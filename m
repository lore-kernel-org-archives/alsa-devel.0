From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/5] ASoC: pxa: Convert e740_wm9705 to use
 snd_soc_register_card()
Date: Thu, 15 Dec 2011 10:52:42 +0800
Message-ID: <1323917562.28019.2.camel@phoenix>
References: <1323917478.28019.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D39A11038C5
	for <alsa-devel@alsa-project.org>; Thu, 15 Dec 2011 03:52:49 +0100 (CET)
Received: by vcbf13 with SMTP id f13so170190vcb.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 18:52:49 -0800 (PST)
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
 arch/arm/mach-pxa/eseries.c |    6 +++
 sound/soc/pxa/e740_wm9705.c |   75 ++++++++++++++++++------------------------
 2 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index f79a610..b411779 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -528,12 +528,18 @@ static struct platform_device e740_t7l66xb_device = {
 	.resource      = eseries_tmio_resources,
 };
 
+static struct platform_device e740_audio_device = {
+	.name		= "e740-audio",
+	.id		= -1,
+};
+
 /* ----------------------------------------------------------------------- */
 
 static struct platform_device *e740_devices[] __initdata = {
 	&e740_fb_device,
 	&e740_t7l66xb_device,
 	&e7xx_gpio_vbus,
+	&e740_audio_device,
 };
 
 static void __init e740_init(void)
diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index 818dc57..203ab78a 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -137,66 +137,55 @@ static struct snd_soc_card e740 = {
 	.num_links = ARRAY_SIZE(e740_dai),
 };
 
-static struct platform_device *e740_snd_device;
+static struct gpio e740_audio_gpios[] = {
+	{ GPIO_E740_MIC_ON, GPIOF_OUT_INIT_LOW, "Mic amp" },
+	{ GPIO_E740_AMP_ON, GPIOF_OUT_INIT_LOW, "Output amp" },
+	{ GPIO_E740_WM9705_nAVDD2, GPIOF_OUT_INIT_HIGH, "Audio power" },
+};
 
-static int __init e740_init(void)
+static int __devinit e740_probe(struct platform_device *pdev)
 {
+	struct snd_soc_card *card = &e740;
 	int ret;
 
-	if (!machine_is_e740())
-		return -ENODEV;
-
-	/* Disable audio */
-	ret = gpio_request_one(GPIO_E740_MIC_ON, GPIOF_OUT_INIT_LOW, "Mic amp");
+	ret = gpio_request_array(e740_audio_gpios,
+				 ARRAY_SIZE(e740_audio_gpios));
 	if (ret)
 		return ret;
 
-	ret = gpio_request_one(GPIO_E740_AMP_ON, GPIOF_OUT_INIT_LOW,
-			       "Output amp");
-	if (ret)
-		goto free_mic_amp_gpio;
+	card->dev = &pdev->dev;
 
-	ret = gpio_request_one(GPIO_E740_WM9705_nAVDD2, GPIOF_OUT_INIT_HIGH,
-			   "Audio power");
-	if (ret)
-		goto free_op_amp_gpio;
-
-	e740_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!e740_snd_device) {
-		ret = -ENOMEM;
-		goto free_apwr_gpio;
+	ret = snd_soc_register_card(card);
+	if (ret) {
+		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
+			ret);
+		gpio_free_array(e740_audio_gpios, ARRAY_SIZE(e740_audio_gpios));
 	}
-
-	platform_set_drvdata(e740_snd_device, &e740);
-	ret = platform_device_add(e740_snd_device);
-
-	if (!ret)
-		return 0;
-
-/* Fail gracefully */
-	platform_device_put(e740_snd_device);
-free_apwr_gpio:
-	gpio_free(GPIO_E740_WM9705_nAVDD2);
-free_op_amp_gpio:
-	gpio_free(GPIO_E740_AMP_ON);
-free_mic_amp_gpio:
-	gpio_free(GPIO_E740_MIC_ON);
-
 	return ret;
 }
 
-static void __exit e740_exit(void)
+static int __devexit e740_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(e740_snd_device);
-	gpio_free(GPIO_E740_WM9705_nAVDD2);
-	gpio_free(GPIO_E740_AMP_ON);
-	gpio_free(GPIO_E740_MIC_ON);
+	struct snd_soc_card *card = platform_get_drvdata(pdev);
+
+	gpio_free_array(e740_audio_gpios, ARRAY_SIZE(e740_audio_gpios));
+	snd_soc_unregister_card(card);
+	return 0;
 }
 
-module_init(e740_init);
-module_exit(e740_exit);
+static struct platform_driver e740_driver = {
+	.driver		= {
+		.name	= "e740-audio",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= e740_probe,
+	.remove		= __devexit_p(e740_remove),
+};
+
+module_platform_driver(e740_driver);
 
 /* Module information */
 MODULE_AUTHOR("Ian Molton <spyro@f2s.com>");
 MODULE_DESCRIPTION("ALSA SoC driver for e740");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:e740-audio");
-- 
1.7.5.4
