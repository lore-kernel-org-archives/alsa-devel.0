From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/8] ASoC: Convert davinci directory to
 module_platform_driver
Date: Fri, 25 Nov 2011 10:09:27 +0800
Message-ID: <1322186967.8878.4.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD9E103B5B
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:09:34 +0100 (CET)
Received: by yws1 with SMTP id 1so122370yws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:09:34 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Steve Chen <schen@mvista.com>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/davinci/davinci-i2s.c   |   12 +-----------
 sound/soc/davinci/davinci-mcasp.c |   12 +-----------
 sound/soc/davinci/davinci-pcm.c   |   12 +-----------
 sound/soc/davinci/davinci-vcif.c  |   12 +-----------
 4 files changed, 4 insertions(+), 44 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index f3d5ae1..ec18710 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -774,17 +774,7 @@ static struct platform_driver davinci_mcbsp_driver = {
 	},
 };
 
-static int __init davinci_i2s_init(void)
-{
-	return platform_driver_register(&davinci_mcbsp_driver);
-}
-module_init(davinci_i2s_init);
-
-static void __exit davinci_i2s_exit(void)
-{
-	platform_driver_unregister(&davinci_mcbsp_driver);
-}
-module_exit(davinci_i2s_exit);
+module_platform_driver(davinci_mcbsp_driver);
 
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI I2S (McBSP) SoC Interface");
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 03cea9d..2152ff5 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -991,17 +991,7 @@ static struct platform_driver davinci_mcasp_driver = {
 	},
 };
 
-static int __init davinci_mcasp_init(void)
-{
-	return platform_driver_register(&davinci_mcasp_driver);
-}
-module_init(davinci_mcasp_init);
-
-static void __exit davinci_mcasp_exit(void)
-{
-	platform_driver_unregister(&davinci_mcasp_driver);
-}
-module_exit(davinci_mcasp_exit);
+module_platform_driver(davinci_mcasp_driver);
 
 MODULE_AUTHOR("Steve Chen");
 MODULE_DESCRIPTION("TI DAVINCI McASP SoC Interface");
diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index d5fe08c..65bff3d 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -886,17 +886,7 @@ static struct platform_driver davinci_pcm_driver = {
 	.remove = __devexit_p(davinci_soc_platform_remove),
 };
 
-static int __init snd_davinci_pcm_init(void)
-{
-	return platform_driver_register(&davinci_pcm_driver);
-}
-module_init(snd_davinci_pcm_init);
-
-static void __exit snd_davinci_pcm_exit(void)
-{
-	platform_driver_unregister(&davinci_pcm_driver);
-}
-module_exit(snd_davinci_pcm_exit);
+module_platform_driver(davinci_pcm_driver);
 
 MODULE_AUTHOR("Vladimir Barinov");
 MODULE_DESCRIPTION("TI DAVINCI PCM DMA module");
diff --git a/sound/soc/davinci/davinci-vcif.c b/sound/soc/davinci/davinci-vcif.c
index dae96b8..70ce10c 100644
--- a/sound/soc/davinci/davinci-vcif.c
+++ b/sound/soc/davinci/davinci-vcif.c
@@ -265,17 +265,7 @@ static struct platform_driver davinci_vcif_driver = {
 	},
 };
 
-static int __init davinci_vcif_init(void)
-{
-	return platform_driver_probe(&davinci_vcif_driver, davinci_vcif_probe);
-}
-module_init(davinci_vcif_init);
-
-static void __exit davinci_vcif_exit(void)
-{
-	platform_driver_unregister(&davinci_vcif_driver);
-}
-module_exit(davinci_vcif_exit);
+module_platform_driver(davinci_vcif_driver);
 
 MODULE_AUTHOR("Miguel Aguilar");
 MODULE_DESCRIPTION("Texas Instruments DaVinci ASoC Voice Codec Interface");
-- 
1.7.5.4
