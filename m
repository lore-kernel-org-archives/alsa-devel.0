From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda/realtek - Apply PRE_PROBE fixup
	after ALC269 codec variant setups
Date: Fri, 22 Jun 2018 11:58:39 +0200
Message-ID: <20180622095839.19844-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 948E72673F2
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:58:41 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5AAAADC6
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:58:40 +0000 (UTC)
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

Currently patch_alc269() calls the fixup with HDA_FIXUP_ACT_PRE_PROBE
before setting up the codec model-specific setups (e.g. setting
codec_variant or mixer_nid setup).  This is rather confusing as others
do call the *_PRE_PROBE fixup after such a setup.  Due to this
disorder, we have to override spec->shutup not at the usual
HDA_FIXUP_ACT_PRE_PROBE but the unusual HDA_FIXUP_ACT_PROBE time.

This patch corrects the fixup call orders in patch_alc269(), and also
corrects the action to set up spec->shutup accordingly.

No functional changes but just refactoring.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Yet another code refactoring that doesn't belong to previous patchsets.
I promise it's the last one in this week!

 sound/pci/hda/patch_realtek.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0e84d9cdd42d..c93e09f9c109 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4906,7 +4906,7 @@ static void alc_no_shutup(struct hda_codec *codec)
 static void alc_fixup_no_shutup(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
-	if (action == HDA_FIXUP_ACT_PROBE) {
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		struct alc_spec *spec = codec->spec;
 		spec->shutup = alc_no_shutup;
 	}
@@ -4988,10 +4988,9 @@ static void alc_fixup_dell_xps13(struct hda_codec *codec,
 		 * it causes a click noise at start up
 		 */
 		snd_hda_codec_set_pin_target(codec, 0x19, PIN_VREFHIZ);
+		spec->shutup = alc_shutup_dell_xps13;
 		break;
 	case HDA_FIXUP_ACT_PROBE:
-		spec->shutup = alc_shutup_dell_xps13;
-
 		/* Make the internal mic the default input source. */
 		for (i = 0; i < imux->num_items; i++) {
 			if (spec->gen.imux_pins[i] == 0x12) {
@@ -7037,18 +7036,6 @@ static int patch_alc269(struct hda_codec *codec)
 	spec->shutup = alc_default_shutup;
 	spec->init_hook = alc_default_init;
 
-	snd_hda_pick_fixup(codec, alc269_fixup_models,
-		       alc269_fixup_tbl, alc269_fixups);
-	snd_hda_pick_pin_fixup(codec, alc269_pin_fixup_tbl, alc269_fixups);
-	snd_hda_pick_fixup(codec, NULL,	alc269_fixup_vendor_tbl,
-			   alc269_fixups);
-	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
-
-	alc_auto_parse_customize_define(codec);
-
-	if (has_cdefine_beep(codec))
-		spec->gen.beep_nid = 0x01;
-
 	switch (codec->core.vendor_id) {
 	case 0x10ec0269:
 		spec->codec_variant = ALC269_TYPE_ALC269VA;
@@ -7168,6 +7155,18 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->init_hook = alc5505_dsp_init;
 	}
 
+	snd_hda_pick_fixup(codec, alc269_fixup_models,
+		       alc269_fixup_tbl, alc269_fixups);
+	snd_hda_pick_pin_fixup(codec, alc269_pin_fixup_tbl, alc269_fixups);
+	snd_hda_pick_fixup(codec, NULL,	alc269_fixup_vendor_tbl,
+			   alc269_fixups);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
+
+	alc_auto_parse_customize_define(codec);
+
+	if (has_cdefine_beep(codec))
+		spec->gen.beep_nid = 0x01;
+
 	/* automatic parse from the BIOS config */
 	err = alc269_parse_auto_config(codec);
 	if (err < 0)
-- 
2.17.1
