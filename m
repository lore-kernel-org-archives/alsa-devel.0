From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 675220 bytes (3827 ms).
Date: Wed, 26 Jan 2011 11:36:18 +0800
Message-ID: <AANLkTi=g7MMYDKg14bcCSuLt+2oRAwqOYX8=DKTtJ61e@mail.gmail.com>
References: <4D393FA6.8050805@san.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7428224369
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 04:36:23 +0100 (CET)
Received: by eyg24 with SMTP id 24so287377eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 19:36:19 -0800 (PST)
In-Reply-To: <4D393FA6.8050805@san.ru>
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

2011/1/21 support <support@san.ru>

>
>
> alsa-util.c: snd_pcm_avail() returned a value that is exceptionally large:
> 675220 bytes (3827 ms).
> alsa-util.c: Most likely this is a bug in the ALSA driver 'snd_emu10k1'.
> Please report this issue to the ALSA developers.
>
>
>
> http://www.alsa-project.org/db/?f=641d9cb90af2e47e527c2912bee4e34bff41b87b
>
> # rpm -qa | grep alsa
> alsa-lib-devel-1.0.23-2.fc14.i686
> alsa-plugins-pulseaudio-1.0.22-1.fc13.i686
> alsa-utils-1.0.23-3.fc14.i686
> alsa-lib-1.0.23-2.fc14.i686
>
> # uname -a
> Linux wp.san.ru 2.6.35.10-74.fc14.i686 #1 SMP Thu Dec 23 16:17:40 UTC 2010
> i686 i686 i386 GNU/Linux
>
>

Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c: Slave: Hardware PCM
card 0 'SB Live! [Unknown]' device
0 subdevice 0
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c: Its setup is:
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   stream       : PLAYBACK
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   access       :
MMAP_INTERLEAVED
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   format       : S16_LE
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   subformat    : STD
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   channels     : 2
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   rate         : 44100
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   exact rate   :
44100 (44100/1)
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   msbits       : 16
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   buffer_size  : 16384
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   period_size  : 16384
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   period_time  : 371519
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   tstamp_mode  : ENABLE
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   period_step  : 1
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   avail_min    : 16384
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   period_event : 0
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   start_threshold  : -1
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   stop_threshold   :
1073741824
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   silence_threshold: 0
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   silence_size : 0
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   boundary     : 1073741824
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   appl_ptr     : 978195372
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   hw_ptr       : 978317001



hwptr 978317001 is ahead of appl_ptr 978195372 indicate xrun occur in PA
server since PA server set stop_threshold to boundary

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___s_w___params.html

PCM is automatically stopped in SND_PCM_STATE_XRUN state when available
frames is >= threshold. If the stop threshold is equal to boundary (also
software parameter - sw_param) then automatic stop will be disabled (thus
device will do the endless loop in the ring buffer).

 (978317001 - 978195372) > 5 * hw_bufsize

only hda driver has 2 second buffers   pa_bytes_per_second(ss)*10 is as same
as 5 * hwbuf_size

since buffer size 16384 at 44100Hz of emu10k1 and other sound cards are only
371ms , 5 x 371ms is only 1.5 seconds


you should ask the two PA developers why they add these condition since
avail > hw_bufsize is already xrun,

http://git.0pointer.de/?p=pulseaudio.git;a=commitdiff;h=07333f8cae480a25af02ad32286ab38d4272698e;hp=dc1ad08a65302c537d607f29be51a0c64cddec7c

     if (k >= hwbuf_size * 3 ||
         k >= pa_bytes_per_second(ss)*10)


http://git.0pointer.de/?p=pulseaudio.git;a=commitdiff;h=ec9f8f10f358ededa1dec0e3f7f57669fce58547;hp=9eb50701b6a6e8e5b74236bc954e94097eb7e680

-    if (k >= hwbuf_size * 3 ||
-        k >= pa_bytes_per_second(ss)*10)
+    if (k >= hwbuf_size * 5 ||
+        k >= pa_bytes_per_second(ss)*10) {


http://git.0pointer.de/?p=pulseaudio.git;a=commitdiff;h=557a90c487a5b681af6c01309fee89bd203b09c6;hp=5cc9d970c83791f5b71b558c438587d5872449f0

     if (k >= hwbuf_size * 3 ||
         k >= pa_bytes_per_second(ss)*10)


http://git.0pointer.de/?p=pulseaudio.git;a=commitdiff;h=f29acfd0e0413a9bd126782763ee2dcf10357546;hp=b0042cec71ffb09d3720fdcc4223de8153fed67a

        if (abs_k >= hwbuf_size * 5 ||
            abs_k >= pa_bytes_per_second(ss)*10) {


if you grep -ir "buffer_bytes_max" , you should notice that only a few sound
drivers have a buffer size of 2 seconds


aoa/soundbus/i2sbus/pcm.c:    hw->buffer_bytes_max = 131072;
arm/aaci.c:    .buffer_bytes_max    = 64 * 1024,
arm/pxa2xx-pcm-lib.c:    .buffer_bytes_max    = 128 * 1024,
atmel/ac97c.c:    .buffer_bytes_max    = 2 * 2 * 64 * 2048,
atmel/abdac.c:    .buffer_bytes_max    = 64 * 4096,
drivers/ml403-ac97cr.c:    .buffer_bytes_max = (128*1024),
drivers/vx/vx_pcm.c:    .buffer_bytes_max =    (128*1024),
drivers/pcsp/pcsp_lib.c:    .buffer_bytes_max = PCSP_BUFFER_SIZE,
isa/ad1816a/ad1816a_lib.c:    .buffer_bytes_max =    (128*1024),
isa/es1688/es1688_lib.c:    .buffer_bytes_max =    65536,
isa/wss/wss_lib.c:    .buffer_bytes_max =    (128*1024),
isa/gus/gus_pcm.c:    .buffer_bytes_max =    (128*1024),
isa/sb/sb8_main.c:    .buffer_bytes_max =    65536,
isa/sb/sb8_main.c:        runtime->hw.buffer_bytes_max = 128 * 1024 * 1024;
isa/sb/emu8000_pcm.c:    .buffer_bytes_max =    (128*1024),
isa/sb/sb16_main.c:    .buffer_bytes_max =    (128*1024),
isa/sb/sb16_main.c:        runtime->hw.buffer_bytes_max = 32 * 1024;
isa/msnd/msnd.c:    .buffer_bytes_max =    0x3000,
isa/es18xx.c:    .buffer_bytes_max =    65536,
mips/sgio2audio.c:    .buffer_bytes_max = 65536,
mips/hal2.c:    .buffer_bytes_max = 65536,
mips/au1x00.c:    .buffer_bytes_max    = 128*1024,
parisc/harmony.c:    .buffer_bytes_max = MAX_BUF_SIZE,
pci/cs5535audio/cs5535audio_pcm.c:    .buffer_bytes_max =    (128*1024),
pci/nm256/nm256.c:    .buffer_bytes_max =    128 * 1024,
pci/bt87x.c:    .buffer_bytes_max = 255 * 4092,
pci/ctxfi/ctpcm.c:    .buffer_bytes_max    = (128*1024),
pci/ca0106/ca0106_main.c:    .buffer_bytes_max =    ((65536 - 64) * 8),
pci/ca0106/ca0106_main.c:    .buffer_bytes_max =    65536 - 128,
pci/rme32.c:    .buffer_bytes_max = RME32_BUFFER_SIZE,
pci/rme32.c:    .buffer_bytes_max =  RME32_MID_BUFFER_SIZE,
pci/aw2/aw2-alsa.c:    .buffer_bytes_max = 32768,
pci/rme96.c:    .buffer_bytes_max =  RME96_BUFFER_SIZE,
pci/azt3328.c:    .buffer_bytes_max =    65536,
pci/cmipci.c:    .buffer_bytes_max =    (128*1024),
pci/als300.c:    .buffer_bytes_max =    64 * 1024,
pci/sonicvibes.c:    .buffer_bytes_max =    (128*1024),
pci/sis7019.c:    .buffer_bytes_max = (0xfff9 * 4),
pci/ymfpci/ymfpci_main.c:    .buffer_bytes_max =    256 * 1024, /* FIXME:
enough? */
pci/hda/hda_intel.c:    .buffer_bytes_max =    AZX_MAX_BUF_SIZE,
pci/via82xx.c:    .buffer_bytes_max =    VIA_MAX_BUFSIZE,
pci/es1938.c:        .buffer_bytes_max =    0x8000,       /* DMA controller
screws on higher values */
pci/cs46xx/cs46xx_lib.c:    .buffer_bytes_max =    (256 * 1024),
pci/cs4281.c:    .buffer_bytes_max =    (512*1024),
pci/lx6464es/lx6464es.c:    .buffer_bytes_max =
64*2*3*MICROBLAZE_IBL_MAX*MAX_STREAM_BUFFER,
pci/korg1212/korg1212.c:        .buffer_bytes_max =   K1212_MAX_BUF_SIZE,
pci/als4000.c:    .buffer_bytes_max =    65536,
pci/ad1889.c:    .buffer_bytes_max = BUFFER_BYTES_MAX,
pci/pcxhr/pcxhr.c:    .buffer_bytes_max = (32*1024),
pci/rme9652/rme9652.c:    .buffer_bytes_max =
RME9652_CHANNEL_BUFFER_BYTES * 26,
pci/rme9652/hdsp.c:    .buffer_bytes_max =    HDSP_CHANNEL_BUFFER_BYTES *
HDSP_MAX_CHANNELS,
pci/ens1370.c:    .buffer_bytes_max =    (128*1024),
pci/trident/trident_main.c:    .buffer_bytes_max =    (128*1024),
pci/oxygen/oxygen_pcm.c:#define BUFFER_BYTES_MAX        ((1 << 16) * 4)
pci/oxygen/oxygen_pcm.c:#define BUFFER_BYTES_MAX_MULTICH    ((1 << 24) * 4)
pci/oxygen/oxygen_pcm.c:#define DEFAULT_BUFFER_BYTES
(BUFFER_BYTES_MAX / 2)
pci/intel8x0.c:    .buffer_bytes_max =    128 * 1024,
pci/intel8x0.c:        runtime->hw.buffer_bytes_max = 64*1024;
pci/es1968.c:    .buffer_bytes_max =    65536,
pci/ad1889.h:#define BUFFER_BYTES_MAX    (256 * 1024)
pci/fm801.c:    .buffer_bytes_max =    (128*1024),
pci/atiixp.c:    .buffer_bytes_max =    256 * 1024,
pci/au88x0/au88x0_pcm.c:    .buffer_bytes_max = 0x10000,
pci/echoaudio/echo3g.c:    .buffer_bytes_max = 262144,
pci/echoaudio/indigoiox.c:    .buffer_bytes_max = 262144,
pci/echoaudio/layla20.c:    .buffer_bytes_max = 262144,
pci/echoaudio/mia.c:    .buffer_bytes_max = 262144,
pci/echoaudio/darla20.c:    .buffer_bytes_max = 262144,
pci/echoaudio/indigodjx.c:    .buffer_bytes_max = 262144,
pci/echoaudio/indigo.c:    .buffer_bytes_max = 262144,
pci/echoaudio/layla24.c:    .buffer_bytes_max = 262144,
pci/echoaudio/mona.c:    .buffer_bytes_max = 262144,
pci/echoaudio/gina24.c:    .buffer_bytes_max = 262144,
pci/echoaudio/indigoio.c:    .buffer_bytes_max = 262144,
pci/echoaudio/darla24.c:    .buffer_bytes_max = 262144,
pci/echoaudio/indigodj.c:    .buffer_bytes_max = 262144,
pci/riptide/riptide.c:    .buffer_bytes_max = (64 * 1024),
pci/emu10k1/emu10k1x.c:    .buffer_bytes_max =    (32*1024),
pci/emu10k1/p16v.c:    .buffer_bytes_max =    ((65536 - 64) * 8),
pci/emu10k1/p16v.c:    .buffer_bytes_max =    (65536 - 64),
pci/emu10k1/emupcm.c:    .buffer_bytes_max =    (64*1024),
pci/emu10k1/emupcm.c:    .buffer_bytes_max =    (128*1024),
pci/ice1712/ice1712.c:    .buffer_bytes_max =    (64*1024),
pci/ice1712/ice1712.c:    .buffer_bytes_max =    (128*1024),
pci/ice1712/ice1712.c:    .buffer_bytes_max =    (256*1024),
pci/ice1712/ice1724.c:    .buffer_bytes_max =    (1UL << 21),    /* 19bits
dword */
pci/ice1712/ice1724.c:    .buffer_bytes_max =    (1UL << 18),    /* 16bits
dword */
pci/ali5451/ali5451.c:    .buffer_bytes_max =    (256*1024),
pci/ali5451/ali5451.c:    .buffer_bytes_max =    (128*1024),
pci/maestro3.c:    .buffer_bytes_max =    (512*1024),
pci/mixart/mixart.c:    .buffer_bytes_max = (32*1024),
pcmcia/pdaudiocf/pdaudiocf_pcm.c:    .buffer_bytes_max =    (512*1024),
ppc/snd_ps3.c:    .buffer_bytes_max = PS3_AUDIO_FIFO_SIZE * 64,
ppc/pmac.c:    .buffer_bytes_max =    131072,
sh/sh_dac_audio.c:    .buffer_bytes_max    = (48*1024),
sh/aica.c:    .buffer_bytes_max = AICA_BUFFER_SIZE,
soc/soc-core.c:    runtime->hw.buffer_bytes_max = hw->buffer_bytes_max;
soc/au1x/dbdma2.c:    .buffer_bytes_max = 4096 * 1024 - 1,
soc/s3c24xx/s3c-dma.c:    .buffer_bytes_max    = 128*1024,
soc/omap/omap-pcm.c:    .buffer_bytes_max    = 128 * 1024,
soc/txx9/txx9aclc.c:    .buffer_bytes_max = 32 * 1024,
soc/sh/siu.h:#define SIU_BUFFER_BYTES_MAX    (SIU_PERIOD_BYTES_MAX *
SIU_PERIODS_MAX)
soc/sh/siu_dai.c:    .buffer_bytes_max    = SIU_BUFFER_BYTES_MAX,
soc/sh/fsi.c:    .buffer_bytes_max    = 64 * 1024,
soc/sh/dma-sh7760.c:    .buffer_bytes_max =    DMABRG_PERIOD_MAX,
soc/davinci/davinci-pcm.c:    .buffer_bytes_max = 128 * 1024,
soc/atmel/atmel-pcm.c:    .buffer_bytes_max    = 32 * 1024,
soc/fsl/mpc5200_dma.c:    .buffer_bytes_max    = 2 * 1024 * 1024,
soc/fsl/fsl_dma.c:    .buffer_bytes_max       = 128 * 1024,   /* A
reasonable limit */
soc/blackfin/bf5xx-i2s-pcm.c:    .buffer_bytes_max    = 0x20000, /* 128
kbytes */
soc/blackfin/bf5xx-ac97-pcm.c:    .buffer_bytes_max    = 0x20000, /* 128
kbytes */
soc/blackfin/bf5xx-tdm-pcm.c:    .buffer_bytes_max = PCM_BUFFER_MAX,
soc/imx/imx-pcm-dma-mx2.c:    .buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
soc/imx/imx-pcm-fiq.c:    .buffer_bytes_max = IMX_SSI_DMABUF_SIZE,
soc/s6000/s6000-pcm.c:    .buffer_bytes_max = 0x7ffffff0,
sparc/amd7930.c:    .buffer_bytes_max    = (64*1024),
sparc/dbri.c:    .buffer_bytes_max    = 64 * 1024,
sparc/cs4231.c:    .buffer_bytes_max    = 32 * 1024,
spi/at73c213.c:    .buffer_bytes_max = 64 * 1024 - 1,
usb/pcm.c:    .buffer_bytes_max =    1024 * 1024,
usb/misc/ua101.c:    substream->runtime->hw.buffer_bytes_max = 45000 * 1024;
usb/caiaq/audio.c:    .buffer_bytes_max = MAX_BUFFER_SIZE,
usb/usx2y/usx2yhwdeppcm.c:    .buffer_bytes_max =    (2*128*1024),
