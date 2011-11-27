From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ALSA: convert sound/* to use
	module_platform_driver()
Date: Sun, 27 Nov 2011 16:36:04 +0800
Message-ID: <1322382964.2677.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 84E3C2488F
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 09:36:18 +0100 (CET)
Received: by iafi7 with SMTP id i7so7612001iaf.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 00:36:16 -0800 (PST)
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
Cc: Habets <mhabets@users.sourceforge.net>, Joachim Foerster <JOFT@gmx.de>, Takashi Iwai <tiwai@suse.de>, Martin@alsa-project.org, "David S. Miller" <davem@davemloft.net>, Rafael Ignacio Zurita <rizurita@yahoo.com>
List-Id: alsa-devel@alsa-project.org

This patch converts the drivers in sound/* to use the
module_platform_driver() macro which makes the code smaller and a bit
simpler.

Cc: Joachim Foerster <JOFT@gmx.de>
Cc: Rafael Ignacio Zurita <rizurita@yahoo.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Martin Habets <mhabets@users.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/arm/pxa2xx-ac97.c      |   13 +------------
 sound/drivers/ml403-ac97cr.c |   13 +------------
 sound/sh/sh_dac_audio.c      |   13 +------------
 sound/sparc/cs4231.c         |   13 +------------
 sound/sparc/dbri.c           |   14 +-------------
 5 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 5d94118..3a39626 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -251,18 +251,7 @@ static struct platform_driver pxa2xx_ac97_driver = {
 	},
 };
 
-static int __init pxa2xx_ac97_init(void)
-{
-	return platform_driver_register(&pxa2xx_ac97_driver);
-}
-
-static void __exit pxa2xx_ac97_exit(void)
-{
-	platform_driver_unregister(&pxa2xx_ac97_driver);
-}
-
-module_init(pxa2xx_ac97_init);
-module_exit(pxa2xx_ac97_exit);
+module_platform_driver(pxa2xx_ac97_driver);
 
 MODULE_AUTHOR("Nicolas Pitre");
 MODULE_DESCRIPTION("AC97 driver for the Intel PXA2xx chip");
diff --git a/sound/drivers/ml403-ac97cr.c b/sound/drivers/ml403-ac97cr.c
index 2ee82c5..07ede97 100644
--- a/sound/drivers/ml403-ac97cr.c
+++ b/sound/drivers/ml403-ac97cr.c
@@ -1341,15 +1341,4 @@ static struct platform_driver snd_ml403_ac97cr_driver = {
 	},
 };
 
-static int __init alsa_card_ml403_ac97cr_init(void)
-{
-	return platform_driver_register(&snd_ml403_ac97cr_driver);
-}
-
-static void __exit alsa_card_ml403_ac97cr_exit(void)
-{
-	platform_driver_unregister(&snd_ml403_ac97cr_driver);
-}
-
-module_init(alsa_card_ml403_ac97cr_init)
-module_exit(alsa_card_ml403_ac97cr_exit)
+module_platform_driver(snd_ml403_ac97cr_driver);
diff --git a/sound/sh/sh_dac_audio.c b/sound/sh/sh_dac_audio.c
index 56bcb46..b11f82b 100644
--- a/sound/sh/sh_dac_audio.c
+++ b/sound/sh/sh_dac_audio.c
@@ -441,15 +441,4 @@ static struct platform_driver driver = {
 	},
 };
 
-static int __init sh_dac_init(void)
-{
-	return platform_driver_register(&driver);
-}
-
-static void __exit sh_dac_exit(void)
-{
-	platform_driver_unregister(&driver);
-}
-
-module_init(sh_dac_init);
-module_exit(sh_dac_exit);
+module_platform_driver(driver);
diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 0e618f8..9aa90e0 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -2118,15 +2118,4 @@ static struct platform_driver cs4231_driver = {
 	.remove		= __devexit_p(cs4231_remove),
 };
 
-static int __init cs4231_init(void)
-{
-	return platform_driver_register(&cs4231_driver);
-}
-
-static void __exit cs4231_exit(void)
-{
-	platform_driver_unregister(&cs4231_driver);
-}
-
-module_init(cs4231_init);
-module_exit(cs4231_exit);
+module_platform_driver(cs4231_driver);
diff --git a/sound/sparc/dbri.c b/sound/sparc/dbri.c
index 4a4f1d7..6afe087 100644
--- a/sound/sparc/dbri.c
+++ b/sound/sparc/dbri.c
@@ -2697,16 +2697,4 @@ static struct platform_driver dbri_sbus_driver = {
 	.remove		= __devexit_p(dbri_remove),
 };
 
-/* Probe for the dbri chip and then attach the driver. */
-static int __init dbri_init(void)
-{
-	return platform_driver_register(&dbri_sbus_driver);
-}
-
-static void __exit dbri_exit(void)
-{
-	platform_driver_unregister(&dbri_sbus_driver);
-}
-
-module_init(dbri_init);
-module_exit(dbri_exit);
+module_platform_driver(dbri_sbus_driver);
-- 
1.7.5.4
