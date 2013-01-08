From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 097/112] ALSA: hda - Drop unneeded pin argument
	from set_output_and_unmute()
Date: Tue,  8 Jan 2013 12:39:30 +0100
Message-ID: <1357645185-7645-98-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E9B9265232
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:27 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id F2DD8A5391
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

Just a minor refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 823fac5..dd65d2a 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3751,16 +3751,18 @@ EXPORT_SYMBOL_HDA(snd_hda_gen_build_pcms);
  * Standard auto-parser initializations
  */
 
-/* configure the path from the given dac to the pin as the proper output */
-static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
+/* configure the given path as a proper output */
+static void set_output_and_unmute(struct hda_codec *codec,
 				  int pin_type, int path_idx)
 {
 	struct nid_path *path;
+	hda_nid_t pin;
 
-	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
 	path = snd_hda_get_path_from_idx(codec, path_idx);
-	if (!path)
+	if (!path || !path->depth)
 		return;
+	pin = path->path[path->depth - 1];
+	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
 	snd_hda_activate_path(codec, path, path->active, true);
 	set_pin_eapd(codec, pin, path->active);
 }
@@ -3769,7 +3771,6 @@ static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
 static void init_multi_out(struct hda_codec *codec)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	hda_nid_t nid;
 	int pin_type;
 	int i;
 
@@ -3778,27 +3779,18 @@ static void init_multi_out(struct hda_codec *codec)
 	else
 		pin_type = PIN_OUT;
 
-	for (i = 0; i < spec->autocfg.line_outs; i++) {
-		nid = spec->autocfg.line_out_pins[i];
-		if (nid)
-			set_output_and_unmute(codec, nid, pin_type,
-					      spec->out_paths[i]);
-	}
+	for (i = 0; i < spec->autocfg.line_outs; i++)
+		set_output_and_unmute(codec, pin_type, spec->out_paths[i]);
 }
 
 
 static void __init_extra_out(struct hda_codec *codec, int num_outs,
-			     hda_nid_t *pins, int *paths, int type)
+			     int *paths, int type)
 {
 	int i;
-	hda_nid_t pin;
 
-	for (i = 0; i < num_outs; i++) {
-		pin = pins[i];
-		if (!pin)
-			break;
-		set_output_and_unmute(codec, pin, type, paths[i]);
-	}
+	for (i = 0; i < num_outs; i++)
+		set_output_and_unmute(codec, type, paths[i]);
 }
 
 /* initialize hp and speaker paths */
@@ -3808,11 +3800,9 @@ static void init_extra_out(struct hda_codec *codec)
 
 	if (spec->autocfg.line_out_type != AUTO_PIN_HP_OUT)
 		__init_extra_out(codec, spec->autocfg.hp_outs,
-				 spec->autocfg.hp_pins,
 				 spec->hp_paths, PIN_HP);
 	if (spec->autocfg.line_out_type != AUTO_PIN_SPEAKER_OUT)
 		__init_extra_out(codec, spec->autocfg.speaker_outs,
-				 spec->autocfg.speaker_pins,
 				 spec->speaker_paths, PIN_OUT);
 }
 
@@ -3909,13 +3899,8 @@ static void init_digital(struct hda_codec *codec)
 	int i;
 	hda_nid_t pin;
 
-	for (i = 0; i < spec->autocfg.dig_outs; i++) {
-		pin = spec->autocfg.dig_out_pins[i];
-		if (!pin)
-			continue;
-		set_output_and_unmute(codec, pin, PIN_OUT,
-				      spec->digout_paths[i]);
-	}
+	for (i = 0; i < spec->autocfg.dig_outs; i++)
+		set_output_and_unmute(codec, PIN_OUT, spec->digout_paths[i]);
 	pin = spec->autocfg.dig_in_pin;
 	if (pin) {
 		struct nid_path *path;
-- 
1.8.0.1
