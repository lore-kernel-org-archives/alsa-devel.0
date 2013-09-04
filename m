From: mengdong.lin@intel.com
Subject: [PATCH v2 2/2] ALSA: hda - unmute pin amplifier in
	infoframe setup for Haswell
Date: Wed,  4 Sep 2013 16:37:12 -0400
Message-ID: <1378327032-14471-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 03E7A265590
 for <alsa-devel@alsa-project.org>; Thu,  5 Sep 2013 05:35:58 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

When Gfx driver reconnects a port and transcoder, the pin amplifier will
be muted. To enable sound, the pin amp need to be unmuted.

This patch
- moves pin amp unmuting from stream preparing to hdmi_setup_audio_infoframe().
  So if port:transcoder reconnection happens during stream playback, the ELDV
  unsol event can stil trigger pin's amp unmuting when re-setting up audio
  info frame.

- remove reading pin amp status before unmuting for speed-up, since pin amp
  should always be unmuted.

- rename haswell_verify_pin_D0() to haswell_verify_D0(), since the convertor
  power state is also fixed here.

This patch is mostly based on suggestion of David Henningsson.

Cc: David Henningsson <david.henningsson@canonical.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 974b55c..3d8cd044 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -896,6 +896,11 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 	if (!channels)
 		return;
 
+	if (is_haswell(codec))
+		snd_hda_codec_write(codec, pin_nid, 0,
+					    AC_VERB_SET_AMP_GAIN_MUTE,
+					    AMP_OUT_UNMUTE);
+
 	eld = &per_pin->sink_eld;
 	if (!eld->monitor_present)
 		return;
@@ -1035,10 +1040,10 @@ static void hdmi_unsol_event(struct hda_codec *codec, unsigned int res)
 		hdmi_non_intrinsic_event(codec, res);
 }
 
-static void haswell_verify_pin_D0(struct hda_codec *codec,
+static void haswell_verify_D0(struct hda_codec *codec,
 		hda_nid_t cvt_nid, hda_nid_t nid)
 {
-	int pwr, lamp, ramp;
+	int pwr;
 
 	/* For Haswell, the converter 1/2 may keep in D3 state after bootup,
 	 * thus pins could only choose converter 0 for use. Make sure the
@@ -1054,25 +1059,6 @@ static void haswell_verify_pin_D0(struct hda_codec *codec,
 		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
 		snd_printd("Haswell HDMI audio: Power for pin 0x%x is now D%d\n", nid, pwr);
 	}
-
-	lamp = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_AMP_GAIN_MUTE,
-				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
-	ramp = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_AMP_GAIN_MUTE,
-				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
-	if (lamp != ramp) {
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    AC_AMP_SET_RIGHT | AC_AMP_SET_OUTPUT | lamp);
-
-		lamp = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_AMP_GAIN_MUTE,
-				  AC_AMP_GET_LEFT | AC_AMP_GET_OUTPUT);
-		ramp = snd_hda_codec_read(codec, nid, 0,
-				  AC_VERB_GET_AMP_GAIN_MUTE,
-				  AC_AMP_GET_RIGHT | AC_AMP_GET_OUTPUT);
-		snd_printd("Haswell HDMI audio: Mute after set on pin 0x%x: [0x%x 0x%x]\n", nid, lamp, ramp);
-	}
 }
 
 /*
@@ -1090,7 +1076,7 @@ static int hdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 	int new_pinctl = 0;
 
 	if (is_haswell(codec))
-		haswell_verify_pin_D0(codec, cvt_nid, pin_nid);
+		haswell_verify_D0(codec, cvt_nid, pin_nid);
 
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
 		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
@@ -1361,13 +1347,9 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		 * changed during the stream playback
 		 */
 		if (is_haswell(codec) &&
-		    eld->eld_valid && !old_eld_valid && per_pin->setup) {
-			snd_hda_codec_write(codec, pin_nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_UNMUTE);
+		    eld->eld_valid && !old_eld_valid && per_pin->setup)
 			hdmi_setup_audio_infoframe(codec, per_pin,
 						   per_pin->non_pcm);
-		}
 	}
 	mutex_unlock(&pin_eld->lock);
 
-- 
1.8.1.2
