From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 069/112] ALSA: hda - Refactor init_extra_out()
	in hda_generic.c
Date: Tue,  8 Jan 2013 12:39:02 +0100
Message-ID: <1357645185-7645-70-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E5B0265204
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 6AAC2A530D
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

Just a small clean up by splitting a function.
No functional changes at all.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 49 ++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b7b8d7e..96c779b 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3389,45 +3389,44 @@ static void init_multi_out(struct hda_codec *codec)
 	}
 }
 
-/* initialize hp and speaker paths */
-static void init_extra_out(struct hda_codec *codec)
+
+static void __init_extra_out(struct hda_codec *codec, int num_outs,
+			     hda_nid_t *pins, hda_nid_t *dacs, int type)
 {
 	struct hda_gen_spec *spec = codec->spec;
 	int i;
 	hda_nid_t pin, dac;
 
-	for (i = 0; i < spec->autocfg.hp_outs; i++) {
-		if (spec->autocfg.line_out_type == AUTO_PIN_HP_OUT)
-			break;
-		pin = spec->autocfg.hp_pins[i];
-		if (!pin)
-			break;
-		dac = spec->multiout.hp_out_nid[i];
-		if (!dac) {
-			if (i > 0 && spec->multiout.hp_out_nid[0])
-				dac = spec->multiout.hp_out_nid[0];
-			else
-				dac = spec->multiout.dac_nids[0];
-		}
-		set_output_and_unmute(codec, pin, PIN_HP, dac);
-	}
-	for (i = 0; i < spec->autocfg.speaker_outs; i++) {
-		if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
-			break;
-		pin = spec->autocfg.speaker_pins[i];
+	for (i = 0; i < num_outs; i++) {
+		pin = pins[i];
 		if (!pin)
 			break;
-		dac = spec->multiout.extra_out_nid[i];
+		dac = dacs[i];
 		if (!dac) {
-			if (i > 0 && spec->multiout.extra_out_nid[0])
-				dac = spec->multiout.extra_out_nid[0];
+			if (i > 0 && dacs[0])
+				dac = dacs[0];
 			else
 				dac = spec->multiout.dac_nids[0];
 		}
-		set_output_and_unmute(codec, pin, PIN_OUT, dac);
+		set_output_and_unmute(codec, pin, type, dac);
 	}
 }
 
+/* initialize hp and speaker paths */
+static void init_extra_out(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->autocfg.line_out_type != AUTO_PIN_HP_OUT)
+		__init_extra_out(codec, spec->autocfg.hp_outs,
+				 spec->autocfg.hp_pins,
+				 spec->multiout.hp_out_nid, PIN_HP);
+	if (spec->autocfg.line_out_type != AUTO_PIN_SPEAKER_OUT)
+		__init_extra_out(codec, spec->autocfg.speaker_outs,
+				 spec->autocfg.speaker_pins,
+				 spec->multiout.extra_out_nid, PIN_OUT);
+}
+
 /* initialize multi-io paths */
 static void init_multi_io(struct hda_codec *codec)
 {
-- 
1.8.0.1
