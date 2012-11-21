From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: MIDI output to Tascam US-122 via usb-usx2y
	(regression?)
Date: Wed, 21 Nov 2012 16:44:37 +0100
Message-ID: <50ACF6E5.4050506@ladisch.de>
References: <20121121151129.0ba32f18@arial.fairholm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 2F55C265D74
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 16:44:40 +0100 (CET)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 51AAE207AC
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:44:39 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id DE32B4827B6
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2012 10:44:38 -0500 (EST)
In-Reply-To: <20121121151129.0ba32f18@arial.fairholm>
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

Nick Bailey wrote:
> I've been stumped for a while as to why my Tascam US-122 box stopped
> working as a writeable midi port.

The fix:
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git;a=commitdiff;h=e99ddfde6ae0
should show up in the stable kernels soon.


Regards,
Clemens
