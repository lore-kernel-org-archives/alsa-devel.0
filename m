From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: [PATCH 15/18] ASoC: SMDK64XX: Rename for other
	platforms
Date: Tue, 26 Oct 2010 10:33:42 +0900
Message-ID: <1288056822-25224-1-git-send-email-jassisinghbrar@gmail.com>
References: <1288056632-24673-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ADA110390F
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

We plan to use the same ASoC Machine driver for most of
latest SMDK platforms. So rename the 64XX specific driver
to generic named.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/s3c24xx/Kconfig                          |    6 +-
 sound/soc/s3c24xx/Makefile                         |    4 +-
 .../s3c24xx/{smdk64xx_wm8580.c => smdk_wm8580.c}   |   64 ++++++++++----------
 3 files changed, 37 insertions(+), 37 deletions(-)
 rename sound/soc/s3c24xx/{smdk64xx_wm8580.c => smdk_wm8580.c} (78%)

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 32f1877..95bdd0d 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -59,13 +59,13 @@ config SND_S3C24XX_SOC_JIVE_WM8750
 	help
 	  Sat Y if you want to add support for SoC audio on the Jive.
 
-config SND_S3C64XX_SOC_WM8580
-	tristate "SoC I2S Audio support for WM8580 on SMDK64XX"
+config SND_SOC_SMDK_WM8580
+	tristate "SoC I2S Audio support for WM8580 on SMDK"
 	depends on SND_S3C24XX_SOC && MACH_SMDK6410
 	select SND_SOC_WM8580
 	select SND_SAMSUNG_I2S
 	help
-	  Say Y if you want to add support for SoC audio on the SMDK6410.
+	  Say Y if you want to add support for SoC audio on the SMDKs.
 
 config SND_S3C24XX_SOC_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index dac41ee..7eee57f 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -28,7 +28,7 @@ snd-soc-s3c24xx-simtec-objs := s3c24xx_simtec.o
 snd-soc-s3c24xx-simtec-hermes-objs := s3c24xx_simtec_hermes.o
 snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
-snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
+snd-soc-smdk-wm8580-objs := smdk_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
@@ -44,7 +44,7 @@ obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC) += snd-soc-s3c24xx-simtec.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_HERMES) += snd-soc-s3c24xx-simtec-hermes.o
 obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320aic23.o
 obj-$(CONFIG_SND_S3C24XX_SOC_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
-obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
+obj-$(CONFIG_SND_SOC_SMDK_WM8580) += snd-soc-smdk-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_SOC_SMDK_SPDIF) += snd-soc-smdk-spdif.o
diff --git a/sound/soc/s3c24xx/smdk64xx_wm8580.c b/sound/soc/s3c24xx/smdk_wm8580.c
similarity index 78%
rename from sound/soc/s3c24xx/smdk64xx_wm8580.c
rename to sound/soc/s3c24xx/smdk_wm8580.c
index 5f51db0..bbd6c97 100644
--- a/sound/soc/s3c24xx/smdk64xx_wm8580.c
+++ b/sound/soc/s3c24xx/smdk_wm8580.c
@@ -1,5 +1,5 @@
 /*
- *  smdk64xx_wm8580.c
+ *  smdk_wm8580.c
  *
  *  Copyright (c) 2009 Samsung Electronics Co. Ltd
  *  Author: Jaswinder Singh <jassi.brar@samsung.com>
@@ -28,10 +28,10 @@
  *   SMDK6410: Set CFG1 1-3 Off, CFG2 1-4 On
  */
 
-/* SMDK64XX has a 12MHZ crystal attached to WM8580 */
-#define SMDK64XX_WM8580_FREQ 12000000
+/* SMDK has a 12MHZ crystal attached to WM8580 */
+#define SMDK_WM8580_FREQ 12000000
 
-static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
+static int smdk_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *params)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
@@ -103,7 +103,7 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 
 	ret = snd_soc_dai_set_pll(codec_dai, WM8580_PLLA, 0,
-					SMDK64XX_WM8580_FREQ, pll_out);
+					SMDK_WM8580_FREQ, pll_out);
 	if (ret < 0)
 		return ret;
 
@@ -116,20 +116,20 @@ static int smdk64xx_hw_params(struct snd_pcm_substream *substream,
 }
 
 /*
- * SMDK64XX WM8580 DAI operations.
+ * SMDK WM8580 DAI operations.
  */
-static struct snd_soc_ops smdk64xx_ops = {
-	.hw_params = smdk64xx_hw_params,
+static struct snd_soc_ops smdk_ops = {
+	.hw_params = smdk_hw_params,
 };
 
-/* SMDK64xx Playback widgets */
+/* SMDK Playback widgets */
 static const struct snd_soc_dapm_widget wm8580_dapm_widgets_pbk[] = {
 	SND_SOC_DAPM_HP("Front", NULL),
 	SND_SOC_DAPM_HP("Center+Sub", NULL),
 	SND_SOC_DAPM_HP("Rear", NULL),
 };
 
-/* SMDK64xx Capture widgets */
+/* SMDK Capture widgets */
 static const struct snd_soc_dapm_widget wm8580_dapm_widgets_cpt[] = {
 	SND_SOC_DAPM_MIC("MicIn", NULL),
 	SND_SOC_DAPM_LINE("LineIn", NULL),
@@ -160,11 +160,11 @@ static const struct snd_soc_dapm_route audio_map_rx[] = {
 	{"Rear", NULL, "VOUT3R"},
 };
 
-static int smdk64xx_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
+static int smdk_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 
-	/* Add smdk64xx specific Capture widgets */
+	/* Add smdk specific Capture widgets */
 	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_cpt,
 				  ARRAY_SIZE(wm8580_dapm_widgets_cpt));
 
@@ -182,11 +182,11 @@ static int smdk64xx_wm8580_init_paiftx(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static int smdk64xx_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
+static int smdk_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_codec *codec = rtd->codec;
 
-	/* Add smdk64xx specific Playback widgets */
+	/* Add smdk specific Playback widgets */
 	snd_soc_dapm_new_controls(codec, wm8580_dapm_widgets_pbk,
 				  ARRAY_SIZE(wm8580_dapm_widgets_pbk));
 
@@ -199,7 +199,7 @@ static int smdk64xx_wm8580_init_paifrx(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_dai_link smdk64xx_dai[] = {
+static struct snd_soc_dai_link smdk_dai[] = {
 { /* Primary Playback i/f */
 	.name = "WM8580 PAIF RX",
 	.stream_name = "Playback",
@@ -207,8 +207,8 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.codec_dai_name = "wm8580-hifi-playback",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
-	.init = smdk64xx_wm8580_init_paifrx,
-	.ops = &smdk64xx_ops,
+	.init = smdk_wm8580_init_paifrx,
+	.ops = &smdk_ops,
 },
 { /* Primary Capture i/f */
 	.name = "WM8580 PAIF TX",
@@ -217,37 +217,37 @@ static struct snd_soc_dai_link smdk64xx_dai[] = {
 	.codec_dai_name = "wm8580-hifi-capture",
 	.platform_name = "samsung-audio",
 	.codec_name = "wm8580-codec.0-001b",
-	.init = smdk64xx_wm8580_init_paiftx,
-	.ops = &smdk64xx_ops,
+	.init = smdk_wm8580_init_paiftx,
+	.ops = &smdk_ops,
 },
 };
 
-static struct snd_soc_card smdk64xx = {
-	.name = "SMDK64xx 5.1",
-	.dai_link = smdk64xx_dai,
-	.num_links = ARRAY_SIZE(smdk64xx_dai),
+static struct snd_soc_card smdk = {
+	.name = "SMDK-I2S",
+	.dai_link = smdk_dai,
+	.num_links = ARRAY_SIZE(smdk_dai),
 };
 
-static struct platform_device *smdk64xx_snd_device;
+static struct platform_device *smdk_snd_device;
 
-static int __init smdk64xx_audio_init(void)
+static int __init smdk_audio_init(void)
 {
 	int ret;
 
-	smdk64xx_snd_device = platform_device_alloc("soc-audio", -1);
-	if (!smdk64xx_snd_device)
+	smdk_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_device)
 		return -ENOMEM;
 
-	platform_set_drvdata(smdk64xx_snd_device, &smdk64xx);
-	ret = platform_device_add(smdk64xx_snd_device);
+	platform_set_drvdata(smdk_snd_device, &smdk);
+	ret = platform_device_add(smdk_snd_device);
 
 	if (ret)
-		platform_device_put(smdk64xx_snd_device);
+		platform_device_put(smdk_snd_device);
 
 	return ret;
 }
-module_init(smdk64xx_audio_init);
+module_init(smdk_audio_init);
 
 MODULE_AUTHOR("Jaswinder Singh, jassi.brar@samsung.com");
-MODULE_DESCRIPTION("ALSA SoC SMDK64XX WM8580");
+MODULE_DESCRIPTION("ALSA SoC SMDK WM8580");
 MODULE_LICENSE("GPL");
-- 
1.6.2.5
