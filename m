From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [RFC PATCH 3/7] ASoC: hdac_hda: add support for
	HDMI/DP as a HDA codec
Date: Thu, 29 Aug 2019 16:53:44 +0300
Message-ID: <20190829135348.23569-4-kai.vehmanen@linux.intel.com>
References: <20190829135348.23569-1-kai.vehmanen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13850F89889
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2019 15:54:16 +0200 (CEST)
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

Handle all HDA codecs using same logic, including HDMI/DP.

Call to snd_hda_codec_build_controls() is delayed for HDMI/DP HDA
devices. This is needed to discover the PCM device numbers as
defined in topology.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/codecs/hdac_hda.c | 95 ++++++++++++++++++++++++++++++++-----
 sound/soc/codecs/hdac_hda.h | 10 +++-
 2 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 7d4940256914..1c950e089e39 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -16,11 +16,8 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_codec.h>
 #include <sound/hda_register.h>
-#include "hdac_hda.h"
 
-#define HDAC_ANALOG_DAI_ID		0
-#define HDAC_DIGITAL_DAI_ID		1
-#define HDAC_ALT_ANALOG_DAI_ID		2
+#include "hdac_hda.h"
 
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
 			SNDRV_PCM_FMTBIT_U8 | \
@@ -121,7 +118,46 @@ static struct snd_soc_dai_driver hdac_hda_dais[] = {
 		.formats = STUB_FORMATS,
 		.sig_bits = 24,
 	},
-}
+},
+{
+	.id = HDAC_HDMI_0_DAI_ID,
+	.name = "intel-hdmi-hifi1",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name    = "HDMI 1 Playback",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates          = SNDRV_PCM_RATE_8000_192000,
+		.formats        = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+},
+{
+	.id = HDAC_HDMI_1_DAI_ID,
+	.name = "intel-hdmi-hifi2",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name    = "HDMI 2 Playback",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates          = SNDRV_PCM_RATE_8000_192000,
+		.formats        = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+},
+{
+	.id = HDAC_HDMI_2_DAI_ID,
+	.name = "intel-hdmi-hifi3",
+	.ops = &hdac_hda_dai_ops,
+	.playback = {
+		.stream_name    = "HDMI 3 Playback",
+		.channels_min   = 1,
+		.channels_max   = 16,
+		.rates          = SNDRV_PCM_RATE_8000_192000,
+		.formats        = STUB_FORMATS,
+		.sig_bits = 24,
+	},
+},
 
 };
 
@@ -135,10 +171,11 @@ static int hdac_hda_dai_set_tdm_slot(struct snd_soc_dai *dai,
 
 	hda_pvt = snd_soc_component_get_drvdata(component);
 	pcm = &hda_pvt->pcm[dai->id];
+
 	if (tx_mask)
-		pcm[dai->id].stream_tag[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
+		pcm->stream_tag[SNDRV_PCM_STREAM_PLAYBACK] = tx_mask;
 	else
-		pcm[dai->id].stream_tag[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
+		pcm->stream_tag[SNDRV_PCM_STREAM_CAPTURE] = rx_mask;
 
 	return 0;
 }
@@ -278,6 +315,12 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 	struct hda_pcm *cpcm;
 	const char *pcm_name;
 
+	/*
+	 * map DAI ID to the closest matching PCM name, using the naming
+	 * scheme used by hda-codec snd_hda_gen_build_pcms() and for
+	 * HDMI in hda_codec patch_hdmi.c)
+	 */
+
 	switch (dai->id) {
 	case HDAC_ANALOG_DAI_ID:
 		pcm_name = "Analog";
@@ -288,13 +331,22 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 	case HDAC_ALT_ANALOG_DAI_ID:
 		pcm_name = "Alt Analog";
 		break;
+	case HDAC_HDMI_0_DAI_ID:
+		pcm_name = "HDMI 0";
+		break;
+	case HDAC_HDMI_1_DAI_ID:
+		pcm_name = "HDMI 1";
+		break;
+	case HDAC_HDMI_2_DAI_ID:
+		pcm_name = "HDMI 2";
+		break;
 	default:
 		dev_err(&hcodec->core.dev, "invalid dai id %d\n", dai->id);
 		return NULL;
 	}
 
 	list_for_each_entry(cpcm, &hcodec->pcm_list_head, list) {
-		if (strpbrk(cpcm->name, pcm_name))
+		if (strstr(cpcm->name, pcm_name))
 			return cpcm;
 	}
 
@@ -302,6 +354,18 @@ static struct hda_pcm *snd_soc_find_pcm_from_dai(struct hdac_hda_priv *hda_pvt,
 	return NULL;
 }
 
+static bool is_hdmi_codec(struct hda_codec *hcodec)
+{
+	struct hda_pcm *cpcm;
+
+	list_for_each_entry(cpcm, &hcodec->pcm_list_head, list) {
+		if (cpcm->pcm_type == HDA_PCM_TYPE_HDMI)
+			return true;
+	}
+
+	return false;
+}
+
 static int hdac_hda_codec_probe(struct snd_soc_component *component)
 {
 	struct hdac_hda_priv *hda_pvt =
@@ -366,16 +430,23 @@ static int hdac_hda_codec_probe(struct snd_soc_component *component)
 		dev_dbg(&hdev->dev, "no patch file found\n");
 	}
 
+	/* configure codec for 1:1 PCM:DAI mapping */
+	hcodec->mst_no_extra_pcms = 1;
+
 	ret = snd_hda_codec_parse_pcms(hcodec);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to map pcms to dai %d\n", ret);
 		goto error;
 	}
 
-	ret = snd_hda_codec_build_controls(hcodec);
-	if (ret < 0) {
-		dev_err(&hdev->dev, "unable to create controls %d\n", ret);
-		goto error;
+	/* HDMI controls need to be created in machine drivers */
+	if (!is_hdmi_codec(hcodec)) {
+		ret = snd_hda_codec_build_controls(hcodec);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "unable to create controls %d\n",
+				ret);
+			goto error;
+		}
 	}
 
 	hcodec->core.lazy_cache = true;
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
index 6b1bd4f428e7..1a4af0b1f38f 100644
--- a/sound/soc/codecs/hdac_hda.h
+++ b/sound/soc/codecs/hdac_hda.h
@@ -6,6 +6,14 @@
 #ifndef __HDAC_HDA_H__
 #define __HDAC_HDA_H__
 
+#define HDAC_ANALOG_DAI_ID		0
+#define HDAC_DIGITAL_DAI_ID		1
+#define HDAC_ALT_ANALOG_DAI_ID		2
+#define HDAC_HDMI_0_DAI_ID		3
+#define HDAC_HDMI_1_DAI_ID		4
+#define HDAC_HDMI_2_DAI_ID		5
+#define HDAC_LAST_DAI_ID		6
+
 struct hdac_hda_pcm {
 	int stream_tag[2];
 	unsigned int format_val[2];
@@ -13,7 +21,7 @@ struct hdac_hda_pcm {
 
 struct hdac_hda_priv {
 	struct hda_codec codec;
-	struct hdac_hda_pcm pcm[2];
+	struct hdac_hda_pcm pcm[HDAC_LAST_DAI_ID];
 };
 
 #define hdac_to_hda_priv(_hdac) \
-- 
2.17.1
