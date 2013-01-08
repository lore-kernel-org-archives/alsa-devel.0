From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 051/112] ALSA: hda - Export standard jack event
	handlers for generic parser
Date: Tue,  8 Jan 2013 12:38:44 +0100
Message-ID: <1357645185-7645-52-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A77DB2651C7
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 0BE7FA52A2
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

These handlers are supposed to be called externally from the codec
drivers once when they need to handle own jack events.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 26 +++++++++++++++-----------
 sound/pci/hda/hda_generic.h |  9 +++++++++
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 364ec06..6914d70 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2414,7 +2414,7 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 }
 
 /* Toggle outputs muting */
-static void update_outputs(struct hda_codec *codec)
+void snd_hda_gen_update_outputs(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int on;
@@ -2448,6 +2448,7 @@ static void update_outputs(struct hda_codec *codec)
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 		    spec->autocfg.line_out_pins, on, false);
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_update_outputs);
 
 static void call_update_outputs(struct hda_codec *codec)
 {
@@ -2455,11 +2456,11 @@ static void call_update_outputs(struct hda_codec *codec)
 	if (spec->automute_hook)
 		spec->automute_hook(codec);
 	else
-		update_outputs(codec);
+		snd_hda_gen_update_outputs(codec);
 }
 
 /* standard HP-automute helper */
-static void hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
+void snd_hda_gen_hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct hda_gen_spec *spec = codec->spec;
 
@@ -2470,9 +2471,10 @@ static void hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 		return;
 	call_update_outputs(codec);
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_hp_automute);
 
 /* standard line-out-automute helper */
-static void line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
+void snd_hda_gen_line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct hda_gen_spec *spec = codec->spec;
 
@@ -2489,9 +2491,10 @@ static void line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
 		return;
 	call_update_outputs(codec);
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_line_automute);
 
 /* standard mic auto-switch helper */
-static void mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *jack)
+void snd_hda_gen_mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *jack)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
@@ -2507,6 +2510,7 @@ static void mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *jack)
 	}
 	mux_select(codec, 0, spec->am_entry[0].idx);
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_mic_autoswitch);
 
 /*
  * Auto-Mute mode mixer enum support
@@ -2639,7 +2643,7 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 		snd_printdd("hda-codec: Enable HP auto-muting on NID 0x%x\n",
 			    nid);
 		snd_hda_jack_detect_enable_callback(codec, nid, HDA_GEN_HP_EVENT,
-						    hp_automute);
+						    snd_hda_gen_hp_automute);
 		spec->detect_hp = 1;
 	}
 
@@ -2652,7 +2656,7 @@ static int check_auto_mute_availability(struct hda_codec *codec)
 				snd_printdd("hda-codec: Enable Line-Out auto-muting on NID 0x%x\n", nid);
 				snd_hda_jack_detect_enable_callback(codec, nid,
 								    HDA_GEN_FRONT_EVENT,
-								    line_automute);
+								    snd_hda_gen_line_automute);
 				spec->detect_lo = 1;
 			}
 		spec->automute_lo_possible = spec->detect_hp;
@@ -2704,7 +2708,7 @@ static bool auto_mic_check_imux(struct hda_codec *codec)
 		snd_hda_jack_detect_enable_callback(codec,
 						    spec->am_entry[i].pin,
 						    HDA_GEN_MIC_EVENT,
-						    mic_autoswitch);
+						    snd_hda_gen_mic_autoswitch);
 	return true;
 }
 
@@ -3536,9 +3540,9 @@ int snd_hda_gen_init(struct hda_codec *codec)
 	init_digital(codec);
 
 	/* call init functions of standard auto-mute helpers */
-	hp_automute(codec, NULL);
-	line_automute(codec, NULL);
-	mic_autoswitch(codec, NULL);
+	snd_hda_gen_hp_automute(codec, NULL);
+	snd_hda_gen_line_automute(codec, NULL);
+	snd_hda_gen_mic_autoswitch(codec, NULL);
 
 	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
 		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 1a3b404..417ab65 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -199,4 +199,13 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 int snd_hda_gen_build_controls(struct hda_codec *codec);
 int snd_hda_gen_build_pcms(struct hda_codec *codec);
 
+/* standard jack event callbacks */
+void snd_hda_gen_hp_automute(struct hda_codec *codec,
+			     struct hda_jack_tbl *jack);
+void snd_hda_gen_line_automute(struct hda_codec *codec,
+			       struct hda_jack_tbl *jack);
+void snd_hda_gen_mic_autoswitch(struct hda_codec *codec,
+				struct hda_jack_tbl *jack);
+void snd_hda_gen_update_outputs(struct hda_codec *codec);
+
 #endif /* __SOUND_HDA_GENERIC_H */
-- 
1.8.0.1
