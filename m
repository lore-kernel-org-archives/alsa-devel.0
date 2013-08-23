From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] ASoC: fsl_spdif: Remove unnecessary
	dev_set_drvdata()
Date: Fri, 23 Aug 2013 18:14:45 -0300
Message-ID: <1377292486-7591-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f169.google.com (mail-ye0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id C3AC42615AE
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 23:14:55 +0200 (CEST)
Received: by mail-ye0-f169.google.com with SMTP id r5so295550yen.0
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 14:14:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Driver core clears the driver data to NULL after device_release or on probe 
failure, so just remove it from here.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Also remove dev_set_drvdata from the remove function

 sound/soc/fsl/fsl_spdif.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 42a4382..a8ef46a 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1184,7 +1184,7 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 					 &spdif_priv->cpu_dai_drv, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
-		goto error_dev;
+		return ret;
 	}
 
 	ret = imx_pcm_dma_init(pdev);
@@ -1197,8 +1197,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 error_component:
 	snd_soc_unregister_component(&pdev->dev);
-error_dev:
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return ret;
 }
@@ -1207,7 +1205,6 @@ static int fsl_spdif_remove(struct platform_device *pdev)
 {
 	imx_pcm_dma_exit(pdev);
 	snd_soc_unregister_component(&pdev->dev);
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
-- 
1.8.1.2
