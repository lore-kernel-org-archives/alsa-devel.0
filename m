From: mengdong.lin@intel.com
Subject: [PATCH v2 1/2] ALSA: hda - define is_haswell() to
	check if a display audio codec is Haswell
Date: Wed,  4 Sep 2013 16:36:57 -0400
Message-ID: <1378327017-14431-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E0A9426559E
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2013 05:36:00 +0200 (CEST)
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

To apply Haswell specific fixings, this patch defines is_haswell() to check
whether a display audio codec is Haswell, to avoid explicitly checking Haswell
vendor ID everywhere.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 9a58893..974b55c 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -44,6 +44,8 @@ static bool static_hdmi_pcm;
 module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
+#define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
+
 struct hdmi_spec_per_cvt {
 	hda_nid_t cvt_nid;
 	int assigned;
@@ -1087,7 +1089,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	int pinctl;
 	int new_pinctl = 0;
 
-	if (codec->vendor_id == 0x80862807)
+	if (is_haswell(codec))
 		haswell_verify_pin_D0(codec, cvt_nid, pin_nid);
 
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
@@ -1227,7 +1229,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 			    mux_idx);
 
 	/* configure unused pins to choose other converters */
-	if (codec->vendor_id == 0x80862807)
+	if (is_haswell(codec))
 		haswell_config_cvts(codec, pin_idx, mux_idx);
 
 	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
@@ -1358,7 +1360,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		/* Haswell-specific workaround: re-setup when the transcoder is
 		 * changed during the stream playback
 		 */
-		if (codec->vendor_id == 0x80862807 &&
+		if (is_haswell(codec) &&
 		    eld->eld_valid && !old_eld_valid && per_pin->setup) {
 			snd_hda_codec_write(codec, pin_nid, 0,
 					    AC_VERB_SET_AMP_GAIN_MUTE,
@@ -1405,7 +1407,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
 		return 0;
 
-	if (codec->vendor_id == 0x80862807)
+	if (is_haswell(codec))
 		intel_haswell_fixup_connect_list(codec, pin_nid);
 
 	pin_idx = spec->num_pins;
@@ -2014,7 +2016,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
-	if (codec->vendor_id == 0x80862807) {
+	if (is_haswell(codec)) {
 		intel_haswell_enable_all_pins(codec, true);
 		intel_haswell_fixup_enable_dp12(codec);
 	}
@@ -2025,7 +2027,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
-	if (codec->vendor_id == 0x80862807) {
+	if (is_haswell(codec)) {
 		codec->patch_ops.set_power_state = haswell_set_power_state;
 		codec->dp_mst = true;
 	}
-- 
1.8.1.2
