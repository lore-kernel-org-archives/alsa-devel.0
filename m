From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Convert mips directory to
	module_platform_driver
Date: Thu, 24 Nov 2011 10:22:50 +0800
Message-ID: <1322101370.16201.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 303A7103B1C
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 03:22:57 +0100 (CET)
Received: by ywp27 with SMTP id 27so2157079ywp.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 18:22:56 -0800 (PST)
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
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Factor out some boilerplate code.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/mips/hal2.c       |   13 +------------
 sound/mips/sgio2audio.c |   13 +------------
 2 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/sound/mips/hal2.c b/sound/mips/hal2.c
index 2e6c858..5f88d1f 100644
--- a/sound/mips/hal2.c
+++ b/sound/mips/hal2.c
@@ -935,15 +935,4 @@ static struct platform_driver hal2_driver = {
 	}
 };
 
-static int __init alsa_card_hal2_init(void)
-{
-	return platform_driver_register(&hal2_driver);
-}
-
-static void __exit alsa_card_hal2_exit(void)
-{
-	platform_driver_unregister(&hal2_driver);
-}
-
-module_init(alsa_card_hal2_init);
-module_exit(alsa_card_hal2_exit);
+module_platform_driver(hal2_driver);
diff --git a/sound/mips/sgio2audio.c b/sound/mips/sgio2audio.c
index 69425d4..ceaa593 100644
--- a/sound/mips/sgio2audio.c
+++ b/sound/mips/sgio2audio.c
@@ -976,15 +976,4 @@ static struct platform_driver sgio2audio_driver = {
 	}
 };
 
-static int __init alsa_card_sgio2audio_init(void)
-{
-	return platform_driver_register(&sgio2audio_driver);
-}
-
-static void __exit alsa_card_sgio2audio_exit(void)
-{
-	platform_driver_unregister(&sgio2audio_driver);
-}
-
-module_init(alsa_card_sgio2audio_init)
-module_exit(alsa_card_sgio2audio_exit)
+module_platform_driver(sgio2audio_driver);
-- 
1.7.5.4
