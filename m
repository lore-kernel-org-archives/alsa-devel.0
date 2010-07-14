From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Asoc Davinci Voicecodec: Added support
 based on copy_from_user instead of DMA
Date: Wed, 14 Jul 2010 15:44:14 +0100
Message-ID: <20100714144414.GE31073@rakim.wolfsonmicro.main>
References: <1279117691-5467-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5573E1037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 16:44:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279117691-5467-1-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Barry Song <21cnbao@gmail.com>, alsa-devel@alsa-project.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Troy Kisky <troy.kisky@boundarydevices.com>, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Chaithrika U S <chaithrika@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 14, 2010 at 04:28:10PM +0200, Raffaele Recalcati wrote:
> From: Davide Bonfanti <davide.bonfanti@bticino.it>

>     Since DM365 has the same DMA event for McBSP and Voicecodec this two
>     peripherals cannot be used at the same time.

Please try to format your patches as documented in SubmittingPatches -
you don't want all this indentation you're introducing in the start of
the changelog.  There's also other stuff with regard to coding style and
so on that it'd be useful for you to look at.

>     This driver implements Voicecodec without the use of a DMA but with
>     a copy_from_user.

Why is this specific to the voice CODEC?  Shouldn't this be generally
usable, and wouldn't it be better if the DMA driver were able to do some
automatic fallback here so that in cases where DMA can be used it will
be?

I had thought from the discussion on original submission that the two
devices were mutually exclusive for other reasons anyway.

> +/* Timer register offsets */
> +#define PID12                   0x00
> +#define TIM12                   0x10
> +#define TIM34                   0x14
> +#define PRD12                   0x18
> +#define PRD34                   0x1c
> +#define TCR                     0x20
> +#define TGCR                    0x24

This timer stuff all looks rather like it should be in whatever other
code manages the timers - as it stands it'll get into a fight with
anything else trying to use them.  I'd expect something like this to use
hrtimers to get high resolution time rather than banging the timer
hardware directly.

> +int pointer_sub;
> +u16 local_buffer[BUF_SIZE/2];

Should BUF_SIZE not be a configuration option, or dynamically configured
at runtime?

> +/*
> + *	ppcm = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
> + *		&pcm_hardware_playback : &pcm_hardware_capture;
> + */

Remove this if it's not used.

> +	__raw_writel(0x0, IO_ADDRESS(0x01D0C008));
> +	__raw_writel(0x7400, IO_ADDRESS(0x01D0C004));

This could do with being substantially clearer...  There's quite a few
other magic numbers in the code which need fixing.

> +static int davinci_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	struct clk *clk;
> +
> +	clk = clk_get(NULL, TIMER);
> +	if (!IS_ERR(clk))
> +		clk_disable(clk);

As with your previous patch you're going to be leaking clocks all over -
you should be balancing your clk_get() with clk_put().

> +struct snd_soc_platform davinci_soc_platform_copy = {
> +	.name =		"davinci-audio-copy",
> +	.pcm_ops =	&davinci_pcm_ops,
> +	.pcm_new =	davinci_pcm_new,
> +}; EXPORT_SYMBOL_GPL(davinci_soc_platform_copy);

Fix your formatting here.

> +++ b/sound/soc/soc-core.c
> @@ -801,7 +801,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
>  	}
>  	return 0;
>  }
> -
> +#if 0
>  /* ASoC PCM operations */
>  static struct snd_pcm_ops soc_pcm_ops = {
>  	.open		= soc_pcm_open,
> @@ -811,7 +811,7 @@ static struct snd_pcm_ops soc_pcm_ops = {
>  	.prepare	= soc_pcm_prepare,
>  	.trigger	= soc_pcm_trigger,
>  };
> -
> +#endif

Um....?  I'm not entirely sure what this and the rest of the changes in
the file are supposed to do but they weren't mentioned at all in the
changelog.  If this is needed it should be a separate change with a
proper changelog explaining what's going on.
