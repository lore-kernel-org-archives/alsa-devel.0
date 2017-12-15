From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC v3 1/3] ALSA: hdac: Remove usage of struct
	hdac_ext_device and use hdac_device instead
Date: Fri, 15 Dec 2017 16:59:58 +0530
Message-ID: <1513337400-19124-2-git-send-email-rakesh.a.ughreja@intel.com>
References: <1513337400-19124-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AAD1266E71
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:25:23 +0100 (CET)
In-Reply-To: <1513337400-19124-1-git-send-email-rakesh.a.ughreja@intel.com>
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

This patch removes the hdac_ext_device structure. The legacy and
enhanced HDaudio capabilities can be handled in a backwards-compatible
way without separate definitions.

Follow-up patches in this series handle the bus and driver definitions.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 include/sound/hdaudio_ext.h  |  36 +---
 sound/hda/ext/hdac_ext_bus.c |  25 ++-
 sound/soc/codecs/hdac_hdmi.c | 395 +++++++++++++++++++++----------------------
 3 files changed, 204 insertions(+), 252 deletions(-)

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 9c14e21..c1a5ad0 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -181,48 +181,20 @@ struct hda_dai_map {
 	u32	maxbps;
 };
 
-#define HDA_MAX_NIDS 16
-
-/**
- * struct hdac_ext_device - HDAC Ext device
- *
- * @hdac: hdac core device
- * @nid_list - the dai map which matches the dai-name with the nid
- * @map_cur_idx - the idx in use in dai_map
- * @ops - the hda codec ops common to all codec drivers
- * @pvt_data - private data, for asoc contains asoc codec object
- */
-struct hdac_ext_device {
-	struct hdac_device hdev;
-	struct hdac_ext_bus *ebus;
-
-	/* soc-dai to nid map */
-	struct hda_dai_map nid_list[HDA_MAX_NIDS];
-	unsigned int map_cur_idx;
-
-	/* codec ops */
-	struct hdac_ext_codec_ops ops;
-
-	struct snd_card *card;
-	void *scodec;
-	void *private_data;
-};
-
 struct hdac_ext_dma_params {
 	u32 format;
 	u8 stream_tag;
 };
-#define to_ehdac_device(dev) (container_of((dev), \
-				 struct hdac_ext_device, hdev))
+
 /*
  * HD-audio codec base driver
  */
 struct hdac_ext_driver {
 	struct hdac_driver hdac;
 
-	int	(*probe)(struct hdac_ext_device *dev);
-	int	(*remove)(struct hdac_ext_device *dev);
-	void	(*shutdown)(struct hdac_ext_device *dev);
+	int	(*probe)(struct hdac_device *dev);
+	int	(*remove)(struct hdac_device *dev);
+	void	(*shutdown)(struct hdac_device *dev);
 };
 
 int snd_hda_ext_driver_register(struct hdac_ext_driver *drv);
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index 0daf313..0e4823f 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -137,17 +137,16 @@ static void default_release(struct device *dev)
  */
 int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *ebus, int addr)
 {
-	struct hdac_ext_device *edev;
 	struct hdac_device *hdev = NULL;
 	struct hdac_bus *bus = ebus_to_hbus(ebus);
 	char name[15];
 	int ret;
 
-	edev = kzalloc(sizeof(*edev), GFP_KERNEL);
-	if (!edev)
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
 		return -ENOMEM;
-	hdev = &edev->hdev;
-	edev->ebus = ebus;
+
+	hdev->bus = bus;
 
 	snprintf(name, sizeof(name), "ehdaudio%dD%d", ebus->idx, addr);
 
@@ -176,10 +175,8 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_init);
  */
 void snd_hdac_ext_bus_device_exit(struct hdac_device *hdev)
 {
-	struct hdac_ext_device *edev = to_ehdac_device(hdev);
-
 	snd_hdac_device_exit(hdev);
-	kfree(edev);
+	kfree(hdev);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_device_exit);
 
@@ -212,27 +209,25 @@ static inline struct hdac_ext_driver *get_edrv(struct device *dev)
 	return edrv;
 }
 
-static inline struct hdac_ext_device *get_edev(struct device *dev)
+static inline struct hdac_device *get_hdev(struct device *dev)
 {
 	struct hdac_device *hdev = dev_to_hdac_dev(dev);
-	struct hdac_ext_device *edev = to_ehdac_device(hdev);
-
-	return edev;
+	return hdev;
 }
 
 static int hda_ext_drv_probe(struct device *dev)
 {
-	return (get_edrv(dev))->probe(get_edev(dev));
+	return (get_edrv(dev))->probe(get_hdev(dev));
 }
 
 static int hdac_ext_drv_remove(struct device *dev)
 {
-	return (get_edrv(dev))->remove(get_edev(dev));
+	return (get_edrv(dev))->remove(get_hdev(dev));
 }
 
 static void hdac_ext_drv_shutdown(struct device *dev)
 {
-	return (get_edrv(dev))->shutdown(get_edev(dev));
+	return (get_edrv(dev))->shutdown(get_hdev(dev));
 }
 
 /**
diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 68a4a6b..a0a3efb 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -85,7 +85,7 @@ struct hdac_hdmi_pin {
 	bool mst_capable;
 	struct hdac_hdmi_port *ports;
 	int num_ports;
-	struct hdac_ext_device *edev;
+	struct hdac_device *hdev;
 };
 
 struct hdac_hdmi_port {
@@ -126,6 +126,9 @@ struct hdac_hdmi_drv_data {
 };
 
 struct hdac_hdmi_priv {
+	struct hdac_device *hdev;
+	struct snd_soc_codec *scodec;
+	struct snd_card *card;
 	struct hdac_hdmi_dai_port_map dai_map[HDA_MAX_CVTS];
 	struct list_head pin_list;
 	struct list_head cvt_list;
@@ -138,7 +141,7 @@ struct hdac_hdmi_priv {
 	struct hdac_hdmi_drv_data *drv_data;
 };
 
-#define hdev_to_hdmi_priv(_hdev) ((to_ehdac_device(_hdev))->private_data)
+#define hdev_to_hdmi_priv(_hdev) dev_get_drvdata(&_hdev->dev)
 
 static struct hdac_hdmi_pcm *
 hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
@@ -157,7 +160,7 @@ hdac_hdmi_get_pcm_from_cvt(struct hdac_hdmi_priv *hdmi,
 static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		struct hdac_hdmi_port *port, bool is_connect)
 {
-	struct hdac_ext_device *edev = port->pin->edev;
+	struct hdac_device *hdev = port->pin->hdev;
 
 	if (is_connect)
 		snd_soc_dapm_enable_pin(port->dapm, port->jack_pin);
@@ -171,7 +174,7 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 		 * ports.
 		 */
 		if (pcm->jack_event == 0) {
-			dev_dbg(&edev->hdev.dev,
+			dev_dbg(&hdev->dev,
 					"jack report for pcm=%d\n",
 					pcm->pcm_id);
 			snd_soc_jack_report(pcm->jack, SND_JACK_AVOUT,
@@ -197,19 +200,18 @@ static void hdac_hdmi_jack_report(struct hdac_hdmi_pcm *pcm,
 /*
  * Get the no devices that can be connected to a port on the Pin widget.
  */
-static int hdac_hdmi_get_port_len(struct hdac_ext_device *edev, hda_nid_t nid)
+static int hdac_hdmi_get_port_len(struct hdac_device *hdev, hda_nid_t nid)
 {
 	unsigned int caps;
 	unsigned int type, param;
 
-	caps = get_wcaps(&edev->hdev, nid);
+	caps = get_wcaps(hdev, nid);
 	type = get_wcaps_type(caps);
 
 	if (!(caps & AC_WCAP_DIGITAL) || (type != AC_WID_PIN))
 		return 0;
 
-	param = snd_hdac_read_parm_uncached(&edev->hdev, nid,
-					AC_PAR_DEVLIST_LEN);
+	param = snd_hdac_read_parm_uncached(hdev, nid, AC_PAR_DEVLIST_LEN);
 	if (param == -1)
 		return param;
 
@@ -221,10 +223,10 @@ static int hdac_hdmi_get_port_len(struct hdac_ext_device *edev, hda_nid_t nid)
  * id selected on the pin. Return 0 means the first port entry
  * is selected or MST is not supported.
  */
-static int hdac_hdmi_port_select_get(struct hdac_ext_device *edev,
+static int hdac_hdmi_port_select_get(struct hdac_device *hdev,
 					struct hdac_hdmi_port *port)
 {
-	return snd_hdac_codec_read(&edev->hdev, port->pin->nid,
+	return snd_hdac_codec_read(hdev, port->pin->nid,
 				0, AC_VERB_GET_DEVICE_SEL, 0);
 }
 
@@ -232,7 +234,7 @@ static int hdac_hdmi_port_select_get(struct hdac_ext_device *edev,
  * Sets the selected port entry for the configuring Pin widget verb.
  * returns error if port set is not equal to port get otherwise success
  */
-static int hdac_hdmi_port_select_set(struct hdac_ext_device *edev,
+static int hdac_hdmi_port_select_set(struct hdac_device *hdev,
 					struct hdac_hdmi_port *port)
 {
 	int num_ports;
@@ -241,8 +243,7 @@ static int hdac_hdmi_port_select_set(struct hdac_ext_device *edev,
 		return 0;
 
 	/* AC_PAR_DEVLIST_LEN is 0 based. */
-	num_ports = hdac_hdmi_get_port_len(edev, port->pin->nid);
-
+	num_ports = hdac_hdmi_get_port_len(hdev, port->pin->nid);
 	if (num_ports < 0)
 		return -EIO;
 	/*
@@ -252,13 +253,13 @@ static int hdac_hdmi_port_select_set(struct hdac_ext_device *edev,
 	if (num_ports + 1  < port->id)
 		return 0;
 
-	snd_hdac_codec_write(&edev->hdev, port->pin->nid, 0,
+	snd_hdac_codec_write(hdev, port->pin->nid, 0,
 			AC_VERB_SET_DEVICE_SEL, port->id);
 
-	if (port->id != hdac_hdmi_port_select_get(edev, port))
+	if (port->id != hdac_hdmi_port_select_get(hdev, port))
 		return -EIO;
 
-	dev_dbg(&edev->hdev.dev, "Selected the port=%d\n", port->id);
+	dev_dbg(&hdev->dev, "Selected the port=%d\n", port->id);
 
 	return 0;
 }
@@ -276,13 +277,6 @@ static struct hdac_hdmi_pcm *get_hdmi_pcm_from_id(struct hdac_hdmi_priv *hdmi,
 	return NULL;
 }
 
-static inline struct hdac_ext_device *to_hda_ext_device(struct device *dev)
-{
-	struct hdac_device *hdev = dev_to_hdac_dev(dev);
-
-	return to_ehdac_device(hdev);
-}
-
 static unsigned int sad_format(const u8 *sad)
 {
 	return ((sad[0] >> 0x3) & 0x1f);
@@ -323,15 +317,13 @@ static int hdac_hdmi_eld_limit_formats(struct snd_pcm_runtime *runtime,
 }
 
 static void
-hdac_hdmi_set_dip_index(struct hdac_ext_device *edev, hda_nid_t pin_nid,
+hdac_hdmi_set_dip_index(struct hdac_device *hdev, hda_nid_t pin_nid,
 				int packet_index, int byte_index)
 {
 	int val;
 
 	val = (packet_index << 5) | (byte_index & 0x1f);
-
-	snd_hdac_codec_write(&edev->hdev, pin_nid, 0,
-				AC_VERB_SET_HDMI_DIP_INDEX, val);
+	snd_hdac_codec_write(hdev, pin_nid, 0, AC_VERB_SET_HDMI_DIP_INDEX, val);
 }
 
 struct dp_audio_infoframe {
@@ -346,14 +338,14 @@ struct dp_audio_infoframe {
 	u8 LFEPBL01_LSV36_DM_INH7;
 };
 
-static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *edev,
+static int hdac_hdmi_setup_audio_infoframe(struct hdac_device *hdev,
 		   struct hdac_hdmi_pcm *pcm, struct hdac_hdmi_port *port)
 {
 	uint8_t buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AUDIO_INFOFRAME_SIZE];
 	struct hdmi_audio_infoframe frame;
 	struct hdac_hdmi_pin *pin = port->pin;
 	struct dp_audio_infoframe dp_ai;
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_cvt *cvt = pcm->cvt;
 	u8 *dip;
 	int ret;
@@ -362,11 +354,11 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *edev,
 	u8 conn_type;
 	int channels, ca;
 
-	ca = snd_hdac_channel_allocation(&edev->hdev, port->eld.info.spk_alloc,
+	ca = snd_hdac_channel_allocation(hdev, port->eld.info.spk_alloc,
 			pcm->channels, pcm->chmap_set, true, pcm->chmap);
 
 	channels = snd_hdac_get_active_channels(ca);
-	hdmi->chmap.ops.set_channel_count(&edev->hdev, cvt->nid, channels);
+	hdmi->chmap.ops.set_channel_count(hdev, cvt->nid, channels);
 
 	snd_hdac_setup_channel_mapping(&hdmi->chmap, pin->nid, false, ca,
 				pcm->channels, pcm->chmap, pcm->chmap_set);
@@ -399,32 +391,31 @@ static int hdac_hdmi_setup_audio_infoframe(struct hdac_ext_device *edev,
 		break;
 
 	default:
-		dev_err(&edev->hdev.dev, "Invalid connection type: %d\n",
-						conn_type);
+		dev_err(&hdev->dev, "Invalid connection type: %d\n", conn_type);
 		return -EIO;
 	}
 
 	/* stop infoframe transmission */
-	hdac_hdmi_set_dip_index(edev, pin->nid, 0x0, 0x0);
-	snd_hdac_codec_write(&edev->hdev, pin->nid, 0,
+	hdac_hdmi_set_dip_index(hdev, pin->nid, 0x0, 0x0);
+	snd_hdac_codec_write(hdev, pin->nid, 0,
 			AC_VERB_SET_HDMI_DIP_XMIT, AC_DIPXMIT_DISABLE);
 
 
 	/*  Fill infoframe. Index auto-incremented */
-	hdac_hdmi_set_dip_index(edev, pin->nid, 0x0, 0x0);
+	hdac_hdmi_set_dip_index(hdev, pin->nid, 0x0, 0x0);
 	if (conn_type == DRM_ELD_CONN_TYPE_HDMI) {
 		for (i = 0; i < sizeof(buffer); i++)
-			snd_hdac_codec_write(&edev->hdev, pin->nid, 0,
+			snd_hdac_codec_write(hdev, pin->nid, 0,
 				AC_VERB_SET_HDMI_DIP_DATA, buffer[i]);
 	} else {
 		for (i = 0; i < sizeof(dp_ai); i++)
-			snd_hdac_codec_write(&edev->hdev, pin->nid, 0,
+			snd_hdac_codec_write(hdev, pin->nid, 0,
 				AC_VERB_SET_HDMI_DIP_DATA, dip[i]);
 	}
 
 	/* Start infoframe */
-	hdac_hdmi_set_dip_index(edev, pin->nid, 0x0, 0x0);
-	snd_hdac_codec_write(&edev->hdev, pin->nid, 0,
+	hdac_hdmi_set_dip_index(hdev, pin->nid, 0x0, 0x0);
+	snd_hdac_codec_write(hdev, pin->nid, 0,
 			AC_VERB_SET_HDMI_DIP_XMIT, AC_DIPXMIT_BEST);
 
 	return 0;
@@ -434,12 +425,12 @@ static int hdac_hdmi_set_tdm_slot(struct snd_soc_dai *dai,
 		unsigned int tx_mask, unsigned int rx_mask,
 		int slots, int slot_width)
 {
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = hdmi->hdev;
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_pcm *pcm;
 
-	dev_dbg(&edev->hdev.dev, "%s: strm_tag: %d\n", __func__, tx_mask);
+	dev_dbg(&hdev->dev, "%s: strm_tag: %d\n", __func__, tx_mask);
 
 	dai_map = &hdmi->dai_map[dai->id];
 
@@ -454,8 +445,8 @@ static int hdac_hdmi_set_tdm_slot(struct snd_soc_dai *dai,
 static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 	struct snd_pcm_hw_params *hparams, struct snd_soc_dai *dai)
 {
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = hdmi->hdev;
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_port *port;
 	struct hdac_hdmi_pcm *pcm;
@@ -468,7 +459,7 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 		return -ENODEV;
 
 	if ((!port->eld.monitor_present) || (!port->eld.eld_valid)) {
-		dev_err(&edev->hdev.dev,
+		dev_err(&hdev->dev,
 			"device is not configured for this pin:port%d:%d\n",
 					port->pin->nid, port->id);
 		return -ENODEV;
@@ -488,28 +479,28 @@ static int hdac_hdmi_set_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int hdac_hdmi_query_port_connlist(struct hdac_ext_device *edev,
+static int hdac_hdmi_query_port_connlist(struct hdac_device *hdev,
 					struct hdac_hdmi_pin *pin,
 					struct hdac_hdmi_port *port)
 {
-	if (!(get_wcaps(&edev->hdev, pin->nid) & AC_WCAP_CONN_LIST)) {
-		dev_warn(&edev->hdev.dev,
+	if (!(get_wcaps(hdev, pin->nid) & AC_WCAP_CONN_LIST)) {
+		dev_warn(&hdev->dev,
 			"HDMI: pin %d wcaps %#x does not support connection list\n",
-			pin->nid, get_wcaps(&edev->hdev, pin->nid));
+			pin->nid, get_wcaps(hdev, pin->nid));
 		return -EINVAL;
 	}
 
-	if (hdac_hdmi_port_select_set(edev, port) < 0)
+	if (hdac_hdmi_port_select_set(hdev, port) < 0)
 		return -EIO;
 
-	port->num_mux_nids = snd_hdac_get_connections(&edev->hdev, pin->nid,
+	port->num_mux_nids = snd_hdac_get_connections(hdev, pin->nid,
 			port->mux_nids, HDA_MAX_CONNECTIONS);
 	if (port->num_mux_nids == 0)
-		dev_warn(&edev->hdev.dev,
+		dev_warn(&hdev->dev,
 			"No connections found for pin:port %d:%d\n",
 						pin->nid, port->id);
 
-	dev_dbg(&edev->hdev.dev, "num_mux_nids %d for pin:port %d:%d\n",
+	dev_dbg(&hdev->dev, "num_mux_nids %d for pin:port %d:%d\n",
 			port->num_mux_nids, pin->nid, port->id);
 
 	return port->num_mux_nids;
@@ -525,7 +516,7 @@ static int hdac_hdmi_query_port_connlist(struct hdac_ext_device *edev,
  * connected.
  */
 static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
-			struct hdac_ext_device *edev,
+			struct hdac_device *hdev,
 			struct hdac_hdmi_priv *hdmi,
 			struct hdac_hdmi_cvt *cvt)
 {
@@ -540,7 +531,7 @@ static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 
 			list_for_each_entry(port, &pcm->port_list, head) {
 				mutex_lock(&pcm->lock);
-				ret = hdac_hdmi_query_port_connlist(edev,
+				ret = hdac_hdmi_query_port_connlist(hdev,
 							port->pin, port);
 				mutex_unlock(&pcm->lock);
 				if (ret < 0)
@@ -567,8 +558,8 @@ static struct hdac_hdmi_port *hdac_hdmi_get_port_from_cvt(
 static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
+	struct hdac_device *hdev = hdmi->hdev;
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_cvt *cvt;
 	struct hdac_hdmi_port *port;
@@ -577,7 +568,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	dai_map = &hdmi->dai_map[dai->id];
 
 	cvt = dai_map->cvt;
-	port = hdac_hdmi_get_port_from_cvt(edev, hdmi, cvt);
+	port = hdac_hdmi_get_port_from_cvt(hdev, hdmi, cvt);
 
 	/*
 	 * To make PA and other userland happy.
@@ -588,7 +579,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 	if ((!port->eld.monitor_present) ||
 			(!port->eld.eld_valid)) {
 
-		dev_warn(&edev->hdev.dev,
+		dev_warn(&hdev->dev,
 			"Failed: present?:%d ELD valid?:%d pin:port: %d:%d\n",
 			port->eld.monitor_present, port->eld.eld_valid,
 			port->pin->nid, port->id);
@@ -610,8 +601,7 @@ static int hdac_hdmi_pcm_open(struct snd_pcm_substream *substream,
 static void hdac_hdmi_pcm_close(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *dai)
 {
-	struct hdac_ext_device *edev = snd_soc_dai_get_drvdata(dai);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_dai_get_drvdata(dai);
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_pcm *pcm;
 
@@ -694,10 +684,10 @@ static void hdac_hdmi_fill_route(struct snd_soc_dapm_route *route,
 	route->connected = handler;
 }
 
-static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
+static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_device *hdev,
 					struct hdac_hdmi_port *port)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm = NULL;
 	struct hdac_hdmi_port *p;
 
@@ -714,21 +704,21 @@ static struct hdac_hdmi_pcm *hdac_hdmi_get_pcm(struct hdac_ext_device *edev,
 	return NULL;
 }
 
-static void hdac_hdmi_set_power_state(struct hdac_ext_device *edev,
+static void hdac_hdmi_set_power_state(struct hdac_device *hdev,
 			     hda_nid_t nid, unsigned int pwr_state)
 {
-	if (get_wcaps(&edev->hdev, nid) & AC_WCAP_POWER) {
-		if (!snd_hdac_check_power_state(&edev->hdev, nid, pwr_state))
-			snd_hdac_codec_write(&edev->hdev, nid, 0,
+	if (get_wcaps(hdev, nid) & AC_WCAP_POWER) {
+		if (!snd_hdac_check_power_state(hdev, nid, pwr_state))
+			snd_hdac_codec_write(hdev, nid, 0,
 				AC_VERB_SET_POWER_STATE, pwr_state);
 	}
 }
 
-static void hdac_hdmi_set_amp(struct hdac_ext_device *edev,
+static void hdac_hdmi_set_amp(struct hdac_device *hdev,
 				   hda_nid_t nid, int val)
 {
-	if (get_wcaps(&edev->hdev, nid) & AC_WCAP_OUT_AMP)
-		snd_hdac_codec_write(&edev->hdev, nid, 0,
+	if (get_wcaps(hdev, nid) & AC_WCAP_OUT_AMP)
+		snd_hdac_codec_write(hdev, nid, 0,
 					AC_VERB_SET_AMP_GAIN_MUTE, val);
 }
 
@@ -737,40 +727,40 @@ static int hdac_hdmi_pin_output_widget_event(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *kc, int event)
 {
 	struct hdac_hdmi_port *port = w->priv;
-	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_device *hdev = dev_to_hdac_dev(w->dapm->dev);
 	struct hdac_hdmi_pcm *pcm;
 
-	dev_dbg(&edev->hdev.dev, "%s: widget: %s event: %x\n",
+	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
 			__func__, w->name, event);
 
-	pcm = hdac_hdmi_get_pcm(edev, port);
+	pcm = hdac_hdmi_get_pcm(hdev, port);
 	if (!pcm)
 		return -EIO;
 
 	/* set the device if pin is mst_capable */
-	if (hdac_hdmi_port_select_set(edev, port) < 0)
+	if (hdac_hdmi_port_select_set(hdev, port) < 0)
 		return -EIO;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		hdac_hdmi_set_power_state(edev, port->pin->nid, AC_PWRST_D0);
+		hdac_hdmi_set_power_state(hdev, port->pin->nid, AC_PWRST_D0);
 
 		/* Enable out path for this pin widget */
-		snd_hdac_codec_write(&edev->hdev, port->pin->nid, 0,
+		snd_hdac_codec_write(hdev, port->pin->nid, 0,
 				AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 
-		hdac_hdmi_set_amp(edev, port->pin->nid, AMP_OUT_UNMUTE);
+		hdac_hdmi_set_amp(hdev, port->pin->nid, AMP_OUT_UNMUTE);
 
-		return hdac_hdmi_setup_audio_infoframe(edev, pcm, port);
+		return hdac_hdmi_setup_audio_infoframe(hdev, pcm, port);
 
 	case SND_SOC_DAPM_POST_PMD:
-		hdac_hdmi_set_amp(edev, port->pin->nid, AMP_OUT_MUTE);
+		hdac_hdmi_set_amp(hdev, port->pin->nid, AMP_OUT_MUTE);
 
 		/* Disable out path for this pin widget */
-		snd_hdac_codec_write(&edev->hdev, port->pin->nid, 0,
+		snd_hdac_codec_write(hdev, port->pin->nid, 0,
 				AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
 
-		hdac_hdmi_set_power_state(edev, port->pin->nid, AC_PWRST_D3);
+		hdac_hdmi_set_power_state(hdev, port->pin->nid, AC_PWRST_D3);
 		break;
 
 	}
@@ -782,11 +772,11 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *kc, int event)
 {
 	struct hdac_hdmi_cvt *cvt = w->priv;
-	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_device *hdev = dev_to_hdac_dev(w->dapm->dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm;
 
-	dev_dbg(&edev->hdev.dev, "%s: widget: %s event: %x\n",
+	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
 			__func__, w->name, event);
 
 	pcm = hdac_hdmi_get_pcm_from_cvt(hdmi, cvt);
@@ -795,29 +785,29 @@ static int hdac_hdmi_cvt_output_widget_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		hdac_hdmi_set_power_state(edev, cvt->nid, AC_PWRST_D0);
+		hdac_hdmi_set_power_state(hdev, cvt->nid, AC_PWRST_D0);
 
 		/* Enable transmission */
-		snd_hdac_codec_write(&edev->hdev, cvt->nid, 0,
+		snd_hdac_codec_write(hdev, cvt->nid, 0,
 			AC_VERB_SET_DIGI_CONVERT_1, 1);
 
 		/* Category Code (CC) to zero */
-		snd_hdac_codec_write(&edev->hdev, cvt->nid, 0,
+		snd_hdac_codec_write(hdev, cvt->nid, 0,
 			AC_VERB_SET_DIGI_CONVERT_2, 0);
 
-		snd_hdac_codec_write(&edev->hdev, cvt->nid, 0,
+		snd_hdac_codec_write(hdev, cvt->nid, 0,
 				AC_VERB_SET_CHANNEL_STREAMID, pcm->stream_tag);
-		snd_hdac_codec_write(&edev->hdev, cvt->nid, 0,
+		snd_hdac_codec_write(hdev, cvt->nid, 0,
 				AC_VERB_SET_STREAM_FORMAT, pcm->format);
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		snd_hdac_codec_write(&edev->hdev, cvt->nid, 0,
+		snd_hdac_codec_write(hdev, cvt->nid, 0,
 				AC_VERB_SET_CHANNEL_STREAMID, 0);
-		snd_hdac_codec_write(&edev->hdev, cvt->nid, 0,
+		snd_hdac_codec_write(hdev, cvt->nid, 0,
 				AC_VERB_SET_STREAM_FORMAT, 0);
 
-		hdac_hdmi_set_power_state(edev, cvt->nid, AC_PWRST_D3);
+		hdac_hdmi_set_power_state(hdev, cvt->nid, AC_PWRST_D3);
 		break;
 
 	}
@@ -829,10 +819,10 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 					struct snd_kcontrol *kc, int event)
 {
 	struct hdac_hdmi_port *port = w->priv;
-	struct hdac_ext_device *edev = to_hda_ext_device(w->dapm->dev);
+	struct hdac_device *hdev = dev_to_hdac_dev(w->dapm->dev);
 	int mux_idx;
 
-	dev_dbg(&edev->hdev.dev, "%s: widget: %s event: %x\n",
+	dev_dbg(&hdev->dev, "%s: widget: %s event: %x\n",
 			__func__, w->name, event);
 
 	if (!kc)
@@ -841,11 +831,11 @@ static int hdac_hdmi_pin_mux_widget_event(struct snd_soc_dapm_widget *w,
 	mux_idx = dapm_kcontrol_get_value(kc);
 
 	/* set the device if pin is mst_capable */
-	if (hdac_hdmi_port_select_set(edev, port) < 0)
+	if (hdac_hdmi_port_select_set(hdev, port) < 0)
 		return -EIO;
 
 	if (mux_idx > 0) {
-		snd_hdac_codec_write(&edev->hdev, port->pin->nid, 0,
+		snd_hdac_codec_write(hdev, port->pin->nid, 0,
 			AC_VERB_SET_CONNECT_SEL, (mux_idx - 1));
 	}
 
@@ -864,8 +854,8 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
 	struct snd_soc_dapm_context *dapm = w->dapm;
 	struct hdac_hdmi_port *port = w->priv;
-	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_device *hdev = dev_to_hdac_dev(dapm->dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm = NULL;
 	const char *cvt_name =  e->texts[ucontrol->value.enumerated.item[0]];
 
@@ -918,12 +908,12 @@ static int hdac_hdmi_set_pin_port_mux(struct snd_kcontrol *kcontrol,
  * care of selecting the right one and leaving all other inputs selected to
  * "NONE"
  */
-static int hdac_hdmi_create_pin_port_muxs(struct hdac_ext_device *edev,
+static int hdac_hdmi_create_pin_port_muxs(struct hdac_device *hdev,
 				struct hdac_hdmi_port *port,
 				struct snd_soc_dapm_widget *widget,
 				const char *widget_name)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pin *pin = port->pin;
 	struct snd_kcontrol_new *kc;
 	struct hdac_hdmi_cvt *cvt;
@@ -935,17 +925,17 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_ext_device *edev,
 	int i = 0;
 	int num_items = hdmi->num_cvt + 1;
 
-	kc = devm_kzalloc(&edev->hdev.dev, sizeof(*kc), GFP_KERNEL);
+	kc = devm_kzalloc(&hdev->dev, sizeof(*kc), GFP_KERNEL);
 	if (!kc)
 		return -ENOMEM;
 
-	se = devm_kzalloc(&edev->hdev.dev, sizeof(*se), GFP_KERNEL);
+	se = devm_kzalloc(&hdev->dev, sizeof(*se), GFP_KERNEL);
 	if (!se)
 		return -ENOMEM;
 
 	snprintf(kc_name, NAME_SIZE, "Pin %d port %d Input",
 						pin->nid, port->id);
-	kc->name = devm_kstrdup(&edev->hdev.dev, kc_name, GFP_KERNEL);
+	kc->name = devm_kstrdup(&hdev->dev, kc_name, GFP_KERNEL);
 	if (!kc->name)
 		return -ENOMEM;
 
@@ -963,35 +953,35 @@ static int hdac_hdmi_create_pin_port_muxs(struct hdac_ext_device *edev,
 	se->mask = roundup_pow_of_two(se->items) - 1;
 
 	sprintf(mux_items, "NONE");
-	items[i] = devm_kstrdup(&edev->hdev.dev, mux_items, GFP_KERNEL);
+	items[i] = devm_kstrdup(&hdev->dev, mux_items, GFP_KERNEL);
 	if (!items[i])
 		return -ENOMEM;
 
 	list_for_each_entry(cvt, &hdmi->cvt_list, head) {
 		i++;
 		sprintf(mux_items, "cvt %d", cvt->nid);
-		items[i] = devm_kstrdup(&edev->hdev.dev, mux_items, GFP_KERNEL);
+		items[i] = devm_kstrdup(&hdev->dev, mux_items, GFP_KERNEL);
 		if (!items[i])
 			return -ENOMEM;
 	}
 
-	se->texts = devm_kmemdup(&edev->hdev.dev, items,
+	se->texts = devm_kmemdup(&hdev->dev, items,
 			(num_items  * sizeof(char *)), GFP_KERNEL);
 	if (!se->texts)
 		return -ENOMEM;
 
-	return hdac_hdmi_fill_widget_info(&edev->hdev.dev, widget,
+	return hdac_hdmi_fill_widget_info(&hdev->dev, widget,
 			snd_soc_dapm_mux, port, widget_name, NULL, kc, 1,
 			hdac_hdmi_pin_mux_widget_event,
 			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_REG);
 }
 
 /* Add cvt <- input <- mux route map */
-static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_ext_device *edev,
+static void hdac_hdmi_add_pinmux_cvt_route(struct hdac_device *hdev,
 			struct snd_soc_dapm_widget *widgets,
 			struct snd_soc_dapm_route *route, int rindex)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	const struct snd_kcontrol_new *kc;
 	struct soc_enum *se;
 	int mux_index = hdmi->num_cvt + hdmi->num_ports;
@@ -1033,8 +1023,8 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 {
 	struct snd_soc_dapm_widget *widgets;
 	struct snd_soc_dapm_route *route;
-	struct hdac_ext_device *edev = to_hda_ext_device(dapm->dev);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_device *hdev = dev_to_hdac_dev(dapm->dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct snd_soc_dai_driver *dai_drv = dapm->component->dai_drv;
 	char widget_name[NAME_SIZE];
 	struct hdac_hdmi_cvt *cvt;
@@ -1086,7 +1076,7 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 		for (j = 0; j < pin->num_ports; j++) {
 			sprintf(widget_name, "Pin%d-Port%d Mux",
 				pin->nid, pin->ports[j].id);
-			ret = hdac_hdmi_create_pin_port_muxs(edev,
+			ret = hdac_hdmi_create_pin_port_muxs(hdev,
 						&pin->ports[j], &widgets[i],
 						widget_name);
 			if (ret < 0)
@@ -1121,7 +1111,7 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 		}
 	}
 
-	hdac_hdmi_add_pinmux_cvt_route(edev, widgets, route, i);
+	hdac_hdmi_add_pinmux_cvt_route(hdev, widgets, route, i);
 
 	snd_soc_dapm_new_controls(dapm, widgets,
 		((2 * hdmi->num_ports) + hdmi->num_cvt));
@@ -1133,9 +1123,9 @@ static int create_fill_widget_route_map(struct snd_soc_dapm_context *dapm)
 
 }
 
-static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
+static int hdac_hdmi_init_dai_map(struct hdac_device *hdev)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_dai_port_map *dai_map;
 	struct hdac_hdmi_cvt *cvt;
 	int dai_id = 0;
@@ -1151,7 +1141,7 @@ static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 		dai_id++;
 
 		if (dai_id == HDA_MAX_CVTS) {
-			dev_warn(&edev->hdev.dev,
+			dev_warn(&hdev->dev,
 				"Max dais supported: %d\n", dai_id);
 			break;
 		}
@@ -1160,9 +1150,9 @@ static int hdac_hdmi_init_dai_map(struct hdac_ext_device *edev)
 	return 0;
 }
 
-static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
+static int hdac_hdmi_add_cvt(struct hdac_device *hdev, hda_nid_t nid)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_cvt *cvt;
 	char name[NAME_SIZE];
 
@@ -1177,10 +1167,10 @@ static int hdac_hdmi_add_cvt(struct hdac_ext_device *edev, hda_nid_t nid)
 	list_add_tail(&cvt->head, &hdmi->cvt_list);
 	hdmi->num_cvt++;
 
-	return hdac_hdmi_query_cvt_params(&edev->hdev, cvt);
+	return hdac_hdmi_query_cvt_params(hdev, cvt);
 }
 
-static int hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
+static int hdac_hdmi_parse_eld(struct hdac_device *hdev,
 			struct hdac_hdmi_port *port)
 {
 	unsigned int ver, mnl;
@@ -1189,7 +1179,7 @@ static int hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
 						>> DRM_ELD_VER_SHIFT;
 
 	if (ver != ELD_VER_CEA_861D && ver != ELD_VER_PARTIAL) {
-		dev_err(&edev->hdev.dev, "HDMI: Unknown ELD version %d\n", ver);
+		dev_err(&hdev->dev, "HDMI: Unknown ELD version %d\n", ver);
 		return -EINVAL;
 	}
 
@@ -1197,7 +1187,7 @@ static int hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
 		DRM_ELD_MNL_MASK) >> DRM_ELD_MNL_SHIFT;
 
 	if (mnl > ELD_MAX_MNL) {
-		dev_err(&edev->hdev.dev, "HDMI: MNL Invalid %d\n", mnl);
+		dev_err(&hdev->dev, "HDMI: MNL Invalid %d\n", mnl);
 		return -EINVAL;
 	}
 
@@ -1209,8 +1199,8 @@ static int hdac_hdmi_parse_eld(struct hdac_ext_device *edev,
 static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 				    struct hdac_hdmi_port *port)
 {
-	struct hdac_ext_device *edev = pin->edev;
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_device *hdev = pin->hdev;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm;
 	int size = 0;
 	int port_id = -1;
@@ -1228,14 +1218,14 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 	if (pin->mst_capable)
 		port_id = port->id;
 
-	size = snd_hdac_acomp_get_eld(&edev->hdev, pin->nid, port_id,
+	size = snd_hdac_acomp_get_eld(hdev, pin->nid, port_id,
 				&port->eld.monitor_present,
 				port->eld.eld_buffer,
 				ELD_MAX_SIZE);
 
 	if (size > 0) {
 		size = min(size, ELD_MAX_SIZE);
-		if (hdac_hdmi_parse_eld(edev, port) < 0)
+		if (hdac_hdmi_parse_eld(hdev, port) < 0)
 			size = -EINVAL;
 	}
 
@@ -1247,11 +1237,11 @@ static void hdac_hdmi_present_sense(struct hdac_hdmi_pin *pin,
 		port->eld.eld_size = 0;
 	}
 
-	pcm = hdac_hdmi_get_pcm(edev, port);
+	pcm = hdac_hdmi_get_pcm(hdev, port);
 
 	if (!port->eld.monitor_present || !port->eld.eld_valid) {
 
-		dev_err(&edev->hdev.dev, "%s: disconnect for pin:port %d:%d\n",
+		dev_err(&hdev->dev, "%s: disconnect for pin:port %d:%d\n",
 						__func__, pin->nid, port->id);
 
 		/*
@@ -1303,9 +1293,9 @@ static int hdac_hdmi_add_ports(struct hdac_hdmi_priv *hdmi,
 	return 0;
 }
 
-static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
+static int hdac_hdmi_add_pin(struct hdac_device *hdev, hda_nid_t nid)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pin *pin;
 	int ret;
 
@@ -1315,7 +1305,7 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 
 	pin->nid = nid;
 	pin->mst_capable = false;
-	pin->edev = edev;
+	pin->hdev = hdev;
 	ret = hdac_hdmi_add_ports(hdmi, pin);
 	if (ret < 0)
 		return ret;
@@ -1445,15 +1435,14 @@ static int hdac_hdmi_create_dais(struct hdac_device *hdev,
  * Parse all nodes and store the cvt/pin nids in array
  * Add one time initialization for pin and cvt widgets
  */
-static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
+static int hdac_hdmi_parse_and_map_nid(struct hdac_device *hdev,
 		struct snd_soc_dai_driver **dais, int *num_dais)
 {
 	hda_nid_t nid;
 	int i, num_nodes;
 	struct hdac_hdmi_cvt *temp_cvt, *cvt_next;
 	struct hdac_hdmi_pin *temp_pin, *pin_next;
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
-	struct hdac_device *hdev = &edev->hdev;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	int ret;
 
 	hdac_hdmi_skl_enable_all_pins(hdev);
@@ -1478,13 +1467,13 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 		switch (type) {
 
 		case AC_WID_AUD_OUT:
-			ret = hdac_hdmi_add_cvt(edev, nid);
+			ret = hdac_hdmi_add_cvt(hdev, nid);
 			if (ret < 0)
 				goto free_widgets;
 			break;
 
 		case AC_WID_PIN:
-			ret = hdac_hdmi_add_pin(edev, nid);
+			ret = hdac_hdmi_add_pin(hdev, nid);
 			if (ret < 0)
 				goto free_widgets;
 			break;
@@ -1504,7 +1493,7 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 	}
 
 	*num_dais = hdmi->num_cvt;
-	ret = hdac_hdmi_init_dai_map(edev);
+	ret = hdac_hdmi_init_dai_map(hdev);
 	if (ret < 0)
 		goto free_widgets;
 
@@ -1530,17 +1519,17 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev,
 
 static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 {
-	struct hdac_ext_device *edev = aptr;
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_device *hdev = aptr;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pin *pin = NULL;
 	struct hdac_hdmi_port *hport = NULL;
-	struct snd_soc_codec *codec = edev->scodec;
+	struct snd_soc_codec *codec = hdmi->scodec;
 	int i;
 
 	/* Don't know how this mapping is derived */
 	hda_nid_t pin_nid = port + 0x04;
 
-	dev_dbg(&edev->hdev.dev, "%s: for pin:%d port=%d\n", __func__,
+	dev_dbg(&hdev->dev, "%s: for pin:%d port=%d\n", __func__,
 							pin_nid, pipe);
 
 	/*
@@ -1553,7 +1542,7 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 			SNDRV_CTL_POWER_D0)
 		return;
 
-	if (atomic_read(&edev->hdev.in_pm))
+	if (atomic_read(&hdev->in_pm))
 		return;
 
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
@@ -1600,15 +1589,15 @@ static struct snd_pcm *hdac_hdmi_get_pcm_from_id(struct snd_soc_card *card,
 
 /* create jack pin kcontrols */
 static int create_fill_jack_kcontrols(struct snd_soc_card *card,
-				    struct hdac_ext_device *edev)
+				    struct hdac_device *hdev)
 {
 	struct hdac_hdmi_pin *pin;
 	struct snd_kcontrol_new *kc;
 	char kc_name[NAME_SIZE], xname[NAME_SIZE];
 	char *name;
 	int i = 0, j;
-	struct snd_soc_codec *codec = edev->scodec;
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+	struct snd_soc_codec *codec = hdmi->scodec;
 
 	kc = devm_kcalloc(codec->dev, hdmi->num_ports,
 				sizeof(*kc), GFP_KERNEL);
@@ -1645,8 +1634,8 @@ static int create_fill_jack_kcontrols(struct snd_soc_card *card,
 int hdac_hdmi_jack_port_init(struct snd_soc_codec *codec,
 			struct snd_soc_dapm_context *dapm)
 {
-	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdev = hdmi->hdev;
 	struct hdac_hdmi_pin *pin;
 	struct snd_soc_dapm_widget *widgets;
 	struct snd_soc_dapm_route *route;
@@ -1701,7 +1690,7 @@ int hdac_hdmi_jack_port_init(struct snd_soc_codec *codec,
 		return ret;
 
 	/* Add Jack Pin switch Kcontrol */
-	ret = create_fill_jack_kcontrols(dapm->card, edev);
+	ret = create_fill_jack_kcontrols(dapm->card, hdev);
 
 	if (ret < 0)
 		return ret;
@@ -1721,8 +1710,8 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 				struct snd_soc_jack *jack)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdev = hdmi->hdev;
 	struct hdac_hdmi_pcm *pcm;
 	struct snd_pcm *snd_pcm;
 	int err;
@@ -1744,7 +1733,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 	if (snd_pcm) {
 		err = snd_hdac_add_chmap_ctls(snd_pcm, device, &hdmi->chmap);
 		if (err < 0) {
-			dev_err(&edev->hdev.dev,
+			dev_err(&hdev->dev,
 				"chmap control add failed with err: %d for pcm: %d\n",
 				err, device);
 			kfree(pcm);
@@ -1758,7 +1747,7 @@ int hdac_hdmi_jack_init(struct snd_soc_dai *dai, int device,
 }
 EXPORT_SYMBOL_GPL(hdac_hdmi_jack_init);
 
-static void hdac_hdmi_present_sense_all_pins(struct hdac_ext_device *edev,
+static void hdac_hdmi_present_sense_all_pins(struct hdac_device *hdev,
 			struct hdac_hdmi_priv *hdmi, bool detect_pin_caps)
 {
 	int i;
@@ -1767,7 +1756,7 @@ static void hdac_hdmi_present_sense_all_pins(struct hdac_ext_device *edev,
 	list_for_each_entry(pin, &hdmi->pin_list, head) {
 		if (detect_pin_caps) {
 
-			if (hdac_hdmi_get_port_len(edev, pin->nid)  == 0)
+			if (hdac_hdmi_get_port_len(hdev, pin->nid)  == 0)
 				pin->mst_capable = false;
 			else
 				pin->mst_capable = true;
@@ -1784,69 +1773,69 @@ static void hdac_hdmi_present_sense_all_pins(struct hdac_ext_device *edev,
 
 static int hdmi_codec_probe(struct snd_soc_codec *codec)
 {
-	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdev = hdmi->hdev;
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_component_get_dapm(&codec->component);
 	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
-	edev->scodec = codec;
+	hdmi->scodec = codec;
 
 	/*
 	 * hold the ref while we probe, also no need to drop the ref on
 	 * exit, we call pm_runtime_suspend() so that will do for us
 	 */
-	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdev.dev));
+	hlink = snd_hdac_ext_bus_get_link(hbus_to_ebus(hdev->bus),
+						dev_name(&hdev->dev));
 	if (!hlink) {
-		dev_err(&edev->hdev.dev, "hdac link not found\n");
+		dev_err(&hdev->dev, "hdac link not found\n");
 		return -EIO;
 	}
 
-	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
+	snd_hdac_ext_bus_link_get(hbus_to_ebus(hdev->bus), hlink);
 
 	ret = create_fill_widget_route_map(dapm);
 	if (ret < 0)
 		return ret;
 
-	aops.audio_ptr = edev;
+	aops.audio_ptr = hdev;
 	ret = snd_hdac_i915_register_notifier(&aops);
 	if (ret < 0) {
-		dev_err(&edev->hdev.dev, "notifier register failed: err: %d\n",
-				ret);
+		dev_err(&hdev->dev, "notifier register failed: err: %d\n", ret);
 		return ret;
 	}
 
-	hdac_hdmi_present_sense_all_pins(edev, hdmi, true);
+	hdac_hdmi_present_sense_all_pins(hdev, hdmi, true);
 	/* Imp: Store the card pointer in hda_codec */
-	edev->card = dapm->card->snd_card;
+	hdmi->card = dapm->card->snd_card;
 
 	/*
 	 * hdac_device core already sets the state to active and calls
 	 * get_noresume. So enable runtime and set the device to suspend.
 	 */
-	pm_runtime_enable(&edev->hdev.dev);
-	pm_runtime_put(&edev->hdev.dev);
-	pm_runtime_suspend(&edev->hdev.dev);
+	pm_runtime_enable(&hdev->dev);
+	pm_runtime_put(&hdev->dev);
+	pm_runtime_suspend(&hdev->dev);
 
 	return 0;
 }
 
 static int hdmi_codec_remove(struct snd_soc_codec *codec)
 {
-	struct hdac_ext_device *edev = snd_soc_codec_get_drvdata(codec);
+	struct hdac_hdmi_priv *hdmi = snd_soc_codec_get_drvdata(codec);
+	struct hdac_device *hdev = hdmi->hdev;
 
-	pm_runtime_disable(&edev->hdev.dev);
+	pm_runtime_disable(&hdev->dev);
 	return 0;
 }
 
 #ifdef CONFIG_PM
 static int hdmi_codec_prepare(struct device *dev)
 {
-	struct hdac_ext_device *edev = to_hda_ext_device(dev);
-	struct hdac_device *hdev = &edev->hdev;
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 
-	pm_runtime_get_sync(&edev->hdev.dev);
+	pm_runtime_get_sync(&hdev->dev);
 
 	/*
 	 * Power down afg.
@@ -1863,16 +1852,15 @@ static int hdmi_codec_prepare(struct device *dev)
 
 static void hdmi_codec_complete(struct device *dev)
 {
-	struct hdac_ext_device *edev = to_hda_ext_device(dev);
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
-	struct hdac_device *hdev = &edev->hdev;
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 
 	/* Power up afg */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
 							AC_PWRST_D0);
 
-	hdac_hdmi_skl_enable_all_pins(&edev->hdev);
-	hdac_hdmi_skl_enable_dp12(&edev->hdev);
+	hdac_hdmi_skl_enable_all_pins(hdev);
+	hdac_hdmi_skl_enable_dp12(hdev);
 
 	/*
 	 * As the ELD notify callback request is not entertained while the
@@ -1880,9 +1868,9 @@ static void hdmi_codec_complete(struct device *dev)
 	 * all pins here. pin capablity change is not support, so use the
 	 * already set pin caps.
 	 */
-	hdac_hdmi_present_sense_all_pins(edev, hdmi, false);
+	hdac_hdmi_present_sense_all_pins(hdev, hdmi, false);
 
-	pm_runtime_put_sync(&edev->hdev.dev);
+	pm_runtime_put_sync(&hdev->dev);
 }
 #else
 #define hdmi_codec_prepare NULL
@@ -1907,7 +1895,6 @@ static void hdac_hdmi_get_chmap(struct hdac_device *hdev, int pcm_idx,
 static void hdac_hdmi_set_chmap(struct hdac_device *hdev, int pcm_idx,
 				unsigned char *chmap, int prepared)
 {
-	struct hdac_ext_device *edev = to_ehdac_device(hdev);
 	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pcm *pcm = get_hdmi_pcm_from_id(hdmi, pcm_idx);
 	struct hdac_hdmi_port *port;
@@ -1923,7 +1910,7 @@ static void hdac_hdmi_set_chmap(struct hdac_device *hdev, int pcm_idx,
 	memcpy(pcm->chmap, chmap, ARRAY_SIZE(pcm->chmap));
 	list_for_each_entry(port, &pcm->port_list, head)
 		if (prepared)
-			hdac_hdmi_setup_audio_infoframe(edev, pcm, port);
+			hdac_hdmi_setup_audio_infoframe(hdev, pcm, port);
 	mutex_unlock(&pcm->lock);
 }
 
@@ -1972,10 +1959,9 @@ static struct hdac_hdmi_drv_data intel_drv_data  = {
 	.vendor_nid = INTEL_VENDOR_NID,
 };
 
-static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
+static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
 {
-	struct hdac_device *hdev = &edev->hdev;
-	struct hdac_hdmi_priv *hdmi_priv;
+	struct hdac_hdmi_priv *hdmi_priv = NULL;
 	struct snd_soc_dai_driver *hdmi_dais = NULL;
 	struct hdac_ext_link *hlink = NULL;
 	int num_dais = 0;
@@ -1984,24 +1970,25 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	const struct hda_device_id *hdac_id = hdac_get_device_id(hdev, hdrv);
 
 	/* hold the ref while we probe */
-	hlink = snd_hdac_ext_bus_get_link(edev->ebus, dev_name(&edev->hdev.dev));
+	hlink = snd_hdac_ext_bus_get_link(hbus_to_ebus(hdev->bus),
+						dev_name(&hdev->dev));
 	if (!hlink) {
-		dev_err(&edev->hdev.dev, "hdac link not found\n");
+		dev_err(&hdev->dev, "hdac link not found\n");
 		return -EIO;
 	}
 
-	snd_hdac_ext_bus_link_get(edev->ebus, hlink);
+	snd_hdac_ext_bus_link_get(hbus_to_ebus(hdev->bus), hlink);
 
 	hdmi_priv = devm_kzalloc(&hdev->dev, sizeof(*hdmi_priv), GFP_KERNEL);
 	if (hdmi_priv == NULL)
 		return -ENOMEM;
 
-	edev->private_data = hdmi_priv;
 	snd_hdac_register_chmap_ops(hdev, &hdmi_priv->chmap);
 	hdmi_priv->chmap.ops.get_chmap = hdac_hdmi_get_chmap;
 	hdmi_priv->chmap.ops.set_chmap = hdac_hdmi_set_chmap;
 	hdmi_priv->chmap.ops.is_pcm_attached = is_hdac_hdmi_pcm_attached;
 	hdmi_priv->chmap.ops.get_spk_alloc = hdac_hdmi_get_spk_alloc;
+	hdmi_priv->hdev = hdev;
 
 	if (!hdac_id)
 		return -ENODEV;
@@ -2012,7 +1999,7 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	else
 		hdmi_priv->drv_data = &intel_drv_data;
 
-	dev_set_drvdata(&hdev->dev, edev);
+	dev_set_drvdata(&hdev->dev, hdmi_priv);
 
 	INIT_LIST_HEAD(&hdmi_priv->pin_list);
 	INIT_LIST_HEAD(&hdmi_priv->cvt_list);
@@ -2023,15 +2010,15 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	 * Turned off in the runtime_suspend during the first explicit
 	 * pm_runtime_suspend call.
 	 */
-	ret = snd_hdac_display_power(edev->hdev.bus, true);
+	ret = snd_hdac_display_power(hdev->bus, true);
 	if (ret < 0) {
-		dev_err(&edev->hdev.dev,
+		dev_err(&hdev->dev,
 			"Cannot turn on display power on i915 err: %d\n",
 			ret);
 		return ret;
 	}
 
-	ret = hdac_hdmi_parse_and_map_nid(edev, &hdmi_dais, &num_dais);
+	ret = hdac_hdmi_parse_and_map_nid(hdev, &hdmi_dais, &num_dais);
 	if (ret < 0) {
 		dev_err(&hdev->dev,
 			"Failed in parse and map nid with err: %d\n", ret);
@@ -2043,21 +2030,21 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
 	ret = snd_soc_register_codec(&hdev->dev, &hdmi_hda_codec,
 					hdmi_dais, num_dais);
 
-	snd_hdac_ext_bus_link_put(edev->ebus, hlink);
+	snd_hdac_ext_bus_link_put(hbus_to_ebus(hdev->bus), hlink);
 
 	return ret;
 }
 
-static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
+static int hdac_hdmi_dev_remove(struct hdac_device *hdev)
 {
-	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(&edev->hdev);
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
 	struct hdac_hdmi_pin *pin, *pin_next;
 	struct hdac_hdmi_cvt *cvt, *cvt_next;
 	struct hdac_hdmi_pcm *pcm, *pcm_next;
 	struct hdac_hdmi_port *port, *port_next;
 	int i;
 
-	snd_soc_unregister_codec(&edev->hdev.dev);
+	snd_soc_unregister_codec(&hdev->dev);
 
 	list_for_each_entry_safe(pcm, pcm_next, &hdmi->pcm_list, head) {
 		pcm->cvt = NULL;
@@ -2092,8 +2079,7 @@ static int hdac_hdmi_dev_remove(struct hdac_ext_device *edev)
 #ifdef CONFIG_PM
 static int hdac_hdmi_runtime_suspend(struct device *dev)
 {
-	struct hdac_ext_device *edev = to_hda_ext_device(dev);
-	struct hdac_device *hdev = &edev->hdev;
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
 	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
 	struct hdac_ext_link *hlink = NULL;
@@ -2116,7 +2102,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 							AC_PWRST_D3);
 	err = snd_hdac_display_power(bus, false);
 	if (err < 0) {
-		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		dev_err(dev, "Cannot turn on display power on i915\n");
 		return err;
 	}
 
@@ -2133,8 +2119,7 @@ static int hdac_hdmi_runtime_suspend(struct device *dev)
 
 static int hdac_hdmi_runtime_resume(struct device *dev)
 {
-	struct hdac_ext_device *edev = to_hda_ext_device(dev);
-	struct hdac_device *hdev = &edev->hdev;
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
 	struct hdac_bus *bus = hdev->bus;
 	struct hdac_ext_bus *ebus = hbus_to_ebus(bus);
 	struct hdac_ext_link *hlink = NULL;
@@ -2156,12 +2141,12 @@ static int hdac_hdmi_runtime_resume(struct device *dev)
 
 	err = snd_hdac_display_power(bus, true);
 	if (err < 0) {
-		dev_err(bus->dev, "Cannot turn on display power on i915\n");
+		dev_err(dev, "Cannot turn on display power on i915\n");
 		return err;
 	}
 
-	hdac_hdmi_skl_enable_all_pins(&edev->hdev);
-	hdac_hdmi_skl_enable_dp12(&edev->hdev);
+	hdac_hdmi_skl_enable_all_pins(hdev);
+	hdac_hdmi_skl_enable_dp12(hdev);
 
 	/* Power up afg */
 	snd_hdac_codec_read(hdev, hdev->afg, 0,	AC_VERB_SET_POWER_STATE,
-- 
2.7.4
