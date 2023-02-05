require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe
    assert subscription.confirmed?
    assert_has_stream "room_channel"
  end

  test "broadcast" do
    subscribe
    text = "hello"
    broadcast_text = ApplicationController.render(
      partial: 'messages/message',
      locals: { message: Message.new(content: text) }
    )
    assert_broadcast_on('room_channel', message: broadcast_text) do # ①
      perform :speak, message: text # ②
    end
  end
end
