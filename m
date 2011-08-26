From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/1] ASoC: soc-core: symmetry checking
 for each DAIs separately
Date: Fri, 26 Aug 2011 13:23:58 +0200
Message-ID: <4E57824E.8000400@metafoo.de>
References: <1314351351-1018-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 6874924403
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 13:24:43 +0200 (CEST)
In-Reply-To: <1314351351-1018-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 08/26/2011 11:35 AM, Dong Aisheng wrote:
> [...]
>  	/* runtime devices */
> diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> index 1aee9fc..3f7ded7 100644
> --- a/sound/soc/soc-pcm.c
> +++ b/sound/soc/soc-pcm.c
> @@ -32,33 +32,54 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream)
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>  	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	unsigned int race;
> +	unsigned int force_rate;
>  	int ret;
>  
> +	race = 0;
> +	force_rate = 0;
> +
>  	if (!codec_dai->driver->symmetric_rates &&
>  	    !cpu_dai->driver->symmetric_rates &&
>  	    !rtd->dai_link->symmetric_rates)
>  		return 0;
>
> +	if (codec_dai->active && codec_dai->driver->symmetric_rates ||
> +	     codec_dai->active && rtd->dai_link->symmetric_rates) {

parenthesis, please, when mixing && and || in the same expression. Makes it
easier to comprehend and protects against accidental mistakes.

> +		if (codec_dai->rate != 0)
> +			force_rate = codec_dai->rate;
> +		else
> +			race = 1;
> +	}
> +
> +	if (cpu_dai->active && cpu_dai->driver->symmetric_rates ||
> +	    codec_dai->active && rtd->dai_link->symmetric_rates) {
> +		if (cpu_dai->rate != 0)
> +			force_rate = cpu_dai->rate;
> +		else
> +			race = 1;
> +	}
> +

If both dais are active and require symmetry we should call
snd_pcm_hw_constraint_minmax for both rates. This will ensure that if both are
already active and are running at different rates that there will be no valid
rate for the new pcm stream. Maybe extend this function to take the dai as an
parameter and call it twice, once for the codec_dai and once for the cpu_dai.
This would allow to keep the current structure of the function.


> +	if (force_rate) {
> +		dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
> +
> +		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
> +				SNDRV_PCM_HW_PARAM_RATE,
> +				force_rate, force_rate);
> +		if (ret < 0) {
> +			dev_err(&rtd->dev,
> +				"Unable to apply rate symmetry constraint: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	/* This can happen if multiple streams are starting simultaneously -
>  	 * the second can need to get its constraints before the first has
>  	 * picked a rate.  Complain and allow the application to carry on.
>  	 */
> -	if (!rtd->rate) {
> +	if (race)
>  		dev_warn(&rtd->dev,
> -			 "Not enforcing symmetric_rates due to race\n");
> -		return 0;
> -	}
> -
> -	dev_dbg(&rtd->dev, "Symmetry forces %dHz rate\n", rtd->rate);
> -
> -	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
> -					   SNDRV_PCM_HW_PARAM_RATE,
> -					   rtd->rate, rtd->rate);
> -	if (ret < 0) {
> -		dev_err(&rtd->dev,
> -			"Unable to apply rate symmetry constraint: %d\n", ret);
> -		return ret;
> -	}
> +			"Not enforcing symmetric_rates due to race\n");
>  
>  	return 0;
>  }
> @@ -287,9 +308,14 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
>  	cpu_dai->active--;
>  	codec_dai->active--;
>  	codec->active--;
> +	rtd->active--;

I guess the line above is a leftover from the previous patch.

> +
> +	/* clear the corresponding DAIs rate when inactive */
> +	if (!cpu_dai->active)
> +		cpu_dai->rate = 0;
>  
> -	if (!cpu_dai->active && !codec_dai->active)
> -		rtd->rate = 0;
> +	if (!codec_dai->active)
> +		codec_dai->rate = 0;
>  
>  	/* Muting the DAC suppresses artifacts caused during digital
>  	 * shutdown, for example from stopping clocks.
> @@ -447,7 +473,9 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
>  		}
>  	}
>  
> -	rtd->rate = params_rate(params);
> +	/* store the rate for each DAIs */
> +	cpu_dai->rate = params_rate(params);
> +	codec_dai->rate = params_rate(params);
>  
>  out:
>  	mutex_unlock(&rtd->pcm_mutex);
