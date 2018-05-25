From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v5 2/3] ASoC: Add multiple CPU DAI support
 for PCM ops
Date: Fri, 25 May 2018 10:16:27 +0530
Message-ID: <20180525044627.GE3116@snc-desk>
References: <1526985623-2606-1-git-send-email-shreyas.nc@intel.com>
 <1526985623-2606-3-git-send-email-shreyas.nc@intel.com>
 <a5934a1f-0f0a-98b7-40ae-d691a779acab@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 57B2C267646
 for <alsa-devel@alsa-project.org>; Fri, 25 May 2018 06:48:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <a5934a1f-0f0a-98b7-40ae-d691a779acab@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 24, 2018 at 04:29:45PM -0500, Pierre-Louis Bossart wrote:
> This one is also quite dense, I could use clarifications on how channels
> will be handled in a multi-cpu context. I believe for the multi-codec case
> there was an assumption of symmetry, not sure this works or is required in a
> multi-cpu case, see below.

I am not sure if I understand symmetry correctly. Mark, can you please help us
here ?

> >-	symmetry = cpu_dai->driver->symmetric_channels ||
> >-		rtd->dai_link->symmetric_channels;
> >+	symmetry = rtd->dai_link->symmetric_channels;
> >+
> >+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_channels;
> >  	for (i = 0; i < rtd->num_codecs; i++)
> >  		symmetry |= rtd->codec_dais[i]->driver->symmetric_channels;
> >-	if (symmetry && cpu_dai->channels && cpu_dai->channels != channels) {
> >-		dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
> >-				cpu_dai->channels, channels);
> >-		return -EINVAL;
> >-	}
> >+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >+		if (symmetry && rtd->cpu_dais[i]->channels &&
> >+				rtd->cpu_dais[i]->channels != channels) {
> >+			dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
> >+					rtd->cpu_dais[i]->channels, channels);
> >+			return -EINVAL;
> >+		}
> I am not sure I get this part - but maybe I am connecting too many dots with
> the SoundWire 'stream' patches.
> 
> This code is assuming all cpu_dais have the same number of channels, defined
> by the hw_params.

Yes

> Is this right? In the SoundWire case, we can have one port with 2 channels
> and another with 4, for a total of 6 channels for the stream. Am I missing
> something or how should I reconcile the concepts?
> 

In the case you have explained, the stream has 6 channels. But, from the
machine driver we can have set channel masks on each of these DAIs
accordingly.

> making the assumption that the rates and sample_bits are identical is ok.
> 
> >-	symmetry = cpu_dai->driver->symmetric_samplebits ||
> >-		rtd->dai_link->symmetric_samplebits;
> >+	symmetry = rtd->dai_link->symmetric_samplebits;
> >+
> >+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_samplebits;
> >  	for (i = 0; i < rtd->num_codecs; i++)
> >  		symmetry |= rtd->codec_dais[i]->driver->symmetric_samplebits;
> >-	if (symmetry && cpu_dai->sample_bits && cpu_dai->sample_bits != sample_bits) {
> >-		dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
> >-				cpu_dai->sample_bits, sample_bits);
> >-		return -EINVAL;
> >-	}
> >+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >+		if (symmetry && rtd->cpu_dais[i]->sample_bits &&
> >+				rtd->cpu_dais[i]->sample_bits != sample_bits) {
> >+			dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
> >+						rtd->cpu_dais[i]->sample_bits,
> >+								sample_bits);
> >+			return -EINVAL;
> >+		}
> >  	return 0;
> >  }
> >@@ -308,13 +328,18 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
> >  static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >-	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
> >  	struct snd_soc_dai_link *link = rtd->dai_link;
> >  	unsigned int symmetry, i;
> >-	symmetry = cpu_driver->symmetric_rates || link->symmetric_rates ||
> >-		cpu_driver->symmetric_channels || link->symmetric_channels ||
> >-		cpu_driver->symmetric_samplebits || link->symmetric_samplebits;
> >+	symmetry = link->symmetric_rates || link->symmetric_channels ||
> >+			link->symmetric_samplebits;
> >+
> >+	/* Apply symmetery for multiple cpu dais */
> I've never seen this spelling for cemetery :-)
> 

Never meant it to be cemetery for sure :D
Will correct it, Thanks!

> [...]
> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		cpu_dai_drv = rtd->cpu_dais[i]->driver;
> >+
> >+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >+			cpu_stream = &cpu_dai_drv->playback;
> >+		else
> >+			cpu_stream = &cpu_dai_drv->capture;
> >+
> >+		cpu_chan_min = max(cpu_chan_min,
> >+					cpu_stream->channels_min);
> >+		cpu_chan_max = min(cpu_chan_max,
> >+					cpu_stream->channels_max);
> >+
> >+		if (hw->formats)
> >+			hw->formats &= cpu_stream->formats;
> >+		else
> >+			hw->formats = cpu_stream->formats;
> >+
> >+		cpu_rates = snd_pcm_rate_mask_intersect(cpu_rates,
> >+						cpu_stream->rates);
> >+
> >+		cpu_rate_min = max(cpu_rate_min, cpu_stream->rate_min);
> >+		cpu_rate_max = min_not_zero(cpu_rate_max, cpu_stream->rate_max);
> >+	}
> >+
> >  	/*
> >-	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
> >-	 * connected to a single CPU DAI, use CPU DAI's directly and let
> >-	 * channel allocation be fixed up later
> >+	 * chan min/max cannot be enforced if there are multiple
> >+	 * CODEC DAIs connected to CPU DAI(s), use CPU DAI's
> >+	 * directly and let channel allocation be fixed up later
> What does 'later' mean?
> I guess I don't quite get the channel management, same issue as my feedback
> above.
> 

I think 'later' here means channel allocation can then be fixed by using
_set_channel_map(), be_hw_params_fixup()

> [...]
> >
> >@@ -963,11 +1070,14 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
> >  	if (ret < 0)
> >  		goto component_err;
> >-	/* store the parameters for each DAIs */
> >-	cpu_dai->rate = params_rate(params);
> >-	cpu_dai->channels = params_channels(params);
> >-	cpu_dai->sample_bits =
> >-		snd_pcm_format_physical_width(params_format(params));
> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		/* store the parameters for each DAIs */
> >+		cpu_dai = rtd->cpu_dais[i];
> >+		cpu_dai->rate = params_rate(params);
> >+		cpu_dai->channels = params_channels(params);
> same here, are we again making the assumption that all cpu_dais can transmit
> the same number of channels?
> 

Yes. But, as explained earlier machine can then set the channels masks on
these CPU DAIs

> [...]
> >@@ -1107,10 +1229,14 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
> >  			return ret;
> >  	}
> >-	if (cpu_dai->driver->ops->trigger) {
> >-		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
> >-		if (ret < 0)
> >-			return ret;
> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		cpu_dai = rtd->cpu_dais[i];
> >+		if (cpu_dai->driver->ops->trigger) {
> >+			ret = cpu_dai->driver->ops->trigger(substream,
> >+								cmd, cpu_dai);
> How do I reconcile this sequential trigger with the notion of bank-switch in
> SoundWire? It seems we are missing a global trigger for all cpu_dais who are
> part of the same dailink? Or am I in the weeds again?
> 

Yes, there is no global trigger for all cpu_dais specifically.
And for Soundwire, this is the reason we chose to call from machine/platform

> [...]
> >@@ -1157,12 +1287,13 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >  	struct snd_soc_component *component;
> >  	struct snd_soc_rtdcom_list *rtdcom;
> >-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >+	struct snd_soc_dai *cpu_dai;
> >  	struct snd_soc_dai *codec_dai;
> >  	struct snd_pcm_runtime *runtime = substream->runtime;
> >  	snd_pcm_uframes_t offset = 0;
> >  	snd_pcm_sframes_t delay = 0;
> >  	snd_pcm_sframes_t codec_delay = 0;
> >+	snd_pcm_sframes_t cpu_delay = 0;
> >  	int i;
> >  	for_each_rtdcom(rtd, rtdcom) {
> >@@ -1177,8 +1308,15 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
> >  		break;
> >  	}
> >-	if (cpu_dai->driver->ops->delay)
> >-		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		cpu_dai = rtd->cpu_dais[i];
> >+		if (cpu_dai->driver->ops->delay)
> >+			cpu_delay = max(cpu_delay,
> >+					cpu_dai->driver->ops->delay(substream,
> >+								cpu_dai));
> >+	}
> >+
> >+	delay += cpu_delay;
> Oh, this is weird. If you are checking the delay sequentially for each
> cpu_dai, what are the odds that you get a consistent reply? I think it's
> fundamentally different from the codec side since you will in theory be able
> to check delays on each cpu_dai fairly quickly over IPC, whereas for codecs
> the delay is likely to be a long-term estimate, not an immediate value. In
> addition you would probably expect that all cpu_dais are triggered at the
> same time and hence have the same delay, so you could use the cpu_dais[0]
> instead of querying the values multiple times.
> 
That sounds like a fair arguement to me. Just wondering if there can be a
case of multiple CPU DAIs but you would not want them to be triggered at the
same time.

Thanks for the review!

--Shreyas

-- 
