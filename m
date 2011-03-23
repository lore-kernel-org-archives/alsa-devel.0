From: =?UTF-8?B?UHJjaGFsIEppxZnDrQ==?= <jiri.prchal@aksignal.cz>
Subject: Re: PROBLEM: Asoc driver in 2.6.37.3 for AT91SAM9260 /
 TLV320AIC3X is broken
Date: Wed, 23 Mar 2011 14:53:22 +0100
Message-ID: <4D89FB52.60405@aksignal.cz>
References: <4D79E428.2060408@aksignal.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050008090300000905080106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from router.aksignal.cz (router.aksignal.cz [188.175.113.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 959F1243ED
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 14:53:28 +0100 (CET)
In-Reply-To: <4D79E428.2060408@aksignal.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: support@atmel.com
Cc: slapin@ossfans.org, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050008090300000905080106
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
I fixed the problem:
in file "linux-2.6.38/sound/soc/atmel/snd-soc-afeb9260.c"
in function "afeb9260_soc_init"
is missing "platform_device_alloc("soc-audio", -1);".

I also add SPI functionality and external clock on BCLK to codec tlv320ai=
c3x.
I'm sending diff, is this the right way to add it as patch to kernel rele=
ases?

I also discover the problem with SD card: not all cards can run at 375kHz=
 at init state, I change minimal freq to
200kHz. It's in diff too.

Dne 11.3.2011 09:58, Prchal Ji=C5=99=C3=AD napsal(a):
> Hallo,
> at first I would like to apologize of sending this report to too many m=
ails, but I can't find the right person / list.
>=20
> [2.] Full description of the problem/report:
> I try for almost 2 month to make kernel with alsa for my hardware. I fi=
rst try version 2.6.37, now trying 2.6.37.3. My
> hw i similar to board afeb-9260, just with difference my codec is TLV32=
0AIC3106 connected as slave with clock on BCLK.
> So I change file snd-soc-afeb9260.c, diff is attached, and Kconfig and =
Makefile too.
> In version 2.6.35.11 it works good, but MMC/SD card doesn't work. (Some=
thing is broken it that driver just in this
> version). I need to work sound and SD card.
> I thing the problem is somewhere between "tlv320aic3x-codec 0-001a: pro=
be" and "i2c-core: driver [tlv320aic3x-codec]
> registered". In version 2.6.35.11 there is I2C communication, in 2.6.37=
 and higher nothing on I2C.
> I also try to put newer alsa 1.0.24 to kernel 2.6.37.3 without any impr=
ovement.
> Trying to put older alsa (but same version?) from kernel 2.6.35.11 to 2=
.6.37.3 produce soundcard, but when try to play
> kernel oops, "cannot dereference null pointer" and freezes.
>=20

--------------050008090300000905080106
Content-Type: text/x-patch;
 name="patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="patch.diff"

diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/arch/arm/mach-at91/Kconfig b/linux-2.6.38/arch/arm/mach-at91/Kconfig
--- a/linux-2.6.38/arch/arm/mach-at91/Kconfig	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/arch/arm/mach-at91/Kconfig	2011-03-16 09:19:40.000000000 +0100
@@ -213,6 +213,12 @@
 	  Select this if you are using Atmel's AT91SAM9260-EK or AT91SAM9XE Evaluation Kit
 	  <http://www.atmel.com/dyn/products/tools_card.asp?tool_id=3933>
 
+config MACH_CDU
+	bool "CDU AKsignal board"
+	help
+	  Select this if you are using AKsignal CDU board
+	  <http://www.aksignal.cz>
+
 config MACH_CAM60
 	bool "KwikByte KB9260 (CAM60) board"
 	help
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/arch/arm/mach-at91/Makefile b/linux-2.6.38/arch/arm/mach-at91/Makefile
--- a/linux-2.6.38/arch/arm/mach-at91/Makefile	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/arch/arm/mach-at91/Makefile	2011-03-16 09:19:40.000000000 +0100
@@ -40,6 +40,7 @@
 
 # AT91SAM9260 board-specific support
 obj-$(CONFIG_MACH_AT91SAM9260EK) += board-sam9260ek.o
+obj-$(CONFIG_MACH_CDU)		 += board-cdu.o
 obj-$(CONFIG_MACH_CAM60)	+= board-cam60.o
 obj-$(CONFIG_MACH_SAM9_L9260)	+= board-sam9-l9260.o
 obj-$(CONFIG_MACH_USB_A9260)	+= board-usb-a9260.o
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/arch/arm/mach-at91/board-cdu.c b/linux-2.6.38/arch/arm/mach-at91/board-cdu.c
--- a/linux-2.6.38/arch/arm/mach-at91/board-cdu.c	1970-01-01 01:00:00.000000000 +0100
+++ b/linux-2.6.38/arch/arm/mach-at91/board-cdu.c	2011-03-23 11:15:47.000000000 +0100
@@ -0,0 +1,351 @@
+/*
+ * linux/arch/arm/mach-at91/board-cdu.c
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2006 Atmel
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/clk.h>
+#include <linux/spi/mcp23s08.h>
+#include <linux/dma-mapping.h>
+
+#include <mach/hardware.h>
+#include <asm/setup.h>
+#include <asm/mach-types.h>
+#include <asm/irq.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/irq.h>
+
+#include <mach/board.h>
+#include <mach/gpio.h>
+#include <mach/at91sam9_smc.h>
+
+#include "sam9_smc.h"
+#include "generic.h"
+
+
+static void __init cdu_map_io(void)
+{
+	/* Initialize processor: 6 MHz crystal */
+	at91sam9260_initialize (6000000);
+
+	/* DBGU on ttyS0. (Rx & Tx only) */
+	at91_register_uart(0, 0, 0);
+
+	/* USART0 on ttyS1. (Rx, Tx, CTS, RTS, DTR, DSR, DCD, RI) */
+	at91_register_uart(AT91SAM9260_ID_US0, 1, ATMEL_UART_CTS | ATMEL_UART_RTS
+			   | ATMEL_UART_DTR | ATMEL_UART_DSR | ATMEL_UART_DCD
+			   | ATMEL_UART_RI);
+
+	/* USART1 on ttyS2. (Rx, Tx, RTS) */
+	at91_register_uart(AT91SAM9260_ID_US1, 2, ATMEL_UART_RTS);
+
+	/* USART2 on ttyS3. (Rx, Tx, RTS) */
+	at91_register_uart(AT91SAM9260_ID_US2, 3, ATMEL_UART_RTS);
+
+	/* USART3 on ttyS4. (Rx, Tx, RTS) */
+	at91_register_uart(AT91SAM9260_ID_US3, 4, ATMEL_UART_RTS);
+
+	/* USART4 on ttyS5. (Tx) */
+	// EBUS - transmit audio, no rx
+	//at91_register_uart(AT91SAM9260_ID_US4, 5, 0);
+
+	/* set serial console to ttyS0 (ie, DBGU) */
+	at91_set_serial_console(0);
+}
+
+static void __init cdu_init_irq(void)
+{
+	at91sam9260_init_interrupts(NULL);
+}
+
+
+/*
+ * USB Host port
+ */
+static struct at91_usbh_data __initdata cdu_usbh_data = {
+	.ports		= 2,
+};
+
+/*
+ * USB Device port
+ */
+static struct at91_udc_data __initdata cdu_udc_data = {
+	.vbus_pin	= AT91_PIN_PC15,
+	.pullup_pin	= 0,		/* pull-up driven by UDC */
+};
+
+
+/*
+ * SPI devices.
+ */
+#define MCP23S08_GPIO_BASE    128
+
+static const struct mcp23s08_platform_data mcp23s08_gpio_info = {
+  .chip[0].is_present = true,
+  .chip[0].pullups = 0,
+  .base = MCP23S08_GPIO_BASE,
+};
+
+static struct spi_board_info cdu_spi_devices[] = {
+	{ // ADC LTC2488
+		.modalias	= "spidev",
+		.chip_select	= 0,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	},
+	{ // GPIO expander MCP23S08
+		.modalias	= "mcp23s08",
+		.chip_select	= 1,
+		.max_speed_hz	= 1000000,
+		.bus_num	= 1,
+		.platform_data	= &mcp23s08_gpio_info,
+		.mode		= SPI_MODE_3,
+	},
+	{ // non volatile memory (F-RAM) FM25VN10
+		.modalias	= "spidev",
+		.chip_select	= 2,
+		.max_speed_hz	= 1 * 1000 * 1000,
+		.bus_num	= 1,
+	},
+	{ // audiocodec TLV320AIC3106
+		.modalias	= "tlv320aic3x-codec",
+		.chip_select	= 3,
+		.max_speed_hz	= 1000000,
+		.bus_num	= 1,
+		.mode		= SPI_MODE_1,
+	},
+};
+
+
+/*
+ * MACB Ethernet device
+ */
+static struct at91_eth_data __initdata cdu_macb_data = {
+	.phy_irq_pin	= 0, //nc,
+	.is_rmii	= 1,
+};
+
+
+/*
+ * NAND flash
+ */
+static struct mtd_partition __initdata cdu_nand_partition[] = {
+	{
+	  .name   = "bootstrap",
+	  .offset = 0,
+	  .size   = 0x40000,
+	},
+	{
+	  .name   = "uboot",
+	  .offset = 0x40000,
+	  .size   = (0xc0000 - 0x40000),
+	},
+	{
+	  .name   = "ubootenv",
+	  .offset = 0xc0000,
+	  .size   = (0x100000 - 0xc0000),
+	},
+	{
+	  .name   = "kernel",
+	  .offset = 0x100000,
+	  .size   = (0x400000 - 0x100000),
+	},
+	{
+	  .name   = "rootfs",
+	  .offset = 0x400000,
+	  .size   = (0x8000000 - 0x400000),
+	},
+};
+
+static struct mtd_partition * __init nand_partitions(int size, int *num_partitions)
+{
+	*num_partitions = ARRAY_SIZE(cdu_nand_partition);
+	return cdu_nand_partition;
+}
+
+static struct atmel_nand_data __initdata cdu_nand_data = {
+	.ale		= 21,
+	.cle		= 22,
+//	.det_pin	= ... not connected
+	.rdy_pin	= AT91_PIN_PC13,
+	.enable_pin	= AT91_PIN_PC14,
+	.partition_info	= nand_partitions,
+	.bus_width_16	= 0,
+};
+
+static struct sam9_smc_config __initdata cdu_nand_smc_config = {
+	.ncs_read_setup		= 0,
+	.nrd_setup		= 1,
+	.ncs_write_setup	= 0,
+	.nwe_setup		= 1,
+
+	.ncs_read_pulse		= 3,
+	.nrd_pulse		= 3,
+	.ncs_write_pulse	= 3,
+	.nwe_pulse		= 3,
+
+	.read_cycle		= 5,
+	.write_cycle		= 5,
+
+	.mode			= AT91_SMC_READMODE | AT91_SMC_WRITEMODE | AT91_SMC_EXNWMODE_DISABLE,
+	.tdf_cycles		= 2,
+};
+
+static void __init cdu_add_device_nand(void)
+{
+	/* setup bus-width (8 or 16) */
+	if (cdu_nand_data.bus_width_16)
+		cdu_nand_smc_config.mode |= AT91_SMC_DBW_16;
+	else
+		cdu_nand_smc_config.mode |= AT91_SMC_DBW_8;
+
+	/* configure chip-select 3 (NAND) */
+	sam9_smc_configure(3, &cdu_nand_smc_config);
+
+	at91_add_device_nand(&cdu_nand_data);
+}
+
+
+/*
+* MCI (SD/MMC)
+*/
+static struct at91_mmc_data __initdata ek_mmc_data = {
+  .slot_b		= 0,
+  .wire4		= 1,
+  //	.det_pin	= ... not connected
+  //	.wp_pin		= ... not connected
+  //	.vcc_pin	= ... not connected
+};
+
+
+/*
+ * LEDs
+ */
+static struct gpio_led cdu_leds[] = {
+  {    // Red led
+    .name            = "red",
+    .gpio            = AT91_PIN_PC10,
+    .default_trigger = "timer",
+  },
+  {    // Green led
+    .name            = "green",
+    .gpio            = AT91_PIN_PA5,
+    .default_trigger = "heartbeat",
+  },
+  {   // Yellow led
+    .name            = "yellow",
+    .gpio            = AT91_PIN_PB20,
+    .active_low      = 1,
+    .default_trigger = "mmc0",
+  },
+  {   // Blue led
+    .name            = "blue",
+    .gpio            = AT91_PIN_PB21,
+    .active_low      = 1,
+    .default_trigger = "nand-disk",
+  },
+};
+
+
+/*
+ * GPIOs
+ */
+static struct gpio gpios[] = {
+  { AT91_PIN_PA0,  GPIOF_OUT_INIT_LOW,  "ebus_dir"},
+  { AT91_PIN_PA1,  GPIOF_OUT_INIT_LOW,  "time_dir"},
+  { AT91_PIN_PB12, GPIOF_OUT_INIT_LOW,  "gsm_rst"},
+  { AT91_PIN_PB13, GPIOF_OUT_INIT_LOW,  "gsm_on"},
+  { AT91_PIN_PC2,  GPIOF_IN,            "por"},
+  { AT91_PIN_PC7,  GPIOF_OUT_INIT_HIGH, "spk_shdn"},
+
+  { AT91_PIN_PC0,  GPIOF_IN,            "in0"},
+  { AT91_PIN_PC1,  GPIOF_IN,            "in1"},
+  { AT91_PIN_PA22, GPIOF_IN,            "in4"},
+  { AT91_PIN_PA23, GPIOF_IN,            "in5"},
+  { AT91_PIN_PA24, GPIOF_IN,            "in6"},
+  { AT91_PIN_PA25, GPIOF_IN,            "in7"},
+
+  { AT91_PIN_PA26, GPIOF_OUT_INIT_LOW,  "out2"},
+  { AT91_PIN_PA27, GPIOF_OUT_INIT_LOW,  "out3"},
+  { AT91_PIN_PA28, GPIOF_OUT_INIT_LOW,  "out4"},
+  { AT91_PIN_PA29, GPIOF_OUT_INIT_LOW,  "out5"},
+  { AT91_PIN_PA30, GPIOF_OUT_INIT_LOW,  "out6"},
+  { AT91_PIN_PB29, GPIOF_OUT_INIT_LOW,  "out7"},
+
+  { MCP23S08_GPIO_BASE + 0, GPIOF_IN,   "busadrp"},
+  { MCP23S08_GPIO_BASE + 2, GPIOF_IN,   "busadr5"},
+  { MCP23S08_GPIO_BASE + 3, GPIOF_IN,   "busadr4"},
+  { MCP23S08_GPIO_BASE + 4, GPIOF_IN,   "busadr3"},
+  { MCP23S08_GPIO_BASE + 5, GPIOF_IN,   "busadr2"},
+  { MCP23S08_GPIO_BASE + 6, GPIOF_IN,   "busadr1"},
+  { MCP23S08_GPIO_BASE + 7, GPIOF_IN,   "busadr0"},
+};
+
+static void __init cdu_add_gpio (void)
+{
+  int i;
+
+  for (i = 0; i < ARRAY_SIZE (gpios); i++) {
+    gpio_request_one (gpios[i].gpio, gpios[i].flags, gpios[i].label);
+    gpio_export_name (gpios[i].gpio, 0, gpios[i].label);
+  }
+}
+
+/*
+ * init
+ */
+static void __init cdu_board_init(void)
+{
+	/* Serial */
+	at91_add_device_serial();
+	/* USB Host */
+	at91_add_device_usbh(&cdu_usbh_data);
+	/* USB Device */
+	at91_add_device_udc(&cdu_udc_data);
+	/* SPI */
+	at91_add_device_spi(cdu_spi_devices, ARRAY_SIZE(cdu_spi_devices));
+	/* NAND */
+	cdu_add_device_nand();
+	/* Ethernet */
+	at91_add_device_eth(&cdu_macb_data);
+	/* MMC */
+	at91_add_device_mmc(0, &ek_mmc_data);
+	/* SSC */
+	at91_add_device_ssc(AT91SAM9260_ID_SSC, (ATMEL_SSC_TF | ATMEL_SSC_TK | ATMEL_SSC_TD | ATMEL_SSC_RD));
+	/* LEDs */
+	at91_gpio_leds(cdu_leds, ARRAY_SIZE(cdu_leds));
+	// GPIO
+	cdu_add_gpio ();
+}
+
+MACHINE_START(AT91SAM9260EK, "CDU")
+	/* Maintainer: Atmel */
+	.boot_params	= AT91_SDRAM_BASE + 0x100,
+	.timer		= &at91sam926x_timer,
+	.map_io		= cdu_map_io,
+	.init_irq	= cdu_init_irq,
+	.init_machine	= cdu_board_init,
+MACHINE_END
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/drivers/gpio/gpiolib.c b/linux-2.6.38/drivers/gpio/gpiolib.c
--- a/linux-2.6.38/drivers/gpio/gpiolib.c	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/drivers/gpio/gpiolib.c	2011-03-16 09:21:44.000000000 +0100
@@ -769,6 +769,85 @@
 	return dev_get_drvdata(dev) == data;
 }
 
+
+/**
+* gpio_export_name - export a GPIO through sysfs
+* @gpio: gpio to make available, already requested
+* @direction_may_change: true if userspace may change gpio direction
+* @name: name in sysfs
+* Context: arch_initcall or later
+*
+* When drivers want to make a GPIO accessible to userspace after they
+* have requested it -- perhaps while debugging, or as part of their
+* public interface -- they may use this routine.  If the GPIO can
+* change direction (some can't) and the caller allows it, userspace
+* will see "direction" sysfs attribute which may be used to change
+* the gpio's direction.  A "value" attribute will always be provided.
+*
+* Returns zero on success, else an error.
+*/
+int gpio_export_name (unsigned gpio, bool direction_may_change, const char * ioname)
+{
+  unsigned long		flags;
+  struct gpio_desc	*desc;
+  int			status = -EINVAL;
+
+  /* can't export until sysfs is available ... */
+  if (!gpio_class.p) {
+    pr_debug("%s: called too early!\n", __func__);
+    return -ENOENT;
+  }
+
+  if (!gpio_is_valid(gpio))
+    goto done;
+
+  mutex_lock(&sysfs_lock);
+
+  spin_lock_irqsave(&gpio_lock, flags);
+  desc = &gpio_desc[gpio];
+  if (test_bit(FLAG_REQUESTED, &desc->flags)
+    && !test_bit(FLAG_EXPORT, &desc->flags)) {
+    status = 0;
+  if (!desc->chip->direction_input
+    || !desc->chip->direction_output)
+    direction_may_change = false;
+  }
+  spin_unlock_irqrestore(&gpio_lock, flags);
+
+  if (status == 0) {
+    struct device	*dev;
+
+    dev = device_create(&gpio_class, desc->chip->dev, MKDEV(0, 0),
+                         desc, ioname ? ioname : "gpio%u", gpio);
+    if (!IS_ERR(dev)) {
+      status = sysfs_create_group(&dev->kobj, &gpio_attr_group);
+
+      if (!status && direction_may_change)
+        status = device_create_file(dev, &dev_attr_direction);
+
+      if (!status && gpio_to_irq(gpio) >= 0 && (direction_may_change || !test_bit(FLAG_IS_OUT, &desc->flags)))
+        status = device_create_file(dev, &dev_attr_edge);
+
+      if (status != 0)
+        device_unregister(dev);
+      } else
+        status = PTR_ERR(dev);
+
+    if (status == 0)
+      set_bit(FLAG_EXPORT, &desc->flags);
+  }
+
+  mutex_unlock(&sysfs_lock);
+
+  done:
+  if (status)
+    pr_debug("%s: gpio%d status %d\n", __func__, gpio, status);
+
+  return status;
+}
+EXPORT_SYMBOL_GPL(gpio_export_name);
+
+
 /**
  * gpio_export_link - create a sysfs link to an exported GPIO node
  * @dev: device under which to create symlink
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/drivers/mmc/host/at91_mci.c b/linux-2.6.38/drivers/mmc/host/at91_mci.c
--- a/linux-2.6.38/drivers/mmc/host/at91_mci.c	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/drivers/mmc/host/at91_mci.c	2011-03-23 12:47:15.000000000 +0100
@@ -724,6 +724,10 @@
 		else
 			clkdiv = (at91_master_clock / ios->clock) / 2;
 
+		/* set maximum divider */
+		if (clkdiv > 255)
+		  clkdiv = 255;
+
 		pr_debug("clkdiv = %d. mcck = %ld\n", clkdiv,
 			at91_master_clock / (2 * (clkdiv + 1)));
 	}
@@ -944,7 +948,7 @@
 	}
 
 	mmc->ops = &at91_mci_ops;
-	mmc->f_min = 375000;
+	mmc->f_min = 200000; /* not all cards can run at 375kHz */
 	mmc->f_max = 25000000;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
 	mmc->caps = 0;
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/include/asm-generic/gpio.h b/linux-2.6.38/include/asm-generic/gpio.h
--- a/linux-2.6.38/include/asm-generic/gpio.h	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/include/asm-generic/gpio.h	2011-03-16 09:20:51.000000000 +0100
@@ -203,6 +203,7 @@
  * but more typically is configured entirely from userspace.
  */
 extern int gpio_export(unsigned gpio, bool direction_may_change);
+extern int gpio_export_name (unsigned gpio, bool direction_may_change, const char * ioname);
 extern int gpio_export_link(struct device *dev, const char *name,
 			unsigned gpio);
 extern int gpio_sysfs_set_active_low(unsigned gpio, int value);
@@ -252,6 +253,11 @@
 	return -ENOSYS;
 }
 
+static inline int gpio_export_name (unsigned gpio, bool direction_may_change, const char * ioname)
+{
+  return -ENOSYS;
+}
+
 static inline int gpio_export_link(struct device *dev, const char *name,
 				unsigned gpio)
 {
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/atmel/Kconfig b/linux-2.6.38/sound/soc/atmel/Kconfig
--- a/linux-2.6.38/sound/soc/atmel/Kconfig	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/sound/soc/atmel/Kconfig	2011-03-22 09:46:46.000000000 +0100
@@ -50,3 +50,11 @@
 	select SND_SOC_TLV320AIC23
 	help
 	  Say Y here to support sound on AFEB9260 board.
+
+config SND_AT91_SOC_CDU
+	tristate "SoC Audio support for CDU board"
+	depends on ARCH_AT91 && MACH_CDU && SND_ATMEL_SOC
+	select SND_ATMEL_SOC_SSC
+	select SND_SOC_TLV320AIC3X
+	help
+	  Say Y here to support sound on CDU board.
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/atmel/Makefile b/linux-2.6.38/sound/soc/atmel/Makefile
--- a/linux-2.6.38/sound/soc/atmel/Makefile	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/sound/soc/atmel/Makefile	2011-03-16 09:26:17.000000000 +0100
@@ -14,3 +14,4 @@
 obj-$(CONFIG_SND_AT91_SOC_SAM9G20_WM8731) += snd-soc-sam9g20-wm8731.o
 obj-$(CONFIG_SND_AT32_SOC_PLAYPAQ) += snd-soc-playpaq.o
 obj-$(CONFIG_SND_AT91_SOC_AFEB9260) += snd-soc-afeb9260.o
+obj-$(CONFIG_SND_AT91_SOC_CDU) += snd-soc-cdu.o
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/atmel/snd-soc-cdu.c b/linux-2.6.38/sound/soc/atmel/snd-soc-cdu.c
--- a/linux-2.6.38/sound/soc/atmel/snd-soc-cdu.c	1970-01-01 01:00:00.000000000 +0100
+++ b/linux-2.6.38/sound/soc/atmel/snd-soc-cdu.c	2011-03-22 14:00:32.000000000 +0100
@@ -0,0 +1,274 @@
+/*
+ * snd-soc-cdu  --  SoC audio for AT91SAM9260-based
+ * 			AKsignal CDU board.
+ *
+ *  Copyright (C) 2005 SAN People
+ *  Copyright (C) 2008 Atmel
+ *  Copyright (C) 2011 AKsignal Brno
+ *
+ * Authors: Sedji Gaouaou <sedji.gaouaou@atmel.com>
+ *                     Jiri Prchal <jiri.prchal@aksignal.cz>
+ *
+ * Based on ati_b1_wm8731.c by:
+ * Frank Mandarino <fmandarino@endrelia.com>
+ * Copyright 2006 Endrelia Technologies Inc.
+ * Based on corgi.c by:
+ * Copyright 2005 Wolfson Microelectronics PLC.
+ * Copyright 2005 Openedhand Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+
+#include <linux/atmel-ssc.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/gpio.h>
+
+#include "../codecs/tlv320aic3x.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
+
+struct {
+	unsigned int channels;
+	snd_pcm_format_t format;
+	unsigned int rate;
+	unsigned int codecclk;
+	unsigned int cmrdiv;
+	unsigned int period;
+} cdu_audio[] = {
+	/* 16 bit stereo modes */
+	{2, SNDRV_PCM_FORMAT_S16_LE, 8000, 2096000, 25, 130,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 16000, 2496000, 21, 77,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 32000, 2496000, 21, 38,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 48000, 2016000, 26, 20,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 96000, 4032000, 13, 20,},
+
+	{2, SNDRV_PCM_FORMAT_S16_LE, 11025, 2381400, 22, 107,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 22050, 2381400, 22, 53,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 44100, 2381400, 22, 26,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 88200, 4762800, 11, 26,},
+
+	{2, SNDRV_PCM_FORMAT_S16_LE, 11520, 2626560, 20, 113,},
+	{2, SNDRV_PCM_FORMAT_S16_LE, 23040, 2626560, 20, 56,},
+
+};
+
+static int cdu_hw_params(struct snd_pcm_substream *substream, struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	int ret;
+	int i, found = 0;
+	snd_pcm_format_t format = params_format(params);
+	unsigned int rate = params_rate(params);
+	unsigned int channels = params_channels(params);
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* set cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
+	if (ret < 0)
+		return ret;
+
+	/* find the correct audio parameters */
+	for (i = 0; i < ARRAY_SIZE(cdu_audio); i++) {
+		if (rate == cdu_audio[i].rate &&
+		    format == cdu_audio[i].format &&
+		    channels == cdu_audio[i].channels) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found)
+		return -EINVAL;
+
+	/* Set the codec system clock for DAC and ADC */
+	ret = snd_soc_dai_set_sysclk(codec_dai, CLKIN_BCLK, cdu_audio[i].codecclk, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set codec system clock\n");
+	  return ret;
+	}
+
+	/* Set the cpu clock dividers to BCLK */
+	ret = snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_CMR_DIV, cdu_audio[i].cmrdiv);
+	ret |= snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_TCMR_PERIOD, cdu_audio[i].period);
+	ret |= snd_soc_dai_set_clkdiv(cpu_dai, ATMEL_SSC_RCMR_PERIOD, cdu_audio[i].period);
+	if (ret < 0) {
+		printk(KERN_ERR "can't set cpu system clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct snd_soc_ops cdu_ops = {
+	.hw_params = cdu_hw_params,
+};
+
+static const struct snd_soc_dapm_widget cdu_dapm_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_LINE("Line Out", NULL),
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In", NULL),
+};
+
+static const struct snd_soc_dapm_route intercon[] = {
+  /* Headphone connected to HPLOUT, HPROUT */
+  {"Headphone Jack", NULL, "HPLOUT"},
+  {"Headphone Jack", NULL, "HPROUT"},
+
+  /* Line Out connected to LLOUT, RLOUT */
+  {"Line Out", NULL, "LLOUT"},
+  {"Line Out", NULL, "RLOUT"},
+
+  /* Mic connected to (MIC3L | MIC3R) */
+  {"MIC3L", NULL, "Mic Bias 2V"},
+  {"MIC3R", NULL, "Mic Bias 2V"},
+  {"Mic Bias 2V", NULL, "Mic Jack"},
+
+  /* Line In connected to (LINE1L | LINE2L), (LINE1R | LINE2R) */
+  {"LINE1L", NULL, "Line In"},
+  {"LINE2L", NULL, "Line In"},
+  {"LINE1R", NULL, "Line In"},
+  {"LINE2R", NULL, "Line In"},
+};
+
+/*
+ * Logic for a aic3x as connected on a cdu board.
+ */
+static int cdu_aic3x_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	int ret;
+
+	printk(KERN_DEBUG "cdu_aic3x: cdu_aic3x_init called\n");
+
+/*	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
+		MCLK_RATE, SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		printk(KERN_ERR "Failed to set WM8731 SYSCLK: %d\n", ret);
+		return ret;
+	}
+*/
+	/* Add specific widgets */
+	snd_soc_dapm_new_controls(dapm, cdu_dapm_widgets,
+				  ARRAY_SIZE(cdu_dapm_widgets));
+	/* Set up specific audio path interconnects */
+	snd_soc_dapm_add_routes(dapm, intercon, ARRAY_SIZE(intercon));
+
+	/* not connected */
+
+	/* always connected */
+	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line Out");
+	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
+	snd_soc_dapm_enable_pin(dapm, "Line In");
+
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link cdu_dai = {
+	.name = "TLV320AIC3106",
+	.stream_name = "PCM",
+	.cpu_dai_name = "atmel-ssc-dai.0",
+	.codec_dai_name = "tlv320aic3x-hifi",
+	.init = cdu_aic3x_init,
+	.platform_name = "atmel-pcm-audio",
+#if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
+	.codec_name = "tlv320aic3x-codec.0-001b",
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	.codec_name = "spi1.3",
+#endif
+	.ops = &cdu_ops,
+};
+
+static struct snd_soc_card snd_soc_cdu = {
+	.name = "TLV320AIC3106",
+	.dai_link = &cdu_dai,
+	.num_links = 1,
+};
+
+static struct platform_device *cdu_snd_device;
+
+static int __init cdu_init(void)
+{
+	struct clk *pllb;
+	int ret;
+
+	ret = atmel_ssc_set_audio(0);
+	if (ret != 0) {
+		pr_err("Failed to set SSC 0 for audio: %d\n", ret);
+		return ret;
+	}
+
+	cdu_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!cdu_snd_device) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		ret = -ENOMEM;
+	}
+
+	platform_set_drvdata(cdu_snd_device,
+			&snd_soc_cdu);
+
+	ret = platform_device_add(cdu_snd_device);
+	if (ret) {
+		printk(KERN_ERR "ASoC: Platform device allocation failed\n");
+		goto err_device_add;
+	}
+
+	return ret;
+
+err_device_add:
+	platform_device_put(cdu_snd_device);
+err:
+	return ret;
+}
+
+static void __exit cdu_exit(void)
+{
+	platform_device_unregister(cdu_snd_device);
+	cdu_snd_device = NULL;
+}
+
+module_init(cdu_init);
+module_exit(cdu_exit);
+
+/* Module information */
+MODULE_AUTHOR("Jiri Prchal <jiri.prchal@aksignal.cz>");
+MODULE_DESCRIPTION("ALSA SoC CDU_AIC3X");
+MODULE_LICENSE("GPL");
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/codecs/Kconfig b/linux-2.6.38/sound/soc/codecs/Kconfig
--- a/linux-2.6.38/sound/soc/codecs/Kconfig	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/sound/soc/codecs/Kconfig	2011-03-17 08:37:14.000000000 +0100
@@ -37,7 +37,7 @@
 	select SND_SOC_STAC9766 if SND_SOC_AC97_BUS
 	select SND_SOC_TLV320AIC23 if I2C
 	select SND_SOC_TLV320AIC26 if SPI_MASTER
-	select SND_SOC_TLV320AIC3X if I2C
+	select SND_SOC_TLV320AIC3X if SND_SOC_I2C_AND_SPI
 	select SND_SOC_TPA6130A2 if I2C
 	select SND_SOC_TLV320DAC33 if I2C
 	select SND_SOC_TWL4030 if TWL4030_CORE
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/codecs/tlv320aic3x.c b/linux-2.6.38/sound/soc/codecs/tlv320aic3x.c
--- a/linux-2.6.38/sound/soc/codecs/tlv320aic3x.c	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/sound/soc/codecs/tlv320aic3x.c	2011-03-22 13:43:27.000000000 +0100
@@ -42,6 +42,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -984,6 +985,13 @@
 {
 	struct snd_soc_codec *codec = codec_dai->codec;
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
+	u8 data;
+
+	/* set external clock on BCLK */
+	data = snd_soc_read(codec, AIC3X_CLKGEN_CTRL_REG);
+	data &= 0x0f;
+	data |= ((clk_id << PLLCLK_IN_SHIFT) | (clk_id << CLKDIV_IN_SHIFT));
+	snd_soc_write (codec, AIC3X_CLKGEN_CTRL_REG, data);
 
 	aic3x->sysclk = freq;
 	return 0;
@@ -1371,9 +1379,12 @@
 	aic3x->codec = codec;
 	codec->dapm.idle_bias_off = 1;
 
+	if (aic3x->control_type == SND_SOC_I2C)
 	ret = snd_soc_codec_set_cache_io(codec, 8, 8, aic3x->control_type);
+	else
+		ret = snd_soc_codec_set_cache_io(codec, 7, 8, aic3x->control_type);
 	if (ret != 0) {
-		dev_err(codec->dev, "Failed to set cache I/O: %d\n", ret);
+		dev_err(codec->dev, "failed to set cache I/O: %d\n", ret);
 		return ret;
 	}
 
@@ -1472,6 +1483,54 @@
 	.resume = aic3x_resume,
 };
 
+#if defined(CONFIG_SPI_MASTER)
+static int aic3x_spi_probe(struct spi_device *spi)
+{
+	struct aic3x_pdata *pdata = spi->dev.platform_data;
+	struct aic3x_priv *aic3x;
+	int ret;
+
+	aic3x = kzalloc(sizeof(struct aic3x_priv), GFP_KERNEL);
+	if (aic3x == NULL) {
+		dev_err(&spi->dev, "failed to create private data\n");
+		return -ENOMEM;
+	}
+
+	aic3x->control_type = SND_SOC_SPI;
+	spi_set_drvdata(spi, aic3x);
+
+	if (pdata) {
+		aic3x->gpio_reset = pdata->gpio_reset;
+		aic3x->setup = pdata->setup;
+	} else {
+		aic3x->gpio_reset = -1;
+	}
+
+	aic3x->model = AIC3X_MODEL_3X;
+
+	ret = snd_soc_register_codec(&spi->dev, &soc_codec_dev_aic3x, &aic3x_dai, 1);
+	if (ret < 0)
+		kfree(aic3x);
+	return ret;
+}
+
+static int __devexit aic3x_spi_remove(struct spi_device *spi)
+{
+	snd_soc_unregister_codec(&spi->dev);
+	kfree(spi_get_drvdata(spi));
+	return 0;
+}
+
+static struct spi_driver aic3x_spi_driver = {
+	.driver = {
+		.name	= "tlv320aic3x-codec",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= aic3x_spi_probe,
+	.remove		= __devexit_p(aic3x_spi_remove),
+};
+#endif /* CONFIG_SPI_MASTER */
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 /*
  * AIC3X 2 wire address can be up to 4 devices with device addresses
@@ -1557,6 +1616,13 @@
 		       ret);
 	}
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&aic3x_spi_driver);
+	if (ret != 0) {
+		printk(KERN_ERR "Failed to register AIC3X SPI driver: %d\n",
+			ret);
+	}
+#endif
 	return ret;
 }
 module_init(aic3x_modinit);
@@ -1566,6 +1632,9 @@
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 	i2c_del_driver(&aic3x_i2c_driver);
 #endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&aic3x_spi_driver);
+#endif
 }
 module_exit(aic3x_exit);
 
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/codecs/tlv320aic3x.h b/linux-2.6.38/sound/soc/codecs/tlv320aic3x.h
--- a/linux-2.6.38/sound/soc/codecs/tlv320aic3x.h	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/sound/soc/codecs/tlv320aic3x.h	2011-03-22 13:37:54.000000000 +0100
@@ -178,6 +178,13 @@
 #define PLL_CLKIN_SHIFT		4
 #define MCLK_SOURCE		0x0
 #define PLL_CLKDIV_SHIFT	0
+#define PLLCLK_IN_SHIFT		4
+#define CLKDIV_IN_SHIFT		6
+/* clock in source */
+#define CLKIN_MCLK		0
+#define CLKIN_GPIO2		1
+#define CLKIN_BCLK		2
+
 
 /* Software reset register bits */
 #define SOFT_RESET		0x80
diff -U 3 -H -b -w -B -E -d -r -N -- a/linux-2.6.38/sound/soc/soc-cache.c b/linux-2.6.38/sound/soc/soc-cache.c
--- a/linux-2.6.38/sound/soc/soc-cache.c	2011-03-15 02:20:32.000000000 +0100
+++ b/linux-2.6.38/sound/soc/soc-cache.c	2011-03-22 09:34:13.000000000 +0100
@@ -99,6 +99,58 @@
 #define snd_soc_4_12_spi_write NULL
 #endif
 
+/* special functions for codecs with 7 bit register address and LSB read/write */
+static unsigned int snd_soc_7_8_read(struct snd_soc_codec *codec,
+				     unsigned int reg)
+{
+	int ret;
+	unsigned int val;
+
+	if (reg >= codec->driver->reg_cache_size ||
+		snd_soc_codec_volatile_register(codec, reg)) {
+			if (codec->cache_only)
+				return -1;
+
+			BUG_ON(!codec->hw_read);
+			return codec->hw_read(codec, ((reg << 1) | 1));
+	}
+
+	ret = snd_soc_cache_read(codec, reg, &val);
+	if (ret < 0)
+		return -1;
+	return val;
+}
+
+static int snd_soc_7_8_write(struct snd_soc_codec *codec, unsigned int reg,
+			     unsigned int value)
+{
+	u8 data[2];
+	int ret;
+
+	data[0] = (reg << 1);
+	data[1] = value;
+
+	if (!snd_soc_codec_volatile_register(codec, reg) &&
+		reg < codec->driver->reg_cache_size) {
+		ret = snd_soc_cache_write(codec, reg, value);
+		if (ret < 0)
+			return -1;
+	}
+
+	if (codec->cache_only) {
+		codec->cache_sync = 1;
+		return 0;
+	}
+
+	ret = codec->hw_write(codec->control_data, data, 2);
+	if (ret == 2)
+		return 0;
+	if (ret < 0)
+		return ret;
+	else
+		return -EIO;
+}
+
 static unsigned int snd_soc_7_9_read(struct snd_soc_codec *codec,
 				     unsigned int reg)
 {
@@ -661,6 +713,11 @@
 		.spi_write = snd_soc_4_12_spi_write,
 	},
 	{
+		.addr_bits = 7, .data_bits = 8,
+		.write = snd_soc_7_8_write, .read = snd_soc_7_8_read,
+		.spi_write = snd_soc_8_8_spi_write,
+	},
+	{
 		.addr_bits = 7, .data_bits = 9,
 		.write = snd_soc_7_9_write, .read = snd_soc_7_9_read,
 		.spi_write = snd_soc_7_9_spi_write,

--------------050008090300000905080106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050008090300000905080106--
