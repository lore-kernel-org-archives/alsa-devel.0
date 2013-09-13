From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] ASoC: fsl_ssi: Remove redundant
	dev_set_drvdata
Date: Fri, 13 Sep 2013 15:59:25 +0530
Message-ID: <1379068165-8397-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
 [209.85.192.173])
 by alsa0.perex.cz (Postfix) with ESMTP id E45162608ED
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 12:47:34 +0200 (CEST)
Received: by mail-pd0-f173.google.com with SMTP id p10so1092346pdj.4
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 03:47:34 -0700 (PDT)
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

Driver core sets the driver data to NULL on detach.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 4973be7..6ac8730 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1135,7 +1135,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	if (ssi_private->ssi_on_imx)
 		imx_pcm_dma_exit(pdev);
 	snd_soc_unregister_component(&pdev->dev);
-	dev_set_drvdata(&pdev->dev, NULL);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 	if (ssi_private->ssi_on_imx)
 		clk_disable_unprepare(ssi_private->clk);
-- 
1.7.9.5
