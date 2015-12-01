From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [PATCH 08/15] ASoC: hdac_hdmi: Enable DP1.2 and all
	converters/pins
Date: Tue,  1 Dec 2015 23:17:04 +0530
Message-ID: <1448992031-8271-8-git-send-email-subhransu.s.prusty@intel.com>
References: <1448991749-8091-1-git-send-email-subhransu.s.prusty@intel.com>
 <1448992031-8271-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 17A5B265CDD
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:16:43 +0100 (CET)
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

By default only one converter and pin widget are enabled. A vendor
widget required to be configured to enable all the widgets of the
codec.

As we are enabling the DP support enable the DP1.2 feature as well.

The changes below are copied from patch_hdmi.c

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/codecs/hdac_hdmi.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
index 55db686..a9e14a0 100644
--- a/sound/soc/codecs/hdac_hdmi.c
+++ b/sound/soc/codecs/hdac_hdmi.c
@@ -525,6 +525,46 @@ static int hdac_hdmi_add_pin(struct hdac_ext_device *edev, hda_nid_t nid)
 	return 0;
 }
 
+#define INTEL_VENDOR_NID 0x08
+#define INTEL_GET_VENDOR_VERB 0xf81
+#define INTEL_SET_VENDOR_VERB 0x781
+#define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
+#define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
+
+static void hdac_hdmi_skl_enable_all_pins(struct hdac_device *hdac)
+{
+	unsigned int vendor_param;
+
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_GET_VENDOR_VERB, 0);
+	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
+		return;
+
+	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_SET_VENDOR_VERB, vendor_param);
+	if (vendor_param == -1)
+		return;
+}
+
+static void hdac_hdmi_skl_enable_dp12(struct hdac_device *hdac)
+{
+	unsigned int vendor_param;
+
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_GET_VENDOR_VERB, 0);
+	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
+		return;
+
+	/* enable DP1.2 mode */
+	vendor_param |= INTEL_EN_DP12;
+	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
+				INTEL_SET_VENDOR_VERB, vendor_param);
+	if (vendor_param == -1)
+		return;
+
+}
+
 /*
  * Parse all nodes and store the cvt/pin nids in array
  * Add one time initialization for pin and cvt widgets
@@ -537,6 +577,9 @@ static int hdac_hdmi_parse_and_map_nid(struct hdac_ext_device *edev)
 	struct hdac_hdmi_priv *hdmi = edev->private_data;
 	int ret;
 
+	hdac_hdmi_skl_enable_all_pins(hdac);
+	hdac_hdmi_skl_enable_dp12(hdac);
+
 	hdac->num_nodes = snd_hdac_get_sub_nodes(hdac, hdac->afg, &nid);
 	if (!nid || hdac->num_nodes <= 0) {
 		dev_warn(&hdac->dev, "HDMI: failed to get afg sub nodes\n");
-- 
1.9.1
