From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 09/13] ASoC: qcom: add bit map to track static dma channel allocations
Date: Sat, 16 May 2015 13:33:14 +0100
Message-ID: <1431779594-2249-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds dma channel bit mask to lpass data to keep track of dma
channel allocations. This flag would be used in apq8016 lpass driver.

Tested-by: Kenneth Westfield <kwestfie@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index d572e7b..deecae9 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -49,6 +49,9 @@ struct lpass_data {
 	/* SOC specific variations in the LPASS IP integration */
 	struct lpass_variant *variant;
 
+	/* bit map to keep track of static channel allocations */
+	unsigned long rdma_ch_bit_map;
+
 	/* used it for handling interrupt per dma channel */
 	struct snd_pcm_substream *substream[LPASS_MAX_DMA_CHANNELS];
 };
-- 
1.9.1
