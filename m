From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 07/14] ASoC: qcom: ipq806x: add wrdma related register offsets
Date: Thu, 11 Feb 2016 12:17:57 +0000
Message-ID: <1455193077-1788-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch adds wrdma related register offsets to the lpass variant data
of ipq806x.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/lpass-ipq806x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/lpass-ipq806x.c b/sound/soc/qcom/lpass-ipq806x.c
index 29a3529..608c1a9 100644
--- a/sound/soc/qcom/lpass-ipq806x.c
+++ b/sound/soc/qcom/lpass-ipq806x.c
@@ -86,6 +86,10 @@ static struct lpass_variant ipq806x_data = {
 	.rdma_reg_base		= 0x6000,
 	.rdma_reg_stride	= 0x1000,
 	.rdma_channels		= 4,
+	.wrdma_reg_base		= 0xB000,
+	.wrdma_reg_stride	= 0x1000,
+	.wrdma_channel_start	= 5,
+	.wrdma_channels		= 4,
 	.dai_driver		= &ipq806x_lpass_cpu_dai_driver,
 	.num_dai		= 1,
 	.alloc_dma_channel	= ipq806x_lpass_alloc_dma_channel,
-- 
1.9.1
