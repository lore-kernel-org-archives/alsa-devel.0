From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] Fixup automute for Realtek auto parser
Date: Fri, 16 Sep 2011 10:01:48 +0200
Message-ID: <4E73026C.5090307@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090504070503080307020206"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B3A9103828
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 10:01:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090504070503080307020206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The ~6 months old functionality for configurable automuting is broken 
for the case that the user has only HP and LO (no speakers) - basically 
there is an "Automute mode" control, but enabling it does nothing. While 
fixing that, I also took the liberty of refactoring/rewriting some of 
that code, in order to make it easier to understand and maintain.

Takashi, given you approve/like these changes, I'll go ahead and fix up 
the quirk files to fit the new variable names.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090504070503080307020206
Content-Type: text/x-patch;
 name="realtek.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="realtek.patch"

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70ba45e..e3d3553 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -33,6 +33,10 @@
 #include "hda_local.h"
 #include "hda_beep.h"
 
+/* FIXME: Temporary since it won't compile otherwise */
+#undef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
+
+
 /* unsol event tags */
 #define ALC_FRONT_EVENT		0x01
 #define ALC_DCVOL_EVENT		0x02
@@ -162,15 +166,17 @@ struct alc_spec {
 	void (*automute_hook)(struct hda_codec *codec);
 
 	/* for pin sensing */
-	unsigned int jack_present: 1;
+	unsigned int hp_jack_present: 1;
 	unsigned int line_jack_present:1;
 	unsigned int master_mute:1;
 	unsigned int auto_mic:1;
 	unsigned int auto_mic_valid_imux:1;	/* valid imux for auto-mic */
-	unsigned int automute:1;	/* HP automute enabled */
-	unsigned int detect_line:1;	/* Line-out detection enabled */
-	unsigned int automute_lines:1;	/* automute line-out as well */
-	unsigned int automute_hp_lo:1;	/* both HP and LO available */
+	unsigned int detect_hp:1;		/* Headphones detection enabled */
+	unsigned int detect_line:1;		/* Line-out detection enabled */
+	unsigned int automute_speaker:1;	/* automute speakers */
+	unsigned int automute_lo:1;		/* automute line-out as well */
+	unsigned int automute_speaker_possible:1;	/* there are speakers and either LO or HP */
+	unsigned int automute_lo_possible:1;		/* there are line outs and HP */
 
 	/* other flags */
 	unsigned int no_analog :1; /* digital I/O only */
@@ -530,8 +536,8 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 	}
 }
 
-/* Toggle internal speakers muting */
-static void update_speakers(struct hda_codec *codec)
+/* Toggle outputs muting */
+static void update_outputs(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	int on;
@@ -543,10 +549,10 @@ static void update_speakers(struct hda_codec *codec)
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
 		    spec->autocfg.hp_pins, spec->master_mute, true);
 
-	if (!spec->automute)
+	if (!spec->automute_speaker)
 		on = 0;
 	else
-		on = spec->jack_present | spec->line_jack_present;
+		on = spec->hp_jack_present | spec->line_jack_present;
 	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
 		    spec->autocfg.speaker_pins, on, false);
@@ -556,22 +562,22 @@ static void update_speakers(struct hda_codec *codec)
 	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0] ||
 	    spec->autocfg.line_out_pins[0] == spec->autocfg.speaker_pins[0])
 		return;
-	if (!spec->automute_lines || !spec->automute)
+	if (!spec->automute_lo)
 		on = 0;
 	else
-		on = spec->jack_present;
+		on = spec->hp_jack_present;
 	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 		    spec->autocfg.line_out_pins, on, false);
 }
 
-static void call_update_speakers(struct hda_codec *codec)
+static void call_update_outputs(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	if (spec->automute_hook)
 		spec->automute_hook(codec);
 	else
-		update_speakers(codec);
+		update_outputs(codec);
 }
 
 /* standard HP-automute helper */
@@ -579,12 +585,12 @@ static void alc_hp_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	spec->jack_present =
+	spec->hp_jack_present =
 		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
 			     spec->autocfg.hp_pins);
-	if (!spec->automute)
+	if (!spec->detect_hp || (!spec->automute_speaker && !spec->automute_lo))
 		return;
-	call_update_speakers(codec);
+	call_update_outputs(codec);
 }
 
 /* standard line-out-automute helper */
@@ -595,9 +601,9 @@ static void alc_line_automute(struct hda_codec *codec)
 	spec->line_jack_present =
 		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 			     spec->autocfg.line_out_pins);
-	if (!spec->automute || !spec->detect_line)
+	if (!spec->automute_speaker || !spec->detect_line)
 		return;
-	call_update_speakers(codec);
+	call_update_outputs(codec);
 }
 
 #define get_connection_index(codec, mux, nid) \
@@ -795,7 +801,7 @@ static int alc_automute_mode_info(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	if (spec->automute_hp_lo) {
+	if (spec->automute_speaker_possible && spec->automute_lo_possible) {
 		uinfo->value.enumerated.items = 3;
 		texts = texts3;
 	} else {
@@ -814,13 +820,12 @@ static int alc_automute_mode_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	unsigned int val;
-	if (!spec->automute)
-		val = 0;
-	else if (!spec->automute_lines)
-		val = 1;
-	else
-		val = 2;
+	unsigned int val = 0;
+	if (spec->automute_speaker)
+		val++;
+	if (spec->automute_lo)
+		val++;
+
 	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
@@ -833,28 +838,38 @@ static int alc_automute_mode_put(struct snd_kcontrol *kcontrol,
 
 	switch (ucontrol->value.enumerated.item[0]) {
 	case 0:
-		if (!spec->automute)
+		if (!spec->automute_speaker && !spec->automute_lo)
 			return 0;
-		spec->automute = 0;
+		spec->automute_speaker = 0;
+		spec->automute_lo = 0;
 		break;
 	case 1:
-		if (spec->automute && !spec->automute_lines)
-			return 0;
-		spec->automute = 1;
-		spec->automute_lines = 0;
+		if (spec->automute_speaker_possible) {
+			if (!spec->automute_lo && spec->automute_speaker)
+				return 0;
+			spec->automute_speaker = 1;
+			spec->automute_lo = 0;
+		} 
+		else if (spec->automute_lo_possible) {
+			if (spec->automute_lo)
+				return 0;
+			spec->automute_lo = 1;
+		}
+		else
+			return -EINVAL;
 		break;
 	case 2:
-		if (!spec->automute_hp_lo)
+		if (!spec->automute_lo_possible || !spec->automute_speaker_possible)
 			return -EINVAL;
-		if (spec->automute && spec->automute_lines)
+		if (spec->automute_speaker && spec->automute_lo)
 			return 0;
-		spec->automute = 1;
-		spec->automute_lines = 1;
+		spec->automute_speaker = 1;
+		spec->automute_lo = 1;
 		break;
 	default:
 		return -EINVAL;
 	}
-	call_update_speakers(codec);
+	call_update_outputs(codec);
 	return 1;
 }
 
@@ -906,8 +921,6 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		present++;
 	if (present < 2) /* need two different output types */
 		return;
-	if (present == 3)
-		spec->automute_hp_lo = 1; /* both HP and LO automute */
 
 	if (!cfg->speaker_pins[0] &&
 	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
@@ -923,6 +936,8 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		cfg->hp_outs = cfg->line_outs;
 	}
 
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+
 	for (i = 0; i < cfg->hp_outs; i++) {
 		hda_nid_t nid = cfg->hp_pins[i];
 		if (!is_jack_detectable(codec, nid))
@@ -932,28 +947,32 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		snd_hda_codec_write_cache(codec, nid, 0,
 				  AC_VERB_SET_UNSOLICITED_ENABLE,
 				  AC_USRSP_EN | ALC_HP_EVENT);
-		spec->automute = 1;
-		spec->automute_mode = ALC_AUTOMUTE_PIN;
-	}
-	if (spec->automute && cfg->line_out_pins[0] &&
-	    cfg->speaker_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->hp_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->speaker_pins[0]) {
-		for (i = 0; i < cfg->line_outs; i++) {
-			hda_nid_t nid = cfg->line_out_pins[i];
-			if (!is_jack_detectable(codec, nid))
-				continue;
-			snd_printdd("realtek: Enable Line-Out auto-muting "
-				    "on NID 0x%x\n", nid);
-			snd_hda_codec_write_cache(codec, nid, 0,
-					AC_VERB_SET_UNSOLICITED_ENABLE,
-					AC_USRSP_EN | ALC_FRONT_EVENT);
-			spec->detect_line = 1;
+		spec->detect_hp = 1;
+	}
+
+	if (cfg->line_out_type == AUTO_PIN_LINE_OUT && cfg->line_outs) {
+		if (cfg->speaker_outs)
+			for (i = 0; i < cfg->line_outs; i++) {
+				hda_nid_t nid = cfg->line_out_pins[i];
+				if (!is_jack_detectable(codec, nid))
+					continue;
+				snd_printdd("realtek: Enable Line-Out "
+					    "auto-muting on NID 0x%x\n", nid);
+				snd_hda_codec_write_cache(codec, nid, 0,
+						AC_VERB_SET_UNSOLICITED_ENABLE,
+						AC_USRSP_EN | ALC_FRONT_EVENT);
+				spec->detect_line = 1;
 		}
-		spec->automute_lines = spec->detect_line;
+		spec->automute_lo_possible = spec->detect_hp;
 	}
 
-	if (spec->automute) {
+	spec->automute_speaker_possible = cfg->speaker_outs && 
+		(spec->detect_hp || spec->detect_line);
+
+	spec->automute_lo = spec->automute_lo_possible;
+	spec->automute_speaker = spec->automute_speaker_possible;
+
+	if (spec->automute_speaker_possible || spec->automute_lo_possible) {
 		/* create a control for automute mode */
 		alc_add_automute_mode_enum(codec);
 		spec->unsol_event = alc_sku_unsol_event;
@@ -4640,7 +4659,7 @@ static void alc269_fixup_stereo_dmic(struct hda_codec *codec,
 
 static void alc269_quanta_automute(struct hda_codec *codec)
 {
-	update_speakers(codec);
+	update_outputs(codec);
 
 	snd_hda_codec_write(codec, 0x20, 0,
 			AC_VERB_SET_COEF_INDEX, 0x0c);

--------------090504070503080307020206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090504070503080307020206--
