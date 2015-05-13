From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 07/13] ASoC: qcom: add dma channel control offset to variant data
Date: Wed, 13 May 2015 13:02:41 +0100
Message-ID: <1431518561-7582-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1431518302-7139-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds ability to pass dma channel control bits start offset, which
differ in differnet qcom SOCs. On apq8016 dma channel control bits start
after an offset of 1.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 sound/soc/qcom/lpass.h          | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index 75e9370..023170a 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -61,6 +61,11 @@ struct lpass_variant {
 	u32	rdma_reg_stride;
 	u32	rdma_channels;
 
+	/**
+	 * on SOCs like APQ8016 the channel control bits start
+	 * at different offset to ipq806x
+	 **/
+	u32	rdmactl_audif_start;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-- 
1.9.1
