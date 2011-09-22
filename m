From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Add platform data for WM1250 EV1
	GPIOs
Date: Thu, 22 Sep 2011 11:12:40 +0100
Message-ID: <1316686361-5126-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4A1D103B23
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Sep 2011 12:12:43 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The WM1250 EV1 has some GPIOs which can be used to control the behaviour
at runtime. Request them all if supplied and add a set_bias_level()
function to start and stop the clocks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/wm1250-ev1.h    |   27 +++++++++
 sound/soc/codecs/wm1250-ev1.c |  121 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 145 insertions(+), 3 deletions(-)
 create mode 100644 include/sound/wm1250-ev1.h

diff --git a/include/sound/wm1250-ev1.h b/include/sound/wm1250-ev1.h
new file mode 100644
index 0000000..7dff828
--- /dev/null
+++ b/include/sound/wm1250-ev1.h
@@ -0,0 +1,27 @@
+/*
+ * linux/sound/wm1250-ev1.h - Platform data for WM1250-EV1
+ *
+ * Copyright 2011 Wolfson Microelectronics. PLC.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __LINUX_SND_WM1250_EV1_H
+#define __LINUX_SND_WM1250_EV1_H
+
+#define WM1250_EV1_NUM_GPIOS 5
+
+#define WM1250_EV1_GPIO_CLK_ENA  0
+#define WM1250_EV1_GPIO_CLK_SEL0 1
+#define WM1250_EV1_GPIO_CLK_SEL1 2
+#define WM1250_EV1_GPIO_OSR      3
+#define WM1250_EV1_GPIO_MASTER   4
+
+
+struct wm1250_ev1_pdata {
+	int gpios[WM1250_EV1_NUM_GPIOS];
+};
+
+#endif
diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index 4523c4c..0554b88 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -12,10 +12,59 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
+#include <sound/wm1250-ev1.h>
+
+static const char *wm1250_gpio_names[WM1250_EV1_NUM_GPIOS] = {
+	"WM1250 CLK_ENA",
+	"WM1250 CLK_SEL0",
+	"WM1250 CLK_SEL1",
+	"WM1250 OSR",
+	"WM1250 MASTER",
+};
+
+struct wm1250_priv {
+	struct gpio gpios[WM1250_EV1_NUM_GPIOS];
+};
+
+static int wm1250_ev1_set_bias_level(struct snd_soc_codec *codec,
+				     enum snd_soc_bias_level level)
+{
+	struct wm1250_priv *wm1250 = dev_get_drvdata(codec->dev);
+	int ena;
+
+	if (wm1250)
+		ena = wm1250->gpios[WM1250_EV1_GPIO_CLK_ENA].gpio;
+	else
+		ena = -1;
+
+	switch (level) {
+	case SND_SOC_BIAS_ON:
+		break;
+
+	case SND_SOC_BIAS_PREPARE:
+		break;
+
+	case SND_SOC_BIAS_STANDBY:
+		if (ena >= 0)
+			gpio_set_value_cansleep(ena, 1);
+		break;
+
+	case SND_SOC_BIAS_OFF:
+		if (ena >= 0)
+			gpio_set_value_cansleep(ena, 0);
+		break;
+	}
+
+	codec->dapm.bias_level = level;
+
+	return 0;
+}
 
 static const struct snd_soc_dapm_widget wm1250_ev1_dapm_widgets[] = {
 SND_SOC_DAPM_ADC("ADC", "wm1250-ev1 Capture", SND_SOC_NOPM, 0, 0),
@@ -53,12 +102,66 @@ static struct snd_soc_codec_driver soc_codec_dev_wm1250_ev1 = {
 	.num_dapm_widgets = ARRAY_SIZE(wm1250_ev1_dapm_widgets),
 	.dapm_routes = wm1250_ev1_dapm_routes,
 	.num_dapm_routes = ARRAY_SIZE(wm1250_ev1_dapm_routes),
+
+	.set_bias_level = wm1250_ev1_set_bias_level,
 };
 
+static int __devinit wm1250_ev1_pdata(struct i2c_client *i2c)
+{
+	struct wm1250_ev1_pdata *pdata = dev_get_platdata(&i2c->dev);
+	struct wm1250_priv *wm1250;
+	int i, ret;
+
+	if (!pdata)
+		return 0;
+
+	wm1250 = kzalloc(sizeof(*wm1250), GFP_KERNEL);
+	if (!wm1250) {
+		dev_err(&i2c->dev, "Unable to allocate private data\n");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(wm1250->gpios); i++) {
+		wm1250->gpios[i].gpio = pdata->gpios[i];
+		wm1250->gpios[i].label = wm1250_gpio_names[i];
+		wm1250->gpios[i].flags = GPIOF_OUT_INIT_LOW;
+	}
+	wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL0].flags = GPIOF_OUT_INIT_HIGH;
+	wm1250->gpios[WM1250_EV1_GPIO_CLK_SEL1].flags = GPIOF_OUT_INIT_HIGH;
+
+	ret = gpio_request_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to get GPIOs: %d\n", ret);
+		goto err_alloc;
+	}
+
+	dev_set_drvdata(&i2c->dev, wm1250);
+
+	return ret;
+
+err_alloc:
+	kfree(wm1250);
+err:
+	return ret;
+}
+
+static void wm1250_ev1_free(struct i2c_client *i2c)
+{
+	struct wm1250_priv *wm1250 = dev_get_drvdata(&i2c->dev);
+
+	if (wm1250) {
+		gpio_free_array(wm1250->gpios, ARRAY_SIZE(wm1250->gpios));
+		kfree(wm1250);
+	}
+}
+
 static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
 				      const struct i2c_device_id *i2c_id)
 {
-	int id, board, rev;
+	int id, board, rev, ret;
+
+	dev_set_drvdata(&i2c->dev, NULL);
 
 	board = i2c_smbus_read_byte_data(i2c, 0);
 	if (board < 0) {
@@ -76,13 +179,25 @@ static int __devinit wm1250_ev1_probe(struct i2c_client *i2c,
 
 	dev_info(&i2c->dev, "revision %d\n", rev + 1);
 
-	return snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm1250_ev1,
-				      &wm1250_ev1_dai, 1);
+	ret = wm1250_ev1_pdata(i2c);
+	if (ret != 0)
+		return ret;
+
+	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_wm1250_ev1,
+				     &wm1250_ev1_dai, 1);
+	if (ret != 0) {
+		dev_err(&i2c->dev, "Failed to register CODEC: %d\n", ret);
+		wm1250_ev1_free(i2c);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int __devexit wm1250_ev1_remove(struct i2c_client *i2c)
 {
 	snd_soc_unregister_codec(&i2c->dev);
+	wm1250_ev1_free(i2c);
 
 	return 0;
 }
-- 
1.7.6.3
