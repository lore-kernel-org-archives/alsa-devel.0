From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v1 02/14] ASoC: qcom: add wrdma register details to lpass_variant
Date: Wed, 10 Feb 2016 10:18:24 +0000
Message-ID: <1455099504-403-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455099418-311-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds wrdma related register offsets, wrdma channel start
and shifts into lpass variant structure.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/lpass.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 0b63e2e..024a771 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -71,12 +71,16 @@ struct lpass_variant {
 	u32	rdma_reg_base;
 	u32	rdma_reg_stride;
 	u32	rdma_channels;
+	u32	wrdma_reg_base;
+	u32	wrdma_reg_stride;
+	u32	wrdma_channels;
 
 	/**
 	 * on SOCs like APQ8016 the channel control bits start
 	 * at different offset to ipq806x
 	 **/
 	u32	rdmactl_audif_start;
+	u32	wrdma_channel_start;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-- 
1.9.1
