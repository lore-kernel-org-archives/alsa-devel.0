From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert Samsung directory to
	module_platform_driver
Date: Wed, 23 Nov 2011 22:54:16 +0000
Message-ID: <1322088856-1920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F94B103B2F
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 23:54:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Saves some boilerplate code.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/ac97.c                       |   12 +-----------
 sound/soc/samsung/dma.c                        |   12 +-----------
 sound/soc/samsung/i2s.c                        |   12 +-----------
 sound/soc/samsung/idma.c                       |   12 +-----------
 sound/soc/samsung/lowland.c                    |   12 +-----------
 sound/soc/samsung/pcm.c                        |   12 +-----------
 sound/soc/samsung/s3c2412-i2s.c                |   12 +-----------
 sound/soc/samsung/s3c24xx-i2s.c                |   12 +-----------
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |   16 ++--------------
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |   16 ++--------------
 sound/soc/samsung/s3c24xx_uda134x.c            |   14 +-------------
 sound/soc/samsung/smdk_wm8580pcm.c             |   14 +-------------
 sound/soc/samsung/spdif.c                      |   12 +-----------
 sound/soc/samsung/speyside.c                   |   12 +-----------
 sound/soc/samsung/speyside_wm8962.c            |   12 +-----------
 15 files changed, 17 insertions(+), 175 deletions(-)

diff --git a/sound/soc/samsung/ac97.c b/sound/soc/samsung/ac97.c
index 16521e3..ee52d51 100644
--- a/sound/soc/samsung/ac97.c
+++ b/sound/soc/samsung/ac97.c
@@ -509,17 +509,7 @@ static struct platform_driver s3c_ac97_driver = {
 	},
 };
 
-static int __init s3c_ac97_init(void)
-{
-	return platform_driver_register(&s3c_ac97_driver);
-}
-module_init(s3c_ac97_init);
-
-static void __exit s3c_ac97_exit(void)
-{
-	platform_driver_unregister(&s3c_ac97_driver);
-}
-module_exit(s3c_ac97_exit);
+module_platform_driver(s3c_ac97_driver);
 
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("AC97 driver for the Samsung SoC");
diff --git a/sound/soc/samsung/dma.c b/sound/soc/samsung/dma.c
index d400ed0..95828ed 100644
--- a/sound/soc/samsung/dma.c
+++ b/sound/soc/samsung/dma.c
@@ -458,17 +458,7 @@ static struct platform_driver asoc_dma_driver = {
 	.remove = __devexit_p(samsung_asoc_platform_remove),
 };
 
-static int __init samsung_asoc_init(void)
-{
-	return platform_driver_register(&asoc_dma_driver);
-}
-module_init(samsung_asoc_init);
-
-static void __exit samsung_asoc_exit(void)
-{
-	platform_driver_unregister(&asoc_dma_driver);
-}
-module_exit(samsung_asoc_exit);
+module_platform_driver(asoc_dma_driver);
 
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("Samsung ASoC DMA Driver");
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index bff42bf..04ab813 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1144,17 +1144,7 @@ static struct platform_driver samsung_i2s_driver = {
 	},
 };
 
-static int __init samsung_i2s_init(void)
-{
-	return platform_driver_register(&samsung_i2s_driver);
-}
-module_init(samsung_i2s_init);
-
-static void __exit samsung_i2s_exit(void)
-{
-	platform_driver_unregister(&samsung_i2s_driver);
-}
-module_exit(samsung_i2s_exit);
+module_platform_driver(samsung_i2s_driver);
 
 /* Module information */
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
diff --git a/sound/soc/samsung/idma.c b/sound/soc/samsung/idma.c
index c41178e..6ca3d8c 100644
--- a/sound/soc/samsung/idma.c
+++ b/sound/soc/samsung/idma.c
@@ -437,17 +437,7 @@ static struct platform_driver asoc_idma_driver = {
 	.remove = __devexit_p(asoc_idma_platform_remove),
 };
 
-static int __init asoc_idma_init(void)
-{
-	return platform_driver_register(&asoc_idma_driver);
-}
-module_init(asoc_idma_init);
-
-static void __exit asoc_idma_exit(void)
-{
-	platform_driver_unregister(&asoc_idma_driver);
-}
-module_exit(asoc_idma_exit);
+module_platform_driver(asoc_idma_driver);
 
 MODULE_AUTHOR("Jaswinder Singh, <jassisinghbrar@gmail.com>");
 MODULE_DESCRIPTION("Samsung ASoC IDMA Driver");
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index eff1b4b..4216a06 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -228,17 +228,7 @@ static struct platform_driver lowland_driver = {
 	.remove = __devexit_p(lowland_remove),
 };
 
-static int __init lowland_audio_init(void)
-{
-	return platform_driver_register(&lowland_driver);
-}
-module_init(lowland_audio_init);
-
-static void __exit lowland_audio_exit(void)
-{
-	platform_driver_unregister(&lowland_driver);
-}
-module_exit(lowland_audio_exit);
+module_platform_driver(lowland_driver);
 
 MODULE_DESCRIPTION("Lowland audio support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index 05a47cf..d96e1d1 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -632,17 +632,7 @@ static struct platform_driver s3c_pcm_driver = {
 	},
 };
 
-static int __init s3c_pcm_init(void)
-{
-	return platform_driver_register(&s3c_pcm_driver);
-}
-module_init(s3c_pcm_init);
-
-static void __exit s3c_pcm_exit(void)
-{
-	platform_driver_unregister(&s3c_pcm_driver);
-}
-module_exit(s3c_pcm_exit);
+module_platform_driver(s3c_pcm_driver);
 
 /* Module information */
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
diff --git a/sound/soc/samsung/s3c2412-i2s.c b/sound/soc/samsung/s3c2412-i2s.c
index 7bbec25..ef041c0 100644
--- a/sound/soc/samsung/s3c2412-i2s.c
+++ b/sound/soc/samsung/s3c2412-i2s.c
@@ -184,17 +184,7 @@ static struct platform_driver s3c2412_iis_driver = {
 	},
 };
 
-static int __init s3c2412_i2s_init(void)
-{
-	return platform_driver_register(&s3c2412_iis_driver);
-}
-module_init(s3c2412_i2s_init);
-
-static void __exit s3c2412_i2s_exit(void)
-{
-	platform_driver_unregister(&s3c2412_iis_driver);
-}
-module_exit(s3c2412_i2s_exit);
+module_platform_driver(s3c2412_iis_driver);
 
 /* Module information */
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
diff --git a/sound/soc/samsung/s3c24xx-i2s.c b/sound/soc/samsung/s3c24xx-i2s.c
index 558c64b..b84436e 100644
--- a/sound/soc/samsung/s3c24xx-i2s.c
+++ b/sound/soc/samsung/s3c24xx-i2s.c
@@ -489,17 +489,7 @@ static struct platform_driver s3c24xx_iis_driver = {
 	},
 };
 
-static int __init s3c24xx_i2s_init(void)
-{
-	return platform_driver_register(&s3c24xx_iis_driver);
-}
-module_init(s3c24xx_i2s_init);
-
-static void __exit s3c24xx_i2s_exit(void)
-{
-	platform_driver_unregister(&s3c24xx_iis_driver);
-}
-module_exit(s3c24xx_i2s_exit);
+module_platform_driver(s3c24xx_iis_driver);
 
 /* Module information */
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
diff --git a/sound/soc/samsung/s3c24xx_simtec_hermes.c b/sound/soc/samsung/s3c24xx_simtec_hermes.c
index d125e79..5027981 100644
--- a/sound/soc/samsung/s3c24xx_simtec_hermes.c
+++ b/sound/soc/samsung/s3c24xx_simtec_hermes.c
@@ -114,21 +114,9 @@ static struct platform_driver simtec_audio_hermes_platdrv = {
 	.remove	= __devexit_p(simtec_audio_remove),
 };
 
-MODULE_ALIAS("platform:s3c24xx-simtec-hermes-snd");
-
-static int __init simtec_hermes_modinit(void)
-{
-	return platform_driver_register(&simtec_audio_hermes_platdrv);
-}
-
-static void __exit simtec_hermes_modexit(void)
-{
-	platform_driver_unregister(&simtec_audio_hermes_platdrv);
-}
-
-module_init(simtec_hermes_modinit);
-module_exit(simtec_hermes_modexit);
+module_platform_driver(simtec_audio_hermes_platdrv);
 
+MODULE_ALIAS("platform:s3c24xx-simtec-hermes-snd");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
index 5e4fd46..7324609 100644
--- a/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
+++ b/sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c
@@ -102,21 +102,9 @@ static struct platform_driver simtec_audio_tlv320aic23_platdrv = {
 	.remove	= __devexit_p(simtec_audio_remove),
 };
 
-MODULE_ALIAS("platform:s3c24xx-simtec-tlv320aic23");
-
-static int __init simtec_tlv320aic23_modinit(void)
-{
-	return platform_driver_register(&simtec_audio_tlv320aic23_platdrv);
-}
-
-static void __exit simtec_tlv320aic23_modexit(void)
-{
-	platform_driver_unregister(&simtec_audio_tlv320aic23_platdrv);
-}
-
-module_init(simtec_tlv320aic23_modinit);
-module_exit(simtec_tlv320aic23_modexit);
+module_platform_driver(simtec_audio_tlv320aic32_driver);
 
+MODULE_ALIAS("platform:s3c24xx-simtec-tlv320aic23");
 MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("ALSA SoC Simtec Audio support");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/samsung/s3c24xx_uda134x.c b/sound/soc/samsung/s3c24xx_uda134x.c
index 548c6ac..62b69fb 100644
--- a/sound/soc/samsung/s3c24xx_uda134x.c
+++ b/sound/soc/samsung/s3c24xx_uda134x.c
@@ -343,19 +343,7 @@ static struct platform_driver s3c24xx_uda134x_driver = {
 	},
 };
 
-static int __init s3c24xx_uda134x_init(void)
-{
-	return platform_driver_register(&s3c24xx_uda134x_driver);
-}
-
-static void __exit s3c24xx_uda134x_exit(void)
-{
-	platform_driver_unregister(&s3c24xx_uda134x_driver);
-}
-
-
-module_init(s3c24xx_uda134x_init);
-module_exit(s3c24xx_uda134x_exit);
+module_platform_driver(s3c24xx_uda134x_driver);
 
 MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
 MODULE_DESCRIPTION("S3C24XX_UDA134X ALSA SoC audio driver");
diff --git a/sound/soc/samsung/smdk_wm8580pcm.c b/sound/soc/samsung/smdk_wm8580pcm.c
index 0677473..49dfafb 100644
--- a/sound/soc/samsung/smdk_wm8580pcm.c
+++ b/sound/soc/samsung/smdk_wm8580pcm.c
@@ -188,19 +188,7 @@ static struct platform_driver snd_smdk_driver = {
 	.remove = __devexit_p(snd_smdk_remove),
 };
 
-static int __init smdk_audio_init(void)
-{
-	return platform_driver_register(&snd_smdk_driver);
-}
-
-module_init(smdk_audio_init);
-
-static void __exit smdk_audio_exit(void)
-{
-	platform_driver_unregister(&snd_smdk_driver);
-}
-
-module_exit(smdk_audio_exit);
+module_platform_driver(snd_smdk_driver);
 
 MODULE_AUTHOR("Sangbeom Kim, <sbkim73@samsung.com>");
 MODULE_DESCRIPTION("ALSA SoC SMDK WM8580 for PCM");
diff --git a/sound/soc/samsung/spdif.c b/sound/soc/samsung/spdif.c
index 468cff1..0798f1c 100644
--- a/sound/soc/samsung/spdif.c
+++ b/sound/soc/samsung/spdif.c
@@ -483,17 +483,7 @@ static struct platform_driver samsung_spdif_driver = {
 	},
 };
 
-static int __init spdif_init(void)
-{
-	return platform_driver_register(&samsung_spdif_driver);
-}
-module_init(spdif_init);
-
-static void __exit spdif_exit(void)
-{
-	platform_driver_unregister(&samsung_spdif_driver);
-}
-module_exit(spdif_exit);
+module_platform_driver(samsung_spdif_driver);
 
 MODULE_AUTHOR("Seungwhan Youn, <sw.youn@samsung.com>");
 MODULE_DESCRIPTION("Samsung S/PDIF Controller Driver");
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index d7ec3a7..2b35aff 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -332,17 +332,7 @@ static struct platform_driver speyside_driver = {
 	.remove = __devexit_p(speyside_remove),
 };
 
-static int __init speyside_audio_init(void)
-{
-	return platform_driver_register(&speyside_driver);
-}
-module_init(speyside_audio_init);
-
-static void __exit speyside_audio_exit(void)
-{
-	platform_driver_unregister(&speyside_driver);
-}
-module_exit(speyside_audio_exit);
+module_platform_driver(speyside_driver);
 
 MODULE_DESCRIPTION("Speyside audio support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
diff --git a/sound/soc/samsung/speyside_wm8962.c b/sound/soc/samsung/speyside_wm8962.c
index e3e2716..97d8959 100644
--- a/sound/soc/samsung/speyside_wm8962.c
+++ b/sound/soc/samsung/speyside_wm8962.c
@@ -248,17 +248,7 @@ static struct platform_driver speyside_wm8962_driver = {
 	.remove = __devexit_p(speyside_wm8962_remove),
 };
 
-static int __init speyside_wm8962_audio_init(void)
-{
-	return platform_driver_register(&speyside_wm8962_driver);
-}
-module_init(speyside_wm8962_audio_init);
-
-static void __exit speyside_wm8962_audio_exit(void)
-{
-	platform_driver_unregister(&speyside_wm8962_driver);
-}
-module_exit(speyside_wm8962_audio_exit);
+module_platform_driver(speyside_wm8962_driver);
 
 MODULE_DESCRIPTION("Speyside WM8962 audio support");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
-- 
1.7.7.3
