From: Christian Pellegrin <chripell@gmail.com>
Subject: [PATCH RESEND 3/3] ALSA SOC driver for s3c24xx with
	uda134x
Date: Sat, 15 Nov 2008 08:58:48 +0100
Message-ID: <12267359281701-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 55553103817
	for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2008 08:58:55 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so1420926fgg.44
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 23:58:55 -0800 (PST)
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
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Christian Pellegrin <chripell@fsfe.org>
List-Id: alsa-devel@alsa-project.org


Adds audio support for SMDK2410

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 arch/arm/mach-s3c2410/mach-smdk2410.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
--
Generated on  20081115  against f7e1798a78a30bae1cf3ebc3e1b6f7c1bac57756..5b7f05e9b57e7e442b1054cbb4423cf9909fb204
--
diff --git a/arch/arm/mach-s3c2410/mach-smdk2410.c b/arch/arm/mach-s3c2410/mach-smdk2410.c
index 152527b..0001d52 100644
--- a/arch/arm/mach-s3c2410/mach-smdk2410.c
+++ b/arch/arm/mach-s3c2410/mach-smdk2410.c
@@ -43,6 +43,7 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/regs-gpio.h>
 #include <asm/irq.h>
 #include <asm/mach-types.h>
 
@@ -53,6 +54,8 @@
 
 #include <plat/common-smdk.h>
 
+#include <sound/s3c24xx_uda134x.h>
+
 static struct map_desc smdk2410_iodesc[] __initdata = {
   /* nothing here yet */
 };
@@ -85,12 +88,27 @@ static struct s3c2410_uartcfg smdk2410_uartcfgs[] __initdata = {
 	}
 };
 
+static struct s3c24xx_uda134x_platform_data s3c24xx_uda134x_data = {
+       .l3_clk = S3C2410_GPB4,
+       .l3_data = S3C2410_GPB3,
+       .l3_mode = S3C2410_GPB2,
+       .model = UDA134X_UDA1341,
+};
+
+static struct platform_device s3c24xx_uda134x = {
+       .name             = "s3c24xx_uda134x",
+       .dev = {
+               .platform_data    = &s3c24xx_uda134x_data,
+       }
+};
+
 static struct platform_device *smdk2410_devices[] __initdata = {
 	&s3c_device_usb,
 	&s3c_device_lcd,
 	&s3c_device_wdt,
 	&s3c_device_i2c,
 	&s3c_device_iis,
+	&s3c24xx_uda134x,
 };
 
 static void __init smdk2410_map_io(void)
--
1.4.4.4
