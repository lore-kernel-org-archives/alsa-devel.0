From: mengdong.lin@intel.com
Subject: [PATCH 2/3] [ALSA] hda - Add fixup for Haswell to
	enable all pin and convertor widgets
Date: Fri,  8 Feb 2013 17:09:52 -0500
Message-ID: <1360361392-4373-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 242C7265346
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 10:09:40 +0100 (CET)
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

Some Haswell machines support more than one display outputs (HDMI or DP),
but its BIOS may not enable the codec's 2nd and 3rd pin and output cvt widgets.

This patch implements a board-specific fixup for Intel Haswell Machines:
If the hidden pins are not enabled by BIOS, the driver will enable them
and call common code to update the codec tree.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 899c4fb..54243c4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1714,6 +1714,57 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec)
 	snd_hda_override_conn_list(codec, 0x07, 3, list);
 }
 
+#define INTEL_VENDOR_NID 0x08
+#define INTEL_GET_VENDOR_VERB 0xf81
+#define INTEL_SET_VENDOR_VERB 0x781
+#define INTEL_EN_DP12			0x02 /* enable DP 1.2 features */
+#define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
+
+static void intel_haswell_enable_all_pins(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	unsigned int vendor_param;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+				INTEL_GET_VENDOR_VERB, 0);
+	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
+		return;
+
+	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
+	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
+				INTEL_SET_VENDOR_VERB, vendor_param);
+	if (vendor_param == -1)
+		return;
+
+	snd_hda_codec_update_widgets(codec);
+	return;
+}
+
+
+/* available models for fixup */
+enum {
+	INTEL_HASWELL,
+};
+
+static const struct hda_model_fixup hdmi_models[] = {
+	{.id = INTEL_HASWELL, .name = "Haswell"},
+	{}
+};
+
+static const struct snd_pci_quirk hdmi_fixup_tbl[] = {
+	SND_PCI_QUIRK(0x8086, 0x2010, "Haswell", INTEL_HASWELL),
+	{} /* terminator */
+};
+
+static const struct hda_fixup hdmi_fixups[] = {
+	[INTEL_HASWELL] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = intel_haswell_enable_all_pins,
+	},
+};
+
 
 static int patch_generic_hdmi(struct hda_codec *codec)
 {
@@ -1725,6 +1776,9 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 
 	codec->spec = spec;
 
+	snd_hda_pick_fixup(codec, hdmi_models, hdmi_fixup_tbl, hdmi_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
 	if (codec->vendor_id == 0x80862807)
 		intel_haswell_fixup_connect_list(codec);
 
-- 
1.7.10.4
