From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] ASoC: ad193x: add support to ad1934
Date: Tue, 29 Sep 2015 10:42:31 +0200
Message-ID: <560A4EF7.9030506@metafoo.de>
References: <273ce440257bbe7c450132bd8dffb25cbaac117e.1443515024.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-050.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D82B26062B
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 10:43:34 +0200 (CEST)
In-Reply-To: <273ce440257bbe7c450132bd8dffb25cbaac117e.1443515024.git.cyrille.pitchen@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09/29/2015 10:36 AM, Cyrille Pitchen wrote:
> The AD1934 codec has no DAC feature. Hence it register mapping is slightly
> different from the register mapping of other members of the AD193x family.
> 
> Some ASoC controls and widgets are related to the DAC feature so are not
> relevant in the case of an AD1934 codec.

Looks mostly good, thanks.

> diff --git a/sound/soc/codecs/ad193x-i2c.c b/sound/soc/codecs/ad193x-i2c.c
> index df3a1a415825..8aa50d35662f 100644
> --- a/sound/soc/codecs/ad193x-i2c.c
> +++ b/sound/soc/codecs/ad193x-i2c.c
> @@ -15,8 +15,8 @@
>  #include "ad193x.h"
>  
>  static const struct i2c_device_id ad193x_id[] = {
> -	{ "ad1936", 0 },
> -	{ "ad1937", 0 },
> +	{ "ad1936", AD193x },
> +	{ "ad1937", AD193x },

Should be a upper case X.

>  	{ }
>  };
[...]
[...]
> @@ -91,18 +97,33 @@ static const struct snd_soc_dapm_route audio_paths[] = {
>  	{ "DAC", NULL, "SYSCLK" },
>  	{ "DAC Output", NULL, "DAC" },
>  	{ "DAC Output", NULL, "VMID" },
> -	{ "ADC", NULL, "SYSCLK" },
> -	{ "DAC", NULL, "ADC_PWR" },
> -	{ "ADC", NULL, "ADC_PWR" },
>  	{ "DAC1OUT", NULL, "DAC Output" },
>  	{ "DAC2OUT", NULL, "DAC Output" },
>  	{ "DAC3OUT", NULL, "DAC Output" },
>  	{ "DAC4OUT", NULL, "DAC Output" },
> +	{ "SYSCLK", NULL, "PLL_PWR" },
> +};
> +
> +static const struct snd_soc_dapm_route adc_audio_paths[] = {

this should have the ad193x_ prefix as well.

> +	{ "ADC", NULL, "SYSCLK" },
> +	{ "ADC", NULL, "ADC_PWR" },
>  	{ "ADC", NULL, "ADC1IN" },
>  	{ "ADC", NULL, "ADC2IN" },
> -	{ "SYSCLK", NULL, "PLL_PWR" },
>  };
