From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 2/7] ASoC: Intel: skl-hda-dsp-generic: use
	snd-hda-codec-hdmi
Date: Thu, 29 Aug 2019 16:53:43 +0300
Message-ID: <20190829135348.23569-3-kai.vehmanen@linux.intel.com>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D754F89884
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:13 +0200 (CEST)
In-Reply-To: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Switch to use the snd-hda-codec-hdmi driver for HDMI/DP instead
of ASoC hdac-hdmi. This is aligned with how other HDA codecs
are handled.

PCM device numbers are parsed from card topology and passed
to snd-hda-codec-hdmi. This needs to be done at runtime as
topology changes may affect PCM device allocation.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/skl_hda_dsp_common.c  | 27 +++------
 sound/soc/intel/boards/skl_hda_dsp_common.h  | 61 ++++++++++++++++++++
 sound/soc/intel/boards/skl_hda_dsp_generic.c |  7 ---
 3 files changed, 68 insertions(+), 27 deletions(-)

diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.c b/sound/soc/intel/boards/skl_hda_dsp_common.c
index 55fd82e05e2c..3db9aee8aa83 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.c
@@ -14,6 +14,9 @@
 #include "../../codecs/hdac_hdmi.h"
 #include "skl_hda_dsp_common.h"
 
+#include <sound/hda_codec.h>
+#include "../../codecs/hdac_hda.h"
+
 #define NAME_SIZE	32
 
 int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device)
@@ -133,28 +136,12 @@ int skl_hda_hdmi_jack_init(struct snd_soc_card *card)
 	struct skl_hda_private *ctx = snd_soc_card_get_drvdata(card);
 	struct snd_soc_component *component = NULL;
 	struct skl_hda_hdmi_pcm *pcm;
-	char jack_name[NAME_SIZE];
-	int err;
-
-	list_for_each_entry(pcm, &ctx->hdmi_pcm_list, head) {
-		component = pcm->codec_dai->component;
-		snprintf(jack_name, sizeof(jack_name),
-			 "HDMI/DP, pcm=%d Jack", pcm->device);
-		err = snd_soc_card_jack_new(card, jack_name,
-					    SND_JACK_AVOUT, &pcm->hdmi_jack,
-					    NULL, 0);
-
-		if (err)
-			return err;
-
-		err = hdac_hdmi_jack_init(pcm->codec_dai, pcm->device,
-					  &pcm->hdmi_jack);
-		if (err < 0)
-			return err;
-	}
 
+	pcm = list_first_entry(&ctx->hdmi_pcm_list, struct skl_hda_hdmi_pcm,
+			       head);
+	component = pcm->codec_dai->component;
 	if (!component)
 		return -EINVAL;
 
-	return hdac_hdmi_jack_port_init(component, &card->dapm);
+	return skl_hda_hdmi_build_controls(card, component);
 }
diff --git a/sound/soc/intel/boards/skl_hda_dsp_common.h b/sound/soc/intel/boards/skl_hda_dsp_common.h
index daa582e513b2..6154688b09e8 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_common.h
+++ b/sound/soc/intel/boards/skl_hda_dsp_common.h
@@ -14,6 +14,8 @@
 #include <linux/platform_device.h>
 #include <sound/core.h>
 #include <sound/jack.h>
+#include <sound/hda_codec.h>
+#include "../../codecs/hdac_hda.h"
 
 #define HDA_DSP_MAX_BE_DAI_LINKS 7
 
@@ -35,4 +37,63 @@ extern struct snd_soc_dai_link skl_hda_be_dai_links[HDA_DSP_MAX_BE_DAI_LINKS];
 int skl_hda_hdmi_jack_init(struct snd_soc_card *card);
 int skl_hda_hdmi_add_pcm(struct snd_soc_card *card, int device);
 
+/*
+ * Search card topology and return PCM device number
+ * matching Nth HDMI device (zero-based index).
+ */
+static inline struct snd_pcm *skl_hda_hdmi_pcm_handle(struct snd_soc_card *card,
+						      int hdmi_idx)
+{
+	struct snd_soc_pcm_runtime *rtd;
+	int i = 0;
+	struct snd_pcm *spcm;
+
+	for_each_card_rtds(card, rtd) {
+		spcm = rtd->pcm ?
+			rtd->pcm->streams[SNDRV_PCM_STREAM_PLAYBACK].pcm : 0;
+		if (spcm && strstr(spcm->id, "HDMI")) {
+			if (i == hdmi_idx)
+				return rtd->pcm;
+			++i;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Search card topology and register HDMI PCM related controls
+ * to codec driver.
+ */
+static int skl_hda_hdmi_build_controls(struct snd_soc_card *card,
+				       struct snd_soc_component *component)
+{
+	struct hdac_hda_priv *hda_pvt;
+	struct hda_codec *hcodec;
+	struct snd_pcm *spcm;
+	struct hda_pcm *hpcm;
+	int err = 0, i = 0;
+
+	hda_pvt = snd_soc_component_get_drvdata(component);
+	hcodec = &hda_pvt->codec;
+
+	list_for_each_entry(hpcm, &hcodec->pcm_list_head, list) {
+		spcm = skl_hda_hdmi_pcm_handle(card, i);
+		if (spcm) {
+			hpcm->pcm = spcm;
+			hpcm->device = spcm->device;
+			dev_dbg(card->dev,
+				"%s: mapping HDMI converter %d to PCM %d (%p)\n",
+				__func__, i, hpcm->device, spcm);
+		}
+		i++;
+	}
+
+	err = snd_hda_codec_build_controls(hcodec);
+	if (err < 0)
+		dev_err(card->dev, "unable to create controls %d\n", err);
+
+	return err;
+}
+
 #endif /* __SOUND_SOC_HDA_DSP_COMMON_H */
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 9ed68eb4f058..9b6f8cc87f99 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -26,13 +26,6 @@ static const struct snd_soc_dapm_widget skl_hda_widgets[] = {
 };
 
 static const struct snd_soc_dapm_route skl_hda_map[] = {
-	{ "hifi3", NULL, "iDisp3 Tx"},
-	{ "iDisp3 Tx", NULL, "iDisp3_out"},
-	{ "hifi2", NULL, "iDisp2 Tx"},
-	{ "iDisp2 Tx", NULL, "iDisp2_out"},
-	{ "hifi1", NULL, "iDisp1 Tx"},
-	{ "iDisp1 Tx", NULL, "iDisp1_out"},
-
 	{ "Analog Out", NULL, "Codec Output Pin1" },
 	{ "Digital Out", NULL, "Codec Output Pin2" },
 	{ "Alt Analog Out", NULL, "Codec Output Pin3" },
-- 
2.17.1
