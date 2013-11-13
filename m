From: Nicolin Chen <b42378@freescale.com>
Subject: [RFC][PATCH v1] ASoC: soc-pcm: add symmetry for
	channels and sample bits
Date: Wed, 13 Nov 2013 18:56:24 +0800
Message-ID: <1384340184-4381-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 26CAE26165C
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 11:56:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some SoCs can only work in mono or stereo mode at one time. So if
we let them capture a mono stream while playing a stereo stream,
there might be a problem occur to one of these two streams: double
paced or slowed down.

In soc-pcm.c, we have soc_pcm_apply_symmetry() to apply the rate
symmetry. But we don't have one for channels.

Likewise, we can treat symmetric_rate as a solution for those SoCs
or CODECs which can not handle asymmetrical LRCLK. But it's also
impossible for them to handle asymmetrical BCLK. And accodring to
BCLK = LRCLK * channel number * slot size(fixed or sample bits),
sample bits might also be a problem if they are not using a fixed
slot size.

Thus, this patch applys symmetry for channels and sample bits.

Meanwhile, there might be a race between two substreams if starting
simultaneously. Previously, we only added warning to compalin but
still using conservative way to let it carry on. However, this patch
rejects the second stream with any unmatched parameter to make sure
the first existing stream won't be broken.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 include/sound/soc-dai.h |   6 +++
 include/sound/soc.h     |   2 +
 sound/soc/soc-pcm.c     | 130 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 115 insertions(+), 23 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 800c101..243d3b6 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -220,6 +220,8 @@ struct snd_soc_dai_driver {
 	struct snd_soc_pcm_stream capture;
 	struct snd_soc_pcm_stream playback;
 	unsigned int symmetric_rates:1;
+	unsigned int symmetric_channels:1;
+	unsigned int symmetric_samplebits:1;
 
 	/* probe ordering - for components with runtime dependencies */
 	int probe_order;
@@ -244,6 +246,8 @@ struct snd_soc_dai {
 	unsigned int capture_active:1;		/* stream is in use */
 	unsigned int playback_active:1;		/* stream is in use */
 	unsigned int symmetric_rates:1;
+	unsigned int symmetric_channels:1;
+	unsigned int symmetric_samplebits:1;
 	struct snd_pcm_runtime *runtime;
 	unsigned int active;
 	unsigned char probed:1;
@@ -258,6 +262,8 @@ struct snd_soc_dai {
 
 	/* Symmetry data - only valid if symmetry is being enforced */
 	unsigned int rate;
+	unsigned int channels;
+	unsigned int sample_bits;
 
 	/* parent platform/codec */
 	struct snd_soc_platform *platform;
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 1f741cb..1cda7d3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -879,6 +879,8 @@ struct snd_soc_dai_link {
 
 	/* Symmetry requirements */
 	unsigned int symmetric_rates:1;
+	unsigned int symmetric_channels:1;
+	unsigned int symmetric_samplebits:1;
 
 	/* Do not create a PCM for this DAI link (Backend link) */
 	unsigned int no_pcm:1;
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d449872..e1c5a00 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -83,30 +83,97 @@ static int soc_pcm_apply_symmetry(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	int ret;
 
-	if (!soc_dai->driver->symmetric_rates &&
-	    !rtd->dai_link->symmetric_rates)
-		return 0;
+	if (soc_dai->rate && (soc_dai->driver->symmetric_rates ||
+				rtd->dai_link->symmetric_rates)) {
+		dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %dHz rate\n",
+				soc_dai->rate);
+
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						SNDRV_PCM_HW_PARAM_RATE,
+						soc_dai->rate, soc_dai->rate);
+		if (ret < 0) {
+			dev_err(soc_dai->dev,
+				"ASoC: Unable to apply rate constraint: %d\n",
+				ret);
+			return ret;
+		}
+	}
 
-	/* This can happen if multiple streams are starting simultaneously -
-	 * the second can need to get its constraints before the first has
-	 * picked a rate.  Complain and allow the application to carry on.
-	 */
-	if (!soc_dai->rate) {
-		dev_warn(soc_dai->dev,
-			 "ASoC: Not enforcing symmetric_rates due to race\n");
-		return 0;
+	if (soc_dai->channels && (soc_dai->driver->symmetric_channels ||
+				rtd->dai_link->symmetric_channels)) {
+		dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %d channel(s)\n",
+				soc_dai->channels);
+
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						SNDRV_PCM_HW_PARAM_CHANNELS,
+						soc_dai->channels,
+						soc_dai->channels);
+		if (ret < 0) {
+			dev_err(soc_dai->dev,
+				"ASoC: Unable to apply channel symmetry constraint: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
-	dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %dHz rate\n", soc_dai->rate);
+	if (soc_dai->sample_bits && (soc_dai->driver->symmetric_samplebits ||
+				rtd->dai_link->symmetric_samplebits)) {
+		dev_dbg(soc_dai->dev, "ASoC: Symmetry forces %d sample bits\n",
+				soc_dai->sample_bits);
 
-	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
-					   SNDRV_PCM_HW_PARAM_RATE,
-					   soc_dai->rate, soc_dai->rate);
-	if (ret < 0) {
-		dev_err(soc_dai->dev,
-			"ASoC: Unable to apply rate symmetry constraint: %d\n",
-			ret);
-		return ret;
+		ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+						SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+						soc_dai->sample_bits,
+						soc_dai->sample_bits);
+		if (ret < 0) {
+			dev_err(soc_dai->dev,
+				"ASoC: Unable to apply sample bits symmetry constraint: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int soc_pcm_params_symmetry(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int rate, channels, sample_bits, symmetry;
+
+	rate = params_rate(params);
+	channels = params_channels(params);
+	sample_bits = snd_pcm_format_physical_width(params_format(params));
+
+	/* reject unmatched parameters when applying symmetry */
+	symmetry = cpu_dai->driver->symmetric_rates ||
+		codec_dai->driver->symmetric_rates ||
+		rtd->dai_link->symmetric_rates;
+	if (symmetry && cpu_dai->rate && cpu_dai->rate != rate) {
+		dev_err(rtd->dev, "ASoC: unmatched rate symmetry: %d - %d\n",
+				cpu_dai->rate, rate);
+		return -EINVAL;
+	}
+
+	symmetry = cpu_dai->driver->symmetric_channels ||
+		codec_dai->driver->symmetric_channels ||
+		rtd->dai_link->symmetric_channels;
+	if (symmetry && cpu_dai->channels && cpu_dai->channels != channels) {
+		dev_err(rtd->dev, "ASoC: unmatched channel symmetry: %d - %d\n",
+				cpu_dai->channels, channels);
+		return -EINVAL;
+	}
+
+	symmetry = cpu_dai->driver->symmetric_samplebits ||
+		codec_dai->driver->symmetric_samplebits ||
+		rtd->dai_link->symmetric_samplebits;
+	if (symmetry && cpu_dai->sample_bits && cpu_dai->sample_bits != sample_bits) {
+		dev_err(rtd->dev, "ASoC: unmatched sample bits symmetry: %d - %d\n",
+				cpu_dai->sample_bits, sample_bits);
+		return -EINVAL;
 	}
 
 	return 0;
@@ -377,11 +444,17 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	codec->active--;
 
 	/* clear the corresponding DAIs rate when inactive */
-	if (!cpu_dai->active)
+	if (!cpu_dai->active) {
 		cpu_dai->rate = 0;
+		cpu_dai->channels = 0;
+		cpu_dai->sample_bits = 0;
+	}
 
-	if (!codec_dai->active)
+	if (!codec_dai->active) {
 		codec_dai->rate = 0;
+		cpu_dai->channels = 0;
+		cpu_dai->sample_bits = 0;
+	}
 
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
@@ -514,6 +587,10 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+	ret = soc_pcm_params_symmetry(substream, params);
+	if (ret)
+		goto out;
+
 	if (rtd->dai_link->ops && rtd->dai_link->ops->hw_params) {
 		ret = rtd->dai_link->ops->hw_params(substream, params);
 		if (ret < 0) {
@@ -550,9 +627,16 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	/* store the rate for each DAIs */
+	/* store the parameters for each DAIs */
 	cpu_dai->rate = params_rate(params);
+	cpu_dai->channels = params_channels(params);
+	cpu_dai->sample_bits =
+		snd_pcm_format_physical_width(params_format(params));
+
 	codec_dai->rate = params_rate(params);
+	codec_dai->channels = params_channels(params);
+	codec_dai->sample_bits =
+		snd_pcm_format_physical_width(params_format(params));
 
 out:
 	mutex_unlock(&rtd->pcm_mutex);
-- 
1.8.4
