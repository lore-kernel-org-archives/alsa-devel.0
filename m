From: Benoit Cousson <bcousson@baylibre.com>
Subject: [PATCH v4 7/8] ASoC: pcm: Add soc_dai_hw_params helper
Date: Tue,  1 Jul 2014 09:48:00 +0200
Message-ID: <1404200881-32253-8-git-send-email-bcousson@baylibre.com>
References: <1404200881-32253-1-git-send-email-bcousson@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f169.google.com (mail-we0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DE562656FD
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 09:49:06 +0200 (CEST)
Received: by mail-we0-f169.google.com with SMTP id t60so9281117wes.14
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 00:49:05 -0700 (PDT)
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
Cc: misael.lopez@ti.com, alsa-devel@alsa-project.org, Benoit Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org

Add a function helper to factorize the hw_params code.

Suggested by Lars-Peter Clausen <lars@metafoo.de>

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 include/sound/soc.h  |  4 ++++
 sound/soc/soc-dapm.c | 26 ++++++--------------------
 sound/soc/soc-pcm.c  | 41 ++++++++++++++++++++++-------------------
 3 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index f2142cf..98555f8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -436,6 +436,10 @@ int snd_soc_set_runtime_hwparams(struct snd_pcm_substream *substream,
 int snd_soc_platform_trigger(struct snd_pcm_substream *substream,
 		int cmd, struct snd_soc_platform *platform);
 
+int soc_dai_hw_params(struct snd_pcm_substream *substream,
+		      struct snd_pcm_hw_params *params,
+		      struct snd_soc_dai *dai);
+
 /* Jack reporting */
 int snd_soc_jack_new(struct snd_soc_codec *codec, const char *id, int type,
 		     struct snd_soc_jack *jack);
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5c63c3b..d8a24bb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3214,27 +3214,13 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		if (source->driver->ops && source->driver->ops->hw_params) {
-			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-			ret = source->driver->ops->hw_params(&substream,
-							     params, source);
-			if (ret != 0) {
-				dev_err(source->dev,
-					"ASoC: hw_params() failed: %d\n", ret);
-				goto out;
-			}
-		}
+		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+		if (soc_dai_hw_params(&substream, params, source) < 0)
+			goto out;
 
-		if (sink->driver->ops && sink->driver->ops->hw_params) {
-			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-			ret = sink->driver->ops->hw_params(&substream, params,
-							   sink);
-			if (ret != 0) {
-				dev_err(sink->dev,
-					"ASoC: hw_params() failed: %d\n", ret);
-				goto out;
-			}
-		}
+		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+		if (soc_dai_hw_params(&substream, params, sink) < 0)
+			goto out;
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 981b99c..b48f2a8 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -780,6 +780,24 @@ static void soc_pcm_codec_params_fixup(struct snd_pcm_hw_params *params,
 	interval->max = channels;
 }
 
+int soc_dai_hw_params(struct snd_pcm_substream *substream,
+		      struct snd_pcm_hw_params *params,
+		      struct snd_soc_dai *dai)
+{
+	int ret;
+
+	if (dai->driver->ops && dai->driver->ops->hw_params) {
+		ret = dai->driver->ops->hw_params(substream, params, dai);
+		if (ret < 0) {
+			dev_err(dai->dev, "ASoC: can't set %s hw params: %d\n",
+				dai->name, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * Called by ALSA when the hardware params are set by application. This
  * function can also be called multiple times and can allocate buffers
@@ -823,17 +841,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 			soc_pcm_codec_params_fixup(&codec_params,
 						   codec_dai->rx_mask);
 
-		if (codec_dai->driver->ops &&
-		    codec_dai->driver->ops->hw_params) {
-			ret = codec_dai->driver->ops->hw_params(substream,
-						&codec_params, codec_dai);
-			if (ret < 0) {
-				dev_err(codec_dai->dev,
-					"ASoC: can't set %s hw params: %d\n",
-					codec_dai->name, ret);
-				goto codec_err;
-			}
-		}
+		if (soc_dai_hw_params(substream, &codec_params, codec_dai) < 0)
+			goto codec_err;
 
 		codec_dai->rate = params_rate(&codec_params);
 		codec_dai->channels = params_channels(&codec_params);
@@ -841,14 +850,8 @@ static int soc_pcm_hw_params(struct snd_pcm_substream *substream,
 						params_format(&codec_params));
 	}
 
-	if (cpu_dai->driver->ops && cpu_dai->driver->ops->hw_params) {
-		ret = cpu_dai->driver->ops->hw_params(substream, params, cpu_dai);
-		if (ret < 0) {
-			dev_err(cpu_dai->dev, "ASoC: %s hw params failed: %d\n",
-				cpu_dai->name, ret);
-			goto interface_err;
-		}
-	}
+	if (soc_dai_hw_params(substream, params, cpu_dai) < 0)
+		goto interface_err;
 
 	if (platform->driver->ops && platform->driver->ops->hw_params) {
 		ret = platform->driver->ops->hw_params(substream, params);
-- 
1.9.1
