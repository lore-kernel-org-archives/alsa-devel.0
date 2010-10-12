From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: [patch 3/3] t5325: add audio support
Date: Tue, 12 Oct 2010 11:44:56 +0200
Message-ID: <20101012100039.492443712@rtp-net.org>
References: <20101012094453.660938870@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lechat.rtp-net.org (lechat.rtp-net.org [88.191.19.38])
	by alsa0.perex.cz (Postfix) with ESMTP id 225BE103A69
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 12:02:22 +0200 (CEST)
Content-Disposition: inline; filename=t5325-2.patch
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
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch declares the i2c audio codec and initialise audio.

Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Index: sound-2.6/arch/arm/mach-kirkwood/t5325-setup.c
===================================================================
--- sound-2.6.orig/arch/arm/mach-kirkwood/t5325-setup.c	2010-09-06 23:35:50.000000000 +0200
+++ sound-2.6/arch/arm/mach-kirkwood/t5325-setup.c	2010-09-06 23:42:21.000000000 +0200
@@ -23,6 +23,7 @@
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
+#include <sound/alc5623.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/kirkwood.h>
@@ -134,6 +135,7 @@
 	MPP33_GE1_TXCTL,
 	MPP39_AU_I2SBCLK,
 	MPP40_AU_I2SDO,
+	MPP43_AU_I2SDI,
 	MPP41_AU_I2SLRCLK,
 	MPP42_AU_I2SMCLK,
 	MPP45_GPIO,		/* Power button */
@@ -141,6 +143,18 @@
 	0
 };
 
+static struct alc5623_platform_data alc5621_data = {
+	.add_ctrl = 0x3700,
+	.jack_det_ctrl = 0x4810,
+};
+
+static struct i2c_board_info i2c_board_info[] __initdata = {
+	{
+		I2C_BOARD_INFO("alc5621", 0x1a),
+		.platform_data = &alc5621_data,
+	},
+};
+
 #define HP_T5325_GPIO_POWER_OFF		48
 
 static void hp_t5325_power_off(void)
@@ -166,6 +180,9 @@
 	kirkwood_ehci_init();
 	platform_device_register(&hp_t5325_button_device);
 
+	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
+	kirkwood_audio_init();
+
 	if (gpio_request(HP_T5325_GPIO_POWER_OFF, "power-off") == 0 &&
 	    gpio_direction_output(HP_T5325_GPIO_POWER_OFF, 0) == 0)
 		pm_power_off = hp_t5325_power_off;
