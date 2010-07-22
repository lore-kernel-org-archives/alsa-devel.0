From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH] ASoC: multi-component - Add Goni sound driver
Date: Thu, 22 Jul 2010 15:16:10 +0900
Message-ID: <4C47E22A.6090405@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id C4A46244ED
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 08:16:14 +0200 (CEST)
Received: from epmmp1. (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5Y0013P42Y5V30@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 22 Jul 2010 15:16:10 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net
	(unknown [165.213.149.150])
	by mmp1.samsung.com (Sun Java(tm) System Messaging Server 7u3-15.01
	64bit
	(built Feb 12 2010)) with ESMTPA id <0L5Y004S842YZFC0@mmp1.samsung.com>
	for
	alsa-devel@alsa-project.org; Thu, 22 Jul 2010 15:16:10 +0900 (KST)
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
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This patch add sound support for the Goni board based on S5PV210.

The Goni board is based on Samsung SoC(S5PV210) and include
WM8994 codec over I2S to support sound.

The kind of jack is below states :
* SND_JACK_HEADPHONE
* SND_JACK_HEADSET
* SND_JACK_MECHANICAL
  : When TV-OUT cable is inserted on Goni board,
  the TV-OUT cable isn't connected to television.
* SND_JACK_AVOUT
  : When TV-OUT cable is inserted on Goni board,
  the TV-OUT cable is connected to television.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 sound/soc/s3c24xx/Kconfig       |    9 ++
 sound/soc/s3c24xx/Makefile      |    2 +
 sound/soc/s3c24xx/goni_wm8994.c |  298 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 309 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/s3c24xx/goni_wm8994.c

diff --git a/sound/soc/s3c24xx/Kconfig b/sound/soc/s3c24xx/Kconfig
index c09b402..1cdc37b 100644
--- a/sound/soc/s3c24xx/Kconfig
+++ b/sound/soc/s3c24xx/Kconfig
@@ -140,3 +140,12 @@ config SND_S5PC110_SOC_AQUILA_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on aquila
 	  with the WM8994.
+
+config SND_S5PV210_SOC_GONI_WM8994
+	tristate "SoC I2S Audio support for GONI - WM8994"
+	depends on SND_S3C24XX_SOC && MACH_GONI
+	select SND_S3C64XX_SOC_I2S_V4
+	select SND_SOC_WM8994
+	help
+	  Say Y if you want to add support for SoC audio on goni
+	  with the WM8994.
diff --git a/sound/soc/s3c24xx/Makefile b/sound/soc/s3c24xx/Makefile
index 02dd12c..47ed6d7 100644
--- a/sound/soc/s3c24xx/Makefile
+++ b/sound/soc/s3c24xx/Makefile
@@ -31,6 +31,7 @@ snd-soc-smdk64xx-wm8580-objs := smdk64xx_wm8580.o
 snd-soc-smdk-wm9713-objs := smdk_wm9713.o
 snd-soc-s3c64xx-smartq-wm8987-objs := smartq_wm8987.o
 snd-soc-aquila-wm8994-objs := aquila_wm8994.o
+snd-soc-goni-wm8994-objs := goni_wm8994.o
 
 obj-$(CONFIG_SND_S3C24XX_SOC_JIVE_WM8750) += snd-soc-jive-wm8750.o
 obj-$(CONFIG_SND_S3C24XX_SOC_NEO1973_WM8753) += snd-soc-neo1973-wm8753.o
@@ -45,3 +46,4 @@ obj-$(CONFIG_SND_S3C64XX_SOC_WM8580) += snd-soc-smdk64xx-wm8580.o
 obj-$(CONFIG_SND_SOC_SMDK_WM9713) += snd-soc-smdk-wm9713.o
 obj-$(CONFIG_SND_S3C64XX_SOC_SMARTQ) += snd-soc-s3c64xx-smartq-wm8987.o
 obj-$(CONFIG_SND_S5PC110_SOC_AQUILA_WM8994) += snd-soc-aquila-wm8994.o
+obj-$(CONFIG_SND_S5PV210_SOC_GONI_WM8994) += snd-soc-goni-wm8994.o
diff --git a/sound/soc/s3c24xx/goni_wm8994.c b/sound/soc/s3c24xx/goni_wm8994.c
new file mode 100644
index 0000000..20bcaab
--- /dev/null
+++ b/sound/soc/s3c24xx/goni_wm8994.c
@@ -0,0 +1,298 @@
+/*
+ * goni_wm8994.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Chanwoo Choi <cw00.choi@samsung.com>
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
+#include "s3c64xx-i2s.h"
+
+static struct snd_soc_card goni;
+static struct platform_device *goni_snd_device;
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
+static const struct snd_soc_dapm_widget goni_dapm_widgets[] = {
+	SND_SOC_DAPM_SPK("Ext Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Ext Right Spk", NULL),
+	SND_SOC_DAPM_SPK("Ext Rcv", NULL),
+	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Main Mic", NULL),
+	SND_SOC_DAPM_MIC("2nd Mic", NULL),
+	SND_SOC_DAPM_LINE("Radio In", NULL),
+};
+
+static const struct snd_soc_dapm_route goni_dapm_routes[] = {
+	{"Ext Left Spk", NULL, "SPKOUTLP"},
+	{"Ext Left Spk", NULL, "SPKOUTLN"},
+
+	{"Ext Right Spk", NULL, "SPKOUTRP"},
+	{"Ext Right Spk", NULL, "SPKOUTRN"},
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
+
+	{"IN2LN", NULL, "Radio In"},
+	{"IN2RN", NULL, "Radio In"},
+};
+
+static int goni_wm8994_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_codec *codec = rtd->codec;
+	int ret;
+
+	/* add goni specific widgets */
+	snd_soc_dapm_new_controls(codec, goni_dapm_widgets,
+			ARRAY_SIZE(goni_dapm_widgets));
+
+	/* set up goni specific audio routes */
+	snd_soc_dapm_add_routes(codec, goni_dapm_routes,
+			ARRAY_SIZE(goni_dapm_routes));
+
+	/* set endpoints to not connected */
+	snd_soc_dapm_nc_pin(codec, "IN2LP:VXRN");
+	snd_soc_dapm_nc_pin(codec, "IN2RP:VXRP");
+	snd_soc_dapm_nc_pin(codec, "LINEOUT1N");
+	snd_soc_dapm_nc_pin(codec, "LINEOUT1P");
+	snd_soc_dapm_nc_pin(codec, "LINEOUT2N");
+	snd_soc_dapm_nc_pin(codec, "LINEOUT2P");
+
+	snd_soc_dapm_sync(codec);
+
+	/* Headset jack detection */
+	ret = snd_soc_jack_new(&goni, "Headset Jack",
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
+static int goni_hifi_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
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
+	ret = snd_soc_dai_set_sysclk(cpu_dai, S3C64XX_CLKSRC_PCLK,
+			0, SND_SOC_CLOCK_IN);
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
+static struct snd_soc_ops goni_hifi_ops = {
+	.hw_params = goni_hifi_hw_params,
+};
+
+static int goni_voice_hw_params(struct snd_pcm_substream *substream,
+		struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
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
+static struct snd_soc_dai_driver voice_dai = {
+	.name = "goni-voice-dai",
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
+static struct snd_soc_ops goni_voice_ops = {
+	.hw_params = goni_voice_hw_params,
+};
+
+static struct snd_soc_dai_link goni_dai[] = {
+{
+	.name = "WM8994",
+	.stream_name = "WM8994 HiFi",
+	.cpu_dai_name = "s3c64xx-i2s-v4-dai",
+	.codec_dai_name = "wm8994-hifi",
+	.platform_name = "s3c24xx-pcm-audio",
+	.codec_name = "wm8994-codec",
+	.init = goni_wm8994_init,
+	.ops = &goni_hifi_ops,
+}, {
+	.name = "WM8994 Voice",
+	.stream_name = "Voice",
+	.cpu_dai_name = "goni-voice-dai",
+	.codec_dai_name = "wm8994-voice",
+	.platform_name = "s3c24xx-pcm-audio",
+	.codec_name = "wm8994-codec",
+	.ops = &goni_voice_ops,
+},
+};
+
+static struct snd_soc_card goni = {
+	.name = "goni",
+	.dai_link = goni_dai,
+	.num_links = ARRAY_SIZE(goni_dai),
+};
+
+static int __init goni_init(void)
+{
+	int ret;
+
+	if (!machine_is_goni())
+		return -ENODEV;
+
+	goni_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!goni_snd_device)
+		return -ENOMEM;
+
+	/* register voice DAI here */
+	ret = snd_soc_register_dai(&goni_snd_device->dev, &voice_dai);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(goni_snd_device, &goni);
+	ret = platform_device_add(goni_snd_device);
+
+	if (ret)
+		platform_device_put(goni_snd_device);
+
+	return ret;
+}
+
+static void __exit goni_exit(void)
+{
+	platform_device_unregister(goni_snd_device);
+}
+
+module_init(goni_init);
+module_exit(goni_exit);
+
+/* Module information */
+MODULE_DESCRIPTION("ALSA SoC WM8994 GONI(S5PV210)");
+MODULE_AUTHOR("Chanwoo Choi <cw00.choi@samsung.com>");
+MODULE_LICENSE("GPL");
-- 
1.6.3.3
