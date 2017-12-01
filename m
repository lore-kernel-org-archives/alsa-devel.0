From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC 10/10] ASoC: Intel: Boards: add support for HDA
	codecs
Date: Fri,  1 Dec 2017 14:44:08 +0530
Message-ID: <1512119648-2700-11-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C8D2267C0B
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:10:22 +0100 (CET)
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

Add support for HDA codecs. add required widgets, controls, routes
and dai links for the same.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/soc/intel/boards/Kconfig           |   1 +
 sound/soc/intel/boards/skl_hda_generic.c | 112 ++++++++++++++++++++++++++++++-
 2 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 4f8bd02..e2a280d 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -267,6 +267,7 @@ config SND_SOC_INTEL_SKL_HDA_GENERIC_MACH
         select SND_SOC_INTEL_SST
         depends on SND_SOC_INTEL_SKYLAKE
         select SND_SOC_HDAC_HDMI
+        select SND_SOC_HDAC_HDA
         help
           This adds support for ASoC Onboard Codec HDA machine driver. This will
           create an alsa sound card for HDA Codecs.
diff --git a/sound/soc/intel/boards/skl_hda_generic.c b/sound/soc/intel/boards/skl_hda_generic.c
index ece39b5..0e592d4 100644
--- a/sound/soc/intel/boards/skl_hda_generic.c
+++ b/sound/soc/intel/boards/skl_hda_generic.c
@@ -38,13 +38,43 @@ struct skl_hda_private {
 };
 
 enum {
-	SKL_HDA_DPCM_AUDIO_HDMI1_PB = 0,
+	SKL_HDA_DPCM_AUDIO_PB = 0,
+	SKL_HDA_DPCM_AUDIO_CP,
+	SKL_HDA_DPCM_AUDIO_HDMI1_PB,
 	SKL_HDA_DPCM_AUDIO_HDMI2_PB,
 	SKL_HDA_DPCM_AUDIO_HDMI3_PB,
 };
 
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
+	{ "Digital Codec Playback", NULL, "Digital CPU Playback" },
+	{ "Digital CPU Playback", NULL, "codec1_out" },
+
+	{ "codec0_in", NULL, "Analog CPU Capture" },
+	{ "Analog CPU Capture", NULL, "Analog Codec Capture" },
+
 	{ "hifi3", NULL, "iDisp3 Tx"},
 	{ "iDisp3 Tx", NULL, "iDisp3_out"},
 	{ "hifi2", NULL, "iDisp2 Tx"},
@@ -108,9 +138,60 @@ static int skl_hda_hdmi3_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static int skl_hda_link_init(struct snd_soc_pcm_runtime *rtd)
+{
+	dev_dbg(rtd->dev, "%s entry\n", __func__);
+	return 0;
+}
+
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
 static struct snd_soc_dai_link skl_hda_dais[] = {
 	/* Front End DAI links */
+	[SKL_HDA_DPCM_AUDIO_PB] = {
+		.name = "Skylake Audio Playback Port",
+		.stream_name = "Audio Playback",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.init = NULL,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_playback = 1,
+	},
+	[SKL_HDA_DPCM_AUDIO_CP] = {
+		.name = "Skylake Audio Capture Port",
+		.stream_name = "Audio Record",
+		.cpu_dai_name = "System Pin",
+		.platform_name = "0000:00:1f.3",
+		.dynamic = 1,
+		.codec_name = "snd-soc-dummy",
+		.codec_dai_name = "snd-soc-dummy-dai",
+		.nonatomic = 1,
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.dpcm_capture = 1,
+	},
 	[SKL_HDA_DPCM_AUDIO_HDMI1_PB] = {
 		.name = "SKL HDA HDMI Port1",
 		.stream_name = "Hdmi1",
@@ -188,6 +269,31 @@ static struct snd_soc_dai_link skl_hda_dais[] = {
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
+		.init = skl_hda_link_init,
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
+		.init = skl_hda_link_init,
+		.no_pcm = 1,
+	},
 };
 
 #define NAME_SIZE	32
@@ -229,6 +335,10 @@ static struct snd_soc_card skl_hda_audio_card = {
 	.owner = THIS_MODULE,
 	.dai_link = skl_hda_dais,
 	.num_links = ARRAY_SIZE(skl_hda_dais),
+	.controls = skl_hda_controls,
+	.num_controls = ARRAY_SIZE(skl_hda_controls),
+	.dapm_widgets = skl_hda_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(skl_hda_widgets),
 	.dapm_routes = skl_hda_map,
 	.num_dapm_routes = ARRAY_SIZE(skl_hda_map),
 	.fully_routed = true,
-- 
2.7.4
