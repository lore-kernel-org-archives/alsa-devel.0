From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: add card for
	MinnowBoardMax/Up I2S access" to the asoc tree
Date: Mon, 13 Mar 2017 16:58:03 +0000
Message-ID: <E1cnTIJ-000551-JY@debutante>
References: <1489105142-25878-5-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2789266D14
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:58:17 +0100 (CET)
In-Reply-To: <1489105142-25878-5-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: add card for MinnowBoardMax/Up I2S access

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 759db1c4660b558345573c7476a45c76a6aa07d2 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 9 Mar 2017 18:19:01 -0600
Subject: [PATCH] ASoC: Intel: boards: add card for MinnowBoardMax/Up I2S
 access

Add card with dummy codec and DAI to make I2S signals observable.
Uses Mic and Speaker pins/widgets to control DAPM

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/Kconfig                 |  12 ++
 sound/soc/intel/boards/Makefile         |   2 +
 sound/soc/intel/boards/bytcht_nocodec.c | 208 ++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 sound/soc/intel/boards/bytcht_nocodec.c

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 8d32fc336eb8..67968ef3bbda 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -214,6 +214,18 @@ config SND_SOC_INTEL_BYT_CHT_DA7213_MACH
 	  platforms with DA7212/7213 audio codec.
 	  If unsure select "N".
 
+config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
+	tristate "ASoC Audio driver for Intel Baytrail & Cherrytrail platform with no codec (MinnowBoard MAX, Up)"
+	depends on X86_INTEL_LPSS && I2C && ACPI
+	select SND_SST_ATOM_HIFI2_PLATFORM
+	select SND_SST_IPC_ACPI
+	select SND_SOC_INTEL_SST_MATCH if ACPI
+	help
+	  This adds support for ASoC machine driver for the MinnowBoard Max or
+	  Up boards and provides access to I2S signals on the Low-Speed
+	  connector
+	  If unsure select "N".
+
 config SND_SOC_INTEL_SKYLAKE
 	tristate
 	select SND_HDA_EXT_CORE
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 8a5d9edd16ee..56896e09445d 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -11,6 +11,7 @@ snd-soc-sst-cht-bsw-rt5672-objs := cht_bsw_rt5672.o
 snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 snd-soc-sst-cht-bsw-max98090_ti-objs := cht_bsw_max98090_ti.o
 snd-soc-sst-byt-cht-da7213-objs := bytcht_da7213.o
+snd-soc-sst-byt-cht-nocodec-objs := bytcht_nocodec.o
 snd-soc-skl_rt286-objs := skl_rt286.o
 snd-skl_nau88l25_max98357a-objs := skl_nau88l25_max98357a.o
 snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
@@ -28,6 +29,7 @@ obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH) += snd-soc-sst-cht-bsw-rt5672.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH) += snd-soc-sst-cht-bsw-rt5645.o
 obj-$(CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH) += snd-soc-sst-cht-bsw-max98090_ti.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH) += snd-soc-sst-byt-cht-da7213.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH) += snd-soc-sst-byt-cht-nocodec.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_RT286_MACH) += snd-soc-skl_rt286.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH) += snd-skl_nau88l25_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH) += snd-soc-skl_nau88l25_ssm4567.o
diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
new file mode 100644
index 000000000000..89853eeaaf9d
--- /dev/null
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -0,0 +1,208 @@
+/*
+ *  bytcht_nocodec.c - ASoc Machine driver for MinnowBoard Max and Up
+ *  to make I2S signals observable on the Low-Speed connector. Audio codec
+ *  is not managed by ASoC/DAPM
+ *
+ *  Copyright (C) 2015-2017 Intel Corp
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
+#include <linux/module.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../atom/sst-atom-controls.h"
+
+static const struct snd_soc_dapm_widget widgets[] = {
+	SND_SOC_DAPM_MIC("Mic", NULL),
+	SND_SOC_DAPM_SPK("Speaker", NULL),
+};
+
+static const struct snd_kcontrol_new controls[] = {
+	SOC_DAPM_PIN_SWITCH("Mic"),
+	SOC_DAPM_PIN_SWITCH("Speaker"),
+};
+
+static const struct snd_soc_dapm_route audio_map[] = {
+	{"ssp2 Tx", NULL, "codec_out0"},
+	{"ssp2 Tx", NULL, "codec_out1"},
+	{"codec_in0", NULL, "ssp2 Rx"},
+	{"codec_in1", NULL, "ssp2 Rx"},
+
+	{"ssp2 Rx", NULL, "Mic"},
+	{"Speaker", NULL, "ssp2 Tx"},
+};
+
+static int codec_fixup(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+			SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	int ret;
+
+	/* The DSP will convert the FE rate to 48k, stereo, 24bits */
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
+				  SND_SOC_DAIFMT_NB_NF   |
+				  SND_SOC_DAIFMT_CBS_CFS);
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
+static int aif1_startup(struct snd_pcm_substream *substream)
+{
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+			SNDRV_PCM_HW_PARAM_RATE,
+			&constraints_48000);
+}
+
+static struct snd_soc_ops aif1_ops = {
+	.startup = aif1_startup,
+};
+
+static struct snd_soc_dai_link dais[] = {
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
+		.ops = &aif1_ops,
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
+		.ops = &aif1_ops,
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
+		.name = "SSP2-LowSpeed Connector",
+		.id = 1,
+		.cpu_dai_name = "ssp2-port",
+		.platform_name = "sst-mfld-platform",
+		.no_pcm = 1,
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.codec_name = "snd-soc-dummy",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+						| SND_SOC_DAIFMT_CBS_CFS,
+		.be_hw_params_fixup = codec_fixup,
+		.ignore_suspend = 1,
+		.nonatomic = true,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+	},
+};
+
+/* SoC card */
+static struct snd_soc_card bytcht_nocodec_card = {
+	.name = "bytcht-nocodec",
+	.owner = THIS_MODULE,
+	.dai_link = dais,
+	.num_links = ARRAY_SIZE(dais),
+	.dapm_widgets = widgets,
+	.num_dapm_widgets = ARRAY_SIZE(widgets),
+	.dapm_routes = audio_map,
+	.num_dapm_routes = ARRAY_SIZE(audio_map),
+	.controls = controls,
+	.num_controls = ARRAY_SIZE(controls),
+	.fully_routed = true,
+};
+
+static int snd_bytcht_nocodec_mc_probe(struct platform_device *pdev)
+{
+	int ret_val = 0;
+
+	/* register the soc card */
+	bytcht_nocodec_card.dev = &pdev->dev;
+
+	ret_val = devm_snd_soc_register_card(&pdev->dev, &bytcht_nocodec_card);
+
+	if (ret_val) {
+		dev_err(&pdev->dev, "devm_snd_soc_register_card failed %d\n",
+			ret_val);
+		return ret_val;
+	}
+	platform_set_drvdata(pdev, &bytcht_nocodec_card);
+	return ret_val;
+}
+
+static struct platform_driver snd_bytcht_nocodec_mc_driver = {
+	.driver = {
+		.name = "bytcht_nocodec",
+	},
+	.probe = snd_bytcht_nocodec_mc_probe,
+};
+module_platform_driver(snd_bytcht_nocodec_mc_driver);
+
+MODULE_DESCRIPTION("ASoC Intel(R) Baytrail/Cherrytrail Nocodec Machine driver");
+MODULE_AUTHOR("Pierre-Louis Bossart <pierre-louis.bossart at linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:bytcht_nocodec");
-- 
2.11.0
