From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Sun, 11 Mar 2012 21:40:37 +0100
Message-ID: <4F5D0DC5.7090908@ladisch.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de>
	<4F5CC7AB.3030300@henning-thielemann.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A24F02456B
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 21:41:21 +0100 (CET)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 056D520E17
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 16:41:20 -0400 (EDT)
In-Reply-To: <4F5CC7AB.3030300@henning-thielemann.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Henning Thielemann <schlepptop@henning-thielemann.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henning Thielemann wrote:
> Clemens Ladisch schrieb:
>> Henning Thielemann wrote:
>>> Unfortunately the ALSA doc does not say, what happens if I send an event
>>> to a queue that is not running.
>>
>> Exactly the same as with a running queue: the event stays in the client's
>> output buffer if its scheduled time has not yet been reached.
>
> I have attached a C program that demonstrates the effect: I start the
> "player" queue with one second delay and immediately send a message with
> a timestamp 0 that is meant to be the local time of the "player" queue.
> I expected that this event is delivered when the player queue starts,
> that is, one second after program start. But actually it is played
> immediately.

Yes; whether an event is delivered depends only on its scheduled time,
not whether the queue is running.

> If I choose a time larger than 0, say 1ns or 1s, then the
> event is not delivered at all.

Starting a queue also clears it.  (This is done explicitly in the code,
so I guess this is a feature.)


I'd suggest to use one queue for both kinds of events, and to add the
delay to the scheduled time.  To remove certain events, use
snd_seq_remove_events().


Regards,
Clemens
