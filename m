From: =?ISO-8859-15?Q?Andreas_Bie=DFmann?= <biessmann@corscience.de>
Subject: Question to sophisticated alsa developer
Date: Wed, 05 Aug 2009 13:05:29 +0200
Message-ID: <4A796779.6030204@corscience.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 704D5243D2
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 13:05:32 +0200 (CEST)
Received: from [192.168.0.14] (azuregos.CS.local [192.168.0.14])
	by corscience.de (Postfix) with ESMTP id F299451C5D
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 13:05:29 +0200 (CEST)
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

Hi all,

I currently test alsa playback on AVR32 board with atmel's abdac driver.
My environment is 2.6.30.4 customized kernel (customization for my own
board), rootfs and toolchain made of customized buildroot from atmel. I
use alsa-lib 1.0.20 with patch [1] applied and alsa-utils with patch [2]
applied. The alsa code does compile and work fine (aside from my problem
described some lines later).

My test case is a sine wave file with 440Hz tone, samplerate is 17089
(cause of samplerate abdac driver offers and to avoid resampling in
alsa-lib) playing with aplay. This works fine, I see a 440Hz sine wave
on my oscilloscope and there is no effect as described later on.

My problem is when I'm enabling dmix layer to run concurrent aplay
processes I always get a click at the end of my last played sine wave
file. My Oscilloscope shows me that there is sometimes a short part of a
single or somtimes multiple sine period(s) moved down (or up) to mid
value (I can supply a screenshot of oscilloscope, if this description is
not clear enough). Mostly this effect is about 500 us long. The sine
wave is missing the information at this position, it is no delay of the
analog value at this position. If I overlay a correct sine wave the
following part after the problematic position matches exactly the
overlayed sine wave.
I investigated that this problem always occur somewhere at the end of
dmix. When I play a long "null" sample and start repeated play of my
short sine wave sample the effect is not there while the null sample is
playing. After ending of null sample the described effect appears
instantly on each end of my repeated test sample.

Here is my asound.conf to enable dmix layer for alsa:

---8<---
pcm.!default {
        type plug
        slave.pcm "dmixer"
}

ctl.mixer0 {
        type hw
        card 0
}

pcm.!plughw {
        type plug
        slave.pcm "dmixer"
}

pcm.dmixer {
        type dmix
        ipc_key 1024
        slave {
                pcm "hw:0"
                format S16_BE
                rate 17089
        }
        bindings {
                0 0
                1 1
        }
        slowptr	false
}

ctl.dmixer {
        type hw
        card 0
}
--->8---

Maybe there is already a bloomer in.

I have tried to change slowptr stuff in pcm.dmixer without any effect to
my problem. I also tried to change buffer sizes in dmixer's slave but
these changes had no effect.

I also tried some changes in kernel driver for ABDAC. I played a bit
with periods_min and period_bytes_min without effect to my problem. The
buffer_size in "Direct Stream Mixing PCM" is fixed to the value in
"hw:0". But if I double the periods_min in Kernel (default: 6
periods_min, 64 periods_max) for "hw:0" the maximum value for
buffer_size in "Direct Stream Mixing PCM" is fixed to 8192. The "Route
conversion" layer has always the buffer_size value of the next layer.
This is 8192 for doubled periods_min in kernel and dmix enabled and
12288 for doubled periods_min and dmix disabled. Any advice to this
"feature"?

Here is the output of aplay -v for dmix enabled:

---8<---
# aplay -v sin_440_17089_1sec.wav
Playing WAVE 'sin_440_17089_1sec.wav' : Signed 16 bit Little Endian,
Rate 17089 Hz, Mono
Plug PCM: Route conversion PCM (sformat=3DS16_BE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 17089
  exact rate   : 17089 (17089/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 59921
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_BE
  subformat    : STD
  channels     : 2
  rate         : 17089
  exact rate   : 17089 (17089/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 1024
  period_time  : 59921
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 8192
  stop_threshold   : 8192
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'Atmel ABDAC' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_BE
  subformat    : STD
  channels     : 2
  rate         : 17089
  exact rate   : 17089 (17089/1)
  msbits       : 16
  buffer_size  : 12288
  period_size  : 1024
  period_time  : 59921
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1610612736
  silence_threshold: 0
  silence_size : 1610612736
  boundary     : 1610612736
  appl_ptr     : 0
  hw_ptr       : 0
--->8---


And here the output of aplay -v without dmix:

---8<---
# aplay -v sin_440_17089_1sec.wav
Playing WAVE 'sin_440_17089_1sec.wav' : Signed 16 bit Little Endian,
Rate 17089 Hz, Mono
Plug PCM: Route conversion PCM (sformat=3DS16_BE)
  Transformation table:
    0 <- 0
    1 <- 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 17089
  exact rate   : 17089 (17089/1)
  msbits       : 16
  buffer_size  : 12288
  period_size  : 1024
  period_time  : 59921
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 12288
  stop_threshold   : 12288
  silence_threshold: 0
  silence_size : 0
  boundary     : 1610612736
Slave: Hardware PCM card 0 'Atmel ABDAC' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_BE
  subformat    : STD
  channels     : 2
  rate         : 17089
  exact rate   : 17089 (17089/1)
  msbits       : 16
  buffer_size  : 12288
  period_size  : 1024
  period_time  : 59921
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 12288
  stop_threshold   : 12288
  silence_threshold: 0
  silence_size : 0
  boundary     : 1610612736
  appl_ptr     : 0
  hw_ptr       : 0
--->8---

Well, currently I have no more ideas where to dig for my problem. I do
need a mixing layer to allow two or three concurrent aplay instances at
the same time but the output in this case is (atm) worse. Has anyone
some advice where to search for a solution to my problem. Or has anybody
some advice to use another feature of alsa to allow concurrent aplay
processes?

regards

Andreas Bie=DFmann

[1]
http://git.buildroot.net/buildroot/tree/package/multimedia/alsa-lib/alsa-li=
b-1.0.18-avr32-bad-inline.patch

[2]
http://git.buildroot.net/buildroot/tree/package/multimedia/alsa-utils/alsa-=
utils-1.0.18-fix-intl-support.patch
