From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: make a STAC_DELL_EQ option
Date: Mon, 03 Nov 2008 08:12:43 -0500
Message-ID: <490EF8CB.4000702@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 92A25243F8
	for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2008 14:12:54 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, "Tellman, Steven" <Steven.Tellman@idt.com>, tim.gardner@canonical.com, Mario Limonciello <mario_limonciello@dell.com>
List-Id: alsa-devel@alsa-project.org

Add support for explicitly enabling the EQ distortion hack for
systems without software biquad support.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
index c2f900f..2c0f37f 100644
--- a/pci/hda/patch_sigmatel.c
+++ b/pci/hda/patch_sigmatel.c
@@ -70,6 +70,7 @@ enum {
 enum {
 	STAC_92HD73XX_REF,
 	STAC_DELL_M6,
+	STAC_DELL_EQ,
 	STAC_92HD73XX_MODELS
 };

@@ -792,9 +793,7 @@ static struct hda_verb dell_eq_core_init[] = {
 };

 static struct hda_verb dell_m6_core_init[] = {
-	/* set master volume to max value without distortion
-	 * and direct control */
-	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xec},
+	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
 	/* setup audio connections */
 	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
@@ -1622,11 +1621,13 @@ static unsigned int dell_m6_pin_configs[13] = {
 static unsigned int *stac92hd73xx_brd_tbl[STAC_92HD73XX_MODELS] = {
 	[STAC_92HD73XX_REF]	= ref92hd73xx_pin_configs,
 	[STAC_DELL_M6]	= dell_m6_pin_configs,
+	[STAC_DELL_EQ]	= dell_m6_pin_configs,
 };

 static const char *stac92hd73xx_models[STAC_92HD73XX_MODELS] = {
 	[STAC_92HD73XX_REF] = "ref",
 	[STAC_DELL_M6] = "dell-m6",
+	[STAC_DELL_EQ] = "dell-eq",
 };

 static struct snd_pci_quirk stac92hd73xx_cfg_tbl[] = {
@@ -4274,12 +4275,17 @@ again:
 			sizeof(stac92hd73xx_dmux));

 	switch (spec->board_config) {
-	case STAC_DELL_M6:
+	case STAC_DELL_EQ:
 		spec->init = dell_eq_core_init;
+		/* fallthru */
+	case STAC_DELL_M6:
 		spec->num_smuxes = 0;
 		spec->mixer = &stac92hd73xx_6ch_mixer[DELL_M6_MIXER];
 		spec->amp_nids = &stac92hd73xx_amp_nids[DELL_M6_AMP];
 		spec->num_amps = 1;
+
+		if (!spec->init)
+			spec->init = dell_m6_core_init;
 		switch (codec->subsystem_id) {
 		case 0x1028025e: /* Analog Mics */
 		case 0x1028025f:
@@ -4289,8 +4295,6 @@ again:
 			break;
 		case 0x10280271: /* Digital Mics */
 		case 0x10280272:
-			spec->init = dell_m6_core_init;
-			/* fall-through */
 		case 0x10280254:
 		case 0x10280255:
 			stac92xx_set_config_reg(codec, 0x13, 0x90A60160);
