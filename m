From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: max98090: remove 24-bit format support
Date: Mon, 13 May 2019 08:31:33 -0500
Message-ID: <bb4f797a-9719-ec77-629c-46622c6fc2ea@linux.intel.com>
References: <20190510102559.76137-1-yuhsuan@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190510102559.76137-1-yuhsuan@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yu-Hsuan Hsu <yuhsuan@chromium.org>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jon Hunter <jonathanh@nvidia.com>, dgreid@chromium.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org



On 5/10/19 5:25 AM, Yu-Hsuan Hsu wrote:
> Remove 24-bit format support because it doesn't work now. We can revert
> this change after it really supports.
> (https://patchwork.kernel.org/patch/10783561/)
> 
> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>

As discussed in the previous thread, the data sheet explicitly mentions 
24 bit support for the input in RJ mode. It'd be odd to remove support 
for 24 bits without clarifying in which modes it's not supported.

Also you'd need to clarify which platform you tested on, there are known 
issues with Maxim devices when using e.g. a 19.2 MHz clock and trailing 
bits (25-bit slots with 24-bit data).

> ---
>   sound/soc/codecs/max98090.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index 7619ea31ab50..b25b7efa9118 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2313,7 +2313,7 @@ int max98090_mic_detect(struct snd_soc_component *component,
>   EXPORT_SYMBOL_GPL(max98090_mic_detect);
>   
>   #define MAX98090_RATES SNDRV_PCM_RATE_8000_96000
> -#define MAX98090_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
> +#define MAX98090_FORMATS SNDRV_PCM_FMTBIT_S16_LE
>   
>   static const struct snd_soc_dai_ops max98090_dai_ops = {
>   	.set_sysclk = max98090_dai_set_sysclk,
> 
