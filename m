From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
	OMAP MCBSP
Date: Thu, 5 Nov 2009 10:26:39 +0200
Message-ID: <200911051026.39538.peter.ujfalusi@nokia.com>
References: <1257357235.2887.499.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4B1AC1038B9
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 09:26:55 +0100 (CET)
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
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Graeme Gregory <gg@slimlogic.co.uk>, ext Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 04 November 2009 19:53:55 ext Liam Girdwood wrote:
> From: Graeme Gregory <gg@slimlogic.co.uk>
> =

> This patch increases the number of supported audio channels from 4
> to 16 and was sponsored by Shotspotter inc.
> =

> Signed-off-by: Graeme Gregory <gg@slimlogic.co.uk>
> Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>
> ---
>  sound/soc/omap/omap-mcbsp.c |   71
>  +++++++++++++++++++++++++++++------------- 1 files changed, 49
>  insertions(+), 22 deletions(-)
> =

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
> =

>  #define to_mcbsp(priv)	container_of((priv), struct omap_mcbsp_data,
>  bus_id) @@ -257,7 +259,7 @@ static int omap_mcbsp_dai_hw_params(struct
>  snd_pcm_substream *substream, int dma, bus_id =3D mcbsp_data->bus_id, id=
 =3D
>  cpu_dai->id;
>  	int wlen, channels, wpf, sync_mode =3D OMAP_DMA_SYNC_ELEMENT;
>  	unsigned long port;
> -	unsigned int format;
> +	unsigned int format, frame_size, div;
> =

>  	if (cpu_class_is_omap1()) {
>  		dma =3D omap1_dma_reqs[bus_id][substream->stream];
> @@ -294,27 +296,23 @@ static int omap_mcbsp_dai_hw_params(struct
>  snd_pcm_substream *substream,
> =

>  	format =3D mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
>  	wpf =3D channels =3D params_channels(params);
> -	switch (channels) {
> -	case 2:
> -		if (format =3D=3D SND_SOC_DAIFMT_I2S) {
> -			/* Use dual-phase frames */
> -			regs->rcr2	|=3D RPHASE;
> -			regs->xcr2	|=3D XPHASE;
> -			/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> -			wpf--;
> -			regs->rcr2	|=3D RFRLEN2(wpf - 1);
> -			regs->xcr2	|=3D XFRLEN2(wpf - 1);
> -		}
> -	case 1:
> -	case 4:
> +	if (channels =3D=3D 2 && format =3D=3D SND_SOC_DAIFMT_I2S) {
> +		/* Use dual-phase frames */
> +		regs->rcr2	|=3D RPHASE;
> +		regs->xcr2	|=3D XPHASE;
> +		/* Set 1 word per (McBSP) frame for phase1 and phase2 */
> +		wpf--;
> +		regs->rcr2	|=3D RFRLEN2(wpf - 1);
> +		regs->xcr2	|=3D XFRLEN2(wpf - 1);
>  		/* Set word per (McBSP) frame for phase1 */
>  		regs->rcr1	|=3D RFRLEN1(wpf - 1);
>  		regs->xcr1	|=3D XFRLEN1(wpf - 1);
> -		break;
> -	default:
> +	} else if (channels > 0 && channels < 17) {
> +		regs->rcr1	|=3D RFRLEN1(wpf - 1);
> +		regs->xcr1	|=3D XFRLEN1(wpf - 1);
> +	} else
>  		/* Unsupported number of channels */
>  		return -EINVAL;
> -	}

I would have done this a bit differently:

...
	/* Check if the number of channels are valid */
	if (channels < 1 || channels > 16) {
		/* Unsupported number of channels */
		/* Probably would be good to have some error message about it? */
		return -EINVAL;
	}

	format =3D mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
	wpf =3D channels =3D params_channels(params);

	if (channels =3D=3D 2 && format =3D=3D SND_SOC_DAIFMT_I2S) {
		/* Use dual-phase frames */
		regs->rcr2      |=3D RPHASE;
		regs->xcr2      |=3D XPHASE;
		/* Set 1 word per (McBSP) frame for phase1 and phase2 */
		wpf--;
		regs->rcr2      |=3D RFRLEN2(wpf - 1);
		regs->xcr2      |=3D XFRLEN2(wpf - 1);
	}
	/* Set word per (McBSP) frame for phase1 */
	regs->rcr1      |=3D RFRLEN1(wpf - 1);
	regs->xcr1      |=3D XFRLEN1(wpf - 1);

> =

>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> @@ -330,6 +328,34 @@ static int omap_mcbsp_dai_hw_params(struct
>  snd_pcm_substream *substream, return -EINVAL;
>  	}
> =

> +	/* Default div to 1 if it wasn't set by machine driver, otherwise
> +	 * use set div as the maximum clock value
> +	 */
> +	div =3D mcbsp_data->clk_div ? mcbsp_data->clk_div : 1;
> +
> +	/* calc best frame size for rate and clock divider */
> +	do {
> +		frame_size =3D (mcbsp_data->in_freq / div) / params_rate(params);

I think this as it is now will not work when McBSP is a slave.
mcbsp_data->in_freq is going to be 0, since the sample rate generator is no=
t in =

use.


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

-- =

P=E9ter
