From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Thu, 4 Jun 2015 11:04:42 +0200
Message-ID: <20150604090442.GB8494@dellaz>
References: <1432752116.8235.25.camel@loki> <20150527201320.GA309@asus>
 <1432812668.2726.18.camel@loki> <20150528125325.GA418@asus>
 <1432819294.2726.33.camel@loki> <20150528191721.GA608@asus>
 <1432892521.2732.14.camel@loki> <20150529131753.GA339@asus>
 <1433156768.2642.21.camel@loki>
 <loom.20150604T085739-771@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 0779426064C
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 11:04:48 +0200 (CEST)
Received: by wiga1 with SMTP id a1so40580516wig.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 02:04:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <loom.20150604T085739-771@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marcus Bannerman <m.bannerman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2015 at 07:09:59AM +0000, Marcus Bannerman wrote:
> > Jarkko thinks the IRQ may be incorrectly reported by ACPI and that it
> > could be using another ACPI index. This could probably be checked by
> > decompiling the ACPi data and searching for the audio DSP.
> 
> Hi,
> Interested x205ta user here and I want to try to help out where I can. Is the 
> patch file somewhere publicly available and which version are you working 
> off?
>

That patch is the same of the 29 may one but with changed cpu_dai_name
as Liam suggested.

The board file it's a copy-paste of byt-rt5640.c

----8<-------------------

add board file and a cople of ACPI id where needed

Signed-off-by: Michele Curti <michele.curti@azcom.it>
---
 sound/soc/codecs/rt5645.c           |   2 +
 sound/soc/intel/Kconfig             |   9 +++
 sound/soc/intel/boards/Makefile     |   2 +
 sound/soc/intel/boards/byt-rt5645.c | 149 ++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.c   |   1 +
 5 files changed, 163 insertions(+)
 create mode 100644 sound/soc/intel/boards/byt-rt5645.c

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e9544c6..9ec416f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3190,6 +3190,7 @@ static const struct regmap_config rt5645_regmap = {
 
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
+	{ "rt5648", 0 },
 	{ "rt5650", 0 },
 	{ }
 };
@@ -3198,6 +3199,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
+	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{},
 };
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 791953f..886c833 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -65,6 +65,15 @@ config SND_SOC_INTEL_BYT_RT5640_MACH
 	  This adds audio driver for Intel Baytrail platform based boards
 	  with the RT5640 audio codec.
 
+config SND_SOC_INTEL_BYT_RT5645_MACH
+	tristate "ASoC Audio driver for Intel Baytrail with RT5645 codec"
+	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
+	select SND_SOC_INTEL_BAYTRAIL
+	select SND_SOC_RT5645
+	help
+	  This adds audio driver for Intel Baytrail platform based boards
+	  with the RT5645 audio codec.
+
 config SND_SOC_INTEL_BYT_MAX98090_MACH
 	tristate "ASoC Audio driver for Intel Baytrail with MAX98090 codec"
 	depends on SND_SOC_INTEL_SST && X86_INTEL_LPSS && I2C
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index cb94895..24685c5 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,5 +1,6 @@
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
+snd-soc-sst-byt-rt5645-mach-objs := byt-rt5645.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
@@ -9,6 +10,7 @@ snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5645_MACH) += snd-soc-sst-byt-rt5645-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
diff --git a/sound/soc/intel/boards/byt-rt5645.c b/sound/soc/intel/boards/byt-rt5645.c
new file mode 100644
index 0000000..0d8851c
--- /dev/null
+++ b/sound/soc/intel/boards/byt-rt5645.c
@@ -0,0 +1,149 @@
+/*
+ * Intel Baytrail SST RT5645 machine driver
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/slab.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/jack.h>
+#include "../../codecs/rt5645.h"
+
+#include "../common/sst-dsp.h"
+
+static const struct snd_soc_dapm_widget byt_rt5645_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_MIC("Internal Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_audio_map[] = {
+	{"IN1P", NULL, "Internal Mic"},
+	{"IN2P", NULL, "Headset Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+	{"Speaker", NULL, "SPORP"},
+	{"Speaker", NULL, "SPORN"},
+};
+
+static const struct snd_kcontrol_new byt_rt5645_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+	SOC_DAPM_PIN_SWITCH("Internal Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int byt_rt5645_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	int ret;
+
+	ret = snd_soc_dai_set_sysclk(codec_dai, RT5645_SCLK_S_PLL1,
+				     params_rate(params) * 256,
+				     SND_SOC_CLOCK_IN);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec clock %d\n", ret);
+		return ret;
+	}
+	ret = snd_soc_dai_set_pll(codec_dai, 0, RT5645_PLL1_S_BCLK1,
+				  params_rate(params) * 64,
+				  params_rate(params) * 256);
+	if (ret < 0) {
+		dev_err(codec_dai->dev, "can't set codec pll: %d\n", ret);
+		return ret;
+	}
+	return 0;
+}
+
+static int byt_rt5645_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+
+	card->dapm.idle_bias_off = true;
+
+	ret = snd_soc_add_card_controls(card, byt_rt5645_controls,
+					ARRAY_SIZE(byt_rt5645_controls));
+	if (ret) {
+		dev_err(card->dev, "unable to add card controls\n");
+		return ret;
+	}
+
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Headphone");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
+
+	return ret;
+}
+
+static struct snd_soc_ops byt_rt5645_ops = {
+	.hw_params = byt_rt5645_hw_params,
+};
+
+static struct snd_soc_dai_link byt_rt5645_dais[] = {
+	{
+		.name = "Baytrail Audio",
+		.stream_name = "Audio",
+		.cpu_dai_name = "Baytrail PCM",
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC5648:00",
+		.platform_name = "baytrail-pcm-audio",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			   SND_SOC_DAIFMT_CBS_CFS,
+		.init = byt_rt5645_init,
+		.ops = &byt_rt5645_ops,
+	},
+};
+
+static struct snd_soc_card byt_rt5645_card = {
+	.name = "byt-rt5645",
+	.dai_link = byt_rt5645_dais,
+	.num_links = ARRAY_SIZE(byt_rt5645_dais),
+	.dapm_widgets = byt_rt5645_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_rt5645_widgets),
+	.dapm_routes = byt_rt5645_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_rt5645_audio_map),
+	.fully_routed = true,
+};
+
+static int byt_rt5645_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &byt_rt5645_card;
+
+	card->dev = &pdev->dev;
+	return devm_snd_soc_register_card(&pdev->dev, card);
+}
+
+static struct platform_driver byt_rt5645_audio = {
+	.probe = byt_rt5645_probe,
+	.driver = {
+		.name = "byt-rt5645",
+		.pm = &snd_soc_pm_ops,
+	},
+};
+module_platform_driver(byt_rt5645_audio)
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail Machine driver");
+MODULE_AUTHOR("Omair Md Abdullah, Jarkko Nikula");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:byt-rt5645");
diff --git a/sound/soc/intel/common/sst-acpi.c b/sound/soc/intel/common/sst-acpi.c
index 42f293f..bb28e84 100644
--- a/sound/soc/intel/common/sst-acpi.c
+++ b/sound/soc/intel/common/sst-acpi.c
@@ -248,6 +248,7 @@ static struct sst_acpi_desc sst_acpi_broadwell_desc = {
 
 static struct sst_acpi_mach baytrail_machines[] = {
 	{ "10EC5640", "byt-rt5640", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
+	{ "10EC5648", "byt-rt5645", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{ "193C9890", "byt-max98090", "intel/fw_sst_0f28.bin-48kHz_i2s_master" },
 	{}
 };
-- 
1.9.1
