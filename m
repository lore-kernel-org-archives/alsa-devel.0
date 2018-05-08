From: Shreyas NC <shreyas.nc@intel.com>
Subject: [PATCH v4 2/3] ASoC: Add multiple CPU DAI support for
	PCM ops
Date: Tue,  8 May 2018 16:15:34 +0530
Message-ID: <1525776335-26259-3-git-send-email-shreyas.nc@intel.com>
References: <1525776335-26259-1-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 63FDB2676BA
 for <alsa-devel@alsa-project.org>; Tue,  8 May 2018 12:48:20 +0200 (CEST)
In-Reply-To: <1525776335-26259-1-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ckeepax@opensource.cirrus.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Add support in PCM operations to invoke multiple cpu dais as we do
for multiple codec dais. Also the symmetry calculations are updated to
reflect multiple cpu dais.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
---
 sound/soc/soc-pcm.c | 487 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 326 insertions(+), 161 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index da5a2dc..77ff279 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -64,23 +64,27 @@ static bool snd_soc_dai_stream_valid(struct snd_soc_dai *dai, int stream)
  */
 void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		cpu_dai->playback_active++;
+		for (i = 0; i < rtd->num_cpu_dai; i++)
+			rtd->cpu_dais[i]->playback_active++;
 		for (i = 0; i < rtd->num_codecs; i++)
 			rtd->codec_dais[i]->playback_active++;
 	} else {
-		cpu_dai->capture_active++;
+		for (i = 0; i < rtd->num_cpu_dai; i++)
+			rtd->cpu_dais[i]->capture_active++;
 		for (i = 0; i < rtd->num_codecs; i++)
 			rtd->codec_dais[i]->capture_active++;
 	}
 
-	cpu_dai->active++;
-	cpu_dai->component->active++;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		rtd->cpu_dais[i]->component->active++;
+		rtd->cpu_dais[i]->active++;
+	}
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		rtd->codec_dais[i]->active++;
 		rtd->codec_dais[i]->component->active++;
@@ -99,23 +103,27 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
  */
 void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		cpu_dai->playback_active--;
+		for (i = 0; i < rtd->num_cpu_dai; i++)
+			rtd->cpu_dais[i]->playback_active--;
 		for (i = 0; i < rtd->num_codecs; i++)
 			rtd->codec_dais[i]->playback_active--;
 	} else {
-		cpu_dai->capture_active--;
+		for (i = 0; i < rtd->num_cpu_dai; i++)
+			rtd->cpu_dais[i]->capture_active--;
 		for (i = 0; i < rtd->num_codecs; i++)
 			rtd->codec_dais[i]->capture_active--;
 	}
 
-	cpu_dai->active--;
-	cpu_dai->component->active--;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		rtd->cpu_dais[i]->component->active--;
+		rtd->cpu_dais[i]->active--;
+	}
+
 	for (i = 0; i < rtd->num_codecs; i++) {
 		rtd->codec_dais[i]->component->active--;
 		rtd->codec_dais[i]->active--;
@@ -263,7 +271,6 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	unsigned int rate, channels, sample_bits, symmetry, i;
 
 	rate = params_rate(params);
@@ -271,41 +278,54 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	sample_bits = snd_pcm_format_physical_width(params_format(params));
 
 	/* reject unmatched parameters when applying symmetry */
-	symmetry = cpu_dai->driver->symmetric_rates ||
-		rtd->dai_link->symmetric_rates;
+	symmetry = rtd->dai_link->symmetric_rates;
+
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_rates;
 
 	for (i = 0; i < rtd->num_codecs; i++)
 		symmetry |= rtd->codec_dais[i]->driver->symmetric_rates;
 
-	if (symmetry && cpu_dai->rate && cpu_dai->rate != rate) {
-		dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
-				cpu_dai->rate, rate);
-		return -EINVAL;
-	}
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		if (symmetry && rtd->cpu_dais[i]->rate &&
+					rtd->cpu_dais[i]->rate != rate) {
+			dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
+					rtd->cpu_dais[i]->rate, rate);
+			return -EINVAL;
+		}
 
-	symmetry = cpu_dai->driver->symmetric_channels ||
-		rtd->dai_link->symmetric_channels;
+	symmetry = rtd->dai_link->symmetric_channels;
+
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_channels;
 
 	for (i = 0; i < rtd->num_codecs; i++)
 		symmetry |= rtd->codec_dais[i]->driver->symmetric_channels;
 
-	if (symmetry && cpu_dai->channels && cpu_dai->channels != channels) {
-		dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
-				cpu_dai->channels, channels);
-		return -EINVAL;
-	}
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		if (symmetry && rtd->cpu_dais[i]->channels &&
+				rtd->cpu_dais[i]->channels != channels) {
+			dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
+					rtd->cpu_dais[i]->channels, channels);
+			return -EINVAL;
+		}
 
-	symmetry = cpu_dai->driver->symmetric_samplebits ||
-		rtd->dai_link->symmetric_samplebits;
+	symmetry = rtd->dai_link->symmetric_samplebits;
+
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		symmetry |= rtd->cpu_dais[i]->driver->symmetric_samplebits;
 
 	for (i = 0; i < rtd->num_codecs; i++)
 		symmetry |= rtd->codec_dais[i]->driver->symmetric_samplebits;
 
-	if (symmetry && cpu_dai->sample_bits && cpu_dai->sample_bits != sample_bits) {
-		dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
-				cpu_dai->sample_bits, sample_bits);
-		return -EINVAL;
-	}
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		if (symmetry && rtd->cpu_dais[i]->sample_bits &&
+				rtd->cpu_dais[i]->sample_bits != sample_bits) {
+			dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
+						rtd->cpu_dais[i]->sample_bits,
+								sample_bits);
+			return -EINVAL;
+		}
 
 	return 0;
 }
@@ -313,13 +333,18 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
 	struct snd_soc_dai_link *link = rtd->dai_link;
-	unsigned int symmetry, i;
+	unsigned int symmetry = 0, i;
 
-	symmetry = cpu_driver->symmetric_rates || link->symmetric_rates ||
-		cpu_driver->symmetric_channels || link->symmetric_channels ||
-		cpu_driver->symmetric_samplebits || link->symmetric_samplebits;
+	symmetry = link->symmetric_rates || link->symmetric_channels ||
+			link->symmetric_samplebits;
+
+	/* Apply symmetery for multiple cpu dais */
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		symmetry = symmetry ||
+			rtd->cpu_dais[i]->driver->symmetric_rates ||
+			rtd->cpu_dais[i]->driver->symmetric_channels ||
+			rtd->cpu_dais[i]->driver->symmetric_samplebits;
 
 	for (i = 0; i < rtd->num_codecs; i++)
 		symmetry = symmetry ||
@@ -347,10 +372,10 @@ static void soc_pcm_set_msb(struct snd_pcm_substream *substream, int bits)
 static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i;
-	unsigned int bits = 0, cpu_bits;
+	unsigned int bits = 0, cpu_bits = 0;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		for (i = 0; i < rtd->num_codecs; i++) {
@@ -361,7 +386,16 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 			}
 			bits = max(codec_dai->driver->playback.sig_bits, bits);
 		}
-		cpu_bits = cpu_dai->driver->playback.sig_bits;
+
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+			if (cpu_dai->driver->playback.sig_bits == 0) {
+				cpu_bits = 0;
+				break;
+			}
+
+			cpu_bits = max(cpu_dai->driver->playback.sig_bits, cpu_bits);
+		}
 	} else {
 		for (i = 0; i < rtd->num_codecs; i++) {
 			codec_dai = rtd->codec_dais[i];
@@ -371,7 +405,15 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 			}
 			bits = max(codec_dai->driver->capture.sig_bits, bits);
 		}
-		cpu_bits = cpu_dai->driver->capture.sig_bits;
+
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+			if (cpu_dai->driver->capture.sig_bits == 0) {
+				cpu_bits = 0;
+				break;
+			}
+			cpu_bits = max(cpu_dai->driver->capture.sig_bits, cpu_bits);
+		}
 	}
 
 	soc_pcm_set_msb(substream, bits);
@@ -383,21 +425,18 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai_driver *cpu_dai_drv = rtd->cpu_dai->driver;
+	struct snd_soc_dai_driver *cpu_dai_drv;
 	struct snd_soc_dai_driver *codec_dai_drv;
 	struct snd_soc_pcm_stream *codec_stream;
 	struct snd_soc_pcm_stream *cpu_stream;
 	unsigned int chan_min = 0, chan_max = UINT_MAX;
+	unsigned int cpu_chan_min = 0, cpu_chan_max = UINT_MAX;
 	unsigned int rate_min = 0, rate_max = UINT_MAX;
-	unsigned int rates = UINT_MAX;
+	unsigned int cpu_rate_min = 0, cpu_rate_max = UINT_MAX;
+	unsigned int rates = UINT_MAX, cpu_rates = UINT_MAX;
 	u64 formats = ULLONG_MAX;
 	int i;
 
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		cpu_stream = &cpu_dai_drv->playback;
-	else
-		cpu_stream = &cpu_dai_drv->capture;
-
 	/* first calculate min/max only for CODECs in the DAI link */
 	for (i = 0; i < rtd->num_codecs; i++) {
 
@@ -427,30 +466,55 @@ static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
 	}
 
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai_drv = rtd->cpu_dais[i]->driver;
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			cpu_stream = &cpu_dai_drv->playback;
+		else
+			cpu_stream = &cpu_dai_drv->capture;
+
+		cpu_chan_min = max(hw->channels_min,
+					cpu_stream->channels_min);
+		cpu_chan_max = min(hw->channels_max,
+					cpu_stream->channels_max);
+
+		if (hw->formats)
+			hw->formats &= cpu_stream->formats;
+		else
+			hw->formats = cpu_stream->formats;
+
+		cpu_rates = snd_pcm_rate_mask_intersect(cpu_rates,
+						cpu_stream->rates);
+
+		cpu_rate_min = max(hw->rate_min, cpu_stream->rate_min);
+		cpu_rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);
+	}
+
 	/*
-	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
-	 * connected to a single CPU DAI, use CPU DAI's directly and let
-	 * channel allocation be fixed up later
+	 * chan min/max cannot be enforced if there are multiple
+	 * CODEC DAIs connected to CPU DAI(s), use CPU DAI's
+	 * directly and let channel allocation be fixed up later
 	 */
 	if (rtd->num_codecs > 1) {
-		chan_min = cpu_stream->channels_min;
-		chan_max = cpu_stream->channels_max;
+		chan_min = cpu_chan_min;
+		chan_max = cpu_chan_max;
 	}
 
-	hw->channels_min = max(chan_min, cpu_stream->channels_min);
-	hw->channels_max = min(chan_max, cpu_stream->channels_max);
-	if (hw->formats)
-		hw->formats &= formats & cpu_stream->formats;
-	else
-		hw->formats = formats & cpu_stream->formats;
-	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_stream->rates);
+	hw->channels_min = max(cpu_chan_min, chan_min);
+
+	hw->channels_max = min(cpu_chan_max, chan_max);
+
+	hw->rate_min = max(cpu_rate_min, rate_min);
+	hw->rate_max = min_not_zero(cpu_rate_max, rate_max);
+	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_rates);
 
 	snd_pcm_limit_hw_rates(runtime);
 
-	hw->rate_min = max(hw->rate_min, cpu_stream->rate_min);
-	hw->rate_min = max(hw->rate_min, rate_min);
-	hw->rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);
-	hw->rate_max = min_not_zero(hw->rate_max, rate_max);
+	if (hw->formats)
+		hw->formats &= formats;
+	else
+		hw->formats = formats;
 }
 
 /*
@@ -464,12 +528,15 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	const char *codec_dai_name = "multicodec";
-	int i, ret = 0, __ret;
+	const char *cpu_dai_name = "multicpu";
+	int i, ret = 0, __ret, j;
+
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		pinctrl_pm_select_default_state(rtd->cpu_dais[i]->dev);
 
-	pinctrl_pm_select_default_state(cpu_dai->dev);
 	for (i = 0; i < rtd->num_codecs; i++)
 		pinctrl_pm_select_default_state(rtd->codec_dais[i]->dev);
 
@@ -482,12 +549,15 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	/* startup the audio subsystem */
-	if (cpu_dai->driver->ops->startup) {
-		ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
-		if (ret < 0) {
-			dev_err(cpu_dai->dev, "ASoC: can't open interface"
-				" %s: %d\n", cpu_dai->name, ret);
-			goto out;
+	for (j = 0; j < rtd->num_cpu_dai; j++) {
+		cpu_dai = rtd->cpu_dais[j];
+		if (cpu_dai->driver->ops->startup) {
+			ret = cpu_dai->driver->ops->startup(substream, cpu_dai);
+			if (ret < 0) {
+				dev_err(cpu_dai->dev, "ASoC: can't open interface %s: %d\n",
+							cpu_dai->name, ret);
+				goto interface_err;
+			}
 		}
 	}
 
@@ -548,34 +618,40 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	if (rtd->num_codecs == 1)
 		codec_dai_name = rtd->codec_dai->name;
 
+	if (rtd->num_cpu_dai == 1)
+		cpu_dai_name = rtd->cpu_dai->name;
+
 	if (soc_pcm_has_symmetry(substream))
 		runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
 
 	ret = -EINVAL;
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
-			codec_dai_name, cpu_dai->name);
+			codec_dai_name, cpu_dai_name);
 		goto config_err;
 	}
 	if (!runtime->hw.formats) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching formats\n",
-			codec_dai_name, cpu_dai->name);
+			codec_dai_name, cpu_dai_name);
 		goto config_err;
 	}
 	if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
 	    runtime->hw.channels_min > runtime->hw.channels_max) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching channels\n",
-				codec_dai_name, cpu_dai->name);
+				codec_dai_name, cpu_dai_name);
 		goto config_err;
 	}
 
 	soc_pcm_apply_msb(substream);
 
 	/* Symmetry only applies if we've already got an active stream. */
-	if (cpu_dai->active) {
-		ret = soc_pcm_apply_symmetry(substream, cpu_dai);
-		if (ret != 0)
-			goto config_err;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		if (rtd->cpu_dais[i]->active) {
+			ret = soc_pcm_apply_symmetry(substream,
+							rtd->cpu_dais[i]);
+			if (ret != 0)
+				goto config_err;
+		}
 	}
 
 	for (i = 0; i < rtd->num_codecs; i++) {
@@ -588,7 +664,7 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	}
 
 	pr_debug("ASoC: %s <-> %s info:\n",
-			codec_dai_name, cpu_dai->name);
+			codec_dai_name, cpu_dai_name);
 	pr_debug("ASoC: rate mask 0x%x\n", runtime->hw.rates);
 	pr_debug("ASoC: min ch %d max ch %d\n", runtime->hw.channels_min,
 		 runtime->hw.channels_max);
@@ -627,9 +703,15 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		component->driver->ops->close(substream);
 	}
 
-	if (cpu_dai->driver->ops->shutdown)
-		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
-out:
+	j = rtd->num_cpu_dai;
+
+interface_err:
+	while (--j >= 0) {
+		cpu_dai = rtd->cpu_dais[j];
+		if (cpu_dai->driver->ops->shutdown)
+			cpu_dai->driver->ops->shutdown(substream, cpu_dai);
+	}
+
 	mutex_unlock(&rtd->pcm_mutex);
 
 	for_each_rtdcom(rtd, rtdcom) {
@@ -643,8 +725,11 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
 	}
-	if (!cpu_dai->active)
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		if (!rtd->cpu_dais[i]->active)
+			pinctrl_pm_select_sleep_state(rtd->cpu_dais[i]->dev);
+	}
 
 	return ret;
 }
@@ -687,7 +772,7 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i;
 
@@ -696,8 +781,11 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	snd_soc_runtime_deactivate(rtd, substream->stream);
 
 	/* clear the corresponding DAIs rate when inactive */
-	if (!cpu_dai->active)
-		cpu_dai->rate = 0;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (!cpu_dai->active)
+			cpu_dai->rate = 0;
+	}
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
@@ -705,10 +793,16 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 			codec_dai->rate = 0;
 	}
 
-	snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		snd_soc_dai_digital_mute(cpu_dai, 1, substream->stream);
+	}
 
-	if (cpu_dai->driver->ops->shutdown)
-		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->driver->ops->shutdown)
+			cpu_dai->driver->ops->shutdown(substream, cpu_dai);
+	}
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
@@ -761,8 +855,11 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 		if (!rtd->codec_dais[i]->active)
 			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
 	}
-	if (!cpu_dai->active)
-		pinctrl_pm_select_sleep_state(cpu_dai->dev);
+
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		if (!rtd->cpu_dais[i]->active)
+			pinctrl_pm_select_sleep_state(rtd->cpu_dais[i]->dev);
+	}
 
 	return 0;
 }
@@ -777,7 +874,7 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret = 0;
 
@@ -821,12 +918,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (cpu_dai->driver->ops->prepare) {
-		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
-		if (ret < 0) {
-			dev_err(cpu_dai->dev,
-				"ASoC: cpu DAI prepare error: %d\n", ret);
-			goto out;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->driver->ops->prepare) {
+			ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
+			if (ret < 0) {
+				dev_err(cpu_dai->dev,
+					"ASoC: cpu DAI prepare error: %d\n",
+					ret);
+				goto out;
+			}
 		}
 	}
 
@@ -843,7 +944,10 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	for (i = 0; i < rtd->num_codecs; i++)
 		snd_soc_dai_digital_mute(rtd->codec_dais[i], 0,
 					 substream->stream);
-	snd_soc_dai_digital_mute(cpu_dai, 0, substream->stream);
+
+	for (i = 0; i < rtd->num_cpu_dai; i++)
+		snd_soc_dai_digital_mute(rtd->cpu_dais[i], 0,
+					substream->stream);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
@@ -890,8 +994,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int i, ret = 0, __ret;
+	struct snd_soc_dai *cpu_dai;
+	int i, ret = 0, __ret, j;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 	if (rtd->dai_link->ops->hw_params) {
@@ -945,9 +1049,12 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 						params_format(&codec_params));
 	}
 
-	ret = soc_dai_hw_params(substream, params, cpu_dai);
-	if (ret < 0)
-		goto interface_err;
+	for (j = 0; j < rtd->num_cpu_dai; j++) {
+		cpu_dai = rtd->cpu_dais[j];
+		ret = soc_dai_hw_params(substream, params, cpu_dai);
+		if (ret < 0)
+			goto interface_err;
+	}
 
 	ret = 0;
 	for_each_rtdcom(rtd, rtdcom) {
@@ -968,11 +1075,14 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		goto component_err;
 
-	/* store the parameters for each DAIs */
-	cpu_dai->rate = params_rate(params);
-	cpu_dai->channels = params_channels(params);
-	cpu_dai->sample_bits =
-		snd_pcm_format_physical_width(params_format(params));
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		/* store the parameters for each DAIs */
+		cpu_dai = rtd->cpu_dais[i];
+		cpu_dai->rate = params_rate(params);
+		cpu_dai->channels = params_channels(params);
+		cpu_dai->sample_bits =
+			snd_pcm_format_physical_width(params_format(params));
+	}
 
 	ret = soc_pcm_params_symmetry(substream, params);
         if (ret)
@@ -992,10 +1102,16 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		component->driver->ops->hw_free(substream);
 	}
 
-	if (cpu_dai->driver->ops->hw_free)
-		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
+	j = rtd->num_cpu_dai;
 
 interface_err:
+	while (--j >= 0) {
+		cpu_dai = rtd->cpu_dais[j];
+
+		if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
+			cpu_dai->driver->ops->hw_free(substream, cpu_dai);
+	}
+
 	i = rtd->num_codecs;
 
 codec_err:
@@ -1021,7 +1137,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
 	int i;
@@ -1029,10 +1145,13 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
 	/* clear the corresponding DAIs parameters when going to be inactive */
-	if (cpu_dai->active == 1) {
-		cpu_dai->rate = 0;
-		cpu_dai->channels = 0;
-		cpu_dai->sample_bits = 0;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->active == 1) {
+			cpu_dai->rate = 0;
+			cpu_dai->channels = 0;
+			cpu_dai->sample_bits = 0;
+		}
 	}
 
 	for (i = 0; i < rtd->num_codecs; i++) {
@@ -1074,8 +1193,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 			codec_dai->driver->ops->hw_free(substream, codec_dai);
 	}
 
-	if (cpu_dai->driver->ops->hw_free)
-		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
+			cpu_dai->driver->ops->hw_free(substream, cpu_dai);
+	}
 
 	mutex_unlock(&rtd->pcm_mutex);
 	return 0;
@@ -1086,7 +1208,7 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret;
 
@@ -1112,10 +1234,14 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 			return ret;
 	}
 
-	if (cpu_dai->driver->ops->trigger) {
-		ret = cpu_dai->driver->ops->trigger(substream, cmd, cpu_dai);
-		if (ret < 0)
-			return ret;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->driver->ops->trigger) {
+			ret = cpu_dai->driver->ops->trigger(substream,
+								cmd, cpu_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (rtd->dai_link->ops->trigger) {
@@ -1131,7 +1257,7 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 				   int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	int i, ret;
 
@@ -1145,10 +1271,14 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (cpu_dai->driver->ops->bespoke_trigger) {
-		ret = cpu_dai->driver->ops->bespoke_trigger(substream, cmd, cpu_dai);
-		if (ret < 0)
-			return ret;
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->driver->ops->bespoke_trigger) {
+			ret = cpu_dai->driver->ops->bespoke_trigger(substream,
+								cmd, cpu_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 	return 0;
 }
@@ -1162,7 +1292,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_dai *codec_dai;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
@@ -1182,8 +1312,12 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 		break;
 	}
 
-	if (cpu_dai->driver->ops->delay)
-		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
+	for (i = 0; i < rtd->num_cpu_dai; i++) {
+		cpu_dai = rtd->cpu_dais[i];
+		if (cpu_dai->driver->ops->delay)
+			delay += cpu_dai->driver->ops->delay(substream,
+								cpu_dai);
+	}
 
 	for (i = 0; i < rtd->num_codecs; i++) {
 		codec_dai = rtd->codec_dais[i];
@@ -1306,12 +1440,16 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
-			dev_dbg(card->dev, "ASoC: try BE : %s\n",
-				be->cpu_dai->playback_widget ?
-				be->cpu_dai->playback_widget->name : "(not set)");
+			for (i = 0; i < be->num_cpu_dai; i++) {
+				struct snd_soc_dai *cpu_dai = be->cpu_dais[i];
+
+				dev_dbg(card->dev, "ASoC: try BE : %s\n",
+					cpu_dai->playback_widget ?
+					cpu_dai->playback_widget->name : "(not set)");
 
-			if (be->cpu_dai->playback_widget == widget)
-				return be;
+				if (cpu_dai->playback_widget == widget)
+					return be;
+			}
 
 			for (i = 0; i < be->num_codecs; i++) {
 				struct snd_soc_dai *dai = be->codec_dais[i];
@@ -1326,12 +1464,16 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
-			dev_dbg(card->dev, "ASoC: try BE %s\n",
-				be->cpu_dai->capture_widget ?
-				be->cpu_dai->capture_widget->name : "(not set)");
+			for (i = 0; i < be->num_cpu_dai; i++) {
+				struct snd_soc_dai *cpu_dai = be->cpu_dais[i];
 
-			if (be->cpu_dai->capture_widget == widget)
-				return be;
+				dev_dbg(card->dev, "ASoC: try BE %s\n",
+					cpu_dai->capture_widget ?
+					cpu_dai->capture_widget->name : "(not set)");
+
+				if (cpu_dai->capture_widget == widget)
+					return be;
+			}
 
 			for (i = 0; i < be->num_codecs; i++) {
 				struct snd_soc_dai *dai = be->codec_dais[i];
@@ -1381,8 +1523,12 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 			if (!rtd->dai_link->no_pcm)
 				continue;
 
-			if (rtd->cpu_dai->playback_widget == widget)
-				return true;
+			for (i = 0; i < rtd->num_cpu_dai; ++i) {
+				struct snd_soc_dai *cpu_dai = rtd->cpu_dais[i];
+
+				if (cpu_dai->playback_widget == widget)
+					return true;
+			}
 
 			for (i = 0; i < rtd->num_codecs; ++i) {
 				struct snd_soc_dai *dai = rtd->codec_dais[i];
@@ -1395,8 +1541,12 @@ static bool dpcm_end_walk_at_be(struct snd_soc_dapm_widget *widget,
 			if (!rtd->dai_link->no_pcm)
 				continue;
 
-			if (rtd->cpu_dai->capture_widget == widget)
-				return true;
+			for (i = 0; i < rtd->num_cpu_dai; ++i) {
+				struct snd_soc_dai *cpu_dai = rtd->cpu_dais[i];
+
+				if (cpu_dai->capture_widget == widget)
+					return true;
+			}
 
 			for (i = 0; i < rtd->num_codecs; ++i) {
 				struct snd_soc_dai *dai = rtd->codec_dais[i];
@@ -1438,11 +1588,15 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 		unsigned int i;
 
 		/* is there a valid CPU DAI widget for this BE */
-		widget = dai_get_widget(dpcm->be->cpu_dai, stream);
+		for (i = 0; i < dpcm->be->num_cpu_dai; i++) {
+			struct snd_soc_dai *dai = dpcm->be->cpu_dais[i];
 
-		/* prune the BE if it's no longer in our active list */
-		if (widget && widget_in_list(list, widget))
-			continue;
+			widget = dai_get_widget(dai, stream);
+
+			/* prune the BE if it's no longer in our active list */
+			if (widget && widget_in_list(list, widget))
+				continue;
+		}
 
 		/* is there a valid CODEC DAI widget for this BE */
 		for (i = 0; i < dpcm->be->num_codecs; i++) {
@@ -1783,10 +1937,13 @@ static int dpcm_apply_symmetry(struct snd_pcm_substream *fe_substream,
 			be_substream->runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
 
 		/* Symmetry only applies if we've got an active stream. */
-		if (rtd->cpu_dai->active) {
-			err = soc_pcm_apply_symmetry(be_substream, rtd->cpu_dai);
-			if (err < 0)
-				return err;
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			if (rtd->cpu_dais[i]->active) {
+				err = soc_pcm_apply_symmetry(be_substream,
+							rtd->cpu_dais[i]);
+				if (err < 0)
+					return err;
+			}
 		}
 
 		for (i = 0; i < rtd->num_codecs; i++) {
@@ -2886,13 +3043,13 @@ static int soc_rtdcom_mmap(struct snd_pcm_substream *substream,
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_dai *codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *cpu_dai;
 	struct snd_soc_component *component;
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
-	int i;
+	int i, cpu_capture = 0, cpu_playback = 0;
 
 	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
 		playback = rtd->dai_link->dpcm_playback;
@@ -2906,8 +3063,16 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 				capture = 1;
 		}
 
-		capture = capture && cpu_dai->driver->capture.channels_min;
-		playback = playback && cpu_dai->driver->playback.channels_min;
+		for (i = 0; i < rtd->num_cpu_dai; i++) {
+			cpu_dai = rtd->cpu_dais[i];
+			if (cpu_dai->driver->playback.channels_min)
+				cpu_playback = 1;
+			if (cpu_dai->driver->capture.channels_min)
+				cpu_capture = 1;
+		}
+
+		playback = playback && cpu_playback;
+		capture = capture && cpu_capture;
 	}
 
 	if (rtd->dai_link->playback_only) {
@@ -3028,7 +3193,7 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 out:
 	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
 		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
-		 cpu_dai->name);
+		 (rtd->num_cpu_dai > 1) ? "multicpu" : rtd->cpu_dai->name);
 	return ret;
 }
 
-- 
2.7.4
