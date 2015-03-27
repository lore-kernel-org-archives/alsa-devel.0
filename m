From: noman pouigt <variksla@gmail.com>
Subject: recording problem in beagleboard-mcbsp
Date: Fri, 27 Mar 2015 13:24:19 -0700
Message-ID: <CAES_P+8NEcMfDSDVT5d0UHU4mo8d2-3rJg31zf5GRT0HaLVXYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f47.google.com (mail-oi0-f47.google.com
 [209.85.218.47])
 by alsa0.perex.cz (Postfix) with ESMTP id C0A35260716
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 21:24:20 +0100 (CET)
Received: by oigz129 with SMTP id z129so40867549oig.1
 for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2015 13:24:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Problem: not able to record with any of the devices
in beagleboard-xm.

Analysis: userspace is stuck in snd_pcm_readi function
and kernel space i don't see snd_pcm_update_hw_ptr
function being called.

Checked the I2S clocks and they are perfect and recording
data line is moving based on the data. I am able to do playback
though.

I am using below command to do recording. Do i need to add
additional switches?


Linux kernel: 3.19

root@arm:~# arecord -t wav -c 2 -r 44100 -f S32_LE -v test.wav
Recording WAVE 'test.wav' : Signed 32 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Linear conversion PCM (S16_LE)
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 32
  buffer_size  : 27560
  period_size  : 5512
  period_time  : 124988
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5512
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 27560
  silence_threshold: 0
  silence_size : 0
  boundary     : 1806172160
Slave: Hardware PCM card 0 'omap3beagle' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 27560
  period_size  : 5512
  period_time  : 124988
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5512
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 27560
  silence_threshold: 0
  silence_size : 0
  boundary     : 1806172160
  appl_ptr     : 0
  hw_ptr       : 0

[   74.696319] omap-mcbsp 48074000.mcbsp: **** McBSP255 regs ****
[   74.696380] omap-mcbsp 48074000.mcbsp: DRR2:  0xedd0abce
[   74.696411] omap-mcbsp 48074000.mcbsp: DRR1:  0x0000
[   74.696441] omap-mcbsp 48074000.mcbsp: DXR2:  0x0000
[   74.696472] omap-mcbsp 48074000.mcbsp: DXR1:  0x0000
[   74.696502] omap-mcbsp 48074000.mcbsp: SPCR2: 0x0230
[   74.696533] omap-mcbsp 48074000.mcbsp: SPCR1: 0x0031
[   74.696563] omap-mcbsp 48074000.mcbsp: RCR2:  0x8041
[   74.696594] omap-mcbsp 48074000.mcbsp: RCR1:  0x0040
[   74.696594] omap-mcbsp 48074000.mcbsp: XCR2:  0x8041
[   74.696624] omap-mcbsp 48074000.mcbsp: XCR1:  0x0040
[   74.696655] omap-mcbsp 48074000.mcbsp: SRGR2: 0x001f
[   74.696685] omap-mcbsp 48074000.mcbsp: SRGR1: 0x0f00
[   74.696716] omap-mcbsp 48074000.mcbsp: PCR0:  0x000f


setup:
beagleoboard-xm
ubuntu distribution
arecord used
jaroslav recording application also tried
