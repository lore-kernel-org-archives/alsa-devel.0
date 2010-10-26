From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 09/18] ASoC: Samsung: Rename s3c64xx I2S device
Date: Tue, 26 Oct 2010 10:33:40 +0900
Message-ID: <1288056820-25032-1-git-send-email-jassisinghbrar@gmail.com>
References: <1288056632-24673-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 38F5F103806
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 03:39:07 +0200 (CEST)
In-Reply-To: <1288056632-24673-1-git-send-email-jassisinghbrar@gmail.com>
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
Cc: kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com, june.bae@samsung.com, lrg@slimlogic.co.uk, sw.youn@samsung.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Since the I2S of S3C64XX and newer SoCs are incremental
versions of each other with changes managable in a single
driver, rename the 's3c64xx-iis' -> 'samsung-i2s'

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/s3c64xx-i2s-v4.c  |    4 ++--
 sound/soc/s3c24xx/s3c64xx-i2s.c     |    4 ++--
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

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
