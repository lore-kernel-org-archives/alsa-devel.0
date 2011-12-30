From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/3] ASoC: pxa: Convert poodle to use
	snd_soc_register_card()
Date: Fri, 30 Dec 2011 09:16:11 +0800
Message-ID: <1325207771.9599.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 58ED2103A89
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 02:16:24 +0100 (CET)
Received: by yenr11 with SMTP id r11so4228389yen.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 17:16:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-pxa/poodle.c |    6 ++++++
 sound/soc/pxa/poodle.c     |   42 +++++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 69036e4..744baee 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -158,6 +158,11 @@ static struct scoop_pcmcia_config poodle_pcmcia_config = {
 EXPORT_SYMBOL(poodle_scoop_device);
 
 
+static struct platform_device poodle_audio_device = {
+	.name	= "poodle-audio",
+	.id	= -1,
+};
+
 /* LoCoMo device */
 static struct resource locomo_resources[] = {
 	[0] = {
@@ -407,6 +412,7 @@ static struct platform_device sharpsl_rom_device = {
 static struct platform_device *devices[] __initdata = {
 	&poodle_locomo_device,
 	&poodle_scoop_device,
+	&poodle_audio_device,
 	&sharpsl_nand_device,
 	&sharpsl_rom_device,
 };
diff --git a/sound/soc/pxa/poodle.c b/sound/soc/pxa/poodle.c
index 4c29bc1..c9e24bf 100644
--- a/sound/soc/pxa/poodle.c
+++ b/sound/soc/pxa/poodle.c
@@ -281,22 +281,18 @@ static struct snd_soc_dai_link poodle_dai = {
 };
 
 /* poodle audio machine driver */
-static struct snd_soc_card snd_soc_poodle = {
+static struct snd_soc_card poodle = {
 	.name = "Poodle",
 	.dai_link = &poodle_dai,
 	.num_links = 1,
 	.owner = THIS_MODULE,
 };
 
-static struct platform_device *poodle_snd_device;
-
-static int __init poodle_init(void)
+static int __devinit poodle_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &poodle;
 	int ret;
 
-	if (!machine_is_poodle())
-		return -ENODEV;
-
 	locomo_gpio_set_dir(&poodle_locomo_device.dev,
 		POODLE_LOCOMO_GPIO_AMP_ON, 0);
 	/* should we mute HP at startup - burning power ?*/
@@ -305,28 +301,36 @@ static int __init poodle_init(void)
 	locomo_gpio_set_dir(&poodle_locomo_device.dev,
 		POODLE_LOCOMO_GPIO_MUTE_R, 0);
 
-	poodle_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!poodle_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(poodle_snd_device, &snd_soc_poodle);
-	ret = platform_device_add(poodle_snd_device);
+	card->dev = &pdev->dev;
 
+	ret = snd_soc_register_card(card);
 	if (ret)
-		platform_device_put(poodle_snd_device);
-
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
 	return ret;
 }
 
-static void __exit poodle_exit(void)
+static int __devexit poodle_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(poodle_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(poodle_init);
-module_exit(poodle_exit);
+static struct platform_driver poodle_driver = {
+	.driver		= {
+		.name	= "poodle-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= poodle_probe,
+	.remove		= __devexit_p(poodle_remove),
+};
+
+module_platform_driver(poodle_driver);
 
 /* Module information */
 MODULE_AUTHOR("Richard Purdie");
 MODULE_DESCRIPTION("ALSA SoC Poodle");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:poodle-audio");
-- 
1.7.5.4
