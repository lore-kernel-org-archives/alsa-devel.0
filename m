From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_ssi: Fix the order of resources
	removal
Date: Sat, 17 Aug 2013 18:13:00 -0300
Message-ID: <1376773980-16240-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gh0-f169.google.com (mail-gh0-f169.google.com
 [209.85.160.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C6FD2610CB
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 23:13:19 +0200 (CEST)
Received: by mail-gh0-f169.google.com with SMTP id r1so604249ghr.28
 for <alsa-devel@alsa-project.org>; Sat, 17 Aug 2013 14:13:18 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In fsl_ssi_remove() we need to remove the resources in the opposite order that
they were acquired in probe.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0c072ff..c8aee4e 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -928,14 +928,14 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 
 	if (!ssi_private->new_binding)
 		platform_device_unregister(ssi_private->pdev);
-	if (ssi_private->ssi_on_imx) {
+	if (ssi_private->ssi_on_imx)
 		imx_pcm_dma_exit(pdev);
-		clk_disable_unprepare(ssi_private->clk);
-	}
 	snd_soc_unregister_component(&pdev->dev);
-	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
-	irq_dispose_mapping(ssi_private->irq);
 	dev_set_drvdata(&pdev->dev, NULL);
+	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
+	if (ssi_private->ssi_on_imx)
+		clk_disable_unprepare(ssi_private->clk);
+	irq_dispose_mapping(ssi_private->irq);
 
 	return 0;
 }
-- 
1.8.1.2
