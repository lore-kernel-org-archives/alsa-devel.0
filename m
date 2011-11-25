From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/8] ASoC: Convert au1x directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:06:59 +0800
Message-ID: <1322186819.8878.2.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 75E6A103B5B
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:07:06 +0100 (CET)
Received: by ggnq2 with SMTP id q2so3221578ggn.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:07:05 -0800 (PST)
In-Reply-To: <1322186745.8878.1.camel@phoenix>
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
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/au1x/db1000.c  |   13 +------------
 sound/soc/au1x/db1200.c  |   13 +------------
 sound/soc/au1x/dbdma2.c  |   13 +------------
 sound/soc/au1x/dma.c     |   13 +------------
 sound/soc/au1x/i2sc.c    |   13 +------------
 sound/soc/au1x/psc-i2s.c |   13 +------------
 6 files changed, 6 insertions(+), 72 deletions(-)

diff --git a/sound/soc/au1x/db1000.c b/sound/soc/au1x/db1000.c
index 127477a..094a207 100644
--- a/sound/soc/au1x/db1000.c
+++ b/sound/soc/au1x/db1000.c
@@ -57,18 +57,7 @@ static struct platform_driver db1000_audio_driver = {
 	.remove		= __devexit_p(db1000_audio_remove),
 };
 
-static int __init db1000_audio_load(void)
-{
-	return platform_driver_register(&db1000_audio_driver);
-}
-
-static void __exit db1000_audio_unload(void)
-{
-	platform_driver_unregister(&db1000_audio_driver);
-}
-
-module_init(db1000_audio_load);
-module_exit(db1000_audio_unload);
+module_platform_driver(db1000_audio_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("DB1000/DB1500/DB1100 ASoC audio");
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 44ad118..ec725f6 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -202,18 +202,7 @@ static struct platform_driver db1200_audio_driver = {
 	.remove		= __devexit_p(db1200_audio_remove),
 };
 
-static int __init db1200_audio_load(void)
-{
-	return platform_driver_register(&db1200_audio_driver);
-}
-
-static void __exit db1200_audio_unload(void)
-{
-	platform_driver_unregister(&db1200_audio_driver);
-}
-
-module_init(db1200_audio_load);
-module_exit(db1200_audio_unload);
+module_platform_driver(db1200_audio_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("DB1200/DB1300/DB1550 ASoC audio support");
diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index d7d04e2..09699de 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -384,18 +384,7 @@ static struct platform_driver au1xpsc_pcm_driver = {
 	.remove		= __devexit_p(au1xpsc_pcm_drvremove),
 };
 
-static int __init au1xpsc_audio_dbdma_load(void)
-{
-	return platform_driver_register(&au1xpsc_pcm_driver);
-}
-
-static void __exit au1xpsc_audio_dbdma_unload(void)
-{
-	platform_driver_unregister(&au1xpsc_pcm_driver);
-}
-
-module_init(au1xpsc_audio_dbdma_load);
-module_exit(au1xpsc_audio_dbdma_unload);
+module_platform_driver(au1xpsc_pcm_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC Audio DMA driver");
diff --git a/sound/soc/au1x/dma.c b/sound/soc/au1x/dma.c
index 177f713..dc4dae4 100644
--- a/sound/soc/au1x/dma.c
+++ b/sound/soc/au1x/dma.c
@@ -359,18 +359,7 @@ static struct platform_driver alchemy_pcmdma_driver = {
 	.remove		= __devexit_p(alchemy_pcm_drvremove),
 };
 
-static int __init alchemy_pcmdma_load(void)
-{
-	return platform_driver_register(&alchemy_pcmdma_driver);
-}
-
-static void __exit alchemy_pcmdma_unload(void)
-{
-	platform_driver_unregister(&alchemy_pcmdma_driver);
-}
-
-module_init(alchemy_pcmdma_load);
-module_exit(alchemy_pcmdma_unload);
+module_platform_driver(alchemy_pcmdma_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au1000/Au1500/Au1100 Audio DMA driver");
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 6bcf48f..cb53ad8 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -331,18 +331,7 @@ static struct platform_driver au1xi2s_driver = {
 	.remove		= __devexit_p(au1xi2s_drvremove),
 };
 
-static int __init au1xi2s_load(void)
-{
-	return platform_driver_register(&au1xi2s_driver);
-}
-
-static void __exit au1xi2s_unload(void)
-{
-	platform_driver_unregister(&au1xi2s_driver);
-}
-
-module_init(au1xi2s_load);
-module_exit(au1xi2s_unload);
+module_platform_driver(au1xi2s_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au1000/1500/1100 I2S ASoC driver");
diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index f7714d5..5c1dc8a 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -435,18 +435,7 @@ static struct platform_driver au1xpsc_i2s_driver = {
 	.remove		= __devexit_p(au1xpsc_i2s_drvremove),
 };
 
-static int __init au1xpsc_i2s_load(void)
-{
-	return platform_driver_register(&au1xpsc_i2s_driver);
-}
-
-static void __exit au1xpsc_i2s_unload(void)
-{
-	platform_driver_unregister(&au1xpsc_i2s_driver);
-}
-
-module_init(au1xpsc_i2s_load);
-module_exit(au1xpsc_i2s_unload);
+module_platform_driver(au1xpsc_i2s_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Au12x0/Au1550 PSC I2S ALSA ASoC audio driver");
-- 
1.7.5.4
