From: Schroettner Robert <rs@ednet.at>
Subject: Re: problem with 8233 -- please help!
Date: Sat, 4 May 2002 23:56:10 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.04.10205042307410.8618-100000@eurolx01.ednet.at>
References: <5.1.1.2.2.20020503180918.00b5ea98@www.angiotech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mr2.ednet.cc (IDENT:qmailr@bsrv.ednet.at [213.147.167.71])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA28014
	for <alsa-devel@alsa-project.org>; Sat, 4 May 2002 23:56:17 +0200
In-Reply-To: <5.1.1.2.2.20020503180918.00b5ea98@www.angiotech.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Stephen Hassard <steve@hassard.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi !

I'm now back to kernel 2.4.19-pre7 and alsa-0.9.0rc1.

On Fri, 3 May 2002, Stephen Hassard wrote:

> I might be wrong, but hopefully your using the Intel8x0 not the Via8233 
> driver. The AC97 on the Via southbridge is disabled on this board and only 
> the Realtek ALC650 is hooked up. Hopefully the Realtek is accessed via the 
> generic AC97 i8x0 driver. You didn't mention which driver you're using, so 
> I'm not sure if that's exactly your problem. Let me know if this helps any. 
> If you need some additional help, let me know. I have one of these boards 
> (without linux currently installed) but you be willing to blast it to do 
> some testing with alsa ..

Yes - i have used the snd-via8233 module.

But if i try to load the snd-intel8x0, i got only:

# modprobe snd-intel8x0
/lib/modules/2.4.19-pre7/kernel/sound/pci/snd-intel8x0.o: init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.19-pre7/kernel/sound/pci/snd-intel8x0.o: insmod
/lib/modules/2.4.19-pre7/kernel/sound/pci/snd-intel8x0.o
failed/lib/modules/2.4.19-pre7/kernel/sound/pci/snd-intel8x0.o: insmod snd-intel8x0 failed

And syslog tells me:
kernel: Intel ICH soundcard not found or device busy

It seems, that the ALC640 is not compatible to the intel810.

The alsa-driver-0.5.11 from RealTek has some ALC650-Hacks in ac97_codec:

alsa-driver-0.5.11# fgrep ALC650 */*/* 2>/dev/null
lowlevel/generic/ac97_codec.0007:       {       0x414c4720,     "ALC650"   },
lowlevel/generic/ac97_codec.0007:       {       0x414c4721,     "ALC650-D" },
lowlevel/generic/ac97_codec.c:  {       0x414c4720,     "ALC650"   },
lowlevel/generic/ac97_codec.c:  {       0x414c4721,     "ALC650-D" },
lowlevel/generic/ac97_codec.c:  case 0x414c4720:        /* ALC650 */
lowlevel/generic/ac97_codec.c:  case 0x414c4721:        /* ALC650-D */

But ac97_codec.c from 0.5.11 won't work in 0.9.0rc1 - i don't know how to
pach 0.9.1rc1. (i've realy tried it...)

The modules.conf-example of 0.5.11 also recomends the via-driver:

#alias sound-slot-0 via82cxxx_audio     //remark this line, this is
default via686a driver
#====== added those lines =============
alias char-major-116 snd
options snd snd_major=116 snd_cards_limit=1
#====== Intel 8x0 ====
#alias snd-card-0 snd-card-intel8x0
#options snd-card-intel8x0 snd_index=0 snd_id="ICH"
#====== Via8233  ====
alias snd-card-0 snd-card-via8233
options snd-card-via8233 snd_index=0 snd_id="Via8233"
#====== Via686A (B) =
#alias snd-card-0 snd-card-via686a
#options snd-card-via686a snd_index=0 snd_id="Via686"
#=================
#====== SiS =
#alias snd-card-0 snd-card-sis
#options snd-card-sis snd_index=0 snd_id="SiS"
#=================
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
#=================================
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null 2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null 2>&1 || :

> At 01:22 AM 03/05/2002 +0200, Schroettner Robert wrote:
> >Hallo !
> >
> >I have some troubles, getting my on-board soundcard working. First, my
> >Computer (MSI KT3 Ultra-ARU, with 8233 and ALC650 Sound) locked up, on
> >trying to access mixer or pcm-device. Now i have updated my kernel to
> >2.4.19-pre7 (with best thanks to Vojtech Pavlik - Kernel Developer:
> >known VIA bug). So i can start up alsamixer, change volume-levels and
> >unmute, and hear sound from cd or line-in. But i don't hear anything when
> >i try to access the pcm-device.
> >
> >$ aplay test.wav
> >Playing WAVE 'test.wav': Signed 16 bit Little Endian, Rate 44100 Hz Stereo
> >
> >ALSA lib pcm_hw.c:411:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
> >Input/output error
> >
> >Maybe, there is a very muted click - then nothing for some time (5-10
> >seconds) and then i get this error message???
> >
> >I tried to run 'snddevices' again - but got the same error.
> >
> >What else can i do?
> >
> >----------------------------------------------------------------------------
> >
> ># cat /etc/modules.conf | grep snd
> >alias char-major-116 snd
> >options snd snd_major=116 snd_cards_limit=1
> >alias snd-card-0 snd-via8233
> >options snd-via8233 snd_index=0 snd_id="Via8233" snd_enable="1" 
> >snd_ac97_clock="48000"
> >alias sound-slot-0 snd-card-0
> >alias sound-service-0-0 snd-mixer-oss
> >alias sound-service-0-1 snd-seq-oss
> >alias sound-service-0-3 snd-pcm-oss
> >alias sound-service-0-8 snd-seq-oss
> >alias sound-service-0-12 snd-pcm-oss
> >
> ># rpm -qa | grep alsa
> >alsa-driver-0.9.0rc1-1
> >alsa-lib-0.9.0rc1-1
> >alsa-utils-0.9.0rc1-1
> >
> ># cat /proc/version
> >Linux version 2.4.19-pre7 (root@athlon.rs.ednet.at) (gcc version 2.96
> >20000731 (Red Hat Linux 7.1 2.96-98)) #6 Don Mai 2 21:29:00 CEST 2002

Liebe Gruesse, Schroettner Robert

|   Schroettner Robert
|   IT-Services
|   Eurodata Datenverarbeitungsdienst Ges.m.b.H.
|   Tel:  +43-1-7747076-51 +43-664-4345798    __   _
|         +43-664-4345798                    / /  (_)__  __ ____  __ 
|   Fax:  +43-1-7747076-12                  / /__/ / _ \/ // /\ \/ /
|   WWW:  http://www.ednet.at              /____/_/_//_/\_,_/ /_/\_\
|                                                    TUX for President
|   EURODATA - WIEN - PRAG - BRUENN - BUDAPEST


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
