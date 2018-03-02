From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [PATCH v2 10/10] ASoC: Intel: Boards: add support for
	HDA codecs
Date: Fri,  2 Mar 2018 16:22:38 +0530
Message-ID: <1519987958-5482-11-git-send-email-rakesh.a.ughreja@intel.com>
References: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C83A267CEA
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 11:50:36 +0100 (CET)
In-Reply-To: <1519987958-5482-1-git-send-email-rakesh.a.ughreja@intel.com>
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

Add support for HDA codecs. add required widgets, controls, routes
and dai links for the same.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/boards/Kconfig               |  1 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 24 ++++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 39 +++++++++++++++++++++++
 sound/soc/intel/skylake/skl.c                | 47 +++++++++++++++++++++++++---
 5 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 5c24b79..953cf4c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -283,6 +283,7 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH
 config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 	tristate "SKL/KBL/BXT/APL with HDA Codecs"
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_HDAC_HDA
 	help
 	  This adds support for ASoC machine driver for Intel platforms
 	  SKL/KBL/BXT/APL with iDisp, HDA audio codecs.
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 7066bed..f5fa475 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -73,6 +73,30 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 		.dpcm_playback = 1,
 		.no_pcm = 1,
 	},
+	{
+		.name = "Analog Playback and Capture",
+		.id = 4,
+		.cpu_dai_name = "Analog CPU DAI",
+		.codec_name = "ehdaudio0D0",
+		.codec_dai_name = "Analog Codec DAI",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = NULL,
+		.no_pcm = 1,
+	},
+	{
+		.name = "Digital Playback and Capture",
+		.id = 5,
+		.cpu_dai_name = "Digital CPU DAI",
+		.codec_name = "ehdaudio0D0",
+		.codec_dai_name = "Digital Codec DAI",
+		.platform_name = "0000:00:1f.3",
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = NULL,
+		.no_pcm = 1,
+	},
 };
 
 int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.h b/sound/soc/intel/boards/skl_hda_dsp_common.h
index 80e64ff..e851fb6 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -13,7 +13,7 @@
 #include <sound/core.h>
 #include <sound/jack.h>
 
-#define HDA_DSP_MAX_BE_DAI_LINKS 3
+#define HDA_DSP_MAX_BE_DAI_LINKS 5
 
 struct skl_hda_hdmi_pcm {
 	struct list_head head;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 720b124..9174796 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -16,6 +16,16 @@
 #include "../skylake/skl.h"
 #include "skl_hda_dsp_common.h"
 
+
+static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
+	SND_SOC_DAPM_HP("Analog Out", NULL),
+	SND_SOC_DAPM_MIC("Analog In", NULL),
+	SND_SOC_DAPM_HP("Alt Analog Out", NULL),
+	SND_SOC_DAPM_MIC("Alt Analog In", NULL),
+	SND_SOC_DAPM_SPK("Digital Out", NULL),
+	SND_SOC_DAPM_MIC("Digital In", NULL),
+};
+
 static const struct snd_soc_dapm_route skl_hda_map[] = {
 
 	{ "hifi3", NULL, "iDisp3 Tx"},
@@ -24,6 +34,29 @@ static const struct snd_soc_dapm_route skl_hda_map[] = {
 	{ "iDisp2 Tx", NULL, "iDisp2_out"},
 	{ "hifi1", NULL, "iDisp1 Tx"},
 	{ "iDisp1 Tx", NULL, "iDisp1_out"},
+
+	{ "Analog Out", NULL, "Codec Output Pin1" },
+	{ "Digital Out", NULL, "Codec Output Pin2" },
+	{ "Alt Analog Out", NULL, "Codec Output Pin3" },
+
+	{ "Codec Input Pin1", NULL, "Analog In" },
+	{ "Codec Input Pin2", NULL, "Digital In" },
+	{ "Codec Input Pin3", NULL, "Alt Analog In" },
+
+	/* CODEC BE connections */
+	{ "Analog Codec Playback", NULL, "Analog CPU Playback" },
+	{ "Analog CPU Playback", NULL, "codec0_out" },
+	{ "Digital Codec Playback", NULL, "Digital CPU Playback" },
+	{ "Digital CPU Playback", NULL, "codec1_out" },
+	{ "Alt Analog Codec Playback", NULL, "Alt Analog CPU Playback" },
+	{ "Alt Analog CPU Playback", NULL, "codec2_out" },
+
+	{ "codec0_in", NULL, "Analog CPU Capture" },
+	{ "Analog CPU Capture", NULL, "Analog Codec Capture" },
+	{ "codec1_in", NULL, "Digital CPU Capture" },
+	{ "Digital CPU Capture", NULL, "Digital Codec Capture" },
+	{ "codec2_in", NULL, "Alt Analog CPU Capture" },
+	{ "Alt Analog CPU Capture", NULL, "Alt Analog Codec Capture" },
 };
 
 static int skl_hda_card_late_probe(struct snd_soc_card *card)
@@ -52,6 +85,7 @@ static struct snd_soc_card hda_soc_card = {
 	.name = "skl_hda_card",
 	.owner = THIS_MODULE,
 	.dai_link = skl_hda_be_dai_links,
+	.dapm_widgets = skl_hda_widgets,
 	.dapm_routes = skl_hda_map,
 	.add_dai_link = skl_hda_add_dai_link,
 	.fully_routed = true,
@@ -75,6 +109,11 @@ static int skl_hda_fill_card_info(struct skl_machine_pdata *pdata)
 	if (codec_count == 1 && pdata->codec_mask & IDISP_CODEC_MASK) {
 		num_links = IDISP_DAI_COUNT;
 		num_route = IDISP_ROUTE_COUNT;
+	} else if (codec_count == 2 && codec_mask & IDISP_CODEC_MASK) {
+		num_links = ARRAY_SIZE(skl_hda_be_dai_links);
+		num_route = ARRAY_SIZE(skl_hda_map),
+		card->dapm_widgets = skl_hda_widgets;
+		card->num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets);
 	} else {
 		return -EINVAL;
 	}
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index be0d76b..dc2b53c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -36,6 +36,7 @@
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 #include "../../../pci/hda/hda_codec.h"
+#include "../../../soc/codecs/hdac_hda.h"
 
 static struct skl_machine_pdata skl_dmic_data;
 
@@ -624,6 +625,24 @@ static void skl_clock_device_unregister(struct skl *skl)
 		platform_device_unregister(skl->clk_dev);
 }
 
+#define IDISP_INTEL_VENDOR_ID	0x80860000
+
+/*
+ * load the legacy codec driver
+ */
+static void load_codec_module(struct hda_codec *codec)
+{
+#ifdef MODULE
+	char modalias[MODULE_NAME_LEN];
+	const char *mod = NULL;
+
+	snd_hdac_codec_modalias(&codec->core, modalias, sizeof(modalias));
+	mod = modalias;
+	dev_dbg(&codec->core.dev, "loading %s codec module\n", mod);
+	request_module(mod);
+#endif
+}
+
 /*
  * Probe the given codec address
  */
@@ -633,7 +652,9 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
 	struct skl *skl = bus_to_skl(bus);
+	struct hdac_hda_priv *hda_codec;
 	struct hdac_device *hdev;
+	int err;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
@@ -643,11 +664,24 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK: %x\n", addr, res);
 
-	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
-	if (!hdev)
+	hda_codec = devm_kzalloc(&skl->pci->dev, sizeof(*hda_codec),
+								GFP_KERNEL);
+	if (!hda_codec)
 		return -ENOMEM;
 
-	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
+	hda_codec->codec.bus = skl_to_hbus(skl);
+	hdev = &hda_codec->codec.core;
+
+	err = snd_hdac_ext_bus_device_init(bus, addr, hdev);
+	if (err < 0)
+		return err;
+
+	/* use legacy bus only for HDA codecs, idisp uses ext bus */
+	if ((res & 0xFFFF0000) != IDISP_INTEL_VENDOR_ID) {
+		hdev->type = HDA_DEV_LEGACY;
+		load_codec_module(&hda_codec->codec);
+	}
+	return 0;
 }
 
 /* Codec initialization */
@@ -782,6 +816,7 @@ static int skl_create(struct pci_dev *pci,
 		      const struct hdac_io_ops *io_ops,
 		      struct skl **rskl)
 {
+	struct hdac_ext_bus_ops *ext_ops;
 	struct skl *skl;
 	struct hdac_bus *bus;
 	struct hda_bus *hbus;
@@ -802,7 +837,11 @@ static int skl_create(struct pci_dev *pci,
 
 	hbus = skl_to_hbus(skl);
 	bus = skl_to_bus(skl);
-	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, NULL);
+
+#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
+	ext_ops = snd_soc_hdac_hda_get_ops();
+#endif
+	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
 	bus->use_posbuf = 1;
 	skl->pci = pci;
 	INIT_WORK(&skl->probe_work, skl_probe_work);
-- 
2.7.4
