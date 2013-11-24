From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] ASoC: fsl: Use
	devm_snd_dmaengine_pcm_register()
Date: Sun, 24 Nov 2013 14:21:00 +0100
Message-ID: <1385299262-24304-4-git-send-email-lars@metafoo.de>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-164.synserver.de (smtp-out-220.synserver.de
 [212.40.185.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 80D3226167D
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:20:39 +0100 (CET)
In-Reply-To: <1385299262-24304-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Makes the code shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/fsl_spdif.c   | 8 --------
 sound/soc/fsl/fsl_ssi.c     | 4 ----
 sound/soc/fsl/imx-pcm-dma.c | 9 ++-------
 sound/soc/fsl/imx-pcm.h     | 5 -----
 sound/soc/fsl/imx-ssi.c     | 3 ---
 5 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 55193a5..4d075f1 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1181,13 +1181,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int fsl_spdif_remove(struct platform_device *pdev)
-{
-	imx_pcm_dma_exit(pdev);
-
-	return 0;
-}
-
 static const struct of_device_id fsl_spdif_dt_ids[] = {
 	{ .compatible = "fsl,imx35-spdif", },
 	{}
@@ -1201,7 +1194,6 @@ static struct platform_driver fsl_spdif_driver = {
 		.of_match_table = fsl_spdif_dt_ids,
 	},
 	.probe = fsl_spdif_probe,
-	.remove = fsl_spdif_remove,
 };
 
 module_platform_driver(fsl_spdif_driver);
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fb8f52a..3df0318 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1109,8 +1109,6 @@ done:
 	return 0;
 
 error_dai:
-	if (ssi_private->ssi_on_imx)
-		imx_pcm_dma_exit(pdev);
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
@@ -1132,8 +1130,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 	if (!ssi_private->new_binding)
 		platform_device_unregister(ssi_private->pdev);
-	if (ssi_private->ssi_on_imx)
-		imx_pcm_dma_exit(pdev);
 	snd_soc_unregister_component(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 	if (ssi_private->ssi_on_imx)
diff --git a/sound/soc/fsl/imx-pcm-dma.c b/sound/soc/fsl/imx-pcm-dma.c
index aee2307..c5e47f8 100644
--- a/sound/soc/fsl/imx-pcm-dma.c
+++ b/sound/soc/fsl/imx-pcm-dma.c
@@ -61,16 +61,11 @@ static const struct snd_dmaengine_pcm_config imx_dmaengine_pcm_config = {
 
 int imx_pcm_dma_init(struct platform_device *pdev)
 {
-	return snd_dmaengine_pcm_register(&pdev->dev, &imx_dmaengine_pcm_config,
+	return devm_snd_dmaengine_pcm_register(&pdev->dev,
+		&imx_dmaengine_pcm_config,
 		SND_DMAENGINE_PCM_FLAG_NO_RESIDUE |
 		SND_DMAENGINE_PCM_FLAG_COMPAT);
 }
 EXPORT_SYMBOL_GPL(imx_pcm_dma_init);
 
-void imx_pcm_dma_exit(struct platform_device *pdev)
-{
-	snd_dmaengine_pcm_unregister(&pdev->dev);
-}
-EXPORT_SYMBOL_GPL(imx_pcm_dma_exit);
-
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/imx-pcm.h b/sound/soc/fsl/imx-pcm.h
index 5d5b733..c79cb27 100644
--- a/sound/soc/fsl/imx-pcm.h
+++ b/sound/soc/fsl/imx-pcm.h
@@ -40,16 +40,11 @@ struct imx_pcm_fiq_params {
 
 #if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_DMA)
 int imx_pcm_dma_init(struct platform_device *pdev);
-void imx_pcm_dma_exit(struct platform_device *pdev);
 #else
 static inline int imx_pcm_dma_init(struct platform_device *pdev)
 {
 	return -ENODEV;
 }
-
-static inline void imx_pcm_dma_exit(struct platform_device *pdev)
-{
-}
 #endif
 
 #if IS_ENABLED(CONFIG_SND_SOC_IMX_PCM_FIQ)
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index f5f248c..cc7376f 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -624,9 +624,6 @@ static int imx_ssi_remove(struct platform_device *pdev)
 {
 	struct imx_ssi *ssi = platform_get_drvdata(pdev);
 
-	if (!ssi->dma_init)
-		imx_pcm_dma_exit(pdev);
-
 	if (!ssi->fiq_init)
 		imx_pcm_fiq_exit(pdev);
 
-- 
1.8.0
