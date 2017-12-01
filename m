From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC 01/10] ASoC: Intel: Boards: Machine driver for
	Intel platforms
Date: Fri,  1 Dec 2017 14:43:59 +0530
Message-ID: <1512119648-2700-2-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8599C267C13
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:09:57 +0100 (CET)
In-Reply-To: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Add machine driver for Intel platforms(SKL/KBL) with HDA and iDisp codecs.
This patch adds support for only iDisp (HDMI/DP) codec. In the
following patch support for HDA codec will be added.

This should work for other Intel platforms as well e.g. BXT,GLK,CNL
however this series is not tested on all the platforms.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/boards/Kconfig           |  10 ++
 sound/soc/intel/boards/Makefile          |   2 +
 sound/soc/intel/boards/skl_hda_generic.c | 276 +++++++++++++++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 sound/soc/intel/boards/skl_hda_generic.c

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 6f75470..4f8bd02 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -262,4 +262,14 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
           Say Y if you have such a device.
           If unsure select "N".
 
+config SND_SOC_INTEL_SKL_HDA_GENERIC_MACH
+        tristate "ASoC Audio driver for SKL/KBL with HDA Codecs"
+        select SND_SOC_INTEL_SST
+        depends on SND_SOC_INTEL_SKYLAKE
+        select SND_SOC_HDAC_HDMI
+        help
+          This adds support for ASoC Onboard Codec HDA machine driver. This will
+          create an alsa sound card for HDA Codecs.
+          Say Y if you have such a device.
+          If unsure select "N".
 endif
diff --git a/sound/soc/intel/boards/Makefile b/sound/soc/intel/boards/Makefile
index 69d2dfa..4686727 100644
--- a/sound/soc/intel/boards/Makefile
+++ b/sound/soc/intel/boards/Makefile
@@ -17,6 +17,7 @@ snd-soc-sst-byt-cht-nocodec-objs := bytcht_nocodec.o
 snd-soc-kbl_rt5663_max98927-objs := kbl_rt5663_max98927.o
 snd-soc-kbl_rt5663_rt5514_max98927-objs := kbl_rt5663_rt5514_max98927.o
 snd-soc-skl_rt286-objs := skl_rt286.o
+snd-soc-skl_hda_generic-objs := skl_hda_generic.o
 snd-skl_nau88l25_max98357a-objs := skl_nau88l25_max98357a.o
 snd-soc-skl_nau88l25_ssm4567-objs := skl_nau88l25_ssm4567.o
 
@@ -40,3 +41,4 @@ obj-$(CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH) += snd-soc-kbl_rt566
 obj-$(CONFIG_SND_SOC_INTEL_SKL_RT286_MACH) += snd-soc-skl_rt286.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH) += snd-skl_nau88l25_max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH) += snd-soc-skl_nau88l25_ssm4567.o
+obj-$(CONFIG_SND_SOC_INTEL_SKL_HDA_GENERIC_MACH) += snd-soc-skl_hda_generic.o
diff --git a/sound/soc/intel/boards/skl_hda_generic.c b/sound/soc/intel/boards/skl_hda_generic.c
new file mode 100644
index 0000000..ece39b5
--- /dev/null
+++ b/sound/soc/intel/boards/skl_hda_generic.c
@@ -0,0 +1,276 @@
+/*
+ * Intel Machine Driver for SKL/KBL platforms with HDA Codecs
+ *
+ * Copyright (C) 2017, Intel Corporation. All rights reserved.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/jack.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "../../codecs/hdac_hdmi.h"
+#include "../skylake/skl.h"
+
+static struct snd_soc_card skl_hda_audio_card;
+static struct snd_soc_jack skl_hda_hdmi_jack[3];
+
+struct skl_hda_hdmi_pcm {
+	struct list_head head;
+	struct snd_soc_dai *codec_dai;
+	int device;
+};
+
+struct skl_hda_private {
+	struct list_head hdmi_pcm_list;
+};
+
+enum {
+	SKL_HDA_DPCM_AUDIO_HDMI1_PB = 0,
+	SKL_HDA_DPCM_AUDIO_HDMI2_PB,
+	SKL_HDA_DPCM_AUDIO_HDMI3_PB,
+};
+
+static const struct snd_soc_dapm_route skl_hda_map[] = {
+
+	{ "hifi3", NULL, "iDisp3 Tx"},
+	{ "iDisp3 Tx", NULL, "iDisp3_out"},
+	{ "hifi2", NULL, "iDisp2 Tx"},
+	{ "iDisp2 Tx", NULL, "iDisp2_out"},
+	{ "hifi1", NULL, "iDisp1 Tx"},
+	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+
+};
+
+static int skl_hda_hdmi1_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hda_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = SKL_HDA_DPCM_AUDIO_HDMI1_PB;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
+}
+
+static int skl_hda_hdmi2_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hda_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = SKL_HDA_DPCM_AUDIO_HDMI2_PB;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
+}
+
+static int skl_hda_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_dai *dai = rtd->codec_dai;
+	struct skl_hda_hdmi_pcm *pcm;
+
+	pcm = devm_kzalloc(rtd->card->dev, sizeof(*pcm), GFP_KERNEL);
+	if (!pcm)
+		return -ENOMEM;
+
+	pcm->device = SKL_HDA_DPCM_AUDIO_HDMI3_PB;
+	pcm->codec_dai = dai;
+
+	list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
+
+	return 0;
+}
+
+/* skl_hda_digital audio interface glue - connects codec <--> CPU */
+static struct snd_soc_dai_link skl_hda_dais[] = {
+	/* Front End DAI links */
+	[SKL_HDA_DPCM_AUDIO_HDMI1_PB] = {
+		.name = "SKL HDA HDMI Port1",
+		.stream_name = "Hdmi1",
+		.cpu_dai_name = "HDMI1 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[SKL_HDA_DPCM_AUDIO_HDMI2_PB] = {
+		.name = "SKL HDA HDMI Port2",
+		.stream_name = "Hdmi2",
+		.cpu_dai_name = "HDMI2 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = NULL,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+	[SKL_HDA_DPCM_AUDIO_HDMI3_PB] = {
+		.name = "SKL HDA HDMI Port3",
+		.stream_name = "Hdmi3",
+		.cpu_dai_name = "HDMI3 Pin",
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.platform_name = "0000:00:1f.3",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+		.init = NULL,
+		.nonatomic = 1,
+		.dynamic = 1,
+	},
+
+	/* Back End DAI links */
+	{
+		.name = "iDisp1",
+		.id = 1,
+		.cpu_dai_name = "iDisp1 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi1",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.init = skl_hda_hdmi1_init,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp2",
+		.id = 2,
+		.cpu_dai_name = "iDisp2 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi2",
+		.platform_name = "0000:00:1f.3",
+		.init = skl_hda_hdmi2_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+	{
+		.name = "iDisp3",
+		.id = 3,
+		.cpu_dai_name = "iDisp3 Pin",
+		.codec_name = "ehdaudio0D2",
+		.codec_dai_name = "intel-hdmi-hifi3",
+		.platform_name = "0000:00:1f.3",
+		.init = skl_hda_hdmi3_init,
+		.dpcm_playback = 1,
+		.no_pcm = 1,
+	},
+};
+
+#define NAME_SIZE	32
+static int skl_hda_card_late_probe(struct snd_soc_card *card)
+{
+	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
+	struct skl_hda_hdmi_pcm *pcm;
+	struct snd_soc_codec *codec = NULL;
+	int err, i = 0;
+	char jack_name[NAME_SIZE];
+
+	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
+		codec = pcm->codec_dai->codec;
+		snprintf(jack_name, sizeof(jack_name),
+			"HDMI/DP, pcm=%d Jack", pcm->device);
+		err = snd_soc_card_jack_new(card, jack_name,
+					SND_JACK_AVOUT, &skl_hda_hdmi_jack[i],
+					NULL, 0);
+
+		if (err)
+			return err;
+
+		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
+						&skl_hda_hdmi_jack[i]);
+		if (err < 0)
+			return err;
+
+		i++;
+	}
+
+	if (!codec)
+		return -EINVAL;
+
+	return hdac_hdmi_jack_port_init(codec, &card->dapm);
+}
+
+static struct snd_soc_card skl_hda_audio_card = {
+	.name = "skl_hda_card",
+	.owner = THIS_MODULE,
+	.dai_link = skl_hda_dais,
+	.num_links = ARRAY_SIZE(skl_hda_dais),
+	.dapm_routes = skl_hda_map,
+	.num_dapm_routes = ARRAY_SIZE(skl_hda_map),
+	.fully_routed = true,
+	.late_probe = skl_hda_card_late_probe,
+};
+
+static int skl_hda_audio_probe(struct platform_device *pdev)
+{
+	struct skl_hda_private *ctx;
+
+	dev_dbg(&pdev->dev, "%s: machine driver probe got called\n", __func__);
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
+
+	skl_hda_audio_card.dev = &pdev->dev;
+	snd_soc_card_set_drvdata(&skl_hda_audio_card, ctx);
+
+	return devm_snd_soc_register_card(&pdev->dev, &skl_hda_audio_card);
+}
+
+static const struct platform_device_id skl_hda_board_ids[] = {
+	{ .name = "skl_hda_generic" },
+	{ }
+};
+
+static struct platform_driver skl_hda_audio = {
+	.probe = skl_hda_audio_probe,
+	.driver = {
+		.name = "skl_hda_generic",
+		.pm = &snd_soc_pm_ops,
+	},
+	.id_table = skl_hda_board_ids,
+};
+
+module_platform_driver(skl_hda_audio)
+
+/* Module information */
+MODULE_DESCRIPTION("SKL/KBL HDA Generic Machine driver");
+MODULE_AUTHOR("Rakesh Ughreja <rakesh.a.ughreja@intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:skl_hda_generic");
-- 
2.7.4
