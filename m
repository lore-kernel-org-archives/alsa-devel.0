From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 07/11] arm: ux500: Add audio-related
	platform-data
Date: Tue, 8 May 2012 15:57:08 +0200
Message-ID: <1336485428-27296-1-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FE0910440B
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 15:57:20 +0200 (CEST)
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

This patch adds audio-related platform-data like hardwired settings
for microphones and common-mode voltage for the earpiece.
There is also some refactoring of the msp/audio-files.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/Makefile                       |    3 +-
 arch/arm/mach-ux500/board-mop500-audio.c           |   58 +++++++++++++++
 arch/arm/mach-ux500/board-mop500-msp.c             |   76 ++++++-------------
 arch/arm/mach-ux500/board-mop500.c                 |    5 +-
 arch/arm/mach-ux500/board-mop500.h                 |    2 +
 .../mach-ux500/include/mach/board-mop500-audio.h   |   52 +++++++++++++
 .../arm/mach-ux500/include/mach/board-mop500-msp.h |   32 ++++++++
 7 files changed, 174 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm/mach-ux500/board-mop500-audio.c
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-audio.h
 create mode 100644 arch/arm/mach-ux500/include/mach/board-mop500-msp.h

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index 11729bc..f97cee8 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -12,7 +12,8 @@ obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
 				board-mop500-uib.o board-mop500-stuib.o \
 				board-mop500-u8500uib.o \
 				board-mop500-pins.o \
-				board-mop500-msp.o
+				board-mop500-msp.o \
+				board-mop500-audio.o
 obj-$(CONFIG_MACH_U5500)	+= board-u5500.o board-u5500-sdi.o
 obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
new file mode 100644
index 0000000..e50b6a9
--- /dev/null
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+
+#include <mach/board-mop500-audio.h>
+
+static struct mop500_audio_platform_data mop500_audio_pdata = {
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
+/* Platform device for MOP500 audio-parts */
+static struct platform_device mop500_audio = {
+	.name = "snd-soc-mop500",
+	.id = 0,
+	.dev = {
+		.platform_data = &mop500_audio_pdata,
+	},
+};
+
+/* Platform device for Ux500-PCM */
+static struct platform_device ux500_pcm = {
+	.name = "ux500-pcm",
+	.id = 0,
+	.dev = {
+		.platform_data = NULL,
+	},
+};
+
+int mop500_audio_init(struct device *parent)
+{
+	int ret;
+
+	pr_info("%s: Register platform-device 'snd-soc-mop500'.\n", __func__);
+	ret = platform_device_register(&mop500_audio);
+
+	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
+	ret |= platform_device_register(&ux500_pcm);
+
+	return ret;
+};
diff --git a/arch/arm/mach-ux500/board-mop500-msp.c b/arch/arm/mach-ux500/board-mop500-msp.c
index c8f6300..2354bd0 100644
--- a/arch/arm/mach-ux500/board-mop500-msp.c
+++ b/arch/arm/mach-ux500/board-mop500-msp.c
@@ -5,21 +5,16 @@
  */
 
 #include <linux/platform_device.h>
-#include <linux/init.h>
 #include <linux/gpio.h>
-#include <plat/gpio-nomadik.h>
 
+#include <plat/gpio-nomadik.h>
 #include <plat/pincfg.h>
 #include <plat/ste_dma40.h>
 
-#include <mach/devices.h>
 #include <ste-dma40-db8500.h>
-#include <mach/hardware.h>
-#include <mach/irqs.h>
-#include <mach/msp.h>
 
-#include "board-mop500.h"
-#include "devices-db8500.h"
+#include <mach/board-mop500-msp.h>
+
 #include "pins-db8500.h"
 
 /* MSP1/3 Tx/Rx usage protection */
@@ -100,7 +95,7 @@ static struct stedma40_chan_cfg msp0_dma_tx = {
 	/* data_width is set during configuration */
 };
 
-static struct msp_i2s_platform_data msp0_platform_data = {
+static struct msp_i2s_platform_data msp0_pdata = {
 	.id = MSP_I2S_0,
 	.msp_i2s_dma_rx = &msp0_dma_rx,
 	.msp_i2s_dma_tx = &msp0_dma_tx,
@@ -132,7 +127,7 @@ static struct stedma40_chan_cfg msp1_dma_tx = {
 	/* data_width is set during configuration */
 };
 
-static struct msp_i2s_platform_data msp1_platform_data = {
+static struct msp_i2s_platform_data msp1_pdata = {
 	.id = MSP_I2S_1,
 	.msp_i2s_dma_rx = NULL,
 	.msp_i2s_dma_tx = &msp1_dma_tx,
@@ -170,7 +165,7 @@ static struct stedma40_chan_cfg msp2_dma_tx = {
 	/* data_width is set during configuration */
 };
 
-static int db8500_add_msp_i2s(struct device *parent, int id,
+static int mop500_msp_register_device(struct device *parent, int id,
 			resource_size_t base, int irq,
 			struct msp_i2s_platform_data *pdata)
 {
@@ -180,46 +175,28 @@ static int db8500_add_msp_i2s(struct device *parent, int id,
 		DEFINE_RES_IRQ(irq),
 	};
 
-	pr_info("Register platform-device 'ux500-msp-i2s', id %d, irq %d\n",
-		id, irq);
+	pr_info("%s: Register platform-device 'ux500-msp-i2s', id %d, irq %d\n",
+		__func__, id, irq);
 	pdev = platform_device_register_resndata(parent, "ux500-msp-i2s", id,
 						res, ARRAY_SIZE(res),
 						pdata, sizeof(*pdata));
 	if (!pdev) {
-		pr_err("Failed to register platform-device 'ux500-msp-i2s.%d'!\n",
-			id);
+		pr_err("%s: Failed to register platform-device 'ux500-msp-i2s.%d'!\n",
+			__func__, id);
 		return -EIO;
 	}
 
 	return 0;
 }
 
-/* Platform device for ASoC U8500 machine */
-static struct platform_device snd_soc_u8500 = {
-		.name = "snd-soc-u8500",
-		.id = 0,
-		.dev = {
-			.platform_data = NULL,
-		},
-};
-
-/* Platform device for Ux500-PCM */
-static struct platform_device ux500_pcm = {
-		.name = "ux500-pcm",
-		.id = 0,
-		.dev = {
-			.platform_data = NULL,
-		},
-};
-
-static struct msp_i2s_platform_data msp2_platform_data = {
+static struct msp_i2s_platform_data msp2_pdata = {
 	.id = MSP_I2S_2,
 	.msp_i2s_dma_rx = &msp2_dma_rx,
 	.msp_i2s_dma_tx = &msp2_dma_tx,
 };
 
-static struct msp_i2s_platform_data msp3_platform_data = {
-	.id		= MSP_I2S_3,
+static struct msp_i2s_platform_data msp3_pdata = {
+	.id = MSP_I2S_3,
 	.msp_i2s_dma_rx	= &msp1_dma_rx,
 	.msp_i2s_dma_tx	= NULL,
 	.msp_i2s_init = msp13_i2s_init,
@@ -230,21 +207,16 @@ int mop500_msp_init(struct device *parent)
 {
 	int ret;
 
-	pr_info("%s: Register platform-device 'snd-soc-u8500'.\n", __func__);
-	platform_device_register(&snd_soc_u8500);
-
-	pr_info("Initialize MSP I2S-devices.\n");
-	ret = db8500_add_msp_i2s(parent, 0, U8500_MSP0_BASE, IRQ_DB8500_MSP0,
-				&msp0_platform_data);
-	ret |= db8500_add_msp_i2s(parent, 1, U8500_MSP1_BASE, IRQ_DB8500_MSP1,
-				&msp1_platform_data);
-	ret |= db8500_add_msp_i2s(parent, 2, U8500_MSP2_BASE, IRQ_DB8500_MSP2,
-				&msp2_platform_data);
-	ret |= db8500_add_msp_i2s(parent, 3, U8500_MSP3_BASE, IRQ_DB8500_MSP1,
-				&msp3_platform_data);
-
-	pr_info("%s: Register platform-device 'ux500-pcm'\n", __func__);
-	platform_device_register(&ux500_pcm);
+	pr_info("%s: Initialize MSP I2S-devices.\n", __func__);
+	ret = mop500_msp_register_device(parent, 0, U8500_MSP0_BASE,
+				IRQ_DB8500_MSP0, &msp0_pdata);
+	ret |= mop500_msp_register_device(parent, 1, U8500_MSP1_BASE,
+				IRQ_DB8500_MSP1, &msp1_pdata);
+	ret |= mop500_msp_register_device(parent, 2, U8500_MSP2_BASE,
+				IRQ_DB8500_MSP2, &msp2_pdata);
+	ret |= mop500_msp_register_device(parent, 3, U8500_MSP3_BASE,
+				IRQ_DB8500_MSP1, &msp3_pdata);
 
 	return ret;
-}
+};
+
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 4cbed08..3d975df 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -53,7 +53,7 @@
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
-#include "board-mop500-msp.h"
+
 
 static struct gpio_led snowball_led_array[] = {
 	{
@@ -633,6 +633,7 @@ static void __init mop500_init_machine(void)
 	mop500_sdi_init(parent);
 	mop500_spi_init(parent);
 	mop500_msp_init(parent);
+	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -665,6 +666,7 @@ static void __init snowball_init_machine(void)
 	snowball_sdi_init(parent);
 	mop500_spi_init(parent);
 	mop500_msp_init(parent);
+	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
@@ -703,6 +705,7 @@ static void __init hrefv60_init_machine(void)
 	hrefv60_sdi_init(parent);
 	mop500_spi_init(parent);
 	mop500_msp_init(parent);
+	mop500_audio_init(parent);
 	mop500_uart_init(parent);
 
 	i2c0_devs = ARRAY_SIZE(mop500_i2c0_devices);
diff --git a/arch/arm/mach-ux500/board-mop500.h b/arch/arm/mach-ux500/board-mop500.h
index fdcfa87..a5e1ccb 100644
--- a/arch/arm/mach-ux500/board-mop500.h
+++ b/arch/arm/mach-ux500/board-mop500.h
@@ -84,6 +84,8 @@ void __init mop500_stuib_init(void);
 void __init mop500_pins_init(void);
 void __init hrefv60_pins_init(void);
 void __init snowball_pins_init(void);
+int mop500_msp_init(struct device *parent);
+int mop500_audio_init(struct device *parent);
 
 void mop500_uib_i2c_add(int busnum, struct i2c_board_info *info,
 		unsigned n);
diff --git a/arch/arm/mach-ux500/include/mach/board-mop500-audio.h b/arch/arm/mach-ux500/include/mach/board-mop500-audio.h
new file mode 100644
index 0000000..15ffea6
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/board-mop500-audio.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2012
+ *
+ * Author: Ola Lilja <ola.o.lilja@stericsson.com>
+ *         for ST-Ericsson.
+ *
+ * License terms:
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef __BOARD_MOP500_AUDIO_H_
+#define __BOARD_MOP500_AUDIO_H_
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
+/* Platform data structure for the audio-parts of the MOP500 */
+struct mop500_audio_platform_data {
+	struct amic_settings amics;
+	enum ear_cm_voltage ear_cmv;
+};
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/board-mop500-msp.h b/arch/arm/mach-ux500/include/mach/board-mop500-msp.h
new file mode 100644
index 0000000..3c096b2
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/board-mop500-msp.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
+ * License terms: GNU General Public License (GPL), version 2.
+ */
+
+
+#ifndef __BOARD_MOP500_MSP_H_
+#define __BOARD_MOP500_MSP_H_
+
+#include <plat/ste_dma40.h>
+
+enum msp_i2s_id {
+	MSP_I2S_0 = 0,
+	MSP_I2S_1,
+	MSP_I2S_2,
+	MSP_I2S_3,
+};
+
+/* Platform data structure for a MSP I2S-device */
+struct msp_i2s_platform_data {
+	enum msp_i2s_id id;
+	struct stedma40_chan_cfg *msp_i2s_dma_rx;
+	struct stedma40_chan_cfg *msp_i2s_dma_tx;
+	int (*msp_i2s_init) (void);
+	int (*msp_i2s_exit) (void);
+};
+
+
+
+#endif
-- 
1.7.8.3
