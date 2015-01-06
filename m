From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] ASoC: Add helper function for changing the
	DAI link format
Date: Tue,  6 Jan 2015 15:17:20 +0100
Message-ID: <1420553842-17335-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-112.synserver.de (smtp-out-112.synserver.de
 [212.40.185.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0240A26085C
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 15:17:27 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

For some setups it is necessary to change the DAI link format at runtime.
This patch factors out the code that does the initial static DAI link format
configuration into a separate helper function which can be used board
drivers as well.

This allows board drivers that have to change the DAI link format at runtime
to reuse it instead of having to manually change the format on all DAIs.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc.h  |   3 ++
 sound/soc/soc-core.c | 125 ++++++++++++++++++++++++++++-----------------------
 2 files changed, 72 insertions(+), 56 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b4fca9a..edd4a0a 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -429,6 +429,9 @@ bool snd_soc_runtime_ignore_pmdown_time(struct snd_soc_pcm_runtime *rtd);
 void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream);
 void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream);
 
+int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
+	unsigned int dai_fmt);
+
 /* Utility functions to get clock rates from various things */
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots);
 int snd_soc_params_to_frame_size(struct snd_pcm_hw_params *params);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c024962..4b8dc5f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1427,11 +1427,75 @@ static int snd_soc_init_codec_cache(struct snd_soc_codec *codec)
 	return 0;
 }
 
+/**
+ * snd_soc_runtime_set_dai_fmt() - Change DAI link format for a ASoC runtime
+ * @rtd: The runtime for which the DAI link format should be changed
+ * @dai_fmt: The new DAI link format
+ *
+ * This function updates the DAI link format for all DAIs connected to the DAI
+ * link for the specified runtime.
+ *
+ * Note: For setups with a static format set the dai_fmt field in the
+ * corresponding snd_dai_link struct instead of using this function.
+ *
+ * Returns 0 on success, otherwise a negative error code.
+ */
+int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
+	unsigned int dai_fmt)
+{
+	struct snd_soc_dai **codec_dais = rtd->codec_dais;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < rtd->num_codecs; i++) {
+		struct snd_soc_dai *codec_dai = codec_dais[i];
+
+		ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
+		if (ret != 0 && ret != -ENOTSUPP) {
+			dev_warn(codec_dai->dev,
+				 "ASoC: Failed to set DAI format: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/* Flip the polarity for the "CPU" end of a CODEC<->CODEC link */
+	if (cpu_dai->codec) {
+		unsigned int inv_dai_fmt;
+
+		inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_MASTER_MASK;
+		switch (dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+		case SND_SOC_DAIFMT_CBM_CFM:
+			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+			break;
+		case SND_SOC_DAIFMT_CBM_CFS:
+			inv_dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+			break;
+		case SND_SOC_DAIFMT_CBS_CFM:
+			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
+			break;
+		case SND_SOC_DAIFMT_CBS_CFS:
+			inv_dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+			break;
+		}
+
+		dai_fmt = inv_dai_fmt;
+	}
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, dai_fmt);
+	if (ret != 0 && ret != -ENOTSUPP) {
+		dev_warn(cpu_dai->dev,
+			 "ASoC: Failed to set DAI format: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
 	struct snd_soc_codec *codec;
-	struct snd_soc_dai_link *dai_link;
-	int ret, i, order, dai_fmt;
+	int ret, i, order;
 
 	mutex_lock_nested(&card->mutex, SND_SOC_CARD_CLASS_INIT);
 
@@ -1542,60 +1606,9 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 					card->num_dapm_routes);
 
 	for (i = 0; i < card->num_links; i++) {
-		struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
-		dai_link = &card->dai_link[i];
-		dai_fmt = dai_link->dai_fmt;
-
-		if (dai_fmt) {
-			struct snd_soc_dai **codec_dais = rtd->codec_dais;
-			int j;
-
-			for (j = 0; j < rtd->num_codecs; j++) {
-				struct snd_soc_dai *codec_dai = codec_dais[j];
-
-				ret = snd_soc_dai_set_fmt(codec_dai, dai_fmt);
-				if (ret != 0 && ret != -ENOTSUPP)
-					dev_warn(codec_dai->dev,
-						 "ASoC: Failed to set DAI format: %d\n",
-						 ret);
-			}
-		}
-
-		/* If this is a regular CPU link there will be a platform */
-		if (dai_fmt &&
-		    (dai_link->platform_name || dai_link->platform_of_node)) {
-			ret = snd_soc_dai_set_fmt(card->rtd[i].cpu_dai,
-						  dai_fmt);
-			if (ret != 0 && ret != -ENOTSUPP)
-				dev_warn(card->rtd[i].cpu_dai->dev,
-					 "ASoC: Failed to set DAI format: %d\n",
-					 ret);
-		} else if (dai_fmt) {
-			/* Flip the polarity for the "CPU" end */
-			dai_fmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
-			switch (dai_link->dai_fmt &
-				SND_SOC_DAIFMT_MASTER_MASK) {
-			case SND_SOC_DAIFMT_CBM_CFM:
-				dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
-				break;
-			case SND_SOC_DAIFMT_CBM_CFS:
-				dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
-				break;
-			case SND_SOC_DAIFMT_CBS_CFM:
-				dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
-				break;
-			case SND_SOC_DAIFMT_CBS_CFS:
-				dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
-				break;
-			}
-
-			ret = snd_soc_dai_set_fmt(card->rtd[i].cpu_dai,
-						  dai_fmt);
-			if (ret != 0 && ret != -ENOTSUPP)
-				dev_warn(card->rtd[i].cpu_dai->dev,
-					 "ASoC: Failed to set DAI format: %d\n",
-					 ret);
-		}
+		if (card->dai_link[i].dai_fmt)
+			snd_soc_runtime_set_dai_fmt(&card->rtd[i],
+				card->dai_link[i].dai_fmt);
 	}
 
 	snprintf(card->snd_card->shortname, sizeof(card->snd_card->shortname),
-- 
1.8.0
