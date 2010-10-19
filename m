From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 04/25] ARM: Samsung: Define common audio-dma
	device
Date: Tue, 19 Oct 2010 16:05:40 +0900
Message-ID: <1287471940-27598-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id C3491103934
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:40 +0200 (CEST)
In-Reply-To: <1P85Z9-0007a6-27>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, ben-linux@fluff.org, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

The ASoC uses common DMA driver for Audio devices. So it makes
sense to a common audio-dma device shared across all platforms.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c         |   13 -------------
 arch/arm/mach-s3c64xx/mach-smdk6410.c     |    2 +-
 arch/arm/plat-s3c24xx/devs.c              |   15 ---------------
 arch/arm/plat-samsung/Makefile            |    1 +
 arch/arm/plat-samsung/dev-asocdma.c       |   24 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h |    2 +-
 6 files changed, 27 insertions(+), 30 deletions(-)
 create mode 100644 arch/arm/plat-samsung/dev-asocdma.c

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index c45cc37..c730dd2 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -336,16 +336,3 @@ void __init s3c64xx_ac97_setup_gpio(int num)
 	else
 		s3c_ac97_pdata.cfg_gpio = s3c64xx_ac97_cfg_gpe;
 }
-
-static u64 s3c_device_audio_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_pcm = {
-	.name		  = "samsung-audio",
-	.id		  = -1,
-	.dev              = {
-		.dma_mask = &s3c_device_audio_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-EXPORT_SYMBOL(s3c_device_pcm);
-
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index ecbddd3..e2b18b8 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -283,7 +283,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
-	&s3c_device_pcm,
+	&samsung_asoc_dma,
 	&s3c64xx_device_iisv4,
 	&samsung_device_keypad,
 
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 4bf0b39..d8fb4e6 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -259,21 +259,6 @@ struct platform_device s3c_device_iis = {
 
 EXPORT_SYMBOL(s3c_device_iis);
 
-/* ASoC PCM DMA */
-
-static u64 s3c_device_audio_dmamask = 0xffffffffUL;
-
-struct platform_device s3c_device_pcm = {
-	.name		  = "samsung-audio",
-	.id		  = -1,
-	.dev              = {
-		.dma_mask = &s3c_device_audio_dmamask,
-		.coherent_dma_mask = 0xffffffffUL
-	}
-};
-
-EXPORT_SYMBOL(s3c_device_pcm);
-
 /* RTC */
 
 static struct resource s3c_rtc_resource[] = {
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4d8ff92..b97623a 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -17,6 +17,7 @@ obj-y				+= clock.o
 obj-y				+= pwm-clock.o
 obj-y				+= gpio.o
 obj-y				+= gpio-config.o
+obj-y				+= dev-asocdma.o
 
 obj-$(CONFIG_SAMSUNG_GPIOLIB_4BIT)	+= gpiolib.o
 obj-$(CONFIG_SAMSUNG_CLKSRC)	+= clock-clksrc.o
diff --git a/arch/arm/plat-samsung/dev-asocdma.c b/arch/arm/plat-samsung/dev-asocdma.c
new file mode 100644
index 0000000..b7b1fca
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-asocdma.c
@@ -0,0 +1,24 @@
+/* linux/arch/arm/plat-samsung/dev-asocdma.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co. Ltd
+ *	Jaswinder Singh <jassi.brar@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+static u64 audio_dmamask = DMA_BIT_MASK(32);
+
+struct platform_device samsung_asoc_dma = {
+	.name		  = "samsung-audio",
+	.id		  = -1,
+	.dev              = {
+		.dma_mask = &audio_dmamask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	}
+};
+EXPORT_SYMBOL(samsung_asoc_dma);
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index a9fecd6..21dfa68 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -32,7 +32,7 @@ extern struct platform_device s3c64xx_device_iisv4;
 extern struct platform_device s3c64xx_device_spi0;
 extern struct platform_device s3c64xx_device_spi1;
 
-extern struct platform_device s3c_device_pcm;
+extern struct platform_device samsung_asoc_dma;
 
 extern struct platform_device s3c64xx_device_pcm0;
 extern struct platform_device s3c64xx_device_pcm1;
-- 
1.6.2.5
