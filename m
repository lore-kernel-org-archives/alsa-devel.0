From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: ALSA pcm_lib.c:1789: playback write error (DMA or IRQ
 trouble?) ALSA pcm_native.c:1531: playback drain error
Date: Sun, 22 May 2011 09:55:24 +0800
Message-ID: <BANLkTimEbhCw5A4kPNuqvf-KtBO=G2321w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C9AAF103813
	for <alsa-devel@alsa-project.org>;
	Sun, 22 May 2011 03:55:26 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3747086fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 21 May 2011 18:55:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

For those HDA Codec which support rate lower than 44100 Hz with prealloc = 4096


ALSA pcm_lib.c:1789: playback write error (DMA or IRQ trouble?)
ALSA hda_intel.c:1678: azx_pcm_prepare: bufsize=0xd7500, format=0x4311


This error occr when aplay using a period time longer than 10 seconds
( usually occur above 12 seconds)

 aplay -v -Dhw:1 --period-time=12000000 11025.wav
Playing WAVE '11025.wav' : Signed 16 bit Little Endian, Rate 11025 Hz, Stereo
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 11025
  exact rate   : 11025 (11025/1)
  msbits       : 16
  buffer_size  : 264576
  period_size  : 132288
  period_time  : 11998911
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 132288
  period_event : 0
  start_threshold  : 264576
  stop_threshold   : 264576
  silence_threshold: 0
  silence_size : 0
  boundary     : 1083703296
  appl_ptr     : 0
  hw_ptr       : 0




ALSA pcm_native.c:1531: playback drain error (DMA or IRQ trouble?)
ALSA hda_intel.c:1678: azx_pcm_prepare: bufsize=0x400000, format=0x511

This error occur with speaker-test which use maximum buffer size

speaker-test -d -c 2 -t sine --rate=8000 -Dhw:CARD=Intel

speaker-test 1.0.24.2

Playback device is hw:CARD=Intel
Stream parameters are 8000Hz, S16_LE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 8000Hz (requested 8000Hz)
Buffer size range from 64 to 1048576
Period size range from 32 to 524288
Using max buffer size 1048576
Periods = 4
was set period_size = 262144
was set buffer_size = 1048576
Hardware PCM card 1 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 1048576
  period_size  : 262144
  period_time  : 32768000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 262144
  period_event : 0
  start_threshold  : 1048576
  stop_threshold   : 1048576
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
 0 - Front Left
 1 - Front Right
Time per period = 20.075443
