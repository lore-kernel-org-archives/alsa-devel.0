From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/5] ASoC: au1x: Convert to
	devm_snd_soc_register_platform
Date: Thu, 27 Aug 2015 09:09:29 +0800
Message-ID: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
 [209.85.220.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 93FBE26591F
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 03:09:34 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so5557643pac.2
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 18:09:32 -0700 (PDT)
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
Cc: Manuel Lauss <manuel.lauss@gmail.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/au1x/dbdma2.c | 11 ++---------
 sound/soc/au1x/dma.c    | 11 ++---------
 2 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index dd94fea..5741c0a 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -344,14 +344,8 @@ static int au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmadata);
 
-	return snd_soc_register_platform(&pdev->dev, &au1xpsc_soc_platform);
-}
-
-static int au1xpsc_pcm_drvremove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &au1xpsc_soc_platform);
 }
 
 static struct platform_driver au1xpsc_pcm_driver = {
@@ -359,7 +353,6 @@ static struct platform_driver au1xpsc_pcm_driver = {
 		.name	= "au1xpsc-pcm",
 	},
 	.probe		= au1xpsc_pcm_drvprobe,
-	.remove		= au1xpsc_pcm_drvremove,
 };
 
 module_platform_driver(au1xpsc_pcm_driver);
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 24cc7f4..fcf5a9ad 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -312,14 +312,8 @@ static int alchemy_pcm_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	return snd_soc_register_platform(&pdev->dev, &alchemy_pcm_soc_platform);
-}
-
-static int alchemy_pcm_drvremove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &alchemy_pcm_soc_platform);
 }
 
 static struct platform_driver alchemy_pcmdma_driver = {
@@ -327,7 +321,6 @@ static struct platform_driver alchemy_pcmdma_driver = {
 		.name	= "alchemy-pcm-dma",
 	},
 	.probe		= alchemy_pcm_drvprobe,
-	.remove		= alchemy_pcm_drvremove,
 };
 
 module_platform_driver(alchemy_pcmdma_driver);
-- 
2.1.0
