From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCHv2 6/7] S3C64XX PCM: Defined PCM controller
	platform devices
Date: Tue, 17 Nov 2009 16:53:56 +0900
Message-ID: <1258444436-24394-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F8962444F
	for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2009 09:01:23 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c/include/plat/devs.h |    3 +
 arch/arm/plat-s3c64xx/dev-audio.c     |  101 ++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-s3c/include/plat/devs.h b/arch/arm/plat-s3c/include/plat/devs.h
index 0f540ea..932cbbb 100644
--- a/arch/arm/plat-s3c/include/plat/devs.h
+++ b/arch/arm/plat-s3c/include/plat/devs.h
@@ -28,6 +28,9 @@ extern struct platform_device s3c64xx_device_iis0;
 extern struct platform_device s3c64xx_device_iis1;
 extern struct platform_device s3c64xx_device_iisv4;
 
+extern struct platform_device s3c64xx_device_pcm0;
+extern struct platform_device s3c64xx_device_pcm1;
+
 extern struct platform_device s3c_device_fb;
 extern struct platform_device s3c_device_usb;
 extern struct platform_device s3c_device_lcd;
diff --git a/arch/arm/plat-s3c64xx/dev-audio.c b/arch/arm/plat-s3c64xx/dev-audio.c
index 1322beb..9e07344 100644
--- a/arch/arm/plat-s3c64xx/dev-audio.c
+++ b/arch/arm/plat-s3c64xx/dev-audio.c
@@ -15,9 +15,14 @@
 
 #include <mach/irqs.h>
 #include <mach/map.h>
+#include <mach/dma.h>
+#include <mach/gpio.h>
 
 #include <plat/devs.h>
-
+#include <plat/audio.h>
+#include <plat/gpio-bank-d.h>
+#include <plat/gpio-bank-e.h>
+#include <plat/gpio-cfg.h>
 
 static struct resource s3c64xx_iis0_resource[] = {
 	[0] = {
@@ -66,3 +71,97 @@ struct platform_device s3c64xx_device_iisv4 = {
 	.resource	  = s3c64xx_iisv4_resource,
 };
 EXPORT_SYMBOL(s3c64xx_device_iisv4);
+
+
+/* PCM Controller platform_devices */
+
+static int s3c64xx_pcm_cfg_gpio(struct platform_device *pdev)
+{
+	switch (pdev->id) {
+	case 0:
+		s3c_gpio_cfgpin(S3C64XX_GPD(0), S3C64XX_GPD0_PCM0_SCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(1), S3C64XX_GPD1_PCM0_EXTCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPD(2), S3C64XX_GPD2_PCM0_FSYNC);
+		s3c_gpio_cfgpin(S3C64XX_GPD(3), S3C64XX_GPD3_PCM0_SIN);
+		s3c_gpio_cfgpin(S3C64XX_GPD(4), S3C64XX_GPD4_PCM0_SOUT);
+		break;
+	case 1:
+		s3c_gpio_cfgpin(S3C64XX_GPE(0), S3C64XX_GPE0_PCM1_SCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(1), S3C64XX_GPE1_PCM1_EXTCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPE(2), S3C64XX_GPE2_PCM1_FSYNC);
+		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_PCM1_SIN);
+		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_PCM1_SOUT);
+		break;
+	default:
+		printk(KERN_DEBUG "Invalid PCM Controller number!");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct resource s3c64xx_pcm0_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_PCM0,
+		.end   = S3C64XX_PA_PCM0 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_PCM0_TX,
+		.end   = DMACH_PCM0_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_PCM0_RX,
+		.end   = DMACH_PCM0_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct s3c_audio_pdata s3c_pcm0_pdata = {
+	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
+};
+
+struct platform_device s3c64xx_device_pcm0 = {
+	.name		  = "samsung-pcm",
+	.id		  = 0,
+	.num_resources	  = ARRAY_SIZE(s3c64xx_pcm0_resource),
+	.resource	  = s3c64xx_pcm0_resource,
+	.dev = {
+		.platform_data = &s3c_pcm0_pdata,
+	},
+};
+EXPORT_SYMBOL(s3c64xx_device_pcm0);
+
+static struct resource s3c64xx_pcm1_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_PCM1,
+		.end   = S3C64XX_PA_PCM1 + 0x100 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = DMACH_PCM1_TX,
+		.end   = DMACH_PCM1_TX,
+		.flags = IORESOURCE_DMA,
+	},
+	[2] = {
+		.start = DMACH_PCM1_RX,
+		.end   = DMACH_PCM1_RX,
+		.flags = IORESOURCE_DMA,
+	},
+};
+
+struct s3c_audio_pdata s3c_pcm1_pdata = {
+	.cfg_gpio = s3c64xx_pcm_cfg_gpio,
+};
+
+struct platform_device s3c64xx_device_pcm1 = {
+	.name		  = "samsung-pcm",
+	.id		  = 1,
+	.num_resources	  = ARRAY_SIZE(s3c64xx_pcm1_resource),
+	.resource	  = s3c64xx_pcm1_resource,
+	.dev = {
+		.platform_data = &s3c_pcm1_pdata,
+	},
+};
+EXPORT_SYMBOL(s3c64xx_device_pcm1);
-- 
1.6.2.5
