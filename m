Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25C9FF8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 17:06:27 +0200 (CEST)
Message-ID: <trinity-99f29eaa-68be-4969-9769-07d51a51e210-1564067186868@3c-app-gmx-bs19>
From: "github repository" <githubrepository@gmx.net>
Date: Thu, 25 Jul 2019 17:06:26 +0200
MIME-Version: 1.0
Subject: [alsa-devel] Kernel 5.2.2 - RSpeaker not working - MacBookAir 3,2
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-ID: <alsa-devel@alsa-project.org>

   Ladies and gentlemen,

   I tested alsa on Kernel 5.2.2 on an MacBook Air 3,2 with alsa-lib
   1.1.9, fftw 3.3.8, ncurses 6.1. Somehow I was not able to get the right
   speaker to work. On Kernel  4.19.60 everything works. Same setup
   different results. Distribution: Arch Linux


   lsmod | grep snd

   snd_hda_codec_hdmi     65536  3
   snd_hda_codec_cirrus    20480  1
   snd_hda_codec_generic    94208  1 snd_hda_codec_cirrus
   ledtrig_audio          16384  1 snd_hda_codec_generic
   snd_hda_intel          49152  0
   snd_hda_codec         155648  4
   snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec_ci
   rrus
   snd_hda_core          102400  5
   snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,sn
   d_hda_codec_cirrus
   snd_hwdep              16384  1 snd_hda_codec
   snd_pcm               135168  4
   snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_hda_core
   snd_timer              40960  1 snd_pcm
   snd                   106496  7
   snd_hda_codec_generic,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_hd
   a_codec,snd_timer,snd_pcm
   soundcore              16384  1 snd


   aplay -L

   null
       Discard all samples (playback) or generate zero samples (capture)
   default:CARD=NVidia
       HDA NVidia, CS4206 Analog
       Default Audio Device
   sysdefault:CARD=NVidia
       HDA NVidia, CS4206 Analog
       Default Audio Device
   front:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       Front speakers
   surround21:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       2.1 Surround output to Front and Subwoofer speakers
   surround40:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       4.0 Surround output to Front and Rear speakers
   surround41:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       4.1 Surround output to Front, Rear and Subwoofer speakers
   surround50:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       5.0 Surround output to Front, Center and Rear speakers
   surround51:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       5.1 Surround output to Front, Center, Rear and Subwoofer speakers
   surround71:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Analog
       7.1 Surround output to Front, Center, Side, Rear and Woofer
   speakers
   iec958:CARD=NVidia,DEV=0
       HDA NVidia, CS4206 Digital
       IEC958 (S/PDIF) Digital Audio Output
   hdmi:CARD=NVidia,DEV=0
       HDA NVidia, HDMI 0
       HDMI Audio Output
   hdmi:CARD=NVidia,DEV=1
       HDA NVidia, HDMI 0
       HDMI Audio Output
   hdmi:CARD=NVidia,DEV=2
       HDA NVidia, HDMI 0
       HDMI Audio Output

   aplay -l

   **** List of PLAYBACK Hardware Devices ****
   card 0: NVidia [HDA NVidia], device 0: CS4206 Analog [CS4206 Analog]
     Subdevices: 1/1
     Subdevice #0: subdevice #0
   card 0: NVidia [HDA NVidia], device 1: CS4206 Digital [CS4206 Digital]
     Subdevices: 1/1
     Subdevice #0: subdevice #0
   card 0: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
     Subdevices: 1/1
     Subdevice #0: subdevice #0
   card 0: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
     Subdevices: 1/1
     Subdevice #0: subdevice #0
   card 0: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
     Subdevices: 1/1
     Subdevice #0: subdevice #0

   ls -l /dev/snd

   total 0
   drwxr-xr-x 2 root root       60 Jul 25 14:25 by-path
   crw-rw---- 1 root audio 116, 12 Jul 25 14:25 controlC0
   crw-rw---- 1 root audio 116,  8 Jul 25 14:25 hwC0D0
   crw-rw---- 1 root audio 116,  9 Jul 25 14:25 hwC0D3
   crw-rw---- 1 root audio 116, 10 Jul 25 14:25 hwC0D4
   crw-rw---- 1 root audio 116, 11 Jul 25 14:25 hwC0D5
   crw-rw---- 1 root audio 116,  3 Jul 25 14:25 pcmC0D0c
   crw-rw---- 1 root audio 116,  2 Jul 25 14:25 pcmC0D0p
   crw-rw---- 1 root audio 116,  4 Jul 25 14:25 pcmC0D1p
   crw-rw---- 1 root audio 116,  5 Jul 25 14:25 pcmC0D3p
   crw-rw---- 1 root audio 116,  6 Jul 25 14:25 pcmC0D7p
   crw-rw---- 1 root audio 116,  7 Jul 25 14:25 pcmC0D8p
   crw-rw---- 1 root audio 116,  1 Jul 25 14:25 seq
   crw-rw---- 1 root audio 116, 33 Jul 25 14:25 timer
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
