From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 037/112] ALSA: hda/realtek - Merge a few split
	functions
Date: Tue,  8 Jan 2013 12:38:30 +0100
Message-ID: <1357645185-7645-38-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7697B2651B8
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id B4739A5233
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
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

Merge a few functions that have been split due to historical reasons
to single functions.  Splitting too much (and placing too far away)
actually worsens the readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c980489..7f4ad78 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -653,14 +653,6 @@ static void alc880_unsol_event(struct hda_codec *codec, unsigned int res)
 	snd_hda_jack_unsol_event(codec, res >> 2);
 }
 
-/* call init functions of standard auto-mute helpers */
-static void alc_inithook(struct hda_codec *codec)
-{
-	alc_hp_automute(codec, NULL);
-	alc_line_automute(codec, NULL);
-	alc_mic_automute(codec, NULL);
-}
-
 /* additional initialization for ALC888 variants */
 static void alc888_coef_init(struct hda_codec *codec)
 {
@@ -1619,7 +1611,7 @@ static const struct snd_kcontrol_new alc_beep_mixer[] = {
 };
 #endif
 
-static int __alc_build_controls(struct hda_codec *codec)
+static int alc_build_controls(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	int i, err;
@@ -1693,13 +1685,6 @@ static int __alc_build_controls(struct hda_codec *codec)
 
 	alc_free_kctls(codec); /* no longer needed */
 
-	return 0;
-}
-
-static int alc_build_jacks(struct hda_codec *codec)
-{
-	struct alc_spec *spec = codec->spec;
-
 	if (spec->shared_mic_hp) {
 		int err;
 		int nid = spec->autocfg.inputs[1].pin;
@@ -1711,18 +1696,10 @@ static int alc_build_jacks(struct hda_codec *codec)
 			return err;
 	}
 
-	return snd_hda_jack_add_kctls(codec, &spec->autocfg);
-}
-
-static int alc_build_controls(struct hda_codec *codec)
-{
-	int err = __alc_build_controls(codec);
+	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
 	if (err < 0)
 		return err;
 
-	err = alc_build_jacks(codec);
-	if (err < 0)
-		return err;
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_BUILD);
 	return 0;
 }
@@ -4244,7 +4221,10 @@ static void alc_auto_init_std(struct hda_codec *codec)
 	alc_auto_init_analog_input(codec);
 	alc_auto_init_input_src(codec);
 	alc_auto_init_digital(codec);
-	alc_inithook(codec);
+	/* call init functions of standard auto-mute helpers */
+	alc_hp_automute(codec, NULL);
+	alc_line_automute(codec, NULL);
+	alc_mic_automute(codec, NULL);
 }
 
 /*
-- 
1.8.0.1
