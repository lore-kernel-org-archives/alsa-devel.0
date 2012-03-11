From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Sun, 11 Mar 2012 22:08:47 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203112200370.12766@anubis.informatik.uni-halle.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de> <4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id E264B24556
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 22:08:57 +0100 (CET)
In-reply-to: <4F5D0DC5.7090908@ladisch.de>
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


On Sun, 11 Mar 2012, Clemens Ladisch wrote:

> Yes; whether an event is delivered depends only on its scheduled time,
> not whether the queue is running.

That is, if the queue time is zero and the event time is zero, then the 
event is sent, independent of whether the queue is running or not. Right?

This is good to know and good to be documented. Is this documented 
somewhere and if not how could I document it myself? I remember there is 
an ALSA wiki ...


>> If I choose a time larger than 0, say 1ns or 1s, then the
>> event is not delivered at all.
>
> Starting a queue also clears it.  (This is done explicitly in the code,
> so I guess this is a feature.)

Should be certainly documented somehow. So maybe, 'CONTINUE' is the 
solution.

> I'd suggest to use one queue for both kinds of events, and to add the
> delay to the scheduled time.  To remove certain events, use
> snd_seq_remove_events().

I'll think about that.


Since we are at documentation. seq.h states:

#define SND_SEQ_PORT_CAP_SYNC_READ	(1<<2)	/**< allow read subscriptions */
#define SND_SEQ_PORT_CAP_SYNC_WRITE	(1<<3)	/**< allow write subscriptions */

...

#define SND_SEQ_PORT_CAP_SUBS_READ	(1<<5)	/**< allow read subscription */
#define SND_SEQ_PORT_CAP_SUBS_WRITE	(1<<6)	/**< allow write subscription */


So are the comments for SYNC_READ and SYNC_WRITE correct?
