From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH v2] ASoC: jz4740: Convert qi_lb60 to use
 snd_soc_register_card()
Date: Mon, 26 Dec 2011 12:30:02 +0800
Message-ID: <1324873802.23831.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B64B24498
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 05:30:16 +0100 (CET)
Received: by yenr11 with SMTP id r11so2995214yen.38
	for <alsa-devel@alsa-project.org>; Sun, 25 Dec 2011 20:30:14 -0800 (PST)
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>, Ralf Baechle <ralf@linux-mips.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Use snd_soc_register_card() instead of creating a "soc-audio" platform device.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
v2: fix a typo in v1. 
Only compile tested, I appreciate if someone can test it.

 arch/mips/jz4740/board-qi_lb60.c |    6 ++++
 sound/soc/jz4740/qi_lb60.c       |   56 +++++++++++++++++--------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
index 639e3ce..9a91fe9 100644
--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -418,6 +418,11 @@ static struct platform_device qi_lb60_charger_device = {
 	},
 };
 
+/* audio */
+static struct platform_device qi_lb60_audio_device = {
+	.name = "qi-lb60-audio",
+	.id = -1,
+};
 
 static struct platform_device *jz_platform_devices[] __initdata = {
 	&jz4740_udc_device,
@@ -434,6 +439,7 @@ static struct platform_device *jz_platform_devices[] __initdata = {
 	&qi_lb60_gpio_keys,
 	&qi_lb60_pwm_beeper,
 	&qi_lb60_charger_device,
+	&qi_lb60_audio_device,
 };
 
 static void __init board_gpio_setup(void)
diff --git a/sound/soc/jz4740/qi_lb60.c b/sound/soc/jz4740/qi_lb60.c
index 0097c3b..b29aa55 100644
--- a/sound/soc/jz4740/qi_lb60.c
+++ b/sound/soc/jz4740/qi_lb60.c
@@ -91,56 +91,52 @@ static struct snd_soc_card qi_lb60 = {
 	.num_dapm_routes = ARRAY_SIZE(qi_lb60_routes),
 };
 
-static struct platform_device *qi_lb60_snd_device;
-
 static const struct gpio qi_lb60_gpios[] = {
 	{ QI_LB60_SND_GPIO, GPIOF_OUT_INIT_LOW, "SND" },
 	{ QI_LB60_AMP_GPIO, GPIOF_OUT_INIT_LOW, "AMP" },
 };
 
-static int __init qi_lb60_init(void)
+static int __devinit qi_lb60_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &qi_lb60;
 	int ret;
 
-	qi_lb60_snd_device = platform_device_alloc("soc-audio", -1);
-
-	if (!qi_lb60_snd_device)
-		return -ENOMEM;
-
 	ret = gpio_request_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
-	if (ret) {
-		pr_err("qi_lb60 snd: Failed to request gpios: %d\n", ret);
-		goto err_device_put;
-	}
+	if (ret)
+		return ret;
 
-	platform_set_drvdata(qi_lb60_snd_device, &qi_lb60);
+	card->dev = &pdev->dev;
 
-	ret = platform_device_add(qi_lb60_snd_device);
+	ret = snd_soc_register_card(card);
 	if (ret) {
-		pr_err("qi_lb60 snd: Failed to add snd soc device: %d\n", ret);
-		goto err_unset_pdata;
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
 	}
-
-	 return 0;
-
-err_unset_pdata:
-	platform_set_drvdata(qi_lb60_snd_device, NULL);
-/*err_gpio_free_array:*/
-	gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
-err_device_put:
-	platform_device_put(qi_lb60_snd_device);
-
 	return ret;
 }
-module_init(qi_lb60_init);
 
-static void __exit qi_lb60_exit(void)
+static int __devexit qi_lb60_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(qi_lb60_snd_device);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
 	gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
+	snd_soc_unregister_card(card);
+	return 0;
 }
-module_exit(qi_lb60_exit);
+
+static struct platform_driver qi_lb60_driver = {
+	.driver		= {
+		.name	= "qi-lb60-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= qi_lb60_probe,
+	.remove		= __devexit_p(qi_lb60_remove),
+};
+
+module_platform_driver(qi_lb60_driver);
 
 MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
 MODULE_DESCRIPTION("ALSA SoC QI LB60 Audio support");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qi-lb60-audio");
-- 
1.7.5.4
