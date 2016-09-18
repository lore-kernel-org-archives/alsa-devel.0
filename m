From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 3/3] ASoC: sun4i-codec: Add custom regmap configs
Date: Sun, 18 Sep 2016 22:27:41 +0200
Message-ID: <20160918202741.GM17518@lukather>
References: <20160915163630.18026-1-dannym@scratchpost.org>
 <20160915163630.18026-4-dannym@scratchpost.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UUMz/kfoogzZ9WLZ"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBPXR7O7AKGQEF46WTOI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160915163630.18026-4-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--UUMz/kfoogzZ9WLZ
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Sep 15, 2016 at 06:36:30PM +0200, Danny Milosavljevic wrote:
> ASoC: sun4i-codec: The A20 has a few extra registers that the A10
> doesn't have.
> Therefore, use different regmaps for A10 as compared to A20.

Same comment with the commit log.

> 
> Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 3b53b78..c5d6d84c 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -682,12 +682,37 @@ static const struct regmap_config sun4i_codec_regmap_config = {
>  	.reg_bits	= 32,
>  	.reg_stride	= 4,
>  	.val_bits	= 32,
> +	.max_register	= SUN4I_CODEC_ADC_RXCNT,
> +};
> +
> +static const struct regmap_config sun7i_codec_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
>  	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
>  };
>  
> +struct sun4i_codec_quirks {
> +	const struct regmap_config *regmap_config;
> +};
> +
> +static const struct sun4i_codec_quirks sun4i_codec_quirks = {
> +	.regmap_config = &sun4i_codec_regmap_config,
> +};
> +
> +static const struct sun4i_codec_quirks sun7i_codec_quirks = {
> +	.regmap_config = &sun7i_codec_regmap_config,
> +};
> +
>  static const struct of_device_id sun4i_codec_of_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-codec" },
> -	{ .compatible = "allwinner,sun7i-a20-codec" },
> +	{
> +		.compatible = "allwinner,sun4i-a10-codec",
> +		.data = &sun4i_codec_quirks,
> +	},
> +	{
> +		.compatible = "allwinner,sun7i-a20-codec",
> +		.data = &sun7i_codec_quirks,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> @@ -760,6 +785,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_card *card;
>  	struct sun4i_codec *scodec;
> +	const struct sun4i_codec_quirks *quirks;
>  	struct resource *res;
>  	void __iomem *base;
>  	int ret;
> @@ -777,8 +803,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  	}
>  
> +	quirks = of_device_get_match_data(&pdev->dev);

And you probably want to check that quirks isn't null there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--UUMz/kfoogzZ9WLZ--
