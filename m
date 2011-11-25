From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 7/8] ASoC: Convert sh directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:15:07 +0800
Message-ID: <1322187307.8878.12.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C4EE103EA8
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:15:14 +0100 (CET)
Received: by ghbg15 with SMTP id g15so2074013ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:15:13 -0800 (PST)
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
Cc: Carlos Munoz <carlos@kenati.com>, Manuel Lauss <mano@roarinelk.homelinux.net>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Liam@alsa-project.org, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/sh/dma-sh7760.c |   12 +-----------
 sound/soc/sh/fsi-ak4642.c |   13 +------------
 sound/soc/sh/fsi-hdmi.c   |   13 +------------
 sound/soc/sh/fsi.c        |   13 +------------
 sound/soc/sh/hac.c        |   12 +-----------
 sound/soc/sh/siu_dai.c    |   13 +------------
 sound/soc/sh/ssi.c        |   12 +-----------
 7 files changed, 7 insertions(+), 81 deletions(-)

diff --git a/sound/soc/sh/dma-sh7760.c b/sound/soc/sh/dma-sh7760.c
index db74005..7da2018 100644
--- a/sound/soc/sh/dma-sh7760.c
+++ b/sound/soc/sh/dma-sh7760.c
@@ -369,17 +369,7 @@ static struct platform_driver sh7760_pcm_driver = {
 	.remove = __devexit_p(sh7760_soc_platform_remove),
 };
 
-static int __init snd_sh7760_pcm_init(void)
-{
-	return platform_driver_register(&sh7760_pcm_driver);
-}
-module_init(snd_sh7760_pcm_init);
-
-static void __exit snd_sh7760_pcm_exit(void)
-{
-	platform_driver_unregister(&sh7760_pcm_driver);
-}
-module_exit(snd_sh7760_pcm_exit);
+module_platform_driver(sh7760_pcm_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SH7760 Audio DMA (DMABRG) driver");
diff --git a/sound/soc/sh/fsi-ak4642.c b/sound/soc/sh/fsi-ak4642.c
index dff64b9..d81de3d 100644
--- a/sound/soc/sh/fsi-ak4642.c
+++ b/sound/soc/sh/fsi-ak4642.c
@@ -192,18 +192,7 @@ static struct platform_driver fsi_ak4642 = {
 	.id_table	= fsi_id_table,
 };
 
-static int __init fsi_ak4642_init(void)
-{
-	return platform_driver_register(&fsi_ak4642);
-}
-
-static void __exit fsi_ak4642_exit(void)
-{
-	platform_driver_unregister(&fsi_ak4642);
-}
-
-module_init(fsi_ak4642_init);
-module_exit(fsi_ak4642_exit);
+module_platform_driver(fsi_ak4642);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic SH4 FSI-AK4642 sound card");
diff --git a/sound/soc/sh/fsi-hdmi.c b/sound/soc/sh/fsi-hdmi.c
index 3ebebe7..621aea1 100644
--- a/sound/soc/sh/fsi-hdmi.c
+++ b/sound/soc/sh/fsi-hdmi.c
@@ -110,18 +110,7 @@ static struct platform_driver fsi_hdmi = {
 	.id_table	= fsi_id_table,
 };
 
-static int __init fsi_hdmi_init(void)
-{
-	return platform_driver_register(&fsi_hdmi);
-}
-
-static void __exit fsi_hdmi_exit(void)
-{
-	platform_driver_unregister(&fsi_hdmi);
-}
-
-module_init(fsi_hdmi_init);
-module_exit(fsi_hdmi_exit);
+module_platform_driver(fsi_hdmi);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic SH4 FSI-HDMI sound card");
diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index aa30330..a27c306 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1468,18 +1468,7 @@ static struct platform_driver fsi_driver = {
 	.id_table	= fsi_id_table,
 };
 
-static int __init fsi_mobile_init(void)
-{
-	return platform_driver_register(&fsi_driver);
-}
-
-static void __exit fsi_mobile_exit(void)
-{
-	platform_driver_unregister(&fsi_driver);
-}
-
-module_init(fsi_mobile_init);
-module_exit(fsi_mobile_exit);
+module_platform_driver(fsi_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip FSI audio driver");
diff --git a/sound/soc/sh/hac.c b/sound/soc/sh/hac.c
index a1f307b..3474d7b 100644
--- a/sound/soc/sh/hac.c
+++ b/sound/soc/sh/hac.c
@@ -332,17 +332,7 @@ static struct platform_driver hac_pcm_driver = {
 	.remove = __devexit_p(hac_soc_platform_remove),
 };
 
-static int __init sh4_hac_pcm_init(void)
-{
-	return platform_driver_register(&hac_pcm_driver);
-}
-module_init(sh4_hac_pcm_init);
-
-static void __exit sh4_hac_pcm_exit(void)
-{
-	platform_driver_unregister(&hac_pcm_driver);
-}
-module_exit(sh4_hac_pcm_exit);
+module_platform_driver(hac_pcm_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip HAC (AC97) audio driver");
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 93dea49..11c6085 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -852,18 +852,7 @@ static struct platform_driver siu_driver = {
 	.remove		= __devexit_p(siu_remove),
 };
 
-static int __init siu_init(void)
-{
-	return platform_driver_register(&siu_driver);
-}
-
-static void __exit siu_exit(void)
-{
-	platform_driver_unregister(&siu_driver);
-}
-
-module_init(siu_init)
-module_exit(siu_exit)
+module_platform_driver(siu_driver);
 
 MODULE_AUTHOR("Carlos Munoz <carlos@kenati.com>");
 MODULE_DESCRIPTION("ALSA SoC SH7722 SIU driver");
diff --git a/sound/soc/sh/ssi.c b/sound/soc/sh/ssi.c
index 1fda16a..ff82b56 100644
--- a/sound/soc/sh/ssi.c
+++ b/sound/soc/sh/ssi.c
@@ -401,17 +401,7 @@ static struct platform_driver sh4_ssi_driver = {
 	.remove = __devexit_p(sh4_soc_dai_remove),
 };
 
-static int __init snd_sh4_ssi_init(void)
-{
-	return platform_driver_register(&sh4_ssi_driver);
-}
-module_init(snd_sh4_ssi_init);
-
-static void __exit snd_sh4_ssi_exit(void)
-{
-	platform_driver_unregister(&sh4_ssi_driver);
-}
-module_exit(snd_sh4_ssi_exit);
+module_platform_driver(sh4_ssi_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SuperH onchip SSI (I2S) audio driver");
-- 
1.7.5.4
