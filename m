From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 17/18] ALSA: hda: move hda_codec to use hdac
	helpers
Date: Tue,  6 Oct 2015 16:07:54 +0100
Message-ID: <1444144075-28963-18-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 28DA42657BA
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:57 +0200 (CEST)
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

Move hda_codec to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/hda_codec.c | 85 ++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 37f43a1b34ef..c551dda68803 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -145,7 +145,8 @@ EXPORT_SYMBOL_GPL(snd_hda_codec_write);
 void snd_hda_sequence_write(struct hda_codec *codec, const struct hda_verb *seq)
 {
 	for (; seq->nid; seq++)
-		snd_hda_codec_write(codec, seq->nid, 0, seq->verb, seq->param);
+		snd_hdac_codec_write(&codec->core, seq->nid, 0, seq->verb,
+				     seq->param);
 }
 EXPORT_SYMBOL_GPL(snd_hda_sequence_write);
 
@@ -445,11 +446,11 @@ static int read_pin_defaults(struct hda_codec *codec)
 		if (!pin)
 			return -ENOMEM;
 		pin->nid = nid;
-		pin->cfg = snd_hda_codec_read(codec, nid, 0,
-					      AC_VERB_GET_CONFIG_DEFAULT, 0);
-		pin->ctrl = snd_hda_codec_read(codec, nid, 0,
-					       AC_VERB_GET_PIN_WIDGET_CONTROL,
-					       0);
+		pin->cfg = snd_hdac_codec_read(&codec->core, nid, 0,
+					       AC_VERB_GET_CONFIG_DEFAULT, 0);
+		pin->ctrl = snd_hdac_codec_read(&codec->core, nid, 0,
+						AC_VERB_GET_PIN_WIDGET_CONTROL,
+						0);
 	}
 	return 0;
 }
@@ -605,8 +606,8 @@ void snd_hda_shutup_pins(struct hda_codec *codec)
 	for (i = 0; i < codec->init_pins.used; i++) {
 		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
 		/* use read here for syncing after issuing each verb */
-		snd_hda_codec_read(codec, pin->nid, 0,
-				   AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
+		snd_hdac_codec_read(&codec->core, pin->nid, 0,
+				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
 	}
 	codec->pins_shutup = 1;
 }
@@ -623,9 +624,9 @@ static void restore_shutup_pins(struct hda_codec *codec)
 		return;
 	for (i = 0; i < codec->init_pins.used; i++) {
 		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
-		snd_hda_codec_write(codec, pin->nid, 0,
-				    AC_VERB_SET_PIN_WIDGET_CONTROL,
-				    pin->ctrl);
+		snd_hdac_codec_write(&codec->core, pin->nid, 0,
+				     AC_VERB_SET_PIN_WIDGET_CONTROL,
+				     pin->ctrl);
 	}
 	codec->pins_shutup = 0;
 }
@@ -983,12 +984,13 @@ static void update_pcm_stream_id(struct hda_codec *codec,
 	unsigned int oldval, newval;
 
 	if (p->stream_tag != stream_tag || p->channel_id != channel_id) {
-		oldval = snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_CONV, 0);
+		oldval = snd_hdac_codec_read(&codec->core, nid, 0,
+					     AC_VERB_GET_CONV, 0);
 		newval = (stream_tag << 4) | channel_id;
 		if (oldval != newval)
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_CHANNEL_STREAMID,
-					    newval);
+			snd_hdac_codec_write(&codec->core, nid, 0,
+					     AC_VERB_SET_CHANNEL_STREAMID,
+					     newval);
 		p->stream_tag = stream_tag;
 		p->channel_id = channel_id;
 	}
@@ -1001,13 +1003,13 @@ static void update_pcm_format(struct hda_codec *codec, struct hda_cvt_setup *p,
 	unsigned int oldval;
 
 	if (p->format_id != format) {
-		oldval = snd_hda_codec_read(codec, nid, 0,
-					    AC_VERB_GET_STREAM_FORMAT, 0);
+		oldval = snd_hdac_codec_read(&codec->core, nid, 0,
+					     AC_VERB_GET_STREAM_FORMAT, 0);
 		if (oldval != format) {
 			msleep(1);
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_STREAM_FORMAT,
-					    format);
+			snd_hdac_codec_write(&codec->core, nid, 0,
+					     AC_VERB_SET_STREAM_FORMAT,
+					     format);
 		}
 		p->format_id = format;
 	}
@@ -1104,10 +1106,11 @@ static void really_cleanup_stream(struct hda_codec *codec,
 {
 	hda_nid_t nid = q->nid;
 	if (q->stream_tag || q->channel_id)
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CHANNEL_STREAMID, 0);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     AC_VERB_SET_CHANNEL_STREAMID, 0);
 	if (q->format_id)
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_STREAM_FORMAT, 0
-);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     AC_VERB_SET_STREAM_FORMAT, 0);
 	memset(q, 0, sizeof(*q));
 	q->nid = nid;
 	if (codec->patch_ops.stream_pm)
@@ -2812,7 +2815,7 @@ int snd_hda_create_spdif_in_ctls(struct hda_codec *codec, hda_nid_t nid)
 			return err;
 	}
 	codec->spdif_in_enable =
-		snd_hda_codec_read(codec, nid, 0,
+		snd_hdac_codec_read(&codec->core, nid, 0,
 				   AC_VERB_GET_DIGI_CONVERT_1, 0) &
 		AC_DIG1_ENABLE;
 	return 0;
@@ -2844,8 +2847,8 @@ void snd_hda_codec_set_power_to_all(struct hda_codec *codec, hda_nid_t fg,
 			if (state != power_state && power_state == AC_PWRST_D3)
 				continue;
 		}
-		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_POWER_STATE,
-				    state);
+		snd_hdac_codec_write(&codec->core, nid, 0,
+				     AC_VERB_SET_POWER_STATE, state);
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_set_power_to_all);
@@ -2861,8 +2864,8 @@ static unsigned int hda_sync_power_state(struct hda_codec *codec,
 	unsigned int state, actual_state;
 
 	for (;;) {
-		state = snd_hda_codec_read(codec, fg, 0,
-					   AC_VERB_GET_POWER_STATE, 0);
+		state = snd_hdac_codec_read(&codec->core, fg, 0,
+					    AC_VERB_GET_POWER_STATE, 0);
 		if (state & AC_PWRST_ERROR)
 			break;
 		actual_state = (state >> 4) & 0x0f;
@@ -2894,7 +2897,7 @@ unsigned int snd_hda_codec_eapd_power_filter(struct hda_codec *codec,
 	if (power_state == AC_PWRST_D3 &&
 	    get_wcaps_type(get_wcaps(codec, nid)) == AC_WID_PIN &&
 	    (snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_EAPD)) {
-		int eapd = snd_hda_codec_read(codec, nid, 0,
+		int eapd = snd_hdac_codec_read(&codec->core, nid, 0,
 					      AC_VERB_GET_EAPD_BTLENABLE, 0);
 		if (eapd & 0x02)
 			return AC_PWRST_D0;
@@ -2933,9 +2936,9 @@ static unsigned int hda_set_power_state(struct hda_codec *codec,
 			if (codec->power_filter)
 				state = codec->power_filter(codec, fg, state);
 			if (state == power_state || power_state != AC_PWRST_D3)
-				snd_hda_codec_read(codec, fg, flags,
-						   AC_VERB_SET_POWER_STATE,
-						   state);
+				snd_hdac_codec_read(&codec->core, fg, flags,
+						    AC_VERB_SET_POWER_STATE,
+						    state);
 			snd_hda_codec_set_power_to_all(codec, fg, power_state);
 		}
 		state = hda_sync_power_state(codec, fg, power_state);
@@ -2965,9 +2968,9 @@ static void sync_power_up_states(struct hda_codec *codec)
 		target = codec->power_filter(codec, nid, AC_PWRST_D0);
 		if (target == AC_PWRST_D0)
 			continue;
-		if (!snd_hda_check_power_state(codec, nid, target))
-			snd_hda_codec_write(codec, nid, 0,
-					    AC_VERB_SET_POWER_STATE, target);
+		if (!snd_hdac_check_power_state(&codec->core, nid, target))
+			snd_hdac_codec_write(&codec->core, nid, 0,
+					     AC_VERB_SET_POWER_STATE, target);
 	}
 }
 
@@ -3630,8 +3633,8 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 	bool reset;
 
 	spdif = snd_hda_spdif_out_of_nid(codec, nid);
-	curr_fmt = snd_hda_codec_read(codec, nid, 0,
-				      AC_VERB_GET_STREAM_FORMAT, 0);
+	curr_fmt = snd_hdac_codec_read(&codec->core, nid, 0,
+				       AC_VERB_GET_STREAM_FORMAT, 0);
 	reset = codec->spdif_status_reset &&
 		(spdif->ctls & AC_DIG1_ENABLE) &&
 		curr_fmt != format;
@@ -3915,8 +3918,8 @@ unsigned int snd_hda_get_default_vref(struct hda_codec *codec, hda_nid_t pin)
 {
 	unsigned int pincap;
 	unsigned int oldval;
-	oldval = snd_hda_codec_read(codec, pin, 0,
-				    AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	oldval = snd_hdac_codec_read(&codec->core, pin, 0,
+				     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 	pincap = snd_hda_query_pin_caps(codec, pin);
 	pincap = (pincap & AC_PINCAP_VREF) >> AC_PINCAP_VREF_SHIFT;
 	/* Exception: if the default pin setup is vref50, we give it priority */
@@ -3999,7 +4002,7 @@ EXPORT_SYMBOL_GPL(snd_hda_correct_pin_ctl);
  * It corrects the pin ctl value via snd_hda_correct_pin_ctl(), stores the
  * value in pin target array via snd_hda_codec_set_pin_target(), then
  * actually writes the value via either snd_hda_codec_update_cache() or
- * snd_hda_codec_write() depending on @cached flag.
+ * snd_hdac_codec_write() depending on @cached flag.
  */
 int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 			 unsigned int val, bool cached)
@@ -4010,7 +4013,7 @@ int _snd_hda_set_pin_ctl(struct hda_codec *codec, hda_nid_t pin,
 		return snd_hda_codec_update_cache(codec, pin, 0,
 				AC_VERB_SET_PIN_WIDGET_CONTROL, val);
 	else
-		return snd_hda_codec_write(codec, pin, 0,
+		return snd_hdac_codec_write(&codec->core, pin, 0,
 					   AC_VERB_SET_PIN_WIDGET_CONTROL, val);
 }
 EXPORT_SYMBOL_GPL(_snd_hda_set_pin_ctl);
-- 
2.4.3
