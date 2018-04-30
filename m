From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/3] ASoC: Add Multi CPU DAI support for
 PCM ops
Date: Mon, 30 Apr 2018 17:22:36 +0100
Message-ID: <20180430162236.xapskcplyphwbloe@localhost.localdomain>
References: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
 <1524131359-24387-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F790266C1C
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 18:22:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524131359-24387-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 03:19:18PM +0530, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
> 
> This adds support for Multi CPU DAIs in PCM ops and stream
> handling functions.
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
> @@ -347,10 +372,10 @@ static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
>  static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> -	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *cpu_dai;
>  	struct snd_soc_dai *codec_dai;
>  	int i;
> -	unsigned int bits = 0, cpu_bits;
> +	unsigned int bits = 0, cpu_bits = 0;
>  
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
>  		for (i = 0; i < rtd->num_codecs; i++) {
> @@ -361,7 +386,16 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
>  			}
>  			bits = max(codec_dai->driver->playback.sig_bits, bits);
>  		}
> -		cpu_bits = cpu_dai->driver->playback.sig_bits;
> +
> +		for (i = 0; i < rtd->num_cpu_dai; i++) {
> +			cpu_dai = rtd->cpu_dais[i];
> +			if (cpu_dai->driver->playback.sig_bits == 0) {
> +				cpu_bits = 0;
> +				break;
> +			}
> +
> +			cpu_bits = max(cpu_dai->driver->playback.sig_bits, bits);

Do you want cpu_bits at the end here? You are not going to get
the max of the cpu_bits here, you will end up with the max of the
CODEC bits and the last CPU bits?

> @@ -427,30 +464,47 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
>  		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
>  	}
>  
> -	/*
> -	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
> -	 * connected to a single CPU DAI, use CPU DAI's directly and let
> -	 * channel allocation be fixed up later
> -	 */
> -	if (rtd->num_codecs > 1) {
> -		chan_min = cpu_stream->channels_min;
> -		chan_max = cpu_stream->channels_max;
> -	}
> +	for (i = 0; i < rtd->num_cpu_dai; i++) {
> +		cpu_dai_drv = rtd->cpu_dais[i]->driver;
>  
> -	hw->channels_min = max(chan_min, cpu_stream->channels_min);
> -	hw->channels_max = min(chan_max, cpu_stream->channels_max);
> -	if (hw->formats)
> -		hw->formats &= formats & cpu_stream->formats;
> -	else
> -		hw->formats = formats & cpu_stream->formats;
> -	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_stream->rates);
> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +			cpu_stream = &cpu_dai_drv->playback;
> +		else
> +			cpu_stream = &cpu_dai_drv->capture;
>  
> -	snd_pcm_limit_hw_rates(runtime);
> +		/*
> +		 * chan min/max cannot be enforced if there are multiple
> +		 * CODEC DAIs connected to a single CPU DAI, use CPU DAI's
> +		 * directly and let channel allocation be fixed up later
> +		 */
> +		if (rtd->num_codecs > 1 && rtd->num_cpu_dai == 1) {
> +			chan_min = cpu_stream->channels_min;
> +			chan_max = cpu_stream->channels_max;
> +		}

This still doesn't quite look like, I am not seeing how the
multiple CPU DAI and single CPU DAI cases differ with respect to
whether we should ignore the CODEC channel settings?

> +
> +		hw->channels_min = max(hw->channels_min, chan_min);
> +		hw->channels_min = max(hw->channels_min,
> +					cpu_stream->channels_min);
> +		hw->channels_max = min(hw->channels_max,
> +					cpu_stream->channels_max);
> +		hw->channels_max = min(hw->channels_max,
> +					cpu_stream->channels_max);
> +
> +		if (hw->formats)
> +			hw->formats &= formats & cpu_stream->formats;

Minor nit.

This feels a little funny now, since we are anding each CPU
formats with the CODEC formats, and then anding them into the
result.

Feels like we should just and in the CODEC format once.

> +		else
> +			hw->formats = formats & cpu_stream->formats;

> +
> +		hw->rates = snd_pcm_rate_mask_intersect(rates,
> +						cpu_stream->rates);

I think this is broken since the rates will end up and the
intersection of the last CPU DAI rates and the CODEC rates, not
an intersection of all the CPU rates.

> @@ -602,7 +668,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
>  	}
>  
>  	pr_debug("ASoC: %s <-> %s info:\n",
> -			codec_dai_name, cpu_dai->name);
> +			codec_dai_name, cpu_dai_name);
>  	pr_debug("ASoC: rate mask 0x%x\n", runtime->hw.rates);
>  	pr_debug("ASoC: min ch %d max ch %d\n", runtime->hw.channels_min,
>  		 runtime->hw.channels_max);
> @@ -649,9 +715,13 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
>  		platform->driver->ops->close(substream);
>  
>  platform_err:
> -	if (cpu_dai->driver->ops->shutdown)
> -		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
> -out:
> +	j = rtd->num_cpu_dai;
> +	while (--j >= 0) {
> +		cpu_dai = rtd->cpu_dais[j];
> +		if (cpu_dai->driver->ops->shutdown)
> +			cpu_dai->driver->ops->shutdown(substream, cpu_dai);
> +	}
> +

This will call shutdown for DAIs that never had startup called on
them, probably better to avoid that.

> @@ -1070,12 +1168,18 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
>  		platform->driver->ops->hw_free(substream);
>  
>  platform_err:
> -	if (cpu_dai->driver->ops->hw_free)
> -		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
> +	j = rtd->num_cpu_dai;
>  
>  interface_err:
>  	i = rtd->num_codecs;
>  
> +	while (--j >= 0) {
> +		cpu_dai = rtd->cpu_dais[j];
> +
> +		if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
> +			cpu_dai->driver->ops->hw_free(substream, cpu_dai);
> +	}
> +

Minor nit might be nicer to add this before the i = since that
kinda relates to the code underneath.

>  codec_err:
>  	while (--i >= 0) {
>  		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];

Thanks,
Charles
