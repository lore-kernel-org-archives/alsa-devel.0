From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 03/14] ASoC: qcom: rename rdmactl_audif_start to dmactrl_audif_start
Date: Thu, 11 Feb 2016 12:17:30 +0000
Message-ID: <1455193050-1620-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455193007-1481-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, kwestfie@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patch renames rdmactl_audif_start to dmactrl_audif_start as this
is common for both rdma and wrdma. Without this patch the name would be
bit misleading to the readers.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Kenneth Westfield <kwestfie@codeaurora.org>
---
 sound/soc/qcom/lpass-apq8016.c  | 2 +-
 sound/soc/qcom/lpass-platform.c | 4 ++--
 sound/soc/qcom/lpass.h          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/lpass-apq8016.c b/sound/soc/qcom/lpass-apq8016.c
index 94efc01..6cc7e72 100644
--- a/sound/soc/qcom/lpass-apq8016.c
+++ b/sound/soc/qcom/lpass-apq8016.c
@@ -212,7 +212,7 @@ static struct lpass_variant apq8016_data = {
 	.rdma_reg_base		= 0x8400,
 	.rdma_reg_stride	= 0x1000,
 	.rdma_channels		= 2,
-	.rdmactl_audif_start	= 1,
+	.dmactl_audif_start	= 1,
 	.dai_driver		= apq8016_lpass_cpu_dai_driver,
 	.num_dai		= ARRAY_SIZE(apq8016_lpass_cpu_dai_driver),
 	.init			= apq8016_lpass_init,
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index ec2414d..7245c2e 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -91,7 +91,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	unsigned int channels = params_channels(params);
 	unsigned int regval;
 	int bitwidth;
-	int ret, rdma_port = pcm_data->i2s_port + v->rdmactl_audif_start;
+	int ret, dma_port = pcm_data->i2s_port + v->dmactl_audif_start;
 
 	bitwidth = snd_pcm_format_width(format);
 	if (bitwidth < 0) {
@@ -101,7 +101,7 @@ static int lpass_platform_pcmops_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	regval = LPAIF_RDMACTL_BURSTEN_INCR4 |
-			LPAIF_RDMACTL_AUDINTF(rdma_port) |
+			LPAIF_RDMACTL_AUDINTF(dma_port) |
 			LPAIF_RDMACTL_FIFOWM_8;
 
 	switch (bitwidth) {
diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
index 024a771..412399a 100644
--- a/sound/soc/qcom/lpass.h
+++ b/sound/soc/qcom/lpass.h
@@ -79,7 +79,7 @@ struct lpass_variant {
 	 * on SOCs like APQ8016 the channel control bits start
 	 * at different offset to ipq806x
 	 **/
-	u32	rdmactl_audif_start;
+	u32	dmactl_audif_start;
 	u32	wrdma_channel_start;
 	/* SOC specific intialization like clocks */
 	int (*init)(struct platform_device *pdev);
-- 
1.9.1
