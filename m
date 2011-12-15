From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 5/5] ASoC: pxa: Convert tosa to use
	snd_soc_register_card()
Date: Thu, 15 Dec 2011 10:57:22 +0800
Message-ID: <1323917842.28019.7.camel@phoenix>
References: <1323917478.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E03A1038EB
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 03:57:35 +0100 (CET)
Received: by vcbf13 with SMTP id f13so172124vcb.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 18:57:34 -0800 (PST)
In-Reply-To: <1323917478.28019.1.camel@phoenix>
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
Cc: Ian Molton <spyro@f2s.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-pxa/tosa.c |    6 +++
 sound/soc/pxa/tosa.c     |   77 ++++++++++++++++++----------------------------
 2 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/arch/arm/mach-pxa/tosa.c b/arch/arm/mach-pxa/tosa.c
index 7ce5c43..4d4eb60 100644
--- a/arch/arm/mach-pxa/tosa.c
+++ b/arch/arm/mach-pxa/tosa.c
@@ -889,6 +889,11 @@ static struct platform_device wm9712_device = {
 	.id	= -1,
 };
 
+static struct platform_device tosa_audio_device = {
+	.name	= "tosa-audio",
+	.id	= -1,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&tosascoop_device,
 	&tosascoop_jc_device,
@@ -901,6 +906,7 @@ static struct platform_device *devices[] __initdata = {
 	&sharpsl_rom_device,
 	&wm9712_device,
 	&tosa_gpio_vbus,
+	&tosa_audio_device,
 };
 
 static void tosa_poweroff(void)
diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index 620fc69..3f394de 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -34,8 +34,6 @@
 #include "../codecs/wm9712.h"
 #include "pxa2xx-ac97.h"
 
-static struct snd_soc_card tosa;
-
 #define TOSA_HP        0
 #define TOSA_MIC_INT   1
 #define TOSA_HEADSET   2
@@ -236,70 +234,55 @@ static struct snd_soc_dai_link tosa_dai[] = {
 },
 };
 
-static int tosa_probe(struct snd_soc_card *card)
-{
-	int ret;
-
-	ret = gpio_request(TOSA_GPIO_L_MUTE, "Headphone Jack");
-	if (ret)
-		return ret;
-	ret = gpio_direction_output(TOSA_GPIO_L_MUTE, 0);
-	if (ret)
-		gpio_free(TOSA_GPIO_L_MUTE);
-
-	return ret;
-}
-
-static int tosa_remove(struct snd_soc_card *card)
-{
-	gpio_free(TOSA_GPIO_L_MUTE);
-	return 0;
-}
-
 static struct snd_soc_card tosa = {
 	.name = "Tosa",
 	.dai_link = tosa_dai,
 	.num_links = ARRAY_SIZE(tosa_dai),
-	.probe = tosa_probe,
-	.remove = tosa_remove,
 };
 
-static struct platform_device *tosa_snd_device;
-
-static int __init tosa_init(void)
+static int __devinit tosa_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &tosa;
 	int ret;
 
-	if (!machine_is_tosa())
-		return -ENODEV;
-
-	tosa_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!tosa_snd_device) {
-		ret = -ENOMEM;
-		goto err_alloc;
-	}
-
-	platform_set_drvdata(tosa_snd_device, &tosa);
-	ret = platform_device_add(tosa_snd_device);
-
-	if (!ret)
-		return 0;
+	ret = gpio_request_one(TOSA_GPIO_L_MUTE, GPIOF_OUT_INIT_LOW,
+			       "Headphone Jack");
+	if (ret)
+		return ret;
 
-	platform_device_put(tosa_snd_device);
+	card->dev = &pdev->dev;
 
-err_alloc:
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		gpio_free(TOSA_GPIO_L_MUTE);
+	}
 	return ret;
 }
 
-static void __exit tosa_exit(void)
+static int __devexit tosa_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(tosa_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	gpio_free(TOSA_GPIO_L_MUTE);
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(tosa_init);
-module_exit(tosa_exit);
+static struct platform_driver tosa_driver = {
+	.driver		= {
+		.name	= "tosa-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= tosa_probe,
+	.remove		= __devexit_p(tosa_remove),
+};
+
+module_platform_driver(tosa_driver);
 
 /* Module information */
 MODULE_AUTHOR("Richard Purdie");
 MODULE_DESCRIPTION("ALSA SoC Tosa");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tosa-audio");
-- 
1.7.5.4
