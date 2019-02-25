From: "Tc, Jenny" <jenny.tc@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add Maxim98373 support
Date: Mon, 25 Feb 2019 16:08:31 +0000
Message-ID: <20ADAB092842284E95860F279283C56456978C48@BGSMSX104.gar.corp.intel.com>
References: <1550550267-32630-1-git-send-email-jenny.tc@intel.com>
 <1550550267-32630-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 57449F89651
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 17:08:41 +0100 (CET)
In-Reply-To: <1550550267-32630-2-git-send-email-jenny.tc@intel.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: "N, Harshapriya" <harshapriya.n@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Chiang,
 Mac" <mac.chiang@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, "M R,
 Sathya Prakash" <sathya.prakash.m.r@intel.com>, "M,
 Naveen" <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org

Adding Mark Brown

A gentle ping for review

>-----Original Message-----
>From: Tc, Jenny
>Sent: Tuesday, February 19, 2019 9:54 AM
>To: alsa-devel@alsa-project.org
>Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>; Chiang, Mac
><mac.chiang@intel.com>; N, Harshapriya <harshapriya.n@intel.com>; M,
>Naveen <naveen.m@intel.com>; M R, Sathya Prakash
><sathya.prakash.m.r@intel.com>; Nujella, Sathyanarayana
><sathyanarayana.nujella@intel.com>; Tc, Jenny <jenny.tc@intel.com>
>Subject: [PATCH] ASoC: Intel: Boards: Add Maxim98373 support
>
>This patch enables the reuse of kbl_da7219_max98927 machine driver to
>support max98373. The same machine driver is modified for cases where one
>amplifier is swapped out with another. Most of the changes are about
>renaming the codec and codec_dai names, with minor differences due to
>support for 24 bits in one case and 16 in the other.
>
>Signed-off-by: Jenny TC <jenny.tc@intel.com>
>Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>---
> sound/soc/intel/boards/Kconfig                    |   1 +
> sound/soc/intel/boards/kbl_da7219_max98927.c      | 203
>+++++++++++++++++++---
> sound/soc/intel/common/soc-acpi-intel-kbl-match.c |  19 ++
> 3 files changed, 200 insertions(+), 23 deletions(-)
>
>diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
>index 0a7e40d..12d6b73 100644
>--- a/sound/soc/intel/boards/Kconfig
>+++ b/sound/soc/intel/boards/Kconfig
>@@ -293,6 +293,7 @@ config
>SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
> 	depends on MFD_INTEL_LPSS && I2C && ACPI
> 	select SND_SOC_DA7219
> 	select SND_SOC_MAX98927
>+	select SND_SOC_MAX98373
> 	select SND_SOC_DMIC
> 	select SND_SOC_HDAC_HDMI
> 	help
>diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c
>b/sound/soc/intel/boards/kbl_da7219_max98927.c
>index 723a493..f41a2fc 100644
>--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
>+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
>@@ -2,7 +2,7 @@
> // Copyright(c) 2018 Intel Corporation.
>
> /*
>- * Intel Kabylake I2S Machine Driver with MAX98927 & DA7219 Codecs
>+ * Intel Kabylake I2S Machine Driver with MAX98927, MAX98373 & DA7219
>+ Codecs
>  *
>  * Modified from:
>  *   Intel Kabylake I2S Machine driver supporting MAX98927 and
>@@ -24,8 +24,14 @@
>
> #define KBL_DIALOG_CODEC_DAI	"da7219-hifi"
> #define MAX98927_CODEC_DAI	"max98927-aif1"
>-#define MAXIM_DEV0_NAME		"i2c-MX98927:00"
>-#define MAXIM_DEV1_NAME		"i2c-MX98927:01"
>+#define MAX98927_DEV0_NAME	"i2c-MX98927:00"
>+#define MAX98927_DEV1_NAME	"i2c-MX98927:01"
>+
>+#define MAX98373_CODEC_DAI	"max98373-aif1"
>+#define MAX98373_DEV0_NAME	"i2c-MX98373:00"
>+#define MAX98373_DEV1_NAME	"i2c-MX98373:01"
>+
>+
> #define DUAL_CHANNEL	2
> #define QUAD_CHANNEL	4
> #define NAME_SIZE	32
>@@ -176,20 +182,38 @@ static int kabylake_ssp0_hw_params(struct
>snd_pcm_substream *substream,
> 	for (j = 0; j < runtime->num_codecs; j++) {
> 		struct snd_soc_dai *codec_dai = runtime->codec_dais[j];
>
>-		if (!strcmp(codec_dai->component->name,
>MAXIM_DEV0_NAME)) {
>+		if (!strcmp(codec_dai->component->name,
>MAX98927_DEV0_NAME)) {
> 			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8,
>16);
> 			if (ret < 0) {
> 				dev_err(runtime->dev, "DEV0 TDM slot
>err:%d\n", ret);
> 				return ret;
> 			}
> 		}
>-		if (!strcmp(codec_dai->component->name,
>MAXIM_DEV1_NAME)) {
>+		if (!strcmp(codec_dai->component->name,
>MAX98927_DEV1_NAME)) {
> 			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xC0, 3, 8,
>16);
> 			if (ret < 0) {
> 				dev_err(runtime->dev, "DEV1 TDM slot
>err:%d\n", ret);
> 				return ret;
> 			}
> 		}
>+		if (!strcmp(codec_dai->component->name,
>MAX98373_DEV0_NAME)) {
>+			ret = snd_soc_dai_set_tdm_slot(codec_dai,
>+							0x03, 3, 8, 24);
>+			if (ret < 0) {
>+				dev_err(runtime->dev,
>+						"DEV0 TDM slot err:%d\n",
>ret);
>+				return ret;
>+			}
>+		}
>+		if (!strcmp(codec_dai->component->name,
>MAX98373_DEV1_NAME)) {
>+			ret = snd_soc_dai_set_tdm_slot(codec_dai,
>+							0x0C, 3, 8, 24);
>+			if (ret < 0) {
>+				dev_err(runtime->dev,
>+						"DEV0 TDM slot err:%d\n",
>ret);
>+				return ret;
>+			}
>+		}
> 	}
>
> 	return 0;
>@@ -213,6 +237,25 @@ static int kabylake_ssp_fixup(struct
>snd_soc_pcm_runtime *rtd,
> 	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
>
> 	/*
>+	 * Topology for kblda7219m98373 & kblmax98373 supports only
>S24_LE,
>+	 * where as kblda7219m98927 & kblmax98927 supports S16_LE by
>default.
>+	 * Skipping the port wise FE and BE configuration for
>kblda7219m98373 &
>+	 * kblmax98373 as the topology (FE & BE) supports S24_LE only.
>+	 */
>+
>+	if (!strcmp(rtd->card->name, "kblda7219m98373") ||
>+		!strcmp(rtd->card->name, "kblmax98373")) {
>+		/* The ADSP will convert the FE rate to 48k, stereo */
>+		rate->min = rate->max = 48000;
>+		channels->min = channels->max = DUAL_CHANNEL;
>+
>+		/* set SSP to 24 bit */
>+		snd_mask_none(fmt);
>+		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
>+		return 0;
>+	}
>+
>+	/*
> 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
> 	 */
> 	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") || @@ -352,20
>+395,31 @@ static int kabylake_da7219_fe_init(struct snd_soc_pcm_runtime
>*rtd)  static int kbl_fe_startup(struct snd_pcm_substream *substream)  {
> 	struct snd_pcm_runtime *runtime = substream->runtime;
>+	struct snd_soc_pcm_runtime *soc_rt = substream->private_data;
>
> 	/*
> 	 * On this platform for PCM device we support,
> 	 * 48Khz
> 	 * stereo
>-	 * 16 bit audio
> 	 */
>
> 	runtime->hw.channels_max = DUAL_CHANNEL;
> 	snd_pcm_hw_constraint_list(runtime, 0,
>SNDRV_PCM_HW_PARAM_CHANNELS,
> 					   &constraints_channels);
>-
>-	runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
>-	snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
>+	/*
>+	 * Setup S24_LE (32 bit container and 24 bit valid data) for
>+	 * kblda7219m98373 & kblmax98373. For kblda7219m98927 &
>+	 * kblmax98927 keeping it as 16/16 due to topology FW dependency.
>+	 */
>+	if (!strcmp(soc_rt->card->name, "kblda7219m98373") ||
>+		!strcmp(soc_rt->card->name, "kblmax98373")) {
>+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_LE;
>+		snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
>+
>+	} else {
>+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
>+		snd_pcm_hw_constraint_msbits(runtime, 0, 16, 16);
>+	}
>
> 	snd_pcm_hw_constraint_list(runtime, 0,
> 				SNDRV_PCM_HW_PARAM_RATE,
>&constraints_rates); @@ -398,11 +452,23 @@ static int
>kabylake_dmic_fixup(struct snd_soc_pcm_runtime *rtd,  static int
>kabylake_dmic_startup(struct snd_pcm_substream *substream)  {
> 	struct snd_pcm_runtime *runtime = substream->runtime;
>+	struct snd_soc_pcm_runtime *soc_rt = substream->private_data;
>
> 	runtime->hw.channels_min = runtime->hw.channels_max =
>QUAD_CHANNEL;
> 	snd_pcm_hw_constraint_list(runtime, 0,
>SNDRV_PCM_HW_PARAM_CHANNELS,
> 			&constraints_channels_quad);
>
>+	/*
>+	 * Topology for kblda7219m98373 & kblmax98373 supports only
>S24_LE.
>+	 * The DMIC also configured for S24_LE. Forcing the DMIC format to
>+	 * S24_LE due to the topology FW dependency.
>+	 */
>+	if (!strcmp(soc_rt->card->name, "kblda7219m98373") ||
>+		!strcmp(soc_rt->card->name, "kblmax98373")) {
>+		runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_LE;
>+		snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
>+	}
>+
> 	return snd_pcm_hw_constraint_list(substream->runtime, 0,
> 			SNDRV_PCM_HW_PARAM_RATE, &constraints_rates);
>} @@ -448,29 +514,55 @@ static int kabylake_refcap_startup(struct
>snd_pcm_substream *substream)  static struct snd_soc_codec_conf
>max98927_codec_conf[] = {
>
> 	{
>-		.dev_name = MAXIM_DEV0_NAME,
>+		.dev_name = MAX98927_DEV0_NAME,
>+		.name_prefix = "Right",
>+	},
>+
>+	{
>+		.dev_name = MAX98927_DEV1_NAME,
>+		.name_prefix = "Left",
>+	},
>+};
>+
>+static struct snd_soc_codec_conf max98373_codec_conf[] = {
>+
>+	{
>+		.dev_name = MAX98373_DEV0_NAME,
> 		.name_prefix = "Right",
> 	},
>
> 	{
>-		.dev_name = MAXIM_DEV1_NAME,
>+		.dev_name = MAX98373_DEV1_NAME,
> 		.name_prefix = "Left",
> 	},
> };
>
>-static struct snd_soc_dai_link_component ssp0_codec_components[] = {
>+static struct snd_soc_dai_link_component
>+max98927_ssp0_codec_components[] = {
> 	{ /* Left */
>-		.name = MAXIM_DEV0_NAME,
>+		.name = MAX98927_DEV0_NAME,
> 		.dai_name = MAX98927_CODEC_DAI,
> 	},
>
> 	{  /* For Right */
>-		.name = MAXIM_DEV1_NAME,
>+		.name = MAX98927_DEV1_NAME,
> 		.dai_name = MAX98927_CODEC_DAI,
> 	},
>
> };
>
>+static struct snd_soc_dai_link_component
>max98373_ssp0_codec_components[] = {
>+	{ /* Left */
>+		.name = MAX98373_DEV0_NAME,
>+		.dai_name = MAX98373_CODEC_DAI,
>+	},
>+
>+	{  /* For Right */
>+		.name = MAX98373_DEV1_NAME,
>+		.dai_name = MAX98373_CODEC_DAI,
>+	},
>+
>+};
>+
> /* kabylake digital audio interface glue - connects codec <--> CPU */  static
>struct snd_soc_dai_link kabylake_dais[] = {
> 	/* Front End DAI links */
>@@ -607,8 +699,8 @@ static int kabylake_refcap_startup(struct
>snd_pcm_substream *substream)
> 		.cpu_dai_name = "SSP0 Pin",
> 		.platform_name = "0000:00:1f.3",
> 		.no_pcm = 1,
>-		.codecs = ssp0_codec_components,
>-		.num_codecs = ARRAY_SIZE(ssp0_codec_components),
>+		.codecs = max98927_ssp0_codec_components,
>+		.num_codecs =
>ARRAY_SIZE(max98927_ssp0_codec_components),
> 		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
> 			SND_SOC_DAIFMT_NB_NF |
> 			SND_SOC_DAIFMT_CBS_CFS,
>@@ -683,7 +775,7 @@ static int kabylake_refcap_startup(struct
>snd_pcm_substream *substream)  };
>
> /* kabylake digital audio interface glue - connects codec <--> CPU */ -static
>struct snd_soc_dai_link kabylake_max98927_dais[] = {
>+static struct snd_soc_dai_link kabylake_max98_927_373_dais[] = {
> 	/* Front End DAI links */
> 	[KBL_DPCM_AUDIO_PB] = {
> 		.name = "Kbl Audio Port",
>@@ -802,8 +894,8 @@ static int kabylake_refcap_startup(struct
>snd_pcm_substream *substream)
> 		.cpu_dai_name = "SSP0 Pin",
> 		.platform_name = "0000:00:1f.3",
> 		.no_pcm = 1,
>-		.codecs = ssp0_codec_components,
>-		.num_codecs = ARRAY_SIZE(ssp0_codec_components),
>+		.codecs = max98927_ssp0_codec_components,
>+		.num_codecs =
>ARRAY_SIZE(max98927_ssp0_codec_components),
> 		.dai_fmt = SND_SOC_DAIFMT_DSP_B |
> 			SND_SOC_DAIFMT_NB_NF |
> 			SND_SOC_DAIFMT_CBS_CFS,
>@@ -917,8 +1009,8 @@ static int kabylake_card_late_probe(struct
>snd_soc_card *card)  static struct snd_soc_card kbl_audio_card_max98927 = {
> 	.name = "kblmax98927",
> 	.owner = THIS_MODULE,
>-	.dai_link = kabylake_max98927_dais,
>-	.num_links = ARRAY_SIZE(kabylake_max98927_dais),
>+	.dai_link = kabylake_max98_927_373_dais,
>+	.num_links = ARRAY_SIZE(kabylake_max98_927_373_dais),
> 	.controls = kabylake_controls,
> 	.num_controls = ARRAY_SIZE(kabylake_controls),
> 	.dapm_widgets = kabylake_widgets,
>@@ -931,9 +1023,46 @@ static int kabylake_card_late_probe(struct
>snd_soc_card *card)
> 	.late_probe = kabylake_card_late_probe,  };
>
>+static struct snd_soc_card kbl_audio_card_da7219_m98373 = {
>+	.name = "kblda7219m98373",
>+	.owner = THIS_MODULE,
>+	.dai_link = kabylake_dais,
>+	.num_links = ARRAY_SIZE(kabylake_dais),
>+	.controls = kabylake_controls,
>+	.num_controls = ARRAY_SIZE(kabylake_controls),
>+	.dapm_widgets = kabylake_widgets,
>+	.num_dapm_widgets = ARRAY_SIZE(kabylake_widgets),
>+	.dapm_routes = kabylake_map,
>+	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
>+	.codec_conf = max98373_codec_conf,
>+	.num_configs = ARRAY_SIZE(max98373_codec_conf),
>+	.fully_routed = true,
>+	.late_probe = kabylake_card_late_probe, };
>+
>+static struct snd_soc_card kbl_audio_card_max98373 = {
>+	.name = "kblmax98373",
>+	.owner = THIS_MODULE,
>+	.dai_link = kabylake_max98_927_373_dais,
>+	.num_links = ARRAY_SIZE(kabylake_max98_927_373_dais),
>+	.controls = kabylake_controls,
>+	.num_controls = ARRAY_SIZE(kabylake_controls),
>+	.dapm_widgets = kabylake_widgets,
>+	.num_dapm_widgets = ARRAY_SIZE(kabylake_widgets),
>+	.dapm_routes = kabylake_map,
>+	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
>+	.codec_conf = max98373_codec_conf,
>+	.num_configs = ARRAY_SIZE(max98373_codec_conf),
>+	.fully_routed = true,
>+	.late_probe = kabylake_card_late_probe, };
>+
> static int kabylake_audio_probe(struct platform_device *pdev)  {
> 	struct kbl_codec_private *ctx;
>+	struct snd_soc_dai_link *kbl_dai_link;
>+	struct snd_soc_dai_link_component **codecs;
>+	int i = 0;
>
> 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
> 	if (!ctx)
>@@ -944,6 +1073,22 @@ static int kabylake_audio_probe(struct
>platform_device *pdev)
> 	kabylake_audio_card =
> 		(struct snd_soc_card *)pdev->id_entry->driver_data;
>
>+	kbl_dai_link = kabylake_audio_card->dai_link;
>+
>+	/* Update codecs for SSP0 with max98373 codec info */
>+	if (!strcmp(pdev->name, "kbl_da7219_max98373") ||
>+		(!strcmp(pdev->name, "kbl_max98373"))) {
>+		for (i = 0; i < kabylake_audio_card->num_links; ++i) {
>+			if (strcmp(kbl_dai_link[i].name, "SSP0-Codec"))
>+				continue;
>+
>+			codecs = &(kbl_dai_link[i].codecs);
>+			*codecs = max98373_ssp0_codec_components;
>+			kbl_dai_link[i].num_codecs =
>+
>	ARRAY_SIZE(max98373_ssp0_codec_components);
>+			break;
>+		}
>+	}
> 	kabylake_audio_card->dev = &pdev->dev;
> 	snd_soc_card_set_drvdata(kabylake_audio_card, ctx);
>
>@@ -961,13 +1106,23 @@ static int kabylake_audio_probe(struct
>platform_device *pdev)
> 		.driver_data =
> 			(kernel_ulong_t)&kbl_audio_card_max98927,
> 	},
>+	{
>+		.name = "kbl_da7219_max98373",
>+		.driver_data =
>+			(kernel_ulong_t)&kbl_audio_card_da7219_m98373,
>+	},
>+	{
>+		.name = "kbl_max98373",
>+		.driver_data =
>+			(kernel_ulong_t)&kbl_audio_card_max98373,
>+	},
> 	{ }
> };
>
> static struct platform_driver kabylake_audio = {
> 	.probe = kabylake_audio_probe,
> 	.driver = {
>-		.name = "kbl_da7219_max98927",
>+		.name = "kbl_da7219_max98_927_373",
> 		.pm = &snd_soc_pm_ops,
> 	},
> 	.id_table = kbl_board_ids,
>@@ -976,8 +1131,10 @@ static int kabylake_audio_probe(struct
>platform_device *pdev)
> module_platform_driver(kabylake_audio)
>
> /* Module information */
>-MODULE_DESCRIPTION("Audio KabyLake Machine driver for MAX98927 &
>DA7219");
>+MODULE_DESCRIPTION("Audio KabyLake Machine driver for
>MAX98927/MAX98373
>+& DA7219");
> MODULE_AUTHOR("Mac Chiang <mac.chiang@intel.com>");
>MODULE_LICENSE("GPL v2");
>MODULE_ALIAS("platform:kbl_da7219_max98927");
> MODULE_ALIAS("platform:kbl_max98927");
>+MODULE_ALIAS("platform:kbl_da7219_max98373");
>+MODULE_ALIAS("platform:kbl_max98373");
>diff --git a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
>b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
>index e6fa6f4..4b33105 100644
>--- a/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
>+++ b/sound/soc/intel/common/soc-acpi-intel-kbl-match.c
>@@ -37,6 +37,11 @@
> 	.codecs = {"MX98927"}
> };
>
>+static struct snd_soc_acpi_codecs kbl_7219_98373_codecs = {
>+	.num_codecs = 1,
>+	.codecs = {"MX98373"}
>+};
>+
> struct snd_soc_acpi_mach snd_soc_acpi_intel_kbl_machines[] = {
> 	{
> 		.id = "INT343A",
>@@ -106,6 +111,20 @@ struct snd_soc_acpi_mach
>snd_soc_acpi_intel_kbl_machines[] = {
> 		.drv_name = "kbl_rt5660",
> 		.fw_filename = "intel/dsp_fw_kbl.bin",
> 	},
>+	{
>+		.id = "DLGS7219",
>+		.drv_name = "kbl_da7219_max98373",
>+		.fw_filename = "intel/dsp_fw_kbl.bin",
>+		.machine_quirk = snd_soc_acpi_codec_list,
>+		.quirk_data = &kbl_7219_98373_codecs,
>+		.pdata = &skl_dmic_data
>+	},
>+	{
>+		.id = "MX98373",
>+		.drv_name = "kbl_max98373",
>+		.fw_filename = "intel/dsp_fw_kbl.bin",
>+		.pdata = &skl_dmic_data
>+	},
> 	{},
> };
> EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_kbl_machines);
>--
>1.9.1
