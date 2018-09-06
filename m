From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Add support for multi-CODEC CODEC
	to CODEC links" to the asoc tree
Date: Thu,  6 Sep 2018 11:48:51 +0100 (BST)
Message-ID: <20180906104851.0A8751122A1F@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB0C26779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:48:52 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Add support for multi-CODEC CODEC to CODEC links

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 4a75aae17b2a802a7267206414050408392c374c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 5 Sep 2018 15:21:01 +0100
Subject: [PATCH] ASoC: dapm: Add support for multi-CODEC CODEC to CODEC links

Currently multi-CODEC is not supported on CODEC to CODEC links.
There are common applications where this would be useful, such
as connecting two mono amplifiers to an audio CODEC. Adding
support simply requires an update of snd_soc_dai_link_event
to loop over the attached CODEC DAIs.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 123 ++++++++++++++++++++++++-------------------
 1 file changed, 70 insertions(+), 53 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index bbfcb7fc05cc..40f27c95da61 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3614,7 +3614,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_new_controls);
 static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *kcontrol, int event)
 {
-	struct snd_soc_dapm_path *source_p, *sink_p;
+	struct snd_soc_dapm_path *path;
 	struct snd_soc_dai *source, *sink;
 	struct snd_soc_pcm_runtime *rtd = w->priv;
 	const struct snd_soc_pcm_stream *config = w->params + w->params_select;
@@ -3629,17 +3629,6 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
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
@@ -3681,59 +3670,90 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
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
 
@@ -4043,9 +4063,6 @@ static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
 	int i;
 
 	if (rtd->dai_link->params) {
-		if (rtd->num_codecs > 1)
-			dev_warn(card->dev, "ASoC: Multiple codecs not supported yet\n");
-
 		playback_cpu = cpu_dai->capture_widget;
 		capture_cpu = cpu_dai->playback_widget;
 	} else {
-- 
2.19.0.rc1
