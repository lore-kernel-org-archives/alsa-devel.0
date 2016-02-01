From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 08/15] ASoC: qcom: add wrdma dma channel start
Date: Mon,  1 Feb 2016 17:29:01 +0000
Message-ID: <1454347741-10696-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

wrdma channel numbering starts at 5 on APQ8016 and is different on other chips.

This patch adds wrdma_channel_start map to variant structure for dma channel
allocations.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 30449f3..8475b60 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -80,6 +80,7 @@ struct lpass_variant {
 	 * at different offset to ipq806x
 	 **/
 	u32	dmactl_audif_start;
+	u32	wrdma_channel_start;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
 	int (*exit)(struct platform_device *pdev);
-- 
1.9.1
