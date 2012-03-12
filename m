From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v4] ASoC: mx27vis-aic32x4: Convert it to
	platform driver
Date: Mon, 12 Mar 2012 19:48:49 -0300
Message-ID: <1331592529-15544-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B9C6A104137
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 23:49:03 +0100 (CET)
Received: by ghbg19 with SMTP id g19so3289811ghb.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 15:49:01 -0700 (PDT)
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
Tested-by: Javier Martin <javier.martin@vista-silicon.com>
---
Changes since v3:
- Rebased against asoc for-3.4
Changes since v2:
- Add missing initialization of mx27vis_aic32x4.dev
- Add Tested-by line
Changes since v1:
- Fix MODULE_ALIAS
- Rename it to mx27vis
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c |    1 +
 sound/soc/imx/mx27vis-aic32x4.c             |   41 ++++++++++++++------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index c2766ae..428459f 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -263,6 +263,7 @@ static void __init visstrim_m10_board_init(void)
 	imx27_add_fec(NULL);
 	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 	platform_add_devices(platform_devices, ARRAY_SIZE(platform_devices));
+	imx_add_platform_device("mx27vis", 0, NULL, 0, NULL, 0);
 }
 
 static void __init visstrim_m10_timer_init(void)
diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
index 976f857..f6d04ad 100644
--- a/sound/soc/imx/mx27vis-aic32x4.c
+++ b/sound/soc/imx/mx27vis-aic32x4.c
@@ -188,22 +188,16 @@ static struct snd_soc_card mx27vis_aic32x4 = {
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
+	mx27vis_aic32x4.dev = &pdev->dev;
+	ret = snd_soc_register_card(&mx27vis_aic32x4);
 	if (ret) {
-		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
-		platform_device_put(mx27vis_aic32x4_snd_device);
+		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
+			ret);
+		return ret;
 	}
 
 	/* Connect SSI0 as clock slave to SSI1 external pins */
@@ -221,22 +215,31 @@ static int __init mx27vis_aic32x4_init(void)
 
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
+		.name = "mx27vis",
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
+MODULE_ALIAS("platform:mx27vis");
-- 
1.7.1
