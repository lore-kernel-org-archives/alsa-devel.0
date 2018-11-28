From: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 4/5] ASoC: sdm845: Add configuration for headset codec
Date: Wed, 28 Nov 2018 17:00:36 +0800
Message-ID: <20181128090037.257359-4-cychiang@chromium.org>
References: <20181128090037.257359-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128090037.257359-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, dgreid@chromium.org, tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

Set DAI format and sysclk for headset codec.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index d0df7ec6042e2..1db8ef6682233 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -14,6 +14,7 @@
 #include <uapi/linux/input-event-codes.h>
 #include "common.h"
 #include "qdsp6/q6afe.h"
+#include "../codecs/rt5663.h"
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
@@ -125,9 +126,27 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	int ret = 0;
 
 	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+	case PRIMARY_MI2S_TX:
+		/*
+		 * Use ASRC for internal clocks, as PLL rate isn't multiple
+		 * of BCLK.
+		 */
+		rt5663_sel_asrc_clk_src(
+			codec_dai->component,
+			RT5663_DA_STEREO_FILTER | RT5663_AD_STEREO_FILTER,
+			RT5663_CLK_SEL_I2S1_ASRC);
+		ret = snd_soc_dai_set_sysclk(
+			codec_dai, RT5663_SCLK_S_MCLK, DEFAULT_MCLK_RATE,
+			SND_SOC_CLOCK_IN);
+		if (ret < 0)
+			dev_err(rtd->dev,
+				"snd_soc_dai_set_sysclk err = %d\n", ret);
+		break;
 	case QUATERNARY_TDM_RX_0:
 	case QUATERNARY_TDM_TX_0:
 		ret = sdm845_tdm_snd_hw_params(substream, params);
@@ -202,6 +221,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case PRIMARY_MI2S_RX:
 	case PRIMARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF;
 		if (++(data->pri_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_MCLK_1,
@@ -211,6 +231,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case SECONDARY_MI2S_TX:
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
