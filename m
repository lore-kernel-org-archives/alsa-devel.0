From: Pavel Hofman <pavhofman@gmail.com>
Subject: bcm2835.conf for RPi v. 4 incl. HDMI
Date: Sat, 10 Aug 2019 19:05:46 +0200
Message-ID: <CA+SWvNw__saBd3udOLgY8ei7ndjmNYy4SFTJnoP202CoknGDgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94694F801A4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 19:05:58 +0200 (CEST)
Received: by mail-qt1-x829.google.com with SMTP id y26so98972444qto.4
 for <alsa-devel@alsa-project.org>; Sat, 10 Aug 2019 10:05:58 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, may I ask for help with cards/bcm2835.conf for the new RPi? No
such config exists yet:

pi@raspberrypi:~ $ strace -f aplay -L 2>&1 | grep -i bcm2835
access("/usr/share/alsa/cards/bcm2835_alsa.conf", R_OK) = -1 ENOENT
(No such file or directory)

I understand the _alsa suffix is handled in aliases (e.g.
https://www.raspberrypi.org/forums/viewtopic.php?t=221734#p1361104 )

The reason I am looking for this file are Pulseaudio profiles. PA
requires front:X, surroundX, hdmi:X, etc. PCM devices, yet non of
these are created due to the missing card config:

pi@raspberrypi:~ $ aplay -L
default
    Playback/recording through the PulseAudio sound server
null
    Discard all samples (playback) or generate zero samples (capture)
jack
    JACK Audio Connection Kit
pulse
    PulseAudio Sound Server
sysdefault:CARD=ALSA
    bcm2835 ALSA, bcm2835 ALSA
    Default Audio Device
dmix:CARD=ALSA,DEV=0
    bcm2835 ALSA, bcm2835 ALSA
    Direct sample mixing device
dmix:CARD=ALSA,DEV=1
    bcm2835 ALSA, bcm2835 IEC958/HDMI
    Direct sample mixing device
dsnoop:CARD=ALSA,DEV=0
    bcm2835 ALSA, bcm2835 ALSA
    Direct sample snooping device
dsnoop:CARD=ALSA,DEV=1
    bcm2835 ALSA, bcm2835 IEC958/HDMI
    Direct sample snooping device
hw:CARD=ALSA,DEV=0
    bcm2835 ALSA, bcm2835 ALSA
    Direct hardware device without any conversions
hw:CARD=ALSA,DEV=1
    bcm2835 ALSA, bcm2835 IEC958/HDMI
    Direct hardware device without any conversions
plughw:CARD=ALSA,DEV=0
    bcm2835 ALSA, bcm2835 ALSA
    Hardware device with all software conversions
plughw:CARD=ALSA,DEV=1
    bcm2835 ALSA, bcm2835 IEC958/HDMI
    Hardware device with all software conversions
usbstream:CARD=ALSA
    bcm2835 ALSA
    USB Stream Output


As a result, only the Analog Mono PA profile (based on the only
existing hw:0) is available in PA:

D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Mono (analog-mono)
D: [pulseaudio] alsa-util.c: Trying hw:0 with SND_PCM_NO_AUTO_FORMAT ...
D: [pulseaudio] alsa-util.c: Managed to open hw:0
...
D: [pulseaudio] alsa-mixer.c: Checking for playback on Analog Stereo
(analog-stereo)
D: [pulseaudio] alsa-util.c: Trying front:0 with SND_PCM_NO_AUTO_FORMAT ...
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 0
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM front:0
---
D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital Stereo
(HDMI) (hdmi-stereo)
D: [pulseaudio] alsa-util.c: Trying hdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 0
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:0
...
D: [pulseaudio] alsa-mixer.c: Checking for playback on Digital
Surround 7.1 (HDMI) (hdmi-surround71)
D: [pulseaudio] alsa-util.c: Trying hdmi:0 with SND_PCM_NO_AUTO_FORMAT ...
I: [pulseaudio] (alsa-lib)conf.c: Unknown parameters 0
I: [pulseaudio] (alsa-lib)pcm.c: Unknown PCM hdmi:0


RPi v.4 has 2 HDMI outputs:

pi@raspberrypi:~ $ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ALSA [bcm2835 ALSA], device 0: bcm2835 ALSA [bcm2835 ALSA]
  Subdevices: 6/7
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
card 0: ALSA [bcm2835 ALSA], device 1: bcm2835 IEC958/HDMI [bcm2835 IEC958/HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: ALSA [bcm2835 ALSA], device 2: bcm2835 IEC958/HDMI1 [bcm2835
IEC958/HDMI1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Each is 2 - 8 channel:

pi@raspberrypi:~ $ aplay -v --dump-hw-params -D hw:0,1 /dev/zero
Playing raw data '/dev/zero' : Unsigned 8 bit, Rate 8000 Hz, Mono
HW Params of device "hw:0,1":
--------------------
ACCESS:  MMAP_INTERLEAVED RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: [32 128]
CHANNELS: [2 8]
RATE: [44100 192000]
PERIOD_TIME: [10000 743039)
PERIOD_SIZE: [441 32768]
PERIOD_BYTES: [1776 524288]
PERIODS: [1 75)
BUFFER_TIME: (2296 743039)
BUFFER_SIZE: [441 32768]
BUFFER_BYTES: [1764 131072]
TICK_TIME: ALL

I looked at hdmi section of cards/Intel-HDA.conf but that one is very
complicated. May I ask for help how the config should look like to
work both for multichannel PCM and digital formats (i.e. support for
the AES vars)? I very much appreciate any help.

Best regards,

Pavel.
