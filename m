From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 6/7] ASoC: dapm: Add support for multi-CODEC
	CODEC to CODEC links
Date: Tue, 28 Aug 2018 14:35:07 +0100
Message-ID: <20180828133508.13012-6-ckeepax@opensource.cirrus.com>
References: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id B9C1F2678C4
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 15:35:13 +0200 (CEST)
In-Reply-To: <20180828133508.13012-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Currently multi-CODEC is not supported on CODEC to CODEC links.
There are common applications where this would be useful, such
as connecting two mono amplifiers to an audio CODEC. Adding
support simply requires an update of snd_soc_dai_link_event
to loop over the attached CODEC DAIs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-dapm.c | 123 +++++++++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 53 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index b3ed5c870baf..bf648e27e2cf 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3613,7 +3613,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_dapm_path *source_p, *sink_p;
+	struct snd_soc_dapm_path *path;
 	struct snd_soc_dai *source, *sink;
 	struct snd_soc_pcm_runtime *rtd = w->priv;
 	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
@@ -3628,17 +3628,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		    list_empty(&w->edges[SND_SOC_DAPM_DIR_IN])))
 		return -EINVAL;
 
-	/* We only support a single source and sink, pick the first */
-	source_p = list_first_entry(&w->edges[SND_SOC_DAPM_DIR_OUT],
-				    struct snd_soc_dapm_path,
-				    list_node[SND_SOC_DAPM_DIR_OUT]);
-	sink_p = list_first_entry(&w->edges[SND_SOC_DAPM_DIR_IN],
-				    struct snd_soc_dapm_path,
-				    list_node[SND_SOC_DAPM_DIR_IN]);
-
-	source = source_p->source->priv;
-	sink = sink_p->sink->priv;
-
 	/* Be a little careful as we don't want to overflow the mask array */
 	if (config->formats) {
 		fmt = ffs(config->formats) - 1;
@@ -3680,59 +3669,90 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-		if (source->driver->ops->startup) {
-			ret = source->driver->ops->startup(&substream, source);
-			if (ret < 0) {
-				dev_err(source->dev,
-					"ASoC: startup() failed: %d\n", ret);
-				goto out;
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
+
+			if (source->driver->ops->startup) {
+				ret = source->driver->ops->startup(&substream,
+								   source);
+				if (ret < 0) {
+					dev_err(source->dev,
+						"ASoC: startup() failed: %d\n",
+						ret);
+					goto out;
+				}
+				source->active++;
 			}
-			source->active++;
+			ret = soc_dai_hw_params(&substream, params, source);
+			if (ret < 0)
+				goto out;
 		}
-		ret = soc_dai_hw_params(&substream, params, source);
-		if (ret < 0)
-			goto out;
 
 		substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-		if (sink->driver->ops->startup) {
-			ret = sink->driver->ops->startup(&substream, sink);
-			if (ret < 0) {
-				dev_err(sink->dev,
-					"ASoC: startup() failed: %d\n", ret);
-				goto out;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+
+			if (sink->driver->ops->startup) {
+				ret = sink->driver->ops->startup(&substream,
+								 sink);
+				if (ret < 0) {
+					dev_err(sink->dev,
+						"ASoC: startup() failed: %d\n",
+						ret);
+					goto out;
+				}
+				sink->active++;
 			}
-			sink->active++;
+			ret = soc_dai_hw_params(&substream, params, sink);
+			if (ret < 0)
+				goto out;
 		}
-		ret = soc_dai_hw_params(&substream, params, sink);
-		if (ret < 0)
-			goto out;
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
-		ret = snd_soc_dai_digital_mute(sink, 0,
-					       SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret != 0 && ret != -ENOTSUPP)
-			dev_warn(sink->dev, "ASoC: Failed to unmute: %d\n", ret);
-		ret = 0;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+
+			ret = snd_soc_dai_digital_mute(sink, 0,
+						       SNDRV_PCM_STREAM_PLAYBACK);
+			if (ret != 0 && ret != -ENOTSUPP)
+				dev_warn(sink->dev,
+					 "ASoC: Failed to unmute: %d\n", ret);
+			ret = 0;
+		}
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-		ret = snd_soc_dai_digital_mute(sink, 1,
-					       SNDRV_PCM_STREAM_PLAYBACK);
-		if (ret != 0 && ret != -ENOTSUPP)
-			dev_warn(sink->dev, "ASoC: Failed to mute: %d\n", ret);
-		ret = 0;
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+
+			ret = snd_soc_dai_digital_mute(sink, 1,
+						       SNDRV_PCM_STREAM_PLAYBACK);
+			if (ret != 0 && ret != -ENOTSUPP)
+				dev_warn(sink->dev,
+					 "ASoC: Failed to mute: %d\n", ret);
+			ret = 0;
+		}
+
+		snd_soc_dapm_widget_for_each_source_path(w, path) {
+			source = path->source->priv;
 
-		source->active--;
-		if (source->driver->ops->shutdown) {
-			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
-			source->driver->ops->shutdown(&substream, source);
+			source->active--;
+			if (source->driver->ops->shutdown) {
+				substream.stream = SNDRV_PCM_STREAM_CAPTURE;
+				source->driver->ops->shutdown(&substream,
+							      source);
+			}
 		}
 
-		sink->active--;
-		if (sink->driver->ops->shutdown) {
-			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-			sink->driver->ops->shutdown(&substream, sink);
+		snd_soc_dapm_widget_for_each_sink_path(w, path) {
+			sink = path->sink->priv;
+
+			sink->active--;
+			if (sink->driver->ops->shutdown) {
+				substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
+				sink->driver->ops->shutdown(&substream, sink);
+			}
 		}
 		break;
 
@@ -4041,9 +4061,6 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	int i;
 
 	if (rtd->dai_link->params) {
-		if (rtd->num_codecs > 1)
-			dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
-
 		playback_cpu = cpu_dai->capture_widget;
 		capture_cpu = cpu_dai->playback_widget;
 	} else {
-- 
2.11.0
