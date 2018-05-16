From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 2/3] ASoC: Add multiple CPU DAI support
	for PCM ops
Date: Wed, 16 May 2018 13:55:39 +0100
Message-ID: <20180516125539.GA20410@imbe.wolfsonmicro.main>
References: <1525776335-26259-1-git-send-email-shreyas.nc@intel.com>
 <1525776335-26259-3-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F62F266F44
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 14:55:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1525776335-26259-3-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 08, 2018 at 04:15:34PM +0530, Shreyas NC wrote:
> Add support in PCM operations to invoke multiple cpu dais as we do
> for multiple codec dais. Also the symmetry calculations are updated to
> reflect multiple cpu dais.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
>  sound/soc/soc-pcm.c | 487 +++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 326 insertions(+), 161 deletions(-)

Getting down to the last few comments from me :-)

> @@ -313,13 +333,18 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
>  static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
>  	struct snd_soc_dai_link *link = rtd->dai_link;
> -	unsigned int symmetry, i;
> +	unsigned int symmetry = 0, i;

No need to init this to zero you are explicitly setting it
straight after.

>  
> -	symmetry = cpu_driver->symmetric_rates || link->symmetric_rates ||
> -		cpu_driver->symmetric_channels || link->symmetric_channels ||
> -		cpu_driver->symmetric_samplebits || link->symmetric_samplebits;
> +	symmetry = link->symmetric_rates || link->symmetric_channels ||
> +			link->symmetric_samplebits;

> @@ -427,30 +466,55 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
>  		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
>  	}
>  
> +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> +		cpu_dai_drv = rtd->cpu_dais[i]->driver;
> +
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			cpu_stream = &cpu_dai_drv->playback;
> +		else
> +			cpu_stream = &cpu_dai_drv->capture;
> +
> +		cpu_chan_min = max(hw->channels_min,
> +					cpu_stream->channels_min);
> +		cpu_chan_max = min(hw->channels_max,
> +					cpu_stream->channels_max);

At the end of the loop cpu_chan_min and cpu_chan_max will only
have considered the channels_min/max from the last cpu DAI, is
that the behaviour you wanted?

> +
> +		if (hw->formats)
> +			hw->formats &= cpu_stream->formats;
> +		else
> +			hw->formats = cpu_stream->formats;
> +
> +		cpu_rates = snd_pcm_rate_mask_intersect(cpu_rates,
> +						cpu_stream->rates);
> +
> +		cpu_rate_min = max(hw->rate_min, cpu_stream->rate_min);
> +		cpu_rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);

Same here with cpu_rate_min and cpu_rate_max all the first n-1 CPU
DAIs are ignored and only the last DAI is considered.

> @@ -1162,7 +1292,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  	struct snd_soc_component *component;
>  	struct snd_soc_rtdcom_list *rtdcom;
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *cpu_dai;
>  	struct snd_soc_dai *codec_dai;
>  	struct snd_pcm_runtime *runtime = substream->runtime;
>  	snd_pcm_uframes_t offset = 0;
> @@ -1182,8 +1312,12 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
>  		break;
>  	}
>  
> -	if (cpu_dai->driver->ops->delay)
> -		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
> +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> +		cpu_dai = rtd->cpu_dais[i];
> +		if (cpu_dai->driver->ops->delay)
> +			delay += cpu_dai->driver->ops->delay(substream,
> +								cpu_dai);
> +	}

Should we be adding these delays? Wouldn't it be better to use
the max CPU DAI delay as we do for the CODECs, or is there a
reason these are additive?

>  
>  	for (i = 0; i < rtd->num_codecs; i++) {
>  		codec_dai = rtd->codec_dais[i];
> @@ -1306,12 +1440,16 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
>  			if (!be->dai_link->no_pcm)
>  				continue;
>  
> -			dev_dbg(card->dev, "ASoC: try BE : %s\n",
> -				be->cpu_dai->playback_widget ?
> -				be->cpu_dai->playback_widget->name : "(not set)");
> +			for (i = 0; i < be->num_cpu_dai; i++) {
> +				struct snd_soc_dai *cpu_dai = be->cpu_dais[i];
> +
> +				dev_dbg(card->dev, "ASoC: try BE : %s\n",
> +					cpu_dai->playback_widget ?
> +					cpu_dai->playback_widget->name : "(not set)");
>  
> -			if (be->cpu_dai->playback_widget == widget)
> -				return be;
> +				if (cpu_dai->playback_widget == widget)
> +					return be;
> +			}
>  
>  			for (i = 0; i < be->num_codecs; i++) {
>  				struct snd_soc_dai *dai = be->codec_dais[i];
> @@ -1326,12 +1464,16 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
>  			if (!be->dai_link->no_pcm)
>  				continue;
>  
> -			dev_dbg(card->dev, "ASoC: try BE %s\n",
> -				be->cpu_dai->capture_widget ?
> -				be->cpu_dai->capture_widget->name : "(not set)");
> +			for (i = 0; i < be->num_cpu_dai; i++) {
> +				struct snd_soc_dai *cpu_dai = be->cpu_dais[i];
>  
> -			if (be->cpu_dai->capture_widget == widget)
> -				return be;
> +				dev_dbg(card->dev, "ASoC: try BE %s\n",
> +					cpu_dai->capture_widget ?
> +					cpu_dai->capture_widget->name : "(not set)");
> +
> +				if (cpu_dai->capture_widget == widget)
> +					return be;
> +			}
>  
>  			for (i = 0; i < be->num_codecs; i++) {
>  				struct snd_soc_dai *dai = be->codec_dais[i];

I still think you need to get Liam or someone to review this DPCM
stuff. Multi-CPU DAIs feels like it could be a tricky thing to
merge with DPCM and I am not sure I am confident enough in me
reviewing it right.

Thanks,
Charles
