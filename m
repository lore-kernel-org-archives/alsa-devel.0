From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 3/3] mfd/ab8500: Move platform-data for
	ab8500-codec into mfd-driver
Date: Thu, 7 Jun 2012 14:00:46 +0200
Message-ID: <1339070446-15186-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog118.obsmtp.com (eu1sys200aog118.obsmtp.com
	[207.126.144.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 944A110B9B2
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 14:00:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

The platform-data used by the Ux500 ASoC-driver is moved from the
machine-driver context into the codec-driver context. This means
adding the platform-data for 'ab8500-codec' into the main AB8500
platform-data.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500.c      |   14 ++++++++
 include/linux/mfd/abx500/ab8500-codec.h |   52 +++++++++++++++++++++++++++++++
 include/linux/mfd/abx500/ab8500.h       |    2 +
 3 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/mfd/abx500/ab8500-codec.h

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index c41912c..679a354 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -24,6 +24,7 @@
 #include <linux/mfd/tc3589x.h>
 #include <linux/mfd/tps6105x.h>
 #include <linux/mfd/abx500/ab8500-gpio.h>
+#include <linux/mfd/abx500/ab8500-codec.h>
 #include <linux/leds-lp5521.h>
 #include <linux/input.h>
 #include <linux/smsc911x.h>
@@ -96,6 +97,18 @@ static struct ab8500_gpio_platform_data ab8500_gpio_pdata = {
 					0x7A, 0x00, 0x00},
 };
 
+/* ab8500-codec */
+static struct ab8500_codec_platform_data ab8500_codec_pdata = {
+	.amics =  {
+		.mic1_type = AMIC_TYPE_DIFFERENTIAL,
+		.mic2_type = AMIC_TYPE_DIFFERENTIAL,
+		.mic1a_micbias = AMIC_MICBIAS_VAMIC1,
+		.mic1b_micbias = AMIC_MICBIAS_VAMIC1,
+		.mic2_micbias = AMIC_MICBIAS_VAMIC2
+	},
+	.ear_cmv = EAR_CMV_0_95V
+};
+
 static struct gpio_keys_button snowball_key_array[] = {
 	{
 		.gpio           = 32,
@@ -194,6 +207,7 @@ static struct ab8500_platform_data ab8500_platdata = {
 	.regulator	= ab8500_regulators,
 	.num_regulator	= ARRAY_SIZE(ab8500_regulators),
 	.gpio		= &ab8500_gpio_pdata,
+	.codec		= &ab8500_codec_pdata,
 };
 
 static struct resource ab8500_resources[] = {
diff --git a/include/linux/mfd/abx500/ab8500-codec.h b/include/linux/mfd/abx500/ab8500-codec.h
new file mode 100644
index 0000000..dc65292
--- /dev/null
+++ b/include/linux/mfd/abx500/ab8500-codec.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef AB8500_CORE_CODEC_H
+#define AB8500_CORE_CODEC_H
+
+/* Mic-types */
+enum amic_type {
+	AMIC_TYPE_SINGLE_ENDED,
+	AMIC_TYPE_DIFFERENTIAL
+};
+
+/* Mic-biases */
+enum amic_micbias {
+	AMIC_MICBIAS_VAMIC1,
+	AMIC_MICBIAS_VAMIC2
+};
+
+/* Bias-voltage */
+enum ear_cm_voltage {
+	EAR_CMV_0_95V,
+	EAR_CMV_1_10V,
+	EAR_CMV_1_27V,
+	EAR_CMV_1_58V
+};
+
+/* Analog microphone settings */
+struct amic_settings {
+	enum amic_type mic1_type;
+	enum amic_type mic2_type;
+	enum amic_micbias mic1a_micbias;
+	enum amic_micbias mic1b_micbias;
+	enum amic_micbias mic2_micbias;
+};
+
+/* Platform data structure for the audio-parts of the AB8500 */
+struct ab8500_codec_platform_data {
+	struct amic_settings amics;
+	enum ear_cm_voltage ear_cmv;
+};
+
+#endif
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 91dd3ef..bc9b84b 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -266,6 +266,7 @@ struct ab8500 {
 struct regulator_reg_init;
 struct regulator_init_data;
 struct ab8500_gpio_platform_data;
+struct ab8500_codec_platform_data;
 
 /**
  * struct ab8500_platform_data - AB8500 platform data
@@ -284,6 +285,7 @@ struct ab8500_platform_data {
 	int num_regulator;
 	struct regulator_init_data *regulator;
 	struct ab8500_gpio_platform_data *gpio;
+	struct ab8500_codec_platform_data *codec;
 };
 
 extern int __devinit ab8500_init(struct ab8500 *ab8500,
-- 
1.7.8.3
