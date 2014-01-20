From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v2 2/4] ASoC: tlv320aic32x4: DT support
Date: Mon, 20 Jan 2014 13:54:57 +0100
Message-ID: <1390222497.5871.2.camel@pizza.hi.pengutronix.de>
References: <1390219558-25341-1-git-send-email-mpa@pengutronix.de>
 <1390219558-25341-3-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id E47C326165F
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:55:07 +0100 (CET)
In-Reply-To: <1390219558-25341-3-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Am Montag, den 20.01.2014, 13:05 +0100 schrieb Markus Pargmann:
> Add DT support for this codec. The bindings differ a bit from the aic3x
> codec bindings, so I created a new binding documentation.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  .../devicetree/bindings/sound/tlv320aic32x4.txt    | 18 ++++++++++++++++
>  sound/soc/codecs/tlv320aic32x4.c                   | 25 ++++++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> new file mode 100644
> index 0000000..cff06ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tlv320aic32x4.txt
> @@ -0,0 +1,18 @@
> +Texas Instruments - tlv320aic32x4 Codec module
> +
> +The tlv320aic32x4 serial control bus communicates through I2C protocols
> +
> +Required properties:
> + - compatible: Should be "ti,tlv320aic32x4"
> + - reg: I2C slave address
> +
> +Optional properties:
> + - gpio-reset: Reset-GPIO phandle with args as described in gpio/gpio.txt

This should be "reset-gpios".

> +
> +
> +Example:
> +
> +codec: tlv320aic32x4@18 {
> +	compatible = "ti,tlv320aic32x4";
> +	reg = <0x18>;
> +};
> diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
> index 1c9f1d8..6c38cb7 100644
> --- a/sound/soc/codecs/tlv320aic32x4.c
> +++ b/sound/soc/codecs/tlv320aic32x4.c
> @@ -29,6 +29,7 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/gpio.h>
> +#include <linux/of_gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/cdev.h>
>  #include <linux/slab.h>
> @@ -669,11 +670,22 @@ static struct snd_soc_codec_driver soc_codec_dev_aic32x4 = {
>  	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
>  };
>  
> +static int aic32x4_parse_dt(struct aic32x4_priv *aic32x4,
> +		struct device_node *np)
> +{
> +	aic32x4->swapdacs = false;
> +	aic32x4->micpga_routing = 0;
> +	aic32x4->rstn_gpio = of_get_named_gpio(np, "gpio-reset", 0);

This should be "reset-gpios".

> +
> +	return 0;
> +}
> +
>  static int aic32x4_i2c_probe(struct i2c_client *i2c,
>  			     const struct i2c_device_id *id)
>  {
>  	struct aic32x4_pdata *pdata = i2c->dev.platform_data;
>  	struct aic32x4_priv *aic32x4;
> +	struct device_node *np = i2c->dev.of_node;
>  	int ret;
>  
>  	aic32x4 = devm_kzalloc(&i2c->dev, sizeof(struct aic32x4_priv),
> @@ -692,6 +704,12 @@ static int aic32x4_i2c_probe(struct i2c_client *i2c,
>  		aic32x4->swapdacs = pdata->swapdacs;
>  		aic32x4->micpga_routing = pdata->micpga_routing;
>  		aic32x4->rstn_gpio = pdata->rstn_gpio;
> +	} else if (np) {
> +		ret = aic32x4_parse_dt(aic32x4, np);
> +		if (ret) {
> +			dev_err(&i2c->dev, "Failed to parse DT node\n");
> +			return ret;
> +		}
>  	} else {
>  		aic32x4->power_cfg = 0;
>  		aic32x4->swapdacs = false;
> @@ -723,10 +741,17 @@ static const struct i2c_device_id aic32x4_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, aic32x4_i2c_id);
>  
> +static const struct of_device_id aic32x4_of_id[] = {
> +	{ .compatible = "ti,tlv320aic32x4", },
> +	{ /* senitel */ }
> +};
> +MODULE_DEVICE_TABLE(of, aic32x4_of_id);
> +
>  static struct i2c_driver aic32x4_i2c_driver = {
>  	.driver = {
>  		.name = "tlv320aic32x4",
>  		.owner = THIS_MODULE,
> +		.of_match_table = aic32x4_of_id,
>  	},
>  	.probe =    aic32x4_i2c_probe,
>  	.remove =   aic32x4_i2c_remove,

regards
Philipp
