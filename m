From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 2/3] ASoC: pcm179x: Add I2C interface driver
Date: Mon, 18 Jan 2016 17:14:42 +0100
Message-ID: <CAOf5uwnEuUPdUn5hdpX2VytDb8qHP8c56ipEM+Qsu7q_zWGbEw@mail.gmail.com>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
 <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D93B4261A28
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 17:14:42 +0100 (CET)
Received: by mail-ig0-f169.google.com with SMTP id t15so58607823igr.0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 08:14:42 -0800 (PST)
In-Reply-To: <1453132657-18678-3-git-send-email-jacob@teenage.engineering>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jacob Siverskog <jacob@teenage.engineering>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Johan Hovold <johan@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Mon, Jan 18, 2016 at 4:57 PM, Jacob Siverskog
<jacob@teenage.engineering> wrote:
> The PCM179x family supports both SPI and I2C. This patch adds support
> for the I2C interface.
>
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> ---
>  .../devicetree/bindings/sound/pcm179x.txt          | 11 ++-
>  sound/soc/codecs/Kconfig                           |  9 +++
>  sound/soc/codecs/Makefile                          |  2 +
>  sound/soc/codecs/pcm179x-i2c.c                     | 82 ++++++++++++++++++++++
>  4 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 sound/soc/codecs/pcm179x-i2c.c
>
> diff --git a/Documentation/devicetree/bindings/sound/pcm179x.txt b/Documentation/devicetree/bindings/sound/pcm179x.txt
> index 4ae70d3..436c2b2 100644
> --- a/Documentation/devicetree/bindings/sound/pcm179x.txt
> +++ b/Documentation/devicetree/bindings/sound/pcm179x.txt
> @@ -1,6 +1,6 @@
>  Texas Instruments pcm179x DT bindings
>
> -This driver supports the SPI bus.
> +This driver supports both the I2C and SPI bus.
>
>  Required properties:
>
> @@ -9,6 +9,11 @@ Required properties:
>  For required properties on SPI, please consult
>  Documentation/devicetree/bindings/spi/spi-bus.txt
>
> +Required properties on I2C:
> +
> + - reg: the I2C address
> +

I think that you have an extra space here

> +
>  Examples:
>
>         codec_spi: 1792a@0 {
> @@ -16,3 +21,7 @@ Examples:
>                 spi-max-frequency = <600000>;
>         };
>
> +       codec_i2c: 1792a@4c {
> +               compatible = "ti,pcm1792a";
> +               reg = <0x4c>;
> +       };


> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index eaf13cb..45269cc 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -87,6 +87,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_ML26124 if I2C
>         select SND_SOC_NAU8825 if I2C
>         select SND_SOC_PCM1681 if I2C
> +       select SND_SOC_PCM179X_I2C if I2C
>         select SND_SOC_PCM179X_SPI if SPI_MASTER
>         select SND_SOC_PCM3008
>         select SND_SOC_PCM3168A_I2C if I2C
> @@ -529,6 +530,14 @@ config SND_SOC_PCM1681
>  config SND_SOC_PCM179X
>         tristate
>
> +config SND_SOC_PCM179X_I2C
> +       tristate "Texas Instruments PCM179X CODEC family (I2C)"
> +       depends on I2C
> +       select SND_SOC_PCM179X
> +       help
> +         Enable support for Texas Instruments PCM179x CODEC family.
> +         Select this if your PCM179x is connected via an I2C bus.
> +
>  config SND_SOC_PCM179X_SPI
>         tristate "Texas Instruments PCM179X CODEC family (SPI)"
>         depends on SPI_MASTER
> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
> index 56e94d8..9acd777 100644
> --- a/sound/soc/codecs/Makefile
> +++ b/sound/soc/codecs/Makefile
> @@ -81,6 +81,7 @@ snd-soc-ml26124-objs := ml26124.o
>  snd-soc-nau8825-objs := nau8825.o
>  snd-soc-pcm1681-objs := pcm1681.o
>  snd-soc-pcm179x-codec-objs := pcm179x.o
> +snd-soc-pcm179x-i2c-objs := pcm179x-i2c.o
>  snd-soc-pcm179x-spi-objs := pcm179x-spi.o
>  snd-soc-pcm3008-objs := pcm3008.o
>  snd-soc-pcm3168a-objs := pcm3168a.o
> @@ -286,6 +287,7 @@ obj-$(CONFIG_SND_SOC_ML26124)       += snd-soc-ml26124.o
>  obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
>  obj-$(CONFIG_SND_SOC_PCM1681)  += snd-soc-pcm1681.o
>  obj-$(CONFIG_SND_SOC_PCM179X)  += snd-soc-pcm179x-codec.o
> +obj-$(CONFIG_SND_SOC_PCM179X_I2C)      += snd-soc-pcm179x-i2c.o
>  obj-$(CONFIG_SND_SOC_PCM179X_SPI)      += snd-soc-pcm179x-spi.o
>  obj-$(CONFIG_SND_SOC_PCM3008)  += snd-soc-pcm3008.o
>  obj-$(CONFIG_SND_SOC_PCM3168A) += snd-soc-pcm3168a.o
> diff --git a/sound/soc/codecs/pcm179x-i2c.c b/sound/soc/codecs/pcm179x-i2c.c
> new file mode 100644
> index 0000000..0b20870
> --- /dev/null
> +++ b/sound/soc/codecs/pcm179x-i2c.c
> @@ -0,0 +1,82 @@
> +/*
> + * PCM179X ASoC I2C driver
> + *
> + * Copyright (c) Teenage Engineering AB 2016
> + *
> + *     Jacob Siverskog <jacob@teenage.engineering>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +#include "pcm179x.h"
> +
> +static int pcm179x_i2c_probe(struct i2c_client *client,
> +                             const struct i2c_device_id *id)
> +{
> +       struct pcm179x_private *pcm179x;
> +       int ret;
> +
> +       pcm179x = devm_kzalloc(&client->dev, sizeof(struct pcm179x_private),
> +                               GFP_KERNEL);
> +       if (!pcm179x)
> +               return -ENOMEM;
> +
> +       i2c_set_clientdata(client, pcm179x);
> +
> +       pcm179x->dev = &client->dev;
> +
> +       pcm179x->regmap = devm_regmap_init_i2c(client, &pcm179x_regmap_config);
> +       if (IS_ERR(pcm179x->regmap)) {
> +               ret = PTR_ERR(pcm179x->regmap);
> +               dev_err(&client->dev, "Failed to register regmap: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return pcm179x_common_init(pcm179x);
> +}
> +
> +static int pcm179x_i2c_remove(struct i2c_client *client)
> +{
> +       return pcm179x_common_exit(i2c_get_clientdata(client));
> +}
> +
> +const struct of_device_id pcm179x_of_match[] = {
> +       { .compatible = "ti,pcm1792a", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, pcm179x_of_match);
> +

can match go in the common part?

> +static const struct i2c_device_id pcm179x_i2c_ids[] = {
> +       { "pcm179x", 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, pcm179x_i2c_ids);
> +
> +static struct i2c_driver pcm179x_i2c_driver = {
> +       .driver = {
> +               .name   = "pcm179x",
> +               .of_match_table = of_match_ptr(pcm179x_of_match),
> +       },
> +       .id_table       = pcm179x_i2c_ids,
> +       .probe          = pcm179x_i2c_probe,
> +       .remove         = pcm179x_i2c_remove,
> +};
> +
> +module_i2c_driver(pcm179x_i2c_driver);
> +
> +MODULE_DESCRIPTION("ASoC PCM179X I2C driver");
> +MODULE_AUTHOR("Jacob Siverskog <jacob@teenage.engineering>");
> +MODULE_LICENSE("GPL");
> --
> 2.7.0
>



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
