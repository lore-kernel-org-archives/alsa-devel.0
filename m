From: =?UTF-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>
Subject: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Wed, 07 Jul 2010 17:41:30 +0900
Message-ID: <4C343DBA.1040107@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id C47DA24157
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 10:41:38 +0200 (CEST)
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
	by mailout2.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L56008HOIT7GT70@mailout2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 07 Jul 2010 17:41:31 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5600IWHIT7IR@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 07 Jul 2010 17:41:31 +0900 (KST)
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
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, =?UTF-8?B?7Ius7KSA7JiB?= <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch add sound support for the Aquila board based on S5PC110.

The Aquila board is based on Samsung SoC(S5PC110) and include
WM8994 codec over I2Sv5 to support sound. As there is currently
no driver for the I2Sv5, the code to use I2Sv5 is deleted
on this patch.

After I2Sv5 driver is posted in a few weeks, I will post incremental
patch which some codes for using I2Sv5. The owner of I2Sv5 said that
he will post I2Sv5 driver after a few weeks.

The kind of jack is below states :
* SND_JACK_HEADPHONE
* SND_JACK_HEADSET
* SND_JACK_MECHANICAL
  : When TV-OUT cable is inserted on Aquila board,
  the TV-OUT cable isn't connected to television.
* SND_JACK_AVOUT
  : When TV-OUT cable is inserted on Aquila board,
  the TV-OUT cable is connected to television.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/s3c24xx/Kconfig         |    8 +
 sound/soc/s3c24xx/Makefile        |    2 +
 sound/soc/s3c24xx/aquila_wm8994.c |  296 +++++++++++++++++++++++++++++++++++++
 3 files changed, 306 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/aquila_wm8994.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index 213963a..0c5d8a5 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -131,3 +131,11 @@ config SND_S3C64XX_SOC_SMARTQ
 	depends on SND_S3C24XX_SOC && MACH_SMARTQ
 	select SND_S3C64XX_SOC_I2S
 	select SND_SOC_WM8750
+
+config SND_S5PC110_SOC_AQUILA_WM8994
+	tristate "SoC I2S Audio support for AQUILA - WM8994"
+	depends on SND_S3C24XX_SOC && MACH_AQUILA
+	select SND_SOC_WM8994
+	help
+	  Say Y if you want to add support for SoC audio on aquila
+	  with the WM8994.
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 50172c3..02dd12c 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -30,6 +30,7 @@ snd-soc-s3c24xx-simtec-tlv320aic23-objs := s3c24xx_simtec_tlv320aic23.o
 snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
+snd-soc-aquila-wm8994-objs := aquila_wm8994.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -43,3 +44,4 @@ obj-$(CONFIG_SND_S3C24XX_SOC_SIMTEC_TLV320AIC23) += snd-soc-s3c24xx-simtec-tlv32
 obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
+obj-$(CONFIG_SND_S5PC110_SOC_AQUILA_WM8994) += snd-soc-aquila-wm8994.o
diff --git a/sound/soc/s3c24xx/aquila_wm8994.c b/sound/soc/s3c24xx/aquila_wm8994.c
new file mode 100644
index 0000000..5caeedd
--- /dev/null
+++ b/sound/soc/s3c24xx/aquila_wm8994.c
@@ -0,0 +1,296 @@
+/*
+ * aquila_wm8994.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <sound/jack.h>
+#include <asm/mach-types.h>
+#include <mach/gpio.h>
+#include <mach/regs-clock.h>
+
+#include <linux/mfd/wm8994/core.h>
+#include <linux/mfd/wm8994/registers.h>
+#include "../codecs/wm8994.h"
+#include "s3c-dma.h"
+#include "s3c24xx-i2s.h"
+
+extern struct snd_soc_platform s3c24xx_soc_platform;
+static struct snd_soc_card aquila;
+static struct platform_device *aquila_snd_device;
+
+/* 3.5 pie jack */
+static struct snd_soc_jack jack;
+
+/* 3.5 pie jack detection DAPM pins */
+static struct snd_soc_jack_pin jack_pins[] = {
+	{
+		.pin = "Headset Mic",
+		.mask = SND_JACK_MICROPHONE,
+	}, {
+		.pin = "Headset Stereophone",
+		.mask = SND_JACK_HEADPHONE | SND_JACK_MECHANICAL |
+			SND_JACK_AVOUT,
+	},
+};
+
+/* 3.5 pie jack detection gpios */
+static struct snd_soc_jack_gpio jack_gpios[] = {
+	{
+		.gpio = S5PV210_GPH0(6),
+		.name = "DET_3.5",
+		.report = SND_JACK_HEADSET | SND_JACK_MECHANICAL |
+			SND_JACK_AVOUT,
+		.debounce_time = 200,
+	},
+};
+
+static const struct snd_kcontrol_new aquila_controls[] = {
+};
+
+static const struct snd_soc_dapm_widget aquila_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+	SND_SOC_DAPM_SPK("Ext Rcv", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Main Mic", NULL),
+	SND_SOC_DAPM_MIC("2nd Mic", NULL),
+};
+
+static const struct snd_soc_dapm_route aquila_dapm_routes[] = {
+	{"Ext Spk", NULL, "SPKOUTLP"},
+	{"Ext Spk", NULL, "SPKOUTLN"},
+
+	{"Ext Rcv", NULL, "HPOUT2N"},
+	{"Ext Rcv", NULL, "HPOUT2P"},
+
+	{"Headset Stereophone", NULL, "HPOUT1L"},
+	{"Headset Stereophone", NULL, "HPOUT1R"},
+
+	{"IN1RN", NULL, "Headset Mic"},
+	{"IN1RP", NULL, "Headset Mic"},
+
+	{"IN1RN", NULL, "2nd Mic"},
+	{"IN1RP", NULL, "2nd Mic"},
+
+	{"IN1LN", NULL, "Main Mic"},
+	{"IN1LP", NULL, "Main Mic"},
+};
+
+static int aquila_wm8994_init(struct snd_soc_codec *codec)
+{
+	int ret;
+	unsigned int reg;
+
+	/* add aquila specific kcontorls */
+	ret = snd_soc_add_controls(codec, aquila_controls,
+			ARRAY_SIZE(aquila_controls));
+
+	if (ret < 0)
+		return ret;
+
+	/* add aquila specific widgets */
+	snd_soc_dapm_new_controls(codec, aquila_dapm_widgets,
+			ARRAY_SIZE(aquila_dapm_widgets));
+
+	/* set up aquila specific audio routes */
+	snd_soc_dapm_add_routes(codec, aquila_dapm_routes,
+			ARRAY_SIZE(aquila_dapm_routes));
+
+	snd_soc_dapm_sync(codec);
+
+	/* Headset jack detection */
+	ret = snd_soc_jack_new(&aquila, "Headset Jack",
+			SND_JACK_HEADSET | SND_JACK_MECHANICAL | SND_JACK_AVOUT,
+			&jack);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_pins(&jack, ARRAY_SIZE(jack_pins), jack_pins);
+	if (ret)
+		return ret;
+
+	ret = snd_soc_jack_add_gpios(&jack, ARRAY_SIZE(jack_gpios), jack_gpios);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int aquila_hifi_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	unsigned int pll_out = 24000000;
+	int ret = 0;
+
+	/* set the cpu DAI configuration */
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the cpu system clock */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec FLL */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL1, 0, pll_out,
+			params_rate(params) * 256);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL1,
+			params_rate(params) * 256, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_ops aquila_hifi_ops = {
+	.hw_params = aquila_hifi_hw_params,
+};
+
+static int aquila_voice_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	unsigned int pll_out = 24000000;
+	int ret = 0;
+
+	if (params_rate(params) != 8000)
+		return -EINVAL;
+
+	/* set codec DAI configuration */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_LEFT_J |
+			SND_SOC_DAIFMT_IB_IF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec FLL */
+	ret = snd_soc_dai_set_pll(codec_dai, WM8994_FLL2, 0, pll_out,
+			params_rate(params) * 256);
+	if (ret < 0)
+		return ret;
+
+	/* set the codec system clock */
+	ret = snd_soc_dai_set_sysclk(codec_dai, WM8994_SYSCLK_FLL2,
+			params_rate(params) * 256, SND_SOC_CLOCK_IN);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static struct snd_soc_dai voice_dai = {
+	.name = "Voice",
+	.id = 0,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000,
+		.formats = SNDRV_PCM_FMTBIT_S16_LE,},
+};
+
+static struct snd_soc_ops aquila_voice_ops = {
+	.hw_params = aquila_voice_hw_params,
+};
+
+static struct snd_soc_dai_link aquila_dai[] = {
+{
+	.name = "WM8994",
+	.stream_name = "WM8994 HiFi",
+	/* After I2Sv5 driver is posted, cpu_dai will is enabled. */
+	/* .cpu_dai = &s5p_i2s_dai[0], */
+	.codec_dai = &wm8994_dai[0],
+	.init = aquila_wm8994_init,
+	.ops = &aquila_hifi_ops,
+}, {
+	.name = "WM8994 Voice",
+	.stream_name = "Voice",
+	.cpu_dai = &voice_dai,
+	.codec_dai = &wm8994_dai[1],
+	.ops = &aquila_voice_ops,
+},
+};
+
+static struct snd_soc_card aquila = {
+	.name = "aquila",
+	.platform = &s3c24xx_soc_platform,
+	.dai_link = aquila_dai,
+	.num_links = ARRAY_SIZE(aquila_dai),
+};
+
+static struct snd_soc_device aquila_snd_devdata = {
+	.card = &aquila,
+	.codec_dev = &soc_codec_dev_wm8994,
+};
+
+static int __init aquila_init(void)
+{
+	int ret;
+
+	if (!machine_is_aquila())
+		return -ENODEV;
+
+	/* register voice DAI here */
+	ret = snd_soc_register_dai(&voice_dai);
+	if (ret)
+		return ret;
+
+	aquila_snd_device = platform_device_alloc("soc-audio", 0);
+	if (!aquila_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(aquila_snd_device, &aquila_snd_devdata);
+	aquila_snd_devdata.dev = &aquila_snd_device->dev;
+	ret = platform_device_add(aquila_snd_device);
+
+	if (ret)
+		platform_device_put(aquila_snd_device);
+
+	return ret;
+}
+
+static void __exit aquila_exit(void)
+{
+	platform_device_unregister(aquila_snd_device);
+}
+
+module_init(aquila_init);
+module_exit(aquila_exit);
+
+/* Module information */
+MODULE_DESCRIPTION("ALSA SoC WM8994 Aquila(C110)");
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_LICENSE("GPL");
-- 
1.6.3.3
