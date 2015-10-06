From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 12/18] ALSA: hda: move patch_hdmi to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:49 +0100
Message-ID: <1444144075-28963-13-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 37ADC265884
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:46 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_hdmi to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 285 +++++++++++++++++++++++----------------------
 1 file changed, 145 insertions(+), 140 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index acbfbe087ee8..e82488ddb9d4 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -488,8 +488,8 @@ static void hdmi_get_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 {
 	int val;
 
-	val = snd_hda_codec_read(codec, pin_nid, 0,
-				 AC_VERB_GET_HDMI_DIP_INDEX, 0);
+	val = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+				  AC_VERB_GET_HDMI_DIP_INDEX, 0);
 
 	*packet_index = val >> 5;
 	*byte_index = val & 0x1f;
@@ -503,13 +503,15 @@ static void hdmi_set_dip_index(struct hda_codec *codec, hda_nid_t pin_nid,
 
 	val = (packet_index << 5) | (byte_index & 0x1f);
 
-	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_INDEX, val);
+	snd_hdac_codec_write(&codec->core, pin_nid, 0,
+			     AC_VERB_SET_HDMI_DIP_INDEX, val);
 }
 
 static void hdmi_write_dip_byte(struct hda_codec *codec, hda_nid_t pin_nid,
 				unsigned char val)
 {
-	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_DATA, val);
+	snd_hdac_codec_write(&codec->core, pin_nid, 0,
+			     AC_VERB_SET_HDMI_DIP_DATA, val);
 }
 
 static void hdmi_init_pin(struct hda_codec *codec, hda_nid_t pin_nid)
@@ -519,8 +521,9 @@ static void hdmi_init_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 
 	/* Unmute */
 	if (get_wcaps(codec, pin_nid) & AC_WCAP_OUT_AMP)
-		snd_hda_codec_write(codec, pin_nid, 0,
-				AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE);
+		snd_hdac_codec_write(&codec->core, pin_nid, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE,
+				     AMP_OUT_UNMUTE);
 
 	if (spec->dyn_pin_out)
 		/* Disable pin out until stream is active */
@@ -531,13 +534,13 @@ static void hdmi_init_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 		 */
 		pin_out = PIN_OUT;
 
-	snd_hda_codec_write(codec, pin_nid, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, pin_out);
+	snd_hdac_codec_write(&codec->core, pin_nid, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, pin_out);
 }
 
 static int hdmi_get_channel_count(struct hda_codec *codec, hda_nid_t cvt_nid)
 {
-	return 1 + snd_hda_codec_read(codec, cvt_nid, 0,
+	return 1 + snd_hdac_codec_read(&codec->core, cvt_nid, 0,
 					AC_VERB_GET_CVT_CHAN_COUNT, 0);
 }
 
@@ -545,8 +548,8 @@ static void hdmi_set_channel_count(struct hda_codec *codec,
 				   hda_nid_t cvt_nid, int chs)
 {
 	if (chs != hdmi_get_channel_count(codec, cvt_nid))
-		snd_hda_codec_write(codec, cvt_nid, 0,
-				    AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
+		snd_hdac_codec_write(&codec->core, cvt_nid, 0,
+				     AC_VERB_SET_CVT_CHAN_COUNT, chs - 1);
 }
 
 /*
@@ -932,7 +935,7 @@ static void hdmi_setup_channel_mapping(struct hda_codec *codec,
 static int hdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
 				     int asp_slot, int channel)
 {
-	return snd_hda_codec_write(codec, pin_nid, 0,
+	return snd_hdac_codec_write(&codec->core, pin_nid, 0,
 				   AC_VERB_SET_HDMI_CHAN_SLOT,
 				   (channel << 4) | asp_slot);
 }
@@ -940,7 +943,7 @@ static int hdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
 static int hdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
 				     int asp_slot)
 {
-	return (snd_hda_codec_read(codec, pin_nid, 0,
+	return (snd_hdac_codec_read(&codec->core, pin_nid, 0,
 				   AC_VERB_GET_HDMI_CHAN_SLOT,
 				   asp_slot) & 0xf0) >> 4;
 }
@@ -956,8 +959,8 @@ static void hdmi_start_infoframe_trans(struct hda_codec *codec,
 				       hda_nid_t pin_nid)
 {
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
-	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
-						AC_DIPXMIT_BEST);
+	snd_hdac_codec_write(&codec->core, pin_nid, 0,
+			     AC_VERB_SET_HDMI_DIP_XMIT, AC_DIPXMIT_BEST);
 }
 
 /*
@@ -967,8 +970,8 @@ static void hdmi_stop_infoframe_trans(struct hda_codec *codec,
 				      hda_nid_t pin_nid)
 {
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
-	snd_hda_codec_write(codec, pin_nid, 0, AC_VERB_SET_HDMI_DIP_XMIT,
-						AC_DIPXMIT_DISABLE);
+	snd_hdac_codec_write(&codec->core, pin_nid, 0,
+			     AC_VERB_SET_HDMI_DIP_XMIT, AC_DIPXMIT_DISABLE);
 }
 
 static void hdmi_debug_dip_size(struct hda_codec *codec, hda_nid_t pin_nid)
@@ -981,8 +984,8 @@ static void hdmi_debug_dip_size(struct hda_codec *codec, hda_nid_t pin_nid)
 	codec_dbg(codec, "HDMI: ELD buf size is %d\n", size);
 
 	for (i = 0; i < 8; i++) {
-		size = snd_hda_codec_read(codec, pin_nid, 0,
-						AC_VERB_GET_HDMI_DIP_SIZE, i);
+		size = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+					   AC_VERB_GET_HDMI_DIP_SIZE, i);
 		codec_dbg(codec, "HDMI: DIP GP[%d] buf size is %d\n", i, size);
 	}
 #endif
@@ -995,8 +998,8 @@ static void hdmi_clear_dip_buffers(struct hda_codec *codec, hda_nid_t pin_nid)
 	int size;
 	int pi, bi;
 	for (i = 0; i < 8; i++) {
-		size = snd_hda_codec_read(codec, pin_nid, 0,
-						AC_VERB_GET_HDMI_DIP_SIZE, i);
+		size = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+					   AC_VERB_GET_HDMI_DIP_SIZE, i);
 		if (size == 0)
 			continue;
 
@@ -1051,14 +1054,14 @@ static bool hdmi_infoframe_uptodate(struct hda_codec *codec, hda_nid_t pin_nid,
 	u8 val;
 	int i;
 
-	if (snd_hda_codec_read(codec, pin_nid, 0, AC_VERB_GET_HDMI_DIP_XMIT, 0)
+	if (snd_hdac_codec_read(&codec->core, pin_nid, 0, AC_VERB_GET_HDMI_DIP_XMIT, 0)
 							    != AC_DIPXMIT_BEST)
 		return false;
 
 	hdmi_set_dip_index(codec, pin_nid, 0x0, 0x0);
 	for (i = 0; i < size; i++) {
-		val = snd_hda_codec_read(codec, pin_nid, 0,
-					 AC_VERB_GET_HDMI_DIP_DATA, 0);
+		val = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+					  AC_VERB_GET_HDMI_DIP_DATA, 0);
 		if (val != dip[i])
 			return false;
 	}
@@ -1130,9 +1133,9 @@ static void hdmi_setup_audio_infoframe(struct hda_codec *codec,
 		return;
 
 	if (is_haswell_plus(codec))
-		snd_hda_codec_write(codec, pin_nid, 0,
-					    AC_VERB_SET_AMP_GAIN_MUTE,
-					    AMP_OUT_UNMUTE);
+		snd_hdac_codec_write(&codec->core, pin_nid, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE,
+				     AMP_OUT_UNMUTE);
 
 	eld = &per_pin->sink_eld;
 
@@ -1251,14 +1254,16 @@ static void haswell_verify_D0(struct hda_codec *codec,
 	/* For Haswell, the converter 1/2 may keep in D3 state after bootup,
 	 * thus pins could only choose converter 0 for use. Make sure the
 	 * converters are in correct power state */
-	if (!snd_hda_check_power_state(codec, cvt_nid, AC_PWRST_D0))
-		snd_hda_codec_write(codec, cvt_nid, 0, AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	if (!snd_hdac_check_power_state(&codec->core, cvt_nid, AC_PWRST_D0))
+		snd_hdac_codec_write(&codec->core, cvt_nid, 0,
+				     AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
 
-	if (!snd_hda_check_power_state(codec, nid, AC_PWRST_D0)) {
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
-				    AC_PWRST_D0);
+	if (!snd_hdac_check_power_state(&codec->core, nid, AC_PWRST_D0)) {
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
 		msleep(40);
-		pwr = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_POWER_STATE, 0);
+		pwr = snd_hdac_codec_read(&codec->core, nid, 0,
+					  AC_VERB_GET_POWER_STATE, 0);
 		pwr = (pwr & AC_PWRST_ACTUAL) >> AC_PWRST_ACTUAL_SHIFT;
 		codec_dbg(codec, "Haswell HDMI audio: Power for pin 0x%x is now D%d\n", nid, pwr);
 	}
@@ -1278,8 +1283,9 @@ static int hdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
 	int pinctl, new_pinctl;
 
 	if (snd_hda_query_pin_caps(codec, pin_nid) & AC_PINCAP_HBR) {
-		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
-					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		pinctl = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+					     AC_VERB_GET_PIN_WIDGET_CONTROL,
+					     0);
 
 		if (pinctl < 0)
 			return hbr ? -EINVAL : 0;
@@ -1297,9 +1303,9 @@ static int hdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
 			    new_pinctl);
 
 		if (pinctl != new_pinctl)
-			snd_hda_codec_write(codec, pin_nid, 0,
-					    AC_VERB_SET_PIN_WIDGET_CONTROL,
-					    new_pinctl);
+			snd_hdac_codec_write(&codec->core, pin_nid, 0,
+					     AC_VERB_SET_PIN_WIDGET_CONTROL,
+					     new_pinctl);
 	} else if (hbr)
 		return -EINVAL;
 
@@ -1375,8 +1381,8 @@ static void intel_verify_pin_cvt_connect(struct hda_codec *codec,
 	int mux_idx, curr;
 
 	mux_idx = per_pin->mux_idx;
-	curr = snd_hda_codec_read(codec, pin_nid, 0,
-					  AC_VERB_GET_CONNECT_SEL, 0);
+	curr = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+				   AC_VERB_GET_CONNECT_SEL, 0);
 	if (curr != mux_idx)
 		snd_hda_codec_write_cache(codec, pin_nid, 0,
 					    AC_VERB_SET_CONNECT_SEL,
@@ -1411,8 +1417,8 @@ static void intel_not_share_assigned_cvt(struct hda_codec *codec,
 		if (nid == pin_nid)
 			continue;
 
-		curr = snd_hda_codec_read(codec, nid, 0,
-					  AC_VERB_GET_CONNECT_SEL, 0);
+		curr = snd_hdac_codec_read(&codec->core, nid, 0,
+					   AC_VERB_GET_CONNECT_SEL, 0);
 		if (curr != mux_idx)
 			continue;
 
@@ -1816,11 +1822,12 @@ static int generic_hdmi_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
 	mutex_unlock(&per_pin->lock);
 
 	if (spec->dyn_pin_out) {
-		pinctl = snd_hda_codec_read(codec, pin_nid, 0,
-					    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		snd_hda_codec_write(codec, pin_nid, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    pinctl | PIN_OUT);
+		pinctl = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+					     AC_VERB_GET_PIN_WIDGET_CONTROL,
+					     0);
+		snd_hdac_codec_write(&codec->core, pin_nid, 0,
+				     AC_VERB_SET_PIN_WIDGET_CONTROL,
+				     pinctl | PIN_OUT);
 	}
 
 	return spec->ops.setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
@@ -1860,11 +1867,14 @@ static int hdmi_pcm_close(struct hda_pcm_stream *hinfo,
 		per_pin = get_pin(spec, pin_idx);
 
 		if (spec->dyn_pin_out) {
-			pinctl = snd_hda_codec_read(codec, per_pin->pin_nid, 0,
-					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-			snd_hda_codec_write(codec, per_pin->pin_nid, 0,
-					    AC_VERB_SET_PIN_WIDGET_CONTROL,
-					    pinctl & ~PIN_OUT);
+			pinctl = snd_hdac_codec_read(&codec->core,
+						     per_pin->pin_nid, 0,
+						     AC_VERB_GET_PIN_WIDGET_CONTROL,
+						     0);
+			snd_hdac_codec_write(&codec->core, per_pin->pin_nid,
+					     0,
+					     AC_VERB_SET_PIN_WIDGET_CONTROL,
+					     pinctl & ~PIN_OUT);
 		}
 
 		snd_hda_spdif_ctls_unassign(codec, pin_idx);
@@ -2278,14 +2288,15 @@ static void intel_haswell_enable_all_pins(struct hda_codec *codec,
 {
 	unsigned int vendor_param;
 
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
-				INTEL_GET_VENDOR_VERB, 0);
+	vendor_param = snd_hdac_codec_read(&codec->core, INTEL_VENDOR_NID, 0,
+				           INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_ALL_PIN_CVTS)
 		return;
 
 	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
-				INTEL_SET_VENDOR_VERB, vendor_param);
+	vendor_param = snd_hdac_codec_read(&codec->core, INTEL_VENDOR_NID, 0,
+				           INTEL_SET_VENDOR_VERB,
+				           vendor_param);
 	if (vendor_param == -1)
 		return;
 
@@ -2297,8 +2308,8 @@ static void intel_haswell_fixup_enable_dp12(struct hda_codec *codec)
 {
 	unsigned int vendor_param;
 
-	vendor_param = snd_hda_codec_read(codec, INTEL_VENDOR_NID, 0,
-				INTEL_GET_VENDOR_VERB, 0);
+	vendor_param = snd_hdac_codec_read(&codec->core, INTEL_VENDOR_NID, 0,
+					   INTEL_GET_VENDOR_VERB, 0);
 	if (vendor_param == -1 || vendor_param & INTEL_EN_DP12)
 		return;
 
@@ -2320,7 +2331,8 @@ static void haswell_set_power_state(struct hda_codec *codec, hda_nid_t fg,
 		intel_haswell_fixup_enable_dp12(codec);
 	}
 
-	snd_hda_codec_read(codec, fg, 0, AC_VERB_SET_POWER_STATE, power_state);
+	snd_hdac_codec_read(&codec->core, fg, 0, AC_VERB_SET_POWER_STATE,
+			    power_state);
 	snd_hda_codec_set_power_to_all(codec, fg, power_state);
 }
 
@@ -2451,12 +2463,13 @@ static int simple_playback_init(struct hda_codec *codec)
 	struct hdmi_spec_per_pin *per_pin = get_pin(spec, 0);
 	hda_nid_t pin = per_pin->pin_nid;
 
-	snd_hda_codec_write(codec, pin, 0,
-			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+	snd_hdac_codec_write(&codec->core, pin, 0,
+			     AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
 	/* some codecs require to unmute the pin */
 	if (get_wcaps(codec, pin) & AC_WCAP_OUT_AMP)
-		snd_hda_codec_write(codec, pin, 0, AC_VERB_SET_AMP_GAIN_MUTE,
-				    AMP_OUT_UNMUTE);
+		snd_hdac_codec_write(&codec->core, pin, 0,
+				     AC_VERB_SET_AMP_GAIN_MUTE,
+				     AMP_OUT_UNMUTE);
 	snd_hda_jack_detect_enable(codec, pin);
 	return 0;
 }
@@ -2684,12 +2697,12 @@ static void nvhdmi_8ch_7x_set_info_frame_parameters(struct hda_codec *codec,
 
 	/* Set the audio infoframe channel allocation and checksum fields.  The
 	 * channel count is computed implicitly by the hardware. */
-	snd_hda_codec_write(codec, 0x1, 0,
-			Nv_VERB_SET_Channel_Allocation, chanmask);
+	snd_hdac_codec_write(&codec->core, 0x1, 0,
+			     Nv_VERB_SET_Channel_Allocation, chanmask);
 
-	snd_hda_codec_write(codec, 0x1, 0,
-			Nv_VERB_SET_Info_Frame_Checksum,
-			(0x71 - chan - chanmask));
+	snd_hdac_codec_write(&codec->core, 0x1, 0,
+			     Nv_VERB_SET_Info_Frame_Checksum,
+			     (0x71 - chan - chanmask));
 }
 
 static int nvhdmi_8ch_7x_pcm_close(struct hda_pcm_stream *hinfo,
@@ -2699,15 +2712,15 @@ static int nvhdmi_8ch_7x_pcm_close(struct hda_pcm_stream *hinfo,
 	struct hdmi_spec *spec = codec->spec;
 	int i;
 
-	snd_hda_codec_write(codec, nvhdmi_master_con_nid_7x,
-			0, AC_VERB_SET_CHANNEL_STREAMID, 0);
+	snd_hdac_codec_write(&codec->core, nvhdmi_master_con_nid_7x, 0,
+			     AC_VERB_SET_CHANNEL_STREAMID, 0);
 	for (i = 0; i < 4; i++) {
 		/* set the stream id */
-		snd_hda_codec_write(codec, nvhdmi_con_nids_7x[i], 0,
-				AC_VERB_SET_CHANNEL_STREAMID, 0);
+		snd_hdac_codec_write(&codec->core, nvhdmi_con_nids_7x[i], 0,
+				     AC_VERB_SET_CHANNEL_STREAMID, 0);
 		/* set the stream format */
-		snd_hda_codec_write(codec, nvhdmi_con_nids_7x[i], 0,
-				AC_VERB_SET_STREAM_FORMAT, 0);
+		snd_hdac_codec_write(&codec->core, nvhdmi_con_nids_7x[i], 0,
+				     AC_VERB_SET_STREAM_FORMAT, 0);
 	}
 
 	/* The audio hardware sends a channel count of 0x7 (8ch) when all the
@@ -2740,32 +2753,27 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 
 	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
 	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
-		snd_hda_codec_write(codec,
-				nvhdmi_master_con_nid_7x,
-				0,
-				AC_VERB_SET_DIGI_CONVERT_1,
-				spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
+		snd_hdac_codec_write(&codec->core, nvhdmi_master_con_nid_7x,
+				     0, AC_VERB_SET_DIGI_CONVERT_1,
+				     spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
 
 	/* set the stream id */
-	snd_hda_codec_write(codec, nvhdmi_master_con_nid_7x, 0,
-			AC_VERB_SET_CHANNEL_STREAMID, (stream_tag << 4) | 0x0);
+	snd_hdac_codec_write(&codec->core, nvhdmi_master_con_nid_7x, 0,
+			     AC_VERB_SET_CHANNEL_STREAMID,
+			     (stream_tag << 4) | 0x0);
 
 	/* set the stream format */
-	snd_hda_codec_write(codec, nvhdmi_master_con_nid_7x, 0,
-			AC_VERB_SET_STREAM_FORMAT, format);
+	snd_hdac_codec_write(&codec->core, nvhdmi_master_con_nid_7x, 0,
+			     AC_VERB_SET_STREAM_FORMAT, format);
 
 	/* turn on again (if needed) */
 	/* enable and set the channel status audio/data flag */
 	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE)) {
-		snd_hda_codec_write(codec,
-				nvhdmi_master_con_nid_7x,
-				0,
-				AC_VERB_SET_DIGI_CONVERT_1,
-				spdif->ctls & 0xff);
-		snd_hda_codec_write(codec,
-				nvhdmi_master_con_nid_7x,
-				0,
-				AC_VERB_SET_DIGI_CONVERT_2, dataDCC2);
+		snd_hdac_codec_write(&codec->core, nvhdmi_master_con_nid_7x,
+				     0, AC_VERB_SET_DIGI_CONVERT_1,
+				     spdif->ctls & 0xff);
+		snd_hdac_codec_write(&codec->core, nvhdmi_master_con_nid_7x,
+				     0, AC_VERB_SET_DIGI_CONVERT_2, dataDCC2);
 	}
 
 	for (i = 0; i < 4; i++) {
@@ -2779,36 +2787,29 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 		 */
 		if (codec->spdif_status_reset &&
 		(spdif->ctls & AC_DIG1_ENABLE))
-			snd_hda_codec_write(codec,
-				nvhdmi_con_nids_7x[i],
-				0,
-				AC_VERB_SET_DIGI_CONVERT_1,
-				spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
+			snd_hdac_codec_write(&codec->core,
+					     nvhdmi_con_nids_7x[i], 0,
+					     AC_VERB_SET_DIGI_CONVERT_1,
+					     spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
 		/* set the stream id */
-		snd_hda_codec_write(codec,
-				nvhdmi_con_nids_7x[i],
-				0,
-				AC_VERB_SET_CHANNEL_STREAMID,
-				(stream_tag << 4) | channel_id);
+		snd_hdac_codec_write(&codec->core, nvhdmi_con_nids_7x[i], 0,
+				     AC_VERB_SET_CHANNEL_STREAMID,
+				     (stream_tag << 4) | channel_id);
 		/* set the stream format */
-		snd_hda_codec_write(codec,
-				nvhdmi_con_nids_7x[i],
-				0,
-				AC_VERB_SET_STREAM_FORMAT,
-				format);
+		snd_hdac_codec_write(&codec->core, nvhdmi_con_nids_7x[i], 0,
+				     AC_VERB_SET_STREAM_FORMAT, format);
 		/* turn on again (if needed) */
 		/* enable and set the channel status audio/data flag */
 		if (codec->spdif_status_reset &&
 		(spdif->ctls & AC_DIG1_ENABLE)) {
-			snd_hda_codec_write(codec,
-					nvhdmi_con_nids_7x[i],
-					0,
-					AC_VERB_SET_DIGI_CONVERT_1,
-					spdif->ctls & 0xff);
-			snd_hda_codec_write(codec,
-					nvhdmi_con_nids_7x[i],
-					0,
-					AC_VERB_SET_DIGI_CONVERT_2, dataDCC2);
+			snd_hdac_codec_write(&codec->core,
+					     nvhdmi_con_nids_7x[i], 0,
+					     AC_VERB_SET_DIGI_CONVERT_1,
+					     spdif->ctls & 0xff);
+			snd_hdac_codec_write(&codec->core,
+					     nvhdmi_con_nids_7x[i], 0,
+					     AC_VERB_SET_DIGI_CONVERT_2,
+					     dataDCC2);
 		}
 	}
 
@@ -3000,21 +3001,19 @@ static void tegra_hdmi_set_format(struct hda_codec *codec, unsigned int format)
 	unsigned int value;
 
 	/* bits [31:30] contain the trigger and valid bits */
-	value = snd_hda_codec_read(codec, NVIDIA_AFG_NID, 0,
-				   NVIDIA_GET_SCRATCH0, 0);
+	value = snd_hdac_codec_read(&codec->core, NVIDIA_AFG_NID, 0,
+				    NVIDIA_GET_SCRATCH0, 0);
 	value = (value >> 24) & 0xff;
 
 	/* bits [15:0] are used to store the HDA format */
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
-			    NVIDIA_SET_SCRATCH0_BYTE0,
-			    (format >> 0) & 0xff);
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
-			    NVIDIA_SET_SCRATCH0_BYTE1,
-			    (format >> 8) & 0xff);
+	snd_hdac_codec_write(&codec->core, NVIDIA_AFG_NID, 0,
+			     NVIDIA_SET_SCRATCH0_BYTE0, (format >> 0) & 0xff);
+	snd_hdac_codec_write(&codec->core, NVIDIA_AFG_NID, 0,
+			     NVIDIA_SET_SCRATCH0_BYTE1, (format >> 8) & 0xff);
 
 	/* bits [16:24] are unused */
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
-			    NVIDIA_SET_SCRATCH0_BYTE2, 0);
+	snd_hdac_codec_write(&codec->core, NVIDIA_AFG_NID, 0,
+			     NVIDIA_SET_SCRATCH0_BYTE2, 0);
 
 	/*
 	 * Bit 30 signals that the data is valid and hence that HDMI audio can
@@ -3032,8 +3031,8 @@ static void tegra_hdmi_set_format(struct hda_codec *codec, unsigned int format)
 	 */
 	value ^= NVIDIA_SCRATCH_TRIGGER;
 
-	snd_hda_codec_write(codec, NVIDIA_AFG_NID, 0,
-			    NVIDIA_SET_SCRATCH0_BYTE3, value);
+	snd_hdac_codec_write(&codec->core, NVIDIA_AFG_NID, 0,
+			     NVIDIA_SET_SCRATCH0_BYTE3, value);
 }
 
 static int tegra_hdmi_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -3176,7 +3175,8 @@ static int atihdmi_pin_get_eld(struct hda_codec *codec, hda_nid_t nid,
 static void atihdmi_pin_setup_infoframe(struct hda_codec *codec, hda_nid_t pin_nid, int ca,
 					int active_channels, int conn_type)
 {
-	snd_hda_codec_write(codec, pin_nid, 0, ATI_VERB_SET_CHANNEL_ALLOCATION, ca);
+	snd_hdac_codec_write(&codec->core, pin_nid, 0,
+			     ATI_VERB_SET_CHANNEL_ALLOCATION, ca);
 }
 
 static int atihdmi_paired_swap_fc_lfe(int pos)
@@ -3275,7 +3275,7 @@ static int atihdmi_pin_set_slot_channel(struct hda_codec *codec, hda_nid_t pin_n
 	if (stream_channel != 0xf)
 		ati_channel_setup = (stream_channel << 4) | ATI_OUT_ENABLE;
 
-	return snd_hda_codec_write(codec, pin_nid, 0, verb, ati_channel_setup);
+	return snd_hdac_codec_write(&codec->core, pin_nid, 0, verb, ati_channel_setup);
 }
 
 static int atihdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_nid,
@@ -3299,7 +3299,8 @@ static int atihdmi_pin_get_slot_channel(struct hda_codec *codec, hda_nid_t pin_n
 
 	verb = ATI_VERB_GET_MULTICHANNEL_01 + ati_asp_slot/2 + (ati_asp_slot % 2) * 0x00e;
 
-	ati_channel_setup = snd_hda_codec_read(codec, pin_nid, 0, verb, 0);
+	ati_channel_setup = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+						verb, 0);
 
 	if (!(ati_channel_setup & ATI_OUT_ENABLE))
 		return 0xf;
@@ -3364,7 +3365,8 @@ static int atihdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
 {
 	int hbr_ctl, hbr_ctl_new;
 
-	hbr_ctl = snd_hda_codec_read(codec, pin_nid, 0, ATI_VERB_GET_HBR_CONTROL, 0);
+	hbr_ctl = snd_hdac_codec_read(&codec->core, pin_nid, 0,
+				      ATI_VERB_GET_HBR_CONTROL, 0);
 	if (hbr_ctl >= 0 && (hbr_ctl & ATI_HBR_CAPABLE)) {
 		if (hbr)
 			hbr_ctl_new = hbr_ctl | ATI_HBR_ENABLE;
@@ -3378,9 +3380,9 @@ static int atihdmi_pin_hbr_setup(struct hda_codec *codec, hda_nid_t pin_nid,
 				hbr_ctl_new);
 
 		if (hbr_ctl != hbr_ctl_new)
-			snd_hda_codec_write(codec, pin_nid, 0,
-						ATI_VERB_SET_HBR_CONTROL,
-						hbr_ctl_new);
+			snd_hdac_codec_write(&codec->core, pin_nid, 0,
+					     ATI_VERB_SET_HBR_CONTROL,
+					     hbr_ctl_new);
 
 	} else if (hbr)
 		return -EINVAL;
@@ -3398,7 +3400,8 @@ static int atihdmi_setup_stream(struct hda_codec *codec, hda_nid_t cvt_nid,
 		if (format & AC_FMT_TYPE_NON_PCM)
 			ramp_rate = 0;
 
-		snd_hda_codec_write(codec, cvt_nid, 0, ATI_VERB_SET_RAMP_RATE, ramp_rate);
+		snd_hdac_codec_write(&codec->core, cvt_nid, 0,
+				     ATI_VERB_SET_RAMP_RATE, ramp_rate);
 	}
 
 	return hdmi_setup_stream(codec, cvt_nid, pin_nid, stream_tag, format);
@@ -3419,13 +3422,15 @@ static int atihdmi_init(struct hda_codec *codec)
 		struct hdmi_spec_per_pin *per_pin = get_pin(spec, pin_idx);
 
 		/* make sure downmix information in infoframe is zero */
-		snd_hda_codec_write(codec, per_pin->pin_nid, 0, ATI_VERB_SET_DOWNMIX_INFO, 0);
+		snd_hdac_codec_write(&codec->core, per_pin->pin_nid, 0,
+				     ATI_VERB_SET_DOWNMIX_INFO, 0);
 
 		/* enable channel-wise remap mode if supported */
 		if (has_amd_full_remap_support(codec))
-			snd_hda_codec_write(codec, per_pin->pin_nid, 0,
-					    ATI_VERB_SET_MULTICHANNEL_MODE,
-					    ATI_MULTICHANNEL_MODE_SINGLE);
+			snd_hdac_codec_write(&codec->core, per_pin->pin_nid,
+					     0,
+					     ATI_VERB_SET_MULTICHANNEL_MODE,
+					     ATI_MULTICHANNEL_MODE_SINGLE);
 	}
 
 	return 0;
-- 
2.4.3
