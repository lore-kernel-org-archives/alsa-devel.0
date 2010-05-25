From: gnutoo <GNUtoo@no-log.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 25 May 2010 18:46:47 +0200
Message-ID: <1274806007.4728.3.camel@gnutoo-desktop>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out12.alice.it (smtp-out12.alice.it [85.37.17.107])
	by alsa0.perex.cz (Postfix) with ESMTP id 664F324659
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 18:46:48 +0200 (CEST)
In-Reply-To: <20100525022646.GA18030@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stuart Longland <redhatter@gentoo.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-05-25 at 12:26 +1000, Stuart Longland wrote:
> If there's any interest, I can format that as a patch and submit it...
I'm very interested...
I've an I.MX31 and a tlv320aic3x

I've tried to import your driver in our 2.6.30 tree
( http://gitorious.org/bug/bug-1x-linux-2-6-30/commits/bug1x-2.6.30 )
and I have now the following issue:

# modprobe bugsound
No device for DAI tlv320aic3x
bug1x_soc_init: hello...
bug1x_soc_init: bug1x_snd_device = c79240c0
bug1x_soc_init: calling platform_set_drvdata( c79240c0, bf07b66c)
bug1x_soc_init: calling platform_device_add(c79240c0)
bug1x_soc_init: platform_device_add(c79240c0) = 0
bug1x_soc_init = 0 (success)

I'll re-read the mails and try harder...
Thanks a lot!!!!

Denis.
