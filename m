From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 1/3] ASoC: fsl_ssi: Remove unnecessary
	dev_set_drvdata()
Date: Mon, 26 Aug 2013 09:25:13 -0300
Message-ID: <1377519915-23998-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 by alsa0.perex.cz (Postfix) with ESMTP id CE072261ABF
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 14:27:40 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Driver core clears the driver data to NULL after device_release or on probe
failure, so just remove it from here.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 0c072ff..6f4a4c5 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -909,7 +909,6 @@ error_dai:
 	snd_soc_unregister_component(&pdev->dev);
 
 error_dev:
-	dev_set_drvdata(&pdev->dev, NULL);
 	device_remove_file(&pdev->dev, dev_attr);
 
 error_clk:
@@ -935,7 +934,6 @@ static int fsl_ssi_remove(struct platform_device *pdev)
 	snd_soc_unregister_component(&pdev->dev);
 	device_remove_file(&pdev->dev, &ssi_private->dev_attr);
 	irq_dispose_mapping(ssi_private->irq);
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
-- 
1.8.1.2
