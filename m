From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Wed, 14 Mar 2012 21:01:12 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203142046430.26232@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de> <4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
	<alpine.DEB.2.00.1203112200370.12766@anubis.informatik.uni-halle.de>
	<4F5DB1FA.9030802@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id DB395103B50
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 21:01:15 +0100 (CET)
In-reply-to: <4F5DB1FA.9030802@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Mon, 12 Mar 2012, Clemens Ladisch wrote:

> Henning Thielemann wrote:
>> On Sun, 11 Mar 2012, Clemens Ladisch wrote:
>>> Yes; whether an event is delivered depends only on its scheduled time,
>>> not whether the queue is running.
>>
>> That is, if the queue time is zero and the event time is zero, then
>> the event is sent, independent of whether the queue is running or not.
>
> Yes.

Ok, I had an idea of how to solve my problem. I want to halt the queue and 
send all messages immediately that are still in the queue. To this end I 
think I could just increase the queue time.

Thus I did a test whether this will work. I did the following:

output note-on event with timestamp 1s
output note-off event with timestamp 2s
control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
drain

Nothing happens.

I continue the queue after increasing the time:

output note-on event with timestamp 1s
output note-off event with timestamp 2s
control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
control_queue SND_SEQ_EVENT_CONTINUE
drain

Now the note events are scheduled at 1s and 2s as if the SETPOS_TIME 
control was ignored.

Then I continued the queue before increasing the time:

output note-on event with timestamp 1s
output note-off event with timestamp 2s
control_queue SND_SEQ_EVENT_CONTINUE
control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
drain

Now the events arrive instantly. This is the behavior I want to have.

It looks like SETPOS_TIME is ignored if the queue is halted. Is this 
correct?
