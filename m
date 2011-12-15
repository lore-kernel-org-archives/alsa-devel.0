From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/5] ASoC: pxa: Convert e800_wm9712 to use
 snd_soc_register_card()
Date: Thu, 15 Dec 2011 10:54:25 +0800
Message-ID: <1323917665.28019.4.camel@phoenix>
References: <1323917478.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F9C11038CA
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 03:54:32 +0100 (CET)
Received: by qcol42 with SMTP id l42so985300qco.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 18:54:32 -0800 (PST)
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
 sound/soc/pxa/e800_wm9712.c |   66 ++++++++++++++++++++----------------------
 2 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index fe52d5c..4cb2391 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -941,12 +941,18 @@ static struct platform_device e800_tc6393xb_device = {
 	.resource      = eseries_tmio_resources,
 };
 
+static struct platform_device e800_audio_device = {
+	.name		= "e800-audio",
+	.id		= -1,
+};
+
 /* ----------------------------------------------------------------------- */
 
 static struct platform_device *e800_devices[] __initdata = {
 	&e800_fb_device,
 	&e800_tc6393xb_device,
 	&e800_gpio_vbus,
+	&e800_audio_device,
 };
 
 static void __init e800_init(void)
diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 478ff19..858bf94 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -110,58 +110,54 @@ static struct snd_soc_card e800 = {
 	.num_links = ARRAY_SIZE(e800_dai),
 };
 
-static struct platform_device *e800_snd_device;
+static struct gpio e800_audio_gpios[] = {
+	{ GPIO_E800_SPK_AMP_ON, GPIOF_OUT_INIT_HIGH, "Headphone amp" },
+	{ GPIO_E800_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH, "Speaker amp" },
+};
 
-static int __init e800_init(void)
+static int __devinit e800_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &e800;
 	int ret;
 
-	if (!machine_is_e800())
-		return -ENODEV;
-
-	ret = gpio_request_one(GPIO_E800_HP_AMP_OFF, GPIOF_OUT_INIT_HIGH,
-			       "Headphone amp");
+	ret = gpio_request_array(e800_audio_gpios,
+				 ARRAY_SIZE(e800_audio_gpios));
 	if (ret)
 		return ret;
 
-	ret = gpio_request_one(GPIO_E800_SPK_AMP_ON, GPIOF_OUT_INIT_HIGH,
-			       "Speaker amp");
-	if (ret)
-		goto free_hp_amp_gpio;
+	card->dev = &pdev->dev;
 
-	e800_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!e800_snd_device) {
-		ret = -ENOMEM;
-		goto free_spk_amp_gpio;
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		gpio_free_array(e800_audio_gpios, ARRAY_SIZE(e800_audio_gpios));
 	}
-
-	platform_set_drvdata(e800_snd_device, &e800);
-	ret = platform_device_add(e800_snd_device);
-
-	if (!ret)
-		return 0;
-
-/* Fail gracefully */
-	platform_device_put(e800_snd_device);
-free_spk_amp_gpio:
-	gpio_free(GPIO_E800_SPK_AMP_ON);
-free_hp_amp_gpio:
-	gpio_free(GPIO_E800_HP_AMP_OFF);
-
 	return ret;
 }
 
-static void __exit e800_exit(void)
+static int __devexit e800_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(e800_snd_device);
-	gpio_free(GPIO_E800_SPK_AMP_ON);
-	gpio_free(GPIO_E800_HP_AMP_OFF);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	gpio_free_array(e800_audio_gpios, ARRAY_SIZE(e800_audio_gpios));
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(e800_init);
-module_exit(e800_exit);
+static struct platform_driver e800_driver = {
+	.driver		= {
+		.name	= "e800-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= e800_probe,
+	.remove		= __devexit_p(e800_remove),
+};
+
+module_platform_driver(e800_driver);
 
 /* Module information */
 MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
 MODULE_DESCRIPTION("ALSA SoC driver for e800");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:e800-audio");
-- 
1.7.5.4
