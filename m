From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 11/11] ASoC: Intel: Boards: add support for
	HDA codecs
Date: Fri, 15 Dec 2017 17:00:48 +0530
Message-ID: <1513337448-31685-12-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 86803267BD7
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:26:43 +0100 (CET)
In-Reply-To: <1513337448-31685-1-git-send-email-rakesh.a.ughreja@intel.com>
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
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 43 ++++++++++++++++++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_common.h  |  2 +-
 sound/soc/intel/boards/skl_hda_dsp_generic.c | 29 +++++++++++++++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index e01137d..4108205 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -267,6 +267,7 @@ config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
         select SND_SOC_INTEL_SST
         depends on SND_SOC_INTEL_SKYLAKE
         select SND_SOC_HDAC_HDMI
+        depends on SND_HDA_CODEC_REALTEK
         help
           This adds support for ASoC Onboard Codec HDA machine driver. This will
           create an alsa sound card for HDA Codecs.
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 5558334..c575d8e 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -62,6 +62,24 @@ int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
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
 
@@ -96,6 +114,31 @@ struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS] = {
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
index c9cb66b..463938a 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -21,7 +21,7 @@
 #include <sound/jack.h>
 #define __SOUND_SOC_HDA_DSP_COMMON_H
 
-#define HDA_DSP_MAX_BE_DAI_LINKS 3
+#define HDA_DSP_MAX_BE_DAI_LINKS 5
 
 struct skl_hda_hdmi_pcm {
 	struct list_head head;
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 2d2b901..e0d7e12 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -25,8 +25,33 @@
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
@@ -63,6 +88,10 @@ static struct snd_soc_card hda_soc_card = {
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
-- 
2.7.4
