From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] disable period wakeups
Date: Mon, 15 Nov 2010 10:58:18 +0100
Message-ID: <4CE1043A.6010607@ladisch.de>
References: <AANLkTimLAuzn+rSEGTv2oV_yPErbBHdRdij-61Ya2JcE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7C3D61037F8
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 10:56:33 +0100 (CET)
In-Reply-To: <AANLkTimLAuzn+rSEGTv2oV_yPErbBHdRdij-61Ya2JcE@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

pl bossart wrote:
> Here's the second set of patches based on feedback from Takashi,
> Jaroslav and Clemens. Hope this is fine now.

Committed, with fixed whitespace (your mailer or editor replaced tabs
with spaces in all new lines), added back
snd_pcm_hw_params_can_disable_period_wakeup(), and small changes.


Regards,
Clemens
