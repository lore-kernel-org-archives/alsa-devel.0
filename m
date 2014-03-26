From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: tas5086: add regulator consumer
 support
Date: Wed, 26 Mar 2014 17:31:18 +0100
Message-ID: <533300D6.3030107@gmail.com>
References: <1395829378-13055-1-git-send-email-zonque@gmail.com>
 <1395829378-13055-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f45.google.com (mail-bk0-f45.google.com
 [209.85.214.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 18821265050
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 17:31:21 +0100 (CET)
Received: by mail-bk0-f45.google.com with SMTP id na10so615071bkb.32
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 09:31:20 -0700 (PDT)
In-Reply-To: <1395829378-13055-3-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 11:22 AM, Daniel Mack wrote:
> The TAS5086 has two power domains, DVDD and AVDD. Add support for
> regulators to the TAS5086 codec driver.

Meh, this one needs more tweaking as well. Please ignore all patches in
this series; I'll resend once things work as expected. Sorry for the noise.



> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/soc/codecs/tas5086.c | 39 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
> index a895a5e..e87a577 100644
> --- a/sound/soc/codecs/tas5086.c
> +++ b/sound/soc/codecs/tas5086.c
> @@ -36,6 +36,7 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> @@ -240,6 +241,10 @@ static int tas5086_reg_read(void *context, unsigned int reg,
>  	return 0;
>  }
>  
> +static const char *supply_names[] = {
> +	"dvdd", "avdd"
> +};
> +
>  struct tas5086_private {
>  	struct regmap	*regmap;
>  	unsigned int	mclk, sclk;
> @@ -251,6 +256,7 @@ struct tas5086_private {
>  	int		rate;
>  	/* GPIO driving Reset pin, if any */
>  	int		gpio_nreset;
> +	struct		regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
>  };
>  
>  static int tas5086_deemph[] = { 0, 32000, 44100, 48000 };
> @@ -773,6 +779,8 @@ static int tas5086_soc_suspend(struct snd_soc_codec *codec)
>  	if (ret < 0)
>  		return ret;
>  
> +	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +
>  	return 0;
>  }
>  
> @@ -781,6 +789,10 @@ static int tas5086_soc_resume(struct snd_soc_codec *codec)
>  	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
>  	int ret;
>  
> +	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +	if (ret < 0)
> +		return ret;
> +
>  	tas5086_reset(priv);
>  	regcache_mark_dirty(priv->regmap);
>  
> @@ -812,6 +824,12 @@ static int tas5086_probe(struct snd_soc_codec *codec)
>  	struct tas5086_private *priv = snd_soc_codec_get_drvdata(codec);
>  	int i, ret;
>  
> +	ret = regulator_bulk_enable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
>  	priv->pwm_start_mid_z = 0;
>  	priv->charge_period = 1300000; /* hardware default is 1300 ms */
>  
> @@ -834,14 +852,19 @@ static int tas5086_probe(struct snd_soc_codec *codec)
>  
>  	ret = tas5086_init(codec->dev, priv);
>  	if (ret < 0)
> -		return ret;
> +		goto exit_disable_regulators;
>  
>  	/* set master volume to 0 dB */
>  	ret = regmap_write(priv->regmap, TAS5086_MASTER_VOL, 0x30);
>  	if (ret < 0)
> -		return ret;
> +		goto exit_disable_regulators;
>  
>  	return 0;
> +
> +exit_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +
> +	return ret;
>  }
>  
>  static int tas5086_remove(struct snd_soc_codec *codec)
> @@ -852,6 +875,8 @@ static int tas5086_remove(struct snd_soc_codec *codec)
>  		/* Set codec to the reset state */
>  		gpio_set_value(priv->gpio_nreset, 0);
>  
> +	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
> +
>  	return 0;
>  };
>  
> @@ -900,6 +925,16 @@ static int tas5086_i2c_probe(struct i2c_client *i2c,
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
> +		priv->supplies[i].supply = supply_names[i];
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(priv->supplies),
> +				      priv->supplies);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to get regulators: %d\n", ret);
> +		return ret;
> +	}
> +
>  	priv->regmap = devm_regmap_init(dev, NULL, i2c, &tas5086_regmap);
>  	if (IS_ERR(priv->regmap)) {
>  		ret = PTR_ERR(priv->regmap);
> 
