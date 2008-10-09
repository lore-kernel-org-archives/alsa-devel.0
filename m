From: "Ted T. Logian" <tedtheologian@gmail.com>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Thu, 09 Oct 2008 13:25:40 -0500
Message-ID: <1223576740.18213.2.camel@home>
References: <s5hy70xsl46.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D27D245A8
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 20:26:00 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so80765waf.16
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 11:25:42 -0700 (PDT)
In-Reply-To: <s5hy70xsl46.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm using fedora 9 with 2.6.26.5.

Should I just be able to download 

ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.bz2

configure and make install it and that should be it?  I mean, do I need
to do anything with my modprobe.conf?

This is what I had when I had an emu10k1 card, is this driver called
emu20k1?


# ALSA portion
#   alias char-major-116 snd
#   alias snd-card-0 snd-emu10k1
#alias midi snd-synth-emu10k1
#install snd-emu10k1 /sbin/modprobe --ignore-install snd-emu10k1
&& /usr/sbin/alsactl restore >/dev/null 2>&1 || :
#options snd-emu10k1 index=0
#remove snd-emu10k1 { /usr/sbin/alsactl store 0 >/dev/null 2>&1
|| : ; }; /sbin/modprobe -r --ignore-remove
   # OSS/Free portion
#   alias char-major-14 soundcore
#   alias sound-slot-0 snd-card-0
# card #1
#alias sound-service-0-0 snd-mixer-oss
#alias sound-service-0-1 snd-seq-oss
#alias sound-service-0-3 snd-pcm-oss
#alias sound-service-0-8 snd-seq-oss
#alias sound-service-0-12 snd-pcm-oss
#options snd-hda-intel index=0
#remove snd-hda-intel { /usr/sbin/alsactl store 0 >/dev/null 2>&1
|| : ; }; /sbin/modprobe -r --ignore-remove snd-hda-intel
#install snd-usb-audio /sbin/modprobe --ignore-install snd-usb-audio
&& /usr/sbin/alsactl restore >/dev/null 2>&1 || :
#remove snd-usb-audio { /usr/sbin/alsactl store >/dev/null 2>&1
|| : ; }; /sbin/modprobe -r --ignore-remove snd-usb-audio
#options snd-usb-audio index=2
#options cdc-acmsu vendor=0x22b8 product=0x2a64
#alias snd-card-0 snd-hda-intel
#options snd-card-0 index=0



On Thu, 2008-10-09 at 20:02 +0200, Takashi Iwai wrote:

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
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
