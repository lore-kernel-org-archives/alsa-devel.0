From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 1/3] ASoC: rt5640: Add RL6231 class device
	shared support for RT5640, RT5645 and RT5651
Date: Tue, 20 May 2014 15:01:53 +0800
Message-ID: <1400569315-12221-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4779B261A38
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 09:02:21 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch adds the RL6231 class device shared support for RT5640, RT5645 and
RT5651. The function of the DMIC clock calculation can be shared by RL6231
shared support.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/Kconfig  |  9 +++++++
 sound/soc/codecs/Makefile |  2 ++
 sound/soc/codecs/rl6231.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/rl6231.h | 18 +++++++++++++
 sound/soc/codecs/rt5640.c | 23 ++++------------
 sound/soc/codecs/rt5645.c | 22 +++-------------
 sound/soc/codecs/rt5651.c | 22 ++++------------
 7 files changed, 110 insertions(+), 53 deletions(-)
 create mode 100644 sound/soc/codecs/rl6231.c
 create mode 100644 sound/soc/codecs/rl6231.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 4f96b97..6951381 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -402,6 +402,15 @@ config SND_SOC_PCM512x_SPI
 	select SND_SOC_PCM512x
 	select REGMAP_SPI
 
+config SND_SOC_RL6231
+	tristate
+	default y if SND_SOC_RT5640=y
+	default y if SND_SOC_RT5645=y
+	default y if SND_SOC_RT5651=y
+	default m if SND_SOC_RT5640=m
+	default m if SND_SOC_RT5645=m
+	default m if SND_SOC_RT5651=m
+
 config SND_SOC_RT5631
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 1ccdaf0..d1e913a 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -60,6 +60,7 @@ snd-soc-pcm3008-objs := pcm3008.o
 snd-soc-pcm512x-objs := pcm512x.o
 snd-soc-pcm512x-i2c-objs := pcm512x-i2c.o
 snd-soc-pcm512x-spi-objs := pcm512x-spi.o
+snd-soc-rl6231-objs := rl6231.o
 snd-soc-rt5631-objs := rt5631.o
 snd-soc-rt5640-objs := rt5640.o
 snd-soc-rt5645-objs := rt5645.o
@@ -216,6 +217,7 @@ obj-$(CONFIG_SND_SOC_PCM3008)	+= snd-soc-pcm3008.o
 obj-$(CONFIG_SND_SOC_PCM512x)	+= snd-soc-pcm512x.o
 obj-$(CONFIG_SND_SOC_PCM512x_I2C)	+= snd-soc-pcm512x-i2c.o
 obj-$(CONFIG_SND_SOC_PCM512x_SPI)	+= snd-soc-pcm512x-spi.o
+obj-$(CONFIG_SND_SOC_RL6231)	+= snd-soc-rl6231.o
 obj-$(CONFIG_SND_SOC_RT5631)	+= snd-soc-rt5631.o
 obj-$(CONFIG_SND_SOC_RT5640)	+= snd-soc-rt5640.o
 obj-$(CONFIG_SND_SOC_RT5645)	+= snd-soc-rt5645.o
diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
new file mode 100644
index 0000000..13ac551
--- /dev/null
+++ b/sound/soc/codecs/rl6231.c
@@ -0,0 +1,67 @@
+/*
+ * rl6231.c - RL6231 class device shared support
+ *
+ * Copyright 2014 Realtek Semiconductor Corp.
+ *
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/pm.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/acpi.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/initval.h>
+#include <sound/tlv.h>
+
+#include "rl6231.h"
+
+/**
+ * rl6231_calc_dmic_clk - Calculate the parameter of dmic.
+ *
+ * @rate: base clock rate.
+ *
+ * Choose dmic clock between 1MHz and 3MHz.
+ * It is better for clock to approximate 3MHz.
+ */
+int rl6231_calc_dmic_clk(int rate)
+{
+	int div[] = {2, 3, 4, 6, 8, 12}, idx = -EINVAL;
+	int i, red, bound, temp;
+
+	red = 3000000 * 12;
+	for (i = 0; i < ARRAY_SIZE(div); i++) {
+		bound = div[i] * 3000000;
+		if (rate > bound)
+			continue;
+		temp = bound - rate;
+		if (temp < red) {
+			red = temp;
+			idx = i;
+		}
+	}
+
+	return idx;
+}
+EXPORT_SYMBOL_GPL(rl6231_calc_dmic_clk);
+
+MODULE_DESCRIPTION("RL6231 class device shared support");
+MODULE_AUTHOR("Oder Chiou <oder_chiou@realtek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/codecs/rl6231.h b/sound/soc/codecs/rl6231.h
new file mode 100644
index 0000000..00032db
--- /dev/null
+++ b/sound/soc/codecs/rl6231.h
@@ -0,0 +1,18 @@
+/*
+ * rl6231.h - RL6231 class device shared support
+ *
+ * Copyright 2014 Realtek Semiconductor Corp.
+ *
+ * Author: Oder Chiou <oder_chiou@realtek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __RL6231_H__
+#define __RL6231_H__
+
+int rl6231_calc_dmic_clk(int rate);
+
+#endif /* __RL6231_H__ */
diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 9e0d48f..0cefc16 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -31,6 +31,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
+#include "rl6231.h"
 #include "rt5640.h"
 
 #define RT5640_DEVICE_ID 0x6231
@@ -453,30 +454,16 @@ static const struct snd_kcontrol_new rt5640_specific_snd_controls[] = {
  * @kcontrol: The kcontrol of this widget.
  * @event: Event id.
  *
- * Choose dmic clock between 1MHz and 3MHz.
- * It is better for clock to approximate 3MHz.
  */
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
-	int div[] = {2, 3, 4, 6, 8, 12};
-	int idx = -EINVAL, i;
-	int rate, red, bound, temp;
-
-	rate = rt5640->sysclk;
-	red = 3000000 * 12;
-	for (i = 0; i < ARRAY_SIZE(div); i++) {
-		bound = div[i] * 3000000;
-		if (rate > bound)
-			continue;
-		temp = bound - rate;
-		if (temp < red) {
-			red = temp;
-			idx = i;
-		}
-	}
+	int idx = -EINVAL;
+
+	idx = rl6231_calc_dmic_clk(rt5640->sysclk);
+
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ab97d72..caa5519 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -26,6 +26,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
+#include "rl6231.h"
 #include "rt5645.h"
 
 #define RT5645_DEVICE_ID 0x6308
@@ -519,30 +520,15 @@ static const struct snd_kcontrol_new rt5645_snd_controls[] = {
  * @kcontrol: The kcontrol of this widget.
  * @event: Event id.
  *
- * Choose dmic clock between 1MHz and 3MHz.
- * It is better for clock to approximate 3MHz.
  */
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct rt5645_priv *rt5645 = snd_soc_codec_get_drvdata(codec);
-	int div[] = {2, 3, 4, 6, 8, 12};
-	int idx = -EINVAL, i;
-	int rate, red, bound, temp;
-
-	rate = rt5645->sysclk;
-	red = 3000000 * 12;
-	for (i = 0; i < ARRAY_SIZE(div); i++) {
-		bound = div[i] * 3000000;
-		if (rate > bound)
-			continue;
-		temp = bound - rate;
-		if (temp < red) {
-			red = temp;
-			idx = i;
-		}
-	}
+	int idx = -EINVAL;
+
+	idx = rl6231_calc_dmic_clk(rt5645->sysclk);
 
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 9c88d89..7a7bec6 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -26,6 +26,7 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
+#include "rl6231.h"
 #include "rt5651.h"
 
 #define RT5651_DEVICE_ID_VALUE 0x6281
@@ -371,29 +372,16 @@ static const struct snd_kcontrol_new rt5651_snd_controls[] = {
  * @kcontrol: The kcontrol of this widget.
  * @event: Event id.
  *
- * Choose dmic clock between 1MHz and 3MHz.
- * It is better for clock to approximate 3MHz.
  */
 static int set_dmic_clk(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
 	struct rt5651_priv *rt5651 = snd_soc_codec_get_drvdata(codec);
-	int div[] = {2, 3, 4, 6, 8, 12}, idx = -EINVAL;
-	int i, rate, red, bound, temp;
-
-	rate = rt5651->sysclk;
-	red = 3000000 * 12;
-	for (i = 0; i < ARRAY_SIZE(div); i++) {
-		bound = div[i] * 3000000;
-		if (rate > bound)
-			continue;
-		temp = bound - rate;
-		if (temp < red) {
-			red = temp;
-			idx = i;
-		}
-	}
+	int idx = -EINVAL;
+
+	idx = rl6231_calc_dmic_clk(rt5651->sysclk);
+
 	if (idx < 0)
 		dev_err(codec->dev, "Failed to set DMIC clock\n");
 	else
-- 
1.8.1.1.439.g50a6b54
