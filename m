From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] EDB93xx: Add support for CS4271 SPI-connected
	CODEC
Date: Fri, 04 Feb 2011 21:20:01 +0300
Message-ID: <1296843601.14577.14.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward18.mail.yandex.net (forward18.mail.yandex.net
	[95.108.253.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 70F13103B27
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 19:20:16 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opens>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Add support for CS4271 SPI-connected CODEC to EDB93xx.
Modified according to latest comments by H Hartley Sweeten.
        
Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 arch/arm/mach-ep93xx/edb93xx.c |   83 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
index 3f37567..2c2f84d 100644
--- a/arch/arm/mach-ep93xx/edb93xx.c
+++ b/arch/arm/mach-ep93xx/edb93xx.c
@@ -30,9 +30,13 @@
 #include <linux/gpio.h>
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
+#include <linux/spi/spi.h>
+
+#include <sound/cs4271.h>
 
 #include <mach/hardware.h>
 #include <mach/fb.h>
+#include <mach/ep93xx_spi.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -94,6 +98,83 @@ static void __init edb93xx_register_i2c(void)
 
 
 /*************************************************************************
+ * EDB93xx SPI peripheral handling
+ *************************************************************************/
+static struct cs4271_platform_data edb93xx_cs4271_data = {
+	.gpio_nreset	= -EINVAL,	/* filled in later */
+};
+
+static int edb93xx_cs4271_hw_setup(struct spi_device *spi)
+{
+	return gpio_request_one(EP93XX_GPIO_LINE_EGPIO6,
+				GPIOF_OUT_INIT_HIGH, spi->modalias);
+}
+
+static void edb93xx_cs4271_hw_cleanup(struct spi_device *spi)
+{
+	gpio_free(EP93XX_GPIO_LINE_EGPIO6);
+}
+
+static void edb93xx_cs4271_hw_cs_control(struct spi_device *spi, int value)
+{
+	gpio_set_value(EP93XX_GPIO_LINE_EGPIO6, value);
+}
+
+static struct ep93xx_spi_chip_ops edb93xx_cs4271_hw = {
+	.setup		= edb93xx_cs4271_hw_setup,
+	.cleanup	= edb93xx_cs4271_hw_cleanup,
+	.cs_control	= edb93xx_cs4271_hw_cs_control,
+};
+
+static struct spi_board_info edb93xx_spi_board_info[] __initdata = {
+	{
+		.modalias		= "cs4271",
+		.platform_data		= &edb93xx_cs4271_data,
+		.controller_data	= &edb93xx_cs4271_hw,
+		.max_speed_hz		= 6000000,
+		.bus_num		= 0,
+		.chip_select		= 0,
+		.mode			= SPI_MODE_3,
+	},
+};
+
+static struct ep93xx_spi_info edb93xx_spi_info __initdata = {
+	.num_chipselect	= ARRAY_SIZE(edb93xx_spi_board_info),
+};
+
+static void __init edb93xx_register_spi(void)
+{
+	if (machine_is_edb9301() || machine_is_edb9302())
+		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO1;
+	else if (machine_is_edb9302a() || machine_is_edb9307a())
+		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_H(2);
+	else if (machine_is_edb9315a())
+		edb93xx_cs4271_data.gpio_nreset = EP93XX_GPIO_LINE_EGPIO14;
+
+	ep93xx_register_spi(&edb93xx_spi_info, edb93xx_spi_board_info,
+			    ARRAY_SIZE(edb93xx_spi_board_info));
+}
+
+
+/*************************************************************************
+ * EDB93xx I2S
+ *************************************************************************/
+static int __init edb93xx_has_audio(void)
+{
+	return (machine_is_edb9301() || machine_is_edb9302() ||
+		machine_is_edb9302a() || machine_is_edb9307a() ||
+		machine_is_edb9315a());
+}
+
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
@@ -149,6 +230,8 @@ static void __init edb93xx_init_machine(void)
 	edb93xx_register_flash();
 	ep93xx_register_eth(&edb93xx_eth_data, 1);
 	edb93xx_register_i2c();
+	edb93xx_register_spi();
+	edb93xx_register_i2s();
 	edb93xx_register_pwm();
 	edb93xx_register_fb();
 }
