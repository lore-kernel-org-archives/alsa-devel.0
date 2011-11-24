From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert mxs directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 14:21:29 +0800
Message-ID: <1322115689.19406.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F8A510381C
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 07:21:41 +0100 (CET)
Received: by ggnq2 with SMTP id q2so2341276ggn.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 22:21:39 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/mxs/mxs-pcm.c      |   12 +-----------
 sound/soc/mxs/mxs-saif.c     |   12 +-----------
 sound/soc/mxs/mxs-sgtl5000.c |   12 +-----------
 3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/sound/soc/mxs/mxs-pcm.c b/sound/soc/mxs/mxs-pcm.c
index dea5aa4..612ad3d 100644
--- a/sound/soc/mxs/mxs-pcm.c
+++ b/sound/soc/mxs/mxs-pcm.c
@@ -346,14 +346,4 @@ static struct platform_driver mxs_pcm_driver = {
 	.remove = __devexit_p(mxs_soc_platform_remove),
 };
 
-static int __init snd_mxs_pcm_init(void)
-{
-	return platform_driver_register(&mxs_pcm_driver);
-}
-module_init(snd_mxs_pcm_init);
-
-static void __exit snd_mxs_pcm_exit(void)
-{
-	platform_driver_unregister(&mxs_pcm_driver);
-}
-module_exit(snd_mxs_pcm_exit);
+module_platform_driver(mxs_pcm_driver);
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 76dc74d..ffc83761 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -781,18 +781,8 @@ static struct platform_driver mxs_saif_driver = {
 	},
 };
 
-static int __init mxs_saif_init(void)
-{
-	return platform_driver_register(&mxs_saif_driver);
-}
-
-static void __exit mxs_saif_exit(void)
-{
-	platform_driver_unregister(&mxs_saif_driver);
-}
+module_platform_driver(mxs_saif_driver);
 
-module_init(mxs_saif_init);
-module_exit(mxs_saif_exit);
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("MXS ASoC SAIF driver");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 7fbeaec..200a928 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -156,17 +156,7 @@ static struct platform_driver mxs_sgtl5000_audio_driver = {
 	.remove = __devexit_p(mxs_sgtl5000_remove),
 };
 
-static int __init mxs_sgtl5000_init(void)
-{
-	return platform_driver_register(&mxs_sgtl5000_audio_driver);
-}
-module_init(mxs_sgtl5000_init);
-
-static void __exit mxs_sgtl5000_exit(void)
-{
-	platform_driver_unregister(&mxs_sgtl5000_audio_driver);
-}
-module_exit(mxs_sgtl5000_exit);
+module_platform_driver(mxs_sgtl5000_audio_driver);
 
 MODULE_AUTHOR("Freescale Semiconductor, Inc.");
 MODULE_DESCRIPTION("MXS ALSA SoC Machine driver");
-- 
1.7.5.4
