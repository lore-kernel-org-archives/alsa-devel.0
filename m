From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC v2 5/7] ALSA: hda - Remove superfluous
	callbacks from STAC/IDT codecs
Date: Mon, 15 Sep 2014 14:48:21 +0200
Message-ID: <1410785303-19454-6-git-send-email-tiwai@suse.de>
References: <1410785303-19454-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 76EF42616F6
 for <alsa-devel@alsa-project.org>; Mon, 15 Sep 2014 14:48:27 +0200 (CEST)
In-Reply-To: <1410785303-19454-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Now we can register multiple callbacks to each jack, most of hooks
used in STAC/IDT codecs can be removed by enabling the powermap update
callback for all relevant pins.  Along with this, the call of
stac_init_power_map() can be moved back to stac_parse_auto_config()
and the own build_controls callback can be removed, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 38 ++------------------------------------
 1 file changed, 2 insertions(+), 36 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 3193529607f2..4f6413e01c13 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -510,27 +510,6 @@ static void jack_update_power(struct hda_codec *codec,
 			    spec->power_map_bits);
 }
 
-static void stac_hp_automute(struct hda_codec *codec,
-				 struct hda_jack_callback *jack)
-{
-	snd_hda_gen_hp_automute(codec, jack);
-	jack_update_power(codec, jack);
-}
-
-static void stac_line_automute(struct hda_codec *codec,
-				   struct hda_jack_callback *jack)
-{
-	snd_hda_gen_line_automute(codec, jack);
-	jack_update_power(codec, jack);
-}
-
-static void stac_mic_autoswitch(struct hda_codec *codec,
-				struct hda_jack_callback *jack)
-{
-	snd_hda_gen_mic_autoswitch(codec, jack);
-	jack_update_power(codec, jack);
-}
-
 static void stac_vref_event(struct hda_codec *codec,
 			    struct hda_jack_callback *event)
 {
@@ -555,8 +534,6 @@ static void stac_init_power_map(struct hda_codec *codec)
 		hda_nid_t nid = spec->pwr_nids[i];
 		unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
 		def_conf = get_defcfg_connect(def_conf);
-		if (snd_hda_jack_tbl_get(codec, nid))
-			continue;
 		if (def_conf == AC_JACK_PORT_COMPLEX &&
 		    spec->vref_mute_led_nid != nid &&
 		    is_jack_detectable(codec, nid)) {
@@ -4206,9 +4183,6 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 	spec->gen.pcm_capture_hook = stac_capture_pcm_hook;
 
 	spec->gen.automute_hook = stac_update_outputs;
-	spec->gen.hp_automute_hook = stac_hp_automute;
-	spec->gen.line_automute_hook = stac_line_automute;
-	spec->gen.mic_autoswitch_hook = stac_mic_autoswitch;
 
 	err = snd_hda_gen_parse_auto_config(codec, &spec->gen.autocfg);
 	if (err < 0)
@@ -4260,16 +4234,8 @@ static int stac_parse_auto_config(struct hda_codec *codec)
 			return err;
 	}
 
-	return 0;
-}
-
-static int stac_build_controls(struct hda_codec *codec)
-{
-	int err = snd_hda_gen_build_controls(codec);
-
-	if (err < 0)
-		return err;
 	stac_init_power_map(codec);
+
 	return 0;
 }
 
@@ -4383,7 +4349,7 @@ static int stac_suspend(struct hda_codec *codec)
 #endif /* CONFIG_PM */
 
 static const struct hda_codec_ops stac_patch_ops = {
-	.build_controls = stac_build_controls,
+	.build_controls = snd_hda_gen_build_controls,
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = stac_init,
 	.free = stac_free,
-- 
2.1.0
