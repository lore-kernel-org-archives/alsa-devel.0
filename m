From: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] ASoC: fsl-asoc-card: add cs4271 and cs4272 support
Date: Fri, 29 Jan 2016 09:58:00 -0800
Message-ID: <20160129175800.GA7283@Asurada-Nvidia>
References: <1454065261-9522-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454065261-9522-1-git-send-email-eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Felipe F. Tonello" <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2016 at 11:01:00AM +0000, Felipe F. Tonello wrote:
> add cs4271 and cs42727 support for fsl-asoc-card
> 
> Signed-off-by: Felipe F. Tonello <eu-NLnRV5p3vwDxYxTyqlRmvgC/G2K4zDHf@public.gmane.org>

Acked-by: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> ---
>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 9 +++++++++
>  sound/soc/fsl/Kconfig                                     | 4 ++--
>  sound/soc/fsl/fsl-asoc-card.c                             | 7 +++++++
>  3 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> index 4da41bf1888e..ceaef5126989 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
> @@ -24,6 +24,9 @@ The compatible list for this generic sound card currently:
>  
>   "fsl,imx-audio-cs42888"
>  
> + "fsl,imx-audio-cs427x"
> + (compatible with CS4271 and CS4272)
> +
>   "fsl,imx-audio-wm8962"
>   (compatible with Documentation/devicetree/bindings/sound/imx-audio-wm8962.txt)
>  
> @@ -63,6 +66,12 @@ Optional properties:
>    - audio-asrc		: The phandle of ASRC. It can be absent if there's no
>  			  need to add ASRC support via DPCM.
>  
> +Optional unless SSI is selected as a CPU DAI:
> +
> +  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
> +
> +  - mux-ext-port	: The external port of the i.MX audio muxer
> +
>  Example:
>  sound-cs42888 {
>  	compatible = "fsl,imx-audio-cs42888";
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 14dfdee05fd5..35aabf9dc503 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -292,8 +292,8 @@ config SND_SOC_FSL_ASOC_CARD
>  	select SND_SOC_FSL_SSI
>  	help
>  	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
> -	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
> -	 and SGTL5000.
> +	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888,
> +	 CS4271, CS4272 and SGTL5000.
>  	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
>  
>  endif # SND_IMX_SOC
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 562b3bd22d9a..56b6b07d1922 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -28,6 +28,8 @@
>  #include "../codecs/wm8962.h"
>  #include "../codecs/wm8960.h"
>  
> +#define CS427x_SYSCLK_MCLK 0
> +
>  #define RX 0
>  #define TX 1
>  
> @@ -528,6 +530,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
>  		priv->cpu_priv.slot_width = 32;
>  		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
> +	} else if (of_device_is_compatible(np, "fsl,imx-audio-cs427x")) {
> +		codec_dai_name = "cs4271-hifi";
> +		priv->codec_priv.mclk_id = CS427x_SYSCLK_MCLK;
> +		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
>  	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
>  		codec_dai_name = "sgtl5000";
>  		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
> @@ -681,6 +687,7 @@ fail:
>  static const struct of_device_id fsl_asoc_card_dt_ids[] = {
>  	{ .compatible = "fsl,imx-audio-ac97", },
>  	{ .compatible = "fsl,imx-audio-cs42888", },
> +	{ .compatible = "fsl,imx-audio-cs427x", },
>  	{ .compatible = "fsl,imx-audio-sgtl5000", },
>  	{ .compatible = "fsl,imx-audio-wm8962", },
>  	{ .compatible = "fsl,imx-audio-wm8960", },
> -- 
> 2.7.0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
