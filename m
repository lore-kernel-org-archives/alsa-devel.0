From: Bard liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH] ASoC: Intel: hdac_hdmi: add Icelake support
Date: Sun, 11 Nov 2018 05:18:46 +0800
Message-ID: <20181110211846.23667-1-yung-chuan.liao@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 31091267877
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2018 14:16:48 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Bard liao <bard.liao@intel.com>

Add Icelake device id. Also, Icelake's pin2port mapping table is
complicated. So we use a mapping table to do the pin2port mapping.

Signed-off-by: Bard liao <bard.liao@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 63 ++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 4e9854889a95..fac397326515 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -121,8 +121,16 @@ struct hdac_hdmi_dai_port_map {
 	struct hdac_hdmi_cvt *cvt;
 };
 
+/*
+ * pin to port mapping table where the value indicate the pin number and
+ * the index indicate the port number with 1 base.
+ */
+static const int icl_pin2port_map[] = {0x4, 0x6, 0x8, 0xa, 0xb};
+
 struct hdac_hdmi_drv_data {
 	unsigned int vendor_nid;
+	const int *port_map; /* pin to port mapping table */
+	int port_num;
 };
 
 struct hdac_hdmi_priv {
@@ -1329,11 +1337,12 @@ static int hdac_hdmi_add_pin(struct hdac_device *hdev, hda_nid_t nid)
 	return 0;
 }
 
-#define INTEL_VENDOR_NID 0x08
-#define INTEL_GLK_VENDOR_NID 0x0b
+#define INTEL_VENDOR_NID_0x2 0x02
+#define INTEL_VENDOR_NID_0x8 0x08
+#define INTEL_VENDOR_NID_0xb 0x0b
 #define INTEL_GET_VENDOR_VERB 0xf81
 #define INTEL_SET_VENDOR_VERB 0x781
-#define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
+#define INTEL_EN_DP12		0x02 /* enable DP 1.2 features */
 #define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
 
 static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdev)
@@ -1538,7 +1547,26 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_device *hdev,
 
 static int hdac_hdmi_pin2port(void *aptr, int pin)
 {
-	return pin - 4; /* map NID 0x05 -> port #1 */
+	struct hdac_device *hdev = aptr;
+	struct hdac_hdmi_priv *hdmi = hdev_to_hdmi_priv(hdev);
+	const int *map = hdmi->drv_data->port_map;
+	int i;
+
+	if (!hdmi->drv_data->port_num)
+		return pin - 4; /* map NID 0x05 -> port #1 */
+
+	/*
+	 * looking for the pin number in the mapping table and return
+	 * the index which indicate the port number
+	 */
+	for (i = 0; i < hdmi->drv_data->port_num; i++) {
+		if (pin == map[i])
+			return i + 1;
+	}
+
+	/* return -1 if pin number exceeds our expectation */
+	dev_err(&hdev->dev, "Can't find the port for pin %d\n", pin);
+	return -1;
 }
 
 static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
@@ -1549,9 +1577,18 @@ static void hdac_hdmi_eld_notify_cb(void *aptr, int port, int pipe)
 	struct hdac_hdmi_port *hport = NULL;
 	struct snd_soc_component *component = hdmi->component;
 	int i;
-
-	/* Don't know how this mapping is derived */
-	hda_nid_t pin_nid = port + 0x04;
+	hda_nid_t pin_nid;
+
+	if (!hdmi->drv_data->port_num) {
+		/* for legacy platforms */
+		pin_nid = port + 0x04;
+	} else if (port < hdmi->drv_data->port_num) {
+		/* get pin number from the pin2port mapping table */
+		pin_nid = hdmi->drv_data->port_map[port - 1];
+	} else {
+		dev_err(&hdev->dev, "Can't find the pin for port %d\n", port);
+		return;
+	}
 
 	dev_dbg(&hdev->dev, "%s: for pin:%d port=%d\n", __func__,
 							pin_nid, pipe);
@@ -1973,12 +2010,18 @@ static int hdac_hdmi_get_spk_alloc(struct hdac_device *hdev, int pcm_idx)
 	return port->eld.info.spk_alloc;
 }
 
+static struct hdac_hdmi_drv_data intel_icl_drv_data  = {
+	.vendor_nid = INTEL_VENDOR_NID_0x2,
+	.port_map = icl_pin2port_map,
+	.port_num = ARRAY_SIZE(icl_pin2port_map),
+};
+
 static struct hdac_hdmi_drv_data intel_glk_drv_data  = {
-	.vendor_nid = INTEL_GLK_VENDOR_NID,
+	.vendor_nid = INTEL_VENDOR_NID_0xb,
 };
 
 static struct hdac_hdmi_drv_data intel_drv_data  = {
-	.vendor_nid = INTEL_VENDOR_NID,
+	.vendor_nid = INTEL_VENDOR_NID_0x8,
 };
 
 static int hdac_hdmi_dev_probe(struct hdac_device *hdev)
@@ -2259,6 +2302,8 @@ static const struct hda_device_id hdmi_list[] = {
 						   &intel_glk_drv_data),
 	HDA_CODEC_EXT_ENTRY(0x8086280d, 0x100000, "Geminilake HDMI",
 						   &intel_glk_drv_data),
+	HDA_CODEC_EXT_ENTRY(0x8086280f, 0x100000, "Icelake HDMI",
+						   &intel_icl_drv_data),
 	{}
 };
 
-- 
2.17.1
