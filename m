From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert blackfin directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 14:44:52 +0800
Message-ID: <1322117092.19406.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 575D1103835
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 07:45:02 +0100 (CET)
Received: by ggnq2 with SMTP id q2so2356751ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:45:00 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Barry Song <21cnbao@gmail.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c     |   12 +-----------
 sound/soc/blackfin/bf5xx-ac97.c         |   13 +------------
 sound/soc/blackfin/bf5xx-i2s-pcm.c      |   12 +-----------
 sound/soc/blackfin/bf5xx-i2s.c          |   13 +------------
 sound/soc/blackfin/bf5xx-tdm-pcm.c      |   12 +-----------
 sound/soc/blackfin/bf5xx-tdm.c          |   12 +-----------
 sound/soc/blackfin/bfin-eval-adau1373.c |   12 +-----------
 sound/soc/blackfin/bfin-eval-adau1701.c |   12 +-----------
 sound/soc/blackfin/bfin-eval-adav80x.c  |   12 +-----------
 9 files changed, 9 insertions(+), 101 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 56815c1..fcff583 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -475,17 +475,7 @@ static struct platform_driver bf5xx_pcm_driver = {
 	.remove = __devexit_p(bf5xx_soc_platform_remove),
 };
 
-static int __init snd_bf5xx_pcm_init(void)
-{
-	return platform_driver_register(&bf5xx_pcm_driver);
-}
-module_init(snd_bf5xx_pcm_init);
-
-static void __exit snd_bf5xx_pcm_exit(void)
-{
-	platform_driver_unregister(&bf5xx_pcm_driver);
-}
-module_exit(snd_bf5xx_pcm_exit);
+module_platform_driver(bf5xx_pcm_driver);
 
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("ADI Blackfin AC97 PCM DMA module");
diff --git a/sound/soc/blackfin/bf5xx-ac97.c b/sound/soc/blackfin/bf5xx-ac97.c
index 6d21625..f4e9dc4 100644
--- a/sound/soc/blackfin/bf5xx-ac97.c
+++ b/sound/soc/blackfin/bf5xx-ac97.c
@@ -375,18 +375,7 @@ static struct platform_driver asoc_bfin_ac97_driver = {
 	.remove = __devexit_p(asoc_bfin_ac97_remove),
 };
 
-static int __init bfin_ac97_init(void)
-{
-	return platform_driver_register(&asoc_bfin_ac97_driver);
-}
-module_init(bfin_ac97_init);
-
-static void __exit bfin_ac97_exit(void)
-{
-	platform_driver_unregister(&asoc_bfin_ac97_driver);
-}
-module_exit(bfin_ac97_exit);
-
+module_platform_driver(asoc_bfin_ac97_driver);
 
 MODULE_AUTHOR("Roy Huang");
 MODULE_DESCRIPTION("AC97 driver for ADI Blackfin");
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 7565e15..6ec3d41 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -314,17 +314,7 @@ static struct platform_driver bfin_i2s_pcm_driver = {
 	.remove = __devexit_p(bfin_i2s_soc_platform_remove),
 };
 
-static int __init snd_bfin_i2s_pcm_init(void)
-{
-	return platform_driver_register(&bfin_i2s_pcm_driver);
-}
-module_init(snd_bfin_i2s_pcm_init);
-
-static void __exit snd_bfin_i2s_pcm_exit(void)
-{
-	platform_driver_unregister(&bfin_i2s_pcm_driver);
-}
-module_exit(snd_bfin_i2s_pcm_exit);
+module_platform_driver(bfin_i2s_pcm_driver);
 
 MODULE_AUTHOR("Cliff Cai");
 MODULE_DESCRIPTION("ADI Blackfin I2S PCM DMA module");
diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 00cc3e0..a400633 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -288,18 +288,7 @@ static struct platform_driver bfin_i2s_driver = {
 	},
 };
 
-static int __init bfin_i2s_init(void)
-{
-	return platform_driver_register(&bfin_i2s_driver);
-}
-
-static void __exit bfin_i2s_exit(void)
-{
-	platform_driver_unregister(&bfin_i2s_driver);
-}
-
-module_init(bfin_i2s_init);
-module_exit(bfin_i2s_exit);
+module_platform_driver(bfin_i2s_driver);
 
 /* Module information */
 MODULE_AUTHOR("Cliff Cai");
diff --git a/sound/soc/blackfin/bf5xx-tdm-pcm.c b/sound/soc/blackfin/bf5xx-tdm-pcm.c
index c95cc03..4406f9a 100644
--- a/sound/soc/blackfin/bf5xx-tdm-pcm.c
+++ b/sound/soc/blackfin/bf5xx-tdm-pcm.c
@@ -339,17 +339,7 @@ static struct platform_driver bfin_tdm_driver = {
 	.remove = __devexit_p(bf5xx_soc_platform_remove),
 };
 
-static int __init snd_bfin_tdm_init(void)
-{
-	return platform_driver_register(&bfin_tdm_driver);
-}
-module_init(snd_bfin_tdm_init);
-
-static void __exit snd_bfin_tdm_exit(void)
-{
-	platform_driver_unregister(&bfin_tdm_driver);
-}
-module_exit(snd_bfin_tdm_exit);
+module_platform_driver(bfin_tdm_driver);
 
 MODULE_AUTHOR("Barry Song");
 MODULE_DESCRIPTION("ADI Blackfin TDM PCM DMA module");
diff --git a/sound/soc/blackfin/bf5xx-tdm.c b/sound/soc/blackfin/bf5xx-tdm.c
index a822d1e..bf65e0e 100644
--- a/sound/soc/blackfin/bf5xx-tdm.c
+++ b/sound/soc/blackfin/bf5xx-tdm.c
@@ -314,17 +314,7 @@ static struct platform_driver bfin_tdm_driver = {
 	},
 };
 
-static int __init bfin_tdm_init(void)
-{
-	return platform_driver_register(&bfin_tdm_driver);
-}
-module_init(bfin_tdm_init);
-
-static void __exit bfin_tdm_exit(void)
-{
-	platform_driver_unregister(&bfin_tdm_driver);
-}
-module_exit(bfin_tdm_exit);
+module_platform_driver(bfin_tdm_driver);
 
 /* Module information */
 MODULE_AUTHOR("Barry Song");
diff --git a/sound/soc/blackfin/bfin-eval-adau1373.c b/sound/soc/blackfin/bfin-eval-adau1373.c
index 8df2a3b..85ed39a 100644
--- a/sound/soc/blackfin/bfin-eval-adau1373.c
+++ b/sound/soc/blackfin/bfin-eval-adau1373.c
@@ -184,17 +184,7 @@ static struct platform_driver bfin_eval_adau1373_driver = {
 	.remove = __devexit_p(bfin_eval_adau1373_remove),
 };
 
-static int __init bfin_eval_adau1373_init(void)
-{
-	return platform_driver_register(&bfin_eval_adau1373_driver);
-}
-module_init(bfin_eval_adau1373_init);
-
-static void __exit bfin_eval_adau1373_exit(void)
-{
-	platform_driver_unregister(&bfin_eval_adau1373_driver);
-}
-module_exit(bfin_eval_adau1373_exit);
+module_platform_driver(bfin_eval_adau1373_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("ALSA SoC bfin adau1373 driver");
diff --git a/sound/soc/blackfin/bfin-eval-adau1701.c b/sound/soc/blackfin/bfin-eval-adau1701.c
index e5550ac..1a88fe9 100644
--- a/sound/soc/blackfin/bfin-eval-adau1701.c
+++ b/sound/soc/blackfin/bfin-eval-adau1701.c
@@ -121,17 +121,7 @@ static struct platform_driver bfin_eval_adau1701_driver = {
 	.remove = __devexit_p(bfin_eval_adau1701_remove),
 };
 
-static int __init bfin_eval_adau1701_init(void)
-{
-	return platform_driver_register(&bfin_eval_adau1701_driver);
-}
-module_init(bfin_eval_adau1701_init);
-
-static void __exit bfin_eval_adau1701_exit(void)
-{
-	platform_driver_unregister(&bfin_eval_adau1701_driver);
-}
-module_exit(bfin_eval_adau1701_exit);
+module_platform_driver(bfin_eval_adau1701_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("ALSA SoC bfin ADAU1701 driver");
diff --git a/sound/soc/blackfin/bfin-eval-adav80x.c b/sound/soc/blackfin/bfin-eval-adav80x.c
index 897cfa6..0bc995f 100644
--- a/sound/soc/blackfin/bfin-eval-adav80x.c
+++ b/sound/soc/blackfin/bfin-eval-adav80x.c
@@ -157,17 +157,7 @@ static struct platform_driver bfin_eval_adav80x_driver = {
 	.id_table = bfin_eval_adav80x_ids,
 };
 
-static int __init bfin_eval_adav80x_init(void)
-{
-	return platform_driver_register(&bfin_eval_adav80x_driver);
-}
-module_init(bfin_eval_adav80x_init);
-
-static void __exit bfin_eval_adav80x_exit(void)
-{
-	platform_driver_unregister(&bfin_eval_adav80x_driver);
-}
-module_exit(bfin_eval_adav80x_exit);
+module_platform_driver(bfin_eval_adav80x_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("ALSA SoC bfin adav80x driver");
-- 
1.7.5.4
