From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/12] ALSA: hda - Use standard fixup table for
	STAC9872
Date: Tue, 15 Jan 2013 12:09:40 +0100
Message-ID: <1358248189-14166-4-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D5D66265D78
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8F0D5A522E
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
In-Reply-To: <1358248189-14166-1-git-send-email-tiwai@suse.de>
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

Now for STAC9872.  It has a small fixup table, fortunately.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 49 ++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 4c98b30..533afb6 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -176,7 +176,6 @@ enum {
 };
 
 enum {
-	STAC_9872_AUTO,
 	STAC_9872_VAIO,
 	STAC_9872_MODELS
 };
@@ -6606,22 +6605,32 @@ static const unsigned long stac9872_capvols[] = {
 };
 #define stac9872_capsws		stac9872_capvols
 
-static const unsigned int stac9872_vaio_pin_configs[9] = {
-	0x03211020, 0x411111f0, 0x411111f0, 0x03a15030,
-	0x411111f0, 0x90170110, 0x411111f0, 0x411111f0,
-	0x90a7013e
+static const struct hda_pintbl stac9872_vaio_pin_configs[] = {
+	{ 0x0a, 0x03211020 },
+	{ 0x0b, 0x411111f0 },
+	{ 0x0c, 0x411111f0 },
+	{ 0x0d, 0x03a15030 },
+	{ 0x0e, 0x411111f0 },
+	{ 0x0f, 0x90170110 },
+	{ 0x11, 0x411111f0 },
+	{ 0x13, 0x411111f0 },
+	{ 0x14, 0x90a7013e },
+	{}
 };
 
-static const char * const stac9872_models[STAC_9872_MODELS] = {
-	[STAC_9872_AUTO] = "auto",
-	[STAC_9872_VAIO] = "vaio",
+static const struct hda_model_fixup stac9872_models[] = {
+	{ .id = STAC_9872_VAIO, .name = "vaio" },
+	{}
 };
 
-static const unsigned int *stac9872_brd_tbl[STAC_9872_MODELS] = {
-	[STAC_9872_VAIO] = stac9872_vaio_pin_configs,
+static const struct hda_fixup stac9872_fixups[] = {
+	[STAC_9872_VAIO] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = stac9872_vaio_pin_configs,
+	},
 };
 
-static const struct snd_pci_quirk stac9872_cfg_tbl[] = {
+static const struct snd_pci_quirk stac9872_fixup_tbl[] = {
 	SND_PCI_QUIRK_MASK(0x104d, 0xfff0, 0x81e0,
 			   "Sony VAIO F/S", STAC_9872_VAIO),
 	{} /* terminator */
@@ -6640,25 +6649,20 @@ static int patch_stac9872(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->linear_tone_beep = 1;
 
-	spec->board_config = snd_hda_check_board_config(codec, STAC_9872_MODELS,
-							stac9872_models,
-							stac9872_cfg_tbl);
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-					 stac9872_brd_tbl[spec->board_config]);
+	snd_hda_pick_fixup(codec, stac9872_models, stac9872_fixup_tbl,
+			   stac9872_fixups);
 
 	spec->multiout.dac_nids = spec->dac_nids;
 	spec->num_adcs = ARRAY_SIZE(stac9872_adc_nids);
 	spec->adc_nids = stac9872_adc_nids;
 	spec->num_muxes = ARRAY_SIZE(stac9872_mux_nids);
 	spec->mux_nids = stac9872_mux_nids;
-	spec->init = stac9872_core_init;
 	spec->num_caps = 1;
 	spec->capvols = stac9872_capvols;
 	spec->capsws = stac9872_capsws;
+	snd_hda_add_verbs(codec, stac9872_core_init);
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	err = stac92xx_parse_auto_config(codec);
 	if (err < 0) {
@@ -6667,6 +6671,9 @@ static int patch_stac9872(struct hda_codec *codec)
 	}
 	spec->input_mux = &spec->private_imux;
 	codec->patch_ops = stac92xx_patch_ops;
+
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
