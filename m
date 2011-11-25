From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 6/8] ASoC: Convert pxa directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:13:37 +0800
Message-ID: <1322187217.8878.10.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BEA5C103E4A
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:13:44 +0100 (CET)
Received: by yws1 with SMTP id 1so124448yws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:13:44 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Marek Vasut <marek.vasut@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Liam@alsa-project.org, Robert Jarzmik <robert.jarzmik@free.fr>, Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/hx4700.c         |   13 +------------
 sound/soc/pxa/mioa701_wm9713.c |   13 +------------
 sound/soc/pxa/palm27x.c        |   13 +------------
 sound/soc/pxa/pxa-ssp.c        |   12 +-----------
 sound/soc/pxa/pxa2xx-ac97.c    |   12 +-----------
 sound/soc/pxa/pxa2xx-pcm.c     |   12 +-----------
 6 files changed, 6 insertions(+), 69 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 65c1248..e32afaf 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -236,18 +236,7 @@ static struct platform_driver hx4700_audio_driver = {
 	.remove	= __devexit_p(hx4700_audio_remove),
 };
 
-static int __init hx4700_modinit(void)
-{
-	return platform_driver_register(&hx4700_audio_driver);
-}
-module_init(hx4700_modinit);
-
-static void __exit hx4700_modexit(void)
-{
-	platform_driver_unregister(&hx4700_audio_driver);
-}
-
-module_exit(hx4700_modexit);
+module_platform_driver(hx4700_audio_driver);
 
 MODULE_AUTHOR("Philipp Zabel");
 MODULE_DESCRIPTION("ALSA SoC iPAQ hx4700");
diff --git a/sound/soc/pxa/mioa701_wm9713.c b/sound/soc/pxa/mioa701_wm9713.c
index 0b8d1ee..0e73a7f 100644
--- a/sound/soc/pxa/mioa701_wm9713.c
+++ b/sound/soc/pxa/mioa701_wm9713.c
@@ -227,18 +227,7 @@ static struct platform_driver mioa701_wm9713_driver = {
 	},
 };
 
-static int __init mioa701_asoc_init(void)
-{
-	return platform_driver_register(&mioa701_wm9713_driver);
-}
-
-static void __exit mioa701_asoc_exit(void)
-{
-	platform_driver_unregister(&mioa701_wm9713_driver);
-}
-
-module_init(mioa701_asoc_init);
-module_exit(mioa701_asoc_exit);
+module_platform_driver(mioa701_wm9713_driver);
 
 /* Module information */
 MODULE_AUTHOR("Robert Jarzmik (rjarzmik@free.fr)");
diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 7edc1fb..f313eca 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -201,18 +201,7 @@ static struct platform_driver palm27x_wm9712_driver = {
 	},
 };
 
-static int __init palm27x_asoc_init(void)
-{
-	return platform_driver_register(&palm27x_wm9712_driver);
-}
-
-static void __exit palm27x_asoc_exit(void)
-{
-	platform_driver_unregister(&palm27x_wm9712_driver);
-}
-
-module_init(palm27x_asoc_init);
-module_exit(palm27x_asoc_exit);
+module_platform_driver(palm27x_wm9712_driver);
 
 /* Module information */
 MODULE_AUTHOR("Marek Vasut <marek.vasut@gmail.com>");
diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 9c9a51e..a57cfbc 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -825,17 +825,7 @@ static struct platform_driver asoc_ssp_driver = {
 	.remove = __devexit_p(asoc_ssp_remove),
 };
 
-static int __init pxa_ssp_init(void)
-{
-	return platform_driver_register(&asoc_ssp_driver);
-}
-module_init(pxa_ssp_init);
-
-static void __exit pxa_ssp_exit(void)
-{
-	platform_driver_unregister(&asoc_ssp_driver);
-}
-module_exit(pxa_ssp_exit);
+module_platform_driver(asoc_ssp_driver);
 
 /* Module information */
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
diff --git a/sound/soc/pxa/pxa2xx-ac97.c b/sound/soc/pxa/pxa2xx-ac97.c
index 3fec2f3..837ff34 100644
--- a/sound/soc/pxa/pxa2xx-ac97.c
+++ b/sound/soc/pxa/pxa2xx-ac97.c
@@ -263,17 +263,7 @@ static struct platform_driver pxa2xx_ac97_driver = {
 	},
 };
 
-static int __init pxa_ac97_init(void)
-{
-	return platform_driver_register(&pxa2xx_ac97_driver);
-}
-module_init(pxa_ac97_init);
-
-static void __exit pxa_ac97_exit(void)
-{
-	platform_driver_unregister(&pxa2xx_ac97_driver);
-}
-module_exit(pxa_ac97_exit);
+module_platform_driver(pxa2xx_ac97_driver);
 
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("AC97 driver for the Intel PXA2xx chip");
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 600676f..fdd6bed 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -141,17 +141,7 @@ static struct platform_driver pxa_pcm_driver = {
 	.remove = __devexit_p(pxa2xx_soc_platform_remove),
 };
 
-static int __init snd_pxa_pcm_init(void)
-{
-	return platform_driver_register(&pxa_pcm_driver);
-}
-module_init(snd_pxa_pcm_init);
-
-static void __exit snd_pxa_pcm_exit(void)
-{
-	platform_driver_unregister(&pxa_pcm_driver);
-}
-module_exit(snd_pxa_pcm_exit);
+module_platform_driver(pxa_pcm_driver);
 
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("Intel PXA2xx PCM DMA module");
-- 
1.7.5.4
