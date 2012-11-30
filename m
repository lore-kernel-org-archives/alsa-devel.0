From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: hda - Pass errors properly in
	alc_auto_check_switches()
Date: Fri, 30 Nov 2012 09:16:02 +0100
Message-ID: <1354263363-25398-5-git-send-email-tiwai@suse.de>
References: <1354202489-12769-1-git-send-email-tiwai@suse.de>
 <1354263363-25398-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B301A265CB6
 for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2012 09:16:22 +0100 (CET)
In-Reply-To: <1354263363-25398-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 55 +++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fc70c0c..b3612a4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1002,12 +1002,12 @@ static int alc_add_automute_mode_enum(struct hda_codec *codec)
  * Check the availability of HP/line-out auto-mute;
  * Set up appropriately if really supported
  */
-static void alc_init_automute(struct hda_codec *codec)
+static int alc_init_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int present = 0;
-	int i;
+	int i, err;
 
 	if (cfg->hp_pins[0])
 		present++;
@@ -1016,7 +1016,7 @@ static void alc_init_automute(struct hda_codec *codec)
 	if (cfg->speaker_pins[0])
 		present++;
 	if (present < 2) /* need two different output types */
-		return;
+		return 0;
 
 	if (!cfg->speaker_pins[0] &&
 	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
@@ -1066,9 +1066,13 @@ static void alc_init_automute(struct hda_codec *codec)
 	spec->automute_lo = spec->automute_lo_possible;
 	spec->automute_speaker = spec->automute_speaker_possible;
 
-	if (spec->automute_speaker_possible || spec->automute_lo_possible)
+	if (spec->automute_speaker_possible || spec->automute_lo_possible) {
 		/* create a control for automute mode */
-		alc_add_automute_mode_enum(codec);
+		err = alc_add_automute_mode_enum(codec);
+		if (err < 0)
+			return err;
+	}
+	return 0;
 }
 
 /* return the position of NID in the list, or -1 if not found */
@@ -1175,7 +1179,7 @@ static int compare_attr(const void *ap, const void *bp)
  * Check the availability of auto-mic switch;
  * Set up if really supported
  */
-static void alc_init_auto_mic(struct hda_codec *codec)
+static int alc_init_auto_mic(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
@@ -1183,7 +1187,7 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 	int i, num_pins;
 
 	if (spec->shared_mic_hp)
-		return; /* no auto-mic for the shared I/O */
+		return 0; /* no auto-mic for the shared I/O */
 
 	types = 0;
 	num_pins = 0;
@@ -1194,23 +1198,23 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 		attr = snd_hda_codec_get_pincfg(codec, nid);
 		attr = snd_hda_get_input_pin_attr(attr);
 		if (types & (1 << attr))
-			return; /* already occupied */
+			return 0; /* already occupied */
 		switch (attr) {
 		case INPUT_PIN_ATTR_INT:
 			if (cfg->inputs[i].type != AUTO_PIN_MIC)
-				return; /* invalid type */
+				return 0; /* invalid type */
 			break;
 		case INPUT_PIN_ATTR_UNUSED:
-			return; /* invalid entry */
+			return 0; /* invalid entry */
 		default:
 			if (cfg->inputs[i].type > AUTO_PIN_LINE_IN)
-				return; /* invalid type */
+				return 0; /* invalid type */
 			if (!is_jack_detectable(codec, nid))
-				return; /* no unsol support */
+				return 0; /* no unsol support */
 			break;
 		}
 		if (num_pins >= MAX_AUTO_MIC_PINS)
-			return;
+			return 0;
 		types |= (1 << attr);
 		spec->am_entry[num_pins].pin = nid;
 		spec->am_entry[num_pins].attr = attr;
@@ -1218,7 +1222,7 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 	}
 
 	if (num_pins < 2)
-		return;
+		return 0;
 
 	spec->am_num_entries = num_pins;
 	/* sort the am_entry in the order of attr so that the pin with a
@@ -1230,25 +1234,34 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 	/* check imux indices */
 	spec->auto_mic = 1;
 	if (!alc_auto_mic_check_imux(codec))
-		return;
+		return 0;
 
 	snd_printdd("realtek: Enable auto-mic switch on NID 0x%x/0x%x/0x%x\n",
 		    spec->am_entry[0].pin,
 		    spec->am_entry[1].pin,
 		    spec->am_entry[2].pin);
 
-	alc_kcontrol_new(spec, "Auto-Mic Mode", &alc_automic_mode_enum);
+	if (!alc_kcontrol_new(spec, "Auto-Mic Mode", &alc_automic_mode_enum))
+		return -ENOMEM;
 
 	/* enable auto mic only on machines with an internal mic as default */
 	if (spec->am_entry[0].attr != INPUT_PIN_ATTR_INT)
 		spec->auto_mic = 0;
+	return 0;
 }
 
 /* check the availabilities of auto-mute and auto-mic switches */
-static void alc_auto_check_switches(struct hda_codec *codec)
+static int alc_auto_check_switches(struct hda_codec *codec)
 {
-	alc_init_automute(codec);
-	alc_init_auto_mic(codec);
+	int err;
+
+	err = alc_init_automute(codec);
+	if (err < 0)
+		return err;
+	err = alc_init_auto_mic(codec);
+	if (err < 0)
+		return err;
+	return 0;
 }
 
 /*
@@ -4419,7 +4432,9 @@ static int alc_parse_auto_config(struct hda_codec *codec,
 		alc_ssid_check(codec, ssid_nids);
 
 	if (!spec->no_analog) {
-		alc_auto_check_switches(codec);
+		err = alc_auto_check_switches(codec);
+		if (err < 0)
+			return err;
 		err = alc_auto_add_mic_boost(codec);
 		if (err < 0)
 			return err;
-- 
1.8.0.1
