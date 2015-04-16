From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: tas571x: New driver for TI TAS571x
 power amplifiers
Date: Thu, 16 Apr 2015 14:57:49 +0200
Message-ID: <552FB1CD.3040401@metafoo.de>
References: <1429134141-17924-1-git-send-email-cernekee@chromium.org> <1429134141-17924-2-git-send-email-cernekee@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1429134141-17924-2-git-send-email-cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 04/15/2015 11:42 PM, Kevin Cernekee wrote:
> Introduce a new codec driver for the Texas Instruments
> TAS5711/TAS5717/TAS5719 power amplifier chips.  These chips are typically
> used to take an I2S digital audio input and drive 10-20W into a pair of
> speakers.
>
> Signed-off-by: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Looks pretty good. Comments inlune.

[...]
> -obj-$(CONFIG_SND_SOC_TAS5086)	+= snd-soc-tas5086.o

Accidentally removed line

> +obj-$(CONFIG_SND_SOC_TAS571X)	+= snd-soc-tas571x.o
[...]
> +++ b/sound/soc/codecs/tas571x.c
> @@ -0,0 +1,456 @@
> +/*
> + * TAS571x amplifier audio driver
> + *
> + * Copyright (C) 2015 Google, Inc.
> + * Copyright (c) 2013 Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>

There is no of specific GPIO code in the driver.

[...]
> +
> +static int tas571x_set_bias_level(struct snd_soc_codec *codec,
> +				  enum snd_soc_bias_level level)
> +{
> +	struct tas571x_private *priv = snd_soc_codec_get_drvdata(codec);
> +	int ret, assert_pdn = 0;
> +
> +	if (priv->bias_level == level)
> +		return 0;

The core already takes care that this function is only called if there is a 
actual change.

> +
> +	switch (level) {
> +	case SND_SOC_BIAS_PREPARE:
> +		if (!IS_ERR(priv->mclk)) {
> +			ret = clk_prepare_enable(priv->mclk);
> +			if (ret) {
> +				dev_err(codec->dev,
> +					"Failed to enable master clock\n");
> +				return ret;
> +			}
> +		}
> +
> +		ret = tas571x_set_shutdown(priv, false);
> +		if (ret)
> +			return ret;
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +		ret = tas571x_set_shutdown(priv, true);
> +		if (ret)
> +			return ret;
> +
> +		if (!IS_ERR(priv->mclk))
> +			clk_disable_unprepare(priv->mclk);
> +		break;
> +	case SND_SOC_BIAS_ON:
> +		break;
> +	case SND_SOC_BIAS_OFF:
> +		/* Note that this kills I2C accesses. */
> +		assert_pdn = 1;
> +		break;
> +	}
> +
> +	if (!IS_ERR(priv->pdn_gpio))
> +		gpiod_set_value(priv->pdn_gpio, !assert_pdn);
> +
> +	priv->bias_level = level;

This should update codec->dapm.bias_level, otherwise the core will become 
confused about the actual level.

> +	return 0;
> +}
> +
[...]
> +static const unsigned int tas5711_volume_tlv[] = {
> +	TLV_DB_RANGE_HEAD(1),
> +	0, 0xff, TLV_DB_SCALE_ITEM(-10350, 50, 1),
> +};

For TLVs with a single item use DECLARE_TLV_DB_SCALE()

> +
[...]
> +static const unsigned int tas5717_volume_tlv[] = {
> +	TLV_DB_RANGE_HEAD(1),
> +	0x000, 0x1ff, TLV_DB_SCALE_ITEM(-10375, 25, 0),
> +};

Same here.

[...]
> +static int tas571x_i2c_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct tas571x_private *priv;
> +	struct device *dev = &client->dev;
> +	int i;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	i2c_set_clientdata(client, priv);
> +
> +	priv->mclk = devm_clk_get(dev, "mclk");
> +	if (PTR_ERR(priv->mclk) == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

If you want to make the clock optional use

	if (PTR_ERR(priv->mclk) == -ENOENT)
		return PTR_ERR(priv->mclk);

This makes sure that the case where the clock is specified, but there is a 
error with the specification (e.g. incorrect DT cells) is handled properly.

> +
> +	for (i = 0; i < TAS571X_NUM_SUPPLIES; i++)
> +		priv->supplies[i].supply = tas571x_supply_names[i];
> +
> +	/*
> +	 * This will fall back to the dummy regulator if nothing is specified
> +	 * in DT.
> +	 */
> +	if (devm_regulator_bulk_get(dev, TAS571X_NUM_SUPPLIES,
> +				    priv->supplies)) {

Move the function outside the if condition and also pass the error condition 
to the caller. (And print it)

> +		dev_err(dev, "Failed to get supplies\n");
> +		return -EINVAL;
> +	}
> +	if (regulator_bulk_enable(TAS571X_NUM_SUPPLIES, priv->supplies)) {

Same here.

> +		dev_err(dev, "Failed to enable supplies\n");
> +		return -EINVAL;
> +	}
> +
> +	priv->regmap = devm_regmap_init(dev, NULL, client, &tas571x_regmap);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->pdn_gpio = devm_gpiod_get(dev, "pdn");

devm_gpiod_get_optional() ?

Using gpiod_get without specifying the direction flags is deprecated. Should be

... = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

and then drop the gpiod_direction_output().


> +	if (!IS_ERR(priv->pdn_gpio)) {
> +		gpiod_direction_output(priv->pdn_gpio, 1);
> +	} else if (PTR_ERR(priv->pdn_gpio) != -ENOENT &&
> +		   PTR_ERR(priv->pdn_gpio) != -ENOSYS) {
> +		dev_warn(dev, "error requesting pdn_gpio: %ld\n",
> +			 PTR_ERR(priv->pdn_gpio));

If the GPIO can't be requested and it is not a optional GPIO that should be 
treated as an error.

> +	}
> +
> +	priv->reset_gpio = devm_gpiod_get(dev, "reset");

Same as for the pdn_gpio.

> +	if (!IS_ERR(priv->reset_gpio)) {
> +		gpiod_direction_output(priv->reset_gpio, 0);
> +		usleep_range(100, 200);
> +		gpiod_set_value(priv->reset_gpio, 1);
> +		usleep_range(12000, 20000);
> +	} else if (PTR_ERR(priv->reset_gpio) != -ENOENT &&
> +		   PTR_ERR(priv->reset_gpio) != -ENOSYS) {
> +		dev_warn(dev, "error requesting reset_gpio: %ld\n",
> +			 PTR_ERR(priv->reset_gpio));

Same as for the pdn_gpio.

> +	}
> +
> +	priv->bias_level = SND_SOC_BIAS_STANDBY;
> +
> +	if (regmap_write(priv->regmap, TAS571X_OSC_TRIM_REG, 0))
> +		return -EIO;
> +
> +	if (tas571x_set_shutdown(priv, true))
> +		return -EIO;
> +
> +	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
> +	priv->dev_id = id->driver_data;
> +
> +	switch (id->driver_data) {
> +	case TAS571X_ID_5711:
> +		priv->codec_driver.controls = tas5711_controls;
> +		priv->codec_driver.num_controls = ARRAY_SIZE(tas5711_controls);
> +		break;
> +	case TAS571X_ID_5717:
> +	case TAS571X_ID_5719:
> +		priv->codec_driver.controls = tas5717_controls;
> +		priv->codec_driver.num_controls = ARRAY_SIZE(tas5717_controls);
> +
> +		/*
> +		 * The master volume defaults to 0x3ff (mute), but we ignore
> +		 * (zero) the LSB because the hardware step size is 0.125 dB
> +		 * and TLV_DB_SCALE_ITEM has a resolution of 0.01 dB.
> +		 */
> +		if (regmap_write(priv->regmap, TAS571X_MVOL_REG, 0x3fe))
> +			return -EIO;
> +
> +		break;
> +	}

Typically when a driver supports multiple chips with different control sets 
the snd_soc_codec_driver implements a probe callback in which the correct 
controls are registered.

> +
> +	return snd_soc_register_codec(&client->dev, &priv->codec_driver,
> +				      &tas571x_dai, 1);
> +}
> +
[...]
> +
> +static const struct of_device_id tas571x_of_match[] = {
> +	{ .compatible = "ti,tas5711", },
> +	{ .compatible = "ti,tas5717", },
> +	{ .compatible = "ti,tas5719", },

You should also specify the id data for the of table and get it from the 
of_data if of_node is non NULL in the probe function. I know that it works 
without, but that is a bit of a unintentional side-effect and might change 
in the future.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tas571x_of_match);
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
