From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 04/10] hda - introduce snd_hda_jack_detect()
	and snd_hda_pin_sense()
Date: Wed, 18 Nov 2009 12:38:02 +0800
Message-ID: <20091118043935.170406864@intel.com>
References: <20091118043758.141785140@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id AC7C9103938
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 05:42:50 +0100 (CET)
Content-Disposition: inline; filename=hda-pin-sense.patch
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

This helps merge duplicate code.

v2: add snd_hda_jack_detect() and comments recommended by Takashi.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.c     |   34 +++++
 sound/pci/hda/hda_eld.c       |    7 -
 sound/pci/hda/hda_local.h     |    2 
 sound/pci/hda/patch_cirrus.c  |   19 --
 sound/pci/hda/patch_realtek.c |  206 +++++++-------------------------
 5 files changed, 91 insertions(+), 177 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.c	2009-11-18 10:00:11.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.c	2009-11-18 12:29:42.000000000 +0800
@@ -1229,6 +1229,40 @@ u32 snd_hda_query_pin_caps(struct hda_co
 }
 EXPORT_SYMBOL_HDA(snd_hda_query_pin_caps);
 
+/**
+ * snd_hda_pin_sense - execute pin sense measurement
+ * @codec: the CODEC to sense
+ * @nid: the pin NID to sense
+ *
+ * Execute necessary pin sense measurement and return its Presence Detect,
+ * Impedance, ELD Valid etc. status bits.
+ */
+u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid)
+{
+	u32 pincap = snd_hda_query_pin_caps(codec, nid);
+
+	if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
+		snd_hda_codec_read(codec, nid, 0, AC_VERB_SET_PIN_SENSE, 0);
+
+	return snd_hda_codec_read(codec, nid, 0,
+				  AC_VERB_GET_PIN_SENSE, 0);
+}
+EXPORT_SYMBOL_HDA(snd_hda_pin_sense);
+
+/**
+ * snd_hda_jack_detect - query pin Presence Detect status
+ * @codec: the CODEC to sense
+ * @nid: the pin NID to sense
+ *
+ * Query and return the pin's Presence Detect status.
+ */
+int snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid)
+{
+        u32 sense = snd_hda_pin_sense(codec, nid);
+        return !!(sense & AC_PINSENSE_PRESENCE);
+}
+EXPORT_SYMBOL_HDA(snd_hda_jack_detect);
+
 /*
  * read the current volume to info
  * if the cache exists, read the cache value.
--- sound-2.6.orig/sound/pci/hda/hda_local.h	2009-11-18 10:00:15.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_local.h	2009-11-18 10:02:28.000000000 +0800
@@ -424,6 +424,8 @@ u32 query_amp_caps(struct hda_codec *cod
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps);
 u32 snd_hda_query_pin_caps(struct hda_codec *codec, hda_nid_t nid);
+u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid);
+int snd_hda_jack_detect(struct hda_codec *codec, hda_nid_t nid);
 
 int snd_hda_ctl_add(struct hda_codec *codec, struct snd_kcontrol *kctl);
 void snd_hda_ctls_clear(struct hda_codec *codec);
--- sound-2.6.orig/sound/pci/hda/patch_realtek.c	2009-11-18 10:00:11.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_realtek.c	2009-11-18 10:27:08.000000000 +0800
@@ -961,16 +961,10 @@ static void alc_fix_pll_init(struct hda_
 static void alc_automute_pin(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int present, pincap;
 	unsigned int nid = spec->autocfg.hp_pins[0];
 	int i;
 
-	pincap = snd_hda_query_pin_caps(codec, nid);
-	if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
-		snd_hda_codec_read(codec, nid, 0, AC_VERB_SET_PIN_SENSE, 0);
-	present = snd_hda_codec_read(codec, nid, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+	spec->jack_present = snd_hda_jack_detect(codec, nid);
 	for (i = 0; i < ARRAY_SIZE(spec->autocfg.speaker_pins); i++) {
 		nid = spec->autocfg.speaker_pins[i];
 		if (!nid)
@@ -1010,9 +1004,7 @@ static void alc_mic_automute(struct hda_
 
 	cap_nid = spec->capsrc_nids ? spec->capsrc_nids[0] : spec->adc_nids[0];
 
-	present = snd_hda_codec_read(codec, spec->ext_mic.pin, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	present &= AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, spec->ext_mic.pin);
 	if (present) {
 		alive = &spec->ext_mic;
 		dead = &spec->int_mic;
@@ -1511,7 +1503,7 @@ static struct hda_verb alc888_fujitsu_xa
 static void alc_automute_amp(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int val, mute, pincap;
+	unsigned int mute;
 	hda_nid_t nid;
 	int i;
 
@@ -1520,13 +1512,7 @@ static void alc_automute_amp(struct hda_
 		nid = spec->autocfg.hp_pins[i];
 		if (!nid)
 			break;
-		pincap = snd_hda_query_pin_caps(codec, nid);
-		if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
-			snd_hda_codec_read(codec, nid, 0,
-					   AC_VERB_SET_PIN_SENSE, 0);
-		val = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_PIN_SENSE, 0);
-		if (val & AC_PINSENSE_PRESENCE) {
+		if (snd_hda_jack_detect(codec, nid)) {
 			spec->jack_present = 1;
 			break;
 		}
@@ -2777,8 +2763,7 @@ static void alc880_uniwill_mic_automute(
  	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x18, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x18);
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1, HDA_AMP_MUTE, bits);
 }
@@ -5089,11 +5074,8 @@ static struct hda_verb alc260_hp_unsol_v
 static void alc260_hp_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int present;
 
-	present = snd_hda_codec_read(codec, 0x10, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+	spec->jack_present = snd_hda_jack_detect(codec, 0x10);
 	alc260_hp_master_update(codec, 0x0f, 0x10, 0x11);
 }
 
@@ -5158,11 +5140,8 @@ static struct hda_verb alc260_hp_3013_un
 static void alc260_hp_3013_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int present;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+	spec->jack_present = snd_hda_jack_detect(codec, 0x15);
 	alc260_hp_master_update(codec, 0x15, 0x10, 0x11);
 }
 
@@ -5175,12 +5154,8 @@ static void alc260_hp_3013_unsol_event(s
 
 static void alc260_hp_3012_automute(struct hda_codec *codec)
 {
-	unsigned int present, bits;
-
-	present = snd_hda_codec_read(codec, 0x10, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & AC_PINSENSE_PRESENCE;
+	unsigned int bits = snd_hda_jack_detect(codec, 0x10) ? 0 : PIN_OUT;
 
-	bits = present ? 0 : PIN_OUT;
 	snd_hda_codec_write(codec, 0x0f, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
 			    bits);
 	snd_hda_codec_write(codec, 0x11, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
@@ -5750,8 +5725,7 @@ static void alc260_replacer_672v_automut
         unsigned int present;
 
 	/* speaker --> GPIO Data 0, hp or spdif --> GPIO data 1 */
-        present = snd_hda_codec_read(codec, 0x0f, 0,
-                                     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x0f);
 	if (present) {
 		snd_hda_codec_write_cache(codec, 0x01, 0,
 					  AC_VERB_SET_GPIO_DATA, 1);
@@ -8183,12 +8157,8 @@ static void alc883_mitac_setup(struct hd
 /*
 static void alc883_mitac_mic_automute(struct hda_codec *codec)
 {
-	unsigned int present;
-	unsigned char bits;
+	unsigned char bits = snd_hda_jack_detect(codec, 0x18) ? HDA_AMP_MUTE : 0;
 
-	present = snd_hda_codec_read(codec, 0x18, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1, HDA_AMP_MUTE, bits);
 }
 */
@@ -8410,10 +8380,8 @@ static struct hda_channel_mode alc888_3s
 /* toggle front-jack and RCA according to the hp-jack state */
 static void alc888_lenovo_ms7195_front_automute(struct hda_codec *codec)
 {
- 	unsigned int present;
+ 	unsigned int present = snd_hda_jack_detect(codec, 0x1b);
 
- 	present = snd_hda_codec_read(codec, 0x1b, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
@@ -8423,10 +8391,8 @@ static void alc888_lenovo_ms7195_front_a
 /* toggle RCA according to the front-jack state */
 static void alc888_lenovo_ms7195_rca_automute(struct hda_codec *codec)
 {
- 	unsigned int present;
+ 	unsigned int present = snd_hda_jack_detect(codec, 0x14);
 
- 	present = snd_hda_codec_read(codec, 0x14, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
 }
@@ -8519,24 +8485,16 @@ static void alc883_haier_w66_setup(struc
 
 static void alc883_lenovo_101e_ispeaker_automute(struct hda_codec *codec)
 {
- 	unsigned int present;
-	unsigned char bits;
+	int bits = snd_hda_jack_detect(codec, 0x14) ? HDA_AMP_MUTE : 0;
 
-	present = snd_hda_codec_read(codec, 0x14, 0, AC_VERB_GET_PIN_SENSE, 0)
-		& AC_PINSENSE_PRESENCE;
-	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
 }
 
 static void alc883_lenovo_101e_all_automute(struct hda_codec *codec)
 {
- 	unsigned int present;
-	unsigned char bits;
+	int bits = snd_hda_jack_detect(codec, 0x1b) ? HDA_AMP_MUTE : 0;
 
- 	present = snd_hda_codec_read(codec, 0x1b, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
 	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
@@ -8687,8 +8645,7 @@ static void alc889A_mb31_automute(struct
 	/* Mute only in 2ch or 4ch mode */
 	if (snd_hda_codec_read(codec, 0x15, 0, AC_VERB_GET_CONNECT_SEL, 0)
 	    == 0x00) {
-		present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & AC_PINSENSE_PRESENCE;
+		present = snd_hda_jack_detect(codec, 0x15);
 		snd_hda_codec_amp_stereo(codec, 0x14,  HDA_OUTPUT, 0,
 			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
 		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
@@ -10030,10 +9987,8 @@ static void alc262_hp_master_update(stru
 static void alc262_hp_bpc_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int presence;
-	presence = snd_hda_codec_read(codec, 0x1b, 0,
-				      AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = !!(presence & AC_PINSENSE_PRESENCE);
+
+	spec->jack_present = snd_hda_jack_detect(codec, 0x1b);
 	alc262_hp_master_update(codec);
 }
 
@@ -10047,10 +10002,8 @@ static void alc262_hp_bpc_unsol_event(st
 static void alc262_hp_wildwest_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int presence;
-	presence = snd_hda_codec_read(codec, 0x15, 0,
-				      AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = !!(presence & AC_PINSENSE_PRESENCE);
+
+	spec->jack_present = snd_hda_jack_detect(codec, 0x15);
 	alc262_hp_master_update(codec);
 }
 
@@ -10284,13 +10237,8 @@ static void alc262_hippo_automute(struct
 {
 	struct alc_spec *spec = codec->spec;
 	hda_nid_t hp_nid = spec->autocfg.hp_pins[0];
-	unsigned int present;
 
-	/* need to execute and sync at first */
-	snd_hda_codec_read(codec, hp_nid, 0, AC_VERB_SET_PIN_SENSE, 0);
-	present = snd_hda_codec_read(codec, hp_nid, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & 0x80000000) != 0;
+	spec->jack_present = snd_hda_jack_detect(codec, hp_nid);
 	alc262_hippo_master_update(codec);
 }
 
@@ -10616,21 +10564,8 @@ static void alc262_fujitsu_automute(stru
 	unsigned int mute;
 
 	if (force || !spec->sense_updated) {
-		unsigned int present;
-		/* need to execute and sync at first */
-		snd_hda_codec_read(codec, 0x14, 0, AC_VERB_SET_PIN_SENSE, 0);
-		/* check laptop HP jack */
-		present = snd_hda_codec_read(codec, 0x14, 0,
-					     AC_VERB_GET_PIN_SENSE, 0);
-		/* need to execute and sync at first */
-		snd_hda_codec_read(codec, 0x1b, 0, AC_VERB_SET_PIN_SENSE, 0);
-		/* check docking HP jack */
-		present |= snd_hda_codec_read(codec, 0x1b, 0,
-					      AC_VERB_GET_PIN_SENSE, 0);
-		if (present & AC_PINSENSE_PRESENCE)
-			spec->jack_present = 1;
-		else
-			spec->jack_present = 0;
+		spec->jack_present = snd_hda_jack_detect(codec, 0x14) ||
+				     snd_hda_jack_detect(codec, 0x1b);
 		spec->sense_updated = 1;
 	}
 	/* unmute internal speaker only if both HPs are unplugged and
@@ -10675,12 +10610,7 @@ static void alc262_lenovo_3000_automute(
 	unsigned int mute;
 
 	if (force || !spec->sense_updated) {
-		unsigned int present_int_hp;
-		/* need to execute and sync at first */
-		snd_hda_codec_read(codec, 0x1b, 0, AC_VERB_SET_PIN_SENSE, 0);
-		present_int_hp = snd_hda_codec_read(codec, 0x1b, 0,
-					AC_VERB_GET_PIN_SENSE, 0);
-		spec->jack_present = (present_int_hp & 0x80000000) != 0;
+		spec->jack_present = snd_hda_jack_detect(codec, 0x1b);
 		spec->sense_updated = 1;
 	}
 	if (spec->jack_present) {
@@ -10872,12 +10802,7 @@ static void alc262_ultra_automute(struct
 	mute = 0;
 	/* auto-mute only when HP is used as HP */
 	if (!spec->cur_mux[0]) {
-		unsigned int present;
-		/* need to execute and sync at first */
-		snd_hda_codec_read(codec, 0x15, 0, AC_VERB_SET_PIN_SENSE, 0);
-		present = snd_hda_codec_read(codec, 0x15, 0,
-					     AC_VERB_GET_PIN_SENSE, 0);
-		spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+		spec->jack_present = snd_hda_jack_detect(codec, 0x15);
 		if (spec->jack_present)
 			mute = HDA_AMP_MUTE;
 	}
@@ -11915,10 +11840,7 @@ static void alc268_acer_automute(struct 
 	unsigned int mute;
 
 	if (force || !spec->sense_updated) {
-		unsigned int present;
-		present = snd_hda_codec_read(codec, 0x14, 0,
-				    	 AC_VERB_GET_PIN_SENSE, 0);
-		spec->jack_present = (present & 0x80000000) != 0;
+		spec->jack_present = snd_hda_jack_detect(codec, 0x14);
 		spec->sense_updated = 1;
 	}
 	if (spec->jack_present)
@@ -12037,8 +11959,7 @@ static void alc268_aspire_one_speaker_au
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x15);
 	bits = present ? AMP_IN_MUTE(0) : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0f, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -13020,8 +12941,7 @@ static void alc269_quanta_fl1_speaker_au
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x15);
 	bits = present ? AMP_IN_MUTE(0) : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 			AMP_IN_MUTE(0), bits);
@@ -13046,12 +12966,10 @@ static void alc269_lifebook_speaker_auto
 	unsigned char bits;
 
 	/* Check laptop headphone socket */
-	present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x15);
 
 	/* Check port replicator headphone socket */
-	present |= snd_hda_codec_read(codec, 0x1a, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present |= snd_hda_jack_detect(codec, 0x1a);
 
 	bits = present ? AMP_IN_MUTE(0) : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
@@ -13075,11 +12993,8 @@ static void alc269_lifebook_mic_autoswit
 	unsigned int present_laptop;
 	unsigned int present_dock;
 
-	present_laptop = snd_hda_codec_read(codec, 0x18, 0,
-				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-
-	present_dock = snd_hda_codec_read(codec, 0x1b, 0,
-				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present_laptop	= snd_hda_jack_detect(codec, 0x18);
+	present_dock	= snd_hda_jack_detect(codec, 0x1b);
 
 	/* Laptop mic port overrides dock mic port, design decision */
 	if (present_dock)
@@ -13164,8 +13079,7 @@ static void alc269_speaker_automute(stru
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x15);
 	bits = present ? AMP_IN_MUTE(0) : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -14143,10 +14057,8 @@ static struct hda_verb alc861_toshiba_in
 /* toggle speaker-output according to the hp-jack state */
 static void alc861_toshiba_automute(struct hda_codec *codec)
 {
-	unsigned int present;
+	unsigned int present = snd_hda_jack_detect(codec, 0x0f);
 
-	present = snd_hda_codec_read(codec, 0x0f, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
 	snd_hda_codec_amp_stereo(codec, 0x16, HDA_INPUT, 0,
 				 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
 	snd_hda_codec_amp_stereo(codec, 0x1a, HDA_INPUT, 3,
@@ -15051,9 +14963,9 @@ static void alc861vd_lenovo_mic_automute
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x18, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x18);
 	bits = present ? HDA_AMP_MUTE : 0;
+
 	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1,
 				 HDA_AMP_MUTE, bits);
 }
@@ -16364,9 +16276,9 @@ static void alc662_lenovo_101e_ispeaker_
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x14, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_jack_detect(codec, 0x14);
 	bits = present ? HDA_AMP_MUTE : 0;
+
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
 }
@@ -16376,9 +16288,9 @@ static void alc662_lenovo_101e_all_autom
 	unsigned int present;
 	unsigned char bits;
 
- 	present = snd_hda_codec_read(codec, 0x1b, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+ 	present = snd_hda_jack_detect(codec, 0x1b);
 	bits = present ? HDA_AMP_MUTE : 0;
+
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
 	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
@@ -16437,9 +16349,7 @@ static void alc663_m51va_speaker_automut
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, 0x21);
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -16452,9 +16362,7 @@ static void alc663_21jd_two_speaker_auto
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, 0x21);
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -16471,9 +16379,7 @@ static void alc663_15jd_two_speaker_auto
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, 0x15);
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -16490,9 +16396,7 @@ static void alc662_f5z_speaker_automute(
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x1b, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, 0x1b);
 	bits = present ? 0 : PIN_OUT;
 	snd_hda_codec_write(codec, 0x14, 0,
 			 AC_VERB_SET_PIN_WIDGET_CONTROL, bits);
@@ -16502,12 +16406,8 @@ static void alc663_two_hp_m1_speaker_aut
 {
 	unsigned int present1, present2;
 
-	present1 = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
-	present2 = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present1 = snd_hda_jack_detect(codec, 0x21);
+	present2 = snd_hda_jack_detect(codec, 0x15);
 
 	if (present1 || present2) {
 		snd_hda_codec_write_cache(codec, 0x14, 0,
@@ -16522,12 +16422,8 @@ static void alc663_two_hp_m2_speaker_aut
 {
 	unsigned int present1, present2;
 
-	present1 = snd_hda_codec_read(codec, 0x1b, 0,
-				AC_VERB_GET_PIN_SENSE, 0)
-				& AC_PINSENSE_PRESENCE;
-	present2 = snd_hda_codec_read(codec, 0x15, 0,
-				AC_VERB_GET_PIN_SENSE, 0)
-				& AC_PINSENSE_PRESENCE;
+	present1 = snd_hda_jack_detect(codec, 0x1b);
+	present2 = snd_hda_jack_detect(codec, 0x15);
 
 	if (present1 || present2) {
 		snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
@@ -16687,9 +16583,7 @@ static void alc663_g71v_hp_automute(stru
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x21, 0,
-				     AC_VERB_GET_PIN_SENSE, 0)
-		& AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, 0x21);
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
@@ -16702,9 +16596,7 @@ static void alc663_g71v_front_automute(s
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-				     AC_VERB_GET_PIN_SENSE, 0)
-		& AC_PINSENSE_PRESENCE;
+	present = snd_hda_jack_detect(codec, 0x15);
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
--- sound-2.6.orig/sound/pci/hda/patch_cirrus.c	2009-11-18 10:00:11.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_cirrus.c	2009-11-18 12:27:34.000000000 +0800
@@ -807,7 +807,7 @@ static void cs_automute(struct hda_codec
 {
 	struct cs_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	unsigned int caps, present, hp_present;
+	unsigned int caps, hp_present;
 	hda_nid_t nid;
 	int i;
 
@@ -817,12 +817,7 @@ static void cs_automute(struct hda_codec
 		caps = snd_hda_query_pin_caps(codec, nid);
 		if (!(caps & AC_PINCAP_PRES_DETECT))
 			continue;
-		if (caps & AC_PINCAP_TRIG_REQ)
-			snd_hda_codec_read(codec, nid, 0,
-					   AC_VERB_SET_PIN_SENSE, 0);
-		present = snd_hda_codec_read(codec, nid, 0,
-					     AC_VERB_GET_PIN_SENSE, 0);
-		hp_present |= (present & AC_PINSENSE_PRESENCE) != 0;
+		hp_present = snd_hda_jack_detect(codec, nid);
 		if (hp_present)
 			break;
 	}
@@ -844,15 +839,11 @@ static void cs_automic(struct hda_codec 
 	struct cs_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	hda_nid_t nid;
-	unsigned int caps, present;
+	unsigned int present;
 	
 	nid = cfg->input_pins[spec->automic_idx];
-	caps = snd_hda_query_pin_caps(codec, nid);
-	if (caps & AC_PINCAP_TRIG_REQ)
-		snd_hda_codec_read(codec, nid, 0, AC_VERB_SET_PIN_SENSE, 0);
-	present = snd_hda_codec_read(codec, nid, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	if (present & AC_PINSENSE_PRESENCE)
+	present = snd_hda_jack_detect(codec, nid);
+	if (present)
 		change_cur_input(codec, spec->automic_idx, 0);
 	else {
 		unsigned int imic = (spec->automic_idx == AUTO_PIN_MIC) ?
--- sound-2.6.orig/sound/pci/hda/hda_eld.c	2009-11-18 10:00:15.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_eld.c	2009-11-18 10:00:15.000000000 +0800
@@ -309,17 +309,12 @@ out_fail:
 	return -EINVAL;
 }
 
-static int hdmi_present_sense(struct hda_codec *codec, hda_nid_t nid)
-{
-	return snd_hda_codec_read(codec, nid, 0, AC_VERB_GET_PIN_SENSE, 0);
-}
-
 static int hdmi_eld_valid(struct hda_codec *codec, hda_nid_t nid)
 {
 	int eldv;
 	int present;
 
-	present = hdmi_present_sense(codec, nid);
+	present = snd_hda_pin_sense(codec, nid);
 	eldv    = (present & AC_PINSENSE_ELDV);
 	present = (present & AC_PINSENSE_PRESENCE);
