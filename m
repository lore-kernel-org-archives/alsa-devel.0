From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert ep93xx directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 12:07:55 +0800
Message-ID: <1322107675.16201.16.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 087DF103B4B
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 05:08:04 +0100 (CET)
Received: by yenr9 with SMTP id r9so2273121yen.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 20:08:03 -0800 (PST)
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
Cc: Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam@alsa-project.org, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/ep93xx/edb93xx.c     |   12 +-----------
 sound/soc/ep93xx/ep93xx-ac97.c |   12 +-----------
 sound/soc/ep93xx/ep93xx-i2s.c  |   13 +------------
 sound/soc/ep93xx/ep93xx-pcm.c  |   13 +------------
 sound/soc/ep93xx/simone.c      |   12 +-----------
 sound/soc/ep93xx/snappercl15.c |   13 +------------
 6 files changed, 6 insertions(+), 69 deletions(-)

diff --git a/sound/soc/ep93xx/edb93xx.c b/sound/soc/ep93xx/edb93xx.c
index 51930b6..6b90c75 100644
--- a/sound/soc/ep93xx/edb93xx.c
+++ b/sound/soc/ep93xx/edb93xx.c
@@ -131,17 +131,7 @@ static struct platform_driver edb93xx_driver = {
 	.remove		= __devexit_p(edb93xx_remove),
 };
 
-static int __init edb93xx_init(void)
-{
-	return platform_driver_register(&edb93xx_driver);
-}
-module_init(edb93xx_init);
-
-static void __exit edb93xx_exit(void)
-{
-	platform_driver_unregister(&edb93xx_driver);
-}
-module_exit(edb93xx_exit);
+module_platform_driver(edb93xx_driver);
 
 MODULE_AUTHOR("Alexander Sverdlin <subaparts@yandex.ru>");
 MODULE_DESCRIPTION("ALSA SoC EDB93xx");
diff --git a/sound/soc/ep93xx/ep93xx-ac97.c b/sound/soc/ep93xx/ep93xx-ac97.c
index 3cd6158..ca0b07a 100644
--- a/sound/soc/ep93xx/ep93xx-ac97.c
+++ b/sound/soc/ep93xx/ep93xx-ac97.c
@@ -449,17 +449,7 @@ static struct platform_driver ep93xx_ac97_driver = {
 	},
 };
 
-static int __init ep93xx_ac97_init(void)
-{
-	return platform_driver_register(&ep93xx_ac97_driver);
-}
-module_init(ep93xx_ac97_init);
-
-static void __exit ep93xx_ac97_exit(void)
-{
-	platform_driver_unregister(&ep93xx_ac97_driver);
-}
-module_exit(ep93xx_ac97_exit);
+module_platform_driver(ep93xx_ac97_driver);
 
 MODULE_DESCRIPTION("EP93xx AC97 ASoC Driver");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 099614e..274234b 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -464,18 +464,7 @@ static struct platform_driver ep93xx_i2s_driver = {
 	},
 };
 
-static int __init ep93xx_i2s_init(void)
-{
-	return platform_driver_register(&ep93xx_i2s_driver);
-}
-
-static void __exit ep93xx_i2s_exit(void)
-{
-	platform_driver_unregister(&ep93xx_i2s_driver);
-}
-
-module_init(ep93xx_i2s_init);
-module_exit(ep93xx_i2s_exit);
+module_platform_driver(ep93xx_i2s_driver);
 
 MODULE_ALIAS("platform:ep93xx-i2s");
 MODULE_AUTHOR("Ryan Mallon");
diff --git a/sound/soc/ep93xx/ep93xx-pcm.c b/sound/soc/ep93xx/ep93xx-pcm.c
index 23de792..93ec013 100644
--- a/sound/soc/ep93xx/ep93xx-pcm.c
+++ b/sound/soc/ep93xx/ep93xx-pcm.c
@@ -339,18 +339,7 @@ static struct platform_driver ep93xx_pcm_driver = {
 	.remove = __devexit_p(ep93xx_soc_platform_remove),
 };
 
-static int __init ep93xx_soc_platform_init(void)
-{
-	return platform_driver_register(&ep93xx_pcm_driver);
-}
-
-static void __exit ep93xx_soc_platform_exit(void)
-{
-	platform_driver_unregister(&ep93xx_pcm_driver);
-}
-
-module_init(ep93xx_soc_platform_init);
-module_exit(ep93xx_soc_platform_exit);
+module_platform_driver(ep93xx_pcm_driver);
 
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("EP93xx ALSA PCM interface");
diff --git a/sound/soc/ep93xx/simone.c b/sound/soc/ep93xx/simone.c
index 968cb31..1e00b33 100644
--- a/sound/soc/ep93xx/simone.c
+++ b/sound/soc/ep93xx/simone.c
@@ -81,17 +81,7 @@ static struct platform_driver simone_driver = {
 	.remove		= __devexit_p(simone_remove),
 };
 
-static int __init simone_init(void)
-{
-	return platform_driver_register(&simone_driver);
-}
-module_init(simone_init);
-
-static void __exit simone_exit(void)
-{
-	platform_driver_unregister(&simone_driver);
-}
-module_exit(simone_exit);
+module_platform_driver(simone_driver);
 
 MODULE_DESCRIPTION("ALSA SoC Simplemachines Sim.One");
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 2cde433..33901d6 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -147,18 +147,7 @@ static struct platform_driver snappercl15_driver = {
 	.remove		= __devexit_p(snappercl15_remove),
 };
 
-static int __init snappercl15_init(void)
-{
-	return platform_driver_register(&snappercl15_driver);
-}
-
-static void __exit snappercl15_exit(void)
-{
-	platform_driver_unregister(&snappercl15_driver);
-}
-
-module_init(snappercl15_init);
-module_exit(snappercl15_exit);
+module_platform_driver(snappercl15_driver);
 
 MODULE_AUTHOR("Ryan Mallon");
 MODULE_DESCRIPTION("ALSA SoC Snapper CL15");
-- 
1.7.5.4
