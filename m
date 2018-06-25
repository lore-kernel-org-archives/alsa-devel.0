From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v6 2/3] ASoC: Add multiple CPU DAI support
 for PCM ops
Date: Mon, 25 Jun 2018 10:29:29 +0530
Message-ID: <20180625045929.GB15119@snc-desk>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-3-git-send-email-shreyas.nc@intel.com>
 <90ab816f-e355-032f-3db9-2416ce7bae0e@linux.intel.com>
 <20180622050439.GQ3116@snc-desk>
 <02b8fd72-38b9-2df8-b580-bbac492a431e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id E6CEF2673F5
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 07:00:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <02b8fd72-38b9-2df8-b580-bbac492a431e@linux.intel.com>
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

On Fri, Jun 22, 2018 at 11:05:00AM -0500, Pierre-Louis Bossart wrote:
> 
> >>>@@ -64,23 +64,27 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
> >>>   */
> >>>  void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
> >>>  {
> >>>-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >>>  	int i;
> >>>  	lockdep_assert_held(&rtd->pcm_mutex);
> >>>  	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >>>-		cpu_dai->playback_active++;
> >>>+		for (i = 0; i < rtd->num_cpu_dai; i++)
> >>>+			rtd->cpu_dais[i]->playback_active++;
> >>>  		for (i = 0; i < rtd->num_codecs; i++)
> >>>  			rtd->codec_dais[i]->playback_active++;
> >>>  	} else {
> >>>-		cpu_dai->capture_active++;
> >>>+		for (i = 0; i < rtd->num_cpu_dai; i++)
> >>>+			rtd->cpu_dais[i]->capture_active++;
> >>>  		for (i = 0; i < rtd->num_codecs; i++)
> >>>  			rtd->codec_dais[i]->capture_active++;
> >>>  	}
> >>>-	cpu_dai->active++;
> >>>-	cpu_dai->component->active++;
> >>>+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >>>+		rtd->cpu_dais[i]->component->active++;
> >>>+		rtd->cpu_dais[i]->active++;
> >>>+	}
> >>
> >>This is becoming complicated, how many times do we need to ref-count?
> >
> >Earlier we incremented cpu_dai->playback_active++ and here it is
> >cpu_dais->component->active++
> 
> my point was whether this can be simplified to use a single counter, even
> before we do the change to multi-cpu?
> 

Ok

> >>>@@ -258,7 +266,6 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
> >>>  				struct snd_pcm_hw_params *params)
> >>>  {
> >>>  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >>>-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >>>  	unsigned int rate, channels, sample_bits, symmetry, i;
> >>>  	rate = params_rate(params);
> >>>@@ -266,41 +273,54 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
> >>>  	sample_bits = snd_pcm_format_physical_width(params_format(params));
> >>>  	/* reject unmatched parameters when applying symmetry */
> >>>-	symmetry = cpu_dai->driver->symmetric_rates ||
> >>>-		rtd->dai_link->symmetric_rates;
> >>This was a logical OR, but...
> >>
> >>>+	symmetry = rtd->dai_link->symmetric_rates;
> >>>+
> >>>+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >>>+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_rates;
> >>this is a bitwise OR. is this ok?
> >
> >I made this change on purpose and I am struggling to remember the reason :(
> >If I dont figure that out, I will go back to logical OR..
> 
> the same change was made for multiple codecs, but it's worth rechecking.
> 

Yes, I will check this :)

> >>>@@ -422,30 +461,55 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
> >>>  		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
> >>>  	}
> >>>+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >>>+		cpu_dai_drv = rtd->cpu_dais[i]->driver;
> >>>+
> >>>+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> >>>+			cpu_stream = &cpu_dai_drv->playback;
> >>>+		else
> >>>+			cpu_stream = &cpu_dai_drv->capture;
> >>>+
> >>>+		cpu_chan_min = max(cpu_chan_min,
> >>>+					cpu_stream->channels_min);
> >>>+		cpu_chan_max = min(cpu_chan_max,
> >>>+					cpu_stream->channels_max);
> >>>+
> >>>+		if (hw->formats)
> >>>+			hw->formats &= cpu_stream->formats;
> >>>+		else
> >>>+			hw->formats = cpu_stream->formats;
> >>Can you double-check the 'else' case? This doesn't seem right, you will
> >>always use the format used for the last cpu_dai. If the formats are
> >>identical for all cpu_dais, then this can be moved outside of the loop.
> >
> >In the second iteration, we would always go into the if (hw->formats) case.
> 
> Sorry I don't get your comment. This test is now placed inside of a for
> loop, so why would the hw->formats change between iterations?
> 

Ok, the else case can be hit only for the first time(if hw->formats == 0)
when  we enter the loop.

I get your point, will fix this :)
 
> >
> >>>@@ -963,11 +1070,14 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
> >>>  	if (ret < 0)
> >>>  		goto component_err;
> >>>-	/* store the parameters for each DAIs */
> >>>-	cpu_dai->rate = params_rate(params);
> >>>-	cpu_dai->channels = params_channels(params);
> >>>-	cpu_dai->sample_bits =
> >>>-		snd_pcm_format_physical_width(params_format(params));
> >>>+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >>>+		/* store the parameters for each DAIs */
> >>>+		cpu_dai = rtd->cpu_dais[i];
> >>>+		cpu_dai->rate = params_rate(params);
> >>>+		cpu_dai->channels = params_channels(params);
> >>>+		cpu_dai->sample_bits =
> >>>+			snd_pcm_format_physical_width(params_format(params));
> >>>+	}
> >>I think I've asked this before but can't recall the answer: does this mean
> >>we assume the same number of channels for each codec_dai[j] and cpu_dai[i]?
> >>
> >
> >Yes, in hw_params we set the same number channels on all the DAIs as that of the
> >stream. But, as I had mentioned in my previous replies, the
> >machine driver would set the channel masks on the individual DAIs(like we do
> >for SoundWire Multi link case)
> 
> so the number of channels is really defined by the stream, and for each
> cpu_dai and codec_dai there is a channel mask defining what the dais should
> produce/consume, right?
> 

Yes

> >
> >>>+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >>>+		cpu_dai = rtd->cpu_dais[i];
> >>>+		if (cpu_dai->driver->ops->trigger) {
> >>>+			ret = cpu_dai->driver->ops->trigger(substream,
> >>>+								cmd, cpu_dai);
> >>>+			if (ret < 0)
> >>>+				return ret;
> >>>+		}
> >>
> >>Maybe add a comment that in the multi_cpu case the triggers are supposed to
> >>be aligned, i.e. the first trigger starts the others - that would be
> >>consistent with the other comments on delay below.
> >
> >Would this be the right place to add that comment?
> >I am not sure if I got a reply to my question in the previous review cycle:
> >"Just wondering if there can be a case of multiple CPU DAIs but you would
> >not want them to be triggered at the same time."
> >
> >Based on the answer to my question , we can add a comment here.
> 
> If you use the stream/multi cpu_dai concept you want the data to remain
> phase locked and triggered at the same time. If you don't care about phase,
> then you are handling different streams that can be handled with the
> existing model with a set of runtimes that deal with individual cpu_dais.
> 

Ok, will add a comment here :)

--Shreyas

-- 
