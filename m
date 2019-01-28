From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v6 8/8] ASoC: apq8096: add slim support
Date: Mon, 28 Jan 2019 14:27:53 +0000
Message-ID: <20190128142753.22396-9-srinivas.kandagatla@linaro.org>
References: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BFD722674D6
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 15:28:41 +0100 (CET)
Received: by mail-wr1-f68.google.com with SMTP id t6so18231237wrr.12
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2019 06:28:41 -0800 (PST)
In-Reply-To: <20190128142753.22396-1-srinivas.kandagatla@linaro.org>
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
Cc: alsa-devel@alsa-project.org, bgoswami@codeaurora.org, lgirdwood@gmail.com, vkoul@kernel.org, robh+dt@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 71 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index fb45f396ab4a..94363fd6846a 100644
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
@@ -23,14 +27,79 @@ static int apq8096_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
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
+
+	return 0;
+}
+
 static void apq8096_add_be_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
 	int i;
 
 	for_each_card_prelinks(card, i, link) {
-		if (link->no_pcm == 1)
+		if (link->no_pcm == 1) {
 			link->be_hw_params_fixup = apq8096_be_hw_params_fixup;
+			link->init = apq8096_init;
+			link->ops = &apq8096_ops;
+		}
 	}
 }
 
-- 
2.20.1
