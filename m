From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Thu, 13 Nov 2008 17:02:57 +0100
Message-ID: <cabda6420811130802w6f7cfe6dh632821751ade4245@mail.gmail.com>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
	<291262.11855.qm@web54401.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 86C77103809
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 17:02:58 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so992930rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 08:02:57 -0800 (PST)
In-Reply-To: <291262.11855.qm@web54401.mail.yahoo.com>
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
To: dave123_aml@yahoo.com
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 4:44 PM, David Anders <dave123_aml@yahoo.com> wrote:
> Christian,
>

Hi,

> the enqueue patch i submitted seems to have fixed the issue on several s3c2440 based platforms. i also tested with a s3c2410 and wm8750 codec. i'll re-setup my s3c2410 platform and do some tests. in the mean time, would it be possible for you to provide me a debug log with the enqueue set as:
>
> s3c24xx_pcm_enqueue(substream, 0);
>

I've copied it at the end of this mail. I have a smdk2410 if you need
some testing of patches. In a short time I should have a custom system
based on s3c2440 and a uda1341 codec.

> the zero value indicates to use whatever the max dma_limit value is. i agree with Mark, that there is some core DMA issue that needs to be resolved, i'm just not sure what it is as of yet. any feedback on the issue is greatly appreciated.

what issues are you seeing? The dma code is quite complicated but I
haven't experienced problems yet.


# /opt/arm/alsa/bin/aplay /mp3z/prova.wav
s3c24xx-pcm: Entered s3c24xx_pcm_open
Playing WAVE '/mp3z/prova.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
s3c24xx-i2s: Entered s3c24xx_i2s_set_fmt
s3c24xx-i2s: hw_params r: IISMOD: 9
s3c24xx-i2s: hw_params w: IISMOD: 9
s3c24xx-i2s: Entered s3c24xx_i2s_set_sysclk
s3c24xx-i2s: Entered s3c24xx_i2s_set_clkdiv
s3c24xx-i2s: Entered s3c24xx_i2s_set_clkdiv
s3c24xx-i2s: Entered s3c24xx_i2s_set_clkdiv
s3c24xx-i2s: Entered s3c24xx_i2s_hw_params
s3c24xx-i2s: hw_params r: IISMOD: 9
s3c24xx-i2s: hw_params w: IISMOD: 9
s3c24xx-pcm: Entered s3c24xx_pcm_hw_params
s3c24xx-pcm: params bf06743c, client bf06744c, channel 10
dma10: s3c2410_request_dma: client=I2S PCM Stereo out, dev=00000000
mapped channel 10 to 2
dma2: s3c2410_dma_request:755: ls=0, cur=c3223040, 00000000 c3223040
dma2: s3c2410_dma_request:755: DCSRC=332a158a, DISRC=332a1000,
DSTAT=00000000 DMT=04, DCON=a0d00000
dma10: s3c2410_dma_request : requesting irq 35
s3c2410_dma_request: channel initialised, c044fdd4
s3c2410_dma_set_buffdone_fn: chan=c044fdd4, callback rtn=bf05d0d0
s3c24xx-pcm: Entered s3c24xx_pcm_mmap
s3c24xx-pcm: Entered s3c24xx_pcm_prepare
s3c2410_dma_devconfig: source=1, hwcfg=00000003, devaddr=55000010
s3c2410_dma_devconfig: mem source, devaddr=55000010, hwcfg=3
s3c2410_dma_config: chan=10, xfer_unit=2, dcon=80000000
s3c2410_dma_config: Initial dcon is 80000000
s3c2410_dma_config: New dcon is 80000000
s3c2410_dma_config: dcon now a0900000
s3c2410_dma_flush: chan c044fdd4 (2)
dma2: s3c2410_dma_flush:912: ls=0, cur=c3223040, 00000000 c3223040
dma2: s3c2410_dma_flush:912: DCSRC=332a158a, DISRC=332a1000,
DSTAT=00000000 DMT=04, DCON=a0d00000
s3c2410_dma_flush: free buffer c3223040, next 00000000
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
dma2: s3c2410_dma_flush:939: DCSRC=332a158a, DISRC=332a1000,
DSTAT=00000000 DMT=04, DCON=a0d00000
dma2: s3c2410_dma_flush:954: DCSRC=332a158a, DISRC=332a1000,
DSTAT=00000000 DMT=04, DCON=a0d00000
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 0
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
s3c2410_dma_enqueue: buffer c3223040 queued onto empty channel
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c24xx-pcm: Entered s3c24xx_pcm_trigger
s3c2410_start_dma: channel=2
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a0000,0x001000)
load_state is none, checking for noreload (next=c3223000)
dma2: s3c2410_dma_start:366: ls=1, cur=c3223040, c3223000 c3223000
dma2: s3c2410_dma_start:366: DCSRC=332a158a, DISRC=332a0000,
DSTAT=00000000 DMT=04, DCON=a0900800
dma2: 00000002 to DMASKTRIG
dma2: s3c2410_dma_start:394: ls=1, cur=c3223040, c3223000 c3223000
dma2: s3c2410_dma_start:394: DCSRC=332a158a, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c2410_dma_start: buff not yet loaded, no more todo
dma2: s3c2410_dma_started:967: ls=1, cur=c3223040, c3223000 c3223000
dma2: s3c2410_dma_started:967: DCSRC=332a158a, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c2410_dma_started: buff not yet loaded, no more todo
s3c24xx-i2s: Entered s3c24xx_i2s_trigger
s3c24xx-i2s: Entered s3c24xx_snd_is_clkmaster
s3c24xx-i2s: Entered s3c24xx_snd_txctrl
s3c24xx-i2s: r: IISCON: f IISMOD: 9 IISFCON: 0
s3c24xx-i2s: w: IISCON: 27 IISMOD: 89 IISFCON: a000
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a014a 55000010
dma2: s3c2410_dma_irq:608: ls=1, cur=c3223040, c3223000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a1000,0x001000)
load_state is none, checking for noreload (next=c3223020)
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a2000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a228e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a3000,0x000e80)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a271e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2802 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a28e8 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a29ce 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a375a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a1000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a128e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1758 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a183e 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a3000,0x000e80)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a328e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3758 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a383e 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a1000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a128e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1758 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a183e 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a3000,0x000e80)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a328e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3758 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a383e 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a1000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a128e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1758 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a183e 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a3000,0x000e80)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a328e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3758 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a383e 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a1000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a128e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1758 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a3000,0x000e80)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2720 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2806 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a28ec 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a0000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a028e 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a1000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0672 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0758 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a175a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a3000,0x000e80)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2720 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2806 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3674 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a375a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a1000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0674 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a075a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a175a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a3000,0x000e80)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2720 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2806 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a375a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a1000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a075a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a175a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a3000,0x000e80)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2720 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2806 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a375a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a1000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a075a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a2000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a175a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a3000,0x000e80)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2720 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2806 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a0000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3676 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a375a 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a1000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a1000,0x001000)
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0676 55000010
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a1000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a1290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a2000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223020 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223020 (0x332a2000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223000, 00000000 c3223020
dma2: s3c2410_dma_irq:608: DCSRC=332a2000, DISRC=332a2000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a2290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c24xx-pcm: <7>s3c24xx_pcm_enqueue: corrected dma len 3712
s3c2410_dma_enqueue: id=c31f6300, data=332a3000, size=3712
dma2: s3c2410_dma_enqueue: buffer c3223040 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223040 (0x332a3000,0x000e80)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223020, 00000000 c3223040
dma2: s3c2410_dma_irq:608: DCSRC=332a3000, DISRC=332a3000,
DSTAT=00000000 DMT=02, DCON=a0900740
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a3290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_enqueue
s3c24xx-pcm: dma_loaded: 1
s3c2410_dma_enqueue: id=c31f6300, data=332a0000, size=4096
dma2: s3c2410_dma_enqueue: buffer c3223000 queued onto non-empty channel
s3c2410_chan_loadbuffer: loading buff c3223000 (0x332a0000,0x001000)
dma2: s3c2410_dma_irq:608: ls=3, cur=c3223040, 00000000 c3223000
dma2: s3c2410_dma_irq:608: DCSRC=332a3e80, DISRC=332a0000,
DSTAT=00000000 DMT=02, DCON=a0900800
s3c24xx-pcm: Entered s3c24xx_audio_buffdone
s3c24xx-pcm: Entered s3c24xx_pcm_pointer
s3c24xx-pcm: Pointer 332a0290 55000010
s3c24xx-pcm: Entered s3c24xx_pcm_trigger
s3c2410_dma_dostop:
dma2: s3c2410_dma_dostop:857: ls=1, cur=c3223000, 00000000 c3223000
dma2: s3c2410_dma_dostop:857: DCSRC=332a03b0, DISRC=332a0000,
DSTAT=00000628 DMT=02, DCON=a0900800
s3c24xx-i2s: Entered s3c24xx_i2s_trigger
s3c24xx-i2s: Entered s3c24xx_snd_txctrl
s3c24xx-i2s: r: IISCON: 127 IISMOD: 89 IISFCON: a000
s3c24xx-i2s: w: IISCON: 10f IISMOD: 9 IISFCON: 0
dma2: end of transfer, stopping channel (-32223)
s3c2410_dma_dostop:
dma2: s3c2410_dma_dostop:857: ls=0, cur=c3223000, 00000000 c3223000
dma2: s3c2410_dma_dostop:857: DCSRC=332a058a, DISRC=332a0000,
DSTAT=00000000 DMT=04, DCON=a0d00000
s3c24xx-pcm: Entered s3c24xx_pcm_hw_free
s3c24xx-pcm: Entered s3c24xx_pcm_hw_free
s3c24xx-pcm: Entered s3c24xx_pcm_close
#


-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
