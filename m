From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Enable stereo mix as default for
	AD and VIA codecs
Date: Mon,  9 Dec 2013 16:06:16 +0100
Message-ID: <1386601576-15315-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F3320261AE7
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 16:06:16 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id C6678A7D86
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2013 16:06:16 +0100 (CET)
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

AD and VIA codecs had stereo mixer input enabled as default before
moving to the generic parser, and people think the lack of such a
regression.  In this patch, the stereo mixer input is added back to
the input selection if no auto-mic is available, and if it's not
disabled explicitly via hint.  This should satisfy most of demands,
i.e. stereo mix on desktop machines like what it worked before, and it
still keeps the new auto-mic feature on laptops.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c  | 19 ++++++++++++++++++-
 sound/pci/hda/patch_analog.c |  1 +
 sound/pci/hda/patch_via.c    |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 058318de1af4..44be167d1cad 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3033,6 +3033,8 @@ static int parse_capture_source(struct hda_codec *codec, hda_nid_t pin,
 			spec->imux_pins[imux->num_items] = pin;
 			snd_hda_add_imux_item(imux, label, cfg_idx, NULL);
 			imux_added = true;
+			if (spec->dyn_adc_switch)
+				spec->dyn_adc_idx[imux_idx] = c;
 		}
 	}
 
@@ -3130,7 +3132,9 @@ static int create_input_ctls(struct hda_codec *codec)
 		}
 	}
 
-	if (mixer && spec->add_stereo_mix_input) {
+	/* add stereo mix when explicitly enabled via hint */
+	if (mixer && spec->add_stereo_mix_input &&
+	    snd_hda_get_bool_hint(codec, "add_stereo_mix_input") > 0) {
 		err = parse_capture_source(codec, mixer, CFG_IDX_MIX, num_adcs,
 					   "Stereo Mix", 0);
 		if (err < 0)
@@ -4403,6 +4407,19 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	if (err < 0)
 		return err;
 
+	/* add stereo mix if available and not enabled yet */
+	if (!spec->auto_mic && spec->mixer_nid &&
+	    spec->add_stereo_mix_input &&
+	    spec->input_mux.num_items > 1 &&
+	    snd_hda_get_bool_hint(codec, "add_stereo_mix_input") < 0) {
+		err = parse_capture_source(codec, spec->mixer_nid,
+					   CFG_IDX_MIX, spec->num_all_adcs,
+					   "Stereo Mix", 0);
+		if (err < 0)
+			return err;
+	}
+
+
 	err = create_capture_mixers(codec);
 	if (err < 0)
 		return err;
diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 34d86ec5d3dd..05280033c302 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -194,6 +194,7 @@ static int ad198x_parse_auto_config(struct hda_codec *codec)
 	codec->no_sticky_stream = 1;
 
 	spec->gen.indep_hp = 1;
+	spec->gen.add_stereo_mix_input = 1;
 
 	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
 	if (err < 0)
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 0bc20ef5687a..f84195f3ea31 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -138,6 +138,7 @@ static struct via_spec *via_new_spec(struct hda_codec *codec)
 	spec->gen.indep_hp = 1;
 	spec->gen.keep_eapd_on = 1;
 	spec->gen.pcm_playback_hook = via_playback_pcm_hook;
+	spec->gen.add_stereo_mix_input = 1;
 	return spec;
 }
 
-- 
1.8.5
