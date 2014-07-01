From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 7/8] ASoC: pcm: Add soc_dai_hw_params
	helper
Date: Tue, 01 Jul 2014 15:43:12 +0200
Message-ID: <53B2BAF0.2050203@metafoo.de>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
 <1404200881-32253-8-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-145.synserver.de
 [212.40.185.145])
 by alsa0.perex.cz (Postfix) with ESMTP id 58BDA261A83
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 15:43:13 +0200 (CEST)
In-Reply-To: <1404200881-32253-8-git-send-email-bcousson@baylibre.com>
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
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/01/2014 09:48 AM, Benoit Cousson wrote:
> Add a function helper to factorize the hw_params code.
>
> Suggested by Lars-Peter Clausen <lars@metafoo.de>
>
> Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
> ---
>   include/sound/soc.h  |  4 ++++
>   sound/soc/soc-dapm.c | 26 ++++++--------------------
>   sound/soc/soc-pcm.c  | 41 ++++++++++++++++++++++-------------------
>   3 files changed, 32 insertions(+), 39 deletions(-)
>
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index f2142cf..98555f8 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -436,6 +436,10 @@ int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
>   int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
>   		int cmd, struct snd_soc_platform *platform);
>
> +int soc_dai_hw_params(struct snd_pcm_substream *substream,
> +		      struct snd_pcm_hw_params *params,
> +		      struct snd_soc_dai *dai);
> +
>   /* Jack reporting */
>   int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
>   		     struct snd_soc_jack *jack);
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 5c63c3b..d8a24bb 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3214,27 +3214,13 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
>
>   	switch (event) {
>   	case SND_SOC_DAPM_PRE_PMU:
> -		if (source->driver->ops && source->driver->ops->hw_params) {
> -			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
> -			ret = source->driver->ops->hw_params(&substream,
> -							     params, source);
> -			if (ret != 0) {
> -				dev_err(source->dev,
> -					"ASoC: hw_params() failed: %d\n", ret);
> -				goto out;
> -			}
> -		}
> +		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
> +		if (soc_dai_hw_params(&substream, params, source) < 0)
> +			goto out;

ret = ...
if (ret < 0)
	goto out;

This should also fix the compiler warning about using ret uninitialized.

Same comment for the other places in this patch that do the same.

>
> -		if (sink->driver->ops && sink->driver->ops->hw_params) {
> -			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
> -			ret = sink->driver->ops->hw_params(&substream, params,
> -							   sink);
> -			if (ret != 0) {
> -				dev_err(sink->dev,
> -					"ASoC: hw_params() failed: %d\n", ret);
> -				goto out;
> -			}
> -		}
> +		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
> +		if (soc_dai_hw_params(&substream, params, sink) < 0)
> +			goto out;
>   		break;
>
