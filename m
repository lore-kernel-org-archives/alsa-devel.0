From: Stephen Hassard <steve@hassard.net>
Subject: Re: problem with 8233 -- please help!
Date: Fri, 03 May 2002 18:13:53 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.1.2.2.20020503180918.00b5ea98@www.angiotech.com>
References: <Pine.LNX.4.04.10205030102170.17955-100000@eurolx01.ednet.a t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from pd4mo1so.prod.shaw.ca (h24-71-223-10.cg.shawcable.net [24.71.223.10])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA10683
	for <alsa-devel@alsa-project.org>; Sat, 4 May 2002 03:14:28 +0200
Received: from pd4mr2so.prod.shaw.ca
 (pd4mr2so-qfe3.prod.shaw.ca [10.0.141.213]) by l-daemon
 (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GVK007CJBF0UD@l-daemon> for alsa-devel@alsa-project.org; Fri,
 03 May 2002 19:13:48 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca
 (pn2ml5so-qfe0.prod.shaw.ca [10.0.121.149]) by l-daemon
 (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GVK00MV4BF0XL@l-daemon> for alsa-devel@alsa-project.org; Fri,
 03 May 2002 19:13:48 -0600 (MDT)
Received: from shwxpdual.hassard.net
 (h24-80-11-127.vc.shawcable.net [24.80.11.127])
 by l-daemon (iPlanet Messaging Server 5.1 (built May  7 2001))
 with ESMTP id <0GVK0072SBEZFH@l-daemon> for alsa-devel@alsa-project.org; Fri,
 03 May 2002 19:13:48 -0600 (MDT)
In-Reply-To: <Pine.LNX.4.04.10205030102170.17955-100000@eurolx01.ednet.a t>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Schroettner Robert <rs@ednet.at>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I might be wrong, but hopefully your using the Intel8x0 not the Via8233 
driver. The AC97 on the Via southbridge is disabled on this board and only 
the Realtek ALC650 is hooked up. Hopefully the Realtek is accessed via the 
generic AC97 i8x0 driver. You didn't mention which driver you're using, so 
I'm not sure if that's exactly your problem. Let me know if this helps any. 
If you need some additional help, let me know. I have one of these boards 
(without linux currently installed) but you be willing to blast it to do 
some testing with alsa ..

later,
Steve

At 01:22 AM 03/05/2002 +0200, Schroettner Robert wrote:
>Hallo !
>
>I have some troubles, getting my on-board soundcard working. First, my
>Computer (MSI KT3 Ultra-ARU, with 8233 and ALC650 Sound) locked up, on
>trying to access mixer or pcm-device. Now i have updated my kernel to
>2.4.19-pre7 (with best thanks to Vojtech Pavlik - Kernel Developer:
>known VIA bug). So i can start up alsamixer, change volume-levels and
>unmute, and hear sound from cd or line-in. But i don't hear anything when
>i try to access the pcm-device.
>
>$ aplay test.wav
>Playing WAVE 'test.wav': Signed 16 bit Little Endian, Rate 44100 Hz Stereo
>
>ALSA lib pcm_hw.c:411:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
>Input/output error
>
>Maybe, there is a very muted click - then nothing for some time (5-10
>seconds) and then i get this error message???
>
>I tried to run 'snddevices' again - but got the same error.
>
>What else can i do?
>
>----------------------------------------------------------------------------
>
># cat /etc/modules.conf | grep snd
>alias char-major-116 snd
>options snd snd_major=116 snd_cards_limit=1
>alias snd-card-0 snd-via8233
>options snd-via8233 snd_index=0 snd_id="Via8233" snd_enable="1" 
>snd_ac97_clock="48000"
>alias sound-slot-0 snd-card-0
>alias sound-service-0-0 snd-mixer-oss
>alias sound-service-0-1 snd-seq-oss
>alias sound-service-0-3 snd-pcm-oss
>alias sound-service-0-8 snd-seq-oss
>alias sound-service-0-12 snd-pcm-oss
>
># rpm -qa | grep alsa
>alsa-driver-0.9.0rc1-1
>alsa-lib-0.9.0rc1-1
>alsa-utils-0.9.0rc1-1
>
># cat /proc/version
>Linux version 2.4.19-pre7 (root@athlon.rs.ednet.at) (gcc version 2.96
>20000731 (Red Hat Linux 7.1 2.96-98)) #6 Don Mai 2 21:29:00 CEST 2002
>
>
>
>Liebe Gruesse, Schroettner Robert
>
>|   Schroettner Robert
>|   IT-Services
>|   Eurodata Datenverarbeitungsdienst Ges.m.b.H.
>|   Tel:  +43-1-7747076-51 +43-664-4345798    __   _
>|         +43-664-4345798                    / /  (_)__  __ ____  __
>|   Fax:  +43-1-7747076-12                  / /__/ / _ \/ // /\ \/ /
>|   WWW:  http://www.ednet.at              /____/_/_//_/\_,_/ /_/\_\
>|                                                    TUX for President
>|   EURODATA - WIEN - PRAG - BRUENN - BUDAPEST
>
>
>_______________________________________________________________
>
>Have big pipes? SourceForge.net is looking for download mirrors. We supply
>the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
