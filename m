From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/38] ALSA: hda/realtek - Remove leftover
	static quirks for ALC260
Date: Fri, 24 Feb 2012 17:36:02 +0100
Message-ID: <1330101391-8788-10-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 14CAF104310
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:34 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5AA2390983
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now we can clean up all static quirks for ALC260.
Also many codes in alc_quirks.c can be ripped off since they have been
used only by ALC260 static quirks.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   48 ++++++----------------------------------
 1 files changed, 8 insertions(+), 40 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 0d81eeb..3ea4206 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4308,14 +4308,10 @@ static const struct snd_pci_quirk alc260_fixup_tbl[] = {
 
 /*
  */
-#ifdef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
-#include "alc260_quirks.c"
-#endif
-
 static int patch_alc260(struct hda_codec *codec)
 {
 	struct alc_spec *spec;
-	int err, board_config;
+	int err;
 
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -4325,38 +4321,13 @@ static int patch_alc260(struct hda_codec *codec)
 
 	spec->mixer_nid = 0x07;
 
-	board_config = alc_board_config(codec, ALC260_MODEL_LAST,
-					alc260_models, alc260_cfg_tbl);
-	if (board_config < 0) {
-		snd_printd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			   codec->chip_name);
-		board_config = ALC_MODEL_AUTO;
-	}
-
-	if (board_config == ALC_MODEL_AUTO) {
-		alc_pick_fixup(codec, NULL, alc260_fixup_tbl, alc260_fixups);
-		alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
-	}
-
-	if (board_config == ALC_MODEL_AUTO) {
-		/* automatic parse from the BIOS config */
-		err = alc260_parse_auto_config(codec);
-		if (err < 0)
-			goto error;
-#ifdef CONFIG_SND_HDA_ENABLE_REALTEK_QUIRKS
-		else if (!err) {
-			printk(KERN_INFO
-			       "hda_codec: Cannot set up configuration "
-			       "from BIOS.  Using base mode...\n");
-			board_config = ALC260_BASIC;
-		}
-#endif
-	}
+	alc_pick_fixup(codec, NULL, alc260_fixup_tbl, alc260_fixups);
+	alc_apply_fixup(codec, ALC_FIXUP_ACT_PRE_PROBE);
 
-	if (board_config != ALC_MODEL_AUTO) {
-		setup_preset(codec, &alc260_presets[board_config]);
-		spec->vmaster_nid = 0x08;
-	}
+	/* automatic parse from the BIOS config */
+	err = alc260_parse_auto_config(codec);
+	if (err < 0)
+		goto error;
 
 	if (!spec->no_analog && !spec->adc_nids) {
 		alc_auto_fill_adc_caps(codec);
@@ -4377,10 +4348,7 @@ static int patch_alc260(struct hda_codec *codec)
 	alc_apply_fixup(codec, ALC_FIXUP_ACT_PROBE);
 
 	codec->patch_ops = alc_patch_ops;
-	if (board_config == ALC_MODEL_AUTO)
-		spec->init_hook = alc_auto_init_std;
-	else
-		codec->patch_ops.build_controls = __alc_build_controls;
+	spec->init_hook = alc_auto_init_std;
 	spec->shutup = alc_eapd_shutup;
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	if (!spec->loopback.amplist)
-- 
1.7.9
