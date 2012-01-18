From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: add driver for max9768 amplifier
Date: Wed, 18 Jan 2012 18:24:44 +0100
Message-ID: <4F17005C.9000507@metafoo.de>
References: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-107.synserver.de (smtp-out-114.synserver.de
	[212.40.185.114]) by alsa0.perex.cz (Postfix) with SMTP id 9645B24685
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 18:23:54 +0100 (CET)
In-Reply-To: <1326901108-3435-1-git-send-email-w.sang@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 01/18/2012 04:38 PM, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
[...]
> diff --git a/sound/soc/codecs/max9768.c b/sound/soc/codecs/max9768.c
> new file mode 100644
> index 0000000..bd57b45
> --- /dev/null
> +++ b/sound/soc/codecs/max9768.c
> @@ -0,0 +1,244 @@
> +/*
> + * MAX9768 AMP driver
> + *
> + * Copyright (C) 2011, 2012 by Wolfram Sang, Pengutronix e.K.
> + *   based on lm4857.c by Lars-Peter Clausen et al.

That driver is a bit older, so some of the issues mentioned below also apply
to that driver, I'll see if I can get it updated.

> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/gpio.h>
> +
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/tlv.h>
> +#include <sound/max9768.h>
> +
> +/* The register offsets in the cache array */
> +#define MAX9768_VOL 0
> +#define MAX9768_CTRL 3
> +
> +/* Commands */
> +#define MAX9768_CTRL_PWM 0x15
> +#define MAX9768_CTRL_FILTERLESS 0x16
> +
> +struct max9768 {
> +	struct i2c_client *client;
> +	int mute_gpio;
> +	int shdn_gpio;

The shutdown gpio is requested, but never used.

> +	u32 flags;
> +};
> +
> +static const uint8_t max9768_default_regs[] = {
> +	0x00, 0x00, 0x00, MAX9768_CTRL_FILTERLESS,
> +};
> +
> +static int max9768_write(struct snd_soc_codec *codec, unsigned int reg,
> +		unsigned int value)
> +{
> +	uint8_t data;
> +	int ret;
> +
> +	ret = snd_soc_cache_write(codec, reg, value);
> +	if (ret < 0)
> +		return ret;
> +
> +	data = (reg << 6) | value;


Adding support for this register type to regmap and use regmap then is the
way to go. regmap should also be used for the cache instead of the legacy
ASoC cache.

> +	ret = i2c_smbus_write_byte(codec->control_data, data);
> +	if (ret)
> +		dev_err(codec->dev, "Failed to write register: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +
> [...]
> +
> +static int max9768_probe(struct snd_soc_codec *codec)
> +{
> +	struct max9768 *max9768 = snd_soc_codec_get_drvdata(codec);
> +	int ret;
> +
> +	codec->control_data = max9768->client;
> +
> +	if (max9768->flags & MAX9768_FLAG_CLASSIC_PWM) {
> +		ret = snd_soc_write(codec, MAX9768_CTRL, MAX9768_CTRL_PWM);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = snd_soc_add_controls(codec, max9768_volume,
> +			ARRAY_SIZE(max9768_volume));
> +	if (ret)
> +		return ret;

Use the controls/num_controls fields of your codec_driver to register these
controls.

> +
> +	if (max9768->mute_gpio >= 0) {
> +		ret = snd_soc_add_controls(codec, max9768_mute,
> +				ARRAY_SIZE(max9768_mute));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_codec_driver soc_codec_dev_max9768 = {

max9768_codec_driver would be a better name.

> +	.write = max9768_write,
> +	.read = max9768_read,
> +	.probe = max9768_probe,
> +	.reg_cache_size = ARRAY_SIZE(max9768_default_regs),
> +	.reg_word_size = sizeof(uint8_t),
> +	.reg_cache_default = max9768_default_regs,
> +};
> +
> +static int __devinit max9768_i2c_probe(struct i2c_client *client,
> +	const struct i2c_device_id *id)
> +{
> +	struct max9768 *max9768;
> +	struct max9768_pdata *pdata = client->dev.platform_data;
> +	int err;
> +
> +	max9768 = devm_kzalloc(&client->dev, sizeof(*max9768), GFP_KERNEL);
> +	if (!max9768)
> +		return -ENOMEM;
> +
> +	if (pdata) {
> +		/* Mute on powerup to avoid clicks */
> +		err = gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 Mute");
> +		max9768->mute_gpio = err ?: pdata->mute_gpio;
> +
> +		/* Activate chip, enabling I2C */
> +		err = gpio_request_one(pdata->shdn_gpio, GPIOF_INIT_HIGH, "MAX9768 Shutdown");
> +		max9768->shdn_gpio = err ?: pdata->shdn_gpio;
> +
> +		max9768->flags = pdata->flags;
> +	} else {
> +		max9768->shdn_gpio = -EINVAL;
> +		max9768->mute_gpio = -EINVAL;
> +	}
> +
> +	max9768->client = client;
> +	i2c_set_clientdata(client, max9768);
> +
> +	return snd_soc_register_codec(&client->dev, &soc_codec_dev_max9768, NULL, 0);

GPIOs are not freed in case of an error.

> +}
> +
> +static int __devexit max9768_i2c_remove(struct i2c_client *client)
> +{
> +	snd_soc_unregister_codec(&client->dev);


GPIOs are never freed.

> +	return 0;
> +}
> +
