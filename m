From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Sat, 10 Mar 2012 21:51:27 +0100
Message-ID: <4F5BBECF.8020506@ladisch.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 1441C24576
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 21:52:12 +0100 (CET)
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id ABD4E203BC
	for <alsa-devel@alsa-project.org>; Sat, 10 Mar 2012 15:52:09 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
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
> Unfortunately the ALSA doc does not say, what happens if I send an event
> to a queue that is not running.

Exactly the same as with a running queue: the event stays in the client's
output buffer if its scheduled time has not yet been reached.

> I expected that the event is being delivered once the queue is started.
> But it seems that instead the event is dropped.

Perhaps it was delivered too early?


Regards,
Clemens
