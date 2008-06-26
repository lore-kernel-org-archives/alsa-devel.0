From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ALSA with Ubuntu 8.04
Date: Wed, 25 Jun 2008 17:01:27 -0700
Message-ID: <1214438487.4303.216.camel@razman>
References: <4862D901.4070700@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8BBE224512
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 02:01:30 +0200 (CEST)
In-Reply-To: <4862D901.4070700@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eliot Blennerhassett <linux@audioscience.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Actually, the best practice is to install your new drivers
in /lib/modules/`uname -r`/updates/sound.  depmod will automatically
detect these as newer than the other modules.  This is how I test new
alsa builds on my test platforms.

The sound modules in linux-ubuntu-modules are modified from the stock
version of alsa that comes with the kernel in Ubuntu.  The patches are
NOT for release into upstream alsa, as they have already been submitted
and are in 1.0.16 and later (I know, I wrote them).

Tobin Davis


On Thu, 2008-06-26 at 11:47 +1200, Eliot Blennerhassett wrote:

> This just an FYI
> 
> In Ubuntu 8.04, ubuntu has packaged alsa-drivers including some out of 
> tree drivers in a separate package: linux-ubuntu-modules-$kernelver
> 
> This gets installed in /lib/modules/$kernelver/ubuntu/sound
> 
> The only things installed in /lib/modules/$kernelver/sound are 
> soundcore.ko and ac97_bus.ko
> 
> However, when you do a default "make install" from alsa-driver source, 
> the modules get installed in /lib/modules/$kernelver/kernel/sound
> 
> So, now there are 2 copies of the drivers in different places.
> 
> I have taken to removing (moving away to say /root) 
> /lib/modules/$kernelver/ubuntu/sound to avoid any confusion and some odd 
> module versioning problems that I was having.
> 
> regards
> 
> Eliot.
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis 


Leela: "There it is, the near-death star." 
