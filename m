From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: clean up cache read/write
 functions
Date: Mon, 20 Dec 2010 17:23:22 +0000
Message-ID: <1292865802.29185.24.camel@dplaptop.localdomain>
References: <s5hei9czeep.wl%tiwai@suse.de>
	<20101220152709.GJ26706@rakim.wolfsonmicro.main>
	<s5h4oa8zbe4.wl%tiwai@suse.de>  <s5h1v5czb5m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E734D103921
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 18:22:34 +0100 (CET)
In-Reply-To: <s5h1v5czb5m.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-12-20 at 17:01 +0100, Takashi Iwai wrote:
> Use common helper functions for standard read/write functions of each
> data type.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/soc/soc-cache.c |  251 ++++++++++---------------------------------------
>  1 files changed, 49 insertions(+), 202 deletions(-)
> 
> diff --git a/sound/soc/soc-cache.c b/sound/soc/soc-cache.c
> index 0e17b40..374b06a 100644
> --- a/sound/soc/soc-cache.c
> +++ b/sound/soc/soc-cache.c
> @@ -18,19 +18,44 @@
>  #include <linux/bitmap.h>
>  #include <linux/rbtree.h>
>  
> -static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
> -				     unsigned int reg)
> +static int do_hw_write(struct snd_soc_codec *codec, unsigned int reg,
> +		       unsigned int value, void *data, unsigned int size)
> +{
> +	int ret;
> +
> +	if (!snd_soc_codec_volatile_register(codec, reg) &&
> +	    reg < codec->driver->reg_cache_size) {
> +		ret = snd_soc_cache_write(codec, reg, value);
> +		if (ret < 0)
> +			return -1;
> +	}
> +
> +	if (codec->cache_only) {
> +		codec->cache_sync = 1;
> +		return 0;
> +	}
> +
> +	ret = codec->hw_write(codec->control_data, data, size);
> +	if (ret == size)
> +		return 0;
> +	if (ret < 0)
> +		return ret;
> +	else
> +		return -EIO;
> +}
> +
> +static unsigned int do_hw_read(struct snd_soc_codec *codec, unsigned int reg)
>  {
>  	int ret;
>  	unsigned int val;
>  
>  	if (reg >= codec->driver->reg_cache_size ||
> -		snd_soc_codec_volatile_register(codec, reg)) {
> -			if (codec->cache_only)
> -				return -1;
> +	    snd_soc_codec_volatile_register(codec, reg)) {
> +		if (codec->cache_only)
> +			return -1;
>  
> -			BUG_ON(!codec->hw_read);
> -			return codec->hw_read(codec, reg);
> +		BUG_ON(!codec->hw_read);
> +		return codec->hw_read(codec, reg);
>  	}
>  
>  	ret = snd_soc_cache_read(codec, reg, &val);
> @@ -39,34 +64,21 @@ static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
>  	return val;
>  }
>  
> +static unsigned int snd_soc_4_12_read(struct snd_soc_codec *codec,
> +				      unsigned int reg)
> +{
> +	return do_hw_read(codec, reg);
> +}
> +
>  static int snd_soc_4_12_write(struct snd_soc_codec *codec, unsigned int reg,
>  			     unsigned int value)
>  {
>  	u8 data[2];
> -	int ret;
>  
>  	data[0] = (reg << 4) | ((value >> 8) & 0x000f);
>  	data[1] = value & 0x00ff;
>  
> -	if (!snd_soc_codec_volatile_register(codec, reg) &&
> -		reg < codec->driver->reg_cache_size) {
> -		ret = snd_soc_cache_write(codec, reg, value);
> -		if (ret < 0)
> -			return -1;
> -	}
> -
> -	if (codec->cache_only) {
> -		codec->cache_sync = 1;
> -		return 0;
> -	}
> -
> -	ret = codec->hw_write(codec->control_data, data, 2);
> -	if (ret == 2)
> -		return 0;
> -	if (ret < 0)
> -		return ret;
> -	else
> -		return -EIO;
> +	return do_hw_write(codec, reg, value, data, 2);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)
> @@ -102,52 +114,18 @@ static int snd_soc_4_12_spi_write(void *control_data, const char *data,
>  static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
>  				     unsigned int reg)
>  {
> -	int ret;
> -	unsigned int val;
> -
> -	if (reg >= codec->driver->reg_cache_size ||
> -		snd_soc_codec_volatile_register(codec, reg)) {
> -			if (codec->cache_only)
> -				return -1;
> -
> -			BUG_ON(!codec->hw_read);
> -			return codec->hw_read(codec, reg);
> -	}
> -
> -	ret = snd_soc_cache_read(codec, reg, &val);
> -	if (ret < 0)
> -		return -1;
> -	return val;
> +	return do_hw_read(codec, reg);
>  }
>  
>  static int snd_soc_7_9_write(struct snd_soc_codec *codec, unsigned int reg,
>  			     unsigned int value)
>  {
>  	u8 data[2];
> -	int ret;
>  
>  	data[0] = (reg << 1) | ((value >> 8) & 0x0001);
>  	data[1] = value & 0x00ff;
>  
> -	if (!snd_soc_codec_volatile_register(codec, reg) &&
> -		reg < codec->driver->reg_cache_size) {
> -		ret = snd_soc_cache_write(codec, reg, value);
> -		if (ret < 0)
> -			return -1;
> -	}
> -
> -	if (codec->cache_only) {
> -		codec->cache_sync = 1;
> -		return 0;
> -	}
> -
> -	ret = codec->hw_write(codec->control_data, data, 2);
> -	if (ret == 2)
> -		return 0;
> -	if (ret < 0)
> -		return ret;
> -	else
> -		return -EIO;
> +	return do_hw_write(codec, reg, value, data, 2);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)
> @@ -184,50 +162,19 @@ static int snd_soc_8_8_write(struct snd_soc_codec *codec, unsigned int reg,
>  			     unsigned int value)
>  {
>  	u8 data[2];
> -	int ret;
>  
>  	reg &= 0xff;
>  	data[0] = reg;
>  	data[1] = value & 0xff;
>  
> -	if (!snd_soc_codec_volatile_register(codec, reg) &&
> -		reg < codec->driver->reg_cache_size) {
> -		ret = snd_soc_cache_write(codec, reg, value);
> -		if (ret < 0)
> -			return -1;
> -	}
> -
> -	if (codec->cache_only) {
> -		codec->cache_sync = 1;
> -		return 0;
> -	}
> -
> -	if (codec->hw_write(codec->control_data, data, 2) == 2)
> -		return 0;
> -	else
> -		return -EIO;
> +	return do_hw_write(codec, reg, value, data, 2);
>  }
>  
>  static unsigned int snd_soc_8_8_read(struct snd_soc_codec *codec,
>  				     unsigned int reg)
>  {
> -	int ret;
> -	unsigned int val;
> -
>  	reg &= 0xff;
> -	if (reg >= codec->driver->reg_cache_size ||
> -		snd_soc_codec_volatile_register(codec, reg)) {
> -			if (codec->cache_only)
> -				return -1;
> -
> -			BUG_ON(!codec->hw_read);
> -			return codec->hw_read(codec, reg);
> -	}
> -
> -	ret = snd_soc_cache_read(codec, reg, &val);
> -	if (ret < 0)
> -		return -1;
> -	return val;
> +	return do_hw_read(codec, reg);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)
> @@ -264,49 +211,18 @@ static int snd_soc_8_16_write(struct snd_soc_codec *codec, unsigned int reg,
>  			      unsigned int value)
>  {
>  	u8 data[3];
> -	int ret;
>  
>  	data[0] = reg;
>  	data[1] = (value >> 8) & 0xff;
>  	data[2] = value & 0xff;
>  
> -	if (!snd_soc_codec_volatile_register(codec, reg) &&
> -		reg < codec->driver->reg_cache_size) {
> -		ret = snd_soc_cache_write(codec, reg, value);
> -		if (ret < 0)
> -			return -1;
> -	}
> -
> -	if (codec->cache_only) {
> -		codec->cache_sync = 1;
> -		return 0;
> -	}
> -
> -	if (codec->hw_write(codec->control_data, data, 3) == 3)
> -		return 0;
> -	else
> -		return -EIO;
> +	return do_hw_write(codec, reg, value, data, 3);
>  }
>  
>  static unsigned int snd_soc_8_16_read(struct snd_soc_codec *codec,
>  				      unsigned int reg)
>  {
> -	int ret;
> -	unsigned int val;
> -
> -	if (reg >= codec->driver->reg_cache_size ||
> -	    snd_soc_codec_volatile_register(codec, reg)) {
> -		if (codec->cache_only)
> -			return -1;
> -
> -		BUG_ON(!codec->hw_read);
> -		return codec->hw_read(codec, reg);
> -	}
> -
> -	ret = snd_soc_cache_read(codec, reg, &val);
> -	if (ret < 0)
> -		return -1;
> -	return val;
> +	return do_hw_read(codec, reg);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)
> @@ -445,55 +361,21 @@ static unsigned int snd_soc_16_8_read_i2c(struct snd_soc_codec *codec,
>  static unsigned int snd_soc_16_8_read(struct snd_soc_codec *codec,
>  				     unsigned int reg)
>  {
> -	int ret;
> -	unsigned int val;
> -
>  	reg &= 0xff;
> -	if (reg >= codec->driver->reg_cache_size ||
> -		snd_soc_codec_volatile_register(codec, reg)) {
> -			if (codec->cache_only)
> -				return -1;
> -
> -			BUG_ON(!codec->hw_read);
> -			return codec->hw_read(codec, reg);
> -	}
> -
> -	ret = snd_soc_cache_read(codec, reg, &val);
> -	if (ret < 0)
> -		return -1;
> -	return val;
> +	return do_hw_read(codec, reg);
>  }
>  
>  static int snd_soc_16_8_write(struct snd_soc_codec *codec, unsigned int reg,
>  			     unsigned int value)
>  {
>  	u8 data[3];
> -	int ret;
>  
>  	data[0] = (reg >> 8) & 0xff;
>  	data[1] = reg & 0xff;
>  	data[2] = value;
>  
>  	reg &= 0xff;
> -	if (!snd_soc_codec_volatile_register(codec, reg) &&
> -		reg < codec->driver->reg_cache_size) {
> -		ret = snd_soc_cache_write(codec, reg, value);
> -		if (ret < 0)
> -			return -1;
> -	}
> -
> -	if (codec->cache_only) {
> -		codec->cache_sync = 1;
> -		return 0;
> -	}
> -
> -	ret = codec->hw_write(codec->control_data, data, 3);
> -	if (ret == 3)
> -		return 0;
> -	if (ret < 0)
> -		return ret;
> -	else
> -		return -EIO;
> +	return do_hw_write(codec, reg, value, data, 3);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)
> @@ -564,55 +446,20 @@ static unsigned int snd_soc_16_16_read_i2c(struct snd_soc_codec *codec,
>  static unsigned int snd_soc_16_16_read(struct snd_soc_codec *codec,
>  				       unsigned int reg)
>  {
> -	int ret;
> -	unsigned int val;
> -
> -	if (reg >= codec->driver->reg_cache_size ||
> -	    snd_soc_codec_volatile_register(codec, reg)) {
> -		if (codec->cache_only)
> -			return -1;
> -
> -		BUG_ON(!codec->hw_read);
> -		return codec->hw_read(codec, reg);
> -	}
> -
> -	ret = snd_soc_cache_read(codec, reg, &val);
> -	if (ret < 0)
> -		return -1;
> -
> -	return val;
> +	return do_hw_read(codec, reg);
>  }
>  
>  static int snd_soc_16_16_write(struct snd_soc_codec *codec, unsigned int reg,
>  			       unsigned int value)
>  {
>  	u8 data[4];
> -	int ret;
>  
>  	data[0] = (reg >> 8) & 0xff;
>  	data[1] = reg & 0xff;
>  	data[2] = (value >> 8) & 0xff;
>  	data[3] = value & 0xff;
>  
> -	if (!snd_soc_codec_volatile_register(codec, reg) &&
> -		reg < codec->driver->reg_cache_size) {
> -		ret = snd_soc_cache_write(codec, reg, value);
> -		if (ret < 0)
> -			return -1;
> -	}
> -
> -	if (codec->cache_only) {
> -		codec->cache_sync = 1;
> -		return 0;
> -	}
> -
> -	ret = codec->hw_write(codec->control_data, data, 4);
> -	if (ret == 4)
> -		return 0;
> -	if (ret < 0)
> -		return ret;
> -	else
> -		return -EIO;
> +	return do_hw_write(codec, reg, value, data, 4);
>  }
>  
>  #if defined(CONFIG_SPI_MASTER)

All

Acked-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
