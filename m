From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 4/4] ASOC: sunxi: Add support for the
 spdif block
Date: Thu, 1 Oct 2015 22:11:22 +0200
Message-ID: <20151001201122.GM7104@lukather>
References: <1443635458-8873-1-git-send-email-codekipper@gmail.com>
 <1443635458-8873-5-git-send-email-codekipper@gmail.com>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rvv34iIeJXisuDc0"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBTNVW2YAKGQEZ4XKJMA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443635458-8873-5-git-send-email-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--rvv34iIeJXisuDc0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Wed, Sep 30, 2015 at 07:50:58PM +0200, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The sun4i, sun6i and sun7i SoC families have an SPDIF
> block which is capable of playback and capture.
> 
> This patch enables the playback of this block for
> the sun4i and sun7i families.
> 
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/Kconfig       |  12 +
>  sound/soc/sunxi/Makefile      |   4 +
>  sound/soc/sunxi/sun4i-spdif.c | 612 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 628 insertions(+)
>  create mode 100644 sound/soc/sunxi/sun4i-spdif.c
> 
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 84c72ec..2ebf43d 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -8,4 +8,16 @@ config SND_SUN4I_CODEC
>  	  Select Y or M to add support for the Codec embedded in the Allwinner
>  	  A10 and affiliated SoCs.
>  
> +config SND_SOC_SUNXI_DAI_SPDIF
> +        tristate
> +	depends on OF
> +        select SND_SOC_GENERIC_DMAENGINE_PCM
> +        select REGMAP_MMIO
> +
> +config SND_SOC_SUNXI_MACHINE_SPDIF
> +        tristate "APB on-chip sun4i/sun5i/sun7i SPDIF"
> +	depends on OF
> +        select SND_SOC_SUNXI_DAI_SPDIF
> +        help
> +          Say Y if you want to add support for SoC S/PDIF audio as simple audio card.

You still haven't said why you can't use simple-card...

> +static void sun4i_spdif_configure(struct sun4i_spdif_dev *host)
> +{
> +	u32 reg_val;
> +
> +	/* soft reset SPDIF */
> +	regmap_write(host->regmap, SUN4I_SPDIF_CTL, SUN4I_SPDIF_CTL_RESET);
> +
> +	/* MCLK OUTPUT enable */
> +	regmap_update_bits(host->regmap, SUN4I_SPDIF_CTL,
> +			SUN4I_SPDIF_CTL_MCLKOUTEN, SUN4I_SPDIF_CTL_MCLKOUTEN);

The alignment is still not right....

> +	/* flush TX FIFO */
> +	regmap_update_bits(host->regmap, SUN4I_SPDIF_FCTL,
> +			SUN4I_SPDIF_FCTL_FTX, SUN4I_SPDIF_FCTL_FTX);
> +
> +	/* clear interrupt status */
> +	regmap_read(host->regmap, SUN4I_SPDIF_ISTA, &reg_val);
> +	regmap_write(host->regmap, SUN4I_SPDIF_ISTA, reg_val);

You're not using any interrupts. Why is this needed?

> +static int sun4i_spdif_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *cpu_dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +
> +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> +		return -EINVAL;
> +
> +	sun4i_spdif_configure(host);
> +
> +	return clk_prepare_enable(host->clk);

You're still not using pm_runtime...

> +}
> +
> +static void sun4i_spdif_shutdown(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +
> +	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
> +		return;
> +
> +	clk_disable_unprepare(host->clk);
> +}
> +
> +static int sun4i_spdif_hw_params(struct snd_pcm_substream *substream,
> +				struct snd_pcm_hw_params *params,
> +				struct snd_soc_dai *cpu_dai)
> +{
> +	int ret = 0;
> +	int fmt;
> +	unsigned long rate = params_rate(params);
> +	u32 mclk_div = 0;
> +	unsigned int mclk = 0;
> +	u32 reg_val;
> +	struct sun4i_spdif_dev *host = snd_soc_dai_get_drvdata(cpu_dai);
> +	struct platform_device *pdev = host->pdev;
> +
> +	/* Add the PCM and raw data select interface */
> +	switch (params_channels(params)) {
> +	case 1: /* PCM mode */
> +	case 2:
> +		fmt = 0;
> +		break;
> +	case 4: /* raw data mode */
> +		fmt = SUN4I_SPDIF_TXCFG_NONAUDIO;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		fmt |= SUN4I_SPDIF_TXCFG_FMT16BIT;
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		fmt |= SUN4I_SPDIF_TXCFG_FMT20BIT;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		fmt |= SUN4I_SPDIF_TXCFG_FMT24BIT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	switch (rate) {
> +	case 22050:
> +	case 44100:
> +	case 88200:
> +	case 176400:
> +		mclk = 22579200;
> +		break;
> +	case 24000:
> +	case 32000:
> +	case 48000:
> +	case 96000:
> +	case 192000:
> +		mclk = 24576000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = clk_set_rate(host->audio_clk, mclk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Setting pll2 clock rate for %d Hz failed!\n", mclk);
> +		return ret;
> +	}

You're still using the PLL2...

> +
> +	ret = clk_set_rate(host->clk, mclk);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"Setting SPDIF clock rate for %d Hz failed!\n", mclk);
> +		return ret;
> +	}
> +
> +	reg_val = 0;
> +	reg_val &= ~SUN4I_SPDIF_FCTL_FIFOSRC;
> +	reg_val |= SUN4I_SPDIF_FCTL_TXTL_MASK;
> +	reg_val |= SUN4I_SPDIF_FCTL_RXTL_MASK;
> +	reg_val |= SUN4I_SPDIF_FCTL_TXIM;
> +	reg_val |= SUN4I_SPDIF_FCTL_RXOM_MASK;
> +	regmap_write(host->regmap, SUN4I_SPDIF_FCTL, reg_val);

You're still not using regmap_update_bits...

IF you're really going to ignore all the comments we did, please tell
us upfront. That way, we will not waste our time doing a review of
your patches.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--rvv34iIeJXisuDc0--
