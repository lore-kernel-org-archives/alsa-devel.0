From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Mute the right widget in
	auto_mute_via_amp mode
Date: Tue, 13 Aug 2013 09:12:20 +0200
Message-ID: <1376377940-28450-2-git-send-email-tiwai@suse.de>
References: <1376377940-28450-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id B82D7265119
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 09:10:56 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 47EB4A51CB
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 09:10:56 +0200 (CEST)
In-Reply-To: <1376377940-28450-1-git-send-email-tiwai@suse.de>
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

The current generic parser code assumes that always a pin widget
controls the mute for an output blindly although it might be a
different widget in the middle.  Instead of the fixed assumption,
check each parsed path and just pick up the right widget that has been
already defined as a mute control.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 6ed2209..fd1965c 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3768,7 +3768,7 @@ static bool detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
 
 /* standard HP/line-out auto-mute helper */
 static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
-			bool mute)
+			int *paths, bool mute)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
@@ -3780,10 +3780,19 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 			break;
 
 		if (spec->auto_mute_via_amp) {
+			struct nid_path *path;
+			hda_nid_t mute_nid;
+
+			path = snd_hda_get_path_from_idx(codec, paths[i]);
+			if (!path)
+				continue;
+			mute_nid = get_amp_nid_(path->ctls[NID_PATH_MUTE_CTL]);
+			if (!mute_nid)
+				continue;
 			if (mute)
-				spec->mute_bits |= (1ULL << nid);
+				spec->mute_bits |= (1ULL << mute_nid);
 			else
-				spec->mute_bits &= ~(1ULL << nid);
+				spec->mute_bits &= ~(1ULL << mute_nid);
 			set_pin_eapd(codec, nid, !mute);
 			continue;
 		}
@@ -3814,14 +3823,19 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 void snd_hda_gen_update_outputs(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
+	int *paths;
 	int on;
 
 	/* Control HP pins/amps depending on master_mute state;
 	 * in general, HP pins/amps control should be enabled in all cases,
 	 * but currently set only for master_mute, just to be safe
 	 */
+	if (spec->autocfg.line_out_type == AUTO_PIN_HP_OUT)
+		paths = spec->out_paths;
+	else
+		paths = spec->hp_paths;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
-		    spec->autocfg.hp_pins, spec->master_mute);
+		    spec->autocfg.hp_pins, paths, spec->master_mute);
 
 	if (!spec->automute_speaker)
 		on = 0;
@@ -3829,8 +3843,12 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 		on = spec->hp_jack_present | spec->line_jack_present;
 	on |= spec->master_mute;
 	spec->speaker_muted = on;
+	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
+		paths = spec->out_paths;
+	else
+		paths = spec->speaker_paths;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
-		    spec->autocfg.speaker_pins, on);
+		    spec->autocfg.speaker_pins, paths, on);
 
 	/* toggle line-out mutes if needed, too */
 	/* if LO is a copy of either HP or Speaker, don't need to handle it */
@@ -3843,8 +3861,9 @@ void snd_hda_gen_update_outputs(struct hda_codec *codec)
 		on = spec->hp_jack_present;
 	on |= spec->master_mute;
 	spec->line_out_muted = on;
+	paths = spec->out_paths;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
-		    spec->autocfg.line_out_pins, on);
+		    spec->autocfg.line_out_pins, paths, on);
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_update_outputs);
 
-- 
1.8.3.1
