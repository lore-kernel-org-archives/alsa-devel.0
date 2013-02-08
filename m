From: mengdong.lin@intel.com
Subject: [PATCH 3/3] ALSA: hda - Yet another fix for broken HSW
	HDMI pin connections
Date: Fri,  8 Feb 2013 17:10:04 -0500
Message-ID: <1360361404-4409-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FF58265373
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 10:09:55 +0100 (CET)
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

From: Takashi Iwai <tiwai@suse.de>

A Haswell test machine showed that the invalid connection list, but
this time it has only a single pin on the codec, thus the former fixup
code doesn't work as it assumes the three pins blindly.

This patch splits the former fixup code to two parts:
- Enable eDP 1.2 for Haswell codec
- Fix the connection list of pins on Haswell codec;
  the converter list is recorded dynamically in hdmi_add_cvt(), and
  applied in hdmi_add_pin()

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 54243c4..b9af281b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -84,6 +84,7 @@ struct hdmi_spec_per_pin {
 struct hdmi_spec {
 	int num_cvts;
 	struct hdmi_spec_per_cvt cvts[MAX_HDMI_CVTS];
+	hda_nid_t cvt_nids[MAX_HDMI_CVTS];
 
 	int num_pins;
 	struct hdmi_spec_per_pin pins[MAX_HDMI_PINS];
@@ -1197,6 +1198,9 @@ static void hdmi_repoll_eld(struct work_struct *work)
 	hdmi_present_sense(per_pin, per_pin->repoll_count);
 }
 
+static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
+					     hda_nid_t nid);
+
 static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1216,6 +1220,9 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	if (snd_BUG_ON(spec->num_pins >= MAX_HDMI_PINS))
 		return -E2BIG;
 
+	if (codec->vendor_id == 0x80862807)
+		intel_haswell_fixup_connect_list(codec, pin_nid);
+
 	pin_idx = spec->num_pins;
 	per_pin = &spec->pins[pin_idx];
 
@@ -1263,7 +1270,7 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 	if (err < 0)
 		return err;
 
-	spec->num_cvts++;
+	spec->cvt_nids[spec->num_cvts++] = cvt_nid;
 
 	return 0;
 }
@@ -1691,27 +1698,22 @@ static const struct hda_codec_ops generic_hdmi_patch_ops = {
 	.unsol_event		= hdmi_unsol_event,
 };
 
-static void intel_haswell_fixup_connect_list(struct hda_codec *codec)
-{
-	unsigned int vendor_param;
-	hda_nid_t list[3] = {0x2, 0x3, 0x4};
 
-	vendor_param = snd_hda_codec_read(codec, 0x08, 0, 0xf81, 0);
-	if (vendor_param == -1 || vendor_param & 0x02)
-		return;
-
-	/* enable DP1.2 mode */
-	vendor_param |= 0x02;
-	snd_hda_codec_read(codec, 0x08, 0, 0x781, vendor_param);
+static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
+					     hda_nid_t nid)
+{
+	struct hdmi_spec *spec = codec->spec;
+	hda_nid_t conns[4];
+	int nconns;
 
-	vendor_param = snd_hda_codec_read(codec, 0x08, 0, 0xf81, 0);
-	if (vendor_param == -1 || !(vendor_param & 0x02))
+	nconns = snd_hda_get_connections(codec, nid, conns, ARRAY_SIZE(conns));
+	if (nconns == spec->num_cvts &&
+	    !memcmp(conns, spec->cvt_nids, spec->num_cvts * sizeof(hda_nid_t)))
 		return;
 
-	/* override 3 pins connection list */
-	snd_hda_override_conn_list(codec, 0x05, 3, list);
-	snd_hda_override_conn_list(codec, 0x06, 3, list);
-	snd_hda_override_conn_list(codec, 0x07, 3, list);
+	/* override pins connection list */
+	snd_printdd("hdmi: haswell: override pin connection 0x%x\n", nid);
+	snd_hda_override_conn_list(codec, nid, spec->num_cvts, spec->cvt_nids);
 }
 
 #define INTEL_VENDOR_NID 0x08
@@ -1742,6 +1744,22 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 	return;
 }
 
+static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
+{
+	unsigned int vendor_param;
+
+	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+				INTEL_GET_VENDOR_VERB, 0);
+	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
+		return;
+
+	/* enable DP1.2 mode */
+	vendor_param |= INTEL_EN_DP12;
+	snd_hda_codec_write_cache(codec, INTEL_VENDOR_NID, 0,
+				INTEL_SET_VENDOR_VERB, vendor_param);
+}
+
+
 
 /* available models for fixup */
 enum {
@@ -1780,7 +1798,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	if (codec->vendor_id == 0x80862807)
-		intel_haswell_fixup_connect_list(codec);
+		intel_haswell_fixup_enable_dp12(codec);
 
 	if (hdmi_parse_codec(codec) < 0) {
 		codec->spec = NULL;
-- 
1.7.10.4
