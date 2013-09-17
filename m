From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: fsl_spdif: Use
	devm_snd_soc_register_component
Date: Tue, 17 Sep 2013 10:13:49 +0530
Message-ID: <1379393029-11711-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f52.google.com (mail-pb0-f52.google.com
 [209.85.160.52])
 by alsa0.perex.cz (Postfix) with ESMTP id CC1B32650B4
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 07:02:07 +0200 (CEST)
Received: by mail-pb0-f52.google.com with SMTP id wz12so4976259pbc.39
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 22:02:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: sachin.kamat@linaro.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

devm_snd_soc_register_component makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c |   14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 3920c3e..44378e6 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1172,23 +1172,16 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	/* Register with ASoC */
 	dev_set_drvdata(&pdev->dev, spdif_priv);
 
-	ret = snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
-					 &spdif_priv->cpu_dai_drv, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &fsl_spdif_component,
+					      &spdif_priv->cpu_dai_drv, 1);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register DAI: %d\n", ret);
 		return ret;
 	}
 
 	ret = imx_pcm_dma_init(pdev);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "imx_pcm_dma_init failed: %d\n", ret);
-		goto error_component;
-	}
-
-	return ret;
-
-error_component:
-	snd_soc_unregister_component(&pdev->dev);
 
 	return ret;
 }
@@ -1196,7 +1189,6 @@ error_component:
 static int fsl_spdif_remove(struct platform_device *pdev)
 {
 	imx_pcm_dma_exit(pdev);
-	snd_soc_unregister_component(&pdev->dev);
 
 	return 0;
 }
-- 
1.7.9.5
