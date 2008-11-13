From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: possible problem in s3c24xx-pcm.c in git-devel
	branch
Date: Thu, 13 Nov 2008 15:17:05 +0000
Message-ID: <20081113151701.GG31592@sirena.org.uk>
References: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B8B2E24590
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 16:17:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cabda6420811130657k4079884cge643c1b33b319b14@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: christian pellegrin <chripell@gmail.com>
Cc: David Anders <dave123_aml@yahoo.com>, alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 03:57:08PM +0100, christian pellegrin wrote:

> during the porting the uda134x driver to the git devel branch of ALSA
> SOC I noticed a possible problem in s3c24xx-pcm.c. s3c24xx_pcm_enqueue
> gained a new parameter that specifies the maximum number of periods
> that can be enqueued. In s3c24xx_pcm_prepare, which is called on
> play/capture start, this is limited to 1. Unfortunately on the 2410
> the result of this change is that the DMA is stopped because the
> autoload of the next DMA descriptor doesn't work. I copied a log at
> the end of this email. Look for DMT==00 after the irq signaling the
> end of the first period and the subsequent fail of DMA loading since
> the channel is stopped.

CCing in Dave Anders who wrote that patch (though the problem it fixes
was reported previously).  I can't help but think that this ought to be
being dealt with within the DMA code, it all feels rather fragile.

> Now I fixed with:

> --- a/sound/soc/s3c24xx/s3c24xx-pcm.c
> +++ b/sound/soc/s3c24xx/s3c24xx-pcm.c
> @@ -253,7 +253,7 @@ static int s3c24xx_pcm_prepare(struct
> snd_pcm_substream *substream)
>         prtd->dma_pos = prtd->dma_start;
> 
>         /* enqueue dma buffers */
> -       s3c24xx_pcm_enqueue(substream, 1);
> +       s3c24xx_pcm_enqueue(substream, 2);
> 
>         return ret;
>  }
> 
> but this really could be "playing with DMA" since I'm not sure why
> there is a 1 (since min_period is 2 I would guess 2 is the right
> value). Anyway with this change play and capture work well.

See the commit log - the underlying DMA code restricts the number of
buffers that can be queued up prior to the start of DMA.

> 
> # /opt/arm/alsa/bin/aplay /mp3z/prova.wav
> s3c24xx-pcm: Entered s3c24xx_pcm_open
> s3c24xx_uda134x_startup 0
>  31250, 132031, 66015, 44010, 33007, 26406, 22005, 18861, 16503,
> 14670, 13203, 12002, 11002, 10156, 9430, 8802, 8251, 7766, 7335, 6949,
> 6601, 6287, 6001, 5740, 5501, 5281, 5078, 4890, 4715, 4552, 4401,
> 4259, 4125, 46875, 198046, 99023, 66015, 49511, 39609, 33007, 28292,
> 24755, 22005, 19804, 18004, 16503, 15234, 14146, 13203, 12377, 11649,
> 11002, 10423, 9902, 9430, 9002, 8610, 8251, 7921, 7617, 7335, 7073,
> 6829, 6601, 6388, 6188,
> Playing WAVE '/mp3z/prova.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
> s3c24xx_uda134x_hw_params desired rate 8000, 58
> s3c24xx_uda134x_hw_params will use: 256FS PCLK 24 sysclk 2048000 err 79
> uda134x_set_dai_fmt fmt: 00003000
> s3c24xx-i2s: Entered s3c24xx_i2s_set_fmt
> s3c24xx-i2s: hw_params r: IISMOD: 9
> s3c24xx-i2s: hw_params w: IISMOD: 9
> s3c24xx-i2s: Entered s3c24xx_i2s_set_sysclk
> s3c24xx-i2s: Entered s3c24xx_i2s_set_clkdiv
> s3c24xx-i2s: Entered s3c24xx_i2s_set_clkdiv
> s3c24xx-i2s: Entered s3c24xx_i2s_set_clkdiv
> uda134x_set_dai_sysclk clk_id: 0, freq: 2048000, dir: 1
> uda134x_hw_params sysclk: 2048000, rate:8000
> uda134x_hw_params dai_fmt: 12288, params_format:2
> uda134x_write reg: 08, value:20
> s3c24xx-i2s: Entered s3c24xx_i2s_hw_params
> s3c24xx-i2s: hw_params r: IISMOD: 9
> s3c24xx-i2s: hw_params w: IISMOD: 9
> s3c24xx-pcm: Entered s3c24xx_pcm_hw_params
> s3c24xx-pcm: params bf0673f4, client bf067404, channel 10
> dma10: s3c2410_request_dma: client=I2S PCM Stereo out, dev=00000000
> mapped channel 10 to 2
> dma2: s3c2410_dma_request:755: ls=0, cur=c326b020, 00000000 c326b020
> dma2: s3c2410_dma_request:755: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=04, DCON=a0d00000
> dma10: s3c2410_dma_request : requesting irq 35
> s3c2410_dma_request: channel initialised, c044fdd4
> s3c2410_dma_set_buffdone_fn: chan=c044fdd4, callback rtn=bf05d108
> s3c24xx-pcm: Entered s3c24xx_pcm_mmap
> s3c24xx-pcm: Entered s3c24xx_pcm_prepare
> s3c2410_dma_devconfig: source=1, hwcfg=00000003, devaddr=55000010
> s3c2410_dma_devconfig: mem source, devaddr=55000010, hwcfg=3
> s3c2410_dma_config: chan=10, xfer_unit=2, dcon=80000000
> s3c2410_dma_config: Initial dcon is 80000000
> s3c2410_dma_config: New dcon is 80000000
> s3c2410_dma_config: dcon now a0900000
> s3c2410_dma_flush: chan c044fdd4 (2)
> dma2: s3c2410_dma_flush:912: ls=0, cur=c326b020, 00000000 c326b020
> dma2: s3c2410_dma_flush:912: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=04, DCON=a0d00000
> s3c2410_dma_flush: free buffer c326b020, next 00000000
> s3c24xx-pcm: Entered s3c24xx_audio_buffdone
> dma2: s3c2410_dma_flush:939: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=04, DCON=a0d00000
> dma2: s3c2410_dma_flush:954: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=04, DCON=a0d00000
> s3c24xx-pcm: Entered s3c24xx_pcm_enqueue dma_max 1
> s3c24xx-pcm: dma_loaded: 0 pos: 332a0000 len: 4096 dma_max: 1 dma_end: 332a3e80
> s3c2410_dma_enqueue: id=c31fa300, data=332a0000, size=4096
> s3c2410_dma_enqueue: buffer c326b020 queued onto empty channel
> s3c24xx-pcm: ret 0 period 4096
> uda134x_mute mute: 0
> uda134x_write reg: 0C, value:80
> s3c24xx-pcm: Entered s3c24xx_pcm_trigger
> s3c2410_start_dma: channel=2
> s3c2410_chan_loadbuffer: loading buff c326b020 (0x332a0000,0x001000)
> load_state is none, checking for noreload (next=00000000)
> dma2: s3c2410_dma_start:366: ls=1, cur=c326b020, 00000000 c326b020
> dma2: s3c2410_dma_start:366: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=04, DCON=a0d00800
> dma2: 00000002 to DMASKTRIG
> dma2: s3c2410_dma_start:394: ls=1, cur=c326b020, 00000000 c326b020
> dma2: s3c2410_dma_start:394: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=02, DCON=a0d00800
> dma2: s3c2410_dma_started:967: ls=1, cur=c326b020, 00000000 c326b020
> dma2: s3c2410_dma_started:967: DCSRC=332a05c4, DISRC=332a0000,
> DSTAT=00000000 DMT=02, DCON=a0d00800
> s3c24xx-i2s: Entered s3c24xx_i2s_trigger
> s3c24xx-i2s: Entered s3c24xx_snd_is_clkmaster
> s3c24xx-i2s: Entered s3c24xx_snd_txctrl
> s3c24xx-i2s: r: IISCON: 10f IISMOD: 9 IISFCON: 0
> s3c24xx-i2s: w: IISCON: 127 IISMOD: 89 IISFCON: a000
> s3c24xx-pcm: Entered s3c24xx_pcm_pointer
> s3c24xx-pcm: Pointer 332a0158 55000010
> dma2: s3c2410_dma_irq:608: ls=1, cur=c326b020, 00000000 c326b020
> dma2: s3c2410_dma_irq:608: DCSRC=332a1000, DISRC=332a0000,
> DSTAT=00000000 DMT=00, DCON=a0d00800
> s3c24xx-pcm: Entered s3c24xx_audio_buffdone
> s3c24xx-pcm: Entered s3c24xx_pcm_pointer
> s3c24xx-pcm: Pointer 332a1000 55000010
> s3c24xx-pcm: Entered s3c24xx_pcm_enqueue dma_max 0
> s3c24xx-pcm: dma_loaded: 0 pos: 332a1000 len: 4096 dma_max: 2 dma_end: 332a3e80
> s3c2410_dma_enqueue: id=c31fa300, data=332a1000, size=4096
> s3c2410_dma_enqueue: buffer c326b040 queued onto empty channel
> s3c2410_chan_loadbuffer: loading buff c326b040 (0x332a1000,0x001000)
> load_state is none, checking for noreload (next=00000000)
> s3c24xx-pcm: ret 0 period 4096
> s3c24xx-pcm: dma_loaded: 1 pos: 332a2000 len: 4096 dma_max: 2 dma_end: 332a3e80
> s3c2410_dma_enqueue: id=c31fa300, data=332a2000, size=4096
> dma2: s3c2410_dma_enqueue: buffer c326b000 queued onto non-empty channel
> dma2: loadbuffer:timeout loading buffer
> dma2: s3c2410_dma_enqueue:517: ls=1, cur=c326b040, c326b000 c326b000
> dma2: s3c2410_dma_enqueue:517: DCSRC=332a1000, DISRC=332a1000,
> DSTAT=00000000 DMT=00, DCON=a0d00800
> s3c24xx-pcm: ret -22 period 4096
> dma2: timeout waiting for load (s3c2410_dma_irq)
> s3c24xx-pcm: Entered s3c24xx_pcm_pointer
> s3c24xx-pcm: Pointer 332a1000 55000010
> s3c24xx-pcm: Entered s3c24xx_pcm_pointer
> s3c24xx-pcm: Pointer 332a1000 55000010
> ^CAborted by signals3c24xx-pcm: Entered s3c24xx_pcm_trigger
> s3c2410_dma_dostop:
> dma2: s3c2410_dma_dostop:857: ls=1, cur=c326b040, c326b000 c326b000
> dma2: s3c2410_dma_dostop:857: DCSRC=332a1000, DISRC=332a1000,
> DSTAT=00000000 DMT=00, DCON=a0d00800
> s3c24xx-i2s: Entered s3c24xx_i2s_trigger
> s3c24xx-i2s: Entered s3c24xx_snd_txctrl
> s3c24xx-i2s: r: IISCON: 127 IISMOD: 89 IISFCON: a000
> 
> 
> -- 
> Christian Pellegrin, see http://www.evolware.org/chri/
> "Real Programmers don't play tennis, or any other sport which requires
> you to change clothes. Mountain climbing is OK, and Real Programmers
> wear their climbing boots to work in case a mountain should suddenly
> spring up in the middle of the computer room."
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
