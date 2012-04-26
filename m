From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Dynamically move CODEC<->CODEC
	params off stack
Date: Thu, 26 Apr 2012 19:13:11 +0100
Message-ID: <1335463991-29110-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4A1F10BBE5
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2012 20:13:14 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Reduce our stack consumption by moving the params off the stack, they
are reasonably large and might be an issue on platforms with small stacks.

Reported-by: Liam Girdwood <lrg@ti.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 75b3ad6..522032e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2987,7 +2987,7 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_dai *source, *sink;
 	const struct snd_soc_pcm_stream *config = w->params;
 	struct snd_pcm_substream substream;
-	struct snd_pcm_hw_params params;
+	struct snd_pcm_hw_params *params = NULL;
 	u64 fmt;
 	int ret;
 
@@ -3017,17 +3017,21 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 	}
 
 	/* Currently very limited parameter selection */
-	memset(&params, 0, sizeof(params));
-	snd_mask_set(hw_param_mask(&params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	snd_mask_set(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT), fmt);
 
-	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->min =
+	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->min =
 		config->rate_min;
-	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_RATE)->max =
+	hw_param_interval(params, SNDRV_PCM_HW_PARAM_RATE)->max =
 		config->rate_max;
 
-	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->min
+	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->min
 		= config->channels_min;
-	hw_param_interval(&params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
+	hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS)->max
 		= config->channels_max;
 
 	memset(&substream, 0, sizeof(substream));
@@ -3037,22 +3041,22 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		if (source->driver->ops && source->driver->ops->hw_params) {
 			substream.stream = SNDRV_PCM_STREAM_CAPTURE;
 			ret = source->driver->ops->hw_params(&substream,
-							     &params, source);
+							     params, source);
 			if (ret != 0) {
 				dev_err(source->dev,
 					"hw_params() failed: %d\n", ret);
-				return ret;
+				goto out;
 			}
 		}
 
 		if (sink->driver->ops && sink->driver->ops->hw_params) {
 			substream.stream = SNDRV_PCM_STREAM_PLAYBACK;
-			ret = sink->driver->ops->hw_params(&substream, &params,
+			ret = sink->driver->ops->hw_params(&substream, params,
 							   sink);
 			if (ret != 0) {
 				dev_err(sink->dev,
 					"hw_params() failed: %d\n", ret);
-				return ret;
+				goto out;
 			}
 		}
 		break;
@@ -3061,12 +3065,14 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		ret = snd_soc_dai_digital_mute(sink, 0);
 		if (ret != 0 && ret != -ENOTSUPP)
 			dev_warn(sink->dev, "Failed to unmute: %d\n", ret);
+		ret = 0;
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
 		ret = snd_soc_dai_digital_mute(sink, 1);
 		if (ret != 0 && ret != -ENOTSUPP)
 			dev_warn(sink->dev, "Failed to mute: %d\n", ret);
+		ret = 0;
 		break;
 
 	default:
@@ -3074,7 +3080,9 @@ static int snd_soc_dai_link_event(struct snd_soc_dapm_widget *w,
 		return -EINVAL;
 	}
 
-	return 0;
+out:
+	kfree(params);
+	return ret;
 }
 
 int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
-- 
1.7.10
