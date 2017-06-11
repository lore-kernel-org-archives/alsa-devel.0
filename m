From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] ALSA: pcm: add 'applptr' event of
	tracepoint
Date: Sun, 11 Jun 2017 15:48:05 +0900
Message-ID: <20170611064808.30572-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 580222669F3
 for <alsa-devel@alsa-project.org>; Sun, 11 Jun 2017 08:48:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is for a event at updating application-side position in
kernel space. This also includes my previous patch:

[alsa-devel] [PATCH 2/2] ALSA: pcm: add arrangement for applying appl_ptr
http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/121091.html

In design of ALSA PCM core, status and control data for runtime of ALSA
PCM substream are shared between kernel/user spaces by page frame
mapping with read-only attribute. The application-side position is a part of
the status data and ALSA PCM applications can't update it. 

When applications are written by read/write programming scenario, they can
be unaware of update of application-side position. In this case, ALSA PCM
core certainly performs it.

However, when applications are written by mmap programming scenario, if
maintaining the application side position accurately in kernel space,
applications should voluntarily execute ioctl(2) with some commands when
they handles any PCM frames. If not voluntarily, the events are not probed.

There's a loophole, using architectures to which ALSA PCM core judges
non-cache coherent. In this case, the status and control data is not mapped
into processe's VMA for any applications. Userland library, alsa-lib, is
programmed for this case. It executes ioctl(2) with
SNDRV_PCM_IOCTL_SYNC_PTR command every time to requiring the status and
control data.

ARM is such an architecture. Below is an example with serial sound interface
(ssi) on i.mx6 quad core SoC. I use v4.1 kernel released by fsl-community
with patches from VIA Tech. Inc. for VAB820, and my backport patches for
relevant features for this patchset. I use Ubuntu 17.04 from
ports.ubuntu.com as user land for armhf architecture.

$ aplay -v -M -D hw:imx6vab820sgtl5,0 /dev/urandom -f S16_LE -r 48000 --period-size=128 --buffer-size=256
Playing raw data '/dev/urandom' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
Hardware PCM card 0 'imx6-vab820-sgtl5000' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 16
  buffer_size  : 256
  period_size  : 128
  period_time  : 2666
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 128
  period_event : 0
  start_threshold  : 256
  stop_threshold   : 256
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0
mmap_area[0] = 0x76f98000,0,16 (16)

$ trace-cmd record -e snd_pcm:hwptr -e snd_pcm:applptr
$ trace-cmd report
...
60.208495: applptr: pcmC0D0p/sub0: prev=1792, curr=1792, avail=0, period=128, buf=256
60.208633: applptr: pcmC0D0p/sub0: prev=1792, curr=1792, avail=0, period=128, buf=256
60.210022: hwptr:   pcmC0D0p/sub0: IRQ: pos=128, old=1536, base=1536, period=128, buf=256
60.210202: applptr: pcmC0D0p/sub0: prev=1792, curr=1792, avail=128, period=128, buf=256
60.210344: hwptr:   pcmC0D0p/sub0: POS: pos=128, old=1664, base=1536, period=128, buf=256
60.210348: applptr: pcmC0D0p/sub0: prev=1792, curr=1792, avail=128, period=128, buf=256
60.210486: applptr: pcmC0D0p/sub0: prev=1792, curr=1792, avail=128, period=128, buf=256
60.210626: applptr: pcmC0D0p/sub0: prev=1792, curr=1920, avail=0, period=128, buf=256
60.211002: applptr: pcmC0D0p/sub0: prev=1920, curr=1920, avail=0, period=128, buf=256
60.211142: hwptr:   pcmC0D0p/sub0: POS: pos=128, old=1664, base=1536, period=128, buf=256
60.211146: applptr: pcmC0D0p/sub0: prev=1920, curr=1920, avail=0, period=128, buf=256
60.211287: applptr: pcmC0D0p/sub0: prev=1920, curr=1920, avail=0, period=128, buf=256
60.212690: hwptr:   pcmC0D0p/sub0: IRQ: pos=0, old=1664, base=1536, period=128, buf=256
60.212866: applptr: pcmC0D0p/sub0: prev=1920, curr=1920, avail=128, period=128, buf=256
60.212999: hwptr:   pcmC0D0p/sub0: POS: pos=0, old=1792, base=1792, period=128, buf=256
60.213003: applptr: pcmC0D0p/sub0: prev=1920, curr=1920, avail=128, period=128, buf=256
60.213135: applptr: pcmC0D0p/sub0: prev=1920, curr=1920, avail=128, period=128, buf=256
60.213276: applptr: pcmC0D0p/sub0: prev=1920, curr=2048, avail=0, period=128, buf=256
60.213654: applptr: pcmC0D0p/sub0: prev=2048, curr=2048, avail=0, period=128, buf=256
60.213796: hwptr:   pcmC0D0p/sub0: POS: pos=0, old=1792, base=1792, period=128, buf=256
60.213800: applptr: pcmC0D0p/sub0: prev=2048, curr=2048, avail=0, period=128, buf=256
60.213937: applptr: pcmC0D0p/sub0: prev=2048, curr=2048, avail=0, period=128, buf=256
60.215356: hwptr:   pcmC0D0p/sub0: IRQ: pos=128, old=1792, base=1792, period=128, buf=256
60.215542: applptr: pcmC0D0p/sub0: prev=2048, curr=2048, avail=128, period=128, buf=256
60.215679: hwptr:   pcmC0D0p/sub0: POS: pos=128, old=1920, base=1792, period=128, buf=256
60.215683: applptr: pcmC0D0p/sub0: prev=2048, curr=2048, avail=128, period=128, buf=256
60.215813: applptr: pcmC0D0p/sub0: prev=2048, curr=2048, avail=128, period=128, buf=256
60.215947: applptr: pcmC0D0p/sub0: prev=2048, curr=2176, avail=0, period=128, buf=256
...

We can surely see 'applptr' event is probed even if the application run
for mmap programming scenario ('-M' option for 'hw' plugin). Below is a
result of strace:

02:44:15.886382 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.887203 poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
02:44:15.887471 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.887637 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.887805 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.887969 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.888132 read(3, "..."..., 256) = 256
02:44:15.889040 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.889221 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.889431 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.889606 poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
02:44:15.889833 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.889998 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.890164 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.891048 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.891228 read(3, "..."..., 256) = 256
02:44:15.891497 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.891661 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.891829 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0
02:44:15.891991 poll([{fd=4, events=POLLOUT|POLLERR|POLLNVAL}], 1, -1) = 1 ([{fd=4, revents=POLLOUT}])
02:44:15.893007 ioctl(4, SNDRV_PCM_IOCTL_SYNC_PTR, 0x56a32b30) = 0

We can see 7 calls of ioctl(2) with SNDRV_PCM_IOCTL_SYNC_PTR per loop with
call of poll(2). 128 PCM frames are transferred per loop of one poll(2),
because the PCM substream is configured with S16_LE format and 1 channel
(2 byte * 1 * 128 = 256 bytes). This equals to the size of period of PCM
buffer. Comparing to the probed data, one of the 7 system calls is
actually used to commit the number of copied PCM frames to kernel space.

The tracepoint event is useful to investigate this case.

I note that below modules are related to the above sample.

 * snd-soc-dummy.ko
 * snd-soc-imx-sgtl5000.ko
 * snd-soc-fsl-ssi.ko
 * snd-soc-imx-pcm-dma.ko
 * snd-soc-sgtl5000.ko

Takashi Sakamoto (3):
  ALSA: pcm: unify codes to operate application-side position on PCM
    buffer
  ALSA: pcm: add 'applptr' event of tracepoint
  ALSA: pcm: use %s instead of %c for format of PCM buffer tracepoints

 sound/core/pcm_lib.c    | 31 +++++++++++++++++++++++++++---
 sound/core/pcm_local.h  |  2 ++
 sound/core/pcm_native.c | 28 ++++-----------------------
 sound/core/pcm_trace.h  | 50 +++++++++++++++++++++++++++++++++++++++++++------
 4 files changed, 78 insertions(+), 33 deletions(-)

-- 
2.11.0
