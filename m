From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/19] ASoC: intel: boards: add card for
	MinnowBoard I2S access
Date: Thu, 17 Dec 2015 20:35:51 -0600
Message-ID: <1450406156-22246-15-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 787652657E6
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:28 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bardliao@realtek.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

Add card with dummy codec and DAI to make I2S signals observable.
Uses Mic and Speaker pins/widgets to control DAPM

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig                |  12 ++
 sound/soc/intel/boards/Makefile        |   2 +
 sound/soc/intel/boards/bytcr_nocodec.c | 233 +++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)
 create mode 100644 sound/soc/intel/boards/bytcr_nocodec.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 0430e2d..12421c2 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -115,6 +115,18 @@ config SND_SOC_INTEL_BYTCR_RT5651_MACH
           Say Y if you have such a device
           If unsure select "N".
 
+config SND_SOC_INTEL_BYTCR_NOCODEC_MACH
+        tristate "ASoC Audio driver for Intel Baytrail and Baytrail-CR with no codec (MinnowBoard MAX)"
+	depends on X86 && I2C
+	select SND_SST_MFLD_PLATFORM
+	select SND_SST_IPC_ACPI
+	help
+          This adds support for ASoC machine driver for the MinnowBoard Max
+	  and provides access to I2S signals on the Low-Speed connector
+          Say Y if you have such a device
+          If unsure select "N".
+
+
 config SND_SOC_INTEL_CHT_BSW_RT5672_MACH
         tristate "ASoC Audio driver for Intel Cherrytrail & Braswell with RT5672 codec"
         depends on X86_INTEL_LPSS && I2C
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 64e4181..c7bf041 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -4,6 +4,7 @@ snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
 snd-soc-sst-bytcr-rt5651-objs := bytcr_rt5651.o
+snd-soc-sst-bytcr-nocodec-objs := bytcr_nocodec.o
 snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
@@ -16,6 +17,7 @@ obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH) += snd-soc-sst-bytcr-rt5651.o
+obj-$(CONFIG_SND_SOC_INTEL_BYTCR_NOCODEC_MACH) += snd-soc-sst-bytcr-nocodec.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) += snd-soc-sst-cht-bsw-max98090_ti.o
diff --git a/sound/soc/intel/boards/bytcr_nocodec.c b/sound/soc/intel/boards/bytcr_nocodec.c
new file mode 100644
index 0000000..4eef28f
--- /dev/null
+++ b/sound/soc/intel/boards/bytcr_nocodec.c
@@ -0,0 +1,233 @@
+/*
+ *  bytcr_nocodec.c - ASoc Machine driver for MinnowBoard
+ *  to make I2S signals observable on the Low-Speed connector. Audio codec
+ *  is not managed by ASoC/DAPM
+ *
+ *  Copyright (C) 2015 Intel Corp
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
+#include "../atom/sst-atom-controls.h"
+
+
+static const struct snd_soc_dapm_widget byt_nocodec_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_soc_dapm_route byt_nocodec_audio_map[] = {
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+
+	{"ssp2 Rx", NULL, "Mic"},
+	{"Speaker", NULL, "ssp2 Tx"},
+};
+
+static const struct snd_kcontrol_new byt_nocodec_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static int byt_nocodec_init(struct snd_soc_pcm_runtime *runtime)
+{
+	return 0;
+}
+
+static const struct snd_soc_pcm_stream byt_nocodec_dai_params = {
+	.formats = SNDRV_PCM_FMTBIT_S24_LE,
+	.rate_min = 48000,
+	.rate_max = 48000,
+	.channels_min = 2,
+	.channels_max = 2,
+};
+
+static int byt_nocodec_codec_fixup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	int ret;
+
+	/* The DSP will covert the FE rate to 48k, stereo, 24bits */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	/* set SSP2 to 24-bit */
+	params_set_format(params, SNDRV_PCM_FORMAT_S24_LE);
+
+	/*
+	 * Default mode for SSP configuration is TDM 4 slot, override config
+	 * with explicit setting to I2S 2ch 24-bit. The word length is set with
+	 * dai_set_tdm_slot() since there is no other API exposed
+	 */
+	ret = snd_soc_dai_set_fmt(rtd->cpu_dai,
+				  SND_SOC_DAIFMT_I2S     |
+				  SND_SOC_DAIFMT_NB_IF   |
+				  SND_SOC_DAIFMT_CBS_CFS
+				  );
+
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set format to I2S, err %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0x3, 0x3, 2, 24);
+	if (ret < 0) {
+		dev_err(rtd->dev, "can't set I2S config, err %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned int rates_48000[] = {
+	48000,
+};
+
+static struct snd_pcm_hw_constraint_list constraints_48000 = {
+	.count = ARRAY_SIZE(rates_48000),
+	.list  = rates_48000,
+};
+
+static int byt_nocodec_aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops byt_nocodec_aif1_ops = {
+	.startup = byt_nocodec_aif1_startup,
+};
+
+static struct snd_soc_dai_link byt_nocodec_dais[] = {
+	[MERR_DPCM_AUDIO] = {
+		.name = "Audio Port",
+		.stream_name = "Audio",
+		.cpu_dai_name = "media-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.ops = &byt_nocodec_aif1_ops,
+	},
+	[MERR_DPCM_DEEP_BUFFER] = {
+		.name = "Deep-Buffer Audio Port",
+		.stream_name = "Deep-Buffer Audio",
+		.cpu_dai_name = "deepbuffer-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		.ops = &byt_nocodec_aif1_ops,
+	},
+	[MERR_DPCM_COMPR] = {
+		.name = "Compressed Port",
+		.stream_name = "Compress",
+		.cpu_dai_name = "compress-cpu-dai",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.platform_name = "sst-mfld-platform",
+	},
+	/* CODEC<->CODEC link */
+	/* back ends */
+	{
+		.name = "LowSpeed Connector",
+		.be_id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+						| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = byt_nocodec_codec_fixup,
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = byt_nocodec_init,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card byt_nocodec_card = {
+	.name = "bytcr-nocodec",
+	.owner = THIS_MODULE,
+	.dai_link = byt_nocodec_dais,
+	.dapm_widgets = byt_nocodec_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(byt_nocodec_widgets),
+	.num_links = ARRAY_SIZE(byt_nocodec_dais),
+	.dapm_routes = byt_nocodec_audio_map,
+	.num_dapm_routes = ARRAY_SIZE(byt_nocodec_audio_map),
+	.controls = byt_nocodec_controls,
+	.num_controls = ARRAY_SIZE(byt_nocodec_controls),
+	.fully_routed = true,
+};
+
+static int snd_byt_nocodec_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+
+	/* register the soc card */
+	byt_nocodec_card.dev = &pdev->dev;
+
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &byt_nocodec_card);
+
+	if (ret_val) {
+		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
+			ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &byt_nocodec_card);
+	return ret_val;
+}
+
+static struct platform_driver snd_byt_nocodec_mc_driver = {
+	.driver = {
+		.name = "bytcr_nocodec",
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = snd_byt_nocodec_mc_probe,
+};
+
+module_platform_driver(snd_byt_nocodec_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail CR Nocodec Machine driver");
+MODULE_AUTHOR("Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bytcr_nocodec");
-- 
1.9.1
