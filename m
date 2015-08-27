From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/5] ASoC: blackfin: Convert to
 devm_snd_soc_register_platform
Date: Thu, 27 Aug 2015 09:11:13 +0800
Message-ID: <1440637873.18698.3.camel@ingics.com>
References: <1440637769.18698.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
 [209.85.220.44])
 by alsa0.perex.cz (Postfix) with ESMTP id A35AE26591F
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 03:11:20 +0200 (CEST)
Received: by pabzx8 with SMTP id zx8so5661382pab.1
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 18:11:19 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, adi-buildroot-devel@lists.sourceforge.net, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c | 10 ++--------
 sound/soc/blackfin/bf5xx-i2s-pcm.c  | 10 ++--------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 238913e..02ad260 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -450,13 +450,8 @@ static struct snd_soc_platform_driver bf5xx_ac97_soc_platform = {
 
 static int bf5xx_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &bf5xx_ac97_soc_platform);
-}
-
-static int bf5xx_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &bf5xx_ac97_soc_platform);
 }
 
 static struct platform_driver bf5xx_pcm_driver = {
@@ -465,7 +460,6 @@ static struct platform_driver bf5xx_pcm_driver = {
 	},
 
 	.probe = bf5xx_soc_platform_probe,
-	.remove = bf5xx_soc_platform_remove,
 };
 
 module_platform_driver(bf5xx_pcm_driver);
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index d95477af..6cba211d 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -342,13 +342,8 @@ static struct snd_soc_platform_driver bf5xx_i2s_soc_platform = {
 
 static int bfin_i2s_soc_platform_probe(struct platform_device *pdev)
 {
-	return snd_soc_register_platform(&pdev->dev, &bf5xx_i2s_soc_platform);
-}
-
-static int bfin_i2s_soc_platform_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_platform(&pdev->dev);
-	return 0;
+	return devm_snd_soc_register_platform(&pdev->dev,
+					      &bf5xx_i2s_soc_platform);
 }
 
 static struct platform_driver bfin_i2s_pcm_driver = {
@@ -357,7 +352,6 @@ static struct platform_driver bfin_i2s_pcm_driver = {
 	},
 
 	.probe = bfin_i2s_soc_platform_probe,
-	.remove = bfin_i2s_soc_platform_remove,
 };
 
 module_platform_driver(bfin_i2s_pcm_driver);
-- 
2.1.0
