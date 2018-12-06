From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sdm845: Add TDM configuration for speaker" to the asoc tree
Date: Thu,  6 Dec 2018 20:25:44 +0000 (GMT)
Message-ID: <20181206202544.2AF2111252F7@debutante.sirena.org.uk>
References: <20181128090037.257359-3-cychiang@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128090037.257359-3-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tzungbi@chromium.orgMark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>, dgreid@chromium.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sdm845: Add TDM configuration for speaker

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

>From 1d92332180659fab7d014eff5e0ab5e133424e3e Mon Sep 17 00:00:00 2001
From: Cheng-Yi Chiang <cychiang@chromium.org>
Date: Wed, 28 Nov 2018 17:00:35 +0800
Subject: [PATCH] ASoC: sdm845: Add TDM configuration for speaker

Set TDM time slots and DAI format for speaker codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 69 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 43c03f8e8cdc..d0df7ec6042e 100644
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
2.19.0.rc2
