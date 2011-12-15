From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/5] ASoC: pxa: Convert e750_wm9705 to use
 snd_soc_register_card()
Date: Thu, 15 Dec 2011 10:53:29 +0800
Message-ID: <1323917609.28019.3.camel@phoenix>
References: <1323917478.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CDD31038CA
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 03:53:36 +0100 (CET)
Received: by qcol42 with SMTP id l42so984868qco.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 18:53:35 -0800 (PST)
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
 arch/arm/mach-pxa/eseries.c |    6 ++++
 sound/soc/pxa/e750_wm9705.c |   66 ++++++++++++++++++++----------------------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index b411779..fe52d5c 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -728,12 +728,18 @@ static struct platform_device e750_tc6393xb_device = {
 	.resource      = eseries_tmio_resources,
 };
 
+static struct platform_device e750_audio_device = {
+	.name		= "e750-audio",
+	.id		= -1,
+};
+
 /* ------------------------------------------------------------- */
 
 static struct platform_device *e750_devices[] __initdata = {
 	&e750_fb_device,
 	&e750_tc6393xb_device,
 	&e7xx_gpio_vbus,
+	&e750_audio_device,
 };
 
 static void __init e750_init(void)
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 55c53d1..27f90cc 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -120,58 +120,54 @@ static struct snd_soc_card e750 = {
 	.num_links = ARRAY_SIZE(e750_dai),
 };
 
-static struct platform_device *e750_snd_device;
+static struct gpio e750_audio_gpios[] = {
+	{ GPIO_E750_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Headphone amp" },
+	{ GPIO_E750_SPK_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Speaker amp" },
+};
 
-static int __init e750_init(void)
+static int __devinit e750_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &e750;
 	int ret;
 
-	if (!machine_is_e750())
-		return -ENODEV;
-
-	ret = gpio_request_one(GPIO_E750_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH,
-			       "Headphone amp");
+	ret = gpio_request_array(e750_audio_gpios,
+				 ARRAY_SIZE(e750_audio_gpios));
 	if (ret)
 		return ret;
 
-	ret = gpio_request_one(GPIO_E750_SPK_AMP_OFF, GPIOF_OUT_INIT_HIGH,
-			       "Speaker amp");
-	if (ret)
-		goto free_hp_amp_gpio;
+	card->dev = &pdev->dev;
 
-	e750_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!e750_snd_device) {
-		ret = -ENOMEM;
-		goto free_spk_amp_gpio;
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		gpio_free_array(e750_audio_gpios, ARRAY_SIZE(e750_audio_gpios));
 	}
-
-	platform_set_drvdata(e750_snd_device, &e750);
-	ret = platform_device_add(e750_snd_device);
-
-	if (!ret)
-		return 0;
-
-/* Fail gracefully */
-	platform_device_put(e750_snd_device);
-free_spk_amp_gpio:
-	gpio_free(GPIO_E750_SPK_AMP_OFF);
-free_hp_amp_gpio:
-	gpio_free(GPIO_E750_HP_AMP_OFF);
-
 	return ret;
 }
 
-static void __exit e750_exit(void)
+static int __devexit e750_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(e750_snd_device);
-	gpio_free(GPIO_E750_SPK_AMP_OFF);
-	gpio_free(GPIO_E750_HP_AMP_OFF);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	gpio_free_array(e750_audio_gpios, ARRAY_SIZE(e750_audio_gpios));
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(e750_init);
-module_exit(e750_exit);
+static struct platform_driver e750_driver = {
+	.driver		= {
+		.name	= "e750-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= e750_probe,
+	.remove		= __devexit_p(e750_remove),
+};
+
+module_platform_driver(e750_driver);
 
 /* Module information */
 MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
 MODULE_DESCRIPTION("ALSA SoC driver for e750");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:e750-audio");
-- 
1.7.5.4
