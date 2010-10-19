From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 15/25] ARM: S5PC100: I2S: Upgrade platform
	device
Date: Tue, 19 Oct 2010 16:07:34 +0900
Message-ID: <1287472054-29548-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id ECC18103920
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
 arch/arm/mach-s5pc100/dev-audio.c |   50 ++++++++++++++++++++++++++++--------
 1 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 3cf22ff..e14137b 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -23,6 +23,8 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 {
 	/* configure GPIO for i2s port */
 	switch (pdev->id) {
+	case 0: /* Dedicated pins */
+		break;
 	case 1:
 		s3c_gpio_cfgpin(S5PC100_GPC(0), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5PC100_GPC(1), S3C_GPIO_SFN(2));
@@ -30,7 +32,6 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 		s3c_gpio_cfgpin(S5PC100_GPC(3), S3C_GPIO_SFN(2));
 		s3c_gpio_cfgpin(S5PC100_GPC(4), S3C_GPIO_SFN(2));
 		break;
-
 	case 2:
 		s3c_gpio_cfgpin(S5PC100_GPG3(0), S3C_GPIO_SFN(4));
 		s3c_gpio_cfgpin(S5PC100_GPG3(1), S3C_GPIO_SFN(4));
@@ -38,10 +39,6 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 		s3c_gpio_cfgpin(S5PC100_GPG3(3), S3C_GPIO_SFN(4));
 		s3c_gpio_cfgpin(S5PC100_GPG3(4), S3C_GPIO_SFN(4));
 		break;
-
-	case -1: /* Dedicated pins */
-		break;
-
 	default:
 		printk(KERN_ERR "Invalid Device %d\n", pdev->id);
 		return -EINVAL;
@@ -50,8 +47,20 @@ static int s5pc100_cfg_i2s(struct platform_device *pdev)
 	return 0;
 }
 
-static struct s3c_audio_pdata s3c_i2s_pdata = {
+static const char *rclksrc_v5[] = {
+	[0] = "iis",
+	[1] = "i2sclkd2",
+};
+
+static struct s3c_audio_pdata i2sv5_pdata = {
 	.cfg_gpio = s5pc100_cfg_i2s,
+	.type = {
+		.i2s = {
+			.quirks = QUIRK_PRI_6CHAN | QUIRK_SEC_DAI
+					 | QUIRK_NEED_RSTCLR,
+			.src_clk = rclksrc_v5,
+		},
+	},
 };
 
 static struct resource s5pc100_iis0_resource[] = {
@@ -70,15 +79,34 @@ static struct resource s5pc100_iis0_resource[] = {
 		.end   = DMACH_I2S0_RX,
 		.flags = IORESOURCE_DMA,
 	},
+	[3] = {
+		.start = DMACH_I2S0S_TX,
+		.end   = DMACH_I2S0S_TX,
+		.flags = IORESOURCE_DMA,
+	},
 };
 
 struct platform_device s5pc100_device_iis0 = {
-	.name		  = "samsung-i2s-v4",
-	.id		  = -1,
+	.name		  = "samsung-i2s",
+	.id		  = 0,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis0_resource),
 	.resource	  = s5pc100_iis0_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv5_pdata,
+	},
+};
+
+static const char *rclksrc_v3[] = {
+	[0] = "iis",
+	[1] = "sclk_audio",
+};
+
+static struct s3c_audio_pdata i2sv3_pdata = {
+	.cfg_gpio = s5pc100_cfg_i2s,
+	.type = {
+		.i2s = {
+			.src_clk = rclksrc_v3,
+		},
 	},
 };
 
@@ -106,7 +134,7 @@ struct platform_device s5pc100_device_iis1 = {
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis1_resource),
 	.resource	  = s5pc100_iis1_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
@@ -134,7 +162,7 @@ struct platform_device s5pc100_device_iis2 = {
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis2_resource),
 	.resource	  = s5pc100_iis2_resource,
 	.dev = {
-		.platform_data = &s3c_i2s_pdata,
+		.platform_data = &i2sv3_pdata,
 	},
 };
 
-- 
1.6.2.5
