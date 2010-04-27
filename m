From: Jassi Brar <jassi.brar@samsung.com>
Subject: [PATCH 11/11] ASoC: SMDK64XX: Switch to IISv4 CPU
	driver
Date: Tue, 27 Apr 2010 15:57:17 +0900
Message-ID: <1272351437-4015-1-git-send-email-jassi.brar@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 900FF24821
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:00:24 +0200 (CEST)
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
Cc: broonie@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, ben-linux@fluff.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Switch the MACHINE driver to use IISv4 CPU dai.
Remove BROKEN dependency now that we have proper CPU driver available.
Also, disable build for SMDK6400, since the S3C6400 doesn't have IISv4
controller.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig           |    7 +++----
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    6 ++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index c0c7edf..2a7cc22 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -64,12 +64,11 @@ config SND_S3C24XX_SOC_JIVE_WM8750
 
 config SND_S3C64XX_SOC_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
-	depends on SND_S3C24XX_SOC && (MACH_SMDK6400 || MACH_SMDK6410)
-	depends on BROKEN
+	depends on SND_S3C24XX_SOC && MACH_SMDK6410
 	select SND_SOC_WM8580
-	select SND_S3C64XX_SOC_I2S
+	select SND_S3C64XX_SOC_I2S_V4
 	help
-	  Sat Y if you want to add support for SoC audio on the SMDK64XX.
+	  Say Y if you want to add support for SoC audio on the SMDK6410.
 
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index efe4901..07e8e51 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk64xx_wm8580.c
@@ -22,8 +22,6 @@
 #include "s3c-dma.h"
 #include "s3c64xx-i2s.h"
 
-#define S3C64XX_I2S_V4 2
-
 /* SMDK64XX has a 12MHZ crystal attached to WM8580 */
 #define SMDK64XX_WM8580_FREQ 12000000
 
@@ -215,7 +213,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Playback i/f */
 	.name = "WM8580 PAIF RX",
 	.stream_name = "Playback",
-	.cpu_dai = &s3c64xx_i2s_dai[S3C64XX_I2S_V4],
+	.cpu_dai = &s3c64xx_i2s_v4_dai,
 	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFRX],
 	.init = smdk64xx_wm8580_init_paifrx,
 	.ops = &smdk64xx_ops,
@@ -223,7 +221,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
 	.stream_name = "Capture",
-	.cpu_dai = &s3c64xx_i2s_dai[S3C64XX_I2S_V4],
+	.cpu_dai = &s3c64xx_i2s_v4_dai,
 	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFTX],
 	.init = smdk64xx_wm8580_init_paiftx,
 	.ops = &smdk64xx_ops,
-- 
1.6.2.5
