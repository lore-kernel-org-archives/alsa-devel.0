From: Michele Curti <michele.curti@gmail.com>
Subject: Re: writing an alsa driver
Date: Sat, 23 May 2015 18:32:51 +0200
Message-ID: <20150523163221.GA936@asus>
References: <20150521145232.GA12157@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D07802604BA
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 18:32:56 +0200 (CEST)
Received: by wicmx19 with SMTP id mx19so14482195wic.0
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 09:32:56 -0700 (PDT)
Received: from asus (host201-167-dynamic.50-79-r.retail.telecomitalia.it.
 [79.50.167.201])
 by mx.google.com with ESMTPSA id z9sm2693797wiv.9.2015.05.23.09.32.54
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 23 May 2015 09:32:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150521145232.GA12157@dellaz>
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
List-Id: alsa-devel@alsa-project.org

On Thu, May 21, 2015 at 04:52:32PM +0200, Michele Curti wrote:
> Hi all,
> I'm going to *try* to "write" a driver for the sound card on my new laptop,
> an asus x205ta.
> 
> To be fair I have almost no experience but I'm hoping that all the code is
> already present and it only needs some adaptations.
> 
> The cpu is a intel bay trail z3735f, the sound card is a realtek rt5648 that
> has the same product Id of the rt5645 (0x6308).
> 
> I see in kernel sources:
>  - the codec driver
> 	sound/soc/codecs/rt5645.c
>  - a baytrail board that uses the rt5640
> 	sound/soc/intel/boards/byt-rt5640.c
>  - a braswell board that uses the rt5645
> 	sound/soc/intel/boards/cht_bsw_rt5645.c
> 
> What do you think?  Is it feasible, given a good amount of free-time? :p
> 
> Thanks,
> Michele


So I started.. :)
At the end of the email there is the patch.


What I did:
  - copied the board file byt-rt5640.c to byt-rt5645.c
  - find&replace 5640->5645 in byt-rt5645.c
  - added acpi device id to detect the sound card
  - added kernel config SND_SOC_INTEL_BYT_RT5645_MACH to select the driver


Nothing works.

But at least the right modules are loaded it seems..  Here the output of 
"lsmod | grep snd":
snd_soc_sst_baytrail_pcm    24576  0 
snd_soc_sst_ipc        16384  1 snd_soc_sst_baytrail_pcm
snd_soc_sst_dsp        36864  2 snd_soc_sst_baytrail_pcm,snd_soc_sst_ipc
snd_soc_sst_byt_rt5645_mach    16384  0 
snd_soc_rt5645         94208  0 
regmap_i2c             16384  1 snd_soc_rt5645
snd_soc_rl6231         16384  1 snd_soc_rt5645
snd_soc_core          159744  3 snd_soc_rt5645,snd_soc_sst_baytrail_pcm,snd_soc_sst_byt_rt5645_mach
snd_compress           20480  1 snd_soc_core
dw_dmac_core           28672  2 dw_dmac,snd_soc_sst_dsp
snd_pcm                90112  3 snd_soc_rt5645,snd_soc_core,snd_soc_sst_baytrail_pcm
snd_timer              28672  1 snd_pcm
snd                    57344  4 snd_soc_core,snd_timer,snd_pcm,snd_compress
soundcore              16384  1 snd
snd_soc_sst_acpi       16384  0 


And dmesg tells me: 
[  +1.386847] rt5645 i2c-10EC5648:00: Failed to reguest IRQ: -22
[  +0.000102] rt5645 i2c-10EC5648:00: Fail gpio_request hp_det_gpio
[  +0.000094] rt5645 i2c-10EC5648:00: Fail gpio_direction hp_det_gpio
[  +0.088989] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.062539] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.021995] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.001828] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.016646] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:7 / ret_size:4
[  +0.002541] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.004755] brcmfmac: brcmf_sdio_drivestrengthinit: No SDIO Drive strength init done for chip 43340 rev 2 pmurev 20
[  +0.003586] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.002844] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.001705] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.011199] i2c_hid i2c-PDEC3393:00: error in i2c_hid_init_report size:19 / ret_size:4
[  +0.018094] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.067913] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:633 / ret_size:7
[  +0.004378] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.000145] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.000980] i2c_hid i2c-ELAN0100:00: error in i2c_hid_init_report size:131 / ret_size:7
[  +0.000949] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.020845] (NULL device *): ipc: error DSP boot timeout
[  +0.213465] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.036706] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +0.008144] byt-rt5645 byt-rt5645: ASoC: CPU DAI baytrail-pcm-audio not registered
[  +1.811435] brcmfmac: brcmf_c_preinit_dcmds: Firmware version = wl0: Jun 17 2014 11:48:43 version 6.10.190.49 (r485840) FWID 01-8744bcd2
[  +0.014526] brcmfmac: brcmf_cfg80211_reg_notifier: not a ISO3166 code
[  +0.092535] brcmfmac: brcmf_add_if: ERROR: netdev:wlan0 already exists
[  +0.000011] brcmfmac: brcmf_add_if: ignore IF event


For now I'm at a standstill and I don't understand a lot of things...
I will read the code.. :)

Regards,
Michele

Signed-off-by: Michele Curti <michele.curti@gmail.com>
---
 sound/soc/codecs/rt5645.c           |   2 +
 sound/soc/intel/Kconfig             |   9 ++
 sound/soc/intel/boards/Makefile     |   2 +
 sound/soc/intel/boards/byt-rt5645.c | 222 ++++++++++++++++++++++++++++++++++++
 sound/soc/intel/common/sst-acpi.c   |   1 +
 5 files changed, 236 insertions(+)
 create mode 100644 sound/soc/intel/boards/byt-rt5645.c

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index be4d741..3692569 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2652,6 +2652,7 @@ static const struct regmap_config rt5645_regmap = {
 
 static const struct i2c_device_id rt5645_i2c_id[] = {
 	{ "rt5645", 0 },
+	{ "rt5648", 0 },
 	{ "rt5650", 0 },
 	{ }
 };
@@ -2660,6 +2661,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 #ifdef CONFIG_ACPI
 static struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
+	{ "10EC5648", 0 },
 	{ "10EC5650", 0 },
 	{},
 };
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ee03dbd..ad324c0 100644
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
index f8237f0..bcb082a 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -1,5 +1,6 @@
 snd-soc-sst-haswell-objs := haswell.o
 snd-soc-sst-byt-rt5640-mach-objs := byt-rt5640.o
+snd-soc-sst-byt-rt5645-mach-objs := byt-rt5645.o
 snd-soc-sst-byt-max98090-mach-objs := byt-max98090.o
 snd-soc-sst-broadwell-objs := broadwell.o
 snd-soc-sst-bytcr-rt5640-objs := bytcr_rt5640.o
@@ -8,6 +9,7 @@ snd-soc-sst-cht-bsw-rt5645-objs := cht_bsw_rt5645.o
 
 obj-$(CONFIG_SND_SOC_INTEL_HASWELL_MACH) += snd-soc-sst-haswell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5640_MACH) += snd-soc-sst-byt-rt5640-mach.o
+obj-$(CONFIG_SND_SOC_INTEL_BYT_RT5645_MACH) += snd-soc-sst-byt-rt5645-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BYT_MAX98090_MACH) += snd-soc-sst-byt-max98090-mach.o
 obj-$(CONFIG_SND_SOC_INTEL_BROADWELL_MACH) += snd-soc-sst-broadwell.o
 obj-$(CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH) += snd-soc-sst-bytcr-rt5640.o
diff --git a/sound/soc/intel/boards/byt-rt5645.c b/sound/soc/intel/boards/byt-rt5645.c
new file mode 100644
index 0000000..5bdb56e
--- /dev/null
+++ b/sound/soc/intel/boards/byt-rt5645.c
@@ -0,0 +1,222 @@
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
+	{"Headset Mic", NULL, "MICBIAS1"},
+	{"IN2P", NULL, "Headset Mic"},
+	{"Headphone", NULL, "HPOL"},
+	{"Headphone", NULL, "HPOR"},
+	{"Speaker", NULL, "SPOLP"},
+	{"Speaker", NULL, "SPOLN"},
+	{"Speaker", NULL, "SPORP"},
+	{"Speaker", NULL, "SPORN"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_intmic_dmic1_map[] = {
+	{"DMIC1", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_intmic_dmic2_map[] = {
+	{"DMIC2", NULL, "Internal Mic"},
+};
+
+static const struct snd_soc_dapm_route byt_rt5645_intmic_in1_map[] = {
+	{"Internal Mic", NULL, "MICBIAS1"},
+	{"IN1P", NULL, "Internal Mic"},
+};
+
+enum {
+	BYT_RT5645_DMIC1_MAP,
+	BYT_RT5645_DMIC2_MAP,
+	BYT_RT5645_IN1_MAP,
+};
+
+#define BYT_RT5645_MAP(quirk)	((quirk) & 0xff)
+#define BYT_RT5645_DMIC_EN	BIT(16)
+
+static unsigned long byt_rt5645_quirk = BYT_RT5645_DMIC1_MAP |
+					BYT_RT5645_DMIC_EN;
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
+static int byt_rt5645_quirk_cb(const struct dmi_system_id *id)
+{
+	byt_rt5645_quirk = (unsigned long)id->driver_data;
+	return 1;
+}
+
+static const struct dmi_system_id byt_rt5645_quirk_table[] = {
+	{
+		.callback = byt_rt5645_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X205TA"),
+		},
+		.driver_data = (unsigned long *)BYT_RT5645_IN1_MAP,
+	},
+	{
+		.callback = byt_rt5645_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DellInc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Venue 8 Pro 5830"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5645_DMIC2_MAP |
+						 BYT_RT5645_DMIC_EN),
+	},
+	{}
+};
+
+static int byt_rt5645_init(struct snd_soc_pcm_runtime *runtime)
+{
+	int ret;
+	struct snd_soc_card *card = runtime->card;
+	const struct snd_soc_dapm_route *custom_map;
+	int num_routes;
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
+	dmi_check_system(byt_rt5645_quirk_table);
+	switch (BYT_RT5645_MAP(byt_rt5645_quirk)) {
+	case BYT_RT5645_IN1_MAP:
+		custom_map = byt_rt5645_intmic_in1_map;
+		num_routes = ARRAY_SIZE(byt_rt5645_intmic_in1_map);
+		break;
+	case BYT_RT5645_DMIC2_MAP:
+		custom_map = byt_rt5645_intmic_dmic2_map;
+		num_routes = ARRAY_SIZE(byt_rt5645_intmic_dmic2_map);
+		break;
+	default:
+		custom_map = byt_rt5645_intmic_dmic1_map;
+		num_routes = ARRAY_SIZE(byt_rt5645_intmic_dmic1_map);
+	}
+
+	ret = snd_soc_dapm_add_routes(&card->dapm, custom_map, num_routes);
+	if (ret)
+		return ret;
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
+		.cpu_dai_name = "baytrail-pcm-audio",
+		.codec_dai_name = "rt5645-aif1",
+		.codec_name = "i2c-10EC56458:00",
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
2.4.1
