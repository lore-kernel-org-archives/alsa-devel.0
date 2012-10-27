From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/3] ASoC: jz4740-codec: Use
	devm_request_and_ioremap
Date: Sat, 27 Oct 2012 17:15:07 +0200
Message-ID: <1351350908-4262-2-git-send-email-lars@metafoo.de>
References: <1351350908-4262-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-149.synserver.de (smtp-out-149.synserver.de
 [212.40.185.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C4C265205
 for <alsa-devel@alsa-project.org>; Sat, 27 Oct 2012 17:14:48 +0200 (CEST)
In-Reply-To: <1351350908-4262-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use devm_request_and_ioremap for requesting and mapping the IO region. This
makes the code a bit smaller and simpler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/jz4740.c |   41 ++++-------------------------------------
 1 files changed, 4 insertions(+), 37 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index 51b4f99..1661202 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -74,7 +74,6 @@ static const uint32_t jz4740_codec_regs[] = {
 
 struct jz4740_codec {
 	void __iomem *base;
-	struct resource *mem;
 };
 
 static unsigned int jz4740_codec_read(struct snd_soc_codec *codec,
@@ -371,56 +370,24 @@ static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mem) {
-		dev_err(&pdev->dev, "Failed to get mmio memory resource\n");
-		ret = -ENOENT;
-		goto err_out;
-	}
-
-	mem = request_mem_region(mem->start, resource_size(mem), pdev->name);
-	if (!mem) {
-		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
-		ret = -EBUSY;
-		goto err_out;
-	}
-
-	jz4740_codec->base = ioremap(mem->start, resource_size(mem));
-	if (!jz4740_codec->base) {
-		dev_err(&pdev->dev, "Failed to ioremap mmio memory\n");
-		ret = -EBUSY;
-		goto err_release_mem_region;
-	}
-	jz4740_codec->mem = mem;
+	jz4740_codec->base = devm_request_and_ioremap(&pdev->dev, mem);
+	if (!jz4740_codec->base)
+		return -EBUSY;
 
 	platform_set_drvdata(pdev, jz4740_codec);
 
 	ret = snd_soc_register_codec(&pdev->dev,
 			&soc_codec_dev_jz4740_codec, &jz4740_codec_dai, 1);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Failed to register codec\n");
-		goto err_iounmap;
-	}
-
-	return 0;
 
-err_iounmap:
-	iounmap(jz4740_codec->base);
-err_release_mem_region:
-	release_mem_region(mem->start, resource_size(mem));
-err_out:
 	return ret;
 }
 
 static int __devexit jz4740_codec_remove(struct platform_device *pdev)
 {
-	struct jz4740_codec *jz4740_codec = platform_get_drvdata(pdev);
-	struct resource *mem = jz4740_codec->mem;
-
 	snd_soc_unregister_codec(&pdev->dev);
 
-	iounmap(jz4740_codec->base);
-	release_mem_region(mem->start, resource_size(mem));
-
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
-- 
1.7.2.5
