From: jeeja.kp@intel.com
Subject: [RFC 11/16] ASoC: hdac_hdmi: Add support to handle
	Multiple Port to same PCM
Date: Tue, 20 Sep 2016 19:16:15 +0530
Message-ID: <1474379180-7132-12-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id C26902666F1
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:38:14 +0200 (CEST)
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

Since we have the MST feature enabled and Pin-Port mux for user to
select the converter routing, Multiple port mapping to same converter
needs to be supported.

This patch the following changes to support Multiple port mapped to same
converter.
1. Jack reporting in case where Multiple port are attached to same PCM.
2. Enable all the port if the device connected in pcm prepare.
3. Configure Audio frame for all ports in pcm prepare.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 295 +++++++++++++++++++++++++++----------------
 1 file changed, 183 insertions(+), 112 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 618af31..bfa0ffb 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -88,6 +88,7 @@ struct hdac_hdmi_pin {
 };
 
 struct hdac_hdmi_port {
+	struct list_head head;
 	int id;
 	struct hdac_hdmi_pin *pin;
 	int num_mux_nids;
@@ -96,15 +97,17 @@ struct hdac_hdmi_port {
 	bool chmap_set;
 	unsigned char chmap[8]; /* ALSA API channel-map */
 	int channels; /* current number of channels */
+	bool is_connected; /* flag to indicate device connected to port */
 };
 
 struct hdac_hdmi_pcm {
 	struct list_head head;
 	struct mutex lock;
 	int pcm_id;
-	struct hdac_hdmi_port *port;
+	struct list_head port_list;
 	struct hdac_hdmi_cvt *cvt;
 	struct snd_jack *jack;
+	int jack_event;
 };
 
 struct hdac_hdmi_dai_port_map {
@@ -125,6 +128,39 @@ struct hdac_hdmi_priv {
 	struct hdac_chmap chmap;
 };
 
+static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
+		struct hdac_hdmi_port *port, bool is_connect)
+{
+	struct hdac_ext_device *edev = port->pin->edev;
+
+	if (is_connect) {
+		/*
+		 * Report Jack connect event when a device is connected
+		 * for the first time where same PCM is attached to mutiple
+		 * ports.
+		 */
+		if (pcm->jack_event == 0) {
+			dev_dbg(&edev->hdac.dev,
+					"jack report for pcm=%d\n",
+					pcm->pcm_id);
+			snd_jack_report(pcm->jack, SND_JACK_AVOUT);
+		}
+		pcm->jack_event++;
+		port->is_connected = true;
+	} else {
+		/*
+		 * Report Jack disconnect event when a device is disconnected
+		 * is the only last connected device when same PCM is attached
+		 * to mutiple ports.
+		 */
+		if (pcm->jack_event == 1)
+			snd_jack_report(pcm->jack, 0);
+		if (pcm->jack_event > 0)
+			pcm->jack_event--;
+		port->is_connected = false;
+	}
+}
+
 static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm_from_cvt(
 			struct hdac_hdmi_priv *hdmi,
 			struct hdac_hdmi_cvt *cvt)
@@ -212,7 +248,7 @@ static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
 		                struct hdac_hdmi_dai_port_map *dai_map);
 
 static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
-		                struct hdac_hdmi_dai_port_map *dai_map);
+                struct hdac_hdmi_port *port, struct hdac_hdmi_cvt *cvt);
 
 static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 						int pcm_idx)
@@ -274,13 +310,12 @@ format_constraint:
 }
 
 static int hdac_hdmi_setup_stream(struct hdac_ext_device *hdac,
-				hda_nid_t cvt_nid, hda_nid_t pin_nid,
-				u32 stream_tag, int format)
+		 hda_nid_t cvt_nid, u32 stream_tag, int format)
 {
 	unsigned int val;
 
-	dev_dbg(&hdac->hdac.dev, "cvt nid %d pnid %d stream %d format 0x%x\n",
-			cvt_nid, pin_nid, stream_tag, format);
+	dev_dbg(&hdac->hdac.dev, "cvt nid %d stream %d format 0x%x\n",
+			cvt_nid, stream_tag, format);
 
 	val = (stream_tag << 4);
 
@@ -409,9 +444,10 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 }
 
 static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
-		struct hdac_hdmi_dai_port_map *dai_map, unsigned int pwr_state)
+	    struct hdac_hdmi_cvt *cvt, struct hdac_hdmi_port *port,
+	    unsigned int pwr_state)
 {
-	struct hdac_hdmi_pin *pin = dai_map->port->pin;
+	struct hdac_hdmi_pin *pin = port->pin;
 
 	/* Power up pin widget */
 	if (!snd_hdac_check_power_state(&edev->hdac, pin->nid,
@@ -420,9 +456,9 @@ static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
 			AC_VERB_SET_POWER_STATE, pwr_state);
 
 	/* Power up converter */
-	if (!snd_hdac_check_power_state(&edev->hdac, dai_map->cvt->nid,
+	if (!snd_hdac_check_power_state(&edev->hdac, cvt->nid,
 						pwr_state))
-		snd_hdac_codec_write(&edev->hdac, dai_map->cvt->nid, 0,
+		snd_hdac_codec_write(&edev->hdac, cvt->nid, 0,
 			AC_VERB_SET_POWER_STATE, pwr_state);
 }
 
@@ -438,7 +474,6 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	int ret;
 
 	dai_map = &hdmi->dai_map[dai->id];
-	port = dai_map->port;
 
 	dd = (struct hdac_ext_dma_params *)snd_soc_dai_get_dma_data(dai, substream);
 	dev_dbg(&hdac->hdac.dev, "stream tag from cpu dai %d format in cvt 0x%x\n",
@@ -450,21 +485,30 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	if (!pcm)
 		return -EIO;
 
-	mutex_lock(&pcm->lock);
-	ret = hdac_hdmi_enable_pin(hdac, dai_map);
-	if (ret < 0)
-		return ret;
+	if (list_empty(&pcm->port_list))
+		return -EIO;
 
-	port->channels = substream->runtime->channels;
+	mutex_lock(&pcm->lock);
+	list_for_each_entry(port, &pcm->port_list, head) {
+		if (port->is_connected) {
+			ret = hdac_hdmi_enable_pin(hdac, port, dai_map->cvt);
+			if (ret < 0) {
+				mutex_unlock(&pcm->lock);
+				return ret;
+			}
+			port->channels = substream->runtime->channels;
 
-	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt->nid,
+			ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt->nid,
 						port->pin->nid, port);
+			if (ret < 0) {
+				mutex_unlock(&pcm->lock);
+				return ret;
+			}
+		}
+	}
 	mutex_unlock(&pcm->lock);
-	if (ret < 0)
-		return ret;
 
-	return hdac_hdmi_setup_stream(hdac, dai_map->cvt->nid,
-			port->pin->nid, dd->stream_tag, dd->format);
+	return hdac_hdmi_setup_stream(hdac, dai_map->cvt->nid, dd->stream_tag, dd->format);
 }
 
 static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
@@ -538,17 +582,16 @@ static void hdac_hdmi_enable_cvt(struct hdac_ext_device *edev,
 }
 
 static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
-		struct hdac_hdmi_dai_port_map *dai_map)
+	struct hdac_hdmi_port *port, struct hdac_hdmi_cvt *cvt)
 {
 	int mux_idx;
-	struct hdac_hdmi_port *port = dai_map->port;
 
 	/* set the device if pin is mst_capable */
 	if (hdac_hdmi_port_select_set(hdac, port) < 0)
 		return -EIO;
 
 	for (mux_idx = 0; mux_idx < port->num_mux_nids; mux_idx++) {
-		if (port->mux_nids[mux_idx] == dai_map->cvt->nid) {
+		if (port->mux_nids[mux_idx] == cvt->nid) {
 			snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
 					AC_VERB_SET_CONNECT_SEL, mux_idx);
 			break;
@@ -562,7 +605,7 @@ static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
 	snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
-	hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D0);
+	hdac_hdmi_set_power_state(hdac, cvt, port, AC_PWRST_D0);
 
 	snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
 			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
@@ -614,30 +657,33 @@ static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 			struct hdac_hdmi_cvt *cvt)
 {
 	struct hdac_hdmi_pcm *pcm;
-	struct hdac_hdmi_port *port = NULL;
+	struct hdac_hdmi_port *port = NULL, *valid_port = NULL;
 	int ret, i;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
 		if (pcm->cvt == cvt) {
-			port = pcm->port;
-			break;
-		}
-	}
+			if (list_empty(&pcm->port_list))
+				continue;
 
-	if (port) {
-		mutex_lock(&pcm->lock);
-		ret = hdac_hdmi_query_port_connlist(edev, port->pin, port);
-		mutex_unlock(&pcm->lock);
+			list_for_each_entry(port, &pcm->port_list, head) {
+				mutex_lock(&pcm->lock);
+				ret = hdac_hdmi_query_port_connlist(edev, port->pin, port);
+				mutex_unlock(&pcm->lock);
 
-		if (ret < 0)
-			return NULL;
+				if (ret < 0)
+					return NULL;
 
-		for (i = 0; i < port->num_mux_nids; i++) {
-			if (port->mux_nids[i] == cvt->nid)
-				return port;
+				for (i = 0; i < port->num_mux_nids; i++) {
+					if (port->mux_nids[i] == cvt->nid)
+						valid_port = port;
+				}
+			}
 		}
 	}
 
+	if (valid_port)
+		return valid_port;
+
 	return NULL;
 }
 
@@ -667,7 +713,6 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	 */
 	if (!port)
 		return 0;
-
 	if ((!port->eld.monitor_present) ||
 			(!port->eld.eld_valid)) {
 
@@ -693,19 +738,10 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 static int hdac_hdmi_trigger(struct snd_pcm_substream *substream, int cmd,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_hdmi_dai_port_map *dai_map;
-	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdac->private_data;
-	int ret;
-
-	dai_map = &hdmi->dai_map[dai->id];
-	if (cmd == SNDRV_PCM_TRIGGER_RESUME) {
-		ret = hdac_hdmi_enable_pin(hdac, dai_map);
-		if (ret < 0)
-			return ret;
 
+	if (cmd == SNDRV_PCM_TRIGGER_RESUME)
 		return hdac_hdmi_playback_prepare(substream, dai);
-	}
+
 
 	return 0;
 }
@@ -718,32 +754,39 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_port *port;
 	struct hdac_hdmi_pcm *pcm;
+	struct hdac_hdmi_cvt *cvt;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
 	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, dai_map->cvt);
 
+	cvt = dai_map->cvt;
+
 	if (dai_map->port && pcm) {
-		port = dai_map->port;
 		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_CHANNEL_STREAMID, 0);
 		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_STREAM_FORMAT, 0);
 
-		mutex_lock(&pcm->lock);
-		/* set the device if pin is mst_capable */
-		if (!hdac_hdmi_port_select_set(hdac, port)) {
-			hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
+		if (!list_empty(&pcm->port_list)) {
+			mutex_lock(&pcm->lock);
+			list_for_each_entry(port, &pcm->port_list, head) {
+				/* set the device if pin is mst_capable */
+				if (!hdac_hdmi_port_select_set(hdac, port)) {
+					hdac_hdmi_set_power_state(hdac, cvt, port,
+								  AC_PWRST_D3);
 
-			snd_hdac_codec_write(&hdac->hdac, dai_map->port->pin->nid, 0,
-				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
-		}
-		dai_map->port->chmap_set = false;
-		memset(dai_map->port->chmap, 0, sizeof(dai_map->port->chmap));
-		dai_map->port->channels = 0;
-		mutex_unlock(&pcm->lock);
+					snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
+						AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+				}
 
-		dai_map->port = NULL;
+				port->chmap_set = false;
+				memset(port->chmap, 0, sizeof(port->chmap));
+				port->channels = 0;
+				dai_map->port = NULL;
+			}
+			mutex_unlock(&pcm->lock);
+		}
 	}
 }
 
@@ -813,13 +856,16 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
 {
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = NULL;
+	struct hdac_hdmi_port *p;
 
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
-		if (!pcm->port)
+		if (list_empty(&pcm->port_list))
 			continue;
 
-		if (pcm->port == port)
-			return pcm;
+		list_for_each_entry(p, &pcm->port_list, head) {
+			if (p->id == port->id && port->pin == p->pin)
+				return pcm;
+		}
 	}
 
 	return NULL;
@@ -832,6 +878,7 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	int ret;
+	struct hdac_hdmi_port *p, *p_next;
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
 	struct snd_soc_dapm_context *dapm = w->dapm;
@@ -850,25 +897,30 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&hdmi->pin_mutex);
 	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
-		if (!pcm->port && pcm->port == port &&
-			pcm->port->id == port->id)
-			pcm->port = NULL;
+		if (list_empty(&pcm->port_list))
+			continue;
 
-		/*
-		 * Jack status is not reported during device probe as the
-		 * PCMs are not registered by then. So report it here.
-		 */
-		if (!strcmp(cvt_name, pcm->cvt->name) && !pcm->port) {
-			pcm->port = port;
-			if (port->eld.monitor_present && port->eld.eld_valid) {
-				dev_dbg(&edev->hdac.dev,
-					"jack report for pcm=%d\n",
-					pcm->pcm_id);
+		list_for_each_entry_safe(p, p_next, &pcm->port_list, head) {
+			if (p == port && p->id == port->id &&
+					p->pin == port->pin) {
+				hdac_hdmi_jack_report(pcm, port, false);
+				list_del(&p->head);
+			}
+		}
+	}
 
-				snd_jack_report(pcm->jack, SND_JACK_AVOUT);
+	/*
+	 * Jack status is not reported during device probe as the
+	 * PCMs are not registered by then. So report it here.
+	 */
+	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
+		if (!strcmp(cvt_name, pcm->cvt->name)) {
+			list_add_tail(&port->head, &pcm->port_list);
+			if (port->eld.monitor_present && port->eld.eld_valid) {
+				hdac_hdmi_jack_report(pcm, port, true);
+				mutex_unlock(&hdmi->pin_mutex);
+				return ret;
 			}
-			mutex_unlock(&hdmi->pin_mutex);
-			return ret;
 		}
 	}
 	mutex_unlock(&hdmi->pin_mutex);
@@ -1209,25 +1261,16 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 		 * report jack here. It will be done in usermode mux
 		 * control select.
 		 */
-		if (pcm) {
-			dev_dbg(&edev->hdac.dev,
-				"jack report for pcm=%d\n", pcm->pcm_id);
-
-			snd_jack_report(pcm->jack, 0);
-		}
+		if (pcm)
+			hdac_hdmi_jack_report(pcm, port, false);
 
 		mutex_unlock(&hdmi->pin_mutex);
 		return;
 	}
 
 	if (port->eld.monitor_present && port->eld.eld_valid) {
-		if (pcm) {
-			dev_dbg(&edev->hdac.dev,
-				"jack report for pcm=%d\n",
-				pcm->pcm_id);
-
-			snd_jack_report(pcm->jack, SND_JACK_AVOUT);
-		}
+		if (pcm)
+			hdac_hdmi_jack_report(pcm, port, true);
 
 		print_hex_dump_debug("ELD: ", DUMP_PREFIX_OFFSET, 16, 1,
 			  port->eld.eld_buffer, port->eld.eld_size, false);
@@ -1551,8 +1594,9 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 		return -ENOMEM;
 	pcm->pcm_id = device;
 	pcm->cvt = hdmi->dai_map[dai->id].cvt;
+	pcm->jack_event = 0;
 	mutex_init(&pcm->lock);
-
+	INIT_LIST_HEAD(&pcm->port_list);
 	snd_pcm = hdac_hdmi_get_pcm_from_id(dai->component->card, device);
 	if (snd_pcm) {
 		err = snd_hdac_add_chmap_ctls(snd_pcm, device, &hdmi->chmap);
@@ -1610,6 +1654,11 @@ static int hdmi_codec_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
+	/* FIXME
+	 * At boot driver does not know if the port is mst capable, to get
+	 * the ELD, i915 acomp API expects to pass pipe id as -1 when the
+	 * port is non mst.
+	 */
 	list_for_each_entry(pin, &hdmi->pin_list, head)
 		for (i = 0; i < pin->num_ports; i++)
 			hdac_hdmi_present_sense(pin, &pin->ports[i]);
@@ -1700,13 +1749,15 @@ static void hdac_hdmi_get_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_port *port = pcm->port;
+	struct hdac_hdmi_port *port;
 
-	/* chmap is already set to 0 in caller */
-	if (!port)
+	if (list_empty(&pcm->port_list))
 		return;
 
-	memcpy(chmap, port->chmap, ARRAY_SIZE(port->chmap));
+	list_for_each_entry(port, &pcm->port_list, head) {
+		/* chmap is already set to 0 in caller */
+		memcpy(chmap, port->chmap, ARRAY_SIZE(port->chmap));
+	}
 }
 
 static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
@@ -1715,16 +1766,20 @@ static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_port *port = pcm->port;
-	struct hdac_hdmi_pin *pin = port->pin;
+	struct hdac_hdmi_port *port;
+
+	if (list_empty(&pcm->port_list))
+		return;
 
 	if (pcm) {
 		mutex_lock(&pcm->lock);
-		port->chmap_set = true;
-		memcpy(port->chmap, chmap, ARRAY_SIZE(port->chmap));
-		if (prepared)
-			hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid,
-							pin->nid, port);
+		list_for_each_entry(port, &pcm->port_list, head) {
+			port->chmap_set = true;
+			memcpy(port->chmap, chmap, ARRAY_SIZE(port->chmap));
+			if (prepared)
+				hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid,
+								port->pin->nid, port);
+		}
 		mutex_unlock(&pcm->lock);
 	}
 }
@@ -1734,9 +1789,11 @@ static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_port *port = pcm->port;
 
-	return port ? true:false;
+	if (list_empty(&pcm->port_list))
+		return false;
+
+	return true;
 }
 
 static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
@@ -1744,7 +1801,15 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdac, int pcm_idx)
 	struct hdac_ext_device *edev = to_ehdac_device(hdac);
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
-	struct hdac_hdmi_port *port = pcm->port;
+	struct hdac_hdmi_port *port;
+
+	if (list_empty(&pcm->port_list))
+		return 0;
+
+	port = list_first_entry(&pcm->port_list, struct hdac_hdmi_port, head);
+
+	if (!port)
+		return 0;
 
 	if (!port || !port->eld.eld_valid)
 		return 0;
@@ -1822,13 +1887,19 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 	struct hdac_hdmi_pin *pin, *pin_next;
 	struct hdac_hdmi_cvt *cvt, *cvt_next;
 	struct hdac_hdmi_pcm *pcm, *pcm_next;
+	struct hdac_hdmi_port *port;
 	int i;
 
 	snd_soc_unregister_codec(&edev->hdac.dev);
 
 	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
 		pcm->cvt = NULL;
-		pcm->port = NULL;
+		if (list_empty(&pcm->port_list))
+			continue;
+
+		list_for_each_entry(port, &pcm->port_list, head)
+			port = NULL;
+
 		list_del(&pcm->head);
 		kfree(pcm);
 	}
-- 
2.5.0
