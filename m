From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH RFC 02/15] ASoC: qcom: add wrdma register details to lpass_variant
Date: Mon,  1 Feb 2016 17:28:20 +0000
Message-ID: <1454347700-10404-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454347622-9970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds wrdma related register offsets and shifts into lpass
variant structure.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/lpass.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 0b63e2e..ab684a8 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -71,6 +71,9 @@ struct lpass_variant {
 	u32	rdma_reg_base;
 	u32	rdma_reg_stride;
 	u32	rdma_channels;
+	u32	wrdma_reg_base;
+	u32	wrdma_reg_stride;
+	u32	wrdma_channels;
 
 	/**
 	 * on SOCs like APQ8016 the channel control bits start
-- 
1.9.1
