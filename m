From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/10] ALSA: hda - Add support for Line-Out
	automute to Realtek auto-parser
Date: Fri, 29 Apr 2011 19:18:34 +0200
Message-ID: <1304097516-7258-9-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 53CAB103A34
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 0E5BF8FEA2
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

By popular demands, I add the functionality to mute / unmute the
line-out jacks per the headphone plug / unplug.  For achieving this
and keeping the compatibility with the old behavior, the new mixer
enum "Auto-Mute Mode" is added.  With this, user can control the
auto-mute behavior either disabled, speaker-only or lineout+speaker.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |  146 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b76d3b3..9e2594d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1129,18 +1129,28 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 static void update_speakers(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	int on;
 
+	if (!spec->automute)
+		on = 0;
+	else
+		on = spec->jack_present | spec->line_jack_present;
+	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
-		    spec->autocfg.speaker_pins,
-		    spec->jack_present | spec->line_jack_present |
-		    spec->master_mute, false);
+		    spec->autocfg.speaker_pins, on, false);
 
 	/* toggle line-out mutes if needed, too */
-	if (!spec->automute_lines)
+	/* if LO is a copy of either HP or Speaker, don't need to handle it */
+	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0] ||
+	    spec->autocfg.line_out_pins[0] == spec->autocfg.speaker_pins[0])
 		return;
+	if (!spec->automute_lines || !spec->automute)
+		on = 0;
+	else
+		on = spec->jack_present;
+	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
-		    spec->autocfg.line_out_pins,
-		    spec->jack_present | spec->master_mute, false);
+		    spec->autocfg.line_out_pins, on, false);
 }
 
 static void alc_hp_automute(struct hda_codec *codec)
@@ -1414,6 +1424,95 @@ static void alc_auto_init_amp(struct hda_codec *codec, int type)
 	}
 }
 
+static int alc_automute_mode_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	static const char * const texts[] = {
+		"Disabled", "Speaker Only", "Line-Out+Speaker"
+	};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 3;
+	if (uinfo->value.enumerated.item >= 3)
+		uinfo->value.enumerated.item = 2;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int alc_automute_mode_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	unsigned int val;
+	if (!spec->automute)
+		val = 0;
+	else if (!spec->automute_lines)
+		val = 1;
+	else
+		val = 2;
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int alc_automute_mode_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+
+	switch (ucontrol->value.enumerated.item[0]) {
+	case 0:
+		if (!spec->automute)
+			return 0;
+		spec->automute = 0;
+		break;
+	case 1:
+		if (spec->automute && !spec->automute_lines)
+			return 0;
+		spec->automute = 1;
+		spec->automute_lines = 0;
+		break;
+	case 2:
+		if (spec->automute && spec->automute_lines)
+			return 0;
+		spec->automute = 1;
+		spec->automute_lines = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	update_speakers(codec);
+	return 1;
+}
+
+static struct snd_kcontrol_new alc_automute_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Auto-Mute Mode",
+	.info = alc_automute_mode_info,
+	.get = alc_automute_mode_get,
+	.put = alc_automute_mode_put,
+};
+
+static struct snd_kcontrol_new *alc_kcontrol_new(struct alc_spec *spec);
+
+static int alc_add_automute_mode_enum(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	struct snd_kcontrol_new *knew;
+
+	knew = alc_kcontrol_new(spec);
+	if (!knew)
+		return -ENOMEM;
+	*knew = alc_automute_mode_enum;
+	knew->name = kstrdup("Auto-Mute Mode", GFP_KERNEL);
+	if (!knew->name)
+		return -ENOMEM;
+	return 0;
+}
+
 static void alc_init_auto_hp(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -1440,14 +1539,37 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 	}
 
 	for (i = 0; i < cfg->hp_outs; i++) {
+		hda_nid_t nid = cfg->hp_pins[i];
+		if (!(snd_hda_query_pin_caps(codec, nid) &
+		      AC_PINCAP_PRES_DETECT))
+			continue;
 		snd_printdd("realtek: Enable HP auto-muting on NID 0x%x\n",
-			    cfg->hp_pins[i]);
-		snd_hda_codec_write_cache(codec, cfg->hp_pins[i], 0,
+			    nid);
+		snd_hda_codec_write_cache(codec, nid, 0,
 				  AC_VERB_SET_UNSOLICITED_ENABLE,
 				  AC_USRSP_EN | ALC880_HP_EVENT);
 		spec->automute = 1;
 		spec->automute_mode = ALC_AUTOMUTE_PIN;
 	}
+	if (spec->automute && cfg->line_out_pins[0] &&
+	    cfg->line_out_pins[0] != cfg->hp_pins[0] &&
+	    cfg->line_out_pins[0] != cfg->speaker_pins[0]) {
+		for (i = 0; i < cfg->line_outs; i++) {
+			hda_nid_t nid = cfg->line_out_pins[i];
+			if (!(snd_hda_query_pin_caps(codec, nid) &
+			      AC_PINCAP_PRES_DETECT))
+				continue;
+			snd_printdd("realtek: Enable Line-Out auto-muting "
+				    "on NID 0x%x\n", nid);
+			snd_hda_codec_write_cache(codec, nid, 0,
+					AC_VERB_SET_UNSOLICITED_ENABLE,
+					AC_USRSP_EN | ALC880_FRONT_EVENT);
+			spec->detect_line = 1;
+		}
+		/* create a control for automute mode */
+		alc_add_automute_mode_enum(codec);
+		spec->automute_lines = 1;
+	}
 	spec->unsol_event = alc_sku_unsol_event;
 }
 
@@ -1684,9 +1806,6 @@ do_sku:
 				return 1;
 		spec->autocfg.hp_pins[0] = nid;
 	}
-
-	alc_init_auto_hp(codec);
-	alc_init_auto_mic(codec);
 	return 1;
 }
 
@@ -1699,9 +1818,10 @@ static void alc_ssid_check(struct hda_codec *codec,
 		snd_printd("realtek: "
 			   "Enable default setup for auto mode as fallback\n");
 		spec->init_amp = ALC_INIT_DEFAULT;
-		alc_init_auto_hp(codec);
-		alc_init_auto_mic(codec);
 	}
+
+	alc_init_auto_hp(codec);
+	alc_init_auto_mic(codec);
 }
 
 /*
-- 
1.7.4.2
