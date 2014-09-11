From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 1/7] ALSA: hda - Get rid of action field
	from struct hda_jack_tbl
Date: Thu, 11 Sep 2014 16:19:11 +0200
Message-ID: <1410445157-23198-2-git-send-email-tiwai@suse.de>
References: <1410445157-23198-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CA3FF2656E2
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:19:20 +0200 (CEST)
In-Reply-To: <1410445157-23198-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The action value assigned to each hda_jack_tbl entry is mostly
superfluous.  The actually used values are either the widget NID or a
value specific to the callback.

The former case can be simply replaced by a reference to widget NID
itself.  The only place doing the latter is STAC/IDT codec driver for
the powermap handling.  But, the code doesn't need to check the action
field at all -- the function jack_update_power() is called either with
a specific pin or with NULL.  So the check of jack->action can be
removed completely there, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c    |  4 +---
 sound/pci/hda/hda_generic.h    |  6 ------
 sound/pci/hda/hda_jack.c       | 10 +++-------
 sound/pci/hda/hda_jack.h       | 22 +---------------------
 sound/pci/hda/patch_ca0132.c   | 16 +++++++++-------
 sound/pci/hda/patch_cirrus.c   |  3 ---
 sound/pci/hda/patch_hdmi.c     |  4 ++--
 sound/pci/hda/patch_realtek.c  |  9 +++------
 sound/pci/hda/patch_sigmatel.c | 18 ++++--------------
 sound/pci/hda/patch_via.c      |  4 ----
 10 files changed, 23 insertions(+), 73 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 95121e818b4d..4d605e4ac41c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4180,7 +4180,7 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 		if (!is_jack_detectable(codec, nid))
 			continue;
 		codec_dbg(codec, "Enable HP auto-muting on NID 0x%x\n", nid);
-		snd_hda_jack_detect_enable_callback(codec, nid, HDA_GEN_HP_EVENT,
+		snd_hda_jack_detect_enable_callback(codec, nid,
 						    call_hp_automute);
 		spec->detect_hp = 1;
 	}
@@ -4193,7 +4193,6 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 					continue;
 				codec_dbg(codec, "Enable Line-Out auto-muting on NID 0x%x\n", nid);
 				snd_hda_jack_detect_enable_callback(codec, nid,
-								    HDA_GEN_FRONT_EVENT,
 								    call_line_automute);
 				spec->detect_lo = 1;
 			}
@@ -4235,7 +4234,6 @@ static bool auto_mic_check_imux(struct hda_codec *codec)
 	for (i = 1; i < spec->am_num_entries; i++)
 		snd_hda_jack_detect_enable_callback(codec,
 						    spec->am_entry[i].pin,
-						    HDA_GEN_MIC_EVENT,
 						    call_mic_autoswitch);
 	return true;
 }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 3f95f1d3f1f8..72f5624125fb 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -12,12 +12,6 @@
 #ifndef __SOUND_HDA_GENERIC_H
 #define __SOUND_HDA_GENERIC_H
 
-/* unsol event tags */
-enum {
-	HDA_GEN_HP_EVENT = 1, HDA_GEN_FRONT_EVENT, HDA_GEN_MIC_EVENT,
-	HDA_GEN_LAST_EVENT = HDA_GEN_MIC_EVENT
-};
-
 /* table entry for multi-io paths */
 struct hda_multi_io {
 	hda_nid_t pin;		/* multi-io widget pin NID */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 9746d73cec52..9c8f24f2d56b 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -217,7 +217,6 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_detect_state);
  * snd_hda_jack_detect_enable - enable the jack-detection
  */
 int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
-					unsigned char action,
 					hda_jack_callback cb)
 {
 	struct hda_jack_tbl *jack = snd_hda_jack_tbl_new(codec, nid);
@@ -226,8 +225,6 @@ int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 	if (jack->jack_detect)
 		return 0; /* already registered */
 	jack->jack_detect = 1;
-	if (action)
-		jack->action = action;
 	if (cb)
 		jack->callback = cb;
 	if (codec->jackpoll_interval > 0)
@@ -238,10 +235,9 @@ int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable_callback);
 
-int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid,
-			       unsigned char action)
+int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid)
 {
-	return snd_hda_jack_detect_enable_callback(codec, nid, action, NULL);
+	return snd_hda_jack_detect_enable_callback(codec, nid, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_hda_jack_detect_enable);
 
@@ -431,7 +427,7 @@ static int add_jack_kctl(struct hda_codec *codec, hda_nid_t nid,
 		return err;
 
 	if (!phantom_jack)
-		return snd_hda_jack_detect_enable(codec, nid, 0);
+		return snd_hda_jack_detect_enable(codec, nid);
 	return 0;
 }
 
diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index 46e1ea83ce3c..c1abc7324d68 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -19,7 +19,6 @@ typedef void (*hda_jack_callback) (struct hda_codec *, struct hda_jack_tbl *);
 
 struct hda_jack_tbl {
 	hda_nid_t nid;
-	unsigned char action;		/* event action (0 = none) */
 	unsigned char tag;		/* unsol event tag */
 	unsigned int private_data;	/* arbitrary data */
 	hda_jack_callback callback;
@@ -47,29 +46,10 @@ struct hda_jack_tbl *
 snd_hda_jack_tbl_new(struct hda_codec *codec, hda_nid_t nid);
 void snd_hda_jack_tbl_clear(struct hda_codec *codec);
 
-/**
- * snd_hda_jack_get_action - get jack-tbl entry for the tag
- *
- * Call this from the unsol event handler to get the assigned action for the
- * event.  This will mark the dirty flag for the later reporting, too.
- */
-static inline unsigned char
-snd_hda_jack_get_action(struct hda_codec *codec, unsigned int tag)
-{
-	struct hda_jack_tbl *jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
-	if (jack) {
-		jack->jack_dirty = 1;
-		return jack->action;
-	}
-	return 0;
-}
-
 void snd_hda_jack_set_dirty_all(struct hda_codec *codec);
 
-int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid,
-			       unsigned char action);
+int snd_hda_jack_detect_enable(struct hda_codec *codec, hda_nid_t nid);
 int snd_hda_jack_detect_enable_callback(struct hda_codec *codec, hda_nid_t nid,
-					unsigned char action,
 					hda_jack_callback cb);
 
 int snd_hda_jack_set_gating_jack(struct hda_codec *codec, hda_nid_t gated_nid,
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 5d8455e2dacd..39fae52258f0 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4116,8 +4116,8 @@ static void init_input(struct hda_codec *codec, hda_nid_t pin, hda_nid_t adc)
 
 static void ca0132_init_unsol(struct hda_codec *codec)
 {
-	snd_hda_jack_detect_enable(codec, UNSOL_TAG_HP, UNSOL_TAG_HP);
-	snd_hda_jack_detect_enable(codec, UNSOL_TAG_AMIC1, UNSOL_TAG_AMIC1);
+	snd_hda_jack_detect_enable(codec, UNSOL_TAG_HP);
+	snd_hda_jack_detect_enable(codec, UNSOL_TAG_AMIC1);
 }
 
 static void refresh_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir)
@@ -4406,16 +4406,18 @@ static void ca0132_process_dsp_response(struct hda_codec *codec)
 static void ca0132_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	struct ca0132_spec *spec = codec->spec;
+	unsigned int tag = (res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f;
 
-	if (((res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f) == UNSOL_TAG_DSP) {
+	if (tag == UNSOL_TAG_DSP) {
 		ca0132_process_dsp_response(codec);
 	} else {
-		res = snd_hda_jack_get_action(codec,
-				(res >> AC_UNSOL_RES_TAG_SHIFT) & 0x3f);
+		struct hda_jack_tbl *jack;
 
 		codec_dbg(codec, "snd_hda_jack_get_action: 0x%x\n", res);
-
-		switch (res) {
+		jack = snd_hda_jack_tbl_get_from_tag(codec, tag);
+		if (!jack)
+			return;
+		switch (jack->nid) {
 		case UNSOL_TAG_HP:
 			/* Delay enabling the HP amp, to let the mic-detection
 			 * state machine run.
diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 3db724eaa53c..69b0ffc55a51 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -135,8 +135,6 @@ enum {
 #define CS421X_IDX_DAC_CFG	0x03
 #define CS421X_IDX_SPK_CTL	0x04
 
-#define SPDIF_EVENT		0x04
-
 /* Cirrus Logic CS4213 is like CS4210 but does not have SPDIF input/output */
 #define CS4213_VENDOR_NID	0x09
 
@@ -1019,7 +1017,6 @@ static void parse_cs421x_digital(struct hda_codec *codec)
 		if (get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP) {
 			spec->spdif_detect = 1;
 			snd_hda_jack_detect_enable_callback(codec, nid,
-							    SPDIF_EVENT,
 							    cs4210_spdif_automute);
 		}
 	}
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 99d7d7fecaad..8f94527f1890 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -2165,7 +2165,7 @@ static int generic_hdmi_init(struct hda_codec *codec)
 		hda_nid_t pin_nid = per_pin->pin_nid;
 
 		hdmi_init_pin(codec, pin_nid);
-		snd_hda_jack_detect_enable_callback(codec, pin_nid, pin_nid,
+		snd_hda_jack_detect_enable_callback(codec, pin_nid,
 			codec->jackpoll_interval > 0 ? jack_callback : NULL);
 	}
 	return 0;
@@ -2428,7 +2428,7 @@ static int simple_playback_init(struct hda_codec *codec)
 	if (get_wcaps(codec, pin) & AC_WCAP_OUT_AMP)
 		snd_hda_codec_write(codec, pin, 0, AC_VERB_SET_AMP_GAIN_MUTE,
 				    AMP_OUT_UNMUTE);
-	snd_hda_jack_detect_enable(codec, pin, pin);
+	snd_hda_jack_detect_enable(codec, pin);
 	return 0;
 }
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6b1a5de07e35..ac00420e59ff 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -40,9 +40,6 @@
 /* keep halting ALC5505 DSP, for power saving */
 #define HALT_REALTEK_ALC5505
 
-/* unsol event tags */
-#define ALC_DCVOL_EVENT		0x08
-
 /* for GPIO Poll */
 #define GPIO_MASK	0x03
 
@@ -1130,7 +1127,8 @@ static void alc880_fixup_vol_knob(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
 	if (action == HDA_FIXUP_ACT_PROBE)
-		snd_hda_jack_detect_enable_callback(codec, 0x21, ALC_DCVOL_EVENT, alc_update_knob_master);
+		snd_hda_jack_detect_enable_callback(codec, 0x21,
+						    alc_update_knob_master);
 }
 
 static const struct hda_fixup alc880_fixups[] = {
@@ -1593,7 +1591,7 @@ static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
 		spec->gen.detect_hp = 1;
 		spec->gen.automute_speaker = 1;
 		spec->gen.autocfg.hp_pins[0] = 0x0f; /* copy it for automute */
-		snd_hda_jack_detect_enable_callback(codec, 0x0f, HDA_GEN_HP_EVENT,
+		snd_hda_jack_detect_enable_callback(codec, 0x0f,
 						    snd_hda_gen_hp_automute);
 		snd_hda_add_verbs(codec, alc_gpio1_init_verbs);
 	}
@@ -4254,7 +4252,6 @@ static void alc282_fixup_asus_tx300(struct hda_codec *codec,
 		spec->gen.auto_mute_via_amp = 1;
 		spec->gen.automute_hook = asus_tx300_automute;
 		snd_hda_jack_detect_enable_callback(codec, 0x1b,
-						    HDA_GEN_HP_EVENT,
 						    snd_hda_gen_hp_automute);
 		break;
 	case HDA_FIXUP_ACT_BUILD:
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 60aebd0f5e56..bc371cfb5d84 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -40,11 +40,6 @@
 #include "hda_generic.h"
 
 enum {
-	STAC_VREF_EVENT	= 8,
-	STAC_PWR_EVENT,
-};
-
-enum {
 	STAC_REF,
 	STAC_9200_OQO,
 	STAC_9200_DELL_D21,
@@ -505,13 +500,11 @@ static void jack_update_power(struct hda_codec *codec,
 	for (i = 0; i < spec->num_pwrs; i++) {
 		hda_nid_t nid = spec->pwr_nids[i];
 		jack = snd_hda_jack_tbl_get(codec, nid);
-		if (!jack || !jack->action)
+		if (!jack)
 			continue;
-		if (jack->action == STAC_PWR_EVENT ||
-		    jack->action <= HDA_GEN_LAST_EVENT)
-			stac_toggle_power_map(codec, nid,
-					      snd_hda_jack_detect(codec, nid),
-					      false);
+		stac_toggle_power_map(codec, nid,
+				      snd_hda_jack_detect(codec, nid),
+				      false);
 	}
 
 	snd_hda_codec_write(codec, codec->afg, 0, AC_VERB_IDT_SET_POWER_MAP,
@@ -568,7 +561,6 @@ static void stac_init_power_map(struct hda_codec *codec)
 		    spec->vref_mute_led_nid != nid &&
 		    is_jack_detectable(codec, nid)) {
 			snd_hda_jack_detect_enable_callback(codec, nid,
-							    STAC_PWR_EVENT,
 							    jack_update_power);
 		} else {
 			if (def_conf == AC_JACK_PORT_NONE)
@@ -3028,7 +3020,6 @@ static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
 	snd_hda_codec_write_cache(codec, codec->afg, 0,
 				  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
 	snd_hda_jack_detect_enable_callback(codec, codec->afg,
-					    STAC_VREF_EVENT,
 					    stac_vref_event);
 	jack = snd_hda_jack_tbl_get(codec, codec->afg);
 	if (jack)
@@ -4052,7 +4043,6 @@ static void stac9205_fixup_dell_m43(struct hda_codec *codec,
 		snd_hda_codec_write_cache(codec, codec->afg, 0,
 			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
 		snd_hda_jack_detect_enable_callback(codec, codec->afg,
-						    STAC_VREF_EVENT,
 						    stac_vref_event);
 		jack = snd_hda_jack_tbl_get(codec, codec->afg);
 		if (jack)
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 778166259b3e..2a8be5a5da15 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -592,8 +592,6 @@ static void via_jack_powerstate_event(struct hda_codec *codec, struct hda_jack_t
 	set_widgets_power_state(codec);
 }
 
-#define VIA_JACK_EVENT	(HDA_GEN_LAST_EVENT + 1)
-
 static void via_set_jack_unsol_events(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
@@ -610,7 +608,6 @@ static void via_set_jack_unsol_events(struct hda_codec *codec)
 		if (pin && !snd_hda_jack_tbl_get(codec, pin) &&
 		    is_jack_detectable(codec, pin))
 			snd_hda_jack_detect_enable_callback(codec, pin,
-							    VIA_JACK_EVENT,
 							    via_jack_powerstate_event);
 	}
 
@@ -619,7 +616,6 @@ static void via_set_jack_unsol_events(struct hda_codec *codec)
 		if (pin && !snd_hda_jack_tbl_get(codec, pin) &&
 		    is_jack_detectable(codec, pin))
 			snd_hda_jack_detect_enable_callback(codec, pin,
-							    VIA_JACK_EVENT,
 							    via_jack_powerstate_event);
 	}
 }
-- 
2.1.0
