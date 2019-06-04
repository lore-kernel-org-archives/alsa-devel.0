From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v4] ASoC: max98090: remove 24-bit format
 support if RJ is 0
Date: Tue, 4 Jun 2019 09:48:04 -0500
Message-ID: <5de28b91-2d87-f013-3438-8708160db63d@linux.intel.com>
References: <20190604104909.112984-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190604104909.112984-1-yuhsuan@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>, dgreid@chromium.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

On 6/4/19 5:49 AM, Yu-Hsuan Hsu wrote:
> The supported formats are S16_LE and S24_LE now. However, by datasheet
> of max98090, S24_LE is only supported when it is in the right justified
> mode. We should remove 24-bit format if it is not in that mode to avoid
> triggering error.
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> ---
>   Remove Change-Id.
> 
>   sound/soc/codecs/max98090.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index 7619ea31ab50..ada8c25e643d 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -1909,6 +1909,21 @@ static int max98090_configure_dmic(struct max98090_priv *max98090,
>   	return 0;
>   }
>   
> +static int max98090_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct max98090_priv *max98090 = snd_soc_component_get_drvdata(component);
> +	unsigned int fmt = max98090->dai_fmt;
> +
> +	/* Remove 24-bit format support if it is not in right justified mode. */
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J) {
> +		substream->runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		snd_pcm_hw_constraint_msbits(substream->runtime, 0, 16, 16);
> +	}
> +	return 0;
> +}

The data sheet is ambiguous, it states that 24-bit data is supported in 
RJ mode when TDM is 0. It doesn't say TDM can only support 16 bits.

That said, it's not clear to me if TDM is supported or not in this 
driver, there are multiple references to tdm_slots but DSP_A and DSP_B 
are not supported.

> +
>   static int max98090_dai_hw_params(struct snd_pcm_substream *substream,
>   				   struct snd_pcm_hw_params *params,
>   				   struct snd_soc_dai *dai)
> @@ -2316,6 +2331,7 @@ EXPORT_SYMBOL_GPL(max98090_mic_detect);
>   #define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
>   
>   static const struct snd_soc_dai_ops max98090_dai_ops = {
> +	.startup = max98090_dai_startup,
>   	.set_sysclk = max98090_dai_set_sysclk,
>   	.set_fmt = max98090_dai_set_fmt,
>   	.set_tdm_slot = max98090_set_tdm_slot,
> 
