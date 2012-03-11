From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: mx27vis-aic32x4: Convert it to platform
	driver
Date: Sun, 11 Mar 2012 17:08:36 -0300
Message-ID: <1331496516-6578-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 15CF124548
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 21:08:48 +0100 (CET)
Received: by yenl1 with SMTP id l1so2047244yen.38
	for <alsa-devel@alsa-project.org>; Sun, 11 Mar 2012 13:08:48 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>, javier.martin@vista-silicon.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Convert mx27vis-aic32x4 to platform driver.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    2 +
 sound/soc/imx/mx27vis-aic32x4.c             |   40 ++++++++++++++-------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 0a1643c..ed5dd41 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -397,6 +397,8 @@ static void __init visstrim_m10_board_init(void)
 				      &iclink_tvp5150, sizeof(iclink_tvp5150));
 	gpio_led_register_device(0, &visstrim_m10_led_data);
 	visstrim_camera_init();
+	imx_add_platform_device("mx27vis_aic32x4", 0, NULL, 0,
+							NULL, 0);
 }
 
 static void __init visstrim_m10_timer_init(void)
diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 976f857..09448b4 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -188,22 +188,15 @@ static struct snd_soc_card mx27vis_aic32x4 = {
 	.num_dapm_routes = ARRAY_SIZE(aic32x4_dapm_routes),
 };
 
-static struct platform_device *mx27vis_aic32x4_snd_device;
-
-static int __init mx27vis_aic32x4_init(void)
+static int __devinit mx27vis_aic32x4_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	mx27vis_aic32x4_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!mx27vis_aic32x4_snd_device)
-		return -ENOMEM;
-
-	platform_set_drvdata(mx27vis_aic32x4_snd_device, &mx27vis_aic32x4);
-	ret = platform_device_add(mx27vis_aic32x4_snd_device);
-
+	ret = snd_soc_register_card(&mx27vis_aic32x4);
 	if (ret) {
-		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		platform_device_put(mx27vis_aic32x4_snd_device);
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+			ret);
+		return ret;
 	}
 
 	/* Connect SSI0 as clock slave to SSI1 external pins */
@@ -221,22 +214,31 @@ static int __init mx27vis_aic32x4_init(void)
 
 	ret = mxc_gpio_setup_multiple_pins(mx27vis_amp_pins,
 			ARRAY_SIZE(mx27vis_amp_pins), "MX27VIS_AMP");
-	if (ret) {
+	if (ret)
 		printk(KERN_ERR "ASoC: unable to setup gpios\n");
-		platform_device_put(mx27vis_aic32x4_snd_device);
-	}
 
 	return ret;
 }
 
-static void __exit mx27vis_aic32x4_exit(void)
+static int __devexit mx27vis_aic32x4_remove(struct platform_device *pdev)
 {
-	platform_device_unregister(mx27vis_aic32x4_snd_device);
+	snd_soc_unregister_card(&mx27vis_aic32x4);
+
+	return 0;
 }
 
-module_init(mx27vis_aic32x4_init);
-module_exit(mx27vis_aic32x4_exit);
+static struct platform_driver mx27vis_aic32x4_audio_driver = {
+	.driver = {
+		.name = "mx27vis_aic32x4",
+		.owner = THIS_MODULE,
+	},
+	.probe = mx27vis_aic32x4_probe,
+	.remove = __devexit_p(mx27vis_aic32x4_remove),
+};
+
+module_platform_driver(mx27vis_aic32x4_audio_driver);
 
 MODULE_AUTHOR("Javier Martin <javier.martin@vista-silicon.com>");
 MODULE_DESCRIPTION("ALSA SoC AIC32X4 mx27 visstrim");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("mx27vis_aic32x4");
-- 
1.7.1
