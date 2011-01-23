From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on
	EDB93xx boards
Date: Sun, 23 Jan 2011 03:51:24 +0300
Message-ID: <1295743884.14515.35.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward1.mail.yandex.net (forward1.mail.yandex.net [77.88.46.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BE7010384E
	for <alsa-devel@alsa-project.org>; Sun, 23 Jan 2011 01:51:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, George Kashperko <george@chas.com.ua>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Add support for CS4271 SPI-connected CODEC on EDB93xx boards.
        
Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 arch/arm/mach-ep93xx/edb93xx.c |   54 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 4b04316..9f9193d 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -30,12 +30,21 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+#include <mach/ep93xx_spi.h>
 
 #include <mach/hardware.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include <sound/cs4271.h>
+
+#define edb93xx_has_audio() (machine_is_edb9301() ||	\
+			     machine_is_edb9302() ||	\
+			     machine_is_edb9302a() ||	\
+			     machine_is_edb9307a() ||	\
+			     machine_is_edb9315a())
 
 static void __init edb93xx_register_flash(void)
 {
@@ -93,6 +102,49 @@ static void __init edb93xx_register_i2c(void)
 
 
 /*************************************************************************
+ * EDB93xx SPI peripheral handling
+ *************************************************************************/
+static struct cs4271_platform_data cs4271_edb93xx_gpio = {
+	.gpio_nreset	= EP93XX_GPIO_LINE_EGPIO1,
+	.gpio_disable	= EP93XX_GPIO_LINE_EGPIO6,
+};
+
+static struct spi_board_info edb93xx_spi_board_info[] = {
+	{
+		.modalias	= "cs4271",
+		.max_speed_hz	= 6000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_3,
+		.platform_data	= &cs4271_edb93xx_gpio,
+	},
+};
+
+static struct ep93xx_spi_info edb93xx_spi_info = {
+	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
+};
+
+static void __init edb93xx_register_spi(void)
+{
+	if (edb93xx_has_audio()) {
+		ep93xx_register_spi(&edb93xx_spi_info,
+				    edb93xx_spi_board_info,
+				    ARRAY_SIZE(edb93xx_spi_board_info));
+	}
+}
+
+/*************************************************************************
+ * EDB93xx I2S
+ *************************************************************************/
+static void __init edb93xx_register_i2s(void)
+{
+	if (edb93xx_has_audio()) {
+		ep93xx_register_i2s();
+	}
+}
+
+
+/*************************************************************************
  * EDB93xx pwm
  *************************************************************************/
 static void __init edb93xx_register_pwm(void)
@@ -117,6 +169,8 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_spi();
+	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 }
