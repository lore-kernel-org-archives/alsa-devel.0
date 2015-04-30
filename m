From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 08/14] ASoC: qcom: add dma channel control offset to variant data
Date: Thu, 30 Apr 2015 18:17:32 +0100
Message-ID: <1430414252-11210-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430414148-10869-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds ability to pass dma channel control bits start offset, which
differ in differnet qcom SOCs. On apq8016 dma channel control bits start
after an offset of 1.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 sound/soc/qcom/lpass.h          | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index fc08891..8ab0ac1 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
 	int bitwidth;
-	int ret, rdma_port = pcm_data->i2s_port;
+	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 301f784..e07ed52 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -61,6 +61,12 @@ struct lpass_variant {
 	u32	rdma_reg_stride;
 	u32	rdma_channels;
 
+	/**
+	 * on SOCs like APQ8016 the channel control bits start
+	 * at different offset to ipq806x
+	 **/
+	u32	rdmactl_audif_start;
+
 	/* OCR clock is not present in SOCs like APQ8016 */
 	bool	no_osr_clk;
 	/* SOC specific intialization like clocks */
-- 
1.9.1
