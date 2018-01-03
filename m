From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v5 9/9] ASoC: Intel: Boards: add support for HDA
	codecs
Date: Wed,  3 Jan 2018 10:26:22 +0530
Message-ID: <1514955382-742-10-git-send-email-rakesh.a.ughreja@intel.com>
References: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CE5A42675DE
 for <alsa-devel@alsa-project.org>; Wed,  3 Jan 2018 05:53:33 +0100 (CET)
In-Reply-To: <1514955382-742-1-git-send-email-rakesh.a.ughreja@intel.com>
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
 sound/soc/intel/Kconfig                      |  1 +
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 43 ++++++++++++++++++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 29 +++++++++++++++++++
 sound/soc/intel/skylake/skl.c                | 27 ++++++++++++++---
 5 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 7b49d04..5dc2b30 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -66,6 +66,7 @@ config SND_SOC_INTEL_SKYLAKE
 	select SND_HDA_DSP_LOADER
 	select SND_SOC_TOPOLOGY
 	select SND_SOC_INTEL_SST
+	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
 
 # ASoC codec drivers
 source "sound/soc/intel/boards/Kconfig"
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 5933902..d65c2cc 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -52,6 +52,24 @@ int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
 	return 0;
 }
 
+static int skl_hda_link_fixup(struct snd_soc_pcm_runtime *rtd,
+					struct snd_pcm_hw_params *params)
+{
+	struct snd_interval *rate = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_RATE);
+	struct snd_interval *channels = hw_param_interval(params,
+						SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+
+	/* The output is 48KHz, stereo, 16bits */
+	rate->min = rate->max = 48000;
+	channels->min = channels->max = 2;
+
+	snd_mask_none(fmt);
+	snd_mask_set(fmt, SNDRV_PCM_FORMAT_S24_LE);
+	return 0;
+}
+
 /* skl_hda_digital audio interface glue - connects codec <--> CPU */
 struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
 
@@ -86,6 +104,31 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
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
+		.be_hw_params_fixup = skl_hda_link_fixup,
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
index 203d527..920fce1 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -13,7 +13,7 @@
 #include <sound/jack.h>
 #define __SOUND_SOC_HDA_DSP_COMMON_H
 
-#define HDA_DSP_MAX_BE_DAI_LINKS 3
+#define HDA_DSP_MAX_BE_DAI_LINKS 5
 
 struct skl_hda_hdmi_pcm {
 	struct list_head head;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 07f4eed..ca82d4e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -16,8 +16,33 @@
 #include "../skylake/skl.h"
 #include "skl_hda_dsp_common.h"
 
+static const struct snd_kcontrol_new skl_hda_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Codec Speaker", NULL),
+	SND_SOC_DAPM_MIC("Codec Mic", NULL),
+};
+
 static const struct snd_soc_dapm_route skl_hda_map[] = {
 
+	/* HP jack connectors - unknown if we have jack detection */
+	{ "Headphone", NULL, "Codec Output Pin1" },
+	{ "Codec Speaker", NULL, "Codec Output Pin2" },
+	{ "Codec Input Pin2", NULL, "Codec Mic" },
+	{ "Codec Input Pin1", NULL, "Headset Mic" },
+
+	/* CODEC BE connections */
+	{ "Analog Codec Playback", NULL, "Analog CPU Playback" },
+	{ "Analog CPU Playback", NULL, "codec0_out" },
+
+	{ "codec0_in", NULL, "Analog CPU Capture" },
+	{ "Analog CPU Capture", NULL, "Analog Codec Capture" },
+
 	{ "hifi3", NULL, "iDisp3 Tx"},
 	{ "iDisp3 Tx", NULL, "iDisp3_out"},
 	{ "hifi2", NULL, "iDisp2 Tx"},
@@ -54,6 +79,10 @@ static struct snd_soc_card hda_soc_card = {
 	.owner = THIS_MODULE,
 	.dai_link = skl_hda_be_dai_links,
 	.num_links = ARRAY_SIZE(skl_hda_be_dai_links),
+	.controls = skl_hda_controls,
+	.num_controls = ARRAY_SIZE(skl_hda_controls),
+	.dapm_widgets = skl_hda_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets),
 	.dapm_routes = skl_hda_map,
 	.num_dapm_routes = ARRAY_SIZE(skl_hda_map),
 	.add_dai_link = skl_hda_add_dai_link,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 712865f..fc7bcab5 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -36,6 +36,7 @@
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 #include "../../../pci/hda/hda_codec.h"
+#include "../../../soc/codecs/hdac_hda.h"
 
 static struct skl_machine_pdata skl_dmic_data;
 
@@ -630,7 +631,9 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
 	struct skl *skl = bus_to_skl(bus);
+	struct hdac_hda_priv *hda_codec;
 	struct hdac_device *hdev;
+	int err;
 
 	mutex_lock(&bus->cmd_mutex);
 	snd_hdac_bus_send_cmd(bus, cmd);
@@ -640,11 +643,22 @@ static int probe_codec(struct hdac_bus *bus, int addr)
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
+	if ((res & 0xFFFF0000) != 0x80860000)
+		hdev->type = HDA_DEV_LEGACY;
+
+	return 0;
 }
 
 /* Codec initialization */
@@ -782,6 +796,7 @@ static int skl_create(struct pci_dev *pci,
 	struct skl *skl;
 	struct hdac_bus *bus;
 	struct hda_bus *hbus;
+	struct hdac_ext_bus_ops *ext_ops = NULL;
 
 	int err;
 
@@ -799,7 +814,11 @@ static int skl_create(struct pci_dev *pci,
 
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
