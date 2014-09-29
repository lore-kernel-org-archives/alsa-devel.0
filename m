From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] ASoC: ssm2602: add support for 11.025kHz and 22.5kHz
 sample rates
Date: Mon, 29 Sep 2014 10:57:08 +0200
Message-ID: <54291EE4.7030505@metafoo.de>
References: <1411891105-22683-1-git-send-email-stefan.kristiansson@saunalahti.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411891105-22683-1-git-send-email-stefan.kristiansson@saunalahti.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 09/28/2014 09:58 AM, Stefan Kristiansson wrote:
> This adds the necessary values to the constraint list and
> register values to the coefficient table in order to
> configure the device for 11.025kHz and 22.5kHz sample rates.
>
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

But again, don't forget to Cc the ASoC maintainers, otherwise the patch will 
be lost.

[...]
> @@ -467,7 +477,8 @@ static int ssm2602_set_bias_level(struct snd_soc_codec *codec,
>   	return 0;
>   }
>
> -#define SSM2602_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
> +#define SSM2602_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
> +		SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_16000 |\

Tiny nitpick, order should be SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 to 
keep things sorted.

>   		SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |\
>   		SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_88200 |\
>   		SNDRV_PCM_RATE_96000)
>
