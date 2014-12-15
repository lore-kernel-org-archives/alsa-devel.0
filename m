From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Make add_stereo_mix_input flag
	tristate
Date: Mon, 15 Dec 2014 13:56:42 +0100
Message-ID: <1418648202-2509-2-git-send-email-tiwai@suse.de>
References: <1418648202-2509-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E2B44260490
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 13:56:49 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B0C8FAC8B
 for <alsa-devel@alsa-project.org>; Mon, 15 Dec 2014 12:56:49 +0000 (UTC)
In-Reply-To: <1418648202-2509-1-git-send-email-tiwai@suse.de>
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

... for distinguishing whether it's explicitly enabled via a user hint
or enabled by a driver as a fallback.  Now the former case corresponds
to HDA_HINT_STEREO_MIX_ENABLE while the latter to
HDA_HINT_STEREO_MIX_AUTO.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c    | 8 +++-----
 sound/pci/hda/hda_generic.h    | 9 ++++++++-
 sound/pci/hda/patch_analog.c   | 3 ++-
 sound/pci/hda/patch_conexant.c | 4 ++--
 sound/pci/hda/patch_via.c      | 2 +-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 293af6b5ba3d..b680b4ec6331 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3218,8 +3218,7 @@ static int create_input_ctls(struct hda_codec *codec)
 	}
 
 	/* add stereo mix when explicitly enabled via hint */
-	if (mixer && spec->add_stereo_mix_input &&
-	    snd_hda_get_bool_hint(codec, "add_stereo_mix_input") > 0) {
+	if (mixer && spec->add_stereo_mix_input == HDA_HINT_STEREO_MIX_ENABLE) {
 		err = parse_capture_source(codec, mixer, CFG_IDX_MIX, num_adcs,
 					   "Stereo Mix", 0);
 		if (err < 0)
@@ -4544,9 +4543,8 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 
 	/* add stereo mix if available and not enabled yet */
 	if (!spec->auto_mic && spec->mixer_nid &&
-	    spec->add_stereo_mix_input &&
-	    spec->input_mux.num_items > 1 &&
-	    snd_hda_get_bool_hint(codec, "add_stereo_mix_input") < 0) {
+	    spec->add_stereo_mix_input == HDA_HINT_STEREO_MIX_AUTO &&
+	    spec->input_mux.num_items > 1) {
 		err = parse_capture_source(codec, spec->mixer_nid,
 					   CFG_IDX_MIX, spec->num_all_adcs,
 					   "Stereo Mix", 0);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 61dd5153f512..3d852660443a 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -222,7 +222,7 @@ struct hda_gen_spec {
 	unsigned int vmaster_mute_enum:1; /* add vmaster mute mode enum */
 	unsigned int indep_hp:1; /* independent HP supported */
 	unsigned int prefer_hp_amp:1; /* enable HP amp for speaker if any */
-	unsigned int add_stereo_mix_input:1; /* add aamix as a capture src */
+	unsigned int add_stereo_mix_input:2; /* add aamix as a capture src */
 	unsigned int add_jack_modes:1; /* add i/o jack mode enum ctls */
 	unsigned int power_down_unused:1; /* power down unused widgets */
 	unsigned int dac_min_mute:1; /* minimal = mute for DACs */
@@ -291,6 +291,13 @@ struct hda_gen_spec {
 				    struct hda_jack_callback *cb);
 };
 
+/* values for add_stereo_mix_input flag */
+enum {
+	HDA_HINT_STEREO_MIX_DISABLE,	/* No stereo mix input */
+	HDA_HINT_STEREO_MIX_ENABLE,	/* Add stereo mix input */
+	HDA_HINT_STEREO_MIX_AUTO,	/* Add only if auto-mic is disabled */
+};
+
 int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
 
 int snd_hda_gen_init(struct hda_codec *codec);
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index c81b715d6c98..eb54da757407 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -195,7 +195,8 @@ static int ad198x_parse_auto_config(struct hda_codec *codec, bool indep_hp)
 	codec->no_sticky_stream = 1;
 
 	spec->gen.indep_hp = indep_hp;
-	spec->gen.add_stereo_mix_input = 1;
+	if (!spec->gen.add_stereo_mix_input)
+		spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
 
 	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
 	if (err < 0)
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index e9ebc7bd752c..fd3ed18670e9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -855,14 +855,14 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f15045:
 		codec->single_adc_amp = 1;
 		spec->gen.mixer_nid = 0x17;
-		spec->gen.add_stereo_mix_input = 1;
+		spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
 		snd_hda_pick_fixup(codec, cxt5045_fixup_models,
 				   cxt5045_fixups, cxt_fixups);
 		break;
 	case 0x14f15047:
 		codec->pin_amp_workaround = 1;
 		spec->gen.mixer_nid = 0x19;
-		spec->gen.add_stereo_mix_input = 1;
+		spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
 		snd_hda_pick_fixup(codec, cxt5047_fixup_models,
 				   cxt5047_fixups, cxt_fixups);
 		break;
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 6c206b6c8d65..3de6d3d779c9 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -137,7 +137,7 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 	spec->gen.indep_hp = 1;
 	spec->gen.keep_eapd_on = 1;
 	spec->gen.pcm_playback_hook = via_playback_pcm_hook;
-	spec->gen.add_stereo_mix_input = 1;
+	spec->gen.add_stereo_mix_input = HDA_HINT_STEREO_MIX_AUTO;
 	return spec;
 }
 
-- 
2.2.0
