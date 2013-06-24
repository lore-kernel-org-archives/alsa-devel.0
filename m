From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 1/4] ASoC: codecs: adau1701: move
 firmware download to adau1701_reset()
Date: Mon, 24 Jun 2013 19:12:35 +0200
Message-ID: <51C87E03.30606@metafoo.de>
References: <1372084292-4859-1-git-send-email-zonque@gmail.com>
 <1372084292-4859-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-229.synserver.de (smtp-out-229.synserver.de
 [212.40.185.229])
 by alsa0.perex.cz (Postfix) with ESMTP id C13FF261B00
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 19:12:28 +0200 (CEST)
In-Reply-To: <1372084292-4859-2-git-send-email-zonque@gmail.com>
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

On 06/24/2013 04:31 PM, Daniel Mack wrote:
> The chip needs a new download after each reset, so the code to do that
> needs to live in adau1701_reset().
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/codecs/adau1701.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau1701.c b/sound/soc/codecs/adau1701.c
> index b6b1a77..997fc3b 100644
> --- a/sound/soc/codecs/adau1701.c
> +++ b/sound/soc/codecs/adau1701.c
> @@ -184,27 +184,20 @@ static unsigned int adau1701_read(struct snd_soc_codec *codec, unsigned int reg)
>  	return value;
>  }
>  
> -static void adau1701_reset(struct snd_soc_codec *codec)
> +static int adau1701_reset(struct snd_soc_codec *codec)
>  {
>  	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
> -
> -	if (!gpio_is_valid(adau1701->gpio_nreset))
> -		return;
> -
> -	gpio_set_value(adau1701->gpio_nreset, 0);
> -	/* minimum reset time is 20ns */
> -	udelay(1);
> -	gpio_set_value(adau1701->gpio_nreset, 1);
> -	/* power-up time may be as long as 85ms */
> -	mdelay(85);
> -}
> -
> -static int adau1701_init(struct snd_soc_codec *codec)
> -{
> -	int ret;
>  	struct i2c_client *client = to_i2c_client(codec->dev);
> +	int ret;
>  
> -	adau1701_reset(codec);
> +	if (gpio_is_valid(adau1701->gpio_nreset)) {
> +		gpio_set_value(adau1701->gpio_nreset, 0);
> +		/* minimum reset time is 20ns */
> +		udelay(1);
> +		gpio_set_value(adau1701->gpio_nreset, 1);
> +		/* power-up time may be as long as 85ms */
> +		mdelay(85);
> +	}
>  
>  	ret = process_sigma_firmware(client, ADAU1701_FIRMWARE);
>  	if (ret) {
> @@ -213,6 +206,7 @@ static int adau1701_init(struct snd_soc_codec *codec)
>  	}
>  
>  	snd_soc_write(codec, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
> +	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
>  
>  	return 0;
>  }
> @@ -498,12 +492,10 @@ static int adau1701_probe(struct snd_soc_codec *codec)
>  
>  	codec->control_data = to_i2c_client(codec->dev);
>  
> -	ret = adau1701_init(codec);
> +	ret = adau1701_reset(codec);
>  	if (ret)
>  		return ret;
>  
> -	snd_soc_write(codec, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
> -
>  	return 0;
>  }
>  
