From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 4/8] ASoC: pcm: Add support for DAI
	multicodec
Date: Tue, 01 Jul 2014 15:32:02 +0200
Message-ID: <53B2B852.5000200@metafoo.de>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-5-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BED0261A83
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 15:32:03 +0200 (CEST)
In-Reply-To: <1404200881-32253-5-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benoit Cousson <bcousson@baylibre.com>, broonie@kernel.org, lgirdwood@gmail.com
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/01/2014 09:47 AM, Benoit Cousson wrote:
> Add multicodec support in soc-pcm.c

Also almost.

>
> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
> Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
[...]
>   /**
> @@ -107,11 +115,15 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
>    */
>   bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
>   {
> +	int i, ignore = 0;

The default value for ignore needs to be 1. Also maybe make ignore a bool 
(and default true).

> +
>   	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
>   		return true;
>
> -	return rtd->cpu_dai->component->ignore_pmdown_time &&
> -			rtd->codec_dai->component->ignore_pmdown_time;
> +	for (i = 0; (i < rtd->num_codecs) && !ignore; i++)
> +		ignore &= rtd->codec_dais[i]->component->ignore_pmdown_time;
> +
> +	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
>   }
>
>   /**
> @@ -309,14 +334,21 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
>   {
>   	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>   	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> -	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *codec_dai;
> +	int i;
>   	unsigned int bits = 0, cpu_bits;
>
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> -		bits = codec_dai->driver->playback.sig_bits;
> +		for (i = 0; i < rtd->num_codecs; i++) {
> +			codec_dai = rtd->codec_dais[i];
> +			bits = max(codec_dai->driver->playback.sig_bits, bits);
> +		}

This ignores one important thing. A sig_bits value of 0 means no 
restrictions. Which means that if at least one codec as a sig_bits value of 
0 the overall value should be 0 as well.

Something like
for (i = 0; i < rtd->num_codecs; i++) {
	codec_dai = rtd->codec_dais[i];
	if (codec_dai->driver->playback.sig_bits == 0) {
		bits = 0;
		break;
	}
	bits = max(codec_dai->driver->playback.sig_bits, bits);
}



>   		cpu_bits = cpu_dai->driver->playback.sig_bits;
>   	} else {
> -		bits = codec_dai->driver->capture.sig_bits;
> +		for (i = 0; i < rtd->num_codecs; i++) {
> +			codec_dai = rtd->codec_dais[i];
> +			bits = max(codec_dai->driver->capture.sig_bits, bits);
> +		}
>   		cpu_bits = cpu_dai->driver->capture.sig_bits;
>   	}
>
> @@ -324,32 +356,65 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
>   	soc_pcm_set_msb(substream, cpu_dai, cpu_bits);

I'm getting a warning here from the compiler that codec_dai might be 
uninitialized. It won't be since num_codecs > 0, but the compiler does not 
know that, maybe you can restructure this to avoid the warning.

>   }
>
[...]


> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +		struct snd_pcm_hw_params codec_params;

> +
> +		/* copy params for each codec */
> +		memcpy(&codec_params, params, sizeof(struct snd_pcm_hw_params));

Just codec_params = *params, this is generally preferred over memcpy since 
it is type safe.
