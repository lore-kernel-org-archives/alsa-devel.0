From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Convert CODEC drivers to
	module_platform_driver
Date: Wed, 23 Nov 2011 22:53:01 +0000
Message-ID: <1322088781-1853-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 449E1103D39
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 23:53:07 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Factors out a bit of boilerplate.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/88pm860x-codec.c    |   12 +-----------
 sound/soc/codecs/ac97.c              |   12 +-----------
 sound/soc/codecs/ad1980.c            |   12 +-----------
 sound/soc/codecs/ad73311.c           |   12 +-----------
 sound/soc/codecs/ads117x.c           |   12 +-----------
 sound/soc/codecs/cq93vc.c            |   12 +-----------
 sound/soc/codecs/cx20442.c           |   12 +-----------
 sound/soc/codecs/dfbmcs320.c         |   12 +-----------
 sound/soc/codecs/dmic.c              |   12 +-----------
 sound/soc/codecs/jz4740.c            |   12 +-----------
 sound/soc/codecs/pcm3008.c           |   12 +-----------
 sound/soc/codecs/sn95031.c           |   14 +-------------
 sound/soc/codecs/spdif_transciever.c |   13 +------------
 sound/soc/codecs/stac9766.c          |   12 +-----------
 sound/soc/codecs/twl4030.c           |   12 +-----------
 sound/soc/codecs/twl6040.c           |   12 +-----------
 sound/soc/codecs/uda134x.c           |   12 +-----------
 sound/soc/codecs/wl1273.c            |   12 +-----------
 sound/soc/codecs/wm8350.c            |   12 +-----------
 sound/soc/codecs/wm8400.c            |   12 +-----------
 sound/soc/codecs/wm8727.c            |   12 +-----------
 sound/soc/codecs/wm8782.c            |   12 +-----------
 sound/soc/codecs/wm8994.c            |   13 +------------
 sound/soc/codecs/wm9705.c            |   12 +-----------
 sound/soc/codecs/wm9712.c            |   12 +-----------
 sound/soc/codecs/wm9713.c            |   12 +-----------
 26 files changed, 26 insertions(+), 290 deletions(-)

diff --git a/sound/soc/codecs/88pm860x-codec.c b/sound/soc/codecs/88pm860x-codec.c
index 5ca122e..52bcf8a 100644
--- a/sound/soc/codecs/88pm860x-codec.c
+++ b/sound/soc/codecs/88pm860x-codec.c
@@ -1481,17 +1481,7 @@ static struct platform_driver pm860x_codec_driver = {
 	.remove	= __devexit_p(pm860x_codec_remove),
 };
 
-static __init int pm860x_init(void)
-{
-	return platform_driver_register(&pm860x_codec_driver);
-}
-module_init(pm860x_init);
-
-static __exit void pm860x_exit(void)
-{
-	platform_driver_unregister(&pm860x_codec_driver);
-}
-module_exit(pm860x_exit);
+module_platform_driver(pm860x_codec_driver);
 
 MODULE_DESCRIPTION("ASoC 88PM860x driver");
 MODULE_AUTHOR("Haojian Zhuang <haojian.zhuang@marvell.com>");
diff --git a/sound/soc/codecs/ac97.c b/sound/soc/codecs/ac97.c
index e715186..07bf6a4 100644
--- a/sound/soc/codecs/ac97.c
+++ b/sound/soc/codecs/ac97.c
@@ -148,17 +148,7 @@ static struct platform_driver ac97_codec_driver = {
 	.remove = __devexit_p(ac97_remove),
 };
 
-static int __init ac97_init(void)
-{
-	return platform_driver_register(&ac97_codec_driver);
-}
-module_init(ac97_init);
-
-static void __exit ac97_exit(void)
-{
-	platform_driver_unregister(&ac97_codec_driver);
-}
-module_exit(ac97_exit);
+module_platform_driver(ac97_codec_driver);
 
 MODULE_DESCRIPTION("Soc Generic AC97 driver");
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/codecs/ad1980.c b/sound/soc/codecs/ad1980.c
index e3931cc..9bba7f8 100644
--- a/sound/soc/codecs/ad1980.c
+++ b/sound/soc/codecs/ad1980.c
@@ -277,17 +277,7 @@ static struct platform_driver ad1980_codec_driver = {
 	.remove = __devexit_p(ad1980_remove),
 };
 
-static int __init ad1980_init(void)
-{
-	return platform_driver_register(&ad1980_codec_driver);
-}
-module_init(ad1980_init);
-
-static void __exit ad1980_exit(void)
-{
-	platform_driver_unregister(&ad1980_codec_driver);
-}
-module_exit(ad1980_exit);
+module_platform_driver(ad1980_codec_driver);
 
 MODULE_DESCRIPTION("ASoC ad1980 driver (Obsolete)");
 MODULE_AUTHOR("Roy Huang, Cliff Cai");
diff --git a/sound/soc/codecs/ad73311.c b/sound/soc/codecs/ad73311.c
index 8d793e9..ee7a68d 100644
--- a/sound/soc/codecs/ad73311.c
+++ b/sound/soc/codecs/ad73311.c
@@ -63,17 +63,7 @@ static struct platform_driver ad73311_codec_driver = {
 	.remove = __devexit_p(ad73311_remove),
 };
 
-static int __init ad73311_init(void)
-{
-	return platform_driver_register(&ad73311_codec_driver);
-}
-module_init(ad73311_init);
-
-static void __exit ad73311_exit(void)
-{
-	platform_driver_unregister(&ad73311_codec_driver);
-}
-module_exit(ad73311_exit);
+module_platform_driver(ad73311_codec_driver);
 
 MODULE_DESCRIPTION("ASoC ad73311 driver");
 MODULE_AUTHOR("Cliff Cai ");
diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 9082e0f..8103b93 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -58,17 +58,7 @@ static struct platform_driver ads117x_codec_driver = {
 	.remove = __devexit_p(ads117x_remove),
 };
 
-static int __init ads117x_init(void)
-{
-	return platform_driver_register(&ads117x_codec_driver);
-}
-module_init(ads117x_init);
-
-static void __exit ads117x_exit(void)
-{
-	platform_driver_unregister(&ads117x_codec_driver);
-}
-module_exit(ads117x_exit);
+module_platform_driver(ads117x_codec_driver);
 
 MODULE_DESCRIPTION("ASoC ads117x driver");
 MODULE_AUTHOR("Graeme Gregory");
diff --git a/sound/soc/codecs/cq93vc.c b/sound/soc/codecs/cq93vc.c
index 46dbfd0..e020374 100644
--- a/sound/soc/codecs/cq93vc.c
+++ b/sound/soc/codecs/cq93vc.c
@@ -206,17 +206,7 @@ static struct platform_driver cq93vc_codec_driver = {
 	.remove = __devexit_p(cq93vc_platform_remove),
 };
 
-static int __init cq93vc_init(void)
-{
-	return platform_driver_register(&cq93vc_codec_driver);
-}
-module_init(cq93vc_init);
-
-static void __exit cq93vc_exit(void)
-{
-	platform_driver_unregister(&cq93vc_codec_driver);
-}
-module_exit(cq93vc_exit);
+module_platform_driver(cq93vc_codec_driver);
 
 MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC CQ0093 Voice Codec Driver");
 MODULE_AUTHOR("Miguel Aguilar");
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index bc7067d..ae55e31 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -391,17 +391,7 @@ static struct platform_driver cx20442_platform_driver = {
 	.remove = __exit_p(cx20442_platform_remove),
 };
 
-static int __init cx20442_init(void)
-{
-	return platform_driver_register(&cx20442_platform_driver);
-}
-module_init(cx20442_init);
-
-static void __exit cx20442_exit(void)
-{
-	platform_driver_unregister(&cx20442_platform_driver);
-}
-module_exit(cx20442_exit);
+module_platform_driver(cx20442_platform_driver);
 
 MODULE_DESCRIPTION("ASoC CX20442-11 voice modem codec driver");
 MODULE_AUTHOR("Janusz Krzysztofik");
diff --git a/sound/soc/codecs/dfbmcs320.c b/sound/soc/codecs/dfbmcs320.c
index 704bbde..bfe46aa 100644
--- a/sound/soc/codecs/dfbmcs320.c
+++ b/sound/soc/codecs/dfbmcs320.c
@@ -55,17 +55,7 @@ static struct platform_driver dfmcs320_driver = {
 	.remove = __devexit_p(dfbmcs320_remove),
 };
 
-static int __init dfbmcs320_init(void)
-{
-	return platform_driver_register(&dfmcs320_driver);
-}
-module_init(dfbmcs320_init);
-
-static void __exit dfbmcs320_exit(void)
-{
-	platform_driver_unregister(&dfmcs320_driver);
-}
-module_exit(dfbmcs320_exit);
+module_platform_driver(dfmcs320_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("ASoC DFBM-CS320 bluethooth module driver");
diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 6fae765..3e929f0 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -89,17 +89,7 @@ static struct platform_driver dmic_driver = {
 	.remove = __devexit_p(dmic_dev_remove),
 };
 
-static int __init dmic_init(void)
-{
-	return platform_driver_register(&dmic_driver);
-}
-module_init(dmic_init);
-
-static void __exit dmic_exit(void)
-{
-	platform_driver_unregister(&dmic_driver);
-}
-module_exit(dmic_exit);
+module_platform_driver(dmic_driver);
 
 MODULE_DESCRIPTION("Generic DMIC driver");
 MODULE_AUTHOR("Liam Girdwood <lrg@slimlogic.co.uk>");
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index e373f8f..21255e2 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -424,17 +424,7 @@ static struct platform_driver jz4740_codec_driver = {
 	},
 };
 
-static int __init jz4740_codec_init(void)
-{
-	return platform_driver_register(&jz4740_codec_driver);
-}
-module_init(jz4740_codec_init);
-
-static void __exit jz4740_codec_exit(void)
-{
-	platform_driver_unregister(&jz4740_codec_driver);
-}
-module_exit(jz4740_codec_exit);
+module_platform_driver(jz4740_codec_driver);
 
 MODULE_DESCRIPTION("JZ4740 SoC internal codec driver");
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
diff --git a/sound/soc/codecs/pcm3008.c b/sound/soc/codecs/pcm3008.c
index f731651..b12d01f 100644
--- a/sound/soc/codecs/pcm3008.c
+++ b/sound/soc/codecs/pcm3008.c
@@ -172,17 +172,7 @@ static struct platform_driver pcm3008_codec_driver = {
 	},
 };
 
-static int __init pcm3008_modinit(void)
-{
-	return platform_driver_register(&pcm3008_codec_driver);
-}
-module_init(pcm3008_modinit);
-
-static void __exit pcm3008_exit(void)
-{
-	platform_driver_unregister(&pcm3008_codec_driver);
-}
-module_exit(pcm3008_exit);
+module_platform_driver(pcm3008_codec_driver);
 
 MODULE_DESCRIPTION("Soc PCM3008 driver");
 MODULE_AUTHOR("Hugo Villeneuve");
diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 887d618..2a34e27 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -920,19 +920,7 @@ static struct platform_driver sn95031_codec_driver = {
 	.remove		= __devexit_p(sn95031_device_remove),
 };
 
-static int __init sn95031_init(void)
-{
-	pr_debug("driver init called\n");
-	return platform_driver_register(&sn95031_codec_driver);
-}
-module_init(sn95031_init);
-
-static void __exit sn95031_exit(void)
-{
-	pr_debug("driver exit called\n");
-	platform_driver_unregister(&sn95031_codec_driver);
-}
-module_exit(sn95031_exit);
+module_platform_driver(sn95031_codec_driver);
 
 MODULE_DESCRIPTION("ASoC TI SN95031 codec driver");
 MODULE_AUTHOR("Vinod Koul <vinod.koul@intel.com>");
diff --git a/sound/soc/codecs/spdif_transciever.c b/sound/soc/codecs/spdif_transciever.c
index 6a1a7e7..112a49d 100644
--- a/sound/soc/codecs/spdif_transciever.c
+++ b/sound/soc/codecs/spdif_transciever.c
@@ -61,18 +61,7 @@ static struct platform_driver spdif_dit_driver = {
 	},
 };
 
-static int __init dit_modinit(void)
-{
-	return platform_driver_register(&spdif_dit_driver);
-}
-
-static void __exit dit_exit(void)
-{
-	platform_driver_unregister(&spdif_dit_driver);
-}
-
-module_init(dit_modinit);
-module_exit(dit_exit);
+module_platform_driver(spdif_dit_driver);
 
 MODULE_AUTHOR("Steve Chen <schen@mvista.com>");
 MODULE_DESCRIPTION("SPDIF dummy codec driver");
diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
index 78b2b50..95b2a43 100644
--- a/sound/soc/codecs/stac9766.c
+++ b/sound/soc/codecs/stac9766.c
@@ -408,17 +408,7 @@ static struct platform_driver stac9766_codec_driver = {
 	.remove = __devexit_p(stac9766_remove),
 };
 
-static int __init stac9766_init(void)
-{
-	return platform_driver_register(&stac9766_codec_driver);
-}
-module_init(stac9766_init);
-
-static void __exit stac9766_exit(void)
-{
-	platform_driver_unregister(&stac9766_codec_driver);
-}
-module_exit(stac9766_exit);
+module_platform_driver(stac9766_codec_driver);
 
 MODULE_DESCRIPTION("ASoC stac9766 driver");
 MODULE_AUTHOR("Jon Smirl <jonsmirl@gmail.com>");
diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f798247..94a5796 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2294,17 +2294,7 @@ static struct platform_driver twl4030_codec_driver = {
 	},
 };
 
-static int __init twl4030_modinit(void)
-{
-	return platform_driver_register(&twl4030_codec_driver);
-}
-module_init(twl4030_modinit);
-
-static void __exit twl4030_exit(void)
-{
-	platform_driver_unregister(&twl4030_codec_driver);
-}
-module_exit(twl4030_exit);
+module_platform_driver(twl4030_codec_driver);
 
 MODULE_DESCRIPTION("ASoC TWL4030 codec driver");
 MODULE_AUTHOR("Steve Sakoman");
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 73e11f0..b2f42f9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1620,17 +1620,7 @@ static struct platform_driver twl6040_codec_driver = {
 	.remove = __devexit_p(twl6040_codec_remove),
 };
 
-static int __init twl6040_codec_init(void)
-{
-	return platform_driver_register(&twl6040_codec_driver);
-}
-module_init(twl6040_codec_init);
-
-static void __exit twl6040_codec_exit(void)
-{
-	platform_driver_unregister(&twl6040_codec_driver);
-}
-module_exit(twl6040_codec_exit);
+module_platform_driver(twl6040_codec_driver);
 
 MODULE_DESCRIPTION("ASoC TWL6040 codec driver");
 MODULE_AUTHOR("Misael Lopez Cruz");
diff --git a/sound/soc/codecs/uda134x.c b/sound/soc/codecs/uda134x.c
index a7b8f30..ba82ccf 100644
--- a/sound/soc/codecs/uda134x.c
+++ b/sound/soc/codecs/uda134x.c
@@ -625,17 +625,7 @@ static struct platform_driver uda134x_codec_driver = {
 	.remove = __devexit_p(uda134x_codec_remove),
 };
 
-static int __init uda134x_codec_init(void)
-{
-	return platform_driver_register(&uda134x_codec_driver);
-}
-module_init(uda134x_codec_init);
-
-static void __exit uda134x_codec_exit(void)
-{
-	platform_driver_unregister(&uda134x_codec_driver);
-}
-module_exit(uda134x_codec_exit);
+module_platform_driver(uda134x_codec_driver);
 
 MODULE_DESCRIPTION("UDA134X ALSA soc codec driver");
 MODULE_AUTHOR("Zoltan Devai, Christian Pellegrin <chripell@evolware.org>");
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index a854989..ba29e98 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -510,17 +510,7 @@ static struct platform_driver wl1273_platform_driver = {
 	.remove		= __devexit_p(wl1273_platform_remove),
 };
 
-static int __init wl1273_init(void)
-{
-	return platform_driver_register(&wl1273_platform_driver);
-}
-module_init(wl1273_init);
-
-static void __exit wl1273_exit(void)
-{
-	platform_driver_unregister(&wl1273_platform_driver);
-}
-module_exit(wl1273_exit);
+module_platform_driver(wl1273_platform_driver);
 
 MODULE_AUTHOR("Matti Aaltonen <matti.j.aaltonen@nokia.com>");
 MODULE_DESCRIPTION("ASoC WL1273 codec driver");
diff --git a/sound/soc/codecs/wm8350.c b/sound/soc/codecs/wm8350.c
index 35f3ad8..cb212a8 100644
--- a/sound/soc/codecs/wm8350.c
+++ b/sound/soc/codecs/wm8350.c
@@ -1711,17 +1711,7 @@ static struct platform_driver wm8350_codec_driver = {
 	.remove = __devexit_p(wm8350_remove),
 };
 
-static __init int wm8350_init(void)
-{
-	return platform_driver_register(&wm8350_codec_driver);
-}
-module_init(wm8350_init);
-
-static __exit void wm8350_exit(void)
-{
-	platform_driver_unregister(&wm8350_codec_driver);
-}
-module_exit(wm8350_exit);
+module_platform_driver(wm8350_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM8350 driver");
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/codecs/wm8400.c b/sound/soc/codecs/wm8400.c
index 585def1..056f7fa 100644
--- a/sound/soc/codecs/wm8400.c
+++ b/sound/soc/codecs/wm8400.c
@@ -1477,17 +1477,7 @@ static struct platform_driver wm8400_codec_driver = {
 	.remove = __devexit_p(wm8400_remove),
 };
 
-static __init int wm8400_init(void)
-{
-	return platform_driver_register(&wm8400_codec_driver);
-}
-module_init(wm8400_init);
-
-static __exit void wm8400_exit(void)
-{
-	platform_driver_unregister(&wm8400_codec_driver);
-}
-module_exit(wm8400_exit);
+module_platform_driver(wm8400_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM8400 driver");
 MODULE_AUTHOR("Mark Brown");
diff --git a/sound/soc/codecs/wm8727.c b/sound/soc/codecs/wm8727.c
index 7488082..fad90a3 100644
--- a/sound/soc/codecs/wm8727.c
+++ b/sound/soc/codecs/wm8727.c
@@ -67,17 +67,7 @@ static struct platform_driver wm8727_codec_driver = {
 	.remove = __devexit_p(wm8727_remove),
 };
 
-static int __init wm8727_init(void)
-{
-	return platform_driver_register(&wm8727_codec_driver);
-}
-module_init(wm8727_init);
-
-static void __exit wm8727_exit(void)
-{
-	platform_driver_unregister(&wm8727_codec_driver);
-}
-module_exit(wm8727_exit);
+module_platform_driver(wm8727_codec_driver);
 
 MODULE_DESCRIPTION("ASoC wm8727 driver");
 MODULE_AUTHOR("Neil Jones");
diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index f2ced71..3fdea98 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -63,17 +63,7 @@ static struct platform_driver wm8782_codec_driver = {
 	.remove = __devexit_p(wm8782_remove),
 };
 
-static int __init wm8782_init(void)
-{
-	return platform_driver_register(&wm8782_codec_driver);
-}
-module_init(wm8782_init);
-
-static void __exit wm8782_exit(void)
-{
-	platform_driver_unregister(&wm8782_codec_driver);
-}
-module_exit(wm8782_exit);
+module_platform_driver(wm8782_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM8782 driver");
 MODULE_AUTHOR("Johannes Stezenbach <js@sig21.net>");
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index c69ae72..a9f3117 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3553,18 +3553,7 @@ static struct platform_driver wm8994_codec_driver = {
 	.remove = __devexit_p(wm8994_remove),
 };
 
-static __init int wm8994_init(void)
-{
-	return platform_driver_register(&wm8994_codec_driver);
-}
-module_init(wm8994_init);
-
-static __exit void wm8994_exit(void)
-{
-	platform_driver_unregister(&wm8994_codec_driver);
-}
-module_exit(wm8994_exit);
-
+module_platform_driver(wm8994_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM8994 driver");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 646b58d..b344b56 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -406,17 +406,7 @@ static struct platform_driver wm9705_codec_driver = {
 	.remove = __devexit_p(wm9705_remove),
 };
 
-static int __init wm9705_init(void)
-{
-	return platform_driver_register(&wm9705_codec_driver);
-}
-module_init(wm9705_init);
-
-static void __exit wm9705_exit(void)
-{
-	platform_driver_unregister(&wm9705_codec_driver);
-}
-module_exit(wm9705_exit);
+module_platform_driver(wm9705_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM9705 driver");
 MODULE_AUTHOR("Ian Molton");
diff --git a/sound/soc/codecs/wm9712.c b/sound/soc/codecs/wm9712.c
index 90117f8..6cd92e9 100644
--- a/sound/soc/codecs/wm9712.c
+++ b/sound/soc/codecs/wm9712.c
@@ -694,17 +694,7 @@ static struct platform_driver wm9712_codec_driver = {
 	.remove = __devexit_p(wm9712_remove),
 };
 
-static int __init wm9712_init(void)
-{
-	return platform_driver_register(&wm9712_codec_driver);
-}
-module_init(wm9712_init);
-
-static void __exit wm9712_exit(void)
-{
-	platform_driver_unregister(&wm9712_codec_driver);
-}
-module_exit(wm9712_exit);
+module_platform_driver(wm9712_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM9711/WM9712 driver");
 MODULE_AUTHOR("Liam Girdwood");
diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 7167cb6..ba0947b 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1277,17 +1277,7 @@ static struct platform_driver wm9713_codec_driver = {
 	.remove = __devexit_p(wm9713_remove),
 };
 
-static int __init wm9713_init(void)
-{
-	return platform_driver_register(&wm9713_codec_driver);
-}
-module_init(wm9713_init);
-
-static void __exit wm9713_exit(void)
-{
-	platform_driver_unregister(&wm9713_codec_driver);
-}
-module_exit(wm9713_exit);
+module_platform_driver(wm9713_codec_driver);
 
 MODULE_DESCRIPTION("ASoC WM9713/WM9714 driver");
 MODULE_AUTHOR("Liam Girdwood");
-- 
1.7.7.3
