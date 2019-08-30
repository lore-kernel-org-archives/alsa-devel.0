From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: fsl_sai: Fix noise when using EDMA
Date: Fri, 30 Aug 2019 23:09:00 +0300
Message-ID: <20190830200900.19668-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, shengjiu.wang@nxp.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, timur@kernel.org, mihai.serban@gmail.com, Mihai Serban <mihai.serban@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

From: Mihai Serban <mihai.serban@nxp.com>

EDMA requires the period size to be multiple of maxburst. Otherwise the
remaining bytes are not transferred and thus noise is produced.

We can handle this issue by adding a constraint on
SNDRV_PCM_HW_PARAM_PERIOD_SIZE to be multiple of tx/rx maxburst value.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 15 +++++++++++++++
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 728307acab90..fe126029f4e3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -612,6 +612,16 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
 			   FSL_SAI_CR3_TRCE_MASK,
 			   FSL_SAI_CR3_TRCE);
 
+	/*
+	 * some DMA controllers need period size to be a multiple of
+	 * tx/rx maxburst
+	 */
+	if (sai->soc_data->use_constraint_period_size)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					   tx ? sai->dma_params_tx.maxburst :
+					   sai->dma_params_rx.maxburst);
+
 	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
 			SNDRV_PCM_HW_PARAM_RATE, &fsl_sai_rate_constraints);
 
@@ -1011,30 +1021,35 @@ static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.use_imx_pcm = false,
 	.fifo_depth = 32,
 	.reg_offset = 0,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 32,
 	.reg_offset = 0,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx7ulp_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 16,
 	.reg_offset = 8,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8mq_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 128,
 	.reg_offset = 8,
+	.use_constraint_period_size = false,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
 	.use_imx_pcm = true,
 	.fifo_depth = 64,
 	.reg_offset = 0,
+	.use_constraint_period_size = true,
 };
 
 static const struct of_device_id fsl_sai_ids[] = {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index b89b0ca26053..3a3f6f8e5595 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -157,6 +157,7 @@
 
 struct fsl_sai_soc_data {
 	bool use_imx_pcm;
+	bool use_constraint_period_size;
 	unsigned int fifo_depth;
 	unsigned int reg_offset;
 };
-- 
2.17.1
