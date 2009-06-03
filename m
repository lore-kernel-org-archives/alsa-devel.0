From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH 3/4] ASoC: pxa add Marvell Littleton platform
	audio support
Date: Wed, 3 Jun 2009 20:35:23 +0800
Message-ID: <f17812d70906030535m4aa841cep77beb1a4362b4adf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f171.google.com (mail-qy0-f171.google.com
	[209.85.221.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 506FC1037FC
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 14:35:24 +0200 (CEST)
Received: by qyk1 with SMTP id 1so12240763qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 05:35:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, alsa-devel@alsa-project.org
Cc: Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Paul Shen <bshen9@marvell.com>
Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 sound/soc/pxa/Kconfig     |    9 ++
 sound/soc/pxa/Makefile    |    2 +
 sound/soc/pxa/littleton.c |  228 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/pxa/littleton.c

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index ad8a10f..a4ad5ba 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -134,3 +134,12 @@ config SND_PXA2XX_SOC_MIOA701
         help
           Say Y if you want to add support for SoC audio on the
           MIO A701.
+
+config SND_PXA2XX_SOC_LITTLETON
+        tristate "SoC Audio support for Marvell littleton"
+        depends on SND_PXA2XX_SOC && MACH_LITTLETON
+        select SND_PXA_SOC_SSP
+        select SND_SOC_DA9034
+        help
+          Say Y if you want to add support for SoC audio on the
+          Marvell Littleton.
diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 4b90c3c..94c719d 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -22,6 +22,7 @@ snd-soc-palm27x-objs := palm27x.o
 snd-soc-zylonite-objs := zylonite.o
 snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
+snd-soc-littleton-objs := littleton.o

 obj-$(CONFIG_SND_PXA2XX_SOC_CORGI) += snd-soc-corgi.o
 obj-$(CONFIG_SND_PXA2XX_SOC_POODLE) += snd-soc-poodle.o
@@ -34,4 +35,5 @@ obj-$(CONFIG_SND_PXA2XX_SOC_EM_X270) += snd-soc-em-x270.o
 obj-$(CONFIG_SND_PXA2XX_SOC_PALM27X) += snd-soc-palm27x.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MAGICIAN) += snd-soc-magician.o
 obj-$(CONFIG_SND_PXA2XX_SOC_MIOA701) += snd-soc-mioa701.o
+obj-$(CONFIG_SND_PXA2XX_SOC_LITTLETON) += snd-soc-littleton.o
 obj-$(CONFIG_SND_SOC_ZYLONITE) += snd-soc-zylonite.o
diff --git a/sound/soc/pxa/littleton.c b/sound/soc/pxa/littleton.c
new file mode 100644
index 0000000..911a5ef
--- /dev/null
+++ b/sound/soc/pxa/littleton.c
@@ -0,0 +1,228 @@
+/*
+ * littleton.c  --  SoC audio for Littleton
+ *
+ * Copyright (C) 2009 Marvell International Ltd.
+ *
+ *   Author: Paul Shen <bshen9@marvell.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-types.h>
+#include <mach/ssp.h>
+#include <mach/regs-ssp.h>
+
+#include "pxa2xx-pcm.h"
+#include "pxa-ssp.h"
+
+static int hifi_mode;
+
+extern struct snd_soc_dai da9034_dais[2];
+extern struct snd_soc_codec_device soc_codec_dev_da9034;
+
+static const char *hifi_mode_select[] = {
+	"HIFI 64FS LEFT_J, SSP CLK Master FRM Master",
+	"HIFI 64FS I2S ,   SSP CLK Master FRM Master",
+	"HIFI 32FS LEFT_J, SSP CLK Master FRM Master",
+	"HIFI 32FS I2S ,   SSP CLK Master FRM Master",
+};
+
+static const struct soc_enum littleton_enum[] = {
+	SOC_ENUM_SINGLE_EXT(4, hifi_mode_select),
+};
+
+static int littleton_get_hifi_mode(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	ucontrol->value.integer.value[0] = hifi_mode;
+	return 0;
+}
+
+static int littleton_set_hifi_mode(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	hifi_mode = ucontrol->value.integer.value[0];
+	return 1;
+}
+
+static const struct snd_kcontrol_new littleton_da9034_controls[] = {
+	SOC_ENUM_EXT("Hifi Mode Select", littleton_enum[0],
+		littleton_get_hifi_mode, littleton_set_hifi_mode),
+};
+
+static int littleton_da9034_init(struct snd_soc_codec *codec)
+{
+	snd_soc_add_controls(codec, littleton_da9034_controls,
+			ARRAY_SIZE(littleton_da9034_controls));
+	return snd_soc_dapm_sync(codec);
+}
+
+struct ssp_clk_div {
+	unsigned int rate;
+	unsigned int pll;
+	unsigned int scdb;
+	unsigned int acds;
+};
+
+static struct ssp_clk_div littleton_hifi_clk_div_64fs[] = {
+	{ 48000, 12288000, PXA_SSP_CLK_SCDB_4, 0 },
+	{ 44100, 11289600, PXA_SSP_CLK_SCDB_4, 0 },
+	{ 32000,  4096000, PXA_SSP_CLK_SCDB_1, 1 },
+	{ 22050, 11289600, PXA_SSP_CLK_SCDB_8, 0 },
+	{ 16000,  4096000, PXA_SSP_CLK_SCDB_4, 0 },
+	{ 11025, 11289600, PXA_SSP_CLK_SCDB_4, 2 },
+	{  8000,  4096000, PXA_SSP_CLK_SCDB_4, 1 },
+	{},
+};
+
+static struct ssp_clk_div littleton_hifi_clk_div_32fs[] = {
+	{ 48000, 12288000, PXA_SSP_CLK_SCDB_4, 1 },
+	{ 44100, 11289600, PXA_SSP_CLK_SCDB_4, 1 },
+	{ 32000,  4096000, PXA_SSP_CLK_SCDB_1, 2 },
+	{ 22050, 11289600, PXA_SSP_CLK_SCDB_8, 1 },
+	{ 16000,  4096000, PXA_SSP_CLK_SCDB_4, 1 },
+	{ 11025, 11289600, PXA_SSP_CLK_SCDB_8, 2 },
+	{  8000,  4096000, PXA_SSP_CLK_SCDB_8, 1 },
+	{},
+};
+
+static int littleton_hifi_hw_params(struct snd_pcm_substream *substream,
+				    struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct ssp_clk_div *clkdiv;
+	struct clk *clk_pout;
+	int format;
+
+	clk_pout = clk_get(NULL, "CLK_POUT");
+	if (IS_ERR(clk_pout)) {
+		pr_err("failed to get POUT clock\n");
+		return PTR_ERR(clk_pout);
+	}
+
+	clk_enable(clk_pout);
+
+	switch (hifi_mode) {
+	case 0:
+		format = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_NF |
+			 SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_64FS;
+		clkdiv = littleton_hifi_clk_div_64fs;
+		break;
+	case 1:
+		format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			 SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_64FS;
+		clkdiv = littleton_hifi_clk_div_64fs;
+		break;
+	case 2:
+		format = SND_SOC_DAIFMT_LEFT_J | SND_SOC_DAIFMT_NB_IF |
+			 SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_32FS;
+		clkdiv = littleton_hifi_clk_div_32fs;
+		break;
+	case 3:
+		format = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			 SND_SOC_DAIFMT_CBS_CFS | PXA_SSP_FRM_32FS;
+		clkdiv = littleton_hifi_clk_div_32fs;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	snd_soc_dai_set_fmt(codec_dai, format);
+	snd_soc_dai_set_fmt(cpu_dai, format);
+	snd_soc_dai_set_tdm_slot(cpu_dai, 3, 2);
+
+	for (; clkdiv->rate; clkdiv++) {
+		if (clkdiv->rate == params_rate(params))
+			break;
+	}
+
+	if (!clkdiv->rate)
+		return -EINVAL;
+
+	snd_soc_dai_set_pll(cpu_dai, 0, 0, clkdiv->pll);
+	snd_soc_dai_set_sysclk(cpu_dai, PXA_SSP_CLK_AUDIO, 0, 1);
+	snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_AUDIO_DIV_SCDB, clkdiv->scdb);
+	snd_soc_dai_set_clkdiv(cpu_dai, PXA_SSP_AUDIO_DIV_ACDS, clkdiv->acds);
+	return 0;
+}
+
+static struct snd_soc_ops littleton_hifi_ops = {
+	.hw_params = littleton_hifi_hw_params,
+};
+
+static struct snd_soc_dai_link littleton_dai[] = {
+	/* HiFi */
+	{
+		.name		= "DA9034 HiFi",
+		.stream_name	= "DA9034 HiFi",
+		.cpu_dai	= &pxa_ssp_dai[PXA_DAI_SSP3],
+		.codec_dai	= &da9034_dais[0],
+		.init		= littleton_da9034_init,
+		.ops		= &littleton_hifi_ops,
+	},
+};
+
+static struct snd_soc_card littleton = {
+	.name		= "Littleton",
+	.platform	= &pxa2xx_soc_platform,
+	.dai_link	= littleton_dai,
+	.num_links	= ARRAY_SIZE(littleton_dai),
+};
+
+static struct snd_soc_device littleton_snd_devdata = {
+	.card		= &littleton,
+	.codec_dev	= &soc_codec_dev_da9034,
+};
+
+static struct platform_device *littleton_snd_device;
+
+static int __init littleton_audio_init(void)
+{
+	int ret;
+
+	if (!machine_is_littleton()) {
+		pr_err("Only Littleton hardware supported by ASoC driver\n");
+		return -ENODEV;
+	}
+
+	littleton_snd_device = platform_device_alloc("soc-audio", -1);
+	if (!littleton_snd_device)
+		return -ENOMEM;
+
+	platform_set_drvdata(littleton_snd_device, &littleton_snd_devdata);
+	littleton_snd_devdata.dev = &littleton_snd_device->dev;
+
+	ret = platform_device_add(littleton_snd_device);
+	if (ret != 0)
+		platform_device_put(littleton_snd_device);
+
+	return ret;
+}
+
+static void __exit littleton_audio_exit(void)
+{
+	platform_device_unregister(littleton_snd_device);
+}
+
+module_init(littleton_audio_init);
+module_exit(littleton_audio_exit);
+
+MODULE_AUTHOR("Paul Shen <bshen9@marvell.com>");
+MODULE_DESCRIPTION("ALSA SoC Da9034 Littleton");
+MODULE_LICENSE("GPL");
-- 
1.6.0.4
