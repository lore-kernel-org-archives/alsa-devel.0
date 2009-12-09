From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Add support for regulator
	framework
Date: Wed, 9 Dec 2009 13:16:13 +0200
Message-ID: <20091209111613.GA20164@esdhcp037198.research.nokia.com>
References: <1260353150-19530-1-git-send-email-ilkka.koskinen@nokia.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D3E4103897
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:16:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1260353150-19530-1-git-send-email-ilkka.koskinen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koskinen Ilkka (Nokia-D/Tampere)" <ilkka.koskinen@nokia.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 09, 2009 at 11:05:50AM +0100, Koskinen Ilkka (Nokia-D/Tampere) wrote:
> Take the regulator framework in use for managing the power sources
> 

On my behalf it looks correctly as well.

Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>

> Signed-off-by: Ilkka Koskinen <ilkka.koskinen@nokia.com>
> ---
>  sound/soc/codecs/tpa6130a2.c |   87 +++++++++++++++++++++++++++++++++--------
>  1 files changed, 70 insertions(+), 17 deletions(-)
> 
> diff --git a/sound/soc/codecs/tpa6130a2.c b/sound/soc/codecs/tpa6130a2.c
> index 6b650c1..0eb33d4 100644
> --- a/sound/soc/codecs/tpa6130a2.c
> +++ b/sound/soc/codecs/tpa6130a2.c
> @@ -25,6 +25,7 @@
>  #include <linux/device.h>
>  #include <linux/i2c.h>
>  #include <linux/gpio.h>
> +#include <linux/regulator/consumer.h>
>  #include <sound/tpa6130a2-plat.h>
>  #include <sound/soc.h>
>  #include <sound/soc-dapm.h>
> @@ -34,10 +35,17 @@
>  
>  static struct i2c_client *tpa6130a2_client;
>  
> +#define TPA6130A2_NUM_SUPPLIES 2
> +static const char *tpa6130a2_supply_names[TPA6130A2_NUM_SUPPLIES] = {
> +	"CPVSS",
> +	"Vdd",
> +};
> +
>  /* This struct is used to save the context */
>  struct tpa6130a2_data {
>  	struct mutex mutex;
>  	unsigned char regs[TPA6130A2_CACHEREGNUM];
> +	struct regulator_bulk_data supplies[TPA6130A2_NUM_SUPPLIES];
>  	int power_gpio;
>  	unsigned char power_state;
>  };
> @@ -106,10 +114,11 @@ static void tpa6130a2_initialize(void)
>  		tpa6130a2_i2c_write(i, data->regs[i]);
>  }
>  
> -static void tpa6130a2_power(int power)
> +static int tpa6130a2_power(int power)
>  {
>  	struct	tpa6130a2_data *data;
>  	u8	val;
> +	int	ret;
>  
>  	BUG_ON(tpa6130a2_client == NULL);
>  	data = i2c_get_clientdata(tpa6130a2_client);
> @@ -117,11 +126,20 @@ static void tpa6130a2_power(int power)
>  	mutex_lock(&data->mutex);
>  	if (power) {
>  		/* Power on */
> -		if (data->power_gpio >= 0) {
> +		if (data->power_gpio >= 0)
>  			gpio_set_value(data->power_gpio, 1);
> -			data->power_state = 1;
> -			tpa6130a2_initialize();
> +
> +		ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies),
> +					    data->supplies);
> +		if (ret != 0) {
> +			dev_err(&tpa6130a2_client->dev,
> +				"Failed to enable supplies: %d\n", ret);
> +			goto exit;
>  		}
> +
> +		data->power_state = 1;
> +		tpa6130a2_initialize();
> +
>  		/* Clear SWS */
>  		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
>  		val &= ~TPA6130A2_SWS;
> @@ -131,13 +149,25 @@ static void tpa6130a2_power(int power)
>  		val = tpa6130a2_read(TPA6130A2_REG_CONTROL);
>  		val |= TPA6130A2_SWS;
>  		tpa6130a2_i2c_write(TPA6130A2_REG_CONTROL, val);
> +
>  		/* Power off */
> -		if (data->power_gpio >= 0) {
> +		if (data->power_gpio >= 0)
>  			gpio_set_value(data->power_gpio, 0);
> -			data->power_state = 0;
> +
> +		ret = regulator_bulk_disable(ARRAY_SIZE(data->supplies),
> +					     data->supplies);
> +		if (ret != 0) {
> +			dev_err(&tpa6130a2_client->dev,
> +				"Failed to disable supplies: %d\n", ret);
> +			goto exit;
>  		}
> +
> +		data->power_state = 0;
>  	}
> +
> +exit:
>  	mutex_unlock(&data->mutex);
> +	return ret;
>  }
>  
>  static int tpa6130a2_get_reg(struct snd_kcontrol *kcontrol,
> @@ -299,15 +329,17 @@ static int tpa6130a2_right_event(struct snd_soc_dapm_widget *w,
>  static int tpa6130a2_supply_event(struct snd_soc_dapm_widget *w,
>  		struct snd_kcontrol *kcontrol, int event)
>  {
> +	int ret = 0;
> +
>  	switch (event) {
>  	case SND_SOC_DAPM_POST_PMU:
> -		tpa6130a2_power(1);
> +		ret = tpa6130a2_power(1);
>  		break;
>  	case SND_SOC_DAPM_POST_PMD:
> -		tpa6130a2_power(0);
> +		ret = tpa6130a2_power(0);
>  		break;
>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  static const struct snd_soc_dapm_widget tpa6130a2_dapm_widgets[] = {
> @@ -352,7 +384,7 @@ static int tpa6130a2_probe(struct i2c_client *client,
>  	struct device *dev;
>  	struct tpa6130a2_data *data;
>  	struct tpa6130a2_platform_data *pdata;
> -	int ret;
> +	int i, ret;
>  
>  	dev = &client->dev;
>  
> @@ -387,15 +419,25 @@ static int tpa6130a2_probe(struct i2c_client *client,
>  		if (ret < 0) {
>  			dev_err(dev, "Failed to request power GPIO (%d)\n",
>  				data->power_gpio);
> -			goto fail;
> +			goto err_gpio;
>  		}
>  		gpio_direction_output(data->power_gpio, 0);
> -	} else {
> -		data->power_state = 1;
> -		tpa6130a2_initialize();
>  	}
>  
> -	tpa6130a2_power(1);
> +	for (i = 0; i < ARRAY_SIZE(data->supplies); i++)
> +		data->supplies[i].supply = tpa6130a2_supply_names[i];
> +
> +	ret = regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> +				 data->supplies);
> +	if (ret != 0) {
> +		dev_err(dev, "Failed to request supplies: %d\n", ret);
> +		goto err_regulator;
> +	}
> +
> +	ret = tpa6130a2_power(1);
> +	if (ret != 0)
> +		goto err_power;
> +
>  
>  	/* Read version */
>  	ret = tpa6130a2_i2c_read(TPA6130A2_REG_VERSION) &
> @@ -404,10 +446,18 @@ static int tpa6130a2_probe(struct i2c_client *client,
>  		dev_warn(dev, "UNTESTED version detected (%d)\n", ret);
>  
>  	/* Disable the chip */
> -	tpa6130a2_power(0);
> +	ret = tpa6130a2_power(0);
> +	if (ret != 0)
> +		goto err_power;
>  
>  	return 0;
> -fail:
> +
> +err_power:
> +	regulator_bulk_free(ARRAY_SIZE(data->supplies), data->supplies);
> +err_regulator:
> +	if (data->power_gpio >= 0)
> +		gpio_free(data->power_gpio);
> +err_gpio:
>  	kfree(data);
>  	i2c_set_clientdata(tpa6130a2_client, NULL);
>  	tpa6130a2_client = NULL;
> @@ -423,6 +473,9 @@ static int tpa6130a2_remove(struct i2c_client *client)
>  
>  	if (data->power_gpio >= 0)
>  		gpio_free(data->power_gpio);
> +
> +	regulator_bulk_free(ARRAY_SIZE(data->supplies), data->supplies);
> +
>  	kfree(data);
>  	tpa6130a2_client = NULL;
>  
> -- 
> 1.6.0.4

-- 
Eduardo Valentin
