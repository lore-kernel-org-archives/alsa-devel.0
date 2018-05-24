From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 3/3] ASoC: Add multiple CPU DAI support
 in DAPM
Date: Thu, 24 May 2018 16:37:43 -0500
Message-ID: <b2738ac2-2e1c-c106-cd0d-c9761cdbe0ce@linux.intel.com>
References: <1526985623-2606-1-git-send-email-shreyas.nc@intel.com>
 <1526985623-2606-4-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 912AE267646
 for <alsa-devel@alsa-project.org>; Thu, 24 May 2018 23:37:46 +0200 (CEST)
In-Reply-To: <1526985623-2606-4-git-send-email-shreyas.nc@intel.com>
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
To: Shreyas NC <shreyas.nc@intel.com>, alsa-devel@alsa-project.org
Cc: patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, ckeepax@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org



On 05/22/2018 05:40 AM, Shreyas NC wrote:
> DAPM handles DAIs during soc_dapm_stream_event() and during addition
> and creation of DAI widgets i.e., dapm_add_valid_dai_widget() and
> dapm_connect_dai_link_widgets().
>
> Extend these functions to handle multiple cpu dai.

nit-pick: the diffs are difficult to look at, it might be easier on the 
reader if you first added a new helper function, then added multi 
cpu_dais in a second patch.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
>   sound/soc/soc-dapm.c | 71 ++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 46 insertions(+), 25 deletions(-)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 2d97091..79f5f61 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -4108,38 +4108,57 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
>   	return 0;
>   }
>   
> -static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
> -					  struct snd_soc_pcm_runtime *rtd)
> +static void dapm_add_valid_dai_widget(struct snd_soc_card *card,
> +					struct snd_soc_pcm_runtime *rtd,
> +					struct snd_soc_dai *codec_dai,
> +					struct snd_soc_dai *cpu_dai)
>   {
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>   	struct snd_soc_dapm_widget *sink, *source;
> -	int i;
>   
> -	for (i = 0; i < rtd->num_codecs; i++) {
> -		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +	/* connect BE DAI playback if widgets are valid */
> +	if (codec_dai->playback_widget && cpu_dai->playback_widget) {
> +		source = cpu_dai->playback_widget;
> +		sink = codec_dai->playback_widget;
> +		dev_err(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
> +				cpu_dai->component->name,
> +				source->name,
> +				codec_dai->component->name,
> +				sink->name);
> +
> +		snd_soc_dapm_add_path(&card->dapm, source, sink,
> +				NULL, NULL);
> +	}
>   
> -		/* connect BE DAI playback if widgets are valid */
> -		if (codec_dai->playback_widget && cpu_dai->playback_widget) {
> -			source = cpu_dai->playback_widget;
> -			sink = codec_dai->playback_widget;
> -			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
> -				cpu_dai->component->name, source->name,
> -				codec_dai->component->name, sink->name);
> +	/* connect BE DAI capture if widgets are valid */
> +	if (codec_dai->capture_widget && cpu_dai->capture_widget) {
> +		source = codec_dai->capture_widget;
> +		sink = cpu_dai->capture_widget;
> +		dev_err(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
> +				codec_dai->component->name,
> +				source->name,
> +				cpu_dai->component->name,
> +				sink->name);
>   
> -			snd_soc_dapm_add_path(&card->dapm, source, sink,
> +		snd_soc_dapm_add_path(&card->dapm, source, sink,
>   				NULL, NULL);
> -		}
> +	}
> +
> +}
>   
> -		/* connect BE DAI capture if widgets are valid */
> -		if (codec_dai->capture_widget && cpu_dai->capture_widget) {
> -			source = codec_dai->capture_widget;
> -			sink = cpu_dai->capture_widget;
> -			dev_dbg(rtd->dev, "connected DAI link %s:%s -> %s:%s\n",
> -				codec_dai->component->name, source->name,
> -				cpu_dai->component->name, sink->name);
> +static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
> +					  struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *cpu_dai;
> +	int i, j;
>   
> -			snd_soc_dapm_add_path(&card->dapm, source, sink,
> -				NULL, NULL);
> +	for (i = 0; i < rtd->num_codecs; i++) {
> +		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
> +
> +		for (j = 0; j < rtd->num_cpu_dai; j++) {
> +			cpu_dai = rtd->cpu_dais[j];
> +
> +			dapm_add_valid_dai_widget(card, rtd,
> +						codec_dai, cpu_dai);
>   		}
>   	}
>   }
> @@ -4206,7 +4225,9 @@ static void soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream,
>   {
>   	int i;
>   
> -	soc_dapm_dai_stream_event(rtd->cpu_dai, stream, event);
> +	for (i = 0; i < rtd->num_cpu_dai; i++)
> +		soc_dapm_dai_stream_event(rtd->cpu_dais[i], stream, event);
> +
>   	for (i = 0; i < rtd->num_codecs; i++)
>   		soc_dapm_dai_stream_event(rtd->codec_dais[i], stream, event);
>   
