From: <vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v6 9/9] davinci: USB1.1 support for Omapl138-Hawkboard
Date: Fri, 29 Oct 2010 10:10:45 -0500
Message-ID: <1288365045-2709-10-git-send-email-vm.rod25@gmail.com>
References: <1288365045-2709-1-git-send-email-vm.rod25@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1288365045-2709-1-git-send-email-vm.rod25-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>

This patch adds USB1.1 support for the Hawkboard-L138 system

Signed-off-by: Victor Rodriguez <victor.rodriguez-Ut8ZLSGP1ULQT0dZR+AlfA@public.gmane.org>
---
Notes:

This patch works with da8xx_omapl_defconfig
In order to test it select in menuconfig like insmodule

 Device Drivers  --->
    SCSI device support  --->
       SCSI device support
       legacy /proc/scsi/ support
       SCSI disk support
       SCSI low-level drivers

       USB support  --->
               Support for Host-side US
               OHCI HCD support (NEW)
               USB Mass Storage support (NEW)
               USB Gadget Support  --->
               USB Gadget Drivers (Ethernet Gadget\
                (with CDC Ethernet support))  --->
               NOP USB Transceiver Driver

And you will be able to mount and USB pen drive

In order to connect a keyboard or a mouse on a USB-hub
select in menuconfig like insmodule

HID Devices  --->
       Generic HID support
       USB Human Interface Device (full HID) support

 arch/arm/mach-davinci/board-omapl138-hawk.c |  107 +++++++++++++++++++++++++++
 1 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 02e54fa..5c8202b 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -26,6 +26,9 @@
 #define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
 #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
+#define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
+#define DA850_USB1_OC_PIN		GPIO_TO_PIN(6, 13)
+
 static short omapl138_hawk_mii_pins[] __initdata = {
 	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
 	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
@@ -204,6 +207,108 @@ static __init void omapl138_hawk_mmc_init(void)
 			__func__, ret);
 }
 
+static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id);
+static da8xx_ocic_handler_t hawk_usb_ocic_handler;
+
+static const short da850_hawk_usb11_pins[] = {
+	DA850_GPIO2_4, DA850_GPIO6_13,
+	-1
+};
+
+static int hawk_usb_set_power(unsigned port, int on)
+{
+	gpio_set_value(DA850_USB1_VBUS_PIN, on);
+	return 0;
+}
+
+static int hawk_usb_get_power(unsigned port)
+{
+	return gpio_get_value(DA850_USB1_VBUS_PIN);
+}
+
+static int hawk_usb_get_oci(unsigned port)
+{
+	return !gpio_get_value(DA850_USB1_OC_PIN);
+}
+
+static int hawk_usb_ocic_notify(da8xx_ocic_handler_t handler)
+{
+	int irq         = gpio_to_irq(DA850_USB1_OC_PIN);
+	int error       = 0;
+
+	if (handler != NULL) {
+		hawk_usb_ocic_handler = handler;
+
+		error = request_irq(irq, omapl138_hawk_usb_ocic_irq,
+					IRQF_DISABLED | IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING,
+					"OHCI over-current indicator", NULL);
+		if (error)
+			pr_err(KERN_ERR "%s: could not request IRQ to watch "
+				"over-current indicator changes\n", __func__);
+	} else
+		free_irq(irq, NULL);
+
+	return error;
+}
+
+static struct da8xx_ohci_root_hub omapl138_hawk_usb11_pdata = {
+	.set_power      = hawk_usb_set_power,
+	.get_power      = hawk_usb_get_power,
+	.get_oci        = hawk_usb_get_oci,
+	.ocic_notify    = hawk_usb_ocic_notify,
+	/* TPS2087 switch @ 5V */
+	.potpgt         = (3 + 1) / 2,  /* 3 ms max */
+};
+
+static irqreturn_t omapl138_hawk_usb_ocic_irq(int irq, void *dev_id)
+{
+	hawk_usb_ocic_handler(&omapl138_hawk_usb11_pdata, 1);
+	return IRQ_HANDLED;
+}
+
+static __init void omapl138_hawk_usb_init(void)
+{
+	int ret;
+	u32 cfgchip2;
+
+	ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
+	if (ret) {
+		pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
+			__func__, ret);
+		return;
+	}
+
+	/*
+	 * Setup the Ref. clock frequency for the HAWK at 24 MHz.
+	 */
+	cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+	cfgchip2 &= ~CFGCHIP2_REFFREQ;
+	cfgchip2 |=  CFGCHIP2_REFFREQ_24MHZ;
+	__raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
+
+	ret = gpio_request_one(DA850_USB1_VBUS_PIN,
+			GPIOF_DIR_OUT, "USB1 VBUS");
+	if (ret < 0) {
+		pr_err(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
+			"power control: %d\n", __func__, ret);
+		return;
+	}
+
+	ret = gpio_request_one(DA850_USB1_OC_PIN,
+			GPIOF_DIR_IN, "USB1 OC");
+	if (ret < 0) {
+		pr_err(KERN_ERR "%s: failed to request GPIO for USB 1.1 port "
+			"over-current indicator: %d\n", __func__, ret);
+		return;
+	}
+
+	ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
+	if (ret)
+		pr_warning("%s: USB 1.1 registration failed: %d\n",
+			__func__, ret);
+}
+
 static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
 	.enabled_uarts = 0x7,
 };
@@ -236,6 +341,8 @@ static __init void omapl138_hawk_init(void)
 
 	omapl138_hawk_mmc_init();
 
+	omapl138_hawk_usb_init();
+
 	ret = da8xx_register_watchdog();
 	if (ret)
 		pr_warning("omapl138_hawk_init: "
-- 
1.7.0.4
