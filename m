From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 02/10] ASoC: fsl_sai: derive TX FIFO watermark from FIFO depth
Date: Mon, 22 Jul 2019 15:48:25 +0300
Message-ID: <20190722124833.28757-3-daniel.baluta@nxp.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722124833.28757-1-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: festevam@gmail.com, perex@perex.cz, tiwai@suse.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, timur@kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shengjiu.wang@nxp.com, angus@akkea.ca, kernel@pengutronix.de, l.stach@pengutronix.de, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

From: Lucas Stach <l.stach@pengutronix.de>

The DMA request schould be triggered as soon as the FIFO has space
for another burst. As different versions of the SAI block have
different FIFO sizes, the watrmark level needs to be derived from
version specific data.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 sound/soc/fsl/fsl_sai.c | 4 +++-
 sound/soc/fsl/fsl_sai.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index ed0432e7327a..1d1a447163e3 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -640,7 +640,7 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1, FSL_SAI_CR1_RFW_MASK,
-			   FSL_SAI_MAXBURST_TX * 2);
+			   sai->soc_data->fifo_depth - FSL_SAI_MAXBURST_TX);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR1, FSL_SAI_CR1_RFW_MASK,
 			   FSL_SAI_MAXBURST_RX - 1);
 
@@ -913,10 +913,12 @@ static int fsl_sai_remove(struct platform_device *pdev)
 
 static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
 	.use_imx_pcm = false,
+	.fifo_depth = 32,
 };
 
 static const struct fsl_sai_soc_data fsl_sai_imx6sx_data = {
 	.use_imx_pcm = true,
+	.fifo_depth = 32,
 };
 
 static const struct of_device_id fsl_sai_ids[] = {
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 83e2bfe05b1b..7c1ef671da28 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -128,6 +128,7 @@
 
 struct fsl_sai_soc_data {
 	bool use_imx_pcm;
+	unsigned int fifo_depth;
 };
 
 struct fsl_sai {
-- 
2.17.1
