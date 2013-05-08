From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Apply pin-enablement workaround to
	all Haswell HDMI codecs
Date: Wed,  8 May 2013 08:27:53 +0200
Message-ID: <1367994473-31589-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E321926162A
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 09:07:59 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id AC033A3DDF
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2013 09:07:59 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

This is a revised patch based on Mengdong Lin's fix patch, which is a
supplement to a previous patch [1611a9c9: ALSA: hda - Add fixup for
Haswell to enable all pin and convertor widgets].

Some Haswell BIOS will disable the 2nd and 3rd pin/covertor widgets
when the HD-A controller changes state from D3 to D0.  So when the
controller resumes after a system or runtime suspend, these widgets
are disabled and programming these widgets to D0 will cause H/W error
and codec will not respond.

In addition, we found out that some BIOS disables the pins at S3
although it shows up at boot.  This confuses the driver utterly, and
the hardware falls into the fatal communication error like the above.

So in this patch, we apply intel_haswell_enable_all_pins() not only as
a fixup to a certain device (with 8086:2010) but to all Haswell
machines.  The codec driver basically assumes that all pins are
exposed, so it's anyway better to see them from the beginning.  Even
if all pins and converters are shown by this call, there should be no
regression in practice: the pin default configurations are still kept,
thus the disabled pins are handled as disabled by the driver
properly.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 54 +++++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 32930e6..e12f7a0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1832,12 +1832,10 @@ static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
 #define INTEL_EN_ALL_PIN_CVTS	0x01 /* enable 2nd & 3rd pins and convertors */
 
 static void intel_haswell_enable_all_pins(struct hda_codec *codec,
-					const struct hda_fixup *fix, int action)
+					  bool update_tree)
 {
 	unsigned int vendor_param;
 
-	if (action != HDA_FIXUP_ACT_PRE_PROBE)
-		return;
 	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
 				INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
@@ -1849,8 +1847,8 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 	if (vendor_param == -1)
 		return;
 
-	snd_hda_codec_update_widgets(codec);
-	return;
+	if (update_tree)
+		snd_hda_codec_update_widgets(codec);
 }
 
 static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
@@ -1868,30 +1866,20 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 				INTEL_SET_VENDOR_VERB, vendor_param);
 }
 
+/* Haswell needs to re-issue the vendor-specific verbs before turning to D0.
+ * Otherwise you may get severe h/w communication errors.
+ */
+static void haswell_set_power_state(struct hda_codec *codec, hda_nid_t fg,
+				unsigned int power_state)
+{
+	if (power_state == AC_PWRST_D0) {
+		intel_haswell_enable_all_pins(codec, false);
+		intel_haswell_fixup_enable_dp12(codec);
+	}
 
-
-/* available models for fixup */
-enum {
-	INTEL_HASWELL,
-};
-
-static const struct hda_model_fixup hdmi_models[] = {
-	{.id = INTEL_HASWELL, .name = "Haswell"},
-	{}
-};
-
-static const struct snd_pci_quirk hdmi_fixup_tbl[] = {
-	SND_PCI_QUIRK(0x8086, 0x2010, "Haswell", INTEL_HASWELL),
-	{} /* terminator */
-};
-
-static const struct hda_fixup hdmi_fixups[] = {
-	[INTEL_HASWELL] = {
-		.type = HDA_FIXUP_FUNC,
-		.v.func = intel_haswell_enable_all_pins,
-	},
-};
-
+	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE, power_state);
+	snd_hda_codec_set_power_to_all(codec, fg, power_state);
+}
 
 static int patch_generic_hdmi(struct hda_codec *codec)
 {
@@ -1904,11 +1892,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
-	snd_hda_pick_fixup(codec, hdmi_models, hdmi_fixup_tbl, hdmi_fixups);
-	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
-
-	if (codec->vendor_id == 0x80862807)
+	if (codec->vendor_id == 0x80862807) {
+		intel_haswell_enable_all_pins(codec, true);
 		intel_haswell_fixup_enable_dp12(codec);
+	}
 
 	if (hdmi_parse_codec(codec) < 0) {
 		codec->spec = NULL;
@@ -1916,6 +1903,9 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
+	if (codec->vendor_id == 0x80862807)
+		codec->patch_ops.set_power_state = haswell_set_power_state;
+
 	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
-- 
1.8.2.1
