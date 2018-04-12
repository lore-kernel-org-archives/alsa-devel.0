From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/2] ASoC: adau17x1: Handling of DSP_RUN
 register during fw setup
Date: Thu, 12 Apr 2018 18:30:31 +0200
Message-ID: <8c9059aa-bd14-af00-72d0-1a5b3788500a@metafoo.de>
References: <20180409131336.21990-1-robert.rosengren@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id DC824266E30
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 18:30:34 +0200 (CEST)
In-Reply-To: <20180409131336.21990-1-robert.rosengren@axis.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Rosengren <robert.rosengren@axis.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Robert Rosengren <robertr@axis.com>, Danny Smith <dannys@axis.com>
List-Id: alsa-devel@alsa-project.org

On 04/09/2018 03:13 PM, Robert Rosengren wrote:
> From: Danny Smith <dannys@axis.com>
> 
> DSP_RUN needs to be disabled during firmware write otherwise
> we can end up with undefined behavior if writing to a dsp which
> is already running firmware.
> 
> Signed-off-by: Danny Smith <dannys@axis.com>
> Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/codecs/adau17x1.c | 26 ++++++++++++++++++++------
>  sound/soc/codecs/adau17x1.h |  3 ++-
>  2 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
> index 80c2a06285bb..12bf24c26818 100644
> --- a/sound/soc/codecs/adau17x1.c
> +++ b/sound/soc/codecs/adau17x1.c
> @@ -502,7 +502,7 @@ static int adau17x1_hw_params(struct snd_pcm_substream *substream,
>  	}
>  
>  	if (adau->sigmadsp) {
> -		ret = adau17x1_setup_firmware(adau, params_rate(params));
> +		ret = adau17x1_setup_firmware(component, params_rate(params));
>  		if (ret < 0)
>  			return ret;
>  	}
> @@ -835,26 +835,40 @@ bool adau17x1_volatile_register(struct device *dev, unsigned int reg)
>  }
>  EXPORT_SYMBOL_GPL(adau17x1_volatile_register);
>  
> -int adau17x1_setup_firmware(struct adau *adau, unsigned int rate)
> +int adau17x1_setup_firmware(struct snd_soc_component *component,
> +	unsigned int rate)
>  {
>  	int ret;
> -	int dspsr;
> +	int dspsr, dsp_run;
> +	struct adau *adau = snd_soc_component_get_drvdata(component);
> +	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
> +
> +	snd_soc_dapm_mutex_lock(dapm);
>  
>  	ret = regmap_read(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, &dspsr);
>  	if (ret)
> -		return ret;
> +		goto err;
> +
> +	ret = regmap_read(adau->regmap, ADAU17X1_DSP_RUN, &dsp_run);
> +	if (ret)
> +		goto err;
>  
>  	regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 1);
>  	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, 0xf);
> +	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, 0);
>  
>  	ret = sigmadsp_setup(adau->sigmadsp, rate);
>  	if (ret) {
>  		regmap_write(adau->regmap, ADAU17X1_DSP_ENABLE, 0);
> -		return ret;
> +		goto err;
>  	}
>  	regmap_write(adau->regmap, ADAU17X1_DSP_SAMPLING_RATE, dspsr);
> +	regmap_write(adau->regmap, ADAU17X1_DSP_RUN, dsp_run);
>  
> -	return 0;
> +err:
> +	snd_soc_dapm_mutex_unlock(dapm);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(adau17x1_setup_firmware);
>  
> diff --git a/sound/soc/codecs/adau17x1.h b/sound/soc/codecs/adau17x1.h
> index a7b1cb770814..e6fe87beec07 100644
> --- a/sound/soc/codecs/adau17x1.h
> +++ b/sound/soc/codecs/adau17x1.h
> @@ -68,7 +68,8 @@ int adau17x1_resume(struct snd_soc_component *component);
>  
>  extern const struct snd_soc_dai_ops adau17x1_dai_ops;
>  
> -int adau17x1_setup_firmware(struct adau *adau, unsigned int rate);
> +int adau17x1_setup_firmware(struct snd_soc_component *component,
> +	unsigned int rate);
>  bool adau17x1_has_dsp(struct adau *adau);
>  
>  #define ADAU17X1_CLOCK_CONTROL			0x4000
> 
