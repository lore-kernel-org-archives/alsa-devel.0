From: Jassi@alsa-project.org, "Brar <jassisinghbrar"@gmail.com
Subject: [PATCH 10/10] ASoC: SMDKV310: Add I2S support
Date: Mon, 20 Dec 2010 11:05:57 +0900
Message-ID: <1292810757-30224-1-git-send-email-jassisinghbrar@gmail.com>
References: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 7363A103803
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 03:27:07 +0100 (CET)
In-Reply-To: <1292810667-29773-1-git-send-email-jassisinghbrar@gmail.com>
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
Cc: lrg@slimlogic.co.uk, kgene.kim@samsung.com, Jassi Brar <jassi.brar@samsung.com>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Jassi Brar <jassi.brar@samsung.com>

Add ASoC machine driver for SMDKV310/C210 boards that have
a WM8994 attached to I2S-0.

Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
---
 sound/soc/samsung/Kconfig       |    8 ++
 sound/soc/samsung/Makefile      |    2 +
 sound/soc/samsung/smdk_wm8994.c |  180 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 190 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/samsung/smdk_wm8994.c

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 9cedf34..11ff4ad 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -68,6 +68,14 @@ config ASOC_SAMSUNG_SMDK_WM8580
 	help
 	  Say Y if you want to add support for SoC audio on the SMDKs.
 
+config ASOC_SAMSUNG_SMDK_WM8994
+	tristate "SoC I2S Audio support for WM8994 on SMDK"
+	depends on ASOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
+	select SND_SOC_WM8994
+	select SND_SAMSUNG_I2S
+	help
+		Say Y if you want to add support for SoC audio on the SMDKs.
+
 config ASOC_SAMSUNG_SMDK2443_WM9710
 	tristate "SoC AC97 Audio support for SMDK2443 - WM9710"
 	depends on ASOC_SAMSUNG && MACH_SMDK2443
diff --git a/sound/soc/samsung/Makefile b/sound/soc/samsung/Makefile
index 622e76e..fe694cc 100644
--- a/sound/soc/samsung/Makefile
+++ b/sound/soc/samsung/Makefile
@@ -30,6 +30,7 @@ snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 snd-soc-h1940-uda1380-objs := h1940_uda1380.o
 snd-soc-rx1950-uda1380-objs := rx1950_uda1380.o
 snd-soc-smdk-wm8580-objs := smdk_wm8580.o
+snd-soc-smdk-wm8994-objs := smdk_wm8994.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-goni-wm8994-objs := goni_wm8994.o
@@ -47,6 +48,7 @@ obj-$(CONFIG_ASOC_SAMSUNG_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv320ai
 obj-$(CONFIG_ASOC_SAMSUNG_H1940_UDA1380) += snd-soc-h1940-uda1380.o
 obj-$(CONFIG_ASOC_SAMSUNG_RX1950_UDA1380) += snd-soc-rx1950-uda1380.o
 obj-$(CONFIG_ASOC_SAMSUNG_SMDK_WM8580) += snd-soc-smdk-wm8580.o
+obj-$(CONFIG_ASOC_SAMSUNG_SMDK_WM8994) += snd-soc-smdk-wm8994.o
 obj-$(CONFIG_ASOC_SAMSUNG_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_ASOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_ASOC_SAMSUNG_SMDK_SPDIF) += snd-soc-smdk-spdif.o
diff --git a/sound/soc/samsung/smdk_wm8994.c b/sound/soc/samsung/smdk_wm8994.c
new file mode 100644
index 0000000..25313f6
--- /dev/null
+++ b/sound/soc/samsung/smdk_wm8994.c
@@ -0,0 +1,176 @@
+/*
+ *  smdk_wm8994.c
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ */
+
+#include "../codecs/wm8994.h"
+
+ /*
+  * Default CFG switch settings to use this driver:
+  *	SMDKV310: CFG5-1000, CFG7-111111
+  */
+
+ /*
+  * Configure audio route as :-
+  * $ amixer sset 'DAC1' on,on
+  * $ amixer sset 'Right Headphone Mux' 'DAC'
+  * $ amixer sset 'Left Headphone Mux' 'DAC'
+  * $ amixer sset 'DAC1R Mixer AIF1.1' on
+  * $ amixer sset 'DAC1L Mixer AIF1.1' on
+  * $ amixer sset 'IN2L' on
+  * $ amixer sset 'IN2L PGA IN2LN' on
+  * $ amixer sset 'MIXINL IN2L' on
+  * $ amixer sset 'AIF1ADC1L Mixer ADC/DMIC' on
+  * $ amixer sset 'IN2R' on
+  * $ amixer sset 'IN2R PGA IN2RN' on
+  * $ amixer sset 'MIXINR IN2R' on
+  * $ amixer sset 'AIF1ADC1R Mixer ADC/DMIC' on
+  */
+
+/* SMDK has a 16.934MHZ crystal attached to WM8994 */
+#define SMDK_WM8994_FREQ 16934000
+
+static int smdk_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	unsigned int pll_out;
+	int ret;
+
+	/* AIF1CLK should be >=3MHz for optimal performance */
+	if (params_rate(params) == 8000 || params_rate(params) == 11025)
+		pll_out = params_rate(params) * 512;
+	else
+		pll_out = params_rate(params) * 256;
+
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S
+					 | SND_SOC_DAIFMT_NB_NF
+					 | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1, WM8994_FLL_SRC_MCLK1,
+					SMDK_WM8994_FREQ, pll_out);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL1,
+					pll_out, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * SMDK WM8994 DAI operations.
+ */
+static struct snd_soc_ops smdk_ops = {
+	.hw_params = smdk_hw_params,
+};
+
+static int smdk_wm8994_init_paiftx(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	struct snd_soc_dapm_context *dapm = &codec->dapm;
+
+	/* HeadPhone */
+	snd_soc_dapm_enable_pin(dapm, "HPOUT1R");
+	snd_soc_dapm_enable_pin(dapm, "HPOUT1L");
+
+	/* MicIn */
+	snd_soc_dapm_enable_pin(dapm, "IN1LN");
+	snd_soc_dapm_enable_pin(dapm, "IN1RN");
+
+	/* LineIn */
+	snd_soc_dapm_enable_pin(dapm, "IN2LN");
+	snd_soc_dapm_enable_pin(dapm, "IN2RN");
+
+	/* Other pins NC */
+	snd_soc_dapm_nc_pin(dapm, "HPOUT2P");
+	snd_soc_dapm_nc_pin(dapm, "HPOUT2N");
+	snd_soc_dapm_nc_pin(dapm, "SPKOUTLN");
+	snd_soc_dapm_nc_pin(dapm, "SPKOUTLP");
+	snd_soc_dapm_nc_pin(dapm, "SPKOUTRP");
+	snd_soc_dapm_nc_pin(dapm, "SPKOUTRN");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT1P");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2N");
+	snd_soc_dapm_nc_pin(dapm, "LINEOUT2P");
+	snd_soc_dapm_nc_pin(dapm, "IN1LP");
+	snd_soc_dapm_nc_pin(dapm, "IN2LP:VXRN");
+	snd_soc_dapm_nc_pin(dapm, "IN1RP");
+	snd_soc_dapm_nc_pin(dapm, "IN2RP:VXRP");
+
+	snd_soc_dapm_sync(dapm);
+
+	return 0;
+}
+
+static struct snd_soc_dai_link smdk_dai[] = {
+	{ /* Primary DAI i/f */
+		.name = "WM8994 AIF1",
+		.stream_name = "Pri_Dai",
+		.cpu_dai_name = "samsung-i2s.0",
+		.codec_dai_name = "wm8994-aif1",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8994-codec",
+		.init = smdk_wm8994_init_paiftx,
+		.ops = &smdk_ops,
+	}, { /* Sec_Fifo Playback i/f */
+		.name = "Sec_FIFO TX",
+		.stream_name = "Sec_Dai",
+		.cpu_dai_name = "samsung-i2s.4",
+		.codec_dai_name = "wm8994-aif1",
+		.platform_name = "samsung-audio",
+		.codec_name = "wm8994-codec",
+		.ops = &smdk_ops,
+	},
+};
+
+static struct snd_soc_card smdk = {
+	.name = "SMDK-I2S",
+	.dai_link = smdk_dai,
+	.num_links = ARRAY_SIZE(smdk_dai),
+};
+
+static struct platform_device *smdk_snd_device;
+
+static int __init smdk_audio_init(void)
+{
+	int ret;
+
+	smdk_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!smdk_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(smdk_snd_device, &smdk);
+
+	ret = platform_device_add(smdk_snd_device);
+	if (ret)
+		platform_device_put(smdk_snd_device);
+
+	return ret;
+}
+module_init(smdk_audio_init);
+
+static void __exit smdk_audio_exit(void)
+{
+	platform_device_unregister(smdk_snd_device);
+}
+module_exit(smdk_audio_exit);
+
+MODULE_DESCRIPTION("ALSA SoC SMDK WM8994");
+MODULE_LICENSE("GPL");
-- 
1.6.2.5
