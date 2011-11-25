From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 8/8] ASoC: Convert txx9 directory to
	module_platform_driver
Date: Fri, 25 Nov 2011 10:16:10 +0800
Message-ID: <1322187370.8878.13.camel@phoenix>
References: <1322186745.8878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C59E4103EA9
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 03:16:16 +0100 (CET)
Received: by yenm6 with SMTP id m6so917958yen.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 18:16:16 -0800 (PST)
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
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/txx9/txx9aclc-ac97.c |   13 +------------
 sound/soc/txx9/txx9aclc.c      |   12 +-----------
 2 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc-ac97.c b/sound/soc/txx9/txx9aclc-ac97.c
index a4e3f55..28db4ca 100644
--- a/sound/soc/txx9/txx9aclc-ac97.c
+++ b/sound/soc/txx9/txx9aclc-ac97.c
@@ -223,18 +223,7 @@ static struct platform_driver txx9aclc_ac97_driver = {
 	},
 };
 
-static int __init txx9aclc_ac97_init(void)
-{
-	return platform_driver_register(&txx9aclc_ac97_driver);
-}
-
-static void __exit txx9aclc_ac97_exit(void)
-{
-	platform_driver_unregister(&txx9aclc_ac97_driver);
-}
-
-module_init(txx9aclc_ac97_init);
-module_exit(txx9aclc_ac97_exit);
+module_platform_driver(txx9aclc_ac97_driver);
 
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("TXx9 ACLC AC97 driver");
diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 602bb68..2155461 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -438,17 +438,7 @@ static struct platform_driver txx9aclc_pcm_driver = {
 	.remove = __devexit_p(txx9aclc_soc_platform_remove),
 };
 
-static int __init snd_txx9aclc_pcm_init(void)
-{
-	return platform_driver_register(&txx9aclc_pcm_driver);
-}
-module_init(snd_txx9aclc_pcm_init);
-
-static void __exit snd_txx9aclc_pcm_exit(void)
-{
-	platform_driver_unregister(&txx9aclc_pcm_driver);
-}
-module_exit(snd_txx9aclc_pcm_exit);
+module_platform_driver(txx9aclc_pcm_driver);
 
 MODULE_AUTHOR("Atsushi Nemoto <anemo@mba.ocn.ne.jp>");
 MODULE_DESCRIPTION("TXx9 ACLC Audio DMA driver");
-- 
1.7.5.4
