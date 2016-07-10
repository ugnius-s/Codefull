class CodePost < ActiveRecord::Base

  validates_uniqueness_of [:title, :code]
  validates_presence_of [:title, :code, :category, :code_language]
  scope :available, -> { where(deleted_at: nil) } # Not deleted CodePost scope

  # Upvoting
  def do_upvote(id = nil)
    if !id.nil? # Not nil
      unless self.upvotes.include?(id)
        self.downvotes.delete(id)
        self.upvotes << id
        self.save
      end
    end
  end

  # Downvoting
  def do_downvote(id = nil)
    if !id.nil? # Not nil
      unless self.downvotes.include?(id)
        self.upvotes.delete(id)
        self.downvotes << id
        self.save
      end
    end
  end

end
