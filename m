From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v3 1/3] ASoC: pcm179x: Split into core and
	SPI parts
Date: Thu, 21 Jan 2016 17:27:58 +0100
Message-ID: <CAOf5uwny3Rz6ctUs1wGkcvhPykFENnniC=Jq9jGBfhJG398yug@mail.gmail.com>
References: <1453390018-16854-1-git-send-email-jacob@teenage.engineering>
 <1453390018-16854-2-git-send-email-jacob@teenage.engineering>
 <20160121153615.GJ31514@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 1621C26062B
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 17:28:01 +0100 (CET)
Received: by mail-ig0-f178.google.com with SMTP id z14so129301089igp.1
 for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2016 08:28:00 -0800 (PST)
In-Reply-To: <20160121153615.GJ31514@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johan Hovold <johan@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Jacob Siverskog <jacob@teenage.engineering>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Thu, Jan 21, 2016 at 4:36 PM, Johan Hovold <johan@kernel.org> wrote:
> On Thu, Jan 21, 2016 at 04:26:56PM +0100, Jacob Siverskog wrote:
>> The pcm179x family supports both SPI and I2C for configuration. This
>> patch splits the driver into core and SPI parts, in preparation for
>> I2C support.
>>
>> Reviewed-by: Johan Hovold <johan@kernel.org>
>> Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
>> ---
>
>> diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
>> new file mode 100644
>> index 0000000..5842add9
>> --- /dev/null
>> +++ b/sound/soc/codecs/pcm179x-spi.c
>> @@ -0,0 +1,63 @@
>> +/*
>> + * PCM179X ASoC SPI driver
>> + *
>> + * Copyright (c) Amarula Solutions B.V. 2013
>> + *
>> + *     Michael Trimarchi <michael@amarulasolutions.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "pcm179x.h"
>> +
>> +static int pcm179x_spi_probe(struct spi_device *spi)
>> +{
>> +     return pcm179x_common_init(&spi->dev,
>> +                     devm_regmap_init_spi(spi, &pcm179x_regmap_config));
>> +}
>> +
>
>> -static int pcm179x_spi_probe(struct spi_device *spi)
>> +int pcm179x_common_init(struct device *dev, struct regmap *regmap)
>>  {
>>       struct pcm179x_private *pcm179x;
>>       int ret;
>>
>> -     pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
>> +     if (IS_ERR(regmap)) {
>> +             ret = PTR_ERR(regmap);
>> +             dev_err(dev, "Failed to register regmap: %d\n", ret);
>> +             return ret;
>> +     }
>
> This looks weird. I think you should check for error where you do the
> allocation even if this means a four more lines of code in total.
>

agree on that

>> +
>> +     pcm179x = devm_kzalloc(dev, sizeof(struct pcm179x_private),
>>                               GFP_KERNEL);
>>       if (!pcm179x)
>>               return -ENOMEM;
>>
>> -     spi_set_drvdata(spi, pcm179x);
>> -
>> -     pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
>> -     if (IS_ERR(pcm179x->regmap)) {
>> -             ret = PTR_ERR(pcm179x->regmap);
>> -             dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
>> -             return ret;
>> -     }
>> +     pcm179x->regmap = regmap;
>> +     dev_set_drvdata(dev, pcm179x);
>>

snd_soc_codec_set_drvdata

Is this more "codec" like?

Michael

>> -     return snd_soc_register_codec(&spi->dev,
>> +     return snd_soc_register_codec(dev,
>>                       &soc_codec_dev_pcm179x, &pcm179x_dai, 1);
>>  }
>
> Thanks,
> Johan



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
