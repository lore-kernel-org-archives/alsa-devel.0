From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 4/8] ASoC: pcm: Add support for DAI
	multicodec
Date: Tue,  1 Jul 2014 09:47:57 +0200
Message-ID: <1404200881-32253-5-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 52F0C2656EF
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:49:01 +0200 (CEST)
Received: by mail-wi0-f169.google.com with SMTP id hi2so6920223wib.2
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:49:01 -0700 (PDT)
In-Reply-To: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: Fabien Parent <fparent@baylibre.com>, misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add multicodec support in soc-pcm.c

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 sound/soc/soc-pcm.c | 515 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 354 insertions(+), 161 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ab0712e..981b99c 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -47,22 +47,26 @@
 void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active++;
-		codec_dai->playback_active++;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->playback_active++;
 	} else {
 		cpu_dai->capture_active++;
-		codec_dai->capture_active++;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->capture_active++;
 	}
 
 	cpu_dai->active++;
-	codec_dai->active++;
 	cpu_dai->component->active++;
-	codec_dai->component->active++;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		rtd->codec_dais[i]->active++;
+		rtd->codec_dais[i]->component->active++;
+	}
 }
 
 /**
@@ -78,22 +82,26 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 {
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int i;
 
 	lockdep_assert_held(&rtd->pcm_mutex);
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		cpu_dai->playback_active--;
-		codec_dai->playback_active--;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->playback_active--;
 	} else {
 		cpu_dai->capture_active--;
-		codec_dai->capture_active--;
+		for (i = 0; i < rtd->num_codecs; i++)
+			rtd->codec_dais[i]->capture_active--;
 	}
 
 	cpu_dai->active--;
-	codec_dai->active--;
 	cpu_dai->component->active--;
-	codec_dai->component->active--;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		rtd->codec_dais[i]->component->active--;
+		rtd->codec_dais[i]->active--;
+	}
 }
 
 /**
@@ -107,11 +115,15 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
  */
 bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd)
 {
+	int i, ignore = 0;
+
 	if (!rtd->pmdown_time || rtd->dai_link->ignore_pmdown_time)
 		return true;
 
-	return rtd->cpu_dai->component->ignore_pmdown_time &&
-			rtd->codec_dai->component->ignore_pmdown_time;
+	for (i = 0; (i < rtd->num_codecs) && !ignore; i++)
+		ignore &= rtd->codec_dais[i]->component->ignore_pmdown_time;
+
+	return rtd->cpu_dai->component->ignore_pmdown_time && ignore;
 }
 
 /**
@@ -222,8 +234,7 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	unsigned int rate, channels, sample_bits, symmetry;
+	unsigned int rate, channels, sample_bits, symmetry, i;
 
 	rate = params_rate(params);
 	channels = params_channels(params);
@@ -231,8 +242,11 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 
 	/* reject unmatched parameters when applying symmetry */
 	symmetry = cpu_dai->driver->symmetric_rates ||
-		codec_dai->driver->symmetric_rates ||
 		rtd->dai_link->symmetric_rates;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry |= rtd->codec_dais[i]->driver->symmetric_rates;
+
 	if (symmetry && cpu_dai->rate && cpu_dai->rate != rate) {
 		dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
 				cpu_dai->rate, rate);
@@ -240,8 +254,11 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	}
 
 	symmetry = cpu_dai->driver->symmetric_channels ||
-		codec_dai->driver->symmetric_channels ||
 		rtd->dai_link->symmetric_channels;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry |= rtd->codec_dais[i]->driver->symmetric_channels;
+
 	if (symmetry && cpu_dai->channels && cpu_dai->channels != channels) {
 		dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
 				cpu_dai->channels, channels);
@@ -249,8 +266,11 @@ static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
 	}
 
 	symmetry = cpu_dai->driver->symmetric_samplebits ||
-		codec_dai->driver->symmetric_samplebits ||
 		rtd->dai_link->symmetric_samplebits;
+
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry |= rtd->codec_dais[i]->driver->symmetric_samplebits;
+
 	if (symmetry && cpu_dai->sample_bits && cpu_dai->sample_bits != sample_bits) {
 		dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
 				cpu_dai->sample_bits, sample_bits);
@@ -264,15 +284,20 @@ static bool soc_pcm_has_symmetry(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai_driver *cpu_driver = rtd->cpu_dai->driver;
-	struct snd_soc_dai_driver *codec_driver = rtd->codec_dai->driver;
 	struct snd_soc_dai_link *link = rtd->dai_link;
+	unsigned int symmetry, i;
+
+	symmetry = cpu_driver->symmetric_rates || link->symmetric_rates ||
+		cpu_driver->symmetric_channels || link->symmetric_channels ||
+		cpu_driver->symmetric_samplebits || link->symmetric_samplebits;
 
-	return cpu_driver->symmetric_rates || codec_driver->symmetric_rates ||
-		link->symmetric_rates || cpu_driver->symmetric_channels ||
-		codec_driver->symmetric_channels || link->symmetric_channels ||
-		cpu_driver->symmetric_samplebits ||
-		codec_driver->symmetric_samplebits ||
-		link->symmetric_samplebits;
+	for (i = 0; i < rtd->num_codecs; i++)
+		symmetry = symmetry ||
+			rtd->codec_dais[i]->driver->symmetric_rates ||
+			rtd->codec_dais[i]->driver->symmetric_channels ||
+			rtd->codec_dais[i]->driver->symmetric_samplebits;
+
+	return symmetry;
 }
 
 /*
@@ -309,14 +334,21 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
 	unsigned int bits = 0, cpu_bits;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		bits = codec_dai->driver->playback.sig_bits;
+		for (i = 0; i < rtd->num_codecs; i++) {
+			codec_dai = rtd->codec_dais[i];
+			bits = max(codec_dai->driver->playback.sig_bits, bits);
+		}
 		cpu_bits = cpu_dai->driver->playback.sig_bits;
 	} else {
-		bits = codec_dai->driver->capture.sig_bits;
+		for (i = 0; i < rtd->num_codecs; i++) {
+			codec_dai = rtd->codec_dais[i];
+			bits = max(codec_dai->driver->capture.sig_bits, bits);
+		}
 		cpu_bits = cpu_dai->driver->capture.sig_bits;
 	}
 
@@ -324,32 +356,65 @@ static void soc_pcm_apply_msb(struct snd_pcm_substream *substream)
 	soc_pcm_set_msb(substream, cpu_dai, cpu_bits);
 }
 
-static void soc_pcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
-	struct snd_soc_pcm_stream *codec_stream,
-	struct snd_soc_pcm_stream *cpu_stream)
+static void soc_pcm_init_runtime_hw(struct snd_pcm_substream *substream)
 {
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_pcm_hardware *hw = &runtime->hw;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai_driver *cpu_dai_drv = rtd->cpu_dai->driver;
+	struct snd_soc_dai_driver *codec_dai_drv;
+	struct snd_soc_pcm_stream *codec_stream;
+	struct snd_soc_pcm_stream *cpu_stream;
+	unsigned int chan_min = 0, chan_max = UINT_MAX;
+	unsigned int rate_min = 0, rate_max = UINT_MAX;
+	unsigned int rates = UINT_MAX;
+	u64 formats = ULLONG_MAX;
+	int i;
 
-	hw->channels_min = max(codec_stream->channels_min,
-		cpu_stream->channels_min);
-	hw->channels_max = min(codec_stream->channels_max,
-		cpu_stream->channels_max);
-	if (hw->formats)
-		hw->formats &= codec_stream->formats & cpu_stream->formats;
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		cpu_stream = &cpu_dai_drv->playback;
 	else
-		hw->formats = codec_stream->formats & cpu_stream->formats;
-	hw->rates = snd_pcm_rate_mask_intersect(codec_stream->rates,
-		cpu_stream->rates);
+		cpu_stream = &cpu_dai_drv->capture;
 
-	hw->rate_min = 0;
-	hw->rate_max = UINT_MAX;
+	/* first calculate min/max only for CODECs in the DAI link */
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai_drv = rtd->codec_dais[i]->driver;
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			codec_stream = &codec_dai_drv->playback;
+		else
+			codec_stream = &codec_dai_drv->capture;
+		chan_min = max(chan_min, codec_stream->channels_min);
+		chan_max = min(chan_max, codec_stream->channels_max);
+		rate_min = max(rate_min, codec_stream->rate_min);
+		rate_max = min_not_zero(rate_max, codec_stream->rate_max);
+		formats &= codec_stream->formats;
+		rates = snd_pcm_rate_mask_intersect(codec_stream->rates, rates);
+	}
+
+	/*
+	 * chan min/max cannot be enforced if there are multiple CODEC DAIs
+	 * connected to a single CPU DAI, use CPU DAI's directly and let
+	 * channel allocation be fixed up later
+	 */
+	if (rtd->num_codecs > 1) {
+		chan_min = cpu_stream->channels_min;
+		chan_max = cpu_stream->channels_max;
+	}
+
+	hw->channels_min = max(chan_min, cpu_stream->channels_min);
+	hw->channels_max = min(chan_max, cpu_stream->channels_max);
+	if (hw->formats)
+		hw->formats &= formats & cpu_stream->formats;
+	else
+		hw->formats = formats & cpu_stream->formats;
+	hw->rates = snd_pcm_rate_mask_intersect(rates, cpu_stream->rates);
 
 	snd_pcm_limit_hw_rates(runtime);
 
 	hw->rate_min = max(hw->rate_min, cpu_stream->rate_min);
-	hw->rate_min = max(hw->rate_min, codec_stream->rate_min);
+	hw->rate_min = max(hw->rate_min, rate_min);
 	hw->rate_max = min_not_zero(hw->rate_max, cpu_stream->rate_max);
-	hw->rate_max = min_not_zero(hw->rate_max, codec_stream->rate_max);
+	hw->rate_max = min_not_zero(hw->rate_max, rate_max);
 }
 
 /*
@@ -363,15 +428,16 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai_driver *cpu_dai_drv = cpu_dai->driver;
-	struct snd_soc_dai_driver *codec_dai_drv = codec_dai->driver;
-	int ret = 0;
+	struct snd_soc_dai *codec_dai;
+	const char *codec_dai_name = "multicodec";
+	int i, ret = 0;
 
 	pinctrl_pm_select_default_state(cpu_dai->dev);
-	pinctrl_pm_select_default_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pinctrl_pm_select_default_state(rtd->codec_dais[i]->dev);
 	pm_runtime_get_sync(cpu_dai->dev);
-	pm_runtime_get_sync(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_get_sync(rtd->codec_dais[i]->dev);
 	pm_runtime_get_sync(platform->dev);
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
@@ -395,13 +461,23 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->startup) {
-		ret = codec_dai->driver->ops->startup(substream, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't open codec"
-				" %s: %d\n", codec_dai->name, ret);
-			goto codec_dai_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->startup) {
+			ret = codec_dai->driver->ops->startup(substream,
+							      codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: can't open codec %s: %d\n",
+					codec_dai->name, ret);
+				goto codec_dai_err;
+			}
 		}
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			codec_dai->tx_mask = 0;
+		else
+			codec_dai->rx_mask = 0;
 	}
 
 	if (rtd->dai_link->ops && rtd->dai_link->ops->startup) {
@@ -418,13 +494,10 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 		goto dynamic;
 
 	/* Check that the codec and cpu DAIs are compatible */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		soc_pcm_init_runtime_hw(runtime, &codec_dai_drv->playback,
-			&cpu_dai_drv->playback);
-	} else {
-		soc_pcm_init_runtime_hw(runtime, &codec_dai_drv->capture,
-			&cpu_dai_drv->capture);
-	}
+	soc_pcm_init_runtime_hw(substream);
+
+	if (rtd->num_codecs == 1)
+		codec_dai_name = rtd->codec_dai->name;
 
 	if (soc_pcm_has_symmetry(substream))
 		runtime->hw.info |= SNDRV_PCM_INFO_JOINT_DUPLEX;
@@ -432,18 +505,18 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 	ret = -EINVAL;
 	if (!runtime->hw.rates) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching rates\n",
-			codec_dai->name, cpu_dai->name);
+			codec_dai_name, cpu_dai->name);
 		goto config_err;
 	}
 	if (!runtime->hw.formats) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching formats\n",
-			codec_dai->name, cpu_dai->name);
+			codec_dai_name, cpu_dai->name);
 		goto config_err;
 	}
 	if (!runtime->hw.channels_min || !runtime->hw.channels_max ||
 	    runtime->hw.channels_min > runtime->hw.channels_max) {
 		printk(KERN_ERR "ASoC: %s <-> %s No matching channels\n",
-				codec_dai->name, cpu_dai->name);
+				codec_dai_name, cpu_dai->name);
 		goto config_err;
 	}
 
@@ -456,14 +529,17 @@ static int soc_pcm_open(struct snd_pcm_substream *substream)
 			goto config_err;
 	}
 
-	if (codec_dai->active) {
-		ret = soc_pcm_apply_symmetry(substream, codec_dai);
-		if (ret != 0)
-			goto config_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (rtd->codec_dais[i]->active) {
+			ret = soc_pcm_apply_symmetry(substream,
+						     rtd->codec_dais[i]);
+			if (ret != 0)
+				goto config_err;
+		}
 	}
 
 	pr_debug("ASoC: %s <-> %s info:\n",
-			codec_dai->name, cpu_dai->name);
+			codec_dai_name, cpu_dai->name);
 	pr_debug("ASoC: rate mask 0x%x\n", runtime->hw.rates);
 	pr_debug("ASoC: min ch %d max ch %d\n", runtime->hw.channels_min,
 		 runtime->hw.channels_max);
@@ -482,10 +558,15 @@ config_err:
 		rtd->dai_link->ops->shutdown(substream);
 
 machine_err:
-	if (codec_dai->driver->ops->shutdown)
-		codec_dai->driver->ops->shutdown(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_dai_err:
+	while (--i >= 0) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops->shutdown)
+			codec_dai->driver->ops->shutdown(substream, codec_dai);
+	}
+
 	if (platform->driver->ops && platform->driver->ops->close)
 		platform->driver->ops->close(substream);
 
@@ -496,10 +577,13 @@ out:
 	mutex_unlock(&rtd->pcm_mutex);
 
 	pm_runtime_put(platform->dev);
-	pm_runtime_put(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_put(rtd->codec_dais[i]->dev);
 	pm_runtime_put(cpu_dai->dev);
-	if (!codec_dai->active)
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->active)
+			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
+	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
@@ -515,7 +599,7 @@ static void close_delayed_work(struct work_struct *work)
 {
 	struct snd_soc_pcm_runtime *rtd =
 			container_of(work, struct snd_soc_pcm_runtime, delayed_work.work);
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dais[0];
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -544,7 +628,8 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -554,14 +639,20 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	if (!cpu_dai->active)
 		cpu_dai->rate = 0;
 
-	if (!codec_dai->active)
-		codec_dai->rate = 0;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (!codec_dai->active)
+			codec_dai->rate = 0;
+	}
 
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
-	if (codec_dai->driver->ops->shutdown)
-		codec_dai->driver->ops->shutdown(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops->shutdown)
+			codec_dai->driver->ops->shutdown(substream, codec_dai);
+	}
 
 	if (rtd->dai_link->ops && rtd->dai_link->ops->shutdown)
 		rtd->dai_link->ops->shutdown(substream);
@@ -591,10 +682,13 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	mutex_unlock(&rtd->pcm_mutex);
 
 	pm_runtime_put(platform->dev);
-	pm_runtime_put(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++)
+		pm_runtime_put(rtd->codec_dais[i]->dev);
 	pm_runtime_put(cpu_dai->dev);
-	if (!codec_dai->active)
-		pinctrl_pm_select_sleep_state(codec_dai->dev);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if (!rtd->codec_dais[i]->active)
+			pinctrl_pm_select_sleep_state(rtd->codec_dais[i]->dev);
+	}
 	if (!cpu_dai->active)
 		pinctrl_pm_select_sleep_state(cpu_dai->dev);
 
@@ -611,8 +705,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	struct snd_soc_dai *codec_dai;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -634,12 +728,16 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->prepare) {
-		ret = codec_dai->driver->ops->prepare(substream, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: DAI prepare error: %d\n",
-				ret);
-			goto out;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->prepare) {
+			ret = codec_dai->driver->ops->prepare(substream,
+							      codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: DAI prepare error: %d\n", ret);
+				goto out;
+			}
 		}
 	}
 
@@ -662,13 +760,26 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	snd_soc_dapm_stream_event(rtd, substream->stream,
 			SND_SOC_DAPM_STREAM_START);
 
-	snd_soc_dai_digital_mute(codec_dai, 0, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++)
+		snd_soc_dai_digital_mute(rtd->codec_dais[i], 0,
+					 substream->stream);
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
 }
 
+static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
+				       unsigned int mask)
+{
+	struct snd_interval *interval;
+	int channels = hweight_long(mask);
+
+	interval = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
+	interval->min = channels;
+	interval->max = channels;
+}
+
 /*
  * Called by ALSA when the hardware params are set by application. This
  * function can also be called multiple times and can allocate buffers
@@ -680,8 +791,7 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -698,13 +808,37 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_params) {
-		ret = codec_dai->driver->ops->hw_params(substream, params, codec_dai);
-		if (ret < 0) {
-			dev_err(codec_dai->dev, "ASoC: can't set %s hw params:"
-				" %d\n", codec_dai->name, ret);
-			goto codec_err;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		struct snd_pcm_hw_params codec_params;
+
+		/* copy params for each codec */
+		memcpy(&codec_params, params, sizeof(struct snd_pcm_hw_params));
+
+		/* fixup params based on TDM slot masks */
+		if (codec_dai->tx_mask)
+			soc_pcm_codec_params_fixup(&codec_params,
+						   codec_dai->tx_mask);
+		if (codec_dai->rx_mask)
+			soc_pcm_codec_params_fixup(&codec_params,
+						   codec_dai->rx_mask);
+
+		if (codec_dai->driver->ops &&
+		    codec_dai->driver->ops->hw_params) {
+			ret = codec_dai->driver->ops->hw_params(substream,
+						&codec_params, codec_dai);
+			if (ret < 0) {
+				dev_err(codec_dai->dev,
+					"ASoC: can't set %s hw params: %d\n",
+					codec_dai->name, ret);
+				goto codec_err;
+			}
 		}
+
+		codec_dai->rate = params_rate(&codec_params);
+		codec_dai->channels = params_channels(&codec_params);
+		codec_dai->sample_bits = snd_pcm_format_physical_width(
+						params_format(&codec_params));
 	}
 
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_params) {
@@ -731,11 +865,6 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 	cpu_dai->sample_bits =
 		snd_pcm_format_physical_width(params_format(params));
 
-	codec_dai->rate = params_rate(params);
-	codec_dai->channels = params_channels(params);
-	codec_dai->sample_bits =
-		snd_pcm_format_physical_width(params_format(params));
-
 out:
 	mutex_unlock(&rtd->pcm_mutex);
 	return ret;
@@ -745,10 +874,16 @@ platform_err:
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
 
 interface_err:
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	i = rtd->num_codecs;
 
 codec_err:
+	while (--i >= 0) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+		codec_dai->rate = 0;
+	}
+
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
 		rtd->dai_link->ops->hw_free(substream);
 
@@ -764,8 +899,9 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
+	int i;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -776,16 +912,22 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		cpu_dai->sample_bits = 0;
 	}
 
-	if (codec_dai->active == 1) {
-		codec_dai->rate = 0;
-		codec_dai->channels = 0;
-		codec_dai->sample_bits = 0;
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->active == 1) {
+			codec_dai->rate = 0;
+			codec_dai->channels = 0;
+			codec_dai->sample_bits = 0;
+		}
 	}
 
 	/* apply codec digital mute */
-	if ((playback && codec_dai->playback_active == 1) ||
-	    (!playback && codec_dai->capture_active == 1))
-		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		if ((playback && rtd->codec_dais[i]->playback_active == 1) ||
+		    (!playback && rtd->codec_dais[i]->capture_active == 1))
+			snd_soc_dai_digital_mute(rtd->codec_dais[i], 1,
+						 substream->stream);
+	}
 
 	/* free any machine hw params */
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_free)
@@ -796,8 +938,11 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 		platform->driver->ops->hw_free(substream);
 
 	/* now free hw params for the DAIs  */
-	if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
-		codec_dai->driver->ops->hw_free(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->hw_free)
+			codec_dai->driver->ops->hw_free(substream, codec_dai);
+	}
 
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_free)
 		cpu_dai->driver->ops->hw_free(substream, cpu_dai);
@@ -811,13 +956,17 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	if (codec_dai->driver->ops && codec_dai->driver->ops->trigger) {
-		ret = codec_dai->driver->ops->trigger(substream, cmd, codec_dai);
-		if (ret < 0)
-			return ret;
+	struct snd_soc_dai *codec_dai;
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->trigger) {
+			ret = codec_dai->driver->ops->trigger(substream,
+							      cmd, codec_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (platform->driver->ops && platform->driver->ops->trigger) {
@@ -847,14 +996,18 @@ static int soc_pcm_bespoke_trigger(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	int ret;
-
-	if (codec_dai->driver->ops &&
-	    codec_dai->driver->ops->bespoke_trigger) {
-		ret = codec_dai->driver->ops->bespoke_trigger(substream, cmd, codec_dai);
-		if (ret < 0)
-			return ret;
+	struct snd_soc_dai *codec_dai;
+	int i, ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops &&
+		    codec_dai->driver->ops->bespoke_trigger) {
+			ret = codec_dai->driver->ops->bespoke_trigger(substream,
+								cmd, codec_dai);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	if (platform->driver->bespoke_trigger) {
@@ -880,10 +1033,12 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t offset = 0;
 	snd_pcm_sframes_t delay = 0;
+	snd_pcm_sframes_t codec_delay = 0;
+	int i;
 
 	if (platform->driver->ops && platform->driver->ops->pointer)
 		offset = platform->driver->ops->pointer(substream);
@@ -891,11 +1046,21 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->delay)
 		delay += cpu_dai->driver->ops->delay(substream, cpu_dai);
 
-	if (codec_dai->driver->ops && codec_dai->driver->ops->delay)
-		delay += codec_dai->driver->ops->delay(substream, codec_dai);
+	for (i = 0; i < rtd->num_codecs; i++) {
+		codec_dai = rtd->codec_dais[i];
+		if (codec_dai->driver->ops && codec_dai->driver->ops->delay)
+			codec_delay = max(codec_delay,
+					codec_dai->driver->ops->delay(substream,
+								    codec_dai));
+	}
+	delay += codec_delay;
 
+	/*
+	 * None of the existing platform drivers implement delay(), so
+	 * for now the codec_dai of first multicodec entry is used
+	 */
 	if (platform->driver->delay)
-		delay += platform->driver->delay(substream, codec_dai);
+		delay += platform->driver->delay(substream, rtd->codec_dais[0]);
 
 	runtime->delay = delay;
 
@@ -998,7 +1163,7 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 		struct snd_soc_dapm_widget *widget, int stream)
 {
 	struct snd_soc_pcm_runtime *be;
-	int i;
+	int i, j;
 
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		for (i = 0; i < card->num_links; i++) {
@@ -1007,9 +1172,14 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
-			if (be->cpu_dai->playback_widget == widget ||
-				be->codec_dai->playback_widget == widget)
+			if (be->cpu_dai->playback_widget == widget)
 				return be;
+
+			for (j = 0; j < be->num_codecs; j++) {
+				struct snd_soc_dai *dai = be->codec_dais[j];
+				if (dai->playback_widget == widget)
+					return be;
+			}
 		}
 	} else {
 
@@ -1019,9 +1189,14 @@ static struct snd_soc_pcm_runtime *dpcm_get_be(struct snd_soc_card *card,
 			if (!be->dai_link->no_pcm)
 				continue;
 
-			if (be->cpu_dai->capture_widget == widget ||
-				be->codec_dai->capture_widget == widget)
+			if (be->cpu_dai->capture_widget == widget)
 				return be;
+
+			for (j = 0; j < be->num_codecs; j++) {
+				struct snd_soc_dai *dai = be->codec_dais[j];
+				if (dai->capture_widget == widget)
+					return be;
+			}
 		}
 	}
 
@@ -1084,6 +1259,7 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 
 	/* Destroy any old FE <--> BE connections */
 	list_for_each_entry(dpcm, &fe->dpcm[stream].be_clients, list_be) {
+		unsigned int i;
 
 		/* is there a valid CPU DAI widget for this BE */
 		widget = dai_get_widget(dpcm->be->cpu_dai, stream);
@@ -1093,11 +1269,14 @@ static int dpcm_prune_paths(struct snd_soc_pcm_runtime *fe, int stream,
 			continue;
 
 		/* is there a valid CODEC DAI widget for this BE */
-		widget = dai_get_widget(dpcm->be->codec_dai, stream);
+		for (i = 0; i < dpcm->be->num_codecs; i++) {
+			struct snd_soc_dai *dai = dpcm->be->codec_dais[i];
+			widget = dai_get_widget(dai, stream);
 
-		/* prune the BE if it's no longer in our active list */
-		if (widget && widget_in_list(list, widget))
-			continue;
+			/* prune the BE if it's no longer in our active list */
+			if (widget && widget_in_list(list, widget))
+				continue;
+		}
 
 		dev_dbg(fe->dev, "ASoC: pruning %s BE %s for %s\n",
 			stream ? "capture" : "playback",
@@ -2127,16 +2306,22 @@ int soc_dpcm_be_digital_mute(struct snd_soc_pcm_runtime *fe, int mute)
 	list_for_each_entry(dpcm, clients, list_be) {
 
 		struct snd_soc_pcm_runtime *be = dpcm->be;
-		struct snd_soc_dai *dai = be->codec_dai;
-		struct snd_soc_dai_driver *drv = dai->driver;
+		int i;
 
 		if (be->dai_link->ignore_suspend)
 			continue;
 
-		dev_dbg(be->dev, "ASoC: BE digital mute %s\n", be->dai_link->name);
+		for (i = 0; i < be->num_codecs; i++) {
+			struct snd_soc_dai *dai = be->codec_dais[i];
+			struct snd_soc_dai_driver *drv = dai->driver;
+
+			dev_dbg(be->dev, "ASoC: BE digital mute %s\n",
+					 be->dai_link->name);
 
-		if (drv->ops && drv->ops->digital_mute && dai->playback_active)
-			drv->ops->digital_mute(dai, mute);
+			if (drv->ops && drv->ops->digital_mute &&
+							dai->playback_active)
+				drv->ops->digital_mute(dai, mute);
+		}
 	}
 
 	return 0;
@@ -2201,22 +2386,27 @@ static int dpcm_fe_dai_close(struct snd_pcm_substream *fe_substream)
 int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 {
 	struct snd_soc_platform *platform = rtd->platform;
-	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *codec_dai;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_pcm *pcm;
 	char new_name[64];
 	int ret = 0, playback = 0, capture = 0;
+	int i;
 
 	if (rtd->dai_link->dynamic || rtd->dai_link->no_pcm) {
 		playback = rtd->dai_link->dpcm_playback;
 		capture = rtd->dai_link->dpcm_capture;
 	} else {
-		if (codec_dai->driver->playback.channels_min &&
-		    cpu_dai->driver->playback.channels_min)
-			playback = 1;
-		if (codec_dai->driver->capture.channels_min &&
-		    cpu_dai->driver->capture.channels_min)
-			capture = 1;
+		for (i = 0; i < rtd->num_codecs; i++) {
+			codec_dai = rtd->codec_dais[i];
+			if (codec_dai->driver->playback.channels_min)
+				playback = 1;
+			if (codec_dai->driver->capture.channels_min)
+				capture = 1;
+		}
+
+		capture = capture && cpu_dai->driver->capture.channels_min;
+		playback = playback && cpu_dai->driver->playback.channels_min;
 	}
 
 	if (rtd->dai_link->playback_only) {
@@ -2242,7 +2432,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 				rtd->dai_link->stream_name);
 		else
 			snprintf(new_name, sizeof(new_name), "%s %s-%d",
-				rtd->dai_link->stream_name, codec_dai->name, num);
+				rtd->dai_link->stream_name,
+				(rtd->num_codecs > 1) ?
+				"multicodec" : rtd->codec_dai->name, num);
 
 		ret = snd_pcm_new(rtd->card->snd_card, new_name, num, playback,
 			capture, &pcm);
@@ -2315,8 +2507,9 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 	pcm->private_free = platform->driver->pcm_free;
 out:
-	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n", codec_dai->name,
-		cpu_dai->name);
+	dev_info(rtd->card->dev, "%s <-> %s mapping ok\n",
+		 (rtd->num_codecs > 1) ? "multicodec" : rtd->codec_dai->name,
+		 cpu_dai->name);
 	return ret;
 }
 
-- 
1.9.1
