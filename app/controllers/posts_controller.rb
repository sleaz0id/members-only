class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Post added"
      redirect_to posts_path
    else
      flash.now[:danger] = "Something goes wrong!"
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

    def post_params
      params.require(:post).permit(:title, :body) 
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = 'Please log in.'
        redirect_to login_url
      end
    end
end
