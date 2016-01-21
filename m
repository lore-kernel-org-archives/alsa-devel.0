From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 1/3] ASoC: pcm179x: Split into core and SPI parts
Date: Thu, 21 Jan 2016 16:36:15 +0100
Message-ID: <20160121153615.GJ31514@localhost>
References: <1453390018-16854-1-git-send-email-jacob@teenage.engineering>
 <1453390018-16854-2-git-send-email-jacob@teenage.engineering>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453390018-16854-2-git-send-email-jacob@teenage.engineering>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Siverskog <jacob@teenage.engineering>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Michael Trimarchi <michael@amarulasolutions.com>, Johan Hovold <johan@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2016 at 04:26:56PM +0100, Jacob Siverskog wrote:
> The pcm179x family supports both SPI and I2C for configuration. This
> patch splits the driver into core and SPI parts, in preparation for
> I2C support.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
> ---

> diff --git a/sound/soc/codecs/pcm179x-spi.c b/sound/soc/codecs/pcm179x-spi.c
> new file mode 100644
> index 0000000..5842add9
> --- /dev/null
> +++ b/sound/soc/codecs/pcm179x-spi.c
> @@ -0,0 +1,63 @@
> +/*
> + * PCM179X ASoC SPI driver
> + *
> + * Copyright (c) Amarula Solutions B.V. 2013
> + *
> + *     Michael Trimarchi <michael@amarulasolutions.com>
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
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +
> +#include "pcm179x.h"
> +
> +static int pcm179x_spi_probe(struct spi_device *spi)
> +{
> +	return pcm179x_common_init(&spi->dev,
> +			devm_regmap_init_spi(spi, &pcm179x_regmap_config));
> +}
> +
  
> -static int pcm179x_spi_probe(struct spi_device *spi)
> +int pcm179x_common_init(struct device *dev, struct regmap *regmap)
>  {
>  	struct pcm179x_private *pcm179x;
>  	int ret;
>  
> -	pcm179x = devm_kzalloc(&spi->dev, sizeof(struct pcm179x_private),
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err(dev, "Failed to register regmap: %d\n", ret);
> +		return ret;
> +	}

This looks weird. I think you should check for error where you do the
allocation even if this means a four more lines of code in total.

> +
> +	pcm179x = devm_kzalloc(dev, sizeof(struct pcm179x_private),
>  				GFP_KERNEL);
>  	if (!pcm179x)
>  		return -ENOMEM;
>  
> -	spi_set_drvdata(spi, pcm179x);
> -
> -	pcm179x->regmap = devm_regmap_init_spi(spi, &pcm179x_regmap);
> -	if (IS_ERR(pcm179x->regmap)) {
> -		ret = PTR_ERR(pcm179x->regmap);
> -		dev_err(&spi->dev, "Failed to register regmap: %d\n", ret);
> -		return ret;
> -	}
> +	pcm179x->regmap = regmap;
> +	dev_set_drvdata(dev, pcm179x);
>  
> -	return snd_soc_register_codec(&spi->dev,
> +	return snd_soc_register_codec(dev,
>  			&soc_codec_dev_pcm179x, &pcm179x_dai, 1);
>  }

Thanks,
Johan
