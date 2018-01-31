From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Date: Wed, 31 Jan 2018 14:20:31 -0200
Message-ID: <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1517403459-6668-1-git-send-email-daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cosmin.samoila-3arQi8VN3Tc@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Wed, Jan 31, 2018 at 10:57 AM, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org> wrote:
> AK5558 is a 32-bit, 768 kHZ sampling, differential input ADC
> for digital audio systems.
>
> Datasheet is available at:
>
> https://www.akm.com/akm/en/file/datasheet/AK5558VN.pdf
>
> Initial patch includes support for normal and TDM modes.
>
> Signed-off-by: Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>
> Signed-off-by: Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Shengjiu Wang <shengjiu.wang-3arQi8VN3Tc@public.gmane.org>
> Signed-off-by: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/sound/ak5558.txt |  20 +
>  sound/soc/codecs/Kconfig                           |   6 +
>  sound/soc/codecs/Makefile                          |   2 +
>  sound/soc/codecs/ak5558.c                          | 754 +++++++++++++++++++++
>  sound/soc/codecs/ak5558.h                          |  60 ++
>  5 files changed, 842 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak5558.txt

Maybe you should split this is as a separate patch and send it to dt
maintainer for review.

>  create mode 100644 sound/soc/codecs/ak5558.c
>  create mode 100644 sound/soc/codecs/ak5558.h
>
> diff --git a/Documentation/devicetree/bindings/sound/ak5558.txt b/Documentation/devicetree/bindings/sound/ak5558.txt
> new file mode 100644
> index 0000000..c6c71af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak5558.txt
> @@ -0,0 +1,20 @@
> +AK5558 8 channel differential 32-bit delta-sigma ADC
> +
> +This device supports I2C mode only.
> +
> +Required properties:
> +
> +- compatible : "asahi-kasei,ak5558"
> +- reg : The I2C address of the device for I2C.
> +- asahi-kasei,pdn-gpios: A GPIO specifier for the GPIO controlling
> +       the power down & reset pin.
> +
> +Example:
> +
> +&i2c {
> +       ak5558: ak5558@10 {
> +               compatible = "asahi-kasei,ak5558";
> +               reg = <0x10>;
> +               asahi-kasei,pdn-gpios = <&gpio1 10 GPIO_ACTIVE_HIGH>;

Datasheet says it is active low.

The driver seems to ignore the GPIO polarity, but device tree should
represent the hardware correctly.

Better switch the driver to use gpiod API.

> --- /dev/null
> +++ b/sound/soc/codecs/ak5558.c
> @@ -0,0 +1,754 @@
> +/*
> + * ak5558.c  --  audio driver for AK5558 ADC
> + *
> + * Copyright (C) 2015 Asahi Kasei Microdevices Corporation
> + * Copyright 2018 NXP
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You could use SPDX identifier and get rid of the license text.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/gpio/consumer.h>
> +#include <sound/soc.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/initval.h>
> +#include <sound/tlv.h>
> +#include <linux/of_gpio.h>
> +#include <linux/regmap.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "ak5558.h"
> +
> +#define AK5558_SLAVE_CKS_AUTO

Why is this define needed?

> +
> +static int ak5558_set_mcki(struct snd_soc_codec *codec, int fs, int rclk)
> +{
> +       u8  mode;
> +#ifndef AK5558_SLAVE_CKS_AUTO
> +       int mcki_rate;
> +#endif

You could drop this variable as AK5558_SLAVE_CKS_AUTO seems to be
always defined.

Then maybe you could remove mcki_rate and AK5558_SLAVE_CKS_AUTO.

> +static int ak5558_startup(struct snd_pcm_substream *substream,
> +                         struct snd_soc_dai *dai)
> +{
> +       int ret;
> +
> +       ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
> +                                        SNDRV_PCM_HW_PARAM_RATE,
> +                                        &ak5558_rate_constraints);
> +       return ret;

You could simply return directly without using the variable 'ret'.

> +static int ak5558_init_reg(struct snd_soc_codec *codec)
> +{
> +       int  ret;
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +
> +       dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);
> +
> +       usleep_range(10000, 11000);
> +       if (gpio_is_valid(ak5558->pdn_gpio)) {
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 0);
> +               usleep_range(1000, 2000);
> +               gpio_set_value_cansleep(ak5558->pdn_gpio, 1);

Here the GPIO polarity is hardcoded, which can cause issues in systems
that has an inverter in this GPIO line.

One more generic approach would be to use gpiod_set_value_cansleep()
instead, which takes the GPIO polarity read from device tree.

> +static int ak5558_probe(struct snd_soc_codec *codec)
> +{
> +       struct ak5558_priv *ak5558 = snd_soc_codec_get_drvdata(codec);
> +       int ret = 0;
> +
> +       dev_dbg(codec->dev, "%s(%d)\n", __func__, __LINE__);

Better to remove such dev_dbg() lines.

> +static int ak5558_i2c_probe(struct i2c_client *i2c,
> +                           const struct i2c_device_id *id)
> +{
> +       struct device_node *np = i2c->dev.of_node;
> +       struct ak5558_priv *ak5558;
> +       int ret = 0;
> +
> +       dev_err(&i2c->dev, "%s(%d)\n", __func__, __LINE__);

You certainly do not want an error message on every probe :-)

> +       ak5558 = devm_kzalloc(&i2c->dev, sizeof(struct ak5558_priv),
> +                             GFP_KERNEL);
> +       if (!ak5558)
> +               return -ENOMEM;
> +
> +       ak5558->regmap = devm_regmap_init_i2c(i2c, &ak5558_regmap);
> +       if (IS_ERR(ak5558->regmap))
> +               return PTR_ERR(ak5558->regmap);
> +
> +       i2c_set_clientdata(i2c, ak5558);
> +       ak5558->i2c = i2c;
> +
> +       ak5558->pdn_gpio = of_get_named_gpio(np, "ak5558,pdn-gpio", 0);

It does not match the property in the binding doc: asahi-kasei,pdn-gpios

> +module_i2c_driver(ak5558_i2c_driver);
> +
> +MODULE_AUTHOR("Junichi Wakasugi <wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org>");
> +MODULE_AUTHOR("Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>");
> +MODULE_DESCRIPTION("ASoC AK5558 ADC driver");
> +MODULE_LICENSE("GPL");

Don't you mean MODULE_LICENSE("GPL v2") instead?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
