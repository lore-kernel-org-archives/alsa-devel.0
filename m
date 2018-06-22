From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/16] ALSA: hda/realtek - Use common helper
	for creating ALC268 beep controls
Date: Fri, 22 Jun 2018 11:53:46 +0200
Message-ID: <20180622095352.19451-11-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA09267707
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B3ED7AFA9
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
In-Reply-To: <20180622095352.19451-1-tiwai@suse.de>
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

The beep mixer controls are the only remaining stuff that uses
spec->mixers[] array, and they can be well converted to the standard
helper in the generic parser, snd_hda_gen_add_kctl().

This simplifies the code, especially the superfluous mixers and
num_mixers fields can be now removed from alc_spec.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1ee086bcefcf..42d3b0f77577 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -83,8 +83,6 @@ struct alc_spec {
 	struct hda_gen_spec gen; /* must be at head */
 
 	/* codec parameterization */
-	const struct snd_kcontrol_new *mixers[5];	/* mixer arrays */
-	unsigned int num_mixers;
 	unsigned int beep_amp;	/* beep amp value, set via set_beep_amp() */
 
 	struct alc_customize_define cdefine;
@@ -207,18 +205,6 @@ static void alc_process_coef_fw(struct hda_codec *codec,
 	}
 }
 
-/*
- * Append the given mixer and verb elements for the later use
- * The mixer array is referred in build_controls(), and init_verbs are
- * called in init().
- */
-static void add_mixer(struct alc_spec *spec, const struct snd_kcontrol_new *mix)
-{
-	if (snd_BUG_ON(spec->num_mixers >= ARRAY_SIZE(spec->mixers)))
-		return;
-	spec->mixers[spec->num_mixers++] = mix;
-}
-
 /*
  * GPIO setup tables, used in initialization
  */
@@ -789,18 +775,12 @@ static const struct snd_kcontrol_new alc_beep_mixer[] = {
 static int alc_build_controls(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
-	int i, err;
+	int err;
 
 	err = snd_hda_gen_build_controls(codec);
 	if (err < 0)
 		return err;
 
-	for (i = 0; i < spec->num_mixers; i++) {
-		err = snd_hda_add_new_ctls(codec, spec->mixers[i]);
-		if (err < 0)
-			return err;
-	}
-
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
 	/* create beep controls if needed */
 	if (spec->beep_amp) {
@@ -2663,7 +2643,6 @@ static const struct snd_kcontrol_new alc268_beep_mixer[] = {
 		.put = alc268_beep_switch_put,
 		.private_value = HDA_COMPOSE_AMP_VAL(0x0f, 3, 1, HDA_INPUT)
 	},
-	{ }
 };
 
 /* set PCBEEP vol = 0, mute connections */
@@ -2731,7 +2710,7 @@ static int alc268_parse_auto_config(struct hda_codec *codec)
 static int patch_alc268(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
-	int err;
+	int i, err;
 
 	/* ALC268 has no aa-loopback mixer */
 	err = alc_alloc_spec(codec, 0);
@@ -2753,7 +2732,13 @@ static int patch_alc268(struct hda_codec *codec)
 
 	if (err > 0 && !spec->gen.no_analog &&
 	    spec->gen.autocfg.speaker_pins[0] != 0x1d) {
-		add_mixer(spec, alc268_beep_mixer);
+		for (i = 0; i < ARRAY_SIZE(alc268_beep_mixer); i++) {
+			if (!snd_hda_gen_add_kctl(&spec->gen, NULL,
+						  &alc268_beep_mixer[i])) {
+				err = -ENOMEM;
+				goto error;
+			}
+		}
 		snd_hda_add_verbs(codec, alc268_beep_init_verbs);
 		if (!query_amp_caps(codec, 0x1d, HDA_INPUT))
 			/* override the amp caps for beep generator */
-- 
2.17.1
