From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 20/25] ASoC: SMDK64XX: Move to use new I2S
	driver
Date: Tue, 19 Oct 2010 16:08:13 +0900
Message-ID: <1287472093-31049-1-git-send-email-jassisinghbrar@gmail.com>
References: <1P85Z9-0007a6-27>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 5558C10394E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 09:17:48 +0200 (CEST)
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

Modify the smdk64xx_wm8580.c to use new i2s controller driver.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig           |    2 +-
 sound/soc/s3c24xx/smdk64xx_wm8580.c |   25 +++----------------------
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index f12e7c8..085a7b0 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -73,7 +73,7 @@ config SND_S3C64XX_SOC_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
 	depends on SND_S3C24XX_SOC && MACH_SMDK6410
 	select SND_SOC_WM8580
-	select SND_S3C64XX_SOC_I2S_V4
+	select SND_SAMSUNG_I2S
 	help
 	  Say Y if you want to add support for SoC audio on the SMDK6410.
 
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index 1d59317..5f51db0 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -20,7 +20,7 @@
 
 #include "../codecs/wm8580.h"
 #include "dma.h"
-#include "s3c64xx-i2s.h"
+#include "i2s.h"
 
 /*
  * Default CFG switch settings to use this driver:
@@ -96,17 +96,6 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_CDCLK,
-					0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
-	/* We use PCLK for basic ops in SoC-Slave mode */
-	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
-					0, SND_SOC_CLOCK_IN);
-	if (ret < 0)
-		return ret;
-
 	/* Set WM8580 to drive MCLK from its PLLA */
 	ret = snd_soc_dai_set_clkdiv(codec_dai, WM8580_MCLK,
 					WM8580_CLKSRC_PLLA);
@@ -123,14 +112,6 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_BCLK, bfs);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_clkdiv(cpu_dai, S3C_I2SV2_DIV_RCLK, rfs);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -222,7 +203,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Playback i/f */
 	.name = "WM8580 PAIF RX",
 	.stream_name = "Playback",
-	.cpu_dai_name = "samsung-i2s-v4",
+	.cpu_dai_name = "samsung-i2s.2",
 	.codec_dai_name = "wm8580-hifi-playback",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
@@ -232,7 +213,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
 	.stream_name = "Capture",
-	.cpu_dai_name = "samsung-i2s-v4",
+	.cpu_dai_name = "samsung-i2s.2",
 	.codec_dai_name = "wm8580-hifi-capture",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
-- 
1.6.2.5
