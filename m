From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 4/5] ASoC: pxa: Convert to
	devm_snd_soc_register_platform
Date: Thu, 27 Aug 2015 09:13:46 +0800
Message-ID: <1440638026.18698.6.camel@ingics.com>
References: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id BA6712658EB
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 03:13:52 +0200 (CEST)
Received: by pacgr6 with SMTP id gr6so5649460pac.3
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 18:13:51 -0700 (PDT)
In-Reply-To: <1440637769.18698.1.camel@ingics.com>
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
Cc: alsa-devel@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/pxa/mmp-pcm.c    | 9 +--------
 sound/soc/pxa/pxa2xx-pcm.c | 9 +--------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/soc/pxa/mmp-pcm.c b/sound/soc/pxa/mmp-pcm.c
index 1eb45dc..51e790d 100644
--- a/sound/soc/pxa/mmp-pcm.c
+++ b/sound/soc/pxa/mmp-pcm.c
@@ -232,13 +232,7 @@ static int mmp_pcm_probe(struct platform_device *pdev)
 		mmp_pcm_hardware[SNDRV_PCM_STREAM_CAPTURE].period_bytes_max =
 						pdata->period_max_capture;
 	}
-	return snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
-}
-
-static int mmp_pcm_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &mmp_soc_platform);
 }
 
 static struct platform_driver mmp_pcm_driver = {
@@ -247,7 +241,6 @@ static struct platform_driver mmp_pcm_driver = {
 	},
 
 	.probe = mmp_pcm_probe,
-	.remove = mmp_pcm_remove,
 };
 
 module_platform_driver(mmp_pcm_driver);
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index a51c9da..831ee37 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -124,13 +124,7 @@ static struct snd_soc_platform_driver pxa2xx_soc_platform = {
 
 static int pxa2xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
-}
-
-static int pxa2xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev, &pxa2xx_soc_platform);
 }
 
 #ifdef CONFIG_OF
@@ -147,7 +141,6 @@ static struct platform_driver pxa_pcm_driver = {
 	},
 
 	.probe = pxa2xx_soc_platform_probe,
-	.remove = pxa2xx_soc_platform_remove,
 };
 
 module_platform_driver(pxa_pcm_driver);
-- 
2.1.0
