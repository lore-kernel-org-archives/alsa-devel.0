From: Shreyas NC <shreyas.nc@intel.com>
Subject: Re: [PATCH v6 2/3] ASoC: Add multiple CPU DAI support
 for PCM ops
Date: Fri, 22 Jun 2018 10:34:39 +0530
Message-ID: <20180622050439.GQ3116@snc-desk>
References: <1529492057-32627-1-git-send-email-shreyas.nc@intel.com>
 <1529492057-32627-3-git-send-email-shreyas.nc@intel.com>
 <90ab816f-e355-032f-3db9-2416ce7bae0e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9414D2673F2
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 07:06:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <90ab816f-e355-032f-3db9-2416ce7bae0e@linux.intel.com>
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

On Thu, Jun 21, 2018 at 09:43:50PM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 06/20/2018 05:54 AM, Shreyas NC wrote:
> >Add support in PCM operations to invoke multiple cpu dais as we do
> >for multiple codec dais. Also the symmetry calculations are updated to
> >reflect multiple cpu dais.
> This doesn't apply on Mark's tree?
> Looks like you need to rebase on top of 244e293690a6 ("ASoC: pcm: Tidy up
> open/hw_params handling")
> contributed by Charles on June 19.

I did rebase the morning before I sent these patches, may be I should do it
just before sending them out. Will take care of that next time :)

> >
> >Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >Signed-off-by: Vinod Koul <vkoul@kernel.org>
> >Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> >---
> >  sound/soc/soc-pcm.c | 491 +++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 332 insertions(+), 159 deletions(-)
> >
> >diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
> >index 5e7ae47..cdcbc4f 100644
> >--- a/sound/soc/soc-pcm.c
> >+++ b/sound/soc/soc-pcm.c
> >@@ -64,23 +64,27 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
> >   */
> >  void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
> >  {
> >-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >  	int i;
> >  	lockdep_assert_held(&rtd->pcm_mutex);
> >  	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >-		cpu_dai->playback_active++;
> >+		for (i = 0; i < rtd->num_cpu_dai; i++)
> >+			rtd->cpu_dais[i]->playback_active++;
> >  		for (i = 0; i < rtd->num_codecs; i++)
> >  			rtd->codec_dais[i]->playback_active++;
> >  	} else {
> >-		cpu_dai->capture_active++;
> >+		for (i = 0; i < rtd->num_cpu_dai; i++)
> >+			rtd->cpu_dais[i]->capture_active++;
> >  		for (i = 0; i < rtd->num_codecs; i++)
> >  			rtd->codec_dais[i]->capture_active++;
> >  	}
> >-	cpu_dai->active++;
> >-	cpu_dai->component->active++;
> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		rtd->cpu_dais[i]->component->active++;
> >+		rtd->cpu_dais[i]->active++;
> >+	}
> 
> This is becoming complicated, how many times do we need to ref-count?

Earlier we incremented cpu_dai->playback_active++ and here it is
cpu_dais->component->active++

> >+
> >  	for (i = 0; i < rtd->num_codecs; i++) {
> >  		rtd->codec_dais[i]->active++;
> >  		rtd->codec_dais[i]->component->active++;
> >@@ -99,23 +103,27 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
> >   */
> >  void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
> >  {
> >-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >  	int i;
> >  	lockdep_assert_held(&rtd->pcm_mutex);
> >  	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> >-		cpu_dai->playback_active--;
> >+		for (i = 0; i < rtd->num_cpu_dai; i++)
> >+			rtd->cpu_dais[i]->playback_active--;
> >  		for (i = 0; i < rtd->num_codecs; i++)
> >  			rtd->codec_dais[i]->playback_active--;
> >  	} else {
> >-		cpu_dai->capture_active--;
> >+		for (i = 0; i < rtd->num_cpu_dai; i++)
> >+			rtd->cpu_dais[i]->capture_active--;
> >  		for (i = 0; i < rtd->num_codecs; i++)
> >  			rtd->codec_dais[i]->capture_active--;
> >  	}
> >-	cpu_dai->active--;
> >-	cpu_dai->component->active--;
> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		rtd->cpu_dais[i]->component->active--;
> >+		rtd->cpu_dais[i]->active--;
> >+	}
> >+
> >  	for (i = 0; i < rtd->num_codecs; i++) {
> >  		rtd->codec_dais[i]->component->active--;
> >  		rtd->codec_dais[i]->active--;
> >@@ -258,7 +266,6 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
> >  				struct snd_pcm_hw_params *params)
> >  {
> >  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> >-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >  	unsigned int rate, channels, sample_bits, symmetry, i;
> >  	rate = params_rate(params);
> >@@ -266,41 +273,54 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
> >  	sample_bits = snd_pcm_format_physical_width(params_format(params));
> >  	/* reject unmatched parameters when applying symmetry */
> >-	symmetry = cpu_dai->driver->symmetric_rates ||
> >-		rtd->dai_link->symmetric_rates;
> This was a logical OR, but...
> 
> >+	symmetry = rtd->dai_link->symmetric_rates;
> >+
> >+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_rates;
> this is a bitwise OR. is this ok?

I made this change on purpose and I am struggling to remember the reason :(
If I dont figure that out, I will go back to logical OR..

> >  	for (i = 0; i < rtd->num_codecs; i++)
> >  		symmetry |= rtd->codec_dais[i]->driver->symmetric_rates;
> >-	if (symmetry && cpu_dai->rate && cpu_dai->rate != rate) {
> >-		dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
> >-				cpu_dai->rate, rate);
> >-		return -EINVAL;
> >-	}
> >+	for (i = 0; i < rtd->num_cpu_dai; i++)
> >+		if (symmetry && rtd->cpu_dais[i]->rate &&
> you could move the if (symmetry) out of the for loop to simplify

Yes, that makes sense :)

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
> You haven't fixed this comment, is this patch the correct one?

I am surprised why this crept in :(
This was the first comment I fixed ..

> >@@ -422,30 +461,55 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
> >  		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
> >  	}
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
> Can you double-check the 'else' case? This doesn't seem right, you will
> always use the format used for the last cpu_dai. If the formats are
> identical for all cpu_dais, then this can be moved outside of the loop.

In the second iteration, we would always go into the if (hw->formats) case.

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
> >+		cpu_dai->sample_bits =
> >+			snd_pcm_format_physical_width(params_format(params));
> >+	}
> I think I've asked this before but can't recall the answer: does this mean
> we assume the same number of channels for each codec_dai[j] and cpu_dai[i]?
> 

Yes, in hw_params we set the same number channels on all the DAIs as that of the
stream. But, as I had mentioned in my previous replies, the
machine driver would set the channel masks on the individual DAIs(like we do
for SoundWire Multi link case)

> >+	for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+		cpu_dai = rtd->cpu_dais[i];
> >+		if (cpu_dai->driver->ops->trigger) {
> >+			ret = cpu_dai->driver->ops->trigger(substream,
> >+								cmd, cpu_dai);
> >+			if (ret < 0)
> >+				return ret;
> >+		}
> 
> Maybe add a comment that in the multi_cpu case the triggers are supposed to
> be aligned, i.e. the first trigger starts the others - that would be
> consistent with the other comments on delay below.

Would this be the right place to add that comment?
I am not sure if I got a reply to my question in the previous review cycle:
"Just wondering if there can be a case of multiple CPU DAIs but you would
not want them to be triggered at the same time."

Based on the answer to my question , we can add a comment here.

> >@@ -1778,11 +1941,13 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
> >  			be_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
> >  		/* Symmetry only applies if we've got an active stream. */
> >-		if (rtd->cpu_dai->active) {
> >-			err = soc_pcm_apply_symmetry(fe_substream,
> >-						     rtd->cpu_dai);
> >-			if (err < 0)
> >-				return err;
> >+		for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+			if (rtd->cpu_dais[i]->active) {
> >+				err = soc_pcm_apply_symmetry(be_substream,
> >+							rtd->cpu_dais[i]);
> >+				if (err < 0)
> >+					return err;
> >+			}
> >  		}
> Can you recheck this block? In the original code the symmetry is with the
> fe_substream, it's now with a be_substream. Looks to me like a major typo
> having significant impact of the result...
> 

This was recently fixed and changed from be_substream to fe_substream :(
commit 99bcedbdebc57fe5d02fb470b7265f2208c2cf96

    ASoC: dpcm: symmetry constraint on FE substream

So, I need to fix my patch as well. Nice catch :)

> >  		for (i = 0; i < rtd->num_codecs; i++) {
> >@@ -2884,13 +3049,13 @@ static int soc_rtdcom_mmap(struct snd_pcm_substream *substream,
> >  int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> >  {
> >  	struct snd_soc_dai *codec_dai;
> >-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> >+	struct snd_soc_dai *cpu_dai;
> >  	struct snd_soc_component *component;
> >  	struct snd_soc_rtdcom_list *rtdcom;
> >  	struct snd_pcm *pcm;
> >  	char new_name[64];
> >  	int ret = 0, playback = 0, capture = 0;
> >-	int i;
> >+	int i, cpu_capture = 0, cpu_playback = 0;
> >  	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
> >  		playback = rtd->dai_link->dpcm_playback;
> >@@ -2904,8 +3069,16 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> >  				capture = 1;
> >  		}
> >-		capture = capture && cpu_dai->driver->capture.channels_min;
> >-		playback = playback && cpu_dai->driver->playback.channels_min;
> >+		for (i = 0; i < rtd->num_cpu_dai; i++) {
> >+			cpu_dai = rtd->cpu_dais[i];
> >+			if (cpu_dai->driver->playback.channels_min)
> >+				cpu_playback = 1;
> >+			if (cpu_dai->driver->capture.channels_min)
> >+				cpu_capture = 1;
> >+		}
> >+
> >+		playback = playback && cpu_playback;
> >+		capture = capture && cpu_capture;
> >  	}
> >  	if (rtd->dai_link->playback_only) {
> >@@ -3026,7 +3199,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
> >  out:
> >  	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
> >  		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
> >-		 cpu_dai->name);
> >+		 (rtd->num_cpu_dai > 1) ? "multicpu" : rtd->cpu_dai->name);
> >  	return ret;
> >  }
> 
> Took me a couple of hours to reach the end of this patch ... I had to use a
> visual diff to figure it out, the diff format is just too hard to look at.
> 

Unfortunately yes :(

-- 
