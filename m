From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/4] ASoC: codecs: adau1701: factor out
 firmware reset
Date: Mon, 10 Jun 2013 15:08:24 +0200
Message-ID: <51B5CFC8.3060608@metafoo.de>
References: <1370605987-19290-1-git-send-email-zonque@gmail.com>
 <1370605987-19290-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-066.synserver.de (smtp-out-067.synserver.de
 [212.40.185.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4236B2615D1
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:08:17 +0200 (CEST)
In-Reply-To: <1370605987-19290-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 06/07/2013 01:53 PM, Daniel Mack wrote:
> Some runtime-determined constraints might need to be satisfied prior to
> firmware loading, so the actual download and releasing the device from
> reset has to be postponed. Factor it out first, so we have everything at
> one place.
> 
> This also changes the behaviour in a way that adau1701_i2c_probe() will
> assert the reset line, and wait for the codec probe to release it.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>  sound/soc/codecs/adau1701.c | 49 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 13 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index 3fc1763..b6b1a77 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -90,6 +90,7 @@
>  #define ADAU1701_FIRMWARE "adau1701.bin"
>  
>  struct adau1701 {
> +	int gpio_nreset;
>  	unsigned int dai_fmt;
>  };
>  
> @@ -183,9 +184,37 @@ static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
>  	return value;
>  }
>  
> -static int adau1701_load_firmware(struct i2c_client *client)
> +static void adau1701_reset(struct snd_soc_codec *codec)
>  {
> -	return process_sigma_firmware(client, ADAU1701_FIRMWARE);
> +	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
> +
> +	if (!gpio_is_valid(adau1701->gpio_nreset))
> +		return;
> +
> +	gpio_set_value(adau1701->gpio_nreset, 0);
> +	/* minimum reset time is 20ns */
> +	udelay(1);
> +	gpio_set_value(adau1701->gpio_nreset, 1);
> +	/* power-up time may be as long as 85ms */
> +	mdelay(85);
> +}
> +
> +static int adau1701_init(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +	struct i2c_client *client = to_i2c_client(codec->dev);
> +
> +	adau1701_reset(codec);
> +
> +	ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
> +	if (ret) {
> +		dev_warn(codec->dev, "Failed to load firmware\n");
> +		return ret;
> +	}
> +
> +	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
> +
> +	return 0;
>  }
>  
>  static int adau1701_set_capture_pcm_format(struct snd_soc_codec *codec,
> @@ -466,15 +495,13 @@ MODULE_DEVICE_TABLE(of, adau1701_dt_ids);
>  static int adau1701_probe(struct snd_soc_codec *codec)
>  {
>  	int ret;
> -	struct i2c_client *client = to_i2c_client(codec->dev);
>  
> -	codec->control_data = client;
> +	codec->control_data = to_i2c_client(codec->dev);
>  
> -	ret = adau1701_load_firmware(client);
> +	ret = adau1701_init(codec);
>  	if (ret)
> -		dev_warn(codec->dev, "Failed to load firmware\n");
> +		return ret;
>  
> -	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
>  	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
>  
>  	return 0;
> @@ -524,14 +551,10 @@ static int adau1701_i2c_probe(struct i2c_client *client,
>  					    "ADAU1701 Reset");
>  		if (ret < 0)
>  			return ret;
> -
> -		/* minimum reset time is 20ns */
> -		udelay(1);
> -		gpio_set_value(gpio_nreset, 1);
> -		/* power-up time may be as long as 85ms */
> -		mdelay(85);
>  	}
>  
> +	adau1701->gpio_nreset = gpio_nreset;
> +
>  	i2c_set_clientdata(client, adau1701);
>  	ret = snd_soc_register_codec(&client->dev, &adau1701_codec_drv,
>  			&adau1701_dai, 1);
