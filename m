From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to apply rate conversion in asound.conf
Date: Tue, 12 Nov 2013 11:00:41 +0100
Message-ID: <5281FC49.7080107@ladisch.de>
References: <DUB122-W45C29A2FD0EE3B2FC1A459AAF00@phx.gbl>,
 <527A6EA1.4080909@ladisch.de>,
 <DUB122-W390A38324ACF50DA28405BAAF20@phx.gbl>
 <DUB122-W40354113C10D5F94B582F2AAF20@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E6C4C2610AA
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 11:00:43 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 1628427422
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 05:00:43 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id B674A6800FC
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2013 05:00:42 -0500 (EST)
In-Reply-To: <DUB122-W40354113C10D5F94B582F2AAF20@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dolevo Jay wrote:
> how can I call a plugin inside of another plugin?

The slave PCM name is the name of some pcm.xxx device.

> What I need to do now is to have a aosund.conf which has dmix into multi plugins together.

pcm.!default {
	type plug
	slave.pcm multi
}

pcm.multi {
	type multi
	slaves {
		a { pcm "hw:0,1" channels 2 }
		b { pcm "dmixer" channels 2 }
	}
	bindings [
		{ slave a channel 0 }
		{ slave a channel 1 }
		{ slave b channel 0 }
		{ slave b channel 1 }
	]
}

pcm.dmixer {
	type dmix
	...
}

But you need another dmix device for hw:0,1.


Regards,
Clemens
