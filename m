From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 04/11] hda - introduce snd_hda_pin_sense()
Date: Sun, 15 Nov 2009 19:32:23 +0800
Message-ID: <20091115114439.816525376@intel.com>
References: <20091115113219.606666087@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A3B410387B
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:45 +0100 (CET)
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

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_codec.c     |   12 ++
 sound/pci/hda/hda_eld.c       |    7 -
 sound/pci/hda/hda_local.h     |    1 
 sound/pci/hda/patch_cirrus.c  |   14 ---
 sound/pci/hda/patch_realtek.c |  146 ++++++++------------------------
 5 files changed, 58 insertions(+), 122 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_codec.c	2009-11-02 15:14:30.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_codec.c	2009-11-02 15:25:17.000000000 +0800
@@ -1229,6 +1229,18 @@ u32 snd_hda_query_pin_caps(struct hda_co
 }
 EXPORT_SYMBOL_HDA(snd_hda_query_pin_caps);
 
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
 /*
  * read the current volume to info
  * if the cache exists, read the cache value.
--- sound-2.6.orig/sound/pci/hda/hda_local.h	2009-11-02 15:21:11.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_local.h	2009-11-02 15:25:17.000000000 +0800
@@ -424,6 +424,7 @@ u32 query_amp_caps(struct hda_codec *cod
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps);
 u32 snd_hda_query_pin_caps(struct hda_codec *codec, hda_nid_t nid);
+u32 snd_hda_pin_sense(struct hda_codec *codec, hda_nid_t nid);
 
 int snd_hda_ctl_add(struct hda_codec *codec, struct snd_kcontrol *kctl);
 void snd_hda_ctls_clear(struct hda_codec *codec);
--- sound-2.6.orig/sound/pci/hda/patch_realtek.c	2009-11-02 15:12:14.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_realtek.c	2009-11-02 15:25:17.000000000 +0800
@@ -961,16 +961,12 @@ static void alc_fix_pll_init(struct hda_
 static void alc_automute_pin(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int present, pincap;
+	unsigned int present;
 	unsigned int nid = spec->autocfg.hp_pins[0];
 	int i;
 
-	pincap = snd_hda_query_pin_caps(codec, nid);
-	if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
-		snd_hda_codec_read(codec, nid, 0, AC_VERB_SET_PIN_SENSE, 0);
-	present = snd_hda_codec_read(codec, nid, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+	present = snd_hda_pin_sense(codec, nid);
+	spec->jack_present = !!(present & AC_PINSENSE_PRESENCE);
 	for (i = 0; i < ARRAY_SIZE(spec->autocfg.speaker_pins); i++) {
 		nid = spec->autocfg.speaker_pins[i];
 		if (!nid)
@@ -1511,7 +1507,7 @@ static struct hda_verb alc888_fujitsu_xa
 static void alc_automute_amp(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int val, mute, pincap;
+	unsigned int val, mute;
 	hda_nid_t nid;
 	int i;
 
@@ -1520,12 +1516,7 @@ static void alc_automute_amp(struct hda_
 		nid = spec->autocfg.hp_pins[i];
 		if (!nid)
 			break;
-		pincap = snd_hda_query_pin_caps(codec, nid);
-		if (pincap & AC_PINCAP_TRIG_REQ) /* need trigger? */
-			snd_hda_codec_read(codec, nid, 0,
-					   AC_VERB_SET_PIN_SENSE, 0);
-		val = snd_hda_codec_read(codec, nid, 0,
-					 AC_VERB_GET_PIN_SENSE, 0);
+		val = snd_hda_pin_sense(codec, nid);
 		if (val & AC_PINSENSE_PRESENCE) {
 			spec->jack_present = 1;
 			break;
@@ -2777,8 +2768,7 @@ static void alc880_uniwill_mic_automute(
  	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x18, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_pin_sense(codec, 0x18) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0b, HDA_INPUT, 1, HDA_AMP_MUTE, bits);
 }
@@ -5091,9 +5081,8 @@ static void alc260_hp_automute(struct hd
 	struct alc_spec *spec = codec->spec;
 	unsigned int present;
 
-	present = snd_hda_codec_read(codec, 0x10, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+	present = snd_hda_pin_sense(codec, 0x10);
+	spec->jack_present = !!(present & AC_PINSENSE_PRESENCE);
 	alc260_hp_master_update(codec, 0x0f, 0x10, 0x11);
 }
 
@@ -5160,9 +5149,8 @@ static void alc260_hp_3013_automute(stru
 	struct alc_spec *spec = codec->spec;
 	unsigned int present;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+	present = snd_hda_pin_sense(codec, 0x15);
+	spec->jack_present = !!(present & AC_PINSENSE_PRESENCE);
 	alc260_hp_master_update(codec, 0x15, 0x10, 0x11);
 }
 
@@ -5177,8 +5165,7 @@ static void alc260_hp_3012_automute(stru
 {
 	unsigned int present, bits;
 
-	present = snd_hda_codec_read(codec, 0x10, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x10) & AC_PINSENSE_PRESENCE;
 
 	bits = present ? 0 : PIN_OUT;
 	snd_hda_codec_write(codec, 0x0f, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
@@ -5750,8 +5737,7 @@ static void alc260_replacer_672v_automut
         unsigned int present;
 
 	/* speaker --> GPIO Data 0, hp or spdif --> GPIO data 1 */
-        present = snd_hda_codec_read(codec, 0x0f, 0,
-                                     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_pin_sense(codec, 0x0f) & AC_PINSENSE_PRESENCE;
 	if (present) {
 		snd_hda_codec_write_cache(codec, 0x01, 0,
 					  AC_VERB_SET_GPIO_DATA, 1);
@@ -8522,8 +8508,7 @@ static void alc883_lenovo_101e_ispeaker_
  	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x14, 0, AC_VERB_GET_PIN_SENSE, 0)
-		& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x14) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
@@ -8534,8 +8519,7 @@ static void alc883_lenovo_101e_all_autom
  	unsigned int present;
 	unsigned char bits;
 
- 	present = snd_hda_codec_read(codec, 0x1b, 0,
-				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_pin_sense(codec, 0x1b) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
@@ -8687,8 +8671,7 @@ static void alc889A_mb31_automute(struct
 	/* Mute only in 2ch or 4ch mode */
 	if (snd_hda_codec_read(codec, 0x15, 0, AC_VERB_GET_CONNECT_SEL, 0)
 	    == 0x00) {
-		present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & AC_PINSENSE_PRESENCE;
+		present = snd_hda_pin_sense(codec, 0x15) & AC_PINSENSE_PRESENCE;
 		snd_hda_codec_amp_stereo(codec, 0x14,  HDA_OUTPUT, 0,
 			HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
 		snd_hda_codec_amp_stereo(codec, 0x16, HDA_OUTPUT, 0,
@@ -10030,9 +10013,7 @@ static void alc262_hp_master_update(stru
 static void alc262_hp_bpc_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int presence;
-	presence = snd_hda_codec_read(codec, 0x1b, 0,
-				      AC_VERB_GET_PIN_SENSE, 0);
+	unsigned int presence = snd_hda_pin_sense(codec, 0x1b);
 	spec->jack_present = !!(presence & AC_PINSENSE_PRESENCE);
 	alc262_hp_master_update(codec);
 }
@@ -10047,9 +10028,7 @@ static void alc262_hp_bpc_unsol_event(st
 static void alc262_hp_wildwest_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	unsigned int presence;
-	presence = snd_hda_codec_read(codec, 0x15, 0,
-				      AC_VERB_GET_PIN_SENSE, 0);
+	unsigned int presence = snd_hda_pin_sense(codec, 0x15);
 	spec->jack_present = !!(presence & AC_PINSENSE_PRESENCE);
 	alc262_hp_master_update(codec);
 }
@@ -10286,11 +10265,8 @@ static void alc262_hippo_automute(struct
 	hda_nid_t hp_nid = spec->autocfg.hp_pins[0];
 	unsigned int present;
 
-	/* need to execute and sync at first */
-	snd_hda_codec_read(codec, hp_nid, 0, AC_VERB_SET_PIN_SENSE, 0);
-	present = snd_hda_codec_read(codec, hp_nid, 0,
-				     AC_VERB_GET_PIN_SENSE, 0);
-	spec->jack_present = (present & 0x80000000) != 0;
+	present = snd_hda_pin_sense(codec, hp_nid) & AC_PINSENSE_PRESENCE;
+	spec->jack_present = !!present;
 	alc262_hippo_master_update(codec);
 }
 
@@ -10617,16 +10593,8 @@ static void alc262_fujitsu_automute(stru
 
 	if (force || !spec->sense_updated) {
 		unsigned int present;
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
+		present = snd_hda_pin_sense(codec, 0x14);
+		present |= snd_hda_pin_sense(codec, 0x1b);
 		if (present & AC_PINSENSE_PRESENCE)
 			spec->jack_present = 1;
 		else
@@ -10675,12 +10643,8 @@ static void alc262_lenovo_3000_automute(
 	unsigned int mute;
 
 	if (force || !spec->sense_updated) {
-		unsigned int present_int_hp;
-		/* need to execute and sync at first */
-		snd_hda_codec_read(codec, 0x1b, 0, AC_VERB_SET_PIN_SENSE, 0);
-		present_int_hp = snd_hda_codec_read(codec, 0x1b, 0,
-					AC_VERB_GET_PIN_SENSE, 0);
-		spec->jack_present = (present_int_hp & 0x80000000) != 0;
+		unsigned int present_int_hp = snd_hda_pin_sense(codec, 0x1b);
+		spec->jack_present = !!(present_int_hp & AC_PINSENSE_PRESENCE);
 		spec->sense_updated = 1;
 	}
 	if (spec->jack_present) {
@@ -10872,12 +10836,9 @@ static void alc262_ultra_automute(struct
 	mute = 0;
 	/* auto-mute only when HP is used as HP */
 	if (!spec->cur_mux[0]) {
-		unsigned int present;
-		/* need to execute and sync at first */
-		snd_hda_codec_read(codec, 0x15, 0, AC_VERB_SET_PIN_SENSE, 0);
-		present = snd_hda_codec_read(codec, 0x15, 0,
-					     AC_VERB_GET_PIN_SENSE, 0);
-		spec->jack_present = (present & AC_PINSENSE_PRESENCE) != 0;
+		unsigned int present = snd_hda_pin_sense(codec, 0x15);
+
+		spec->jack_present = !!(present & AC_PINSENSE_PRESENCE);
 		if (spec->jack_present)
 			mute = HDA_AMP_MUTE;
 	}
@@ -11918,7 +11879,7 @@ static void alc268_acer_automute(struct 
 		unsigned int present;
 		present = snd_hda_codec_read(codec, 0x14, 0,
 				    	 AC_VERB_GET_PIN_SENSE, 0);
-		spec->jack_present = (present & 0x80000000) != 0;
+		spec->jack_present = !!(present & AC_PINSENSE_PRESENCE);
 		spec->sense_updated = 1;
 	}
 	if (spec->jack_present)
@@ -13046,12 +13007,10 @@ static void alc269_lifebook_speaker_auto
 	unsigned char bits;
 
 	/* Check laptop headphone socket */
-	present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_pin_sense(codec, 0x15) & AC_PINSENSE_PRESENCE;
 
 	/* Check port replicator headphone socket */
-	present |= snd_hda_codec_read(codec, 0x1a, 0,
-			AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present = snd_hda_pin_sense(codec, 0x1a) & AC_PINSENSE_PRESENCE;
 
 	bits = present ? AMP_IN_MUTE(0) : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
@@ -13075,11 +13034,8 @@ static void alc269_lifebook_mic_autoswit
 	unsigned int present_laptop;
 	unsigned int present_dock;
 
-	present_laptop = snd_hda_codec_read(codec, 0x18, 0,
-				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
-
-	present_dock = snd_hda_codec_read(codec, 0x1b, 0,
-				AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	present_laptop	= snd_hda_pin_sense(codec, 0x18) & AC_PINSENSE_PRESENCE;
+	present_dock	= snd_hda_pin_sense(codec, 0x1b) & AC_PINSENSE_PRESENCE;
 
 	/* Laptop mic port overrides dock mic port, design decision */
 	if (present_dock)
@@ -16437,9 +16393,7 @@ static void alc663_m51va_speaker_automut
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x21) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -16452,9 +16406,7 @@ static void alc663_21jd_two_speaker_auto
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x21) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -16471,9 +16423,7 @@ static void alc663_15jd_two_speaker_auto
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x15) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
 				AMP_IN_MUTE(0), bits);
@@ -16490,9 +16440,7 @@ static void alc662_f5z_speaker_automute(
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x1b, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x1b) & AC_PINSENSE_PRESENCE;
 	bits = present ? 0 : PIN_OUT;
 	snd_hda_codec_write(codec, 0x14, 0,
 			 AC_VERB_SET_PIN_WIDGET_CONTROL, bits);
@@ -16502,12 +16450,8 @@ static void alc663_two_hp_m1_speaker_aut
 {
 	unsigned int present1, present2;
 
-	present1 = snd_hda_codec_read(codec, 0x21, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
-	present2 = snd_hda_codec_read(codec, 0x15, 0,
-			AC_VERB_GET_PIN_SENSE, 0)
-			& AC_PINSENSE_PRESENCE;
+	present1 = snd_hda_pin_sense(codec, 0x21) & AC_PINSENSE_PRESENCE;
+	present2 = snd_hda_pin_sense(codec, 0x15) & AC_PINSENSE_PRESENCE;
 
 	if (present1 || present2) {
 		snd_hda_codec_write_cache(codec, 0x14, 0,
@@ -16522,12 +16466,8 @@ static void alc663_two_hp_m2_speaker_aut
 {
 	unsigned int present1, present2;
 
-	present1 = snd_hda_codec_read(codec, 0x1b, 0,
-				AC_VERB_GET_PIN_SENSE, 0)
-				& AC_PINSENSE_PRESENCE;
-	present2 = snd_hda_codec_read(codec, 0x15, 0,
-				AC_VERB_GET_PIN_SENSE, 0)
-				& AC_PINSENSE_PRESENCE;
+	present1 = snd_hda_pin_sense(codec, 0x1b) & AC_PINSENSE_PRESENCE;
+	present2 = snd_hda_pin_sense(codec, 0x15) & AC_PINSENSE_PRESENCE;
 
 	if (present1 || present2) {
 		snd_hda_codec_amp_stereo(codec, 0x0c, HDA_INPUT, 0,
@@ -16687,9 +16627,7 @@ static void alc663_g71v_hp_automute(stru
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x21, 0,
-				     AC_VERB_GET_PIN_SENSE, 0)
-		& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x21) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x15, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
@@ -16702,9 +16640,7 @@ static void alc663_g71v_front_automute(s
 	unsigned int present;
 	unsigned char bits;
 
-	present = snd_hda_codec_read(codec, 0x15, 0,
-				     AC_VERB_GET_PIN_SENSE, 0)
-		& AC_PINSENSE_PRESENCE;
+	present = snd_hda_pin_sense(codec, 0x15) & AC_PINSENSE_PRESENCE;
 	bits = present ? HDA_AMP_MUTE : 0;
 	snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
 				 HDA_AMP_MUTE, bits);
--- sound-2.6.orig/sound/pci/hda/patch_cirrus.c	2009-11-02 15:12:14.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_cirrus.c	2009-11-02 15:25:17.000000000 +0800
@@ -817,11 +817,7 @@ static void cs_automute(struct hda_codec
 		caps = snd_hda_query_pin_caps(codec, nid);
 		if (!(caps & AC_PINCAP_PRES_DETECT))
 			continue;
-		if (caps & AC_PINCAP_TRIG_REQ)
-			snd_hda_codec_read(codec, nid, 0,
-					   AC_VERB_SET_PIN_SENSE, 0);
-		present = snd_hda_codec_read(codec, nid, 0,
-					     AC_VERB_GET_PIN_SENSE, 0);
+		present = snd_hda_pin_sense(codec, nid);
 		hp_present |= (present & AC_PINSENSE_PRESENCE) != 0;
 		if (hp_present)
 			break;
@@ -844,14 +840,10 @@ static void cs_automic(struct hda_codec 
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
+	present = snd_hda_pin_sense(codec, nid);
 	if (present & AC_PINSENSE_PRESENCE)
 		change_cur_input(codec, spec->automic_idx, 0);
 	else {
--- sound-2.6.orig/sound/pci/hda/hda_eld.c	2009-11-02 15:43:35.000000000 +0800
+++ sound-2.6/sound/pci/hda/hda_eld.c	2009-11-02 15:43:58.000000000 +0800
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
