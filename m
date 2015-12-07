From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v3 07/15] ASoC: hdac_hdmi: create dais based on
	number of streams
Date: Tue,  8 Dec 2015 02:54:21 +0530
Message-ID: <1449523469-4395-7-git-send-email-subhransu.s.prusty@intel.com>
References: <1449523078-4311-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 502A12651AD
 for <alsa-devel@alsa-project.org>; Mon,  7 Dec 2015 16:54:12 +0100 (CET)
In-Reply-To: <1449523469-4395-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

A stream is mapped to a converter. So based on the converters
queried, dais are created.

The streams can be dynamically routed to any converter. For
now it is mapped statically. The dynamic mapping of stream
to converter will be added when required.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 108 ++++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 32 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 27d1a54..01d063e 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -30,6 +30,8 @@
 #include <sound/pcm_drm_eld.h>
 #include "../../hda/local.h"
 
+#define NAME_SIZE	32
+
 #define AMP_OUT_MUTE		0xb080
 #define AMP_OUT_UNMUTE		0xb000
 #define PIN_OUT			(AC_PINCTL_OUT_EN)
@@ -685,11 +687,67 @@ static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
 
 }
 
+static struct snd_soc_dai_ops hdmi_dai_ops = {
+	.startup = hdac_hdmi_pcm_open,
+	.shutdown = hdac_hdmi_pcm_close,
+	.hw_params = hdac_hdmi_set_hw_params,
+	.prepare = hdac_hdmi_playback_prepare,
+	.hw_free = hdac_hdmi_playback_cleanup,
+};
+
+static int hdac_hdmi_create_dais(struct hdac_device *hdac,
+		struct snd_soc_dai_driver **dais,
+		struct hdac_hdmi_priv *hdmi, int num_dais)
+{
+	struct snd_soc_dai_driver *hdmi_dais;
+	struct hdac_hdmi_cvt *cvt;
+	char name[NAME_SIZE], dai_name[NAME_SIZE];
+	int i = 0;
+	u32 rates, bps;
+	unsigned int rate_max = 384000, rate_min = 8000;
+	u64 formats;
+	int ret;
+
+	hdmi_dais = devm_kzalloc(&hdac->dev, (sizeof(*hdmi_dais) * num_dais),
+			GFP_KERNEL);
+	if (!hdmi_dais)
+		return -ENOMEM;
+
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		ret = snd_hdac_query_supported_pcm(hdac, cvt->nid, &rates,
+			&formats, &bps);
+		if (ret)
+			return ret;
+
+		sprintf(dai_name, "intel-hdmi-hifi%d", i+1);
+		hdmi_dais[i].name = devm_kstrdup(&hdac->dev, dai_name,
+						GFP_KERNEL);
+
+		snprintf(name, sizeof(name), "hifi%d", i+1);
+		hdmi_dais[i].playback.stream_name =
+				devm_kstrdup(&hdac->dev, name, GFP_KERNEL);
+		hdmi_dais[i].playback.formats = formats;
+		hdmi_dais[i].playback.rates = rates;
+		hdmi_dais[i].playback.rate_max = rate_max;
+		hdmi_dais[i].playback.rate_min = rate_min;
+		hdmi_dais[i].playback.channels_min = 2;
+		hdmi_dais[i].playback.channels_max = 2;
+		hdmi_dais[i].ops = &hdmi_dai_ops;
+
+		i++;
+	}
+
+	*dais = hdmi_dais;
+
+	return 0;
+}
+
 /*
  * Parse all nodes and store the cvt/pin nids in array
  * Add one time initialization for pin and cvt widgets
  */
-static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
+static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
+		struct snd_soc_dai_driver **dais, int *num_dais)
 {
 	hda_nid_t nid;
 	int i, num_nodes;
@@ -740,6 +798,15 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	if (!hdmi->num_pin || !hdmi->num_cvt)
 		return -EIO;
 
+	ret = hdac_hdmi_create_dais(hdac, dais, hdmi, hdmi->num_cvt);
+	if (ret) {
+		dev_err(&hdac->dev, "Failed to create dais with err: %d\n",
+							ret);
+		return ret;
+	}
+
+	*num_dais = hdmi->num_cvt;
+
 	return hdac_hdmi_init_dai_map(edev);
 }
 
@@ -829,38 +896,12 @@ static struct snd_soc_codec_driver hdmi_hda_codec = {
 	.idle_bias_off	= true,
 };
 
-static struct snd_soc_dai_ops hdmi_dai_ops = {
-	.startup = hdac_hdmi_pcm_open,
-	.shutdown = hdac_hdmi_pcm_close,
-	.hw_params = hdac_hdmi_set_hw_params,
-	.prepare = hdac_hdmi_playback_prepare,
-	.hw_free = hdac_hdmi_playback_cleanup,
-};
-
-static struct snd_soc_dai_driver hdmi_dais[] = {
-	{	.name = "intel-hdmi-hif1",
-		.playback = {
-			.stream_name = "hif1",
-			.channels_min = 2,
-			.channels_max = 2,
-			.rates = SNDRV_PCM_RATE_32000 |
-				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-				SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 |
-				SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000,
-			.formats = SNDRV_PCM_FMTBIT_S16_LE |
-				SNDRV_PCM_FMTBIT_S20_3LE |
-				SNDRV_PCM_FMTBIT_S24_LE |
-				SNDRV_PCM_FMTBIT_S32_LE,
-
-		},
-		.ops = &hdmi_dai_ops,
-	},
-};
-
 static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 {
 	struct hdac_device *codec = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi_priv;
+	struct snd_soc_dai_driver *hdmi_dais = NULL;
+	int num_dais = 0;
 	int ret = 0;
 
 	hdmi_priv = devm_kzalloc(&codec->dev, sizeof(*hdmi_priv), GFP_KERNEL);
@@ -874,13 +915,16 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	INIT_LIST_HEAD(&hdmi_priv->pin_list);
 	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
 
-	ret = hdac_hdmi_parse_and_map_nid(edev);
-	if (ret < 0)
+	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
+	if (ret < 0) {
+		dev_err(&codec->dev,
+			"Failed in parse and map nid with err: %d\n", ret);
 		return ret;
+	}
 
 	/* ASoC specific initialization */
 	return snd_soc_register_codec(&codec->dev, &hdmi_hda_codec,
-			hdmi_dais, ARRAY_SIZE(hdmi_dais));
+			hdmi_dais, num_dais);
 }
 
 static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
-- 
1.9.1
