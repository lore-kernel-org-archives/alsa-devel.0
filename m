From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 07/10] ASoC: Convert jz4740 to devm_kzalloc()
Date: Mon, 26 Dec 2011 20:55:01 +0800
Message-ID: <1324904101.26543.8.camel@phoenix>
References: <1324903728.26543.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AC5621038B8
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 13:55:07 +0100 (CET)
Received: by iaae16 with SMTP id e16so18099938iaa.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 04:55:07 -0800 (PST)
In-Reply-To: <1324903728.26543.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/jz4740.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index d73d283..4624e75 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -353,7 +353,8 @@ static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 	struct jz4740_codec *jz4740_codec;
 	struct resource *mem;
 
-	jz4740_codec = kzalloc(sizeof(*jz4740_codec), GFP_KERNEL);
+	jz4740_codec = devm_kzalloc(&pdev->dev, sizeof(*jz4740_codec),
+				    GFP_KERNEL);
 	if (!jz4740_codec)
 		return -ENOMEM;
 
@@ -361,14 +362,14 @@ static int __devinit jz4740_codec_probe(struct platform_device *pdev)
 	if (!mem) {
 		dev_err(&pdev->dev, "Failed to get mmio memory resource\n");
 		ret = -ENOENT;
-		goto err_free_codec;
+		goto err_out;
 	}
 
 	mem = request_mem_region(mem->start, resource_size(mem), pdev->name);
 	if (!mem) {
 		dev_err(&pdev->dev, "Failed to request mmio memory region\n");
 		ret = -EBUSY;
-		goto err_free_codec;
+		goto err_out;
 	}
 
 	jz4740_codec->base = ioremap(mem->start, resource_size(mem));
@@ -394,9 +395,7 @@ err_iounmap:
 	iounmap(jz4740_codec->base);
 err_release_mem_region:
 	release_mem_region(mem->start, resource_size(mem));
-err_free_codec:
-	kfree(jz4740_codec);
-
+err_out:
 	return ret;
 }
 
@@ -411,7 +410,6 @@ static int __devexit jz4740_codec_remove(struct platform_device *pdev)
 	release_mem_region(mem->start, resource_size(mem));
 
 	platform_set_drvdata(pdev, NULL);
-	kfree(jz4740_codec);
 
 	return 0;
 }
-- 
1.7.5.4
