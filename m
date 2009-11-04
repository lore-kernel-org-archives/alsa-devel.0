From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels	on
	OMAP MCBSP
Date: Wed, 4 Nov 2009 18:28:30 +0000
Message-ID: <20091104182829.GF25044@sirena.org.uk>
References: <1257357235.2887.499.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 249A624434
	for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2009 19:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1257357235.2887.499.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 04, 2009 at 05:53:55PM +0000, Liam Girdwood wrote:
> From: Graeme Gregory <gg@slimlogic.co.uk>
> 
> This patch increases the number of supported audio channels from 4
> to 16 and was sponsored by Shotspotter inc.

I'm OK with this from an ASoC point of view (the provision of a default
for existing machine drivers is good BTW), also adding Jarkko as well as
Peter for the OMAP-specific review.

> 
> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/omap/omap-mcbsp.c |   71 +++++++++++++++++++++++++++++-------------
>  1 files changed, 49 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 3341f49..290ef2f 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -49,6 +49,8 @@ struct omap_mcbsp_data {
>  	 */
>  	int				active;
>  	int				configured;
> +	unsigned int			in_freq;
> +	int				clk_div;
>  };
>  
>  #define to_mcbsp(priv)	container_of((priv), struct omap_mcbsp_data, bus_id)
> @@ -257,7 +259,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  	int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
>  	int wlen, channels, wpf, sync_mode = OMAP_DMA_SYNC_ELEMENT;
>  	unsigned long port;
> -	unsigned int format;
> +	unsigned int format, frame_size, div;
>  
>  	if (cpu_class_is_omap1()) {
>  		dma = omap1_dma_reqs[bus_id][substream->stream];
> @@ -294,27 +296,23 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  
>  	format = mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
>  	wpf = channels = params_channels(params);
> -	switch (channels) {
> -	case 2:
> -		if (format == SND_SOC_DAIFMT_I2S) {
> -			/* Use dual-phase frames */
> -			regs->rcr2	|= RPHASE;
> -			regs->xcr2	|= XPHASE;
> -			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> -			wpf--;
> -			regs->rcr2	|= RFRLEN2(wpf - 1);
> -			regs->xcr2	|= XFRLEN2(wpf - 1);
> -		}
> -	case 1:
> -	case 4:
> +	if (channels == 2 && format == SND_SOC_DAIFMT_I2S) {
> +		/* Use dual-phase frames */
> +		regs->rcr2	|= RPHASE;
> +		regs->xcr2	|= XPHASE;
> +		/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> +		wpf--;
> +		regs->rcr2	|= RFRLEN2(wpf - 1);
> +		regs->xcr2	|= XFRLEN2(wpf - 1);
>  		/* Set word per (McBSP) frame for phase1 */
>  		regs->rcr1	|= RFRLEN1(wpf - 1);
>  		regs->xcr1	|= XFRLEN1(wpf - 1);
> -		break;
> -	default:
> +	} else if (channels > 0 && channels < 17) {
> +		regs->rcr1	|= RFRLEN1(wpf - 1);
> +		regs->xcr1	|= XFRLEN1(wpf - 1);
> +	} else
>  		/* Unsupported number of channels */
>  		return -EINVAL;
> -	}
>  
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> @@ -330,6 +328,34 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  		return -EINVAL;
>  	}
>  
> +	/* Default div to 1 if it wasn't set by machine driver, otherwise
> +	 * use set div as the maximum clock value
> +	 */
> +	div = mcbsp_data->clk_div ? mcbsp_data->clk_div : 1;
> +
> +	/* calc best frame size for rate and clock divider */
> +	do {
> +		frame_size = (mcbsp_data->in_freq / div) / params_rate(params);
> +		pr_debug("freq %d, rate %d, frame size %d, div %d\n",
> +				mcbsp_data->in_freq, params_rate(params), frame_size, div);
> +
> +		if (frame_size > 256)
> +			div++;
> +	} while (frame_size > 256);
> +
> +	/* Check we can fit the requested number of channels into our
> +	 * calculated frame size
> +	 */
> +	if ((channels * wlen) > frame_size) {
> +		printk(KERN_ERR
> +			"OMAP-MCBSP: cannot fit channels in frame size\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set the actual clkdiv to use for this samplerate */
> +	regs->srgr1 &= ~CLKGDV(0xFF);
> +	regs->srgr1 |= CLKGDV(div - 1);
> +
>  	/* Set FS period and length in terms of bit clock periods */
>  	switch (format) {
>  	case SND_SOC_DAIFMT_I2S:
> @@ -338,7 +364,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
>  	case SND_SOC_DAIFMT_DSP_B:
> -		regs->srgr2	|= FPER(wlen * channels - 1);
> +		regs->srgr2	|= FPER(frame_size - 1);
>  		regs->srgr1	|= FWID(0);
>  		break;
>  	}
> @@ -449,12 +475,11 @@ static int omap_mcbsp_dai_set_clkdiv(struct snd_soc_dai *cpu_dai,
>  				     int div_id, int div)
>  {
>  	struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
> -	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
>  
>  	if (div_id != OMAP_MCBSP_CLKGDV)
>  		return -ENODEV;
>  
> -	regs->srgr1	|= CLKGDV(div - 1);
> +	mcbsp_data->clk_div = div;
>  
>  	return 0;
>  }
> @@ -554,6 +579,8 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>  	struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
>  	int err = 0;
>  
> +	mcbsp_data->in_freq = freq;
> +
>  	switch (clk_id) {
>  	case OMAP_MCBSP_SYSCLK_CLK:
>  		regs->srgr2	|= CLKSM;
> @@ -598,13 +625,13 @@ static struct snd_soc_dai_ops omap_mcbsp_dai_ops = {
>  	.id = (link_id),					\
>  	.playback = {						\
>  		.channels_min = 1,				\
> -		.channels_max = 4,				\
> +		.channels_max = 16,				\
>  		.rates = OMAP_MCBSP_RATES,			\
>  		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
>  	},							\
>  	.capture = {						\
>  		.channels_min = 1,				\
> -		.channels_max = 4,				\
> +		.channels_max = 16,				\
>  		.rates = OMAP_MCBSP_RATES,			\
>  		.formats = SNDRV_PCM_FMTBIT_S16_LE,		\
>  	},							\
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
