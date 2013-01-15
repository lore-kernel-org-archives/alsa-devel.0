From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/12] ALSA: hda - Use standard fixup table for
	IDT92HD71Bxx
Date: Tue, 15 Jan 2013 12:09:44 +0100
Message-ID: <1358248189-14166-8-git-send-email-tiwai@suse.de>
References: <1358248189-14166-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE01265D72
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:09:52 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 888ECA520D
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

This time, the only intrusive changes are for HP machines.
As the mute LED fixup and the bass speaker switch are required only
for HP machines, we can move these checks into the fixup entries; the
former is applied generically to all HP machines while the latter for
only certain models.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_sigmatel.c | 481 ++++++++++++++++++++++++++---------------
 1 file changed, 312 insertions(+), 169 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 796dfd1..4a2594a 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -108,7 +108,6 @@ enum {
 };
 
 enum {
-	STAC_92HD71BXX_AUTO,
 	STAC_92HD71BXX_REF,
 	STAC_DELL_M4_1,
 	STAC_DELL_M4_2,
@@ -118,6 +117,9 @@ enum {
 	STAC_HP_DV5,
 	STAC_HP_HDX,
 	STAC_HP_DV4_1222NR,
+	STAC_92HD71BXX_HP,
+	STAC_92HD71BXX_NO_DMIC,
+	STAC_92HD71BXX_NO_SMUX,
 	STAC_92HD71BXX_MODELS
 };
 
@@ -589,6 +591,14 @@ static const hda_nid_t stac9205_pin_nids[12] = {
 	0x21, 0x22,
 };
 
+static int stac_add_event(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned char type, int data);
+static int stac_add_hp_bass_switch(struct hda_codec *codec);
+static void stac92xx_auto_set_pinctl(struct hda_codec *codec,
+				     hda_nid_t nid, int pin_type);
+static int hp_blike_system(u32 subsystem_id);
+static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity);
+
 static int stac92xx_dmux_enum_info(struct snd_kcontrol *kcontrol,
 				   struct snd_ctl_elem_info *uinfo)
 {
@@ -2018,60 +2028,305 @@ static const struct snd_pci_quirk stac92hd83xxx_codec_id_cfg_tbl[] = {
 	{} /* terminator */
 };
 
-static const unsigned int ref92hd71bxx_pin_configs[STAC92HD71BXX_NUM_PINS] = {
-	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
-	0x0181302e, 0x01014010, 0x01019020, 0x90a000f0,
-	0x90a000f0, 0x01452050, 0x01452050, 0x00000000,
-	0x00000000
+static const struct hda_pintbl ref92hd71bxx_pin_configs[] = {
+	{ 0x0a, 0x02214030 },
+	{ 0x0b, 0x02a19040 },
+	{ 0x0c, 0x01a19020 },
+	{ 0x0d, 0x01014010 },
+	{ 0x0e, 0x0181302e },
+	{ 0x0f, 0x01014010 },
+	{ 0x14, 0x01019020 },
+	{ 0x18, 0x90a000f0 },
+	{ 0x19, 0x90a000f0 },
+	{ 0x1e, 0x01452050 },
+	{ 0x1f, 0x01452050 },
+	{}
 };
 
-static const unsigned int dell_m4_1_pin_configs[STAC92HD71BXX_NUM_PINS] = {
-	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
-	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x4f0000f0, 0x4f0000f0, 0x00000000,
-	0x00000000
+static const struct hda_pintbl dell_m4_1_pin_configs[] = {
+	{ 0x0a, 0x0421101f },
+	{ 0x0b, 0x04a11221 },
+	{ 0x0c, 0x40f000f0 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x23a1902e },
+	{ 0x0f, 0x23014250 },
+	{ 0x14, 0x40f000f0 },
+	{ 0x18, 0x90a000f0 },
+	{ 0x19, 0x40f000f0 },
+	{ 0x1e, 0x4f0000f0 },
+	{ 0x1f, 0x4f0000f0 },
+	{}
 };
 
-static const unsigned int dell_m4_2_pin_configs[STAC92HD71BXX_NUM_PINS] = {
-	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
-	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
-	0x40f000f0, 0x044413b0, 0x044413b0, 0x00000000,
-	0x00000000
+static const struct hda_pintbl dell_m4_2_pin_configs[] = {
+	{ 0x0a, 0x0421101f },
+	{ 0x0b, 0x04a11221 },
+	{ 0x0c, 0x90a70330 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x23a1902e },
+	{ 0x0f, 0x23014250 },
+	{ 0x14, 0x40f000f0 },
+	{ 0x18, 0x40f000f0 },
+	{ 0x19, 0x40f000f0 },
+	{ 0x1e, 0x044413b0 },
+	{ 0x1f, 0x044413b0 },
+	{}
 };
 
-static const unsigned int dell_m4_3_pin_configs[STAC92HD71BXX_NUM_PINS] = {
-	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
-	0x40f000f0, 0x40f000f0, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x044413b0, 0x044413b0, 0x00000000,
-	0x00000000
+static const struct hda_pintbl dell_m4_3_pin_configs[] = {
+	{ 0x0a, 0x0421101f },
+	{ 0x0b, 0x04a11221 },
+	{ 0x0c, 0x90a70330 },
+	{ 0x0d, 0x90170110 },
+	{ 0x0e, 0x40f000f0 },
+	{ 0x0f, 0x40f000f0 },
+	{ 0x14, 0x40f000f0 },
+	{ 0x18, 0x90a000f0 },
+	{ 0x19, 0x40f000f0 },
+	{ 0x1e, 0x044413b0 },
+	{ 0x1f, 0x044413b0 },
+	{}
 };
 
-static const unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
-	[STAC_92HD71BXX_REF] = ref92hd71bxx_pin_configs,
-	[STAC_DELL_M4_1]	= dell_m4_1_pin_configs,
-	[STAC_DELL_M4_2]	= dell_m4_2_pin_configs,
-	[STAC_DELL_M4_3]	= dell_m4_3_pin_configs,
-	[STAC_HP_M4]		= NULL,
-	[STAC_HP_DV4]		= NULL,
-	[STAC_HP_DV5]		= NULL,
-	[STAC_HP_HDX]           = NULL,
-	[STAC_HP_DV4_1222NR]	= NULL,
+static void stac92hd71bxx_fixup_ref(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	snd_hda_apply_pincfgs(codec, ref92hd71bxx_pin_configs);
+	spec->gpio_mask = spec->gpio_dir = spec->gpio_data = 0;
+}
+
+static void stac92hd71bxx_fixup_no_dmic(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->num_dmics = 0;
+	spec->num_smuxes = 0;
+	spec->num_dmuxes = 0;
+}
+
+static void stac92hd71bxx_fixup_no_smux(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->num_dmics = 1;
+	spec->num_smuxes = 0;
+	spec->num_dmuxes = 1;
+}
+
+static void stac92hd71bxx_fixup_hp_m4(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	/* Enable VREF power saving on GPIO1 detect */
+	stac_add_event(codec, codec->afg, STAC_VREF_EVENT, 0x02);
+	snd_hda_codec_write_cache(codec, codec->afg, 0,
+				  AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
+	snd_hda_jack_detect_enable(codec, codec->afg, 0);
+	spec->gpio_mask |= 0x02;
+
+	/* enable internal microphone */
+	snd_hda_codec_set_pincfg(codec, 0x0e, 0x01813040);
+	stac92xx_auto_set_pinctl(codec, 0x0e,
+				 AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
+
+	stac92hd71bxx_fixup_no_dmic(codec, fix, action);
+}
+
+static void stac92hd71bxx_fixup_hp_dv4_1222nr(struct hda_codec *codec,
+					const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->num_dmics = 1;
+	/* I don't know if it needs 1 or 2 smuxes - will wait for
+	 * bug reports to fix if needed
+	 */
+	spec->num_smuxes = 1;
+	spec->num_dmuxes = 1;
+}
+
+static void stac92hd71bxx_fixup_hp_dv4(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->gpio_led = 0x01;
+}
+
+static void stac92hd71bxx_fixup_hp_dv5(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+	unsigned int cap;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		snd_hda_codec_set_pincfg(codec, 0x0d, 0x90170010);
+		stac92xx_auto_set_pinctl(codec, 0x0d, AC_PINCTL_OUT_EN);
+		/* HP dv6 gives the headphone pin as a line-out.  Thus we
+		 * need to set hp_detect flag here to force to enable HP
+		 * detection.
+		 */
+		spec->hp_detect = 1;
+		break;
+
+	case HDA_FIXUP_ACT_PROBE:
+		/* enable bass on HP dv7 */
+		cap = snd_hda_param_read(codec, 0x1, AC_PAR_GPIO_CAP);
+		cap &= AC_GPIO_IO_COUNT;
+		if (cap >= 6)
+			stac_add_hp_bass_switch(codec);
+		break;
+	}
+}
+
+static void stac92hd71bxx_fixup_hp_hdx(struct hda_codec *codec,
+				       const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+	spec->gpio_led = 0x08;
+	spec->num_dmics = 1;
+	spec->num_smuxes = 1;
+	spec->num_dmuxes = 1;
+}
+
+
+static void stac92hd71bxx_fixup_hp(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	if (hp_blike_system(codec->subsystem_id)) {
+		unsigned int pin_cfg = snd_hda_codec_get_pincfg(codec, 0x0f);
+		if (get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
+			get_defcfg_device(pin_cfg) == AC_JACK_SPEAKER  ||
+			get_defcfg_device(pin_cfg) == AC_JACK_HP_OUT) {
+			/* It was changed in the BIOS to just satisfy MS DTM.
+			 * Lets turn it back into slaved HP
+			 */
+			pin_cfg = (pin_cfg & (~AC_DEFCFG_DEVICE))
+					| (AC_JACK_HP_OUT <<
+						AC_DEFCFG_DEVICE_SHIFT);
+			pin_cfg = (pin_cfg & (~(AC_DEFCFG_DEF_ASSOC
+							| AC_DEFCFG_SEQUENCE)))
+								| 0x1f;
+			snd_hda_codec_set_pincfg(codec, 0x0f, pin_cfg);
+		}
+	}
+
+	if (find_mute_led_cfg(codec, 1))
+		snd_printd("mute LED gpio %d polarity %d\n",
+				spec->gpio_led,
+				spec->gpio_led_polarity);
+
+}
+
+static const struct hda_fixup stac92hd71bxx_fixups[] = {
+	[STAC_92HD71BXX_REF] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_ref,
+	},
+	[STAC_DELL_M4_1] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_m4_1_pin_configs,
+		.chained = true,
+		.chain_id = STAC_92HD71BXX_NO_SMUX,
+	},
+	[STAC_DELL_M4_2] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_m4_2_pin_configs,
+		.chained = true,
+		.chain_id = STAC_92HD71BXX_NO_DMIC,
+	},
+	[STAC_DELL_M4_3] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = dell_m4_3_pin_configs,
+		.chained = true,
+		.chain_id = STAC_92HD71BXX_NO_SMUX,
+	},
+	[STAC_HP_M4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_hp_m4,
+		.chained = true,
+		.chain_id = STAC_92HD71BXX_HP,
+	},
+	[STAC_HP_DV4] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_hp_dv4,
+		.chained = true,
+		.chain_id = STAC_HP_DV5,
+	},
+	[STAC_HP_DV5] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_hp_dv5,
+		.chained = true,
+		.chain_id = STAC_92HD71BXX_HP,
+	},
+	[STAC_HP_HDX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_hp_hdx,
+		.chained = true,
+		.chain_id = STAC_92HD71BXX_HP,
+	},
+	[STAC_HP_DV4_1222NR] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_hp_dv4_1222nr,
+		.chained = true,
+		.chain_id = STAC_HP_DV4,
+	},
+	[STAC_92HD71BXX_NO_DMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_no_dmic,
+	},
+	[STAC_92HD71BXX_NO_SMUX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_no_smux,
+	},
+	[STAC_92HD71BXX_HP] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd71bxx_fixup_hp,
+	},
 };
 
-static const char * const stac92hd71bxx_models[STAC_92HD71BXX_MODELS] = {
-	[STAC_92HD71BXX_AUTO] = "auto",
-	[STAC_92HD71BXX_REF] = "ref",
-	[STAC_DELL_M4_1] = "dell-m4-1",
-	[STAC_DELL_M4_2] = "dell-m4-2",
-	[STAC_DELL_M4_3] = "dell-m4-3",
-	[STAC_HP_M4] = "hp-m4",
-	[STAC_HP_DV4] = "hp-dv4",
-	[STAC_HP_DV5] = "hp-dv5",
-	[STAC_HP_HDX] = "hp-hdx",
-	[STAC_HP_DV4_1222NR] = "hp-dv4-1222nr",
+static const struct hda_model_fixup stac92hd71bxx_models[] = {
+	{ .id = STAC_92HD71BXX_REF, .name = "ref" },
+	{ .id = STAC_DELL_M4_1, .name = "dell-m4-1" },
+	{ .id = STAC_DELL_M4_2, .name = "dell-m4-2" },
+	{ .id = STAC_DELL_M4_3, .name = "dell-m4-3" },
+	{ .id = STAC_HP_M4, .name = "hp-m4" },
+	{ .id = STAC_HP_DV4, .name = "hp-dv4" },
+	{ .id = STAC_HP_DV5, .name = "hp-dv5" },
+	{ .id = STAC_HP_HDX, .name = "hp-hdx" },
+	{ .id = STAC_HP_DV4_1222NR, .name = "hp-dv4-1222nr" },
+	{}
 };
 
-static const struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
+static const struct snd_pci_quirk stac92hd71bxx_fixup_tbl[] = {
 	/* SigmaTel reference board */
 	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
 		      "DFI LanParty", STAC_92HD71BXX_REF),
@@ -2101,6 +2356,7 @@ static const struct snd_pci_quirk stac92hd71bxx_cfg_tbl[] = {
 		      "HP DV6", STAC_HP_DV5),
 	SND_PCI_QUIRK_MASK(PCI_VENDOR_ID_HP, 0xfff0, 0x7010,
 		      "HP", STAC_HP_DV5),
+	SND_PCI_QUIRK_VENDOR(PCI_VENDOR_ID_HP, "HP", STAC_92HD71BXX_HP),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0233,
 				"unknown Dell", STAC_DELL_M4_1),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0234,
@@ -2931,9 +3187,6 @@ static void stac9205_fixup_ref(struct hda_codec *codec,
 	}
 }
 
-static int stac_add_event(struct hda_codec *codec, hda_nid_t nid,
-			  unsigned char type, int data);
-
 static void stac9205_fixup_dell_m43(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
@@ -5615,8 +5868,6 @@ static void stac_issue_unsol_event(struct hda_codec *codec, hda_nid_t nid)
 	handle_unsol_event(codec, event);
 }
 
-static int hp_blike_system(u32 subsystem_id);
-
 static void set_hp_led_gpio(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec = codec->spec;
@@ -5663,6 +5914,7 @@ static int find_mute_led_cfg(struct hda_codec *codec, int default_polarity)
 			     &spec->gpio_led_polarity);
 		return 1;
 	}
+
 	if ((codec->subsystem_id >> 16) == PCI_VENDOR_ID_HP) {
 		while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
 								NULL, dev))) {
@@ -6466,7 +6718,6 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
 	const struct hda_verb *unmute_init = stac92hd71bxx_unmute_core_init;
-	unsigned int pin_cfg;
 	int err;
 
 	err = alloc_stac_spec(codec, STAC92HD71BXX_NUM_PINS,
@@ -6490,24 +6741,14 @@ static int patch_stac92hd71bxx(struct hda_codec *codec)
 		spec->pin_nids = stac92hd71bxx_pin_nids_6port;
 	}
 	spec->num_pwrs = ARRAY_SIZE(stac92hd71bxx_pwr_nids);
-	spec->board_config = snd_hda_check_board_config(codec,
-							STAC_92HD71BXX_MODELS,
-							stac92hd71bxx_models,
-							stac92hd71bxx_cfg_tbl);
-again:
-	if (spec->board_config < 0)
-		snd_printdd(KERN_INFO "hda_codec: %s: BIOS auto-probing.\n",
-			    codec->chip_name);
-	else
-		stac92xx_set_config_regs(codec,
-				stac92hd71bxx_brd_tbl[spec->board_config]);
 
-	if (spec->board_config != STAC_92HD71BXX_REF) {
-		/* GPIO0 = EAPD */
-		spec->gpio_mask = 0x01;
-		spec->gpio_dir = 0x01;
-		spec->gpio_data = 0x01;
-	}
+	snd_hda_pick_fixup(codec, stac92hd71bxx_models, stac92hd71bxx_fixup_tbl,
+			   stac92hd71bxx_fixups);
+
+	/* GPIO0 = EAPD */
+	spec->gpio_mask = 0x01;
+	spec->gpio_dir = 0x01;
+	spec->gpio_data = 0x01;
 
 	spec->dmic_nids = stac92hd71bxx_dmic_nids;
 	spec->dmux_nids = stac92hd71bxx_dmux_nids;
@@ -6529,19 +6770,6 @@ again:
 					STAC92HD71BXX_NUM_DMICS);
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
-		switch (spec->board_config) {
-		case STAC_HP_M4:
-			/* Enable VREF power saving on GPIO1 detect */
-			err = stac_add_event(codec, codec->afg,
-					     STAC_VREF_EVENT, 0x02);
-			if (err < 0)
-				return err;
-			snd_hda_codec_write_cache(codec, codec->afg, 0,
-				AC_VERB_SET_GPIO_UNSOLICITED_RSP_MASK, 0x02);
-			snd_hda_jack_detect_enable(codec, codec->afg, 0);
-			spec->gpio_mask |= 0x02;
-			break;
-		}
 		if ((codec->revision_id & 0xf) == 0 ||
 		    (codec->revision_id & 0xf) == 1)
 			spec->stream_delay = 40; /* 40 milliseconds */
@@ -6569,7 +6797,7 @@ again:
 	}
 
 	if (get_wcaps_type(get_wcaps(codec, 0x28)) == AC_WID_VOL_KNB)
-		spec->init = stac92hd71bxx_core_init;
+		snd_hda_add_verbs(codec, stac92hd71bxx_core_init);
 
 	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP)
 		snd_hda_sequence_write_cache(codec, unmute_init);
@@ -6590,76 +6818,7 @@ again:
 	spec->num_dmuxes = ARRAY_SIZE(stac92hd71bxx_dmux_nids);
 	spec->num_smuxes = stac92hd71bxx_connected_smuxes(codec, 0x1e);
 
-	snd_printdd("Found board config: %d\n", spec->board_config);
-
-	switch (spec->board_config) {
-	case STAC_HP_M4:
-		/* enable internal microphone */
-		snd_hda_codec_set_pincfg(codec, 0x0e, 0x01813040);
-		stac92xx_auto_set_pinctl(codec, 0x0e,
-			AC_PINCTL_IN_EN | AC_PINCTL_VREF_80);
-		/* fallthru */
-	case STAC_DELL_M4_2:
-		spec->num_dmics = 0;
-		spec->num_smuxes = 0;
-		spec->num_dmuxes = 0;
-		break;
-	case STAC_DELL_M4_1:
-	case STAC_DELL_M4_3:
-		spec->num_dmics = 1;
-		spec->num_smuxes = 0;
-		spec->num_dmuxes = 1;
-		break;
-	case STAC_HP_DV4_1222NR:
-		spec->num_dmics = 1;
-		/* I don't know if it needs 1 or 2 smuxes - will wait for
-		 * bug reports to fix if needed
-		 */
-		spec->num_smuxes = 1;
-		spec->num_dmuxes = 1;
-		/* fallthrough */
-	case STAC_HP_DV4:
-		spec->gpio_led = 0x01;
-		/* fallthrough */
-	case STAC_HP_DV5:
-		snd_hda_codec_set_pincfg(codec, 0x0d, 0x90170010);
-		stac92xx_auto_set_pinctl(codec, 0x0d, AC_PINCTL_OUT_EN);
-		/* HP dv6 gives the headphone pin as a line-out.  Thus we
-		 * need to set hp_detect flag here to force to enable HP
-		 * detection.
-		 */
-		spec->hp_detect = 1;
-		break;
-	case STAC_HP_HDX:
-		spec->num_dmics = 1;
-		spec->num_dmuxes = 1;
-		spec->num_smuxes = 1;
-		spec->gpio_led = 0x08;
-		break;
-	}
-
-	if (hp_blike_system(codec->subsystem_id)) {
-		pin_cfg = snd_hda_codec_get_pincfg(codec, 0x0f);
-		if (get_defcfg_device(pin_cfg) == AC_JACK_LINE_OUT ||
-			get_defcfg_device(pin_cfg) == AC_JACK_SPEAKER  ||
-			get_defcfg_device(pin_cfg) == AC_JACK_HP_OUT) {
-			/* It was changed in the BIOS to just satisfy MS DTM.
-			 * Lets turn it back into slaved HP
-			 */
-			pin_cfg = (pin_cfg & (~AC_DEFCFG_DEVICE))
-					| (AC_JACK_HP_OUT <<
-						AC_DEFCFG_DEVICE_SHIFT);
-			pin_cfg = (pin_cfg & (~(AC_DEFCFG_DEF_ASSOC
-							| AC_DEFCFG_SEQUENCE)))
-								| 0x1f;
-			snd_hda_codec_set_pincfg(codec, 0x0f, pin_cfg);
-		}
-	}
-
-	if (find_mute_led_cfg(codec, 1))
-		snd_printd("mute LED gpio %d polarity %d\n",
-				spec->gpio_led,
-				spec->gpio_led_polarity);
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
 
 	if (spec->gpio_led) {
 		if (!spec->vref_mute_led_nid) {
@@ -6675,33 +6834,17 @@ again:
 	spec->multiout.dac_nids = spec->dac_nids;
 
 	err = stac92xx_parse_auto_config(codec);
-	if (!err) {
-		if (spec->board_config < 0) {
-			printk(KERN_WARNING "hda_codec: No auto-config is "
-			       "available, default to model=ref\n");
-			spec->board_config = STAC_92HD71BXX_REF;
-			goto again;
-		}
+	if (!err)
 		err = -EINVAL;
-	}
-
 	if (err < 0) {
 		stac92xx_free(codec);
 		return err;
 	}
 
-	/* enable bass on HP dv7 */
-	if (spec->board_config == STAC_HP_DV4 ||
-	    spec->board_config == STAC_HP_DV5) {
-		unsigned int cap;
-		cap = snd_hda_param_read(codec, 0x1, AC_PAR_GPIO_CAP);
-		cap &= AC_GPIO_IO_COUNT;
-		if (cap >= 6)
-			stac_add_hp_bass_switch(codec);
-	}
-
 	codec->proc_widget_hook = stac92hd7x_proc_hook;
 
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
+
 	return 0;
 }
 
-- 
1.8.1
