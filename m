From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8731: initialize the hardware when
	loading the	codec driver
Date: Fri, 5 Jun 2015 17:25:46 +0100
Message-ID: <20150605162546.GB32730@opensource.wolfsonmicro.com>
References: <20150603131926.eba497d0b22010838fb094f4@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A8936266881
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 18:25:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150603131926.eba497d0b22010838fb094f4@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey Kiselev <sergey.kiselev@intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2015 at 01:19:26PM -0700, Sergey Kiselev wrote:
> From: Sergey Kiselev <sergey.kiselev@intel.com>
> 
> This patch moves the requesting supplies, hardware reset and
> initialization from wm8731_probe to wm8731_i2c_probe and wm8731_spi_probe.
> So that the codec hardware is initialized when loading the codec driver,
> and not when loading the machine driver. This avoids unnecesary hardware
> resets and re-initializations when re-loading the machine driver.
> 
> Signed-off-by: Sergey Kiselev <sergey.kiselev@intel.com>
> ---
>  sound/soc/codecs/wm8731.c | 80 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 28 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
> index 915ea11..28401f6 100644
> --- a/sound/soc/codecs/wm8731.c
> +++ b/sound/soc/codecs/wm8731.c
> @@ -84,7 +84,7 @@ static bool wm8731_writeable(struct device *dev, unsigned int reg)
>  	return reg <= WM8731_RESET;
>  }
>  
> -#define wm8731_reset(c)	snd_soc_write(c, WM8731_RESET, 0)
> +#define wm8731_reset(m)	regmap_write(m, WM8731_RESET, 0)
>  
>  static const char *wm8731_input_select[] = {"Line In", "Mic"};
>  
> @@ -571,44 +571,54 @@ static struct snd_soc_dai_driver wm8731_dai = {
>  	.symmetric_rates = 1,
>  };
>  
> -static int wm8731_probe(struct snd_soc_codec *codec)
> +static int wm8731_request_supplies(struct device *dev,
> +		struct wm8731_priv *wm8731)
>  {
> -	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
>  	int ret = 0, i;
>  
>  	for (i = 0; i < ARRAY_SIZE(wm8731->supplies); i++)
>  		wm8731->supplies[i].supply = wm8731_supply_names[i];
>  
> -	ret = devm_regulator_bulk_get(codec->dev, ARRAY_SIZE(wm8731->supplies),
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(wm8731->supplies),
>  				 wm8731->supplies);
>  	if (ret != 0) {
> -		dev_err(codec->dev, "Failed to request supplies: %d\n", ret);
> +		dev_err(dev, "Failed to request supplies: %d\n", ret);
>  		return ret;
>  	}
>  
>  	ret = regulator_bulk_enable(ARRAY_SIZE(wm8731->supplies),
>  				    wm8731->supplies);
>  	if (ret != 0) {
> -		dev_err(codec->dev, "Failed to enable supplies: %d\n", ret);
> +		dev_err(dev, "Failed to enable supplies: %d\n", ret);
>  		return ret;
>  	}
>  
> -	ret = wm8731_reset(codec);
> +	return 0;
> +}
> +
> +static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
> +{
> +	int ret = 0;
> +
> +	ret = wm8731_reset(wm8731->regmap);
>  	if (ret < 0) {
> -		dev_err(codec->dev, "Failed to issue reset: %d\n", ret);
> +		dev_err(dev, "Failed to issue reset: %d\n", ret);
>  		goto err_regulator_enable;
>  	}
>  
> -	snd_soc_codec_force_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	/* Clear POWEROFF, keep everything else disabled */
> +	regmap_write(wm8731->regmap, WM8731_PWR, 0x7f);
>  
>  	/* Latch the update bits */
> -	snd_soc_update_bits(codec, WM8731_LOUT1V, 0x100, 0);
> -	snd_soc_update_bits(codec, WM8731_ROUT1V, 0x100, 0);
> -	snd_soc_update_bits(codec, WM8731_LINVOL, 0x100, 0);
> -	snd_soc_update_bits(codec, WM8731_RINVOL, 0x100, 0);
> +	regmap_update_bits(wm8731->regmap, WM8731_LOUT1V, 0x100, 0);
> +	regmap_update_bits(wm8731->regmap, WM8731_ROUT1V, 0x100, 0);
> +	regmap_update_bits(wm8731->regmap, WM8731_LINVOL, 0x100, 0);
> +	regmap_update_bits(wm8731->regmap, WM8731_RINVOL, 0x100, 0);
>  
>  	/* Disable bypass path by default */
> -	snd_soc_update_bits(codec, WM8731_APANA, 0x8, 0);
> +	regmap_update_bits(wm8731->regmap, WM8731_APANA, 0x8, 0);
> +
> +	regcache_mark_dirty(wm8731->regmap);
>  
>  	/* Regulators will have been enabled by bias management */

This comment needs an update because this function is only called
from the bus probe so no bias management will have been called
yet. Basically we are powering down here after probe is complete
and the bias management will power us up again.

>  	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> @@ -621,19 +631,7 @@ err_regulator_enable:

Looks like you really should just combine the error and normal
exit paths for this function.

>  	return ret;
>  }
>  
> -/* power down chip */
> -static int wm8731_remove(struct snd_soc_codec *codec)
> -{
> -	struct wm8731_priv *wm8731 = snd_soc_codec_get_drvdata(codec);
> -
> -	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> -
> -	return 0;
> -}
> -
>  static struct snd_soc_codec_driver soc_codec_dev_wm8731 = {
> -	.probe =	wm8731_probe,
> -	.remove =	wm8731_remove,
>  	.set_bias_level = wm8731_set_bias_level,
>  	.suspend_bias_off = true,
>  
> @@ -690,6 +688,12 @@ static int wm8731_spi_probe(struct spi_device *spi)
>  
>  	mutex_init(&wm8731->lock);
>  
> +	spi_set_drvdata(spi, wm8731);
> +
> +	ret = wm8731_request_supplies(&spi->dev, wm8731);
> +	if (ret != 0)
> +		return ret;
> +
>  	wm8731->regmap = devm_regmap_init_spi(spi, &wm8731_regmap);
>  	if (IS_ERR(wm8731->regmap)) {
>  		ret = PTR_ERR(wm8731->regmap);
> @@ -698,7 +702,9 @@ static int wm8731_spi_probe(struct spi_device *spi)
>  		return ret;
>  	}
>  
> -	spi_set_drvdata(spi, wm8731);
> +	ret = wm8731_hw_init(&spi->dev, wm8731);
> +	if (ret != 0)
> +		return ret;
>  
>  	ret = snd_soc_register_codec(&spi->dev,
>  			&soc_codec_dev_wm8731, &wm8731_dai, 1);
> @@ -712,7 +718,12 @@ static int wm8731_spi_probe(struct spi_device *spi)
>  
>  static int wm8731_spi_remove(struct spi_device *spi)
>  {
> +	struct wm8731_priv *wm8731 = spi_get_drvdata(spi);
> +
>  	snd_soc_unregister_codec(&spi->dev);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> +
>  	return 0;
>  }
>  
> @@ -754,6 +765,12 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
>  
>  	mutex_init(&wm8731->lock);
>  
> +	i2c_set_clientdata(i2c, wm8731);
> +
> +	ret = wm8731_request_supplies(&i2c->dev, wm8731);
> +	if (ret != 0)
> +		return ret;
> +
>  	wm8731->regmap = devm_regmap_init_i2c(i2c, &wm8731_regmap);
>  	if (IS_ERR(wm8731->regmap)) {
>  		ret = PTR_ERR(wm8731->regmap);
> @@ -762,7 +779,9 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> -	i2c_set_clientdata(i2c, wm8731);
> +	ret = wm8731_hw_init(&i2c->dev, wm8731);
> +	if (ret != 0)
> +		return ret;
>  
>  	ret = snd_soc_register_codec(&i2c->dev,
>  			&soc_codec_dev_wm8731, &wm8731_dai, 1);
> @@ -776,7 +795,12 @@ static int wm8731_i2c_probe(struct i2c_client *i2c,
>  
>  static int wm8731_i2c_remove(struct i2c_client *client)
>  {
> +	struct wm8731_priv *wm8731 = i2c_get_clientdata(client);
> +
>  	snd_soc_unregister_codec(&client->dev);
> +
> +	regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies), wm8731->supplies);
> +

Do we actually need to bulk_disable here? The enable we did
during bus probe is balanced with the disable we do there two.
Then I would expect that ASoC has put us back into bias off
before we are removing the i2c. Not a 100% sure on this one but
it looks like it is redundant.

Thanks,
Charles

>  	return 0;
>  }
>  
> -- 
> 1.9.1
> 
> _______________________________________________
> patches mailing list
> patches@opensource.wolfsonmicro.com
> http://opensource.wolfsonmicro.com/cgi-bin/mailman/listinfo/patches
