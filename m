From: mengdong.lin@intel.com
Subject: [PATCH 3/3] ALSA: hda/hdmi - apply all Haswell fix-ups
	to Broadwell display codec
Date: Wed,  8 Jan 2014 15:55:32 -0500
Message-ID: <dcdc2e509a9830f6a2c3e770b1e78ab3ff2d89a2.1389214150.git.mengdong.lin@intel.com>
References: <cover.1389214150.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 707442651F3
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 04:50:43 +0100 (CET)
In-Reply-To: <cover.1389214150.git.mengdong.lin@intel.com>
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

Broadwell and Haswell have the same behavior on display audio. So this patch
defines is_haswell_plus() to include codecs for both Haswell and its successor
Broadwell, and apply all Haswell fix-ups to Broadwell.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 670da3e..64f0a5e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -46,6 +46,9 @@ module_param(static_hdmi_pcm, bool, 0644);
 MODULE_PARM_DESC(static_hdmi_pcm, "Don't restrict PCM parameters per ELD info");
 
 #define is_haswell(codec)  ((codec)->vendor_id == 0x80862807)
+#define is_broadwell(codec)    ((codec)->vendor_id == 0x80862808)
+#define is_haswell_plus(codec) (is_haswell(codec) || is_broadwell(codec))
+
 #define is_valleyview(codec) ((codec)->vendor_id == 0x80862882)
 
 struct hdmi_spec_per_cvt {
@@ -1101,7 +1104,7 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	if (!channels)
 		return;
 
-	if (is_haswell(codec))
+	if (is_haswell_plus(codec))
 		snd_hda_codec_write(codec, pin_nid, 0,
 					    AC_VERB_SET_AMP_GAIN_MUTE,
 					    AMP_OUT_UNMUTE);
@@ -1280,7 +1283,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	struct hdmi_spec *spec = codec->spec;
 	int err;
 
-	if (is_haswell(codec))
+	if (is_haswell_plus(codec))
 		haswell_verify_D0(codec, cvt_nid, pin_nid);
 
 	err = spec->ops.pin_hbr_setup(codec, pin_nid, is_hbr_format(format));
@@ -1421,7 +1424,7 @@ static int hdmi_pcm_open(struct hda_pcm_stream *hinfo,
 			    mux_idx);
 
 	/* configure unused pins to choose other converters */
-	if (is_haswell(codec) || is_valleyview(codec))
+	if (is_haswell_plus(codec) || is_valleyview(codec))
 		intel_not_share_assigned_cvt(codec, per_pin->pin_nid, mux_idx);
 
 	snd_hda_spdif_ctls_assign(codec, pin_idx, per_cvt->cvt_nid);
@@ -1611,7 +1614,7 @@ static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 	if (get_defcfg_connect(config) == AC_JACK_PORT_NONE)
 		return 0;
 
-	if (is_haswell(codec))
+	if (is_haswell_plus(codec))
 		intel_haswell_fixup_connect_list(codec, pin_nid);
 
 	pin_idx = spec->num_pins;
@@ -2249,7 +2252,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 	codec->spec = spec;
 	hdmi_array_init(spec, 4);
 
-	if (is_haswell(codec)) {
+	if (is_haswell_plus(codec)) {
 		intel_haswell_enable_all_pins(codec, true);
 		intel_haswell_fixup_enable_dp12(codec);
 	}
@@ -2264,7 +2267,7 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
-	if (is_haswell(codec)) {
+	if (is_haswell_plus(codec)) {
 		codec->patch_ops.set_power_state = haswell_set_power_state;
 		codec->dp_mst = true;
 	}
-- 
1.8.1.2
