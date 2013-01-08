From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/8] ALSA: hda - Rearrange for dropping static
	quirk codes in Coexant driver
Date: Tue,  8 Jan 2013 12:50:47 +0100
Message-ID: <1357645849-8181-7-git-send-email-tiwai@suse.de>
References: <1357645849-8181-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A96B9265F83
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8177CA51C9
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:50:59 +0100 (CET)
In-Reply-To: <1357645849-8181-1-git-send-email-tiwai@suse.de>
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

Just shuffle the codes and add ifdefs for testing to drop the static
quirk codes from patch_conexant.c.

By commenting out ENABLE_CXT_STATIC_QUIRKS define at the beginning of
the file, you can disable the whole static codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 100 +++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 43 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f27125b..47b3d5b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -35,6 +35,8 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
+#define ENABLE_CXT_STATIC_QUIRKS
+
 #define CXT_PIN_DIR_IN              0x00
 #define CXT_PIN_DIR_OUT             0x01
 #define CXT_PIN_DIR_INOUT           0x02
@@ -57,6 +59,13 @@
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
+	unsigned int beep_amp;
+
+	/* extra EAPD pins */
+	unsigned int num_eapds;
+	hda_nid_t eapds[4];
+
+#ifdef ENABLE_CXT_STATIC_QUIRKS
 	const struct snd_kcontrol_new *mixers[5];
 	int num_mixers;
 	hda_nid_t vmaster_nid;
@@ -125,14 +134,48 @@ struct conexant_spec {
 	unsigned int dc_enable;
 	unsigned int dc_input_bias; /* offset into cxt5066_olpc_dc_bias */
 	unsigned int mic_boost; /* offset into cxt5066_analog_mic_boost */
+#endif /* ENABLE_CXT_STATIC_QUIRKS */
+};
 
-	unsigned int beep_amp;
 
-	/* extra EAPD pins */
-	unsigned int num_eapds;
-	hda_nid_t eapds[4];
+#ifdef CONFIG_SND_HDA_INPUT_BEEP
+#define set_beep_amp(spec, nid, idx, dir) \
+	((spec)->beep_amp = HDA_COMPOSE_AMP_VAL(nid, 1, idx, dir))
+/* additional beep mixers; the actual parameters are overwritten at build */
+static const struct snd_kcontrol_new cxt_beep_mixer[] = {
+	HDA_CODEC_VOLUME_MONO("Beep Playback Volume", 0, 1, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE_BEEP_MONO("Beep Playback Switch", 0, 1, 0, HDA_OUTPUT),
+	{ } /* end */
 };
 
+/* create beep controls if needed */
+static int add_beep_ctls(struct hda_codec *codec)
+{
+	struct conexant_spec *spec = codec->spec;
+	int err;
+
+	if (spec->beep_amp) {
+		const struct snd_kcontrol_new *knew;
+		for (knew = cxt_beep_mixer; knew->name; knew++) {
+			struct snd_kcontrol *kctl;
+			kctl = snd_ctl_new1(knew, codec);
+			if (!kctl)
+				return -ENOMEM;
+			kctl->private_value = spec->beep_amp;
+			err = snd_hda_ctl_add(codec, 0, kctl);
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+#else
+#define set_beep_amp(spec, nid, idx, dir) /* NOP */
+#define add_beep_ctls(codec)	0
+#endif
+
+
+#ifdef ENABLE_CXT_STATIC_QUIRKS
 static int conexant_playback_pcm_open(struct hda_pcm_stream *hinfo,
 				      struct hda_codec *codec,
 				      struct snd_pcm_substream *substream)
@@ -423,38 +466,6 @@ static const struct snd_kcontrol_new cxt_capture_mixers[] = {
 	{}
 };
 
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-/* additional beep mixers; the actual parameters are overwritten at build */
-static const struct snd_kcontrol_new cxt_beep_mixer[] = {
-	HDA_CODEC_VOLUME_MONO("Beep Playback Volume", 0, 1, 0, HDA_OUTPUT),
-	HDA_CODEC_MUTE_BEEP_MONO("Beep Playback Switch", 0, 1, 0, HDA_OUTPUT),
-	{ } /* end */
-};
-/* create beep controls if needed */
-static int add_beep_ctls(struct hda_codec *codec)
-{
-	struct conexant_spec *spec = codec->spec;
-	int err;
-
-	if (spec->beep_amp) {
-		const struct snd_kcontrol_new *knew;
-		for (knew = cxt_beep_mixer; knew->name; knew++) {
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
-	return 0;
-}
-#else
-#define add_beep_ctls(codec)	0
-#endif
-
 static const char * const slave_pfxs[] = {
 	"Headphone", "Speaker", "Bass Speaker", "Front", "Surround", "CLFE",
 	NULL
@@ -543,13 +554,6 @@ static const struct hda_codec_ops conexant_patch_ops = {
 	.reboot_notify = snd_hda_shutup_pins,
 };
 
-#ifdef CONFIG_SND_HDA_INPUT_BEEP
-#define set_beep_amp(spec, nid, idx, dir) \
-	((spec)->beep_amp = HDA_COMPOSE_AMP_VAL(nid, 1, idx, dir))
-#else
-#define set_beep_amp(spec, nid, idx, dir) /* NOP */
-#endif
-
 static int patch_conexant_auto(struct hda_codec *codec);
 /*
  * EAPD control
@@ -3112,6 +3116,9 @@ static int patch_cxt5066(struct hda_codec *codec)
 	return 0;
 }
 
+#endif /* ENABLE_CXT_STATIC_QUIRKS */
+
+
 /*
  * Automatic parser for CX20641 & co
  */
@@ -3408,6 +3415,13 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	return err;
 }
 
+#ifndef ENABLE_CXT_STATIC_QUIRKS
+#define patch_cxt5045	patch_conexant_auto
+#define patch_cxt5047	patch_conexant_auto
+#define patch_cxt5051	patch_conexant_auto
+#define patch_cxt5066	patch_conexant_auto
+#endif
+
 /*
  */
 
-- 
1.8.0.1
