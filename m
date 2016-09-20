From: jeeja.kp@intel.com
Subject: [RFC 10/16] ASoc: hdac_hdmi: Configure pin verbs for
	MST
Date: Tue, 20 Sep 2016 19:16:14 +0530
Message-ID: <1474379180-7132-11-git-send-email-jeeja.kp@intel.com>
References: <1474379180-7132-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id ED5922666AA
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 15:38:11 +0200 (CEST)
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

To enable stream on to specific port which is MST capable pin, before
configuring the pin widget verb, Port need to be selected.

When Port is selected, all the Pin widget verb controlling the sink
device operation will be directed to selected port. So add port
selection before configuring the pin widget verb.

Since the port select can change between pcm, need to protect the
selection of port and the configuration of pin widget verb. So moved
the port lock to pcm lock.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 80 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index d99eb9c..618af31 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -93,7 +93,6 @@ struct hdac_hdmi_port {
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
 	struct hdac_hdmi_eld eld;
-	struct mutex lock;
 	bool chmap_set;
 	unsigned char chmap[8]; /* ALSA API channel-map */
 	int channels; /* current number of channels */
@@ -101,6 +100,7 @@ struct hdac_hdmi_port {
 
 struct hdac_hdmi_pcm {
 	struct list_head head;
+	struct mutex lock;
 	int pcm_id;
 	struct hdac_hdmi_port *port;
 	struct hdac_hdmi_cvt *cvt;
@@ -125,6 +125,20 @@ struct hdac_hdmi_priv {
 	struct hdac_chmap chmap;
 };
 
+static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm_from_cvt(
+			struct hdac_hdmi_priv *hdmi,
+			struct hdac_hdmi_cvt *cvt)
+{
+	struct hdac_hdmi_pcm *pcm = NULL;
+
+	list_for_each_entry(pcm, &hdmi->pcm_list, head) {
+		if (pcm->cvt == cvt)
+			break;
+	}
+
+	return pcm;
+}
+
 /* MST supported verbs */
 /*
  * Get the no devices that can be connected to a port on the Pin widget.
@@ -323,6 +337,9 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *hdac,
 			break;
 	}
 
+	if (hdac_hdmi_port_select_set(hdac, port) < 0)
+		return -EIO;
+
 	ca = snd_hdac_channel_allocation(&hdac->hdac, port->eld.info.spk_alloc,
 			port->channels, port->chmap_set, true, port->chmap);
 
@@ -416,6 +433,7 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_pcm *pcm;
 	struct hdac_ext_dma_params *dd;
 	int ret;
 
@@ -427,16 +445,21 @@ static int hdac_hdmi_playback_prepare(struct snd_pcm_substream *substream,
 			dd->stream_tag,	dd->format);
 
 	hdac_hdmi_enable_cvt(hdac, dai_map);
+	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, dai_map->cvt);
+
+	if (!pcm)
+		return -EIO;
+
+	mutex_lock(&pcm->lock);
 	ret = hdac_hdmi_enable_pin(hdac, dai_map);
 	if (ret < 0)
 		return ret;
 
-	mutex_lock(&port->lock);
 	port->channels = substream->runtime->channels;
 
 	ret = hdac_hdmi_setup_audio_infoframe(hdac, dai_map->cvt->nid,
 						port->pin->nid, port);
-	mutex_unlock(&port->lock);
+	mutex_unlock(&pcm->lock);
 	if (ret < 0)
 		return ret;
 
@@ -520,6 +543,10 @@ static int hdac_hdmi_enable_pin(struct hdac_ext_device *hdac,
 	int mux_idx;
 	struct hdac_hdmi_port *port = dai_map->port;
 
+	/* set the device if pin is mst_capable */
+	if (hdac_hdmi_port_select_set(hdac, port) < 0)
+		return -EIO;
+
 	for (mux_idx = 0; mux_idx < port->num_mux_nids; mux_idx++) {
 		if (port->mux_nids[mux_idx] == dai_map->cvt->nid) {
 			snd_hdac_codec_write(&hdac->hdac, port->pin->nid, 0,
@@ -547,6 +574,11 @@ static int hdac_hdmi_query_port_connlist(struct hdac_ext_device *hdac,
 					struct hdac_hdmi_pin *pin,
 					struct hdac_hdmi_port *port)
 {
+
+	/* set the device if pin is mst_capable */
+	if (hdac_hdmi_port_select_set(hdac, port) < 0)
+		return -EIO;
+
 	if (!(get_wcaps(&hdac->hdac, pin->nid) & AC_WCAP_CONN_LIST)) {
 		dev_warn(&hdac->hdac.dev,
 			"HDMI: pin %d wcaps %#x does not support connection list\n",
@@ -593,7 +625,10 @@ static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 	}
 
 	if (port) {
+		mutex_lock(&pcm->lock);
 		ret = hdac_hdmi_query_port_connlist(edev, port->pin, port);
+		mutex_unlock(&pcm->lock);
+
 		if (ret < 0)
 			return NULL;
 
@@ -681,25 +716,32 @@ static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 	struct hdac_ext_device *hdac = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_priv *hdmi = hdac->private_data;
 	struct hdac_hdmi_dai_port_map *dai_map;
+	struct hdac_hdmi_port *port;
+	struct hdac_hdmi_pcm *pcm;
 
 	dai_map = &hdmi->dai_map[dai->id];
 
-	if (dai_map->port) {
+	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, dai_map->cvt);
+
+	if (dai_map->port && pcm) {
+		port = dai_map->port;
 		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_CHANNEL_STREAMID, 0);
 		snd_hdac_codec_write(&hdac->hdac, dai_map->cvt->nid, 0,
 				AC_VERB_SET_STREAM_FORMAT, 0);
 
-		hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
-
-		snd_hdac_codec_write(&hdac->hdac, dai_map->port->pin->nid, 0,
-			AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		mutex_lock(&pcm->lock);
+		/* set the device if pin is mst_capable */
+		if (!hdac_hdmi_port_select_set(hdac, port)) {
+			hdac_hdmi_set_power_state(hdac, dai_map, AC_PWRST_D3);
 
-		mutex_lock(&dai_map->port->lock);
+			snd_hdac_codec_write(&hdac->hdac, dai_map->port->pin->nid, 0,
+				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+		}
 		dai_map->port->chmap_set = false;
 		memset(dai_map->port->chmap, 0, sizeof(dai_map->port->chmap));
 		dai_map->port->channels = 0;
-		mutex_unlock(&dai_map->port->lock);
+		mutex_unlock(&pcm->lock);
 
 		dai_map->port = NULL;
 	}
@@ -1209,7 +1251,6 @@ static int hdac_hdmi_add_ports(struct hdac_hdmi_priv *hdmi,
 	for (i=0; i < max_ports; i++) {
 		ports[i].id = i + 1;
 		ports[i].pin = pin;
-		mutex_init(&ports[i].lock);
 	}
 	pin->ports = ports;
 	pin->num_ports = max_ports;
@@ -1510,6 +1551,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device)
 		return -ENOMEM;
 	pcm->pcm_id = device;
 	pcm->cvt = hdmi->dai_map[dai->id].cvt;
+	mutex_init(&pcm->lock);
 
 	snd_pcm = hdac_hdmi_get_pcm_from_id(dai->component->card, device);
 	if (snd_pcm) {
@@ -1676,13 +1718,15 @@ static void hdac_hdmi_set_chmap(struct hdac_device *hdac, int pcm_idx,
 	struct hdac_hdmi_port *port = pcm->port;
 	struct hdac_hdmi_pin *pin = port->pin;
 
-	mutex_lock(&port->lock);
-	port->chmap_set = true;
-	memcpy(port->chmap, chmap, ARRAY_SIZE(port->chmap));
-	if (prepared)
-		hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid,
-						pin->nid, port);
-	mutex_unlock(&port->lock);
+	if (pcm) {
+		mutex_lock(&pcm->lock);
+		port->chmap_set = true;
+		memcpy(port->chmap, chmap, ARRAY_SIZE(port->chmap));
+		if (prepared)
+			hdac_hdmi_setup_audio_infoframe(edev, pcm->cvt->nid,
+							pin->nid, port);
+		mutex_unlock(&pcm->lock);
+	}
 }
 
 static bool is_hdac_hdmi_pcm_attached(struct hdac_device *hdac, int pcm_idx)
-- 
2.5.0
