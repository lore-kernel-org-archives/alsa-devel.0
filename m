From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Mon, 12 Mar 2012 09:21:14 +0100
Message-ID: <4F5DB1FA.9030802@ladisch.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de>
	<4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
	<alpine.DEB.2.00.1203112200370.12766@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 18FDC2435C
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 09:18:10 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 67768211F9
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 04:18:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1203112200370.12766@anubis.informatik.uni-halle.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Henning Thielemann <alsa@henning-thielemann.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Henning Thielemann wrote:
> On Sun, 11 Mar 2012, Clemens Ladisch wrote:
>> Yes; whether an event is delivered depends only on its scheduled time,
>> not whether the queue is running.
>
> That is, if the queue time is zero and the event time is zero, then
> the event is sent, independent of whether the queue is running or not.

Yes.

> Since we are at documentation. seq.h states:
>
> #define SND_SEQ_PORT_CAP_SYNC_READ    (1<<2)    /**< allow read subscriptions */
> #define SND_SEQ_PORT_CAP_SYNC_WRITE    (1<<3)    /**< allow write subscriptions */
> ...
> #define SND_SEQ_PORT_CAP_SUBS_READ    (1<<5)    /**< allow read subscription */
> #define SND_SEQ_PORT_CAP_SUBS_WRITE    (1<<6)    /**< allow write subscription */
>
> So are the comments for SYNC_READ and SYNC_WRITE correct?

No, they should say "obsolete; no effect".


Regards,
Clemens
