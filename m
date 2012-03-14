From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Wed, 14 Mar 2012 21:22:41 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203142118210.26232@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de> <4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
	<alpine.DEB.2.00.1203112200370.12766@anubis.informatik.uni-halle.de>
	<4F5DB1FA.9030802@ladisch.de>
	<alpine.DEB.2.00.1203142046430.26232@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 08C0D103B78
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 21:22:44 +0100 (CET)
In-reply-to: <alpine.DEB.2.00.1203142046430.26232@anubis.informatik.uni-halle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


I get interesting result if I print the queue time using
snd_seq_queue_status_get_real_time.


On Wed, 14 Mar 2012, Henning Thielemann wrote:

> Ok, I had an idea of how to solve my problem. I want to halt the queue and 
> send all messages immediately that are still in the queue. To this end I 
> think I could just increase the queue time.
>
> Thus I did a test whether this will work. I did the following:
>
> output note-on event with timestamp 1s
> output note-off event with timestamp 2s
> control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
> drain
>
> Nothing happens.


Queue time is exactly 3s after drain.


> I continue the queue after increasing the time:
>
> output note-on event with timestamp 1s
> output note-off event with timestamp 2s
> control_queue SND_SEQ_EVENT_SETPOS_TIME 3s
> control_queue SND_SEQ_EVENT_CONTINUE
> drain
>
> Now the note events are scheduled at 1s and 2s as if the SETPOS_TIME control 
> was ignored.


Queue time is some microseconds larger than 0.


That is, SETPOS_TIME seems to successfully alter the time, but then 
CONTINUE seems to reset the time. Is this a bug or a feature?

SETPOS_TIME does not emit events that become older than queue time. Is it 
a bug or a feature?
