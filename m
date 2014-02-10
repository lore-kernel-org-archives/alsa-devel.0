From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Disable static quirks for C-Media
	codecs
Date: Mon, 10 Feb 2014 18:21:06 +0100
Message-ID: <1392052866-6363-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C62572625E2
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 18:21:20 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 895D1ABC3
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2014 17:21:06 +0000 (UTC)
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

According to alsa-info.sh outputs, all three entries with static
quirks have the correct pin configs, so it's safe to remove static
quirks.  For now, turn the static quirks off via ifdef.  The dead
codes will be removed in later release.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_cmedia.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/patch_cmedia.c b/sound/pci/hda/patch_cmedia.c
index 9c6ce73b03c5..139ef301c914 100644
--- a/sound/pci/hda/patch_cmedia.c
+++ b/sound/pci/hda/patch_cmedia.c
@@ -32,6 +32,9 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
+#undef ENABLE_CMI_STATIC_QUIRKS
+
+#ifdef ENABLE_CMI_STATIC_QUIRKS
 #define NUM_PINS	11
 
 
@@ -45,10 +48,12 @@ enum {
 	CMI_AUTO,	/* let driver guess it */
 	CMI_MODELS
 };
+#endif /* ENABLE_CMI_STATIC_QUIRKS */
 
 struct cmi_spec {
 	struct hda_gen_spec gen;
 
+#ifdef ENABLE_CMI_STATIC_QUIRKS
 	/* below are only for static models */
 
 	int board_config;
@@ -81,8 +86,10 @@ struct cmi_spec {
 
 	/* multichannel pins */
 	struct hda_verb multi_init[9];	/* 2 verbs for each pin + terminator */
+#endif /* ENABLE_CMI_STATIC_QUIRKS */
 };
 
+#ifdef ENABLE_CMI_STATIC_QUIRKS
 /*
  * input MUX
  */
@@ -566,6 +573,7 @@ static const struct hda_codec_ops cmi9880_patch_ops = {
 	.init = cmi9880_init,
 	.free = cmi9880_free,
 };
+#endif /* ENABLE_CMI_STATIC_QUIRKS */
 
 /*
  * stuff for auto-parser
@@ -588,15 +596,20 @@ static int cmi_parse_auto_config(struct hda_codec *codec)
 
 	err = snd_hda_parse_pin_defcfg(codec, cfg, NULL, 0);
 	if (err < 0)
-		return err;
+		goto error;
 	err = snd_hda_gen_parse_auto_config(codec, cfg);
 	if (err < 0)
-		return err;
+		goto error;
 
 	codec->patch_ops = cmi_auto_patch_ops;
 	return 0;
+
+ error:
+	snd_hda_gen_free(codec);
+	return err;
 }
 
+
 static int patch_cmi9880(struct hda_codec *codec)
 {
 	struct cmi_spec *spec;
@@ -606,6 +619,7 @@ static int patch_cmi9880(struct hda_codec *codec)
 		return -ENOMEM;
 
 	codec->spec = spec;
+#ifdef ENABLE_CMI_STATIC_QUIRKS
 	spec->board_config = snd_hda_check_board_config(codec, CMI_MODELS,
 							cmi9880_models,
 							cmi9880_cfg_tbl);
@@ -615,14 +629,8 @@ static int patch_cmi9880(struct hda_codec *codec)
 		spec->board_config = CMI_AUTO; /* try everything */
 	}
 
-	if (spec->board_config == CMI_AUTO) {
-		int err = cmi_parse_auto_config(codec);
-		if (err < 0) {
-			snd_hda_gen_free(codec);
-			return err;
-		}
-		return 0;
-	}
+	if (spec->board_config == CMI_AUTO)
+		return cmi_parse_auto_config(codec);
 
 	/* copy default DAC NIDs */
 	memcpy(spec->dac_nids, cmi9880_dac_nids, sizeof(spec->dac_nids));
@@ -669,6 +677,9 @@ static int patch_cmi9880(struct hda_codec *codec)
 	codec->patch_ops = cmi9880_patch_ops;
 
 	return 0;
+#else
+	return cmi_parse_auto_config(codec);
+#endif
 }
 
 /*
-- 
1.8.5.2
