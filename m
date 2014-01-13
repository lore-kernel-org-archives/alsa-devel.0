From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Don't set indep_hp flag for old AD
	codecs
Date: Mon, 13 Jan 2014 12:43:32 +0100
Message-ID: <1389613412-21768-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 381332608B7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 12:43:33 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 117EFAC34
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 11:43:33 +0000 (UTC)
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

Some old AD codecs don't like the independent HP handling, either it
contains a single DAC (AD1981) or it mandates the mixer routing
(AD1986A).  This patch removes the indep_hp flag for such codecs.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=68081
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_analog.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_analog.c b/sound/pci/hda/patch_analog.c
index 819d4a98abaf..7a426ed491f2 100644
--- a/sound/pci/hda/patch_analog.c
+++ b/sound/pci/hda/patch_analog.c
@@ -185,7 +185,7 @@ static const struct hda_codec_ops ad198x_auto_patch_ops = {
 };
 
 
-static int ad198x_parse_auto_config(struct hda_codec *codec)
+static int ad198x_parse_auto_config(struct hda_codec *codec, bool indep_hp)
 {
 	struct ad198x_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->gen.autocfg;
@@ -195,7 +195,7 @@ static int ad198x_parse_auto_config(struct hda_codec *codec)
 	codec->no_trigger_sense = 1;
 	codec->no_sticky_stream = 1;
 
-	spec->gen.indep_hp = 1;
+	spec->gen.indep_hp = indep_hp;
 	spec->gen.add_stereo_mix_input = 1;
 
 	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
@@ -379,7 +379,7 @@ static int patch_ad1986a(struct hda_codec *codec)
 			   ad1986a_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
-	err = ad198x_parse_auto_config(codec);
+	err = ad198x_parse_auto_config(codec, false);
 	if (err < 0) {
 		snd_hda_gen_free(codec);
 		return err;
@@ -481,7 +481,7 @@ static int patch_ad1983(struct hda_codec *codec)
 
 	spec->gen.beep_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
-	err = ad198x_parse_auto_config(codec);
+	err = ad198x_parse_auto_config(codec, false);
 	if (err < 0)
 		goto error;
 	err = ad1983_add_spdif_mux_ctl(codec);
@@ -568,7 +568,7 @@ static int patch_ad1981(struct hda_codec *codec)
 	snd_hda_pick_fixup(codec, NULL, ad1981_fixup_tbl, ad1981_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
-	err = ad198x_parse_auto_config(codec);
+	err = ad198x_parse_auto_config(codec, false);
 	if (err < 0)
 		goto error;
 	err = ad1983_add_spdif_mux_ctl(codec);
@@ -894,7 +894,7 @@ static int patch_ad1988(struct hda_codec *codec)
 	snd_hda_pick_fixup(codec, ad1988_fixup_models, NULL, ad1988_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
-	err = ad198x_parse_auto_config(codec);
+	err = ad198x_parse_auto_config(codec, true);
 	if (err < 0)
 		goto error;
 	err = ad1988_add_spdif_mux_ctl(codec);
@@ -1071,7 +1071,7 @@ static int patch_ad1884(struct hda_codec *codec)
 	snd_hda_pick_fixup(codec, NULL, ad1884_fixup_tbl, ad1884_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
-	err = ad198x_parse_auto_config(codec);
+	err = ad198x_parse_auto_config(codec, true);
 	if (err < 0)
 		goto error;
 	err = ad1983_add_spdif_mux_ctl(codec);
@@ -1113,7 +1113,7 @@ static int patch_ad1882(struct hda_codec *codec)
 	spec->gen.mixer_merge_nid = 0x21;
 	spec->gen.beep_nid = 0x10;
 	set_beep_amp(spec, 0x10, 0, HDA_OUTPUT);
-	err = ad198x_parse_auto_config(codec);
+	err = ad198x_parse_auto_config(codec, true);
 	if (err < 0)
 		goto error;
 	err = ad1988_add_spdif_mux_ctl(codec);
-- 
1.8.5.2
