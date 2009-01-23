From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: Add STAC92HD83XXX_PWR_REF quirk
Date: Thu, 22 Jan 2009 20:53:29 -0500
Message-ID: <49792319.5070108@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id F2777103804
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 02:53:37 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Some revisions of the 92hd8xxx codec's not supporting port power
downs in which the using of it causes capture and also randomly playback streams
to not function at all. Thus by disabling it by default and adding a
option to enable it manually will fix all issue on current and future revisions.

Signed-by-off: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt b/Documentation/sound/alsa/HD-Audio-Models.txt
index 75914bc..2119175 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -349,6 +349,7 @@ STAC92HD73*
 STAC92HD83*
 ===========
   ref		Reference board
+  mic-ref	Reference board with power managment for ports
 
 STAC9872
 ========
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index dbe8b12..156f6fa 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -81,6 +81,7 @@ enum {
 
 enum {
 	STAC_92HD83XXX_REF,
+	STAC_92HD83XXX_PWR_REF,
 	STAC_92HD83XXX_MODELS
 };
 
@@ -1734,10 +1735,12 @@ static unsigned int ref92hd83xxx_pin_configs[14] = {
 
 static unsigned int *stac92hd83xxx_brd_tbl[STAC_92HD83XXX_MODELS] = {
 	[STAC_92HD83XXX_REF] = ref92hd83xxx_pin_configs,
+	[STAC_92HD83XXX_PWR_REF] = ref92hd83xxx_pin_configs,
 };
 
 static const char *stac92hd83xxx_models[STAC_92HD83XXX_MODELS] = {
 	[STAC_92HD83XXX_REF] = "ref",
+	[STAC_92HD83XXX_PWR_REF] = "mic-ref",
 };
 
 static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
@@ -4781,13 +4784,6 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 		AC_VERB_SET_CONNECT_SEL, num_dacs);
 
 	spec->init = stac92hd83xxx_core_init;
-	switch (codec->vendor_id) {
-	case 0x111d7605:
-		break;
-	default:
-		spec->num_pwrs--;
-	}
-
 	spec->mixer = stac92hd83xxx_mixer;
 	spec->num_pins = ARRAY_SIZE(stac92hd83xxx_pin_nids);
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd83xxx_dmux_nids);
@@ -4813,6 +4809,15 @@ again:
 		return err;
 	}
 
+	switch (codec->vendor_id) {
+	case 0x111d7604:
+	case 0x111d7605:
+		if (spec->board_config == STAC_92HD83XXX_PWR_REF)
+			break;
+		spec->num_pwrs = 0;
+		break;
+	}
+
 	err = stac92xx_parse_auto_config(codec, 0x1d, 0);
 	if (!err) {
 		if (spec->board_config < 0) {
