From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: sh: dma-sh7760: Convert to
 devm_snd_soc_register_platform
Date: Sun, 30 Aug 2015 11:07:33 +0800
Message-ID: <1440904053.32046.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C451260703
 for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2015 05:07:41 +0200 (CEST)
Received: by pacdd16 with SMTP id dd16so101772267pac.2
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2015 20:07:40 -0700 (PDT)
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
 sound/soc/sh/dma-sh7760.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index fd11404..8fad444 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -327,13 +327,7 @@ static struct snd_soc_platform_driver sh7760_soc_platform = {
 
 static int sh7760_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
-}
-
-static int sh7760_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &sh7760_soc_platform);
 }
 
 static struct platform_driver sh7760_pcm_driver = {
@@ -342,7 +336,6 @@ static struct platform_driver sh7760_pcm_driver = {
 	},
 
 	.probe = sh7760_soc_platform_probe,
-	.remove = sh7760_soc_platform_remove,
 };
 
 module_platform_driver(sh7760_pcm_driver);
-- 
2.1.0
