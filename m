From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: rt5640: add more settings for rt5639
Date: Wed, 09 Apr 2014 09:48:28 -0600
Message-ID: <53456BCC.1010400@wwwdotorg.org>
References: <1397045989-13518-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F6F526007E
 for <alsa-devel@alsa-project.org>; Wed,  9 Apr 2014 17:48:32 +0200 (CEST)
In-Reply-To: <1397045989-13518-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

On 04/09/2014 06:19 AM, Oder Chiou wrote:
> The patch adds the the list of OF compatible strings, the binding document and
> the list of I2C device IDs for rt5639.

> diff --git a/Documentation/devicetree/bindings/sound/rt5639.txt b/Documentation/devicetree/bindings/sound/rt5639.txt
> new file mode 100644

Why not just add the new compatible value to the existing rt5640.txt?

> +Pins on the device (for linking into audio routes):
> +
> +  * DMIC1
> +  * DMIC2
> +  * MICBIAS1
> +  * IN1P
> +  * IN1R
> +  * IN2P
> +  * IN2R
> +  * HPOL
> +  * HPOR
> +  * LOUTL
> +  * LOUTR
> +  * SPOLP
> +  * SPOLN
> +  * SPORP
> +  * SPORN

The one difference is that RT5640 supports MONOP/N, which you could
handle by:

Pins on the device (for linking into audio routes) for RT5639/RT5640:

  * DMIC
  ...
  * SPORN

Additional pins on the device for RT5640:

  * MONOP
  * MONON

> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c

> @@ -2168,12 +2209,38 @@ static const struct i2c_device_id rt5640_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);
>  
> +static const struct i2c_device_id rt5639_i2c_id[] = {
> +	{ "rt5639", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, rt5640_i2c_id);

I thought you could put all the values into a single table, along with
some device-specific value which probe() could use to differentiate the
two if needed?

> +#if defined(CONFIG_OF)
> +static const struct of_device_id rt5640_of_match[] = {
> +	{ .compatible = "realtek,rt5640", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt5640_of_match);

That's already part of the file.

> +static const struct of_device_id rt5639_of_match[] = {
> +	{ .compatible = "realtek,rt5639", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, rt5639_of_match);
> +#endif

Same for of_match; just use a single table with multiple entries.

> +static struct acpi_device_id rt5639_acpi_match[] = {
> +	{ "INT33CA", 0 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, rt5639_acpi_match);
>  #endif

Same for ACPI, I hope.

> @@ -2293,8 +2360,18 @@ static int rt5640_i2c_probe(struct i2c_client *i2c,
>  
>  	rt5640->hp_mute = 1;
>  
> -	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_rt5640,
> -			rt5640_dai, ARRAY_SIZE(rt5640_dai));
> +	regmap_read(rt5640->regmap, RT5640_RESET, &val);
> +	switch (val) {
> +	case RT5640_RESET_ID:

It would be good to validate whether the RT5640_RESET register value
matches the name in the i2c/of/ACPI device table that matched, and at
least warn if they don't.

> @@ -2315,6 +2392,9 @@ static struct i2c_driver rt5640_i2c_driver = {
>  		.name = "rt5640",
>  		.owner = THIS_MODULE,
>  		.acpi_match_table = ACPI_PTR(rt5640_acpi_match),
> +#if defined(CONFIG_OF)
> +		.of_match_table = of_match_ptr(rt5640_of_match),
> +#endif

> -MODULE_DESCRIPTION("ASoC RT5640 driver");
> +static struct i2c_driver rt5639_i2c_driver = {
> +	.driver = {
> +		.name = "rt5639",
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(rt5639_acpi_match),
> +#if defined(CONFIG_OF)
> +		.of_match_table = of_match_ptr(rt5639_of_match),
> +#endif
> +	},
> +	.probe = rt5640_i2c_probe,
> +	.remove   = rt5640_i2c_remove,
> +	.id_table = rt5639_i2c_id,
> +};
> +module_i2c_driver(rt5639_i2c_driver);

I don't think you need a separate i2c_driver structure; just make the
existing one handle multiple devices.
