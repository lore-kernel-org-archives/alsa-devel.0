From: jeeja.kp@intel.com
Subject: [RFC 02/16] ASoC: hdac_hdmi: Begin to add support for
	DP Multi-stream Audio
Date: Tue, 20 Sep 2016 19:16:06 +0530
Message-ID: <1474379180-7132-3-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id BB3BA2666F1
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:37:48 +0200 (CEST)
In-Reply-To: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, broonie@kernel.org, liam.r.girdwood@intel.com, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

With MST each pin contains several ports to which device can be
connected.

As a preparatory work to support DP MST this patch adds below changes:
1. Defines the port structure and moves all stream related information
   like ELD, converter list, chmap to port.
2. Creates ports for each pin based on the max_ports support.
3. Based on Pin-Port combination creates DAPM Mux widget instead of Pin
   to allow user to select a converter.
4. Port zero is the default port when pin does not support MST.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 454 +++++++++++++++++++++++++------------------
 1 file changed, 270 insertions(+), 184 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index c504e98..88d6dae 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -81,10 +81,17 @@ struct hdac_hdmi_eld {
 struct hdac_hdmi_pin {
 	struct list_head head;
 	hda_nid_t nid;
+	struct hdac_hdmi_port *ports;
+	int num_ports;
+	struct hdac_ext_device *edev;
+};
+
+struct hdac_hdmi_port {
+	int id;
+	struct hdac_hdmi_pin *pin;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	struct hdac_hdmi_eld eld;
-	struct hdac_ext_device *edev;
 	struct mutex lock;
 	bool chmap_set;
 	unsigned char chmap[8]; /* ALSA API channel-map */
@@ -94,28 +101,35 @@ struct hdac_hdmi_pin {
 struct hdac_hdmi_pcm {
 	struct list_head head;
 	int pcm_id;
-	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_port *port;
 	struct hdac_hdmi_cvt *cvt;
 	struct snd_jack *jack;
 };
 
-struct hdac_hdmi_dai_pin_map {
+struct hdac_hdmi_dai_port_map {
 	int dai_id;
-	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_port *port;
 	struct hdac_hdmi_cvt *cvt;
 };
 
 struct hdac_hdmi_priv {
-	struct hdac_hdmi_dai_pin_map dai_map[HDA_MAX_CVTS];
+	struct hdac_hdmi_dai_port_map dai_map[HDA_MAX_CVTS];
 	struct list_head pin_list;
 	struct list_head cvt_list;
 	struct list_head pcm_list;
 	int num_pin;
 	int num_cvt;
+	int num_ports;
 	struct mutex pin_mutex;
 	struct hdac_chmap chmap;
 };
 
+static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
+		                struct hdac_hdmi_dai_port_map *dai_map);
+
+static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
+		                struct hdac_hdmi_dai_port_map *dai_map);
+
 static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 						int pcm_idx)
 {
@@ -219,13 +233,14 @@ struct dp_audio_infoframe {
 };
 
 static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
-				hda_nid_t cvt_nid, hda_nid_t pin_nid)
+				hda_nid_t cvt_nid, hda_nid_t pin_nid,
+				struct hdac_hdmi_port *port)
 {
 	uint8_t buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AUDIO_INFOFRAME_SIZE];
 	struct hdmi_audio_infoframe frame;
+	struct hdac_hdmi_pin *pin;
 	struct dp_audio_infoframe dp_ai;
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	struct hdac_hdmi_pin *pin;
 	u8 *dip;
 	int ret;
 	int i;
@@ -238,16 +253,16 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 			break;
 	}
 
-	ca = snd_hdac_channel_allocation(&hdac->hdac, pin->eld.info.spk_alloc,
-			pin->channels, pin->chmap_set, true, pin->chmap);
+	ca = snd_hdac_channel_allocation(&hdac->hdac, port->eld.info.spk_alloc,
+			port->channels, port->chmap_set, true, port->chmap);
 
 	channels = snd_hdac_get_active_channels(ca);
 	hdmi->chmap.ops.set_channel_count(&hdac->hdac, cvt_nid, channels);
 
 	snd_hdac_setup_channel_mapping(&hdmi->chmap, pin->nid, false, ca,
-				pin->channels, pin->chmap, pin->chmap_set);
+				port->channels, port->chmap, port->chmap_set);
 
-	eld_buf = pin->eld.eld_buffer;
+	eld_buf = port->eld.eld_buffer;
 	conn_type = drm_eld_get_conn_type(eld_buf);
 
 	switch (conn_type) {
@@ -307,12 +322,14 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 }
 
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
-		struct hdac_hdmi_dai_pin_map *dai_map, unsigned int pwr_state)
+		struct hdac_hdmi_dai_port_map *dai_map, unsigned int pwr_state)
 {
+	struct hdac_hdmi_pin *pin = dai_map->port->pin;
+
 	/* Power up pin widget */
-	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->pin->nid,
+	if (!snd_hdac_check_power_state(&edev->hdac, pin->nid,
 						pwr_state))
-		snd_hdac_codec_write(&edev->hdac, dai_map->pin->nid, 0,
+		snd_hdac_codec_write(&edev->hdac, pin->nid, 0,
 			AC_VERB_SET_POWER_STATE, pwr_state);
 
 	/* Power up converter */
@@ -327,29 +344,34 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
-	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_dai_port_map *dai_map;
+	struct hdac_hdmi_port *port;
 	struct hdac_ext_dma_params *dd;
 	int ret;
 
 	dai_map = &hdmi->dai_map[dai->id];
-	pin = dai_map->pin;
+	port = dai_map->port;
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
 			dd->stream_tag,	dd->format);
 
-	mutex_lock(&pin->lock);
-	pin->channels = substream->runtime->channels;
+	hdac_hdmi_enable_cvt(hdac, dai_map);
+	ret = hdac_hdmi_enable_pin(hdac, dai_map);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&port->lock);
+	port->channels = substream->runtime->channels;
 
 	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt->nid,
-						dai_map->pin->nid);
-	mutex_unlock(&pin->lock);
+						port->pin->nid, port);
+	mutex_unlock(&port->lock);
 	if (ret < 0)
 		return ret;
 
 	return hdac_hdmi_setup_stream(hdac, dai_map->cvt->nid,
-			dai_map->pin->nid, dd->stream_tag, dd->format);
+			port->pin->nid, dd->stream_tag, dd->format);
 }
 
 static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
@@ -357,19 +379,20 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
-	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_dai_port_map *dai_map;
+	struct hdac_hdmi_port *port;
 	struct hdac_ext_dma_params *dd;
 
 	dai_map = &hdmi->dai_map[dai->id];
-	pin = dai_map->pin;
+	port = dai_map->port;
 
-	if (!pin)
+	if (!port)
 		return -ENODEV;
 
-	if ((!pin->eld.monitor_present) || (!pin->eld.eld_valid)) {
-		dev_err(&hdac->hdac.dev, "device is not configured for this pin: %d\n",
-								pin->nid);
+	if ((!port->eld.monitor_present) || (!port->eld.eld_valid)) {
+		dev_err(&hdac->hdac.dev,
+			"device is not configured for this pin:port%d:%d\n",
+					port->pin->nid, port->id);
 		return -ENODEV;
 	}
 
@@ -395,7 +418,7 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
 	struct hdac_ext_dma_params *dd;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_dai_port_map *dai_map;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
@@ -410,7 +433,7 @@ static int hdac_hdmi_playback_cleanup(struct snd_pcm_substream *substream,
 }
 
 static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
-		struct hdac_hdmi_dai_pin_map *dai_map)
+		struct hdac_hdmi_dai_port_map *dai_map)
 {
 	/* Enable transmission */
 	snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
@@ -422,36 +445,37 @@ static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
 }
 
 static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
-		struct hdac_hdmi_dai_pin_map *dai_map)
+		struct hdac_hdmi_dai_port_map *dai_map)
 {
 	int mux_idx;
-	struct hdac_hdmi_pin *pin = dai_map->pin;
+	struct hdac_hdmi_port *port = dai_map->port;
 
-	for (mux_idx = 0; mux_idx < pin->num_mux_nids; mux_idx++) {
-		if (pin->mux_nids[mux_idx] == dai_map->cvt->nid) {
-			snd_hdac_codec_write(&hdac->hdac, pin->nid, 0,
+	for (mux_idx = 0; mux_idx < port->num_mux_nids; mux_idx++) {
+		if (port->mux_nids[mux_idx] == dai_map->cvt->nid) {
+			snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
 					AC_VERB_SET_CONNECT_SEL, mux_idx);
 			break;
 		}
 	}
 
-	if (mux_idx == pin->num_mux_nids)
+	if (mux_idx == port->num_mux_nids)
 		return -EIO;
 
 	/* Enable out path for this pin widget */
-	snd_hdac_codec_write(&hdac->hdac, pin->nid, 0,
+	snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
 	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D0);
 
-	snd_hdac_codec_write(&hdac->hdac, pin->nid, 0,
+	snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
 
 	return 0;
 }
 
-static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
-					struct hdac_hdmi_pin *pin)
+static int hdac_hdmi_query_port_connlist(struct hdac_ext_device *hdac,
+					struct hdac_hdmi_pin *pin,
+					struct hdac_hdmi_port *port)
 {
 	if (!(get_wcaps(&hdac->hdac, pin->nid) & AC_WCAP_CONN_LIST)) {
 		dev_warn(&hdac->hdac.dev,
@@ -460,51 +484,52 @@ static int hdac_hdmi_query_pin_connlist(struct hdac_ext_device *hdac,
 		return -EINVAL;
 	}
 
-	pin->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
-			pin->mux_nids, HDA_MAX_CONNECTIONS);
-	if (pin->num_mux_nids == 0)
-		dev_warn(&hdac->hdac.dev, "No connections found for pin: %d\n",
-								pin->nid);
+	port->num_mux_nids = snd_hdac_get_connections(&hdac->hdac, pin->nid,
+			port->mux_nids, HDA_MAX_CONNECTIONS);
+	if (port->num_mux_nids == 0)
+		dev_warn(&hdac->hdac.dev,
+			"No connections found for pin:port %d:%d\n",
+						pin->nid, port->id);
 
-	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin: %d\n",
-			pin->num_mux_nids, pin->nid);
+	dev_dbg(&hdac->hdac.dev, "num_mux_nids %d for pin:port %d:%d\n",
+			port->num_mux_nids, pin->nid, port->id);
 
-	return pin->num_mux_nids;
+	return port->num_mux_nids;
 }
 
 /*
- * Query pcm list and return pin widget to which stream is routed.
+ * Query pcm list and return port to which stream is routed.
  *
- * Also query connection list of the pin, to validate the cvt to pin map.
+ * Also query connection list of the pin, to validate the cvt to port map.
  *
- * Same stream rendering to multiple pins simultaneously can be done
- * possibly, but not supported for now in driver. So return the first pin
+ * Same stream rendering to multiple ports simultaneously can be done
+ * possibly, but not supported for now in driver. So return the first port
  * connected.
  */
-static struct hdac_hdmi_pin *hdac_hdmi_get_pin_from_cvt(
+static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 			struct hdac_ext_device *edev,
 			struct hdac_hdmi_priv *hdmi,
 			struct hdac_hdmi_cvt *cvt)
 {
 	struct hdac_hdmi_pcm *pcm;
-	struct hdac_hdmi_pin *pin = NULL;
+	struct hdac_hdmi_port *port = NULL;
 	int ret, i;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
 		if (pcm->cvt == cvt) {
-			pin = pcm->pin;
+			port = pcm->port;
 			break;
 		}
 	}
 
-	if (pin) {
-		ret = hdac_hdmi_query_pin_connlist(edev, pin);
+	if (port) {
+		ret = hdac_hdmi_query_port_connlist(edev, port->pin, port);
 		if (ret < 0)
 			return NULL;
 
-		for (i = 0; i < pin->num_mux_nids; i++) {
-			if (pin->mux_nids[i] == cvt->nid)
-				return pin;
+		for (i = 0; i < port->num_mux_nids; i++) {
+			if (port->mux_nids[i] == cvt->nid)
+				return port;
 		}
 	}
 
@@ -521,53 +546,49 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_cvt *cvt;
-	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_port *port;
 	int ret;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
 	cvt = dai_map->cvt;
-	pin = hdac_hdmi_get_pin_from_cvt(hdac, hdmi, cvt);
+	port = hdac_hdmi_get_port_from_cvt(hdac, hdmi, cvt);
 
 	/*
 	 * To make PA and other userland happy.
 	 * userland scans devices so returning error does not help.
 	 */
-	if (!pin)
+	if (!port)
 		return 0;
 
-	if ((!pin->eld.monitor_present) ||
-			(!pin->eld.eld_valid)) {
+	if ((!port->eld.monitor_present) ||
+			(!port->eld.eld_valid)) {
 
 		dev_warn(&hdac->hdac.dev,
-			"Failed: montior present? %d ELD valid?: %d for pin: %d\n",
-			pin->eld.monitor_present, pin->eld.eld_valid, pin->nid);
+			"Failed: present?:%d ELD valid?:%d pin:port: %d:%d\n",
+			port->eld.monitor_present, port->eld.eld_valid,
+			port->pin->nid, port->id);
 
 		return 0;
 	}
 
-	dai_map->pin = pin;
-
-	hdac_hdmi_enable_cvt(hdac, dai_map);
-	ret = hdac_hdmi_enable_pin(hdac, dai_map);
-	if (ret < 0)
-		return ret;
+	dai_map->port = port;
 
 	ret = hdac_hdmi_eld_limit_formats(substream->runtime,
-				pin->eld.eld_buffer);
+				port->eld.eld_buffer);
 	if (ret < 0)
 		return ret;
 
 	return snd_pcm_hw_constraint_eld(substream->runtime,
-				pin->eld.eld_buffer);
+				port->eld.eld_buffer);
 }
 
 static int hdac_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	int ret;
@@ -589,11 +610,11 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 {
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_dai_port_map *dai_map;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	if (dai_map->pin) {
+	if (dai_map->port) {
 		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_CHANNEL_STREAMID, 0);
 		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
@@ -601,16 +622,16 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 
 		hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
 
-		snd_hdac_codec_write(&hdac->hdac, dai_map->pin->nid, 0,
+		snd_hdac_codec_write(&hdac->hdac, dai_map->port->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
 
-		mutex_lock(&dai_map->pin->lock);
-		dai_map->pin->chmap_set = false;
-		memset(dai_map->pin->chmap, 0, sizeof(dai_map->pin->chmap));
-		dai_map->pin->channels = 0;
-		mutex_unlock(&dai_map->pin->lock);
+		mutex_lock(&dai_map->port->lock);
+		dai_map->port->chmap_set = false;
+		memset(dai_map->port->chmap, 0, sizeof(dai_map->port->chmap));
+		dai_map->port->channels = 0;
+		mutex_unlock(&dai_map->port->lock);
 
-		dai_map->pin = NULL;
+		dai_map->port = NULL;
 	}
 }
 
@@ -676,13 +697,16 @@ static void hdac_hdmi_fill_route(struct snd_soc_dapm_route *route,
 }
 
 static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
-					struct hdac_hdmi_pin *pin)
+					struct hdac_hdmi_port *port)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = NULL;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
-		if (pcm->pin == pin)
+		if (!pcm->port)
+			continue;
+
+		if (pcm->port == port)
 			return pcm;
 	}
 
@@ -692,14 +716,14 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
 /*
  * Based on user selection, map the PINs with the PCMs.
  */
-static int hdac_hdmi_set_pin_mux(struct snd_kcontrol *kcontrol,
+static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	int ret;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
 	struct snd_soc_dapm_context *dapm = w->dapm;
-	struct hdac_hdmi_pin *pin = w->priv;
+	struct hdac_hdmi_port *port = w->priv;
 	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = NULL;
@@ -709,18 +733,22 @@ static int hdac_hdmi_set_pin_mux(struct snd_kcontrol *kcontrol,
 	if (ret < 0)
 		return ret;
 
+	if (port == NULL)
+		return -EINVAL;
+
 	mutex_lock(&hdmi->pin_mutex);
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
-		if (pcm->pin == pin)
-			pcm->pin = NULL;
+		if (!pcm->port && pcm->port == port &&
+			pcm->port->id == port->id)
+			pcm->port = NULL;
 
 		/*
 		 * Jack status is not reported during device probe as the
 		 * PCMs are not registered by then. So report it here.
 		 */
-		if (!strcmp(cvt_name, pcm->cvt->name) && !pcm->pin) {
-			pcm->pin = pin;
-			if (pin->eld.monitor_present && pin->eld.eld_valid) {
+		if (!strcmp(cvt_name, pcm->cvt->name) && !pcm->port) {
+			pcm->port = port;
+			if (port->eld.monitor_present && port->eld.eld_valid) {
 				dev_dbg(&edev->hdac.dev,
 					"jack report for pcm=%d\n",
 					pcm->pcm_id);
@@ -745,12 +773,13 @@ static int hdac_hdmi_set_pin_mux(struct snd_kcontrol *kcontrol,
  * care of selecting the right one and leaving all other inputs selected to
  * "NONE"
  */
-static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
-				struct hdac_hdmi_pin *pin,
+static int hdac_hdmi_create_pin_port_muxs(struct hdac_ext_device *edev,
+				struct hdac_hdmi_port *port,
 				struct snd_soc_dapm_widget *widget,
 				const char *widget_name)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
+	struct hdac_hdmi_pin *pin = port->pin;
 	struct snd_kcontrol_new *kc;
 	struct hdac_hdmi_cvt *cvt;
 	struct soc_enum *se;
@@ -769,7 +798,7 @@ static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
 	if (!se)
 		return -ENOMEM;
 
-	sprintf(kc_name, "Pin %d Input", pin->nid);
+	sprintf(kc_name, "Pin %d port %d Input", pin->nid, port->id);
 	kc->name = devm_kstrdup(&edev->hdac.dev, kc_name, GFP_KERNEL);
 	if (!kc->name)
 		return -ENOMEM;
@@ -778,7 +807,7 @@ static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
 	kc->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
 	kc->access = 0;
 	kc->info = snd_soc_info_enum_double;
-	kc->put = hdac_hdmi_set_pin_mux;
+	kc->put = hdac_hdmi_set_pin_port_mux;
 	kc->get = snd_soc_dapm_get_enum_double;
 
 	se->reg = SND_SOC_NOPM;
@@ -806,7 +835,7 @@ static int hdac_hdmi_create_pin_muxs(struct hdac_ext_device *edev,
 		return -ENOMEM;
 
 	return hdac_hdmi_fill_widget_info(&edev->hdac.dev, widget,
-			snd_soc_dapm_mux, pin, widget_name, NULL, kc, 1);
+			snd_soc_dapm_mux, port, widget_name, NULL, kc, 1);
 }
 
 /* Add cvt <- input <- mux route map */
@@ -817,10 +846,10 @@ static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_ext_device *edev,
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	const struct snd_kcontrol_new *kc;
 	struct soc_enum *se;
-	int mux_index = hdmi->num_cvt + hdmi->num_pin;
+	int mux_index = hdmi->num_cvt + hdmi->num_ports;
 	int i, j;
 
-	for (i = 0; i < hdmi->num_pin; i++) {
+	for (i = 0; i < hdmi->num_ports; i++) {
 		kc = widgets[mux_index].kcontrol_news;
 		se = (struct soc_enum *)kc->private_value;
 		for (j = 0; j < hdmi->num_cvt; j++) {
@@ -839,17 +868,18 @@ static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_ext_device *edev,
 /*
  * Widgets are added in the below sequence
  *	Converter widgets for num converters enumerated
- *	Pin widgets for num pins enumerated
- *	Pin mux widgets to represent connenction list of pin widget
+ *	Pin-port widgets for num ports for Pins enumerated
+ *	Pin-port mux widgets to represent connenction list of pin widget
  *
- * Total widgets elements = num_cvt + num_pin + num_pin;
+ * For each port, one Mux and One output widget is added
+ * Total widgets elements = num_cvt + (num_ports * 2);
  *
  * Routes are added as below:
- *	pin mux -> pin (based on num_pins)
- *	cvt -> "Input sel control" -> pin_mux
+ *	pin-port mux -> pin (based on num_ports)
+ *	cvt -> "Input sel control" -> pin-port_mux
  *
  * Total route elements:
- *	num_pins + (pin_muxes * num_cvt)
+ *	num_ports + (pin_muxes * num_cvt)
  */
 static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 {
@@ -861,13 +891,13 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 	char widget_name[NAME_SIZE];
 	struct hdac_hdmi_cvt *cvt;
 	struct hdac_hdmi_pin *pin;
-	int ret, i = 0, num_routes = 0;
+	int ret, i = 0, num_routes = 0, j;
 
 	if (list_empty(&hdmi->cvt_list) || list_empty(&hdmi->pin_list))
 		return -EINVAL;
 
 	widgets = devm_kzalloc(dapm->dev,
-		(sizeof(*widgets) * ((2 * hdmi->num_pin) + hdmi->num_cvt)),
+		(sizeof(*widgets) * ((2 * hdmi->num_ports) + hdmi->num_cvt)),
 		GFP_KERNEL);
 
 	if (!widgets)
@@ -885,31 +915,37 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 	}
 
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
-		sprintf(widget_name, "hif%d Output", pin->nid);
-		ret = hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
-				snd_soc_dapm_output, &pin->nid,
-				widget_name, NULL, NULL, 0);
-		if (ret < 0)
-			return ret;
-		i++;
+		for (j = 0; j < pin->num_ports; j++) {
+			sprintf(widget_name, "hif%d-%d Output",
+				pin->nid, pin->ports[j].id);
+			ret = hdac_hdmi_fill_widget_info(dapm->dev, &widgets[i],
+					snd_soc_dapm_output, &pin->ports[j].id,
+					widget_name, NULL, NULL, 0);
+			if (ret < 0)
+				return ret;
+			i++;
+		}
 	}
 
 	/* DAPM widgets to represent the connection list to pin widget */
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
-		sprintf(widget_name, "Pin %d Mux", pin->nid);
-		ret = hdac_hdmi_create_pin_muxs(edev, pin, &widgets[i],
-							widget_name);
-		if (ret < 0)
-			return ret;
-		i++;
+		for (j = 0; j < pin->num_ports; j++) {
+			sprintf(widget_name, "Pin%d-Port%d Mux",
+				pin->nid, pin->ports[j].id);
+			ret = hdac_hdmi_create_pin_port_muxs(edev,
+						&pin->ports[j], &widgets[i],
+						widget_name);
+			if (ret < 0)
+				return ret;
+			i++;
 
-		/* For cvt to pin_mux mapping */
-		num_routes += hdmi->num_cvt;
+			/* For cvt to pin_mux mapping */
+			num_routes += hdmi->num_cvt;
 
-		/* For pin_mux to pin mapping */
-		num_routes++;
+			/* For pin_mux to pin mapping */
+			num_routes++;
+		}
 	}
-
 	route = devm_kzalloc(dapm->dev, (sizeof(*route) * num_routes),
 							GFP_KERNEL);
 	if (!route)
@@ -918,20 +954,21 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 	i = 0;
 	/* Add pin <- NULL <- mux route map */
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
-		int sink_index = i + hdmi->num_cvt;
-		int src_index = sink_index + hdmi->num_pin;
+		for (j = 0; j < pin->num_ports; j++) {
+			int sink_index = i + hdmi->num_cvt;
+			int src_index = sink_index + pin->num_ports;
 
-		hdac_hdmi_fill_route(&route[i],
+			hdac_hdmi_fill_route(&route[i],
 				widgets[sink_index].name, NULL,
 				widgets[src_index].name, NULL);
-		i++;
-
+			i++;
+		}
 	}
 
 	hdac_hdmi_add_pinmux_cvt_route(edev, widgets, route, i);
 
 	snd_soc_dapm_new_controls(dapm, widgets,
-		((2 * hdmi->num_pin) + hdmi->num_cvt));
+		((2 * hdmi->num_ports) + hdmi->num_cvt));
 
 	snd_soc_dapm_add_routes(dapm, route, num_routes);
 	snd_soc_dapm_new_widgets(dapm->card);
@@ -943,7 +980,7 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_dai_pin_map *dai_map;
+	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_cvt *cvt;
 	int dai_id = 0;
 
@@ -987,12 +1024,12 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 	return hdac_hdmi_query_cvt_params(&edev->hdac, cvt);
 }
 
-static int  hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
-			struct hdac_hdmi_pin *pin)
+static int hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
+			struct hdac_hdmi_port *port)
 {
 	unsigned int ver, mnl;
 
-	ver = (pin->eld.eld_buffer[DRM_ELD_VER] & DRM_ELD_VER_MASK)
+	ver = (port->eld.eld_buffer[DRM_ELD_VER] & DRM_ELD_VER_MASK)
 						>> DRM_ELD_VER_SHIFT;
 
 	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
@@ -1000,7 +1037,7 @@ static int  hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
 		return -EINVAL;
 	}
 
-	mnl = (pin->eld.eld_buffer[DRM_ELD_CEA_EDID_VER_MNL] &
+	mnl = (port->eld.eld_buffer[DRM_ELD_CEA_EDID_VER_MNL] &
 		DRM_ELD_MNL_MASK) >> DRM_ELD_MNL_SHIFT;
 
 	if (mnl > ELD_MAX_MNL) {
@@ -1008,45 +1045,49 @@ static int  hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
 		return -EINVAL;
 	}
 
-	pin->eld.info.spk_alloc = pin->eld.eld_buffer[DRM_ELD_SPEAKER];
+	port->eld.info.spk_alloc = port->eld.eld_buffer[DRM_ELD_SPEAKER];
 
 	return 0;
 }
 
-static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin)
+static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
+				    struct hdac_hdmi_port *port)
 {
 	struct hdac_ext_device *edev = pin->edev;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm;
-	int size;
+	int size = 0;
+
+	if (!hdmi)
+		return;
 
 	mutex_lock(&hdmi->pin_mutex);
-	pin->eld.monitor_present = false;
+	port->eld.monitor_present = false;
 
 	size = snd_hdac_acomp_get_eld(&edev->hdac, pin->nid, -1,
-				&pin->eld.monitor_present, pin->eld.eld_buffer,
+				&port->eld.monitor_present, port->eld.eld_buffer,
 				ELD_MAX_SIZE);
 
 	if (size > 0) {
 		size = min(size, ELD_MAX_SIZE);
-		if (hdac_hdmi_parse_eld(edev, pin) < 0)
+		if (hdac_hdmi_parse_eld(edev, port) < 0)
 			size = -EINVAL;
 	}
 
 	if (size > 0) {
-		pin->eld.eld_valid = true;
-		pin->eld.eld_size = size;
+		port->eld.eld_valid = true;
+		port->eld.eld_size = size;
 	} else {
-		pin->eld.eld_valid = false;
-		pin->eld.eld_size = 0;
+		port->eld.eld_valid = false;
+		port->eld.eld_size = 0;
 	}
 
-	pcm = hdac_hdmi_get_pcm(edev, pin);
+	pcm = hdac_hdmi_get_pcm(edev, port);
 
-	if (!pin->eld.monitor_present || !pin->eld.eld_valid) {
+	if (!port->eld.monitor_present || !port->eld.eld_valid) {
 
-		dev_dbg(&edev->hdac.dev, "%s: disconnect for pin %d\n",
-						__func__, pin->nid);
+		dev_dbg(&edev->hdac.dev, "%s: disconnect for pin:port %d:%d\n",
+						__func__, pin->nid, port->id);
 
 		/*
 		 * PCMs are not registered during device probe, so don't
@@ -1064,7 +1105,7 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin)
 		return;
 	}
 
-	if (pin->eld.monitor_present && pin->eld.eld_valid) {
+	if (port->eld.monitor_present && port->eld.eld_valid) {
 		if (pcm) {
 			dev_dbg(&edev->hdac.dev,
 				"jack report for pcm=%d\n",
@@ -1074,28 +1115,53 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin)
 		}
 
 		print_hex_dump_debug("ELD: ", DUMP_PREFIX_OFFSET, 16, 1,
-			  pin->eld.eld_buffer, pin->eld.eld_size, false);
-	}
+			  port->eld.eld_buffer, port->eld.eld_size, false);
 
+	}
 	mutex_unlock(&hdmi->pin_mutex);
 }
 
+static int hdac_hdmi_add_ports(struct hdac_hdmi_priv *hdmi,
+				struct hdac_hdmi_pin *pin)
+{
+	struct hdac_hdmi_port *ports;
+	int max_ports = 3; /* FIXME  this will read from i915 acomp API*/
+	int i;
+
+	/*get max ports supported from i915 acomp interface */
+	ports = kzalloc(max_ports * sizeof(*ports), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+
+	for (i=0; i < max_ports; i++) {
+		ports[i].id = i + 1;
+		ports[i].pin = pin;
+		mutex_init(&ports[i].lock);
+	}
+	pin->ports = ports;
+	pin->num_ports = max_ports;
+	return 0;
+}
+
 static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pin *pin;
+	int ret;
 
 	pin = kzalloc(sizeof(*pin), GFP_KERNEL);
 	if (!pin)
 		return -ENOMEM;
 
 	pin->nid = nid;
+	pin->edev = edev;
+	ret = hdac_hdmi_add_ports(hdmi, pin);
+	if (ret < 0)
+		return ret;
 
 	list_add_tail(&pin->head, &hdmi->pin_list);
 	hdmi->num_pin++;
-
-	pin->edev = edev;
-	mutex_init(&pin->lock);
+	hdmi->num_ports += pin->num_ports;
 
 	return 0;
 }
@@ -1279,17 +1345,19 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 	return hdac_hdmi_init_dai_map(edev);
 }
 
-static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
+static void hdac_hdmi_eld_notify_cb(void *aptr, int dport, int pipe)
 {
 	struct hdac_ext_device *edev = aptr;
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
-	struct hdac_hdmi_pin *pin;
+	struct hdac_hdmi_pin *pin = NULL;
+	struct hdac_hdmi_port *port = NULL;
 	struct snd_soc_codec *codec = edev->scodec;
 
 	/* Don't know how this mapping is derived */
-	hda_nid_t pin_nid = port + 0x04;
+	hda_nid_t pin_nid = dport + 0x04;
 
-	dev_dbg(&edev->hdac.dev, "%s: for pin: %d\n", __func__, pin_nid);
+	dev_dbg(&edev->hdac.dev, "%s: for pin:%d port=%d\n", __func__,
+							pin_nid, pipe);
 
 	/*
 	 * skip notification during system suspend (but not in runtime PM);
@@ -1305,9 +1373,18 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 		return;
 
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
-		if (pin->nid == pin_nid)
-			hdac_hdmi_present_sense(pin);
+		if (pin->nid != pin_nid)
+			continue;
+
+		if (pipe == -1) {
+			/* if not MST, default is port[0] */
+			port = &pin->ports[0];
+			break;
+		}
 	}
+
+	if (port)
+		hdac_hdmi_present_sense(pin, port);
 }
 
 static struct i915_audio_component_audio_ops aops = {
@@ -1378,7 +1455,7 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_hdmi_pin *pin;
 	struct hdac_ext_link *hlink = NULL;
-	int ret;
+	int ret, i;
 
 	edev->scodec = codec;
 
@@ -1407,7 +1484,8 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 	}
 
 	list_for_each_entry(pin, &hdmi->pin_list, head)
-		hdac_hdmi_present_sense(pin);
+		for (i = 0; i < pin->num_ports; i++)
+			hdac_hdmi_present_sense(pin, &pin->ports[i]);
 
 	/* Imp: Store the card pointer in hda_codec */
 	edev->card = dapm->card->snd_card;
@@ -1458,6 +1536,7 @@ static void hdmi_codec_complete(struct device *dev)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pin *pin;
 	struct hdac_device *hdac = &edev->hdac;
+	int i;
 
 	/* Power up afg */
 	snd_hdac_codec_read(hdac, hdac->afg, 0,	AC_VERB_SET_POWER_STATE,
@@ -1472,7 +1551,8 @@ static void hdmi_codec_complete(struct device *dev)
 	 * all pins here.
 	 */
 	list_for_each_entry(pin, &hdmi->pin_list, head)
-		hdac_hdmi_present_sense(pin);
+		for (i = 0; i < pin->num_ports; i++)
+			hdac_hdmi_present_sense(pin, &pin->ports[i]);
 
 	pm_runtime_put_sync(&edev->hdac.dev);
 }
@@ -1493,13 +1573,13 @@ static void hdac_hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_pin *pin = pcm->pin;
+	struct hdac_hdmi_port *port = pcm->port;
 
 	/* chmap is already set to 0 in caller */
-	if (!pin)
+	if (!port)
 		return;
 
-	memcpy(chmap, pin->chmap, ARRAY_SIZE(pin->chmap));
+	memcpy(chmap, port->chmap, ARRAY_SIZE(port->chmap));
 }
 
 static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
@@ -1508,14 +1588,16 @@ static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_pin *pin = pcm->pin;
+	struct hdac_hdmi_port *port = pcm->port;
+	struct hdac_hdmi_pin *pin = port->pin;
 
-	mutex_lock(&pin->lock);
-	pin->chmap_set = true;
-	memcpy(pin->chmap, chmap, ARRAY_SIZE(pin->chmap));
+	mutex_lock(&port->lock);
+	port->chmap_set = true;
+	memcpy(port->chmap, chmap, ARRAY_SIZE(port->chmap));
 	if (prepared)
-		hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid, pin->nid);
-	mutex_unlock(&pin->lock);
+		hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid,
+						pin->nid, port);
+	mutex_unlock(&port->lock);
 }
 
 static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
@@ -1523,9 +1605,9 @@ static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_pin *pin = pcm->pin;
+	struct hdac_hdmi_port *port = pcm->port;
 
-	return pin ? true:false;
+	return port ? true:false;
 }
 
 static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
@@ -1533,12 +1615,12 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_pin *pin = pcm->pin;
+	struct hdac_hdmi_port *port = pcm->port;
 
-	if (!pin || !pin->eld.eld_valid)
+	if (!port || !port->eld.eld_valid)
 		return 0;
 
-	return pin->eld.info.spk_alloc;
+	return port->eld.info.spk_alloc;
 }
 
 static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
@@ -1611,12 +1693,13 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 	struct hdac_hdmi_pin *pin, *pin_next;
 	struct hdac_hdmi_cvt *cvt, *cvt_next;
 	struct hdac_hdmi_pcm *pcm, *pcm_next;
+	int i;
 
 	snd_soc_unregister_codec(&edev->hdac.dev);
 
 	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
 		pcm->cvt = NULL;
-		pcm->pin = NULL;
+		pcm->port = NULL;
 		list_del(&pcm->head);
 		kfree(pcm);
 	}
@@ -1628,6 +1711,9 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 	}
 
 	list_for_each_entry_safe(pin, pin_next, &hdmi->pin_list, head) {
+		for (i =0; i < pin->num_ports; i++)
+			pin->ports[i].pin = NULL;
+		kfree(pin->ports);
 		list_del(&pin->head);
 		kfree(pin);
 	}
-- 
2.5.0
