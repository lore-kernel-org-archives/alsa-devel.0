From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 3/5] ASoC: sdm845: Add TDM configuration for speaker
Date: Wed, 28 Nov 2018 17:00:35 +0800
Message-ID: <20181128090037.257359-3-cychiang@chromium.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Set TDM time slots and DAI format for speaker codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 43c03f8e8cdc2..d0df7ec6042e2 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -6,9 +6,11 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
+#include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/jack.h>
+#include <sound/soc.h>
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
@@ -17,6 +19,10 @@
 #define DEFAULT_MCLK_RATE		24576000
 #define TDM_BCLK_RATE		6144000
 #define MI2S_BCLK_RATE		1536000
+#define LEFT_SPK_TDM_TX_MASK    0x30
+#define RIGHT_SPK_TDM_TX_MASK   0xC0
+#define SPK_TDM_RX_MASK         0x03
+#define NUM_TDM_SLOTS           8
 
 struct sdm845_snd_data {
 	struct snd_soc_jack jack;
@@ -34,7 +40,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-	int ret = 0;
+	int ret = 0, j;
 	int channels, slot_width;
 
 	switch (params_format(params)) {
@@ -81,6 +87,35 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 			goto end;
 		}
 	}
+
+	for (j = 0; j < rtd->num_codecs; j++) {
+		struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+
+		if (!strcmp(codec_dai->component->name_prefix, "Left")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, LEFT_SPK_TDM_TX_MASK,
+					SPK_TDM_RX_MASK, NUM_TDM_SLOTS,
+					slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV0 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+
+		if (!strcmp(codec_dai->component->name_prefix, "Right")) {
+			ret = snd_soc_dai_set_tdm_slot(
+					codec_dai, RIGHT_SPK_TDM_TX_MASK,
+					SPK_TDM_RX_MASK, NUM_TDM_SLOTS,
+					slot_width);
+			if (ret < 0) {
+				dev_err(rtd->dev,
+					"DEV1 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+	}
+
 end:
 	return ret;
 }
@@ -155,10 +190,14 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 {
 	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct sdm845_snd_data *data = snd_soc_card_get_drvdata(card);
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int j;
+	int ret;
 
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
@@ -190,6 +229,34 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
 				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
+
+		codec_dai_fmt |= SND_SOC_DAIFMT_IB_NF | SND_SOC_DAIFMT_DSP_B;
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			codec_dai = rtd->codec_dais[j];
+
+			if (!strcmp(codec_dai->component->name_prefix,
+				    "Left")) {
+				ret = snd_soc_dai_set_fmt(
+						codec_dai, codec_dai_fmt);
+				if (ret < 0) {
+					dev_err(rtd->dev,
+						"Left TDM fmt err:%d\n", ret);
+					return ret;
+				}
+			}
+
+			if (!strcmp(codec_dai->component->name_prefix,
+				    "Right")) {
+				ret = snd_soc_dai_set_fmt(
+						codec_dai, codec_dai_fmt);
+				if (ret < 0) {
+					dev_err(rtd->dev,
+						"Right TDM slot err:%d\n", ret);
+					return ret;
+				}
+			}
+		}
 		break;
 
 	default:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
