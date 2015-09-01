From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: sh: siu_dai: Convert to use resource
	managed APIs
Date: Tue, 01 Sep 2015 21:11:10 +0800
Message-ID: <1441113070.29223.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 7513A260599
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 15:11:17 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so176799525pab.1
 for <alsa-devel@alsa-project.org>; Tue, 01 Sep 2015 06:11:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/sh/siu_dai.c | 85 ++++++++++++++------------------------------------
 1 file changed, 24 insertions(+), 61 deletions(-)

diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index abb0d95..76b2ab8 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -738,7 +738,7 @@ static int siu_probe(struct platform_device *pdev)
 	struct siu_info *info;
 	int ret;
 
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = devm_kmalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 	siu_i2s_data = info;
@@ -746,7 +746,7 @@ static int siu_probe(struct platform_device *pdev)
 
 	ret = request_firmware(&fw_entry, "siu_spb.bin", &pdev->dev);
 	if (ret)
-		goto ereqfw;
+		return ret;
 
 	/*
 	 * Loaded firmware is "const" - read only, but we have to modify it in
@@ -757,89 +757,52 @@ static int siu_probe(struct platform_device *pdev)
 	release_firmware(fw_entry);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		ret = -ENODEV;
-		goto egetres;
-	}
+	if (!res)
+		return -ENODEV;
 
-	region = request_mem_region(res->start, resource_size(res),
-				    pdev->name);
+	region = devm_request_mem_region(&pdev->dev, res->start,
+					 resource_size(res), pdev->name);
 	if (!region) {
 		dev_err(&pdev->dev, "SIU region already claimed\n");
-		ret = -EBUSY;
-		goto ereqmemreg;
+		return -EBUSY;
 	}
 
-	ret = -ENOMEM;
-	info->pram = ioremap(res->start, PRAM_SIZE);
+	info->pram = devm_ioremap(&pdev->dev, res->start, PRAM_SIZE);
 	if (!info->pram)
-		goto emappram;
-	info->xram = ioremap(res->start + XRAM_OFFSET, XRAM_SIZE);
+		return -ENOMEM;
+	info->xram = devm_ioremap(&pdev->dev, res->start + XRAM_OFFSET,
+				  XRAM_SIZE);
 	if (!info->xram)
-		goto emapxram;
-	info->yram = ioremap(res->start + YRAM_OFFSET, YRAM_SIZE);
+		return -ENOMEM;
+	info->yram = devm_ioremap(&pdev->dev, res->start + YRAM_OFFSET,
+				  YRAM_SIZE);
 	if (!info->yram)
-		goto emapyram;
-	info->reg = ioremap(res->start + REG_OFFSET, resource_size(res) -
-			    REG_OFFSET);
+		return -ENOMEM;
+	info->reg = devm_ioremap(&pdev->dev, res->start + REG_OFFSET,
+			    resource_size(res) - REG_OFFSET);
 	if (!info->reg)
-		goto emapreg;
+		return -ENOMEM;
 
 	dev_set_drvdata(&pdev->dev, info);
 
 	/* register using ARRAY version so we can keep dai name */
-	ret = snd_soc_register_component(&pdev->dev, &siu_i2s_component,
-					 &siu_i2s_dai, 1);
+	ret = devm_snd_soc_register_component(&pdev->dev, &siu_i2s_component,
+					      &siu_i2s_dai, 1);
 	if (ret < 0)
-		goto edaiinit;
+		return ret;
 
-	ret = snd_soc_register_platform(&pdev->dev, &siu_platform);
+	ret = devm_snd_soc_register_platform(&pdev->dev, &siu_platform);
 	if (ret < 0)
-		goto esocregp;
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 
-	return ret;
-
-esocregp:
-	snd_soc_unregister_component(&pdev->dev);
-edaiinit:
-	iounmap(info->reg);
-emapreg:
-	iounmap(info->yram);
-emapyram:
-	iounmap(info->xram);
-emapxram:
-	iounmap(info->pram);
-emappram:
-	release_mem_region(res->start, resource_size(res));
-ereqmemreg:
-egetres:
-ereqfw:
-	kfree(info);
-
-	return ret;
+	return 0;
 }
 
 static int siu_remove(struct platform_device *pdev)
 {
-	struct siu_info *info = dev_get_drvdata(&pdev->dev);
-	struct resource *res;
-
 	pm_runtime_disable(&pdev->dev);
-
-	snd_soc_unregister_platform(&pdev->dev);
-	snd_soc_unregister_component(&pdev->dev);
-
-	iounmap(info->reg);
-	iounmap(info->yram);
-	iounmap(info->xram);
-	iounmap(info->pram);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res)
-		release_mem_region(res->start, resource_size(res));
-	kfree(info);
-
 	return 0;
 }
 
-- 
2.1.0
