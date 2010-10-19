From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 10/25] ASoC: Samsung: Rename s3c64xx I2S device
Date: Tue, 19 Oct 2010 16:06:52 +0900
Message-ID: <1287472012-27800-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 0276F10392A
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

Since the I2S of S3C64XX and newer SoCs are incremental
versions of each other with changes managable in a single
driver, rename the 's3c64xx-iis' -> 'samsung-i2s'

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/mach-s3c64xx/dev-audio.c   |    6 +++---
 arch/arm/mach-s5p6440/dev-audio.c   |    2 +-
 arch/arm/mach-s5p6442/dev-audio.c   |    4 ++--
 arch/arm/mach-s5pc100/dev-audio.c   |    6 +++---
 arch/arm/mach-s5pv210/dev-audio.c   |    6 +++---
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c  |    4 ++--
 sound/soc/s3c24xx/s3c64xx-i2s.c     |    4 ++--
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/dev-audio.c b/arch/arm/mach-s3c64xx/dev-audio.c
index 1615c94..01dda91 100644
--- a/arch/arm/mach-s3c64xx/dev-audio.c
+++ b/arch/arm/mach-s3c64xx/dev-audio.c
@@ -89,7 +89,7 @@ static struct s3c_audio_pdata s3c_i2s0_pdata = {
 };
 
 struct platform_device s3c64xx_device_iis0 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 0,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis0_resource),
 	.resource	  = s3c64xx_iis0_resource,
@@ -122,7 +122,7 @@ static struct s3c_audio_pdata s3c_i2s1_pdata = {
 };
 
 struct platform_device s3c64xx_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iis1_resource),
 	.resource	  = s3c64xx_iis1_resource,
@@ -155,7 +155,7 @@ static struct s3c_audio_pdata s3c_i2sv4_pdata = {
 };
 
 struct platform_device s3c64xx_device_iisv4 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s3c64xx_iisv4_resource),
 	.resource	  = s3c64xx_iisv4_resource,
diff --git a/arch/arm/mach-s5p6440/dev-audio.c b/arch/arm/mach-s5p6440/dev-audio.c
index 3ca0d2b..5d98629 100644
--- a/arch/arm/mach-s5p6440/dev-audio.c
+++ b/arch/arm/mach-s5p6440/dev-audio.c
@@ -64,7 +64,7 @@ static struct resource s5p6440_iis0_resource[] = {
 };
 
 struct platform_device s5p6440_device_iis = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5p6440_iis0_resource),
 	.resource	  = s5p6440_iis0_resource,
diff --git a/arch/arm/mach-s5p6442/dev-audio.c b/arch/arm/mach-s5p6442/dev-audio.c
index 7a4e347..1419442 100644
--- a/arch/arm/mach-s5p6442/dev-audio.c
+++ b/arch/arm/mach-s5p6442/dev-audio.c
@@ -70,7 +70,7 @@ static struct resource s5p6442_iis0_resource[] = {
 };
 
 struct platform_device s5p6442_device_iis0 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis0_resource),
 	.resource	  = s5p6442_iis0_resource,
@@ -98,7 +98,7 @@ static struct resource s5p6442_iis1_resource[] = {
 };
 
 struct platform_device s5p6442_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s5p6442_iis1_resource),
 	.resource	  = s5p6442_iis1_resource,
diff --git a/arch/arm/mach-s5pc100/dev-audio.c b/arch/arm/mach-s5pc100/dev-audio.c
index 4207511..3cf22ff 100644
--- a/arch/arm/mach-s5pc100/dev-audio.c
+++ b/arch/arm/mach-s5pc100/dev-audio.c
@@ -73,7 +73,7 @@ static struct resource s5pc100_iis0_resource[] = {
 };
 
 struct platform_device s5pc100_device_iis0 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis0_resource),
 	.resource	  = s5pc100_iis0_resource,
@@ -101,7 +101,7 @@ static struct resource s5pc100_iis1_resource[] = {
 };
 
 struct platform_device s5pc100_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis1_resource),
 	.resource	  = s5pc100_iis1_resource,
@@ -129,7 +129,7 @@ static struct resource s5pc100_iis2_resource[] = {
 };
 
 struct platform_device s5pc100_device_iis2 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s5pc100_iis2_resource),
 	.resource	  = s5pc100_iis2_resource,
diff --git a/arch/arm/mach-s5pv210/dev-audio.c b/arch/arm/mach-s5pv210/dev-audio.c
index e6db957..6e60041 100644
--- a/arch/arm/mach-s5pv210/dev-audio.c
+++ b/arch/arm/mach-s5pv210/dev-audio.c
@@ -80,7 +80,7 @@ static struct resource s5pv210_iis0_resource[] = {
 };
 
 struct platform_device s5pv210_device_iis0 = {
-	.name		  = "s3c64xx-iis-v4",
+	.name		  = "samsung-i2s-v4",
 	.id		  = -1,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis0_resource),
 	.resource	  = s5pv210_iis0_resource,
@@ -108,7 +108,7 @@ static struct resource s5pv210_iis1_resource[] = {
 };
 
 struct platform_device s5pv210_device_iis1 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 1,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis1_resource),
 	.resource	  = s5pv210_iis1_resource,
@@ -136,7 +136,7 @@ static struct resource s5pv210_iis2_resource[] = {
 };
 
 struct platform_device s5pv210_device_iis2 = {
-	.name		  = "s3c64xx-iis",
+	.name		  = "samsung-i2s",
 	.id		  = 2,
 	.num_resources	  = ARRAY_SIZE(s5pv210_iis2_resource),
 	.resource	  = s5pv210_iis2_resource,
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
index 46b65d7..8a08041 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s-v4.c
@@ -206,7 +206,7 @@ static struct platform_driver s3c64xx_i2sv4_driver = {
 	.probe  = s3c64xx_i2sv4_dev_probe,
 	.remove = s3c64xx_i2sv4_dev_remove,
 	.driver = {
-		.name = "s3c64xx-iis-v4",
+		.name = "samsung-i2s-v4",
 		.owner = THIS_MODULE,
 	},
 };
@@ -227,4 +227,4 @@ module_exit(s3c64xx_i2sv4_exit);
 MODULE_AUTHOR("Jaswinder Singh, <jassi.brar@samsung.com>");
 MODULE_DESCRIPTION("S3C64XX I2Sv4 SoC Interface");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s3c64xx-iis-v4");
+MODULE_ALIAS("platform:samsung-i2s-v4");
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.c b/sound/soc/s3c24xx/s3c64xx-i2s.c
index 0288d4e..0fefbb5 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.c
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.c
@@ -218,7 +218,7 @@ static struct platform_driver s3c64xx_iis_driver = {
 	.probe  = s3c64xx_iis_dev_probe,
 	.remove = s3c64xx_iis_dev_remove,
 	.driver = {
-		.name = "s3c64xx-iis",
+		.name = "samsung-i2s",
 		.owner = THIS_MODULE,
 	},
 };
@@ -239,4 +239,4 @@ module_exit(s3c64xx_i2s_exit);
 MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
 MODULE_DESCRIPTION("S3C64XX I2S SoC Interface");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:s3c64xx-iis");
+MODULE_ALIAS("platform:samsung-i2s");
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 9ddc964..1d59317 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -222,7 +222,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Playback i/f */
 	.name = "WM8580 PAIF RX",
 	.stream_name = "Playback",
-	.cpu_dai_name = "s3c64xx-iis-v4",
+	.cpu_dai_name = "samsung-i2s-v4",
 	.codec_dai_name = "wm8580-hifi-playback",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
@@ -232,7 +232,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
 	.stream_name = "Capture",
-	.cpu_dai_name = "s3c64xx-iis-v4",
+	.cpu_dai_name = "samsung-i2s-v4",
 	.codec_dai_name = "wm8580-hifi-capture",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
-- 
1.6.2.5
