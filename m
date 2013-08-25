From: mengdong.lin@intel.com
Subject: [PATCH v2 1/4] ALSA: hda - add flags and routines to
	get devices selection info for DP1.2 MST
Date: Sun, 25 Aug 2013 17:44:11 -0400
Message-ID: <1377467051-21579-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 11BE12619FF
 for <alsa-devel@alsa-project.org>; Mon, 26 Aug 2013 06:43:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch adds flags and routines to get device list & selection info on
a pin.

To support Display Port 1.2 multi-stream transport (MST) over single DP port,
a pin can support multiple devices. Please refer to HD-A spec Document Change
Notificaton HDA040-A.

A display audio codec can set flag "dp_mst" in its patch, indicating its pins
can support MST. But at runtime, a pin may not be multi-streaming capable and
report the device list is empty, depending on Gfx driver configuration.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index fdbb09a..2596e36 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -666,6 +666,66 @@ int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_conn_index);
 
+
+/* return DEVLIST_LEN parameter of the given widget */
+static unsigned int get_num_devices(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int wcaps = get_wcaps(codec, nid);
+	unsigned int parm;
+
+	if (!codec->dp_mst || !(wcaps & AC_WCAP_DIGITAL) ||
+	    get_wcaps_type(wcaps) != AC_WID_PIN)
+		return 0;
+
+	parm = snd_hda_param_read(codec, nid, AC_PAR_DEVLIST_LEN);
+	if (parm == -1 && codec->bus->rirb_error)
+		parm = 0;
+	return parm & AC_DEVLIST_LEN;
+}
+
+/**
+ * snd_hda_get_devices - copy device list without cache
+ * @codec: the HDA codec
+ * @nid: NID of the pin to parse
+ * @dev_list: device list array
+ * @max_devices: max. number of devices to store
+ *
+ * Copy the device list. This info is dynamic and so not cached.
+ * Currently called only from hda_proc.c, so not exported.
+ */
+int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
+			struct hda_devlist_entry *dev_list, int max_devices)
+{
+	unsigned int parm;
+	int i, dev_len, devices;
+
+	parm = get_num_devices(codec, nid);
+	if (!parm)	/* not multi-stream capable */
+		return 0;
+
+	dev_len = parm + 1;
+	dev_len = dev_len < max_devices ? dev_len : max_devices;
+
+	devices = 0;
+	while (devices < dev_len) {
+		parm = snd_hda_codec_read(codec, nid, 0,
+					  AC_VERB_GET_DEVICE_LIST, devices);
+		if (parm == -1 && codec->bus->rirb_error)
+			break;
+
+		for (i = 0; i < 8; i++) {
+			dev_list[devices].present_detect = !!(parm & AC_DE_PD);
+			dev_list[devices].eld_valid = !!(parm & AC_DE_ELDV);
+			dev_list[devices].inactive = !!(parm & AC_DE_IA);
+			parm >>= 4;
+			devices++;
+			if (devices >= dev_len)
+				break;
+		}
+	}
+	return devices;
+}
+
 /**
  * snd_hda_queue_unsol_event - add an unsolicited event to queue
  * @bus: the BUS
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 701c2e0..316076e 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -94,6 +94,8 @@ enum {
 #define AC_VERB_GET_HDMI_DIP_XMIT		0x0f32
 #define AC_VERB_GET_HDMI_CP_CTRL		0x0f33
 #define AC_VERB_GET_HDMI_CHAN_SLOT		0x0f34
+#define AC_VERB_GET_DEVICE_SEL			0xf35
+#define AC_VERB_GET_DEVICE_LIST			0xf36
 
 /*
  * SET verbs
@@ -133,6 +135,7 @@ enum {
 #define AC_VERB_SET_HDMI_DIP_XMIT		0x732
 #define AC_VERB_SET_HDMI_CP_CTRL		0x733
 #define AC_VERB_SET_HDMI_CHAN_SLOT		0x734
+#define AC_VERB_SET_DEVICE_SEL			0x735
 
 /*
  * Parameter IDs
@@ -154,6 +157,7 @@ enum {
 #define AC_PAR_GPIO_CAP			0x11
 #define AC_PAR_AMP_OUT_CAP		0x12
 #define AC_PAR_VOL_KNB_CAP		0x13
+#define AC_PAR_DEVLIST_LEN		0x15
 #define AC_PAR_HDMI_LPCM_CAP		0x20
 
 /*
@@ -460,6 +464,11 @@ enum {
 #define AC_DEFCFG_PORT_CONN		(0x3<<30)
 #define AC_DEFCFG_PORT_CONN_SHIFT	30
 
+/* Display pin's device list entry */
+#define AC_DE_PD			(1<<0)
+#define AC_DE_ELDV			(1<<1)
+#define AC_DE_IA			(1<<2)
+
 /* device device types (0x0-0xf) */
 enum {
 	AC_JACK_LINE_OUT,
@@ -795,6 +804,16 @@ struct hda_pcm {
 	bool own_chmap;		/* codec driver provides own channel maps */
 };
 
+/* display pin's device list entry */
+struct  hda_devlist_entry {
+	unsigned int present_detect:1;
+	unsigned int eld_valid:1;
+	unsigned int inactive:1;
+};
+
+#define AC_MAX_DEVLIST_LEN	64
+#define AC_DEVLIST_LEN		0x3f
+
 /* codec information */
 struct hda_codec {
 	struct hda_bus *bus;
@@ -885,6 +904,7 @@ struct hda_codec {
 	unsigned int pcm_format_first:1; /* PCM format must be set first */
 	unsigned int epss:1;		/* supporting EPSS? */
 	unsigned int cached_write:1;	/* write only to caches */
+	unsigned int dp_mst:1; /* support DP1.2 Multi-stream transport */
 #ifdef CONFIG_PM
 	unsigned int power_on :1;	/* current (global) power-state */
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
@@ -972,6 +992,8 @@ int snd_hda_override_conn_list(struct hda_codec *codec, hda_nid_t nid, int nums,
 			  const hda_nid_t *list);
 int snd_hda_get_conn_index(struct hda_codec *codec, hda_nid_t mux,
 			   hda_nid_t nid, int recursive);
+int snd_hda_get_devices(struct hda_codec *codec, hda_nid_t nid,
+			struct hda_devlist_entry *dev_list, int max_devices);
 int snd_hda_query_supported_pcm(struct hda_codec *codec, hda_nid_t nid,
 				u32 *ratesp, u64 *formatsp, unsigned int *bpsp);
 
-- 
1.8.1.2
