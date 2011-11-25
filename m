From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/8] ASoC: Convert omap directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:12:16 +0800
Message-ID: <1322187136.8878.8.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 612B8103BC3
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:12:23 +0100 (CET)
Received: by ghbg15 with SMTP id g15so2072618ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:12:22 -0800 (PST)
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
Cc: Jorge Candelaria <jorge.candelaria@ti.com>, Ricardo Neri <ricardo.neri@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lopez Cruz <misael.lopez@ti.com>, Misael@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/omap/omap-hdmi.c       |   12 +-----------
 sound/soc/omap/omap-mcbsp.c      |   12 +-----------
 sound/soc/omap/omap-mcpdm.c      |   12 +-----------
 sound/soc/omap/omap-pcm.c        |   12 +-----------
 sound/soc/omap/omap4-hdmi-card.c |   12 +-----------
 5 files changed, 5 insertions(+), 55 deletions(-)

diff --git a/sound/soc/omap/omap-hdmi.c b/sound/soc/omap/omap-hdmi.c
index 9bb1cf8..38e0def 100644
--- a/sound/soc/omap/omap-hdmi.c
+++ b/sound/soc/omap/omap-hdmi.c
@@ -139,17 +139,7 @@ static struct platform_driver hdmi_dai_driver = {
 	.remove = __devexit_p(omap_hdmi_remove),
 };
 
-static int __init hdmi_dai_init(void)
-{
-	return platform_driver_register(&hdmi_dai_driver);
-}
-module_init(hdmi_dai_init);
-
-static void __exit hdmi_dai_exit(void)
-{
-	platform_driver_unregister(&hdmi_dai_driver);
-}
-module_exit(hdmi_dai_exit);
+module_platform_driver(hdmi_dai_driver);
 
 MODULE_AUTHOR("Jorge Candelaria <jorge.candelaria@ti.com>");
 MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d91e6ef..bd11d25 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -785,17 +785,7 @@ static struct platform_driver asoc_mcbsp_driver = {
 	.remove = __devexit_p(asoc_mcbsp_remove),
 };
 
-static int __init snd_omap_mcbsp_init(void)
-{
-	return platform_driver_register(&asoc_mcbsp_driver);
-}
-module_init(snd_omap_mcbsp_init);
-
-static void __exit snd_omap_mcbsp_exit(void)
-{
-	platform_driver_unregister(&asoc_mcbsp_driver);
-}
-module_exit(snd_omap_mcbsp_exit);
+module_platform_driver(asoc_mcbsp_driver);
 
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP I2S SoC Interface");
diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index cc8ceff..b50ac60 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -520,17 +520,7 @@ static struct platform_driver asoc_mcpdm_driver = {
 	.remove	= __devexit_p(asoc_mcpdm_remove),
 };
 
-static int __init snd_omap_mcpdm_init(void)
-{
-	return platform_driver_register(&asoc_mcpdm_driver);
-}
-module_init(snd_omap_mcpdm_init);
-
-static void __exit snd_omap_mcpdm_exit(void)
-{
-	platform_driver_unregister(&asoc_mcpdm_driver);
-}
-module_exit(snd_omap_mcpdm_exit);
+module_platform_driver(asoc_mcpdm_driver);
 
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_DESCRIPTION("OMAP PDM SoC Interface");
diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
index 6ede7dc..52a0f63 100644
--- a/sound/soc/omap/omap-pcm.c
+++ b/sound/soc/omap/omap-pcm.c
@@ -433,17 +433,7 @@ static struct platform_driver omap_pcm_driver = {
 	.remove = __devexit_p(omap_pcm_remove),
 };
 
-static int __init snd_omap_pcm_init(void)
-{
-	return platform_driver_register(&omap_pcm_driver);
-}
-module_init(snd_omap_pcm_init);
-
-static void __exit snd_omap_pcm_exit(void)
-{
-	platform_driver_unregister(&omap_pcm_driver);
-}
-module_exit(snd_omap_pcm_exit);
+module_platform_driver(omap_pcm_driver);
 
 MODULE_AUTHOR("Jarkko Nikula <jarkko.nikula@bitmer.com>");
 MODULE_DESCRIPTION("OMAP PCM DMA module");
diff --git a/sound/soc/omap/omap4-hdmi-card.c b/sound/soc/omap/omap4-hdmi-card.c
index 8671261..52d471c 100644
--- a/sound/soc/omap/omap4-hdmi-card.c
+++ b/sound/soc/omap/omap4-hdmi-card.c
@@ -112,17 +112,7 @@ static struct platform_driver omap4_hdmi_driver = {
 	.remove = __devexit_p(omap4_hdmi_remove),
 };
 
-static int __init omap4_hdmi_init(void)
-{
-	return platform_driver_register(&omap4_hdmi_driver);
-}
-module_init(omap4_hdmi_init);
-
-static void __exit omap4_hdmi_exit(void)
-{
-	platform_driver_unregister(&omap4_hdmi_driver);
-}
-module_exit(omap4_hdmi_exit);
+module_platform_driver(omap4_hdmi_driver);
 
 MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
 MODULE_DESCRIPTION("OMAP4 HDMI machine ASoC driver");
-- 
1.7.5.4
