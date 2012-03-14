From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: sending a sequencer event to a delayed queue
Date: Wed, 14 Mar 2012 09:22:09 +0100
Message-ID: <4F605531.6050103@ladisch.de>
References: <alpine.DEB.2.00.1203101859280.16157@anubis.informatik.uni-halle.de>
	<4F5BBECF.8020506@ladisch.de>
	<4F5CC7AB.3030300@henning-thielemann.de>
	<4F5D0DC5.7090908@ladisch.de>
	<alpine.DEB.2.00.1203132322120.5893@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C367E103B2C
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 09:19:04 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1F9FF20125
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 04:19:01 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1203132322120.5893@anubis.informatik.uni-halle.de>
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
> In order to understand how snd_seq_remove_events works, I looked into
> its source code ... I wondered why I can set the queue as condition
> with snd_seq_remove_events_set_queue but there is no flag that enables
> queue matching

SND_SEQ_REMOVE_DEST enables queue/client/port matching.

> and actually the queue is not checked in remove_match, as far as I can
> see.

Well, it's checked in the kernel. :)  I guess this is a bug in alsa-lib.

> I have another question: Is snd_seq_remove_events atomic, that is, if
> some events have the same time stamp, is it guaranteed that they are
> removed all or none at all? Are events still delivered while removing?

Queues are locked one at a time; events in the same queue with the same
timestamping mode should be removed atomically.


Regards,
Clemens
