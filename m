From: Varka Bhadram <varkab-If5XQcfNmg0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: add es8328 codec driver
Date: Tue, 17 Jun 2014 17:18:21 +0530
Message-ID: <53A02B05.6090805@cdac.in>
References: <1402997571-1255-1-git-send-email-xobs@kosagi.com> <1402997571-1255-2-git-send-email-xobs@kosagi.com> <20140617104639.GD26741@opensource.wolfsonmicro.com> <53A02844.9050701@kosagi.com> <53A029A4.1020304@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A029A4.1020304-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Cc: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bunnie-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 06/17/2014 05:12 PM, Lars-Peter Clausen wrote:
> On 06/17/2014 01:36 PM, Sean Cross wrote:
>> On 06/17/14 18:46, Charles Keepax wrote:
>>> On Tue, Jun 17, 2014 at 05:32:50PM +0800, Sean Cross wrote:
>>>> Add a codec driver for the Everest ES8328.  It supports two 
>>>> separate audio
>>>> outputs and two separate audio inputs.
>>>>
>>>> Signed-off-by: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>   Documentation/devicetree/bindings/sound/es8328.txt |  18 +
>>>>   sound/soc/codecs/Kconfig                           |  13 +
>>>>   sound/soc/codecs/Makefile                          |   6 +
>>>>   sound/soc/codecs/es8328-i2c.c                      |  55 ++
>>>>   sound/soc/codecs/es8328-spi.c                      |  44 ++
>>>>   sound/soc/codecs/es8328.c                          | 625 
>>>> +++++++++++++++++++++
>>>>   sound/soc/codecs/es8328.h                          | 313 +++++++++++
>>>>   7 files changed, 1074 insertions(+)
>>>>   create mode 100644 
>>>> Documentation/devicetree/bindings/sound/es8328.txt
>>>>   create mode 100644 sound/soc/codecs/es8328-i2c.c
>>>>   create mode 100644 sound/soc/codecs/es8328-spi.c
>>>>   create mode 100644 sound/soc/codecs/es8328.c
>>>>   create mode 100644 sound/soc/codecs/es8328.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/sound/es8328.txt 
>>>> b/Documentation/devicetree/bindings/sound/es8328.txt
>>>> new file mode 100644
>>>> index 0000000..488bc32
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/sound/es8328.txt
>>>> @@ -0,0 +1,18 @@
>>>> +Everest ES8328 audio CODEC
>>>> +
>>>> +This device supports both I2C and SPI (configured with pin strapping
>>>> +on the board).
>>>> +
>>>> +Required properties:
>>>> +
>>>> +  - compatible : "es8328"
>>> I suspect the vendor prefix will be mandatory.
>>>
>>>> +
>>>> +  - reg : the I2C address of the device for I2C, the chip select
>>>> +          number for SPI.
>>>> +
>>>> +Example:
>>>> +
>>>> +codec: es8328@11 {
>>>> +    compatible = "es8328";
>>>> +    reg = <0x11>;
>>>> +};
>>>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>>>> index cbfa1e1..6a509e3 100644
>>>> --- a/sound/soc/codecs/Kconfig
>>>> +++ b/sound/soc/codecs/Kconfig
>>>> @@ -56,6 +56,8 @@ config SND_SOC_ALL_CODECS
>>>>       select SND_SOC_DA732X if I2C
>>>>       select SND_SOC_DA9055 if I2C
>>>>       select SND_SOC_BT_SCO
>>>> +    select SND_SOC_ES8328_SPI if SPI_MASTER
>>>> +    select SND_SOC_ES8328_I2C if I2C
>>>>       select SND_SOC_ISABELLE if I2C
>>>>       select SND_SOC_JZ4740_CODEC
>>>>       select SND_SOC_LM4857 if I2C
>>>> @@ -396,6 +398,17 @@ config SND_SOC_DMIC
>>>>   config SND_SOC_HDMI_CODEC
>>>>          tristate "HDMI stub CODEC"
>>>>
>>>> +config SND_SOC_ES8328
>>>> +    tristate "Everest Semi ES8328 CODEC"
>>>> +
>>>> +config SND_SOC_ES8328_I2C
>>>> +    tristate
>>>> +    select SND_SOC_ES8328
>>>> +
>>>> +config SND_SOC_ES8328_SPI
>>>> +    tristate
>>>> +    select SND_SOC_ES8328
>>>> +
>>>>   config SND_SOC_ISABELLE
>>>>           tristate
>>>>
>>>> diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
>>>> index be3377b..66e7859 100644
>>>> --- a/sound/soc/codecs/Makefile
>>>> +++ b/sound/soc/codecs/Makefile
>>>> @@ -48,6 +48,9 @@ snd-soc-da732x-objs := da732x.o
>>>>   snd-soc-da9055-objs := da9055.o
>>>>   snd-soc-bt-sco-objs := bt-sco.o
>>>>   snd-soc-dmic-objs := dmic.o
>>>> +snd-soc-es8328-objs := es8328.o
>>>> +snd-soc-es8328-i2c-objs := es8328-i2c.o
>>>> +snd-soc-es8328-spi-objs := es8328-spi.o
>>>>   snd-soc-isabelle-objs := isabelle.o
>>>>   snd-soc-jz4740-codec-objs := jz4740.o
>>>>   snd-soc-l3-objs := l3.o
>>>> @@ -213,6 +216,9 @@ obj-$(CONFIG_SND_SOC_DA732X)    += 
>>>> snd-soc-da732x.o
>>>>   obj-$(CONFIG_SND_SOC_DA9055)    += snd-soc-da9055.o
>>>>   obj-$(CONFIG_SND_SOC_BT_SCO)    += snd-soc-bt-sco.o
>>>>   obj-$(CONFIG_SND_SOC_DMIC)    += snd-soc-dmic.o
>>>> +obj-$(CONFIG_SND_SOC_ES8328)    += snd-soc-es8328.o
>>>> +obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
>>>> +obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
>>>>   obj-$(CONFIG_SND_SOC_ISABELLE)    += snd-soc-isabelle.o
>>>>   obj-$(CONFIG_SND_SOC_JZ4740_CODEC)    += snd-soc-jz4740-codec.o
>>>>   obj-$(CONFIG_SND_SOC_L3)    += snd-soc-l3.o
>>>> diff --git a/sound/soc/codecs/es8328-i2c.c 
>>>> b/sound/soc/codecs/es8328-i2c.c
>>>> new file mode 100644
>>>> index 0000000..0bb02d3
>>>> --- /dev/null
>>>> +++ b/sound/soc/codecs/es8328-i2c.c
>>>> @@ -0,0 +1,55 @@
>>>> +/*
>>>> + * es8328-i2c.c  --  ES8328 ALSA SoC I2C Audio driver
>>>> + *
>>>> + * Copyright 2014 Sutajio Ko-Usagi PTE LTD
>>>> + *
>>>> + * Author: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or 
>>>> modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/i2c.h>
>>>> +#include <linux/regmap.h>
>>>> +
>>>> +#include <sound/soc.h>
>>>> +
>>>> +#include "es8328.h"
>>>> +
>>>> +static const struct i2c_device_id es8328_id[] = {
>>>> +    { "es8328", 0 },
>>>> +    { }
>>>> +};
>>>> +MODULE_DEVICE_TABLE(i2c, es8328_id);
>>>> +
>>>> +static int es8328_i2c_probe(struct i2c_client *i2c,
>>>> +                const struct i2c_device_id *id)
>>>> +{
>>>> +    struct regmap_config config;
>>>> +
>>>> +    config = es8328_regmap_config;
>>>> +    return es8328_probe(&i2c->dev, devm_regmap_init_i2c(i2c, 
>>>> &config));
>>>> +}
>>>> +
>>>> +static int es8328_i2c_remove(struct i2c_client *i2c)
>>>> +{
>>>> +    snd_soc_unregister_codec(&i2c->dev);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static struct i2c_driver es8328_i2c_driver = {
>>>> +    .driver = {
>>>> +        .name = "es8328",
>>>> +    },
>>>> +    .probe    = es8328_i2c_probe,
>>>> +    .remove   = es8328_i2c_remove,
>>>> +    .id_table = es8328_id,
>>>> +};
>>>> +
>>>> +module_i2c_driver(es8328_i2c_driver);
>>>> +
>>>> +MODULE_DESCRIPTION("ASoC ES8328 audio CODEC I2C driver");
>>>> +MODULE_AUTHOR("Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>");
>>>> +MODULE_LICENSE("GPL");
>>>> diff --git a/sound/soc/codecs/es8328-spi.c 
>>>> b/sound/soc/codecs/es8328-spi.c
>>>> new file mode 100644
>>>> index 0000000..28433e7
>>>> --- /dev/null
>>>> +++ b/sound/soc/codecs/es8328-spi.c
>>>> @@ -0,0 +1,44 @@
>>>> +/*
>>>> + * es8328.c  --  ES8328 ALSA SoC SPI Audio driver
>>>> + *
>>>> + * Copyright 2014 Sutajio Ko-Usagi PTE LTD
>>>> + *
>>>> + * Author: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or 
>>>> modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/regmap.h>
>>>> +#include <linux/spi/spi.h>
>>>> +#include <sound/soc.h>
>>>> +#include "es8328.h"
>>>> +
>>>> +static int es8328_spi_probe(struct spi_device *spi)
>>>> +{
>>>> +    struct regmap_config config;
>>>> +
>>>> +    config = es8328_regmap_config;
>>>> +    return es8328_probe(&spi->dev, devm_regmap_init_spi(spi, 
>>>> &config));
>>>> +}
>>>> +
>>>> +static int es8328_spi_remove(struct spi_device *spi)
>>>> +{
>>>> +    snd_soc_unregister_codec(&spi->dev);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static struct spi_driver es8328_spi_driver = {
>>>> +    .driver = {
>>>> +        .name    = "es8328",
>>>> +    },
>>>> +    .probe    = es8328_spi_probe,
>>>> +    .remove    = es8328_spi_remove,
>>>> +};
>>> Your of_match_table seems to have gone missing since the last
>>> version I suspect that is why you had trouble with the vendor
>>> prefix. Ditto for the I2C as well.
>> I was basing the driver off the 6c3d713e6d32706999689e379a9098afb4cd8a2c
>> commit mentioned in the previous comment.  In that commit, there is an
>> id_table in ad193x-i2c.c.  ad193x.c doesn't have an of_match_table,
>> which makes sense because I'm trying to load the I2C device.
>
> The ad1936 drivers does not have devicetree support, this is why it 
> does not have a of_match_table.
>
>>
>> I see now that of_match_table is distinct from the id_table.  I assumed
>> the I2C bus would walk the i2c_driver's id_table and load it that way.
>>
>> How should this work, then?  Should I specify the same "everest,es8328"
>> compatible array to both the I2C and the SPI driver, and let the
>> different buses sort it out?
>
> Yes.
>
>> Also, for my own curiosity, what is the difference between the I2C
>> id_table and the generic driver of_match_table?
>
> One is used for matching devices that are registered via the 
> devicetree and the other is used for matching devices that have been 
> registered via the in-kernel APIs, e.g. i2c_register_board_info (It 
> can also match devices registered via the devicetree, but does not 
> take the vendor prefix into account). The reason why there are two 
> ways to match a device is mostly history and there are some efforts in 
> progress to unify this.
>
adding to the above explanation [0] will give example for DT and NON-DT 
supported platforms.

> - :ars
>
[0] : 
http://stackoverflow.com/questions/19244847/from-where-platform-device-gets-it-name

Thanks,
Varka Bhadram

-------------------------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
-------------------------------------------------------------------------------------------------------------------------------

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
