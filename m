From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 12/13] ASoC: apq8096: add slim support
Date: Tue,  4 Sep 2018 11:24:59 +0100
Message-ID: <20180904102500.30318-13-srinivas.kandagatla@linaro.org>
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 69 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 1543e85629f8..db07e9b62daf 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -9,6 +9,10 @@
 #include <sound/pcm.h>
 #include "common.h"
 
+#define SLIM_MAX_TX_PORTS 16
+#define SLIM_MAX_RX_PORTS 16
+#define WCD9335_DEFAULT_MCLK_RATE	9600000
+
 static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 				      struct snd_pcm_hw_params *params)
 {
@@ -19,6 +23,66 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	rate->min = rate->max = 48000;
 	channels->min = channels->max = 2;
+}
+
+static int msm_snd_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	u32 rx_ch[SLIM_MAX_RX_PORTS], tx_ch[SLIM_MAX_TX_PORTS];
+	u32 rx_ch_cnt = 0, tx_ch_cnt = 0;
+	int ret = 0;
+
+	ret = snd_soc_dai_get_channel_map(codec_dai,
+				&tx_ch_cnt, tx_ch, &rx_ch_cnt, rx_ch);
+	if (ret != 0 && ret != -ENOTSUPP) {
+		pr_err("failed to get codec chan map, err:%d\n", ret);
+		goto end;
+	} else if (ret == -ENOTSUPP) {
+		return 0;
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ret = snd_soc_dai_set_channel_map(cpu_dai, 0, NULL,
+						  rx_ch_cnt, rx_ch);
+	else
+		ret = snd_soc_dai_set_channel_map(cpu_dai, tx_ch_cnt, tx_ch,
+						  0, NULL);
+	if (ret != 0 && ret != -ENOTSUPP)
+		pr_err("Failed to set cpu chan map, err:%d\n", ret);
+	else if (ret == -ENOTSUPP)
+		ret = 0;
+end:
+	return ret;
+}
+
+static struct snd_soc_ops apq8096_ops = {
+	.hw_params = msm_snd_hw_params,
+};
+
+static int apq8096_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+
+	/*
+	 * Codec SLIMBUS configuration
+	 * RX1, RX2, RX3, RX4, RX5, RX6, RX7, RX8, RX9, RX10, RX11, RX12, RX13
+	 * TX1, TX2, TX3, TX4, TX5, TX6, TX7, TX8, TX9, TX10, TX11, TX12, TX13
+	 * TX14, TX15, TX16
+	 */
+	unsigned int rx_ch[SLIM_MAX_RX_PORTS] = {144, 145, 146, 147, 148, 149,
+					150, 151, 152, 153, 154, 155, 156};
+	unsigned int tx_ch[SLIM_MAX_TX_PORTS] = {128, 129, 130, 131, 132, 133,
+					    134, 135, 136, 137, 138, 139,
+					    140, 141, 142, 143};
+
+	snd_soc_dai_set_channel_map(codec_dai, ARRAY_SIZE(tx_ch),
+					tx_ch, ARRAY_SIZE(rx_ch), rx_ch);
+
+	snd_soc_dai_set_sysclk(codec_dai, 0, WCD9335_DEFAULT_MCLK_RATE,
+				SNDRV_PCM_STREAM_PLAYBACK);
 
 	return 0;
 }
@@ -29,8 +93,11 @@ static void apq8096_add_be_ops(struct snd_soc_card *card)
 	int i, num_links = card->num_links;
 
 	for (i = 0; i < num_links; i++) {
-		if (link->no_pcm == 1)
+		if (link->no_pcm == 1) {
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+			link->init = apq8096_init;
+			link->ops = &apq8096_ops;
+		}
 		link++;
 	}
 }
-- 
2.18.0
