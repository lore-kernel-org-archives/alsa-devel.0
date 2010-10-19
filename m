From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 11/25] ASoC: Samsung: Add common I2S driver
Date: Tue, 19 Oct 2010 02:35:50 -0700
Message-ID: <20101019093550.GA11371@opensource.wolfsonmicro.com>
References: <1P85Z9-0007a6-27>
	<1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64680103871
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 11:36:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1287472025-27898-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 19, 2010 at 04:07:05PM +0900, Jassi Brar wrote:

This looks good - there's a few comments below but they're pretty small
things.

>  /**
>   * struct s3c_audio_pdata - common platform data for audio device drivers
>   * @cfg_gpio: Callback function to setup mux'ed pins in I2S/PCM/AC97 mode
>   */
>  struct s3c_audio_pdata {
>  	int (*cfg_gpio)(struct platform_device *);
> +	union {
> +		struct samsung_i2s i2s;
> +	} type;

Might be as easy just to embed a struct s3c_audio_pdata within the
struct samsung_i2s?

> +	switch (bfs) {
> +	case 48:
> +		mod |= MOD_BCLK_48FS;
> +		break;
> +	case 32:
> +		mod |= MOD_BCLK_32FS;
> +		break;
> +	case 24:
> +		mod |= MOD_BCLK_24FS;
> +		break;
> +	default:
> +		mod |= MOD_BCLK_16FS;
> +		break;

Especially on the write side I'd be a bit more comfortable if these
functions didn't silently convert an unspecified setting into a default
so that we know that users are getting the setting they asked for.

> +		if (is_secondary(i2s)) {
> +			con |= CON_TXSDMA_ACTIVE;
> +			con &= ~CON_TXSDMA_PAUSE;
> +		} else {
> +			con |= CON_TXDMA_ACTIVE;
> +			con &= ~CON_TXDMA_PAUSE;

Can we do this stuff with a variable storing the mask to use?  It might
compress the code a lot but I've not looked at what the bits actually
are.

> +	/* Allow LRCLK-inverted version of the supported formats */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +	case SND_SOC_DAIFMT_NB_IF:
> +		if (tmp & MOD_LR_RLOW)
> +			tmp &= ~MOD_LR_RLOW;
> +		else
> +			tmp |= MOD_LR_RLOW;
> +		break;

This looks a bit odd - it'll flip MOD_LR_FLOW if the frame is inverted,
I'd expect it to want to set a specific value?

> +	/* We don't care about BFS in Slave mode */
> +	if (is_slave(i2s))
> +		return 0;

You're skipping more than just rfs setting here.  Probably just a case
of updating the comment.

> +static int i2sv2_i2s_set_clkdiv(struct snd_soc_dai *dai,
> +	int div_id, int div)
> +{
> +	struct i2s_dai *i2s = to_info(dai);
> +	struct i2s_dai *other = i2s->pri_dai ? : i2s->sec_dai;
> +
> +	if (div_id == SAMSUNG_I2S_DIV_BCLK) {

switch statement please.

> +#define SAMSUNG_I2S_RATES \
> +	(SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | SNDRV_PCM_RATE_16000 | \
> +	SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
> +	SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000)

SNDRV_PCM_RATE_8000_96000.

> +/*
> + * Maximum number of I2S blocks that any SoC can have.
> + * The secondary interface of a CPU dai(if there exists any),
> + * is indexed at [cpu-dai's ID + MAX_I2S]
> + */
> +#define MAX_I2S	4

Can this be kept internal to the driver?  If not it should be
namespaced.
