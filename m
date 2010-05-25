From: Stuart Longland <redhatter@gentoo.org>
Subject: Re: ASoC: Hooking a TI CODEC to a i.MX27 MCU
Date: Tue, 25 May 2010 13:26:37 +1000
Message-ID: <20100525032637.GB18030@www.longlandclan.yi.org>
References: <20100524074946.GC16346@www.longlandclan.yi.org>
	<1274698156.3064.93.camel@odin>
	<20100525004126.GA10968@www.longlandclan.yi.org>
	<20100525022646.GA18030@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helicon.mas.viperplatform.net.au
	(helicon.mas.viperplatform.net.au [202.147.75.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 413C5103895
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 05:26:41 +0200 (CEST)
Received: from eryx.mas.viperplatform.net.au ([172.16.5.11])
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGkms-0005eT-O4
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 13:26:38 +1000
Received: from mail by eryx.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OGkms-0000jy-Hd
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 13:26:38 +1000
Received: from [172.16.100.13] (helo=helicon.mas.viperplatform.net.au)
	by eryx.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGkms-0000jv-G3
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 13:26:38 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by helicon.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OGkms-0005e9-4s
	for alsa-devel@alsa-project.org; Tue, 25 May 2010 13:26:38 +1000
Content-Disposition: inline
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
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 12:26:50PM +1000, Stuart Longland wrote:
> I now get:
> 
> Registered platform 'imx-audio'
> soc-audio soc-audio: CPU DAI (null) not registered (card bf07d568
> dai_link 0 cpu_dai=bf075f78)
> soc-audio soc-audio: Registered card 'JEM3'

Well this one prooved to be an easy one; and the other SoC drivers in
arch/arm/mach-mx2 lead the way.  I just needed to register the platform
device.  I now get:

Registered platform 'imx-audio'
Registered DAI 'imx-ssi.0'
soc-audio soc-audio: CODEC DAI tlv320aic3x not registered (card bf07d568
dai_link 0 codec_dai=bf06b768)
soc-audio soc-audio: Registered card 'JEM3'

Interestingly, I cannot register more than one SSI port... but this is a
minor inconvenience.  I suspect the issue now is that I must somehow
convince the system to add the CODEC driver as a platform device.
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
