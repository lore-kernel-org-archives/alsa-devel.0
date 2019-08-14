From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 12/15] ASoC: sun4i-i2s: Add multi-lane functionality
Date: Wed, 14 Aug 2019 10:27:26 +0200
Message-ID: <3526410.lk6A0UfGIS@jernej-laptop>
References: <20190814060854.26345-1-codekipper@gmail.com> <20190814060854.26345-13-codekipper@gmail.com>
Reply-To: jernej.skrabec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDP4JJM5QYGRB4ULZ7VAKGQE4E3CTEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20190814060854.26345-13-codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, be17068-p0aYb1w59bq9tCD/VL7h6Q@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi!

Dne sreda, 14. avgust 2019 ob 08:08:51 CEST je codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
napisal(a):
> From: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> The i2s block supports multi-lane i2s output however this functionality
> is only possible in earlier SoCs where the pins are exposed and for
> the i2s block used for HDMI audio on the later SoCs.
> 
> To enable this functionality, an optional property has been added to
> the bindings.
> 
> Signed-off-by: Marcus Cooper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index a8d98696fe7c..a020c3b372a8 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -23,7 +23,7 @@
> 
>  #define SUN4I_I2S_CTRL_REG		0x00
>  #define SUN4I_I2S_CTRL_SDO_EN_MASK		GENMASK(11, 8)
> -#define SUN4I_I2S_CTRL_SDO_EN(sdo)			BIT(8 + 
(sdo))
> +#define SUN4I_I2S_CTRL_SDO_EN(lines)		(((1 << lines) - 1) 
<< 8)
>  #define SUN4I_I2S_CTRL_MODE_MASK		BIT(5)
>  #define SUN4I_I2S_CTRL_MODE_SLAVE			(1 << 5)
>  #define SUN4I_I2S_CTRL_MODE_MASTER			(0 << 5)
> @@ -614,6 +614,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream
> *substream, struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>  	int sr, wss, channels;
>  	u32 width;
> +	int lines;
> 
>  	channels = params_channels(params);
>  	if (channels != 2) {
> @@ -622,6 +623,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream
> *substream, return -EINVAL;
>  	}
> 
> +	lines = (channels + 1) / 2;
> +
> +	/* Enable the required output lines */
> +	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
> +			   SUN4I_I2S_CTRL_SDO_EN_MASK,
> +			   SUN4I_I2S_CTRL_SDO_EN(lines));

As Maxime said before, this doesn't work for TDM. Maybe we can skip this for 
now, until we agree on method how to describe channel allocation?

> +
>  	if (i2s->variant->has_chcfg) {
>  		regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
>  				   
SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
> @@ -1389,9 +1397,10 @@ static int sun4i_i2s_init_regmap_fields(struct device
> *dev, static int sun4i_i2s_probe(struct platform_device *pdev)
>  {
>  	struct sun4i_i2s *i2s;
> +	struct snd_soc_dai_driver *soc_dai;
>  	struct resource *res;
>  	void __iomem *regs;
> -	int irq, ret;
> +	int irq, ret, val;
> 
>  	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
>  	if (!i2s)
> @@ -1456,6 +1465,19 @@ static int sun4i_i2s_probe(struct platform_device
> *pdev) i2s->capture_dma_data.addr = res->start + SUN4I_I2S_FIFO_RX_REG;
> i2s->capture_dma_data.maxburst = 8;
> 
> +	soc_dai = devm_kmemdup(&pdev->dev, &sun4i_i2s_dai,
> +			       sizeof(*soc_dai), GFP_KERNEL);
> +	if (!soc_dai) {
> +		ret = -ENOMEM;
> +		goto err_pm_disable;
> +	}
> +
> +	if (!of_property_read_u32(pdev->dev.of_node,
> +				  "allwinner,playback-channels", 
&val)) {
> +		if (val >= 2 && val <= 8)
> +			soc_dai->playback.channels_max = val;
> +	}
> +

Rather than inventing new DT properties, I would rather have multiple 
snd_soc_dai_driver structures, depending on capabilities of that particular 
I2S block. That way we avoid some boilerplate code as can be seen here and 
it's IMO more transparent.

In this case, I would make another snd_soc_dai_driver struct for H3, which has 
channel_max property set to 8 and from patch 14, additional supported formats.

Best regards,
Jernej

>  	pm_runtime_enable(&pdev->dev);
>  	if (!pm_runtime_enabled(&pdev->dev)) {
>  		ret = sun4i_i2s_runtime_resume(&pdev->dev);
> @@ -1465,7 +1487,7 @@ static int sun4i_i2s_probe(struct platform_device
> *pdev)
> 
>  	ret = devm_snd_soc_register_component(&pdev->dev,
>  					      
&sun4i_i2s_component,
> -					      &sun4i_i2s_dai, 
1);
> +					      soc_dai, 1);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Could not register DAI\n");
>  		goto err_suspend;
