From: Jan Wolf <xarteras@nostalgicnetworxx.org>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 16 Oct 2008 12:03:41 +0000 (UTC)
Message-ID: <loom.20081016T120322-319@post.gmane.org>
References: <s5hy70xsl46.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 4046024557
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Oct 2008 14:05:24 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KqRbC-0000Vr-LZ
	for alsa-devel@alsa-project.org; Thu, 16 Oct 2008 12:05:02 +0000
Received: from p579EE846.dip.t-dialin.net ([87.158.232.70])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 12:05:02 +0000
Received: from xarteras by p579EE846.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2008 12:05:02 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> Hi,
> 
> $SUBJECT is now on my sound-unstable git tree:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstable-2.6.git
> together with other experimental patches.
> 
> If you're using 2.6.27-rc* git tree, pull the master branch of the
> tree above into yours, and run make oldconfig.  That is,
>     % cd /your/git-tree
>     % git pull git://...../sound-unstable-2.6.git master
> 
> If you are not using 2.6.27-rc*, or not familiar with git, you can try
> alsa-driver-unstable snapshot tarball available at
>     ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
> Run configure, make and make install as usual ALSA-driver tarball.
> 
> (I didn't check whether the tarball correctly includes the sbxfi
>  stuff.  It should have been generated automatically.  If not, wait
>  for a while.  If it still doesn't include sbxfi code, please report.
>  I'll fix it tomorrow morning.)
> 
> The driver is built only for 2.6.26 or later.  If you have an older
> kernel, edit alsa-driver*/kconfig-vers and change the version of
> CONFIG_SND_SBXFI to 2.6.24 or whatever you want.  Then run
> ./gitcompile, instead of configure in this case to update the
> configure script.
> 
> **NOTE**
> The driver is totally untested.  It's just compiled without errors,
> but not reviewed after a quick writing.  So, don't expect it ever runs
> at the first try.  A crash is highly possible.
> 
> There are some build conditions found in sound/pci/sbxfi/sbxfi.c,
> starting with XXX_*.  You can change it if you want.  As default, it's
> for non-fullduplex but accept different rates.  Not sure whether this
> works at all.
> 
> Any test- (and better debugging-) reports are appreciated.
> 
> thanks,
> 
> Takashi
> 

I finally managed to play music over xmms with this driver.
I needed to modify something, because most music is 44100Hz and the driver did
not work with this rate.

61,62c61,62
< #undef XXX_48K_ONLY
< #define XXX_CONT_RATE
---
> #define XXX_48K_ONLY
> #undef XXX_CONT_RATE
529a530,532
>       case 44100:
>               ratec = 0x4c;
>               break;

It also needs to run in 48000Hz mode or else it will playback way to slow.
I think this flag in ratec switches to 96KHz mode in the X-Fi, in windows this
mode is only available in Audio creation mode, so it must be handled in a
special way somehow.

Great work with the driver, finally I have sound under linux as creative's
driver only oopsed the kernel for me :)
