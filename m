From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 12/25] ARM: S3C64XX: I2S: Upgrade platform
	device
Date: Tue, 19 Oct 2010 16:07:12 +0900
Message-ID: <1287472032-27931-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id E90B0103910
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:12:35 +0200 (CEST)
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

Add more information to I2S platform_devices in order to
prepare them for new controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/clock.c     |    2 +-
 arch/arm/mach-s3c64xx/dev-audio.c |   62 +++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index 7e03f0a..1c98d2f 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -695,7 +695,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk	= {
 			.name		= "audio-bus",
-			.id		= -1,  /* There's only one IISv4 port */
+			.id		= 2,
 			.ctrlbit        = S3C6410_CLKCON_SCLK_AUDIO2,
 			.enable		= s3c64xx_sclk_ctrl,
 		},
diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 01dda91..c2ad04c 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -27,7 +27,12 @@
 #include <mach/gpio-bank-e.h>
 #include <mach/gpio-bank-h.h>
 
-static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
+static const char *rclksrc[] = {
+	[0] = "iis",
+	[1] = "audio-bus",
+};
+
+static int s3c64xx_i2s_cfg_gpio(struct platform_device *pdev)
 {
 	switch (pdev->id) {
 	case 0:
@@ -44,6 +49,15 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 		s3c_gpio_cfgpin(S3C64XX_GPE(3), S3C64XX_GPE3_I2S1_DI);
 		s3c_gpio_cfgpin(S3C64XX_GPE(4), S3C64XX_GPE4_I2S1_D0);
 		break;
+	case 2:
+		s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
+		s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
+		s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
+		s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
+		s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
+		break;
 	default:
 		printk(KERN_DEBUG "Invalid I2S Controller number: %d\n",
 			pdev->id);
@@ -53,19 +67,6 @@ static int s3c64xx_i2sv3_cfg_gpio(struct platform_device *pdev)
 	return 0;
 }
 
-static int s3c64xx_i2sv4_cfg_gpio(struct platform_device *pdev)
-{
-	s3c_gpio_cfgpin(S3C64XX_GPC(4), S3C64XX_GPC4_I2S_V40_DO0);
-	s3c_gpio_cfgpin(S3C64XX_GPC(5), S3C64XX_GPC5_I2S_V40_DO1);
-	s3c_gpio_cfgpin(S3C64XX_GPC(7), S3C64XX_GPC7_I2S_V40_DO2);
-	s3c_gpio_cfgpin(S3C64XX_GPH(6), S3C64XX_GPH6_I2S_V40_BCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(7), S3C64XX_GPH7_I2S_V40_CDCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(8), S3C64XX_GPH8_I2S_V40_LRCLK);
-	s3c_gpio_cfgpin(S3C64XX_GPH(9), S3C64XX_GPH9_I2S_V40_DI);
-
-	return 0;
-}
-
 static struct resource s3c64xx_iis0_resource[] = {
 	[0] = {
 		.start = S3C64XX_PA_IIS0,
@@ -84,8 +85,13 @@ static struct resource s3c64xx_iis0_resource[] = {
 	},
 };
 
-static struct s3c_audio_pdata s3c_i2s0_pdata = {
-	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
+static struct s3c_audio_pdata i2sv3_pdata = {
+	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.type = {
+		.i2s = {
+			.src_clk = rclksrc,
+		},
+	},
 };
 
 struct platform_device s3c64xx_device_iis0 = {
@@ -94,7 +100,7 @@ struct platform_device s3c64xx_device_iis0 = {
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis0_resource),
 	.resource	  = s3c64xx_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s0_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis0);
@@ -117,17 +123,13 @@ static struct resource s3c64xx_iis1_resource[] = {
 	},
 };
 
-static struct s3c_audio_pdata s3c_i2s1_pdata = {
-	.cfg_gpio = s3c64xx_i2sv3_cfg_gpio,
-};
-
 struct platform_device s3c64xx_device_iis1 = {
 	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis1_resource),
 	.resource	  = s3c64xx_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s1_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iis1);
@@ -150,17 +152,23 @@ static struct resource s3c64xx_iisv4_resource[] = {
 	},
 };
 
-static struct s3c_audio_pdata s3c_i2sv4_pdata = {
-	.cfg_gpio = s3c64xx_i2sv4_cfg_gpio,
+static struct s3c_audio_pdata i2sv4_pdata = {
+	.cfg_gpio = s3c64xx_i2s_cfg_gpio,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN,
+			.src_clk = rclksrc,
+		},
+	},
 };
 
 struct platform_device s3c64xx_device_iisv4 = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name		  = "samsung-i2s",
+	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
 	.resource	  = s3c64xx_iisv4_resource,
 	.dev = {
-		.platform_data = &s3c_i2sv4_pdata,
+		.platform_data = &i2sv4_pdata,
 	},
 };
 EXPORT_SYMBOL(s3c64xx_device_iisv4);
-- 
1.6.2.5
