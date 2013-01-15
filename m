From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/12] ALSA: hda - Use standard fixup table for
	STAC9205
Date: Tue, 15 Jan 2013 12:09:41 +0100
Message-ID: <1358248189-14166-5-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A87D5265D6F
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8652AA5202
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 237 ++++++++++++++++++++++++++---------------
 1 file changed, 154 insertions(+), 83 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 533afb6..f66c7d1 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -70,7 +70,6 @@ enum {
 };
 
 enum {
-	STAC_9205_AUTO,
 	STAC_9205_REF,
 	STAC_9205_DELL_M42,
 	STAC_9205_DELL_M43,
@@ -2472,10 +2471,20 @@ static const struct snd_pci_quirk stac927x_cfg_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref9205_pin_configs[12] = {
-	0x40000100, 0x40000100, 0x01016011, 0x01014010,
-	0x01813122, 0x01a19021, 0x01019020, 0x40000100,
-	0x90a000f0, 0x90a000f0, 0x01441030, 0x01c41030
+static const struct hda_pintbl ref9205_pin_configs[] = {
+	{ 0x0a, 0x40000100 },
+	{ 0x0b, 0x40000100 },
+	{ 0x0c, 0x01016011 },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x01813122 },
+	{ 0x0f, 0x01a19021 },
+	{ 0x14, 0x01019020 },
+	{ 0x16, 0x40000100 },
+	{ 0x17, 0x90a000f0 },
+	{ 0x18, 0x90a000f0 },
+	{ 0x21, 0x01441030 },
+	{ 0x22, 0x01c41030 },
+	{}
 };
 
 /*
@@ -2489,10 +2498,20 @@ static const unsigned int ref9205_pin_configs[12] = {
     10280228 (Dell Vostro 1500)
     10280229 (Dell Vostro 1700)
 */
-static const unsigned int dell_9205_m42_pin_configs[12] = {
-	0x0321101F, 0x03A11020, 0x400003FA, 0x90170310,
-	0x400003FB, 0x400003FC, 0x400003FD, 0x40F000F9,
-	0x90A60330, 0x400003FF, 0x0144131F, 0x40C003FE,
+static const struct hda_pintbl dell_9205_m42_pin_configs[] = {
+	{ 0x0a, 0x0321101F },
+	{ 0x0b, 0x03A11020 },
+	{ 0x0c, 0x400003FA },
+	{ 0x0d, 0x90170310 },
+	{ 0x0e, 0x400003FB },
+	{ 0x0f, 0x400003FC },
+	{ 0x14, 0x400003FD },
+	{ 0x16, 0x40F000F9 },
+	{ 0x17, 0x90A60330 },
+	{ 0x18, 0x400003FF },
+	{ 0x21, 0x0144131F },
+	{ 0x22, 0x40C003FE },
+	{}
 };
 
 /*
@@ -2505,36 +2524,127 @@ static const unsigned int dell_9205_m42_pin_configs[12] = {
     10280200
     10280201
 */
-static const unsigned int dell_9205_m43_pin_configs[12] = {
-	0x0321101f, 0x03a11020, 0x90a70330, 0x90170310,
-	0x400000fe, 0x400000ff, 0x400000fd, 0x40f000f9,
-	0x400000fa, 0x400000fc, 0x0144131f, 0x40c003f8,
+static const struct hda_pintbl dell_9205_m43_pin_configs[] = {
+	{ 0x0a, 0x0321101f },
+	{ 0x0b, 0x03a11020 },
+	{ 0x0c, 0x90a70330 },
+	{ 0x0d, 0x90170310 },
+	{ 0x0e, 0x400000fe },
+	{ 0x0f, 0x400000ff },
+	{ 0x14, 0x400000fd },
+	{ 0x16, 0x40f000f9 },
+	{ 0x17, 0x400000fa },
+	{ 0x18, 0x400000fc },
+	{ 0x21, 0x0144131f },
+	{ 0x22, 0x40c003f8 },
+	/* Enable SPDIF in/out */
+	{ 0x1f, 0x01441030 },
+	{ 0x20, 0x1c410030 },
+	{}
 };
 
-static const unsigned int dell_9205_m44_pin_configs[12] = {
-	0x0421101f, 0x04a11020, 0x400003fa, 0x90170310,
-	0x400003fb, 0x400003fc, 0x400003fd, 0x400003f9,
-	0x90a60330, 0x400003ff, 0x01441340, 0x40c003fe,
+static const struct hda_pintbl dell_9205_m44_pin_configs[] = {
+	{ 0x0a, 0x0421101f },
+	{ 0x0b, 0x04a11020 },
+	{ 0x0c, 0x400003fa },
+	{ 0x0d, 0x90170310 },
+	{ 0x0e, 0x400003fb },
+	{ 0x0f, 0x400003fc },
+	{ 0x14, 0x400003fd },
+	{ 0x16, 0x400003f9 },
+	{ 0x17, 0x90a60330 },
+	{ 0x18, 0x400003ff },
+	{ 0x21, 0x01441340 },
+	{ 0x22, 0x40c003fe },
+	{}
 };
 
-static const unsigned int *stac9205_brd_tbl[STAC_9205_MODELS] = {
-	[STAC_9205_REF] = ref9205_pin_configs,
-	[STAC_9205_DELL_M42] = dell_9205_m42_pin_configs,
-	[STAC_9205_DELL_M43] = dell_9205_m43_pin_configs,
-	[STAC_9205_DELL_M44] = dell_9205_m44_pin_configs,
-	[STAC_9205_EAPD] = NULL,
+static void stac9205_fixup_ref(struct hda_codec *codec,
+			       const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		snd_hda_apply_pincfgs(codec, ref9205_pin_configs);
+		/* SPDIF-In enabled */
+		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0;
+	}
+}
+
+static int stac_add_event(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned char type, int data);
+
+static void stac9205_fixup_dell_m43(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	int err;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		snd_hda_apply_pincfgs(codec, dell_9205_m43_pin_configs);
+
+		/* Enable unsol response for GPIO4/Dock HP connection */
+		err = stac_add_event(codec, codec->afg, STAC_VREF_EVENT, 0x01);
+		if (err < 0)
+			return;
+		snd_hda_codec_write_cache(codec, codec->afg, 0,
+			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
+		snd_hda_jack_detect_enable(codec, codec->afg, 0);
+
+		spec->gpio_dir = 0x0b;
+		spec->eapd_mask = 0x01;
+		spec->gpio_mask = 0x1b;
+		spec->gpio_mute = 0x10;
+		/* GPIO0 High = EAPD, GPIO1 Low = Headphone Mute,
+		 * GPIO3 Low = DRM
+		 */
+		spec->gpio_data = 0x01;
+	}
+}
+
+static void stac9205_fixup_eapd(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+		spec->eapd_switch = 0;
+}
+
+static const struct hda_fixup stac9205_fixups[] = {
+	[STAC_9205_REF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac9205_fixup_ref,
+	},
+	[STAC_9205_DELL_M42] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_9205_m42_pin_configs,
+	},
+	[STAC_9205_DELL_M43] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac9205_fixup_dell_m43,
+	},
+	[STAC_9205_DELL_M44] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_9205_m44_pin_configs,
+	},
+	[STAC_9205_EAPD] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac9205_fixup_eapd,
+	},
+	{}
 };
 
-static const char * const stac9205_models[STAC_9205_MODELS] = {
-	[STAC_9205_AUTO] = "auto",
-	[STAC_9205_REF] = "ref",
-	[STAC_9205_DELL_M42] = "dell-m42",
-	[STAC_9205_DELL_M43] = "dell-m43",
-	[STAC_9205_DELL_M44] = "dell-m44",
-	[STAC_9205_EAPD] = "eapd",
+static const struct hda_model_fixup stac9205_models[] = {
+	{ .id = STAC_9205_REF, .name = "ref" },
+	{ .id = STAC_9205_DELL_M42, .name = "dell-m42" },
+	{ .id = STAC_9205_DELL_M43, .name = "dell-m43" },
+	{ .id = STAC_9205_DELL_M44, .name = "dell-m44" },
+	{ .id = STAC_9205_EAPD, .name = "eapd" },
+	{}
 };
 
-static const struct snd_pci_quirk stac9205_cfg_tbl[] = {
+static const struct snd_pci_quirk stac9205_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_9205_REF),
@@ -6484,16 +6594,9 @@ static int patch_stac9205(struct hda_codec *codec)
 
 	spec = codec->spec;
 	spec->linear_tone_beep = 1;
-	spec->board_config = snd_hda_check_board_config(codec, STAC_9205_MODELS,
-							stac9205_models,
-							stac9205_cfg_tbl);
- again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-					 stac9205_brd_tbl[spec->board_config]);
+
+	snd_hda_pick_fixup(codec, stac9205_models, stac9205_fixup_tbl,
+			   stac9205_fixups);
 
 	spec->digbeep_nid = 0x23;
 	spec->adc_nids = stac9205_adc_nids;
@@ -6508,7 +6611,7 @@ static int patch_stac9205(struct hda_codec *codec)
 	spec->num_dmuxes = ARRAY_SIZE(stac9205_dmux_nids);
 	spec->num_pwrs = 0;
 
-	spec->init = stac9205_core_init;
+	snd_hda_add_verbs(codec, stac9205_core_init);
 	spec->aloopback_ctl = stac9205_loopback;
 
 	spec->num_caps = STAC9205_NUM_CAPS;
@@ -6517,54 +6620,20 @@ static int patch_stac9205(struct hda_codec *codec)
 
 	spec->aloopback_mask = 0x40;
 	spec->aloopback_shift = 0;
-	/* Turn on/off EAPD per HP plugging */
-	if (spec->board_config != STAC_9205_EAPD)
-		spec->eapd_switch = 1;
 	spec->multiout.dac_nids = spec->dac_nids;
 	
-	switch (spec->board_config){
-	case STAC_9205_DELL_M43:
-		/* Enable SPDIF in/out */
-		snd_hda_codec_set_pincfg(codec, 0x1f, 0x01441030);
-		snd_hda_codec_set_pincfg(codec, 0x20, 0x1c410030);
+	/* GPIO0 High = EAPD */
+	spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
+	spec->gpio_data = 0x01;
 
-		/* Enable unsol response for GPIO4/Dock HP connection */
-		err = stac_add_event(codec, codec->afg, STAC_VREF_EVENT, 0x01);
-		if (err < 0)
-			return err;
-		snd_hda_codec_write_cache(codec, codec->afg, 0,
-			AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x10);
-		snd_hda_jack_detect_enable(codec, codec->afg, 0);
+	/* Turn on/off EAPD per HP plugging */
+	spec->eapd_switch = 1;
 
-		spec->gpio_dir = 0x0b;
-		spec->eapd_mask = 0x01;
-		spec->gpio_mask = 0x1b;
-		spec->gpio_mute = 0x10;
-		/* GPIO0 High = EAPD, GPIO1 Low = Headphone Mute,
-		 * GPIO3 Low = DRM
-		 */
-		spec->gpio_data = 0x01;
-		break;
-	case STAC_9205_REF:
-		/* SPDIF-In enabled */
-		break;
-	default:
-		/* GPIO0 High = EAPD */
-		spec->eapd_mask = spec->gpio_mask = spec->gpio_dir = 0x1;
-		spec->gpio_data = 0x01;
-		break;
-	}
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	err = stac92xx_parse_auto_config(codec);
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_9205_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
@@ -6574,6 +6643,8 @@ static int patch_stac9205(struct hda_codec *codec)
 
 	codec->proc_widget_hook = stac9205_proc_hook;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
