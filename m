From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 03/15] ASoC: hdac_hdmi - Use list to add pins
	and converters
Date: Tue,  1 Dec 2015 23:16:59 +0530
Message-ID: <1448992031-8271-3-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AF7E261AE4
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:30 +0100 (CET)
In-Reply-To: <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
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

Future platforms may have a different set of pins/converters.
So use lists to add pins and converters based on enumeration.

Also it may be required to connect any converter to any pin
dynamically as per different use cases (for example DP is
connected to pin 6 on skylake board). So this will help in
dynamically select and route.

Fix the dai map as well to use the pin/cvt from list. Not
enabling all dai maps for now.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 140 ++++++++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 48 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 3b2fb87..0869855 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -43,11 +43,13 @@ struct hdac_hdmi_cvt_params {
 };
 
 struct hdac_hdmi_cvt {
+	struct list_head head;
 	hda_nid_t nid;
 	struct hdac_hdmi_cvt_params params;
 };
 
 struct hdac_hdmi_pin {
+	struct list_head head;
 	hda_nid_t nid;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
@@ -55,14 +57,16 @@ struct hdac_hdmi_pin {
 
 struct hdac_hdmi_dai_pin_map {
 	int dai_id;
-	struct hdac_hdmi_pin pin;
-	struct hdac_hdmi_cvt cvt;
+	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_cvt *cvt;
 };
 
 struct hdac_hdmi_priv {
-	hda_nid_t pin_nid[3];
-	hda_nid_t cvt_nid[3];
 	struct hdac_hdmi_dai_pin_map dai_map[3];
+	struct list_head pin_list;
+	struct list_head cvt_list;
+	int num_pin;
+	int num_cvt;
 };
 
 static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
@@ -149,13 +153,15 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 		struct hdac_hdmi_dai_pin_map *dai_map, unsigned int pwr_state)
 {
 	/* Power up pin widget */
-	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->pin.nid, pwr_state))
-		snd_hdac_codec_write(&edev->hdac, dai_map->pin.nid, 0,
+	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->pin->nid,
+						pwr_state))
+		snd_hdac_codec_write(&edev->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_POWER_STATE, pwr_state);
 
 	/* Power up converter */
-	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->cvt.nid, pwr_state))
-		snd_hdac_codec_write(&edev->hdac, dai_map->cvt.nid, 0,
+	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->cvt->nid,
+						pwr_state))
+		snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
 			AC_VERB_SET_POWER_STATE, pwr_state);
 }
 
@@ -179,13 +185,13 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
-	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt.nid,
-						dai_map->pin.nid);
+	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt->nid,
+						dai_map->pin->nid);
 	if (ret < 0)
 		return ret;
 
-	return hdac_hdmi_setup_stream(hdac, dai_map->cvt.nid, dai_map->pin.nid,
-					dd->stream_tag, dd->format);
+	return hdac_hdmi_setup_stream(hdac, dai_map->cvt->nid,
+			dai_map->pin->nid, dd->stream_tag, dd->format);
 }
 
 static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
@@ -221,9 +227,9 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	snd_hdac_codec_write(&edev->hdac, dai_map->cvt.nid, 0,
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_CHANNEL_STREAMID, 0);
-	snd_hdac_codec_write(&edev->hdac, dai_map->cvt.nid, 0,
+	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_STREAM_FORMAT, 0);
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
@@ -249,7 +255,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	val = snd_hdac_codec_read(&hdac->hdac, dai_map->pin.nid, 0,
+	val = snd_hdac_codec_read(&hdac->hdac, dai_map->pin->nid, 0,
 					AC_VERB_GET_PIN_SENSE, 0);
 	dev_info(&hdac->hdac.dev, "Val for AC_VERB_GET_PIN_SENSE: %x\n", val);
 
@@ -260,7 +266,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D0);
 
-	snd_hdac_codec_write(&hdac->hdac, dai_map->pin.nid, 0,
+	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
 	snd_pcm_hw_constraint_step(substream->runtime, 0,
@@ -280,7 +286,7 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 
 	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
 
-	snd_hdac_codec_write(&hdac->hdac, dai_map->pin.nid, 0,
+	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 }
 
@@ -368,40 +374,79 @@ static void create_fill_widget_route_map(struct snd_soc_dapm_context *dapm,
 	snd_soc_dapm_add_routes(dapm, route, ARRAY_SIZE(route));
 }
 
-static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev,
-			struct hdac_hdmi_dai_pin_map *dai_map,
-			hda_nid_t pin_nid, hda_nid_t cvt_nid, int dai_id)
+static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 {
-	int ret;
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_dai_pin_map *dai_map = &hdmi->dai_map[0];
+	struct hdac_hdmi_cvt *cvt;
+	struct hdac_hdmi_pin *pin;
 
-	dai_map->dai_id = dai_id;
-	dai_map->pin.nid = pin_nid;
+	if (list_empty(&hdmi->cvt_list) || list_empty(&hdmi->pin_list))
+		return -EINVAL;
 
-	ret = hdac_hdmi_query_pin_connlist(edev, &dai_map->pin);
-	if (ret < 0) {
-		dev_err(&edev->hdac.dev,
-			"Error querying connection list: %d\n", ret);
-		return ret;
-	}
+	/*
+	 * Currently on board only 1 pin and 1 converter is enabled for
+	 * simplification, more will be added eventually
+	 * So using fixed map for dai_id:pin:cvt
+	 */
+	cvt = list_first_entry(&hdmi->cvt_list, struct hdac_hdmi_cvt, head);
+	pin = list_first_entry(&hdmi->pin_list, struct hdac_hdmi_pin, head);
 
-	dai_map->cvt.nid = cvt_nid;
+	dai_map->dai_id = 0;
+	dai_map->pin = pin;
+
+	dai_map->cvt = cvt;
 
 	/* Enable out path for this pin widget */
-	snd_hdac_codec_write(&edev->hdac, pin_nid, 0,
+	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
 	/* Enable transmission */
-	snd_hdac_codec_write(&edev->hdac, cvt_nid, 0,
+	snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
 			AC_VERB_SET_DIGI_CONVERT_1, 1);
 
 	/* Category Code (CC) to zero */
-	snd_hdac_codec_write(&edev->hdac, cvt_nid, 0,
+	snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
 			AC_VERB_SET_DIGI_CONVERT_2, 0);
 
-	snd_hdac_codec_write(&edev->hdac, pin_nid, 0,
+	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,
 			AC_VERB_SET_CONNECT_SEL, 0);
 
-	return hdac_hdmi_query_cvt_params(&edev->hdac, &dai_map->cvt);
+	return 0;
+}
+
+static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
+{
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_cvt *cvt;
+
+	cvt = devm_kzalloc(&edev->hdac.dev, sizeof(*cvt), GFP_KERNEL);
+	if (!cvt)
+		return -ENOMEM;
+
+	cvt->nid = nid;
+
+	list_add_tail(&cvt->head, &hdmi->cvt_list);
+	hdmi->num_cvt++;
+
+	return hdac_hdmi_query_cvt_params(&edev->hdac, cvt);
+}
+
+static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
+{
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin;
+
+	pin = devm_kzalloc(&edev->hdac.dev, sizeof(*pin), GFP_KERNEL);
+	if (!pin)
+		return -ENOMEM;
+
+	pin->nid = nid;
+
+	list_add_tail(&pin->head, &hdmi->pin_list);
+	hdmi->num_pin++;
+
+	return 0;
 }
 
 /*
@@ -414,7 +459,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	int i;
 	struct hdac_device *hdac = &edev->hdac;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	int cvt_nid = 0, pin_nid = 0;
+	int ret;
 
 	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
 	if (!nid || hdac->num_nodes <= 0) {
@@ -437,29 +482,25 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 		switch (type) {
 
 		case AC_WID_AUD_OUT:
-			hdmi->cvt_nid[cvt_nid] = nid;
-			cvt_nid++;
+			ret = hdac_hdmi_add_cvt(edev, nid);
+			if (ret < 0)
+				return ret;
 			break;
 
 		case AC_WID_PIN:
-			hdmi->pin_nid[pin_nid] = nid;
-			pin_nid++;
+			ret = hdac_hdmi_add_pin(edev, nid);
+			if (ret < 0)
+				return ret;
 			break;
 		}
 	}
 
 	hdac->end_nid = nid;
 
-	if (!pin_nid || !cvt_nid)
+	if (!hdmi->num_pin || !hdmi->num_cvt)
 		return -EIO;
 
-	/*
-	 * Currently on board only 1 pin and 1 converter is enabled for
-	 * simplification, more will be added eventually
-	 * So using fixed map for dai_id:pin:cvt
-	 */
-	return hdac_hdmi_init_dai_map(edev, &hdmi->dai_map[0], hdmi->pin_nid[0],
-			hdmi->cvt_nid[0], 0);
+	return hdac_hdmi_init_dai_map(edev);
 }
 
 static int hdmi_codec_probe(struct snd_soc_codec *codec)
@@ -543,6 +584,9 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 
 	dev_set_drvdata(&codec->dev, edev);
 
+	INIT_LIST_HEAD(&hdmi_priv->pin_list);
+	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
+
 	ret = hdac_hdmi_parse_and_map_nid(edev);
 	if (ret < 0)
 		return ret;
-- 
1.9.1
