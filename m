From: "William Juul" <william@juul.no>
Subject: new driver - some initial problems
Date: Fri, 8 Feb 2008 09:43:37 +0100
Message-ID: <2563ac9e0802080043g13e48d42pcc7311eb81ea9124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 495CC244CF
	for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2008 09:43:39 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so288453wag.8
	for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2008 00:43:37 -0800 (PST)
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

I am new to alsa development, but I am trying to write a alsa capture
driver for a DAC. The driver is based on at73c213 since it will be
running on AVR32 and using the SSC bus.
The driver is running on a NGW100 card and I am using buildroot
provided by Atmel. The alsa version is 1.0.14a and the kernel is
2.6.23.

The DAC is not using any configuration bus so I have switched to using
platform_* functions instead of dev/spi (grabbed from snd-dummy). I
have also been taking some capture pieces from the snd-dummy driver.

I am now stuck with two problems:
1) When using arecord -L, I only get the "null" device
2) When I try to use arecord to do a recording I get "arecord:
set_params:1039: unable to install sw params:". I get the same message
when trying to use the snd-dummy driver, even though this driver also
has PCM device.

Any hints on how to proceed?

I can post the driver source if that is interesting.

Best regards
William Juul

Listings (annotated):

# modprobe -v snd-dummy
Loading module snd-page-alloc
Loading module soundcore
Loading module snd
Loading module snd-timer
Loading module snd-pcm
Loading module snd-dummy
#
#
# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Dummy [Dummy], device 0: Dummy PCM [Dummy PCM]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7
#
# arecord -L
default:CARD=Dummy
    Dummy, Dummy PCM
    Default Audio Device
null
    Discard all samples (playback) or generate zero samples (capture)
#
#
#
# arecord > dummy.wav
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
pcm->setup: 1
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : U8
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 8
  buffer_size  : 355
  period_size  : 355
  period_time  : 44375
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 355
  xfer_align   : 355
  start_threshold  : 1
  stop_threshold   : 355
  silence_threshold: 0
  silence_size : 0
  boundary     : 1488977920
arecord: set_params:1039: unable to install sw params:
start_mode: DATA
xrun_mode: STOP
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 0
xfer_align: 0
silence_threshold: 0
silence_size: 0
boundary: 1488977920
#
#
# arecord  -r  22786 -c 1 -f U8 -s 1 -A 100 -v > dummy.wav
# (This works OK)
#
# reboot
...
#
#
# modprobe -v snd-ads127x
Loading module soundcore
Loading module snd
Loading module snd-page-alloc
Loading module snd-timer
Loading module snd-pcm
Loading module snd-ads127x
snd_ads127x_probe OK
#
#
# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: ads127x_0 [AVR32 NGW100 external DAC], device 0: ads127x [ads127x]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
# arecord -L
null
    Discard all samples (playback) or generate zero samples (capture)
#
#
#
#
# arecord  -r  22786 -c 1 -f S24_LE -s 1 -A 100  > ads127x.wav
ALSA /home/williaj/src/ads127x/src/ads127x.c:141: snd_ads127x_pcm_open
Recording WAVE 'stdin' : Signed 24 bit Little Endian, Rate 22786 Hz, Mono
pcm->setup: 1
  stream       : CAPTURE
  accessALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos =
0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
       : RW_INTERLEAVED
  format       : S24_LEALSA sound/core/pcm_lib.c:155: BUG: stream = 1,
pos = 0x3b5f034, buffer size = 0xfcc, period size = 0x3f3

  subformat    : STD
  channels     : 1
  raALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos = 0x3b5f034,
buffer size = 0xfcc, period size = 0x3f3
te         : 22786
  exact rate   : 22786 (22786/1)
  msbits       : 32
  buffer_size  : 4044
  period_size  : 1011
  period_time  : 44369
  tick_time ALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos =
0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
   : 4000
  tstamp_mode  : NONE
  period_step ALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos =
0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
 : 1
  sleep_min    : 0
ALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos = 0x3b5f034,
buffer size = 0xfcc, period size = 0x3f3

  xfer_align   : 1011
  start_threshold  : 1
ALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos = 0x3b5f034,
buffer size = 0xfcc, period size = 0x3f3
  stop_threshold   : 4044
  silence_threshold: ALSA sound/core/pcm_lib.c:155: BUG: stream = 1,
pos = 0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
0
  silence_size : 0
  boundary     : 21202206ALSA sound/core/pcm_lib.c:155: BUG: stream =
1, pos = 0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
72
overrun!!! (at least 1.074 ms long)
overrun!!! (at least 0.151 ms long)
overrun!!! (at least 0.139 ms long)
overrun!!! (at least 0.141 ms long)
overrALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos = 0x3b5f034,
buffer size = 0xfcc, period size = 0x3f3
un!!! (at least 0.142 ms long)
overrun!!! (at lALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos =
0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
east 0.139 ms long)
overrun!!! (at least 0.137 ALSA sound/core/pcm_lib.c:155: BUG: stream
= 1, pos = 0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
ms long)
overrun!!! (at least 0.139 ms long)
oALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos = 0x3b5f034,
buffer size = 0xfcc, period size = 0x3f3
verrun!!! (at least 0.138 ms long)
overrun!!! (ALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos =
0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
at least 0.149 ms long)
overrun!!! (at least 0.ALSA sound/core/pcm_lib.c:155: BUG: stream = 1,
pos = 0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
145 ms long)
overrun!!! (at least 0.154 ms long)
overrun!!! (at least 0.146 ms long)
overrun!!! (at least 0.146 ms long)
overrun!!! (at least 0.724 ms loALSA sound/core/pcm_lib.c:155: BUG:
stream = 1, pos = 0x3b5f034, buffer size = 0xfcc, period size = 0x3f3
ng)
overrun!!! (at least 0.152 ms long)
ALSA sound/core/pcm_lib.c:155: BUG: stream = 1, pos = 0x3b5f034,
buffer size = 0xfcc, period size = 0x3f3
overrun!!! (at least 0.125 ms long)
