From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH v2 3/9] ASoC: hdac_hdmi: Add multichannel
	support
Date: Tue, 12 Apr 2016 15:26:11 +0530
Message-ID: <1460454977-30057-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1460454977-30057-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F44C26520A
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 11:57:19 +0200 (CEST)
In-Reply-To: <1460454977-30057-1-git-send-email-subhransu.s.prusty@intel.com>
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

To support multichannel hdac hdmi driver registers with HDA
channel map framework. Channel count and channel slot verbs are
programmed by using the chmap helpers/ops.  The channel
allocation is then programmed in the audio infoframe as per CEA
spec.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 52 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 81ac173..63ef7dd 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -29,6 +29,7 @@
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_i915.h>
 #include <sound/pcm_drm_eld.h>
+#include <sound/hda_chmap.h>
 #include "../../hda/local.h"
 #include "hdac_hdmi.h"
 
@@ -82,6 +83,10 @@ struct hdac_hdmi_pin {
 	struct hdac_ext_device *edev;
 	int repoll_count;
 	struct delayed_work work;
+	struct mutex lock;
+	bool chmap_set;
+	unsigned char chmap[8]; /* ALSA API channel-map */
+	int channels; /* current number of channels */
 };
 
 struct hdac_hdmi_pcm {
@@ -106,6 +111,7 @@ struct hdac_hdmi_priv {
 	int num_pin;
 	int num_cvt;
 	struct mutex pin_mutex;
+	struct hdac_chmap chmap;
 };
 
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
@@ -284,26 +290,31 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 	int i;
 	const u8 *eld_buf;
 	u8 conn_type;
-	int channels = 2;
+	int channels, ca;
 
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
 		if (pin->nid == pin_nid)
 			break;
 	}
 
+	ca = snd_hdac_channel_allocation(&hdac->hdac, pin->eld.info.spk_alloc,
+			pin->channels, pin->chmap_set, true, pin->chmap);
+
+	channels = snd_hdac_get_active_channels(ca);
+	hdmi->chmap.ops.set_channel_count(&hdac->hdac, cvt_nid, channels);
+
+	snd_hdac_setup_channel_mapping(&hdmi->chmap, pin->nid, false, ca,
+				pin->channels, pin->chmap, pin->chmap_set);
+
 	eld_buf = pin->eld.eld_buffer;
 	conn_type = drm_eld_get_conn_type(eld_buf);
 
-	/* setup channel count */
-	snd_hdac_codec_write(&hdac->hdac, cvt_nid, 0,
-			    AC_VERB_SET_CVT_CHAN_COUNT, channels - 1);
-
 	switch (conn_type) {
 	case DRM_ELD_CONN_TYPE_HDMI:
 		hdmi_audio_infoframe_init(&frame);
 
-		/* Default stereo for now */
 		frame.channels = channels;
+		frame.channel_allocation = ca;
 
 		ret = hdmi_audio_infoframe_pack(&frame, buffer, sizeof(buffer));
 		if (ret < 0)
@@ -317,7 +328,7 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 		dp_ai.len	= 0x1b;
 		dp_ai.ver	= 0x11 << 2;
 		dp_ai.CC02_CT47	= channels - 1;
-		dp_ai.CA	= 0;
+		dp_ai.CA	= ca;
 
 		dip = (u8 *)&dp_ai;
 		break;
@@ -376,17 +387,23 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_pin *pin;
 	struct hdac_ext_dma_params *dd;
 	int ret;
 
 	dai_map = &hdmi->dai_map[dai->id];
+	pin = dai_map->pin;
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
+	mutex_lock(&pin->lock);
+	pin->channels = substream->runtime->channels;
+
 	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt->nid,
 						dai_map->pin->nid);
+	mutex_unlock(&pin->lock);
 	if (ret < 0)
 		return ret;
 
@@ -646,6 +663,10 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 		snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
+		mutex_lock(&dai_map->pin->lock);
+		dai_map->pin->channels = 0;
+		mutex_unlock(&dai_map->pin->lock);
+
 		dai_map->pin = NULL;
 	}
 }
@@ -653,10 +674,21 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 static int
 hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 {
+	unsigned int chans;
+	struct hdac_ext_device *edev = to_ehdac_device(hdac);
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	int err;
 
-	/* Only stereo supported as of now */
-	cvt->params.channels_min = cvt->params.channels_max = 2;
+	chans = get_wcaps(hdac, cvt->nid);
+	chans = get_wcaps_channels(chans);
+
+	cvt->params.channels_min = 2;
+
+	if (chans <= 16) {
+		cvt->params.channels_max = chans;
+		if (chans > hdmi->chmap.channels_max)
+			hdmi->chmap.channels_max = chans;
+	}
 
 	err = snd_hdac_query_supported_pcm(hdac, cvt->nid,
 			&cvt->params.rates,
@@ -1136,6 +1168,7 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 	hdmi->num_pin++;
 
 	pin->edev = edev;
+	mutex_init(&pin->lock);
 	INIT_DELAYED_WORK(&pin->work, hdac_hdmi_repoll_eld);
 
 	return 0;
@@ -1501,6 +1534,7 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 		return -ENOMEM;
 
 	edev->private_data = hdmi_priv;
+	snd_hdac_register_chmap_ops(codec, &hdmi_priv->chmap);
 
 	dev_set_drvdata(&codec->dev, edev);
 
-- 
1.9.1
