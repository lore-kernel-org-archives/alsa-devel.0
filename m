From: "Paul Kavan" <pkavan@gmail.com>
Subject: Help with SoC alsa.conf
Date: Thu, 21 Jun 2007 10:20:19 -0500
Message-ID: <61c0054e0706210820g17f90888qed3d9548d46ec1f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.190])
	by alsa0.perex.cz (Postfix) with ESMTP id A3C8010383F
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2007 17:20:20 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so525603mue
	for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2007 08:20:20 -0700 (PDT)
Content-Disposition: inline
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

I am trying to determine an appropriate conf file for my AT91SAM9260ek
running linux-2.6.22-rc1 and the following alsa drivers:

<6>Advanced Linux Sound Architecture Driver Version 1.0.14rc4 (Wed May 09
09:51:39 2007 UTC).
<6>ASoC version 0.13.0
<4>AT91SAM9260EK W6811 Driver <1>
<6>w6811: W6811 PCM SoC Audio 0.1
<6>asoc: W6811 <-> at91-ssc0 mapping ok
<6>grh_ek_w6811: W6811 PCM in Slave Mode
<6>ALSA device list:
<6>  #0: GRH_EK_W6811 (W6811)

I have installed alsa-lib-1.0.14a and alsa-utils-1.0.14 on the at91sam9260.
The default conf file produces sound using speaker-test and aplay, but will
not record using arecord. Frank Mandarino has been kind enough to lend me a
barebones conf that worked for him:

pcm.!default {
   type hw
   card 0
}
pcm.hw {
   type hw
   card 0
   device 0
   subdevice 0
}
ctl.!default {
   type hw
   card 0
}
ctl.hw {
   type hw
   card 0
}


but produces the following for me:


/usr/share/alsa $ aplay -l
**** List of PLAYBACK Hardware Devices ****
ALSA lib conf.c:3949:(snd_config_expand) Unknown parameters 0
ALSA lib control.c:909:(snd_ctl_open_noupdate) Invalid CTL hw:0
aplay: device_list:213: control open (0): Invalid argument

ALSA is *very* new to me and I am unsure how to interpret any of this. I am
using a dumb W6811 pcm codec. I am fairly confident the machine/codec driver
is working as expected, so I need to determine what I can do to get alsa to
play nice with it as well.

When I use the default alsa.conf produced from making alsa-libs, I get the
following:

/usr/share/alsa $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: GRHEKW6811 [GRH_EK_W6811], device 0: W6811 W6811-PCM-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

record and playing do not seem to work. When I try:

/usr/share/alsa $ arecord -d5 test.wav
Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Aborted by signal Interrupt...

It does not stop at 5 seconds....I have to interrupt it manually.
Furthermore, it does not appear to record anything as when I:

/usr/share/alsa $ aplay test.wav
Playing WAVE ' test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

The speaker pops once, but no audio.

Finally, when I use speaker-test, I get some weird results. Doing:

/usr/share/alsa $ speaker-test -r8000 -c1 -f1000 -tsine -l1

speaker-test 1.0.14

Playback device is default
Stream parameters are 8000Hz, S16_LE, 1 channels
Sine wave rate is 1000.0000Hz
Rate set to 8000Hz (requested 8000Hz)
Buffer size range from 64 to 32768
Period size range from 32 to 8192
Using max buffer size 32768
Periods = 4
was set period_size = 8192
was set buffer_size = 32768
 0 - Front Left
Time per period = 5.086305

Gives me a wave composed of both the 1k sine and likely a 2k sine. If I go
much below 1k, I get a periodic wave, but it looks more like a heart beat.
My codec expects u-law, so that may be the problem with speaker-test.
However, the fact the aplay and arecord are not working give me pause.

I would be greatly appreciative of any insights, pointers, etc. If there is
more information that would be helpful, please ask.

Thanks.

Paul



-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
