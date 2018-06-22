From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/16] ALSA: hda/realtek - Use common helper
	for creating beep controls
Date: Fri, 22 Jun 2018 11:53:47 +0200
Message-ID: <20180622095352.19451-12-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 493EC2676FD
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C2A0BAFAA
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

In the Realtek codec driver, we used to build kctl elements for beep
mixer in the own build_controls callback.  This is an open-code and
can be covered by the standard feature of the generic parser with
snd_hda_gen_add_kctl() instead.

Also, after the conversion, spec->beep_amp becomes superfluous; hence
it's removed along with the conversion.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 114 +++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 49 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 42d3b0f77577..0e84d9cdd42d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -83,8 +83,6 @@ struct alc_spec {
 	struct hda_gen_spec gen; /* must be at head */
 
 	/* codec parameterization */
-	unsigned int beep_amp;	/* beep amp value, set via set_beep_amp() */
-
 	struct alc_customize_define cdefine;
 	unsigned int parse_flags; /* flag for snd_hda_parse_pin_defcfg() */
 
@@ -763,41 +761,14 @@ static void alc_fixup_inv_dmic(struct hda_codec *codec,
 }
 
 
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-/* additional beep mixers; the actual parameters are overwritten at build */
-static const struct snd_kcontrol_new alc_beep_mixer[] = {
-	HDA_CODEC_VOLUME("Beep Playback Volume", 0, 0, HDA_INPUT),
-	HDA_CODEC_MUTE_BEEP("Beep Playback Switch", 0, 0, HDA_INPUT),
-	{ } /* end */
-};
-#endif
-
 static int alc_build_controls(struct hda_codec *codec)
 {
-	struct alc_spec *spec = codec->spec;
 	int err;
 
 	err = snd_hda_gen_build_controls(codec);
 	if (err < 0)
 		return err;
 
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-	/* create beep controls if needed */
-	if (spec->beep_amp) {
-		const struct snd_kcontrol_new *knew;
-		for (knew = alc_beep_mixer; knew->name; knew++) {
-			struct snd_kcontrol *kctl;
-			kctl = snd_ctl_new1(knew, codec);
-			if (!kctl)
-				return -ENOMEM;
-			kctl->private_value = spec->beep_amp;
-			err = snd_hda_ctl_add(codec, 0, kctl);
-			if (err < 0)
-				return err;
-		}
-	}
-#endif
-
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_BUILD);
 	return 0;
 }
@@ -1008,8 +979,30 @@ static int alc_codec_rename_from_preset(struct hda_codec *codec)
  * Digital-beep handlers
  */
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
-#define set_beep_amp(spec, nid, idx, dir) \
-	((spec)->beep_amp = HDA_COMPOSE_AMP_VAL(nid, 3, idx, dir))
+
+/* additional beep mixers; private_value will be overwritten */
+static const struct snd_kcontrol_new alc_beep_mixer[] = {
+	HDA_CODEC_VOLUME("Beep Playback Volume", 0, 0, HDA_INPUT),
+	HDA_CODEC_MUTE_BEEP("Beep Playback Switch", 0, 0, HDA_INPUT),
+};
+
+/* set up and create beep controls */
+static int set_beep_amp(struct alc_spec *spec, hda_nid_t nid,
+			int idx, int dir)
+{
+	struct snd_kcontrol_new *knew;
+	unsigned int beep_amp = HDA_COMPOSE_AMP_VAL(nid, 3, idx, dir);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(alc_beep_mixer); i++) {
+		knew = snd_hda_gen_add_kctl(&spec->gen, NULL,
+					    &alc_beep_mixer[i]);
+		if (!knew)
+			return -ENOMEM;
+		knew->private_value = beep_amp;
+	}
+	return 0;
+}
 
 static const struct snd_pci_quirk beep_white_list[] = {
 	SND_PCI_QUIRK(0x1043, 0x103c, "ASUS", 1),
@@ -1034,7 +1027,7 @@ static inline int has_cdefine_beep(struct hda_codec *codec)
 	return spec->cdefine.enable_pcbeep;
 }
 #else
-#define set_beep_amp(spec, nid, idx, dir) /* NOP */
+#define set_beep_amp(spec, nid, idx, dir)	0
 #define has_cdefine_beep(codec)		0
 #endif
 
@@ -1536,8 +1529,11 @@ static int patch_alc880(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog)
-		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+	if (!spec->gen.no_analog) {
+		err = set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -1784,8 +1780,11 @@ static int patch_alc260(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog)
-		set_beep_amp(spec, 0x07, 0x05, HDA_INPUT);
+	if (!spec->gen.no_analog) {
+		err = set_beep_amp(spec, 0x07, 0x05, HDA_INPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -2434,8 +2433,11 @@ static int patch_alc882(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog && spec->gen.beep_nid)
-		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+	if (!spec->gen.no_analog && spec->gen.beep_nid) {
+		err = set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -2596,8 +2598,11 @@ static int patch_alc262(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog && spec->gen.beep_nid)
-		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+	if (!spec->gen.no_analog && spec->gen.beep_nid) {
+		err = set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -7168,8 +7173,11 @@ static int patch_alc269(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog && spec->gen.beep_nid && spec->gen.mixer_nid)
-		set_beep_amp(spec, spec->gen.mixer_nid, 0x04, HDA_INPUT);
+	if (!spec->gen.no_analog && spec->gen.beep_nid && spec->gen.mixer_nid) {
+		err = set_beep_amp(spec, spec->gen.mixer_nid, 0x04, HDA_INPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -7298,8 +7306,11 @@ static int patch_alc861(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog)
-		set_beep_amp(spec, 0x23, 0, HDA_OUTPUT);
+	if (!spec->gen.no_analog) {
+		err = set_beep_amp(spec, 0x23, 0, HDA_OUTPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -7392,8 +7403,11 @@ static int patch_alc861vd(struct hda_codec *codec)
 	if (err < 0)
 		goto error;
 
-	if (!spec->gen.no_analog)
-		set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+	if (!spec->gen.no_analog) {
+		err = set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+		if (err < 0)
+			goto error;
+	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
@@ -8103,18 +8117,20 @@ static int patch_alc662(struct hda_codec *codec)
 	if (!spec->gen.no_analog && spec->gen.beep_nid) {
 		switch (codec->core.vendor_id) {
 		case 0x10ec0662:
-			set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
+			err = set_beep_amp(spec, 0x0b, 0x05, HDA_INPUT);
 			break;
 		case 0x10ec0272:
 		case 0x10ec0663:
 		case 0x10ec0665:
 		case 0x10ec0668:
-			set_beep_amp(spec, 0x0b, 0x04, HDA_INPUT);
+			err = set_beep_amp(spec, 0x0b, 0x04, HDA_INPUT);
 			break;
 		case 0x10ec0273:
-			set_beep_amp(spec, 0x0b, 0x03, HDA_INPUT);
+			err = set_beep_amp(spec, 0x0b, 0x03, HDA_INPUT);
 			break;
 		}
+		if (err < 0)
+			goto error;
 	}
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
-- 
2.17.1
