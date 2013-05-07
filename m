From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - re-apply fixup when resuming
	haswell hdmi codec
Date: Tue,  7 May 2013 11:55:20 -0400
Message-ID: <1367942120-21382-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 943702608EE
 for <alsa-devel@alsa-project.org>; Tue,  7 May 2013 10:47:58 +0200 (CEST)
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

This patch is a supplement to a previous patch:
"ALSA: hda - Add fixup for Haswell to enable all pin and convertor widgets".

Some Haswell BIOS will disable the 2nd and 3rd pin/covertor widgets when the
HD-A controller changes state from D3 to D0. So when the controller resumes
after a system or runtime suspend, these widgets are disabled and programming
these widgets to D0 will cause H/W error and codec will not respond.

So this patch adds a "set_power_state" ops for Haswell codec. Before setting
the codec to D0, this function will apply a BIOS-specific fixup to enable the
2nd & 3rd pins/cvts if need.

And since BIOS will also disable DP1.2, so this function will check and enable
DP1.2 mode if need.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index adb5dce..9ecb55c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1842,7 +1842,7 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 {
 	unsigned int vendor_param;
 
-	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+	if (action != HDA_FIXUP_ACT_PRE_PROBE && action != HDA_FIXUP_ACT_INIT)
 		return;
 	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
 				INTEL_GET_VENDOR_VERB, 0);
@@ -1855,7 +1855,8 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 	if (vendor_param == -1)
 		return;
 
-	snd_hda_codec_update_widgets(codec);
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		snd_hda_codec_update_widgets(codec);
 	return;
 }
 
@@ -1874,7 +1875,27 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 				INTEL_SET_VENDOR_VERB, vendor_param);
 }
 
+static void haswell_set_power_state(struct hda_codec *codec, hda_nid_t fg,
+				unsigned int power_state)
+{
+	unsigned int state;
+	unsigned int vendor_param;
+
+	if (AC_PWRST_D0 == power_state) {
+		snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_INIT);
+
+		intel_haswell_fixup_enable_dp12(codec);
+
+	}
 
+	snd_hda_codec_read(codec, fg, 0,
+					   AC_VERB_SET_POWER_STATE,
+					   power_state);
+
+	snd_hda_codec_set_power_to_all(codec, fg, power_state);
+
+	return;
+}
 
 /* available models for fixup */
 enum {
@@ -1922,6 +1943,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
+
+	if (codec->vendor_id == 0x80862807)
+		codec->patch_ops.set_power_state = haswell_set_power_state;
+
 	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
-- 
1.7.10.4
