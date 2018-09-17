From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 14/14] ASoC: qcom: common: move be_hw_fixup to common
Date: Sun, 16 Sep 2018 17:57:27 -0700
Message-ID: <20180917005727.32728-15-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

be_hw_fixup for qdsp is common across mutiple qcom machine drivers,
so move it to common file and remove the redundant code.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 15 ---------------
 sound/soc/qcom/common.c  | 17 +++++++++++++++++
 sound/soc/qcom/sdm845.c  | 22 ++--------------------
 3 files changed, 19 insertions(+), 35 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index daad43f..9cb26aee 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -20,20 +20,6 @@ struct apq8096_card_data {
 	bool jack_setup;
 };
 
-static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				      struct snd_pcm_hw_params *params)
-{
-	struct snd_interval *rate = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_CHANNELS);
-
-	rate->min = rate->max = 48000;
-	channels->min = channels->max = 2;
-
-	return 0;
-}
-
 static int msm_snd_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
@@ -139,7 +125,6 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 
 	for (i = 0; i < num_links; i++) {
 		if (link->no_pcm == 1) {
-			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
 			link->init = apq8096_init;
 			link->ops = &apq8096_ops;
 		}
diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index eb1b9da..ce8e759 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -3,8 +3,24 @@
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
 #include <linux/module.h>
+#include <sound/pcm_params.h>
 #include "common.h"
 
+static int qcom_snd_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				       struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+					SNDRV_PCM_HW_PARAM_CHANNELS);
+
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+	params_set_format(params, SNDRV_PCM_FORMAT_S16_LE);
+
+	return 0;
+}
+
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
 	struct device_node *np;
@@ -79,6 +95,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			}
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
+			link->be_hw_params_fixup = qcom_snd_be_hw_params_fixup;
 		} else {
 			link->platform_of_node = link->cpu_of_node;
 			link->codec_dai_name = "snd-soc-dummy-dai";
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 2a781d8..87e150c 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -11,7 +11,6 @@
 #include "common.h"
 #include "qdsp6/q6afe.h"
 
-#define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
 #define DEFAULT_BCLK_RATE		12288000
 
@@ -177,32 +176,15 @@ static struct snd_soc_ops sdm845_be_ops = {
 	.shutdown = sdm845_snd_shutdown,
 };
 
-static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
-				struct snd_pcm_hw_params *params)
-{
-	struct snd_interval *rate = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval *channels = hw_param_interval(params,
-					SNDRV_PCM_HW_PARAM_CHANNELS);
-	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-
-	rate->min = rate->max = DEFAULT_SAMPLE_RATE_48K;
-	channels->min = channels->max = 2;
-	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
-
-	return 0;
-}
-
 static void sdm845_add_be_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link = card->dai_link;
 	int i, num_links = card->num_links;
 
 	for (i = 0; i < num_links; i++) {
-		if (link->no_pcm == 1) {
+		if (link->no_pcm == 1)
 			link->ops = &sdm845_be_ops;
-			link->be_hw_params_fixup = sdm845_be_hw_params_fixup;
-		}
+
 		link++;
 	}
 }
-- 
2.9.3
