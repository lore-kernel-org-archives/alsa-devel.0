From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Implement initial S3C64XX IISv4 support
Date: Fri, 27 Nov 2009 16:54:28 +0000
Message-ID: <1259340868-12613-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5022C2463D
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 17:54:30 +0100 (CET)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, ben-linux@fluff.org, jassi.brar@samsung.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

The IISv4 port can be controlled by the IISv2 driver so copy over that
with light modifications, including use of platform data to get the pin
configuration. Currently this is S3C6410 specific due to the DMA
configuration - in the future when we have IISv4 specific support we may
want to split out a generic IISv4 portion.

Since this allows the SMDK64xx machine driver to work update it to
reflect the API changes involved and mark it as not BROKEN.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

This depends on the arch/arm changes I posted to linux-arm-kernel a
minute ago.  I'll not push it until it looks like those will be merged.

 sound/soc/s3c24xx/Kconfig           |   10 +++++++---
 sound/soc/s3c24xx/Makefile          |    2 ++
 sound/soc/s3c24xx/s3c64xx-i2s.h     |    1 +
 sound/soc/s3c24xx/smdk64xx_wm8580.c |    6 ++----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index b489f1a..1b98850 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -24,6 +24,11 @@ config SND_S3C64XX_SOC_I2S
 	select SND_S3C_I2SV2_SOC
 	select S3C64XX_DMA
 
+config SND_S3C64XX_SOC_I2S_V4
+	tristate
+	select SND_S3C_I2SV2_SOC
+	select S3C64XX_DMA
+
 config SND_S3C_SOC_PCM
 	tristate
 
@@ -62,11 +67,10 @@ config SND_S3C24XX_SOC_JIVE_WM8750
 config SND_S3C64XX_SOC_WM8580
 	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
 	depends on SND_S3C24XX_SOC && (MACH_SMDK6400 || MACH_SMDK6410)
-	depends on BROKEN
 	select SND_SOC_WM8580
-	select SND_S3C64XX_SOC_I2S
+	select SND_S3C64XX_SOC_I2S_V4
 	help
-	  Sat Y if you want to add support for SoC audio on the SMDK64XX.
+	  Say Y if you want to add support for SoC audio on the SMDK64XX.
 
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index b744657..114028c 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -3,6 +3,7 @@ snd-soc-s3c24xx-objs := s3c-dma.o
 snd-soc-s3c24xx-i2s-objs := s3c24xx-i2s.o
 snd-soc-s3c2412-i2s-objs := s3c2412-i2s.o
 snd-soc-s3c64xx-i2s-objs := s3c64xx-i2s.o
+snd-soc-s3c64xx-i2s-v4-objs := s3c64xx-i2s-v4.o
 snd-soc-s3c2443-ac97-objs := s3c2443-ac97.o
 snd-soc-s3c-i2s-v2-objs := s3c-i2s-v2.o
 snd-soc-s3c-pcm-objs := s3c-pcm.o
@@ -12,6 +13,7 @@ obj-$(CONFIG_SND_S3C24XX_SOC_I2S) += snd-soc-s3c24xx-i2s.o
 obj-$(CONFIG_SND_S3C2443_SOC_AC97) += snd-soc-s3c2443-ac97.o
 obj-$(CONFIG_SND_S3C2412_SOC_I2S) += snd-soc-s3c2412-i2s.o
 obj-$(CONFIG_SND_S3C64XX_SOC_I2S) += snd-soc-s3c64xx-i2s.o
+obj-$(CONFIG_SND_S3C64XX_SOC_I2S_V4) += snd-soc-s3c64xx-i2s-v4.o
 obj-$(CONFIG_SND_S3C_I2SV2_SOC) += snd-soc-s3c-i2s-v2.o
 obj-$(CONFIG_SND_S3C_SOC_PCM) += snd-soc-s3c-pcm.o
 
diff --git a/sound/soc/s3c24xx/s3c64xx-i2s.h b/sound/soc/s3c24xx/s3c64xx-i2s.h
index abe7253..a50b2dc 100644
--- a/sound/soc/s3c24xx/s3c64xx-i2s.h
+++ b/sound/soc/s3c24xx/s3c64xx-i2s.h
@@ -28,6 +28,7 @@ struct clk;
 #define S3C64XX_CLKSRC_CDCLK    (2)
 
 extern struct snd_soc_dai s3c64xx_i2s_dai[];
+extern struct snd_soc_dai s3c64xx_i2s_v4_dai[];
 
 extern struct clk *s3c64xx_i2s_get_clock(struct snd_soc_dai *dai);
 
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk64xx_wm8580.c
index efe4901..b5bb129 100644
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
+	.cpu_dai = &s3c64xx_i2s_v4_dai[0],
 	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFRX],
 	.init = smdk64xx_wm8580_init_paifrx,
 	.ops = &smdk64xx_ops,
@@ -223,7 +221,7 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
 	.stream_name = "Capture",
-	.cpu_dai = &s3c64xx_i2s_dai[S3C64XX_I2S_V4],
+	.cpu_dai = &s3c64xx_i2s_v4_dai[0],
 	.codec_dai = &wm8580_dai[WM8580_DAI_PAIFTX],
 	.init = smdk64xx_wm8580_init_paiftx,
 	.ops = &smdk64xx_ops,
-- 
1.6.5.3
