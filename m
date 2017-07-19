From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Hide platform data in the
	module sources" to the asoc tree
Date: Wed, 19 Jul 2017 12:27:09 +0100
Message-ID: <E1dXn8H-0002cG-85@debutante>
References: <20170718173419.65980-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 20193266998
 for <alsa-devel@alsa-project.org>; Wed, 19 Jul 2017 13:27:17 +0200 (CEST)
In-Reply-To: <20170718173419.65980-2-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, John Keeping <john@metanate.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Hide platform data in the module sources

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From ddc9e69b9dc23d4c0d8ed829575327746ea77a04 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 18 Jul 2017 20:34:17 +0300
Subject: [PATCH] ASoC: rt5677: Hide platform data in the module sources

There is no user of legacy platform data.

Remove separate header and hide its content inside module sources.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/rt5677.h    | 45 ---------------------------------------------
 sound/soc/codecs/rt5677.c | 29 +++++++++++++++++------------
 sound/soc/codecs/rt5677.h | 30 +++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 58 deletions(-)
 delete mode 100644 include/sound/rt5677.h

diff --git a/include/sound/rt5677.h b/include/sound/rt5677.h
deleted file mode 100644
index a6207043ac3c..000000000000
--- a/include/sound/rt5677.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * linux/sound/rt5677.h -- Platform data for RT5677
- *
- * Copyright 2013 Realtek Semiconductor Corp.
- * Author: Oder Chiou <oder_chiou@realtek.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __LINUX_SND_RT5677_H
-#define __LINUX_SND_RT5677_H
-
-enum rt5677_dmic2_clk {
-	RT5677_DMIC_CLK1 = 0,
-	RT5677_DMIC_CLK2 = 1,
-};
-
-
-struct rt5677_platform_data {
-	/* IN1/IN2/LOUT1/LOUT2/LOUT3 can optionally be differential */
-	bool in1_diff;
-	bool in2_diff;
-	bool lout1_diff;
-	bool lout2_diff;
-	bool lout3_diff;
-	/* DMIC2 clock source selection */
-	enum rt5677_dmic2_clk dmic2_clk_pin;
-
-	/* configures GPIO, 0 - floating, 1 - pulldown, 2 - pullup */
-	u8 gpio_config[6];
-
-	/* jd1 can select 0 ~ 3 as OFF, GPIO1, GPIO2 and GPIO3 respectively */
-	unsigned int jd1_gpio;
-	/* jd2 and jd3 can select 0 ~ 3 as
-		OFF, GPIO4, GPIO5 and GPIO6 respectively */
-	unsigned int jd2_gpio;
-	unsigned int jd3_gpio;
-
-	/* Set MICBIAS1 VDD 1v8 or 3v3 */
-	bool micbias1_vdd_3v3;
-};
-
-#endif
diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 36e530a36c82..0f9642c2198a 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 #include <linux/firmware.h>
+#include <linux/of_device.h>
 #include <linux/property.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -5019,25 +5020,21 @@ static const struct regmap_config rt5677_regmap = {
 };
 
 static const struct i2c_device_id rt5677_i2c_id[] = {
-	{ "rt5677", RT5677 },
-	{ "rt5676", RT5676 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, rt5677_i2c_id);
 
 static const struct of_device_id rt5677_of_match[] = {
-	{ .compatible = "realtek,rt5677", },
+	{ .compatible = "realtek,rt5677", RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rt5677_of_match);
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5677_acpi_match[] = {
 	{ "RT5677CE", RT5677 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, rt5677_acpi_match);
-#endif
 
 static void rt5677_read_acpi_properties(struct rt5677_priv *rt5677,
 		struct device *dev)
@@ -5147,7 +5144,6 @@ static void rt5677_free_irq(struct i2c_client *i2c)
 static int rt5677_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
-	struct rt5677_platform_data *pdata = dev_get_platdata(&i2c->dev);
 	struct rt5677_priv *rt5677;
 	int ret;
 	unsigned int val;
@@ -5159,16 +5155,25 @@ static int rt5677_i2c_probe(struct i2c_client *i2c,
 
 	i2c_set_clientdata(i2c, rt5677);
 
-	rt5677->type = id->driver_data;
+	if (i2c->dev.of_node) {
+		const struct of_device_id *match_id;
+
+		match_id = of_match_device(rt5677_of_match, &i2c->dev);
+		if (match_id)
+			rt5677->type = (enum rt5677_type)match_id->data;
 
-	if (pdata)
-		rt5677->pdata = *pdata;
-	else if (i2c->dev.of_node)
 		rt5677_read_device_properties(rt5677, &i2c->dev);
-	else if (ACPI_HANDLE(&i2c->dev))
+	} else if (ACPI_HANDLE(&i2c->dev)) {
+		const struct acpi_device_id *acpi_id;
+
+		acpi_id = acpi_match_device(rt5677_acpi_match, &i2c->dev);
+		if (acpi_id)
+			rt5677->type = (enum rt5677_type)acpi_id->driver_data;
+
 		rt5677_read_acpi_properties(rt5677, &i2c->dev);
-	else
+	} else {
 		return -EINVAL;
+	}
 
 	/* pow-ldo2 and reset are optional. The codec pins may be statically
 	 * connected on the board without gpios. If the gpio device property
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index d46855a42c40..97239973edc4 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -12,7 +12,6 @@
 #ifndef __RT5677_H__
 #define __RT5677_H__
 
-#include <sound/rt5677.h>
 #include <linux/gpio/driver.h>
 #include <linux/gpio/consumer.h>
 
@@ -1761,6 +1760,35 @@ enum {
 	RT5677_I2S4_SOURCE = (0x1 << 18),
 };
 
+enum rt5677_dmic2_clk {
+	RT5677_DMIC_CLK1 = 0,
+	RT5677_DMIC_CLK2 = 1,
+};
+
+struct rt5677_platform_data {
+	/* IN1/IN2/LOUT1/LOUT2/LOUT3 can optionally be differential */
+	bool in1_diff;
+	bool in2_diff;
+	bool lout1_diff;
+	bool lout2_diff;
+	bool lout3_diff;
+	/* DMIC2 clock source selection */
+	enum rt5677_dmic2_clk dmic2_clk_pin;
+
+	/* configures GPIO, 0 - floating, 1 - pulldown, 2 - pullup */
+	u8 gpio_config[6];
+
+	/* jd1 can select 0 ~ 3 as OFF, GPIO1, GPIO2 and GPIO3 respectively */
+	unsigned int jd1_gpio;
+	/* jd2 and jd3 can select 0 ~ 3 as
+		OFF, GPIO4, GPIO5 and GPIO6 respectively */
+	unsigned int jd2_gpio;
+	unsigned int jd3_gpio;
+
+	/* Set MICBIAS1 VDD 1v8 or 3v3 */
+	bool micbias1_vdd_3v3;
+};
+
 struct rt5677_priv {
 	struct snd_soc_codec *codec;
 	struct rt5677_platform_data pdata;
-- 
2.13.2
