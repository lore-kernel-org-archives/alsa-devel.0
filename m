From: Schroettner Robert <rs@ednet.at>
Subject: Re: problem with 8233 -- please help!
Date: Fri, 3 May 2002 22:24:23 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.04.10205032218030.31397-100000@eurolx01.ednet.at>
References: <Pine.LNX.4.04.10205030102170.17955-100000@eurolx01.ednet.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mr2.ednet.cc (IDENT:qmailr@bsrv.ednet.at [213.147.167.71])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id WAA05554
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 22:24:27 +0200
In-Reply-To: <Pine.LNX.4.04.10205030102170.17955-100000@eurolx01.ednet.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hallo !

I have compiled alsa-driver with 'debug=full' and get some nice
messages via syslog:

May  3 22:11:05 athlon kernel: ALSA ../alsa-kernel/core/pcm_lib.c:177:
  BUG: stream = 0, pos = 0xf80113a, buffer size = 0x5622, period size = 0x113a

And aplay say now:

$ aplay test.wav
xrun!!! (at least 0.016ms long)
xrun!!! (at least 0.032ms long)
...

????
hmmm... im now trying kernel-2.4.19-pre7-ac4 and kernel-2.5.10...

On Fri, 3 May 2002, Schroettner Robert wrote:

> I have some troubles, getting my on-board soundcard working. First, my 
> Computer (MSI KT3 Ultra-ARU, with 8233 and ALC650 Sound) locked up, on
> trying to access mixer or pcm-device. Now i have updated my kernel to
> 2.4.19-pre7 (with best thanks to Vojtech Pavlik - Kernel Developer:
> known VIA bug). So i can start up alsamixer, change volume-levels and
> unmute, and hear sound from cd or line-in. But i don't hear anything when
> i try to access the pcm-device.
> 
> $ aplay test.wav
> Playing WAVE 'test.wav': Signed 16 bit Little Endian, Rate 44100 Hz Stereo
> 
> ALSA lib pcm_hw.c:411:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
> Input/output error
> 
> Maybe, there is a very muted click - then nothing for some time (5-10
> seconds) and then i get this error message???
> 
> I tried to run 'snddevices' again - but got the same error.
> 
> What else can i do?
> 
> ----------------------------------------------------------------------------
> 
> # cat /etc/modules.conf | grep snd
> alias char-major-116 snd
> options snd snd_major=116 snd_cards_limit=1
> alias snd-card-0 snd-via8233
> options snd-via8233 snd_index=0 snd_id="Via8233" snd_enable="1" snd_ac97_clock="48000"
> alias sound-slot-0 snd-card-0
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> 
> # rpm -qa | grep alsa
> alsa-driver-0.9.0rc1-1
> alsa-lib-0.9.0rc1-1
> alsa-utils-0.9.0rc1-1
> 
> # cat /proc/version
> Linux version 2.4.19-pre7 (root@athlon.rs.ednet.at) (gcc version 2.96 
> 20000731 (Red Hat Linux 7.1 2.96-98)) #6 Don Mai 2 21:29:00 CEST 2002

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
