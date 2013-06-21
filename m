From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] ASoC: codecs: adau1701: add support
	for pin muxing
Date: Fri, 21 Jun 2013 09:24:37 +0200
Message-ID: <51C3FFB5.9010101@metafoo.de>
References: <1371749397-32238-1-git-send-email-zonque@gmail.com>
 <1371749397-32238-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-182.synserver.de (smtp-out-182.synserver.de
 [212.40.185.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 7DC4F2654C5
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 09:24:17 +0200 (CEST)
In-Reply-To: <1371749397-32238-4-git-send-email-zonque@gmail.com>
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

On 06/20/2013 07:29 PM, Daniel Mack wrote:
> [...]
>  static int adau1701_probe(struct snd_soc_codec *codec)
>  {
> -	int ret;
> +	int ret, i;
> +	unsigned int val;
>  	struct i2c_client *client = to_i2c_client(codec->dev);
>  	struct adau1701 *adau1701 = snd_soc_codec_get_drvdata(codec);
>  
> @@ -576,6 +584,19 @@ static int adau1701_probe(struct snd_soc_codec *codec)
>  	regmap_write(adau1701->regmap, ADAU1701_DACSET, ADAU1701_DACSET_DACINIT);
>  	regmap_write(adau1701->regmap, ADAU1701_DSPCTRL, ADAU1701_DSPCTRL_CR);
>  
> +	/* set up pin config */
> +	val = 0;
> +	for (i = 0; i < 6; i++)
> +		val |= adau1701->pin_config[i] << (i * 4);
> +
> +	regmap_write(adau1701->regmap, ADAU1701_PINCONF_0, val);
> +
> +	val = 0;
> +	for (i = 0; i < 6; i++)
> +		val |= adau1701->pin_config[i + 6] << (i * 4);
> +
> +	regmap_write(adau1701->regmap, ADAU1701_PINCONF_1, val);

Will the config survive a reset?
