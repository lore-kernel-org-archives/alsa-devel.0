From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 11/15] ASoC: hdac_hdmi: Assign pin for stream
	based on dapm connection
Date: Tue,  1 Dec 2015 23:17:07 +0530
Message-ID: <1448992031-8271-11-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E3FD265D25
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:51 +0100 (CET)
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

Now that we have all the widgets enumerated we can route the stream
to any pin widget based on Mux connection. So map the pin to stream
accordingly.

Also seems the connection list to the pin widgets are not static
and is updated runtime based on type of display attached to the port.
This looks to be a hardware behavior.

So querying of the connection list is removed from pin initialization
and used in selecting the pin for a dai map.

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 208 +++++++++++++++++++++++++++++++------------
 1 file changed, 151 insertions(+), 57 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 888d02e..4cb4262 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -37,6 +37,8 @@
 
 #define HDA_MAX_CONNECTIONS     32
 
+#define HDA_MAX_CVTS		3
+
 #define ELD_MAX_SIZE    256
 #define ELD_FIXED_BYTES	20
 
@@ -79,7 +81,7 @@ struct hdac_hdmi_dai_pin_map {
 };
 
 struct hdac_hdmi_priv {
-	struct hdac_hdmi_dai_pin_map dai_map[3];
+	struct hdac_hdmi_dai_pin_map dai_map[HDA_MAX_CVTS];
 	struct list_head pin_list;
 	struct list_head cvt_list;
 	int num_pin;
@@ -257,12 +259,126 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
+		struct hdac_hdmi_dai_pin_map *dai_map)
+{
+	int mux_idx;
+	struct hdac_hdmi_pin *pin = dai_map->pin;
+
+	for (mux_idx = 0; mux_idx < pin->num_mux_nids; mux_idx++) {
+		if (pin->mux_nids[mux_idx] == dai_map->cvt->nid) {
+			snd_hdac_codec_write(&hdac->hdac, pin->nid, 0,
+					AC_VERB_SET_CONNECT_SEL, mux_idx);
+			break;
+		}
+	}
+
+	if (mux_idx == pin->num_mux_nids)
+		return -EIO;
+
+	/* Enable out path for this pin widget */
+	snd_hdac_codec_write(&hdac->hdac, pin->nid, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+
+	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D0);
+
+	snd_hdac_codec_write(&hdac->hdac, pin->nid, 0,
+			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+
+	return 0;
+}
+
+static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
+					struct hdac_hdmi_pin *pin)
+{
+	if (!(get_wcaps(&hdac->hdac, pin->nid) & AC_WCAP_CONN_LIST)) {
+		dev_warn(&hdac->hdac.dev,
+			"HDMI: pin %d wcaps %#x does not support connection list\n",
+			pin->nid, get_wcaps(&hdac->hdac, pin->nid));
+		return -EINVAL;
+	}
+
+	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
+			pin->mux_nids, HDA_MAX_CONNECTIONS);
+	if (pin->num_mux_nids == 0)
+		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n", pin->nid);
+
+	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
+			pin->num_mux_nids, pin->nid);
+
+	return pin->num_mux_nids;
+}
+
+static inline struct hdac_hdmi_pin *hdac_hdmi_get_pin(
+			struct hdac_ext_device *edev,
+			struct snd_soc_dapm_path *p,
+			struct hdac_hdmi_cvt *cvt)
+{
+	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin;
+	hda_nid_t *nid;
+	int ret, i;
+
+	nid = (hda_nid_t *)p->sink->priv;
+	list_for_each_entry(pin, &hdmi->pin_list, head) {
+		if (pin->nid == *nid) {
+			ret = hdac_hdmi_query_pin_connlist(edev, pin);
+			if (ret < 0)
+				continue;
+
+			for (i = 0; i < pin->num_mux_nids; i++) {
+				if (pin->mux_nids[i] == cvt->nid)
+					return pin;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/*
+ * This queries mux widgets in each sink path of the dai widget and returns
+ * a matching pin widget to which the stream may be routed.
+ *
+ * The converter may be input to multiple pin muxes. So each
+ * pin mux (basically each pin widget) is queried to identify if
+ * the converter as one of the input, then the first pin match
+ * is selected for rendering.
+ *
+ * Same stream rendering to multiple pins simultaneously can be done
+ * possibly, but not supported for now.
+ *
+ * So return the first pin connected
+ */
+static struct hdac_hdmi_pin *hdac_hdmi_get_pin_from_daistream(
+			struct hdac_ext_device *edev,
+			struct snd_soc_dapm_widget *strm_w,
+			struct hdac_hdmi_cvt *cvt)
+{
+	struct snd_soc_dapm_path *p;
+
+	snd_soc_dapm_widget_for_each_sink_path(strm_w, p) {
+		if (!p->connect)
+			continue;
+
+		if (strstr(p->sink->name, "Mux"))
+			return hdac_hdmi_get_pin(edev, p, cvt);
+		else
+			return hdac_hdmi_get_pin_from_daistream(edev, p->sink, cvt);
+	}
+
+	return NULL;
+}
+
 static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_cvt *cvt;
+	struct hdac_hdmi_pin *pin;
+	int ret;
 
 	if (dai->id > 0) {
 		dev_err(&hdac->hdac.dev, "Only one dai supported as of now\n");
@@ -271,18 +387,23 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	if ((!dai_map->pin->eld.monitor_present) ||
-		(!dai_map->pin->eld.eld_valid)) {
+	cvt = dai_map->cvt;
+	pin = hdac_hdmi_get_pin_from_daistream(hdac, dai->playback_widget, cvt);
+	if (!pin)
+		return -EIO;
+
+	if ((!pin->eld.monitor_present) ||
+		(!pin->eld.eld_valid)) {
 		dev_err(&hdac->hdac.dev, "Failed: montior present? %d eld valid?: %d\n",
-				dai_map->pin->eld.monitor_present,
-				dai_map->pin->eld.eld_valid);
-		return -ENODEV;
+				pin->eld.monitor_present, pin->eld.eld_valid);
+		return -EINVAL;
 	}
 
-	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D0);
+	dai_map->pin = pin;
 
-	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
-			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+	ret = hdac_hdmi_enable_pin(hdac, dai_map);
+	if (ret < 0)
+		return ret;
 
 	return snd_pcm_hw_constraint_eld(substream->runtime,
 			dai_map->pin->eld.eld_buffer);
@@ -301,6 +422,8 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 
 	snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+	dai_map->pin = NULL;
 }
 
 static int
@@ -323,28 +446,6 @@ hdac_hdmi_query_cvt_params(struct hdac_device *hdac, struct hdac_hdmi_cvt *cvt)
 	return err;
 }
 
-static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
-					struct hdac_hdmi_pin *pin)
-{
-	if (!(get_wcaps(&hdac->hdac, pin->nid) & AC_WCAP_CONN_LIST)) {
-		dev_warn(&hdac->hdac.dev,
-			"HDMI: pin %d wcaps %#x does not support connection list\n",
-			pin->nid, get_wcaps(&hdac->hdac, pin->nid));
-		return -EINVAL;
-	}
-
-	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
-			pin->mux_nids, HDA_MAX_CONNECTIONS);
-	if (pin->num_mux_nids == 0)
-		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n",
-								pin->nid);
-
-	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
-			pin->num_mux_nids, pin->nid);
-
-	return pin->num_mux_nids;
-}
-
 static void hdac_hdmi_fill_widget_info(struct device *dev,
 				struct snd_soc_dapm_widget *w,
 				enum snd_soc_dapm_type id, void *priv,
@@ -568,40 +669,33 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map = &hdmi->dai_map[0];
+	struct hdac_hdmi_dai_pin_map *dai_map;
 	struct hdac_hdmi_cvt *cvt;
-	struct hdac_hdmi_pin *pin;
+	int dai_id = 0;
 
-	if (list_empty(&hdmi->cvt_list) || list_empty(&hdmi->pin_list))
+	if (list_empty(&hdmi->cvt_list))
 		return -EINVAL;
 
-	/*
-	 * Currently on board only 1 pin and 1 converter is enabled for
-	 * simplification, more will be added eventually
-	 * So using fixed map for dai_id:pin:cvt
-	 */
-	cvt = list_first_entry(&hdmi->cvt_list, struct hdac_hdmi_cvt, head);
-	pin = list_first_entry(&hdmi->pin_list, struct hdac_hdmi_pin, head);
-
-	dai_map->dai_id = 0;
-	dai_map->pin = pin;
-
-	dai_map->cvt = cvt;
+	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
+		dai_map = &hdmi->dai_map[dai_id];
+		dai_map->dai_id = dai_id;
+		dai_map->cvt = cvt;
 
-	/* Enable out path for this pin widget */
-	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+		/* Enable transmission */
+		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
+				AC_VERB_SET_DIGI_CONVERT_1, 1);
 
-	/* Enable transmission */
-	snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
-			AC_VERB_SET_DIGI_CONVERT_1, 1);
+		/* Category Code (CC) to zero */
+		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
+				AC_VERB_SET_DIGI_CONVERT_2, 0);
 
-	/* Category Code (CC) to zero */
-	snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
-			AC_VERB_SET_DIGI_CONVERT_2, 0);
+		dai_id++;
 
-	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,
-			AC_VERB_SET_CONNECT_SEL, 0);
+		if (dai_id == HDA_MAX_CVTS) {
+			dev_warn(&edev->hdac.dev, "Max dais supported: %d\n", dai_id);
+			break;
+		}
+	}
 
 	return 0;
 }
-- 
1.9.1
