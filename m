From: "Neil Jones" <neil.jones@imgtec.com>
Subject: What am i doing wrong?
Date: Wed, 28 Oct 2009 17:33:51 -0000
Message-ID: <0D107966AF6D79418315B7C5549F4B5101150D3A@lemail1.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filter3.imgtec.com (multi.imgtec.com [194.200.65.239])
	by alsa0.perex.cz (Postfix) with ESMTP id D54C824395
	for <alsa-devel@alsa-project.org>; Wed, 28 Oct 2009 18:33:53 +0100 (CET)
Content-class: urn:content-classes:message
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

Im developing ASoC Driver for an SoC (I2S based).

When testing playback with aplay, I get 1 buffers worth of data played
back (10 periods) then playback stops due to a XRUN when my dma list
wraps back to the start because the available data >= stop_threshold ??

Here are my logs, interrupts are occurring at the correct time and my
buffer pointer increments by period size each time.

Any help would be appreciated

Aplay log:

# /usr/bin/aplay -vvv /var/sample96KHz_edit.wav
Playing WAVE '/var/sample96KHz_edit.wav' : Signed 16 bit Little Endian,
Rate 96000 Hz, Stereo
Plug PCM: Route conversion PCM (sformat=S16_LE)
  Transformation table:
    0 <- 0*0.5 + 1*0.5
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 96000
  exact rate   : 96000 (96000/1)
  msbits       : 16
  buffer_size  : 48000
  period_size  : 4096
  period_time  : 42666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 48000
  stop_threshold   : 48000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
Slave: Hardware PCM card 0 'Metamorph-Base' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 96000
  exact rate   : 96000 (96000/1)
  msbits       : 16
  buffer_size  : 48000
  period_size  : 4096
  period_time  : 42666
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 4096
  period_event : 0
  start_threshold  : 48000
  stop_threshold   : 48000
  silence_threshold: 0
  silence_size : 0
  boundary     : 1572864000
Max peak (8192 samples): 0x00002594 ######               29%
Max peak (8192 samples): 0x00000df8 ###                  10%
Max peak (8192 samples): 0x00007fff #################### 99%
Max peak (8192 samples): 0x00006074 ################     75%
Max peak (8192 samples): 0x00003bff ##########           46%
Max peak (8192 samples): 0x00003e7b ##########           48%
Max peak (8192 samples): 0x00001abf #####                20%
Max peak (8192 samples): 0x000009e0 ##                   7%
Max peak (8192 samples): 0x000067df #################    81%
Max peak (8192 samples): 0x00001b45 #####                21%
Max peak (8192 samples): 0x00000b91 ##                   9%
Max peak (5888 samples): 0x000044a5 ###########          53%
underrun!!! (at least 83.448 ms long)
Status:
  state       : XRUN
  trigger_time: 4784.5629989
  tstamp      : 4784.88220967
  delay       : 0
  avail       : 48000
  avail_max   : 48000


Kernel Log:

PCM DMA IRQ: status 100000, timestamp 4483380 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x1000/0x1000/0xbb80, hwptr=0x0, hw_base=0x0, hw_intr=0x0
PCM DMA IRQ: status 120000, timestamp 4483430 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x2000/0x1000/0xbb80, hwptr=0x1000, hw_base=0x0, hw_intr=0x1000
PCM DMA IRQ: status 120000, timestamp 4483480 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x3000/0x1000/0xbb80, hwptr=0x2000, hw_base=0x0, hw_intr=0x2000
PCM DMA IRQ: status 120000, timestamp 4483530 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x4000/0x1000/0xbb80, hwptr=0x3000, hw_base=0x0, hw_intr=0x3000
PCM DMA IRQ: status 120000, timestamp 4483580 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x5000/0x1000/0xbb80, hwptr=0x4000, hw_base=0x0, hw_intr=0x4000
PCM DMA IRQ: status 120000, timestamp 4483630 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x6000/0x1000/0xbb80, hwptr=0x5000, hw_base=0x0, hw_intr=0x5000
PCM DMA IRQ: status 120000, timestamp 4483680 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x7000/0x1000/0xbb80, hwptr=0x6000, hw_base=0x0, hw_intr=0x6000
PCM DMA IRQ: status 120000, timestamp 4483730 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x8000/0x1000/0xbb80, hwptr=0x7000, hw_base=0x0, hw_intr=0x7000
PCM DMA IRQ: status 120000, timestamp 4483790 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x9000/0x1000/0xbb80, hwptr=0x8000, hw_base=0x0, hw_intr=0x8000
PCM DMA IRQ: status 120000, timestamp 4483840 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0xa000/0x1000/0xbb80, hwptr=0x9000, hw_base=0x0, hw_intr=0x9000
PCM DMA IRQ: status 120000, timestamp 4483890 ms, 
ALSA sound/core/pcm_lib.c:250: period_update: pcmC0D0p:0:
pos=0x0/0x1000/0xbb80, hwptr=0xa000, hw_base=0x0, hw_intr=0xa000
ALSA sound/core/pcm_lib.c:160: XRUN: pcmC0D0p:0
-
This message is subject to Imagination Technologies' e-mail terms: http://www.imgtec.com/e-mail.htm

Imagination Technologies Ltd is a limited company registered in England No:  1306335 
Registered Office: Imagination House, Home Park Estate, Kings Langley, Hertfordshire, WD4 8LZ.  

Email to and from the company may be monitored for compliance and other administrative purposes.  
-
