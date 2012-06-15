From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcpdm: Convert to use devm_*
Date: Fri, 15 Jun 2012 11:55:00 +0300
Message-ID: <1339750500-16517-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog102.obsmtp.com (na3sys009aog102.obsmtp.com
	[74.125.149.69]) by alsa0.perex.cz (Postfix) with ESMTP id F3CF124656
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jun 2012 10:54:48 +0200 (CEST)
Received: by lban1 with SMTP id n1so2480402lba.38
	for <alsa-devel@alsa-project.org>; Fri, 15 Jun 2012 01:54:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Switch to use devm_* te make the probe/remove code more cleaner.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |   52 ++++++++++--------------------------------
 1 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 59d47ab..b5e23af 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -445,9 +445,8 @@ static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
 {
 	struct omap_mcpdm *mcpdm;
 	struct resource *res;
-	int ret = 0;
 
-	mcpdm = kzalloc(sizeof(struct omap_mcpdm), GFP_KERNEL);
+	mcpdm = devm_kzalloc(&pdev->dev, sizeof(struct omap_mcpdm), GFP_KERNEL);
 	if (!mcpdm)
 		return -ENOMEM;
 
@@ -456,55 +455,30 @@ static __devinit int asoc_mcpdm_probe(struct platform_device *pdev)
 	mutex_init(&mcpdm->mutex);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "no resource\n");
-		goto err_res;
-	}
+	if (res == NULL)
+		return -ENOMEM;
 
-	if (!request_mem_region(res->start, resource_size(res), "McPDM")) {
-		ret = -EBUSY;
-		goto err_res;
-	}
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     resource_size(res), "McPDM"))
+		return -EBUSY;
 
-	mcpdm->io_base = ioremap(res->start, resource_size(res));
-	if (!mcpdm->io_base) {
-		ret = -ENOMEM;
-		goto err_iomap;
-	}
+	mcpdm->io_base = devm_ioremap(&pdev->dev, res->start,
+				      resource_size(res));
+	if (!mcpdm->io_base)
+		return -ENOMEM;
 
 	mcpdm->irq = platform_get_irq(pdev, 0);
-	if (mcpdm->irq < 0) {
-		ret = mcpdm->irq;
-		goto err_irq;
-	}
+	if (mcpdm->irq < 0)
+		return mcpdm->irq;
 
 	mcpdm->dev = &pdev->dev;
 
-	ret = snd_soc_register_dai(&pdev->dev, &omap_mcpdm_dai);
-	if (!ret)
-		return 0;
-
-err_irq:
-	iounmap(mcpdm->io_base);
-err_iomap:
-	release_mem_region(res->start, resource_size(res));
-err_res:
-	kfree(mcpdm);
-	return ret;
+	return snd_soc_register_dai(&pdev->dev, &omap_mcpdm_dai);
 }
 
 static int __devexit asoc_mcpdm_remove(struct platform_device *pdev)
 {
-	struct omap_mcpdm *mcpdm = platform_get_drvdata(pdev);
-	struct resource *res;
-
 	snd_soc_unregister_dai(&pdev->dev);
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	iounmap(mcpdm->io_base);
-	release_mem_region(res->start, resource_size(res));
-
-	kfree(mcpdm);
 	return 0;
 }
 
-- 
1.7.8.6
