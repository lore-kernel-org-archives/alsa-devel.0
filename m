From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Implement headset jack
	functionality for some Dell hw
Date: Mon, 15 Apr 2013 15:44:14 +0200
Message-ID: <1366033454-5795-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id E88CD265179
 for <alsa-devel@alsa-project.org>; Mon, 15 Apr 2013 15:44:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: 1169143@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On some machines, there is a headset jack that can support both
headphone, headsets (of both CTIA and OMTP type) and mic-in.

On other machines, the headset jack supports headphone, headsets
(both CTIA and OMTP), but not mic-in.

This patch implements that functionality as different capture sources.

Buglink: https://bugs.launchpad.net/bugs/1169143
Tested-by: David Chen <david.chen@canonical.com>
Co-authored-by: Kailang <kailang@realtek.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |  386 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 386 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6cf27f5..f3307eb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -52,6 +52,20 @@ enum {
 	ALC_INIT_GPIO3,
 };
 
+enum {
+	ALC_HEADSET_MODE_UNKNOWN,
+	ALC_HEADSET_MODE_UNPLUGGED,
+	ALC_HEADSET_MODE_HEADSET,
+	ALC_HEADSET_MODE_MIC,
+	ALC_HEADSET_MODE_HEADPHONE,
+};
+
+enum {
+	ALC_HEADSET_TYPE_UNKNOWN,
+	ALC_HEADSET_TYPE_CTIA,
+	ALC_HEADSET_TYPE_OMTP,
+};
+
 struct alc_customize_define {
 	unsigned int  sku_cfg;
 	unsigned char port_connectivity;
@@ -87,6 +101,11 @@ struct alc_spec {
 
 	unsigned int gpio_led; /* used for alc269_fixup_hp_gpio_led() */
 
+	hda_nid_t headset_mic_pin;
+	hda_nid_t headphone_mic_pin;
+	int current_headset_mode;
+	int current_headset_type;
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -2798,6 +2817,302 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 	}
 }
 
+static void alc_headset_mode_unplugged(struct hda_codec *codec)
+{
+	int val;
+
+	switch (codec->vendor_id) {
+	case 0x10ec0283:
+		alc_write_coef_idx(codec, 0x1b, 0x0c0b);
+		alc_write_coef_idx(codec, 0x45, 0xc429);
+		val = alc_read_coef_idx(codec, 0x35);
+		alc_write_coef_idx(codec, 0x35, val & 0xbfff);
+		alc_write_coef_idx(codec, 0x06, 0x2104);
+		alc_write_coef_idx(codec, 0x1a, 0x0001);
+		alc_write_coef_idx(codec, 0x26, 0x0004);
+		alc_write_coef_idx(codec, 0x32, 0x42a3);
+		break;
+	case 0x10ec0292:
+		alc_write_coef_idx(codec, 0x76, 0x000e);
+		alc_write_coef_idx(codec, 0x6c, 0x2400);
+		alc_write_coef_idx(codec, 0x18, 0x7308);
+		alc_write_coef_idx(codec, 0x6b, 0xc429);
+		break;
+	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x15, 0x0d40);
+		alc_write_coef_idx(codec, 0xb7, 0x802b);
+		break;
+	}
+	snd_printdd("Headset jack set to unplugged mode.\n");
+}
+
+
+static void alc_headset_mode_mic_in(struct hda_codec *codec, hda_nid_t hp_pin,
+				    hda_nid_t mic_pin)
+{
+	int val;
+
+	switch (codec->vendor_id) {
+	case 0x10ec0283:
+		alc_write_coef_idx(codec, 0x45, 0xc429);
+		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);
+		val = alc_read_coef_idx(codec, 0x35);
+		alc_write_coef_idx(codec, 0x35, val | 1<<14);
+		alc_write_coef_idx(codec, 0x06, 0x2100);
+		alc_write_coef_idx(codec, 0x1a, 0x0021);
+		alc_write_coef_idx(codec, 0x26, 0x008c);
+		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);
+		break;
+	case 0x10ec0292:
+		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);
+		alc_write_coef_idx(codec, 0x19, 0xa208);
+		alc_write_coef_idx(codec, 0x2e, 0xacf0);
+		break;
+	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x11, 0x0001);
+		snd_hda_set_pin_ctl_cache(codec, hp_pin, 0);
+		alc_write_coef_idx(codec, 0xb7, 0x802b);
+		alc_write_coef_idx(codec, 0xb5, 0x1040);
+		val = alc_read_coef_idx(codec, 0xc3);
+		alc_write_coef_idx(codec, 0xc3, val | 1<<12);
+		snd_hda_set_pin_ctl_cache(codec, mic_pin, PIN_VREF50);
+		break;
+	}
+	snd_printdd("Headset jack set to mic-in mode.\n");
+}
+
+static void alc_headset_mode_default(struct hda_codec *codec)
+{
+	switch (codec->vendor_id) {
+	case 0x10ec0283:
+		alc_write_coef_idx(codec, 0x06, 0x2100);
+		alc_write_coef_idx(codec, 0x32, 0x4ea3);
+		break;
+	case 0x10ec0292:
+		alc_write_coef_idx(codec, 0x76, 0x000e);
+		alc_write_coef_idx(codec, 0x6c, 0x2400);
+		alc_write_coef_idx(codec, 0x6b, 0xc429);
+		alc_write_coef_idx(codec, 0x18, 0x7308);
+		break;
+	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x11, 0x0041);
+		alc_write_coef_idx(codec, 0x15, 0x0d40);
+		alc_write_coef_idx(codec, 0xb7, 0x802b);
+		break;
+	}
+	snd_printdd("Headset jack set to headphone (default) mode.\n");
+}
+
+/* Iphone type */
+static void alc_headset_mode_ctia(struct hda_codec *codec)
+{
+	switch (codec->vendor_id) {
+	case 0x10ec0283:
+		alc_write_coef_idx(codec, 0x45, 0xd429);
+		alc_write_coef_idx(codec, 0x1b, 0x0c2b);
+		alc_write_coef_idx(codec, 0x32, 0x4ea3);
+		break;
+	case 0x10ec0292:
+		alc_write_coef_idx(codec, 0x6b, 0xd429);
+		alc_write_coef_idx(codec, 0x76, 0x0008);
+		alc_write_coef_idx(codec, 0x18, 0x7388);
+		break;
+	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x15, 0x0d60);
+		alc_write_coef_idx(codec, 0xc3, 0x0000);
+		break;
+	}
+	snd_printdd("Headset jack set to iPhone-style headset mode.\n");
+}
+
+/* Nokia type */
+static void alc_headset_mode_omtp(struct hda_codec *codec)
+{
+	switch (codec->vendor_id) {
+	case 0x10ec0283:
+		alc_write_coef_idx(codec, 0x45, 0xe429);
+		alc_write_coef_idx(codec, 0x1b, 0x0c2b);
+		alc_write_coef_idx(codec, 0x32, 0x4ea3);
+		break;
+	case 0x10ec0292:
+		alc_write_coef_idx(codec, 0x6b, 0xe429);
+		alc_write_coef_idx(codec, 0x76, 0x0008);
+		alc_write_coef_idx(codec, 0x18, 0x7388);
+		break;
+	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x15, 0x0d50);
+		alc_write_coef_idx(codec, 0xc3, 0x0000);
+		break;
+	}
+	snd_printdd("Headset jack set to Nokia-style headset mode.\n");
+}
+
+static void alc_determine_headset_type(struct hda_codec *codec)
+{
+	int val;
+	bool is_ctia = false;
+	struct alc_spec *spec = codec->spec;
+
+	switch (codec->vendor_id) {
+	case 0x10ec0283:
+		alc_write_coef_idx(codec, 0x45, 0xd029);
+		msleep(300);
+		val = alc_read_coef_idx(codec, 0x46);
+		is_ctia = (val & 0x0070) == 0x0070;
+		break;
+	case 0x10ec0292:
+		alc_write_coef_idx(codec, 0x6b, 0xd429);
+		msleep(300);
+		val = alc_read_coef_idx(codec, 0x6c);
+		is_ctia = (val & 0x001c) == 0x001c;
+		break;
+	case 0x10ec0668:
+		alc_write_coef_idx(codec, 0x11, 0x0001);
+		alc_write_coef_idx(codec, 0xb7, 0x802b);
+		alc_write_coef_idx(codec, 0x15, 0x0d60);
+		alc_write_coef_idx(codec, 0xc3, 0x0c00);
+		msleep(300);
+		val = alc_read_coef_idx(codec, 0xbe);
+		is_ctia = (val & 0x1c02) == 0x1c02;
+		break;
+	}
+
+	snd_printdd("Headset jack detected iPhone-style headset: %s\n",
+		    is_ctia ? "yes" : "no");
+	spec->current_headset_type = is_ctia ? ALC_HEADSET_TYPE_CTIA : ALC_HEADSET_TYPE_OMTP;
+}
+
+static void alc_update_headset_mode(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+
+	hda_nid_t mux_pin = spec->gen.imux_pins[spec->gen.cur_mux[0]];
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+
+	int new_headset_mode;
+
+	if (!snd_hda_jack_detect(codec, hp_pin))
+		new_headset_mode = ALC_HEADSET_MODE_UNPLUGGED;
+	else if (mux_pin == spec->headset_mic_pin)
+		new_headset_mode = ALC_HEADSET_MODE_HEADSET;
+	else if (mux_pin == spec->headphone_mic_pin)
+		new_headset_mode = ALC_HEADSET_MODE_MIC;
+	else
+		new_headset_mode = ALC_HEADSET_MODE_HEADPHONE;
+
+	if (new_headset_mode == spec->current_headset_mode)
+		return;
+
+	switch (new_headset_mode) {
+	case ALC_HEADSET_MODE_UNPLUGGED:
+		alc_headset_mode_unplugged(codec);
+		spec->gen.hp_jack_present = false;
+		break;
+	case ALC_HEADSET_MODE_HEADSET:
+		if (spec->current_headset_type == ALC_HEADSET_TYPE_UNKNOWN)
+			alc_determine_headset_type(codec);
+		if (spec->current_headset_type == ALC_HEADSET_TYPE_CTIA)
+			alc_headset_mode_ctia(codec);
+		else if (spec->current_headset_type == ALC_HEADSET_TYPE_OMTP)
+			alc_headset_mode_omtp(codec);
+		spec->gen.hp_jack_present = true;
+		break;
+	case ALC_HEADSET_MODE_MIC:
+		alc_headset_mode_mic_in(codec, hp_pin, spec->headphone_mic_pin);
+		spec->gen.hp_jack_present = false;
+		break;
+	case ALC_HEADSET_MODE_HEADPHONE:
+		alc_headset_mode_default(codec);
+		spec->gen.hp_jack_present = true;
+		break;
+	}
+	if (new_headset_mode != ALC_HEADSET_MODE_MIC) {
+		snd_hda_set_pin_ctl_cache(codec, hp_pin,
+					  AC_PINCTL_OUT_EN | AC_PINCTL_HP_EN);
+		if (spec->headphone_mic_pin)
+			snd_hda_set_pin_ctl_cache(codec, spec->headphone_mic_pin,
+						  PIN_VREFHIZ);
+	}
+	spec->current_headset_mode = new_headset_mode;
+
+	snd_hda_gen_update_outputs(codec);
+}
+
+static void alc_update_headset_mode_hook(struct hda_codec *codec,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	alc_update_headset_mode(codec);
+}
+
+static void alc_update_headset_jack_cb(struct hda_codec *codec, struct hda_jack_tbl *jack)
+{
+	struct alc_spec *spec = codec->spec;
+	spec->current_headset_type = ALC_HEADSET_MODE_UNKNOWN;
+	snd_hda_gen_hp_automute(codec, jack);
+}
+
+static void alc_probe_headset_mode(struct hda_codec *codec)
+{
+	int i;
+	struct alc_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->gen.autocfg;
+
+	/* Find mic pins */
+	for (i = 0; i < cfg->num_inputs; i++) {
+		if (cfg->inputs[i].is_headset_mic && !spec->headset_mic_pin)
+			spec->headset_mic_pin = cfg->inputs[i].pin;
+		if (cfg->inputs[i].is_headphone_mic && !spec->headphone_mic_pin)
+			spec->headphone_mic_pin = cfg->inputs[i].pin;
+	}
+
+	spec->gen.cap_sync_hook = alc_update_headset_mode_hook;
+	spec->gen.automute_hook = alc_update_headset_mode;
+	spec->gen.hp_automute_hook = alc_update_headset_jack_cb;
+}
+
+static void alc_fixup_headset_mode(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC | HDA_PINCFG_HEADPHONE_MIC;
+		break;
+	case HDA_FIXUP_ACT_PROBE:
+		alc_probe_headset_mode(codec);
+		break;
+	case HDA_FIXUP_ACT_INIT:
+		spec->current_headset_mode = 0;
+		alc_update_headset_mode(codec);
+		break;
+	}
+}
+
+static void alc_fixup_headset_mode_no_hp_mic(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		struct alc_spec *spec = codec->spec;
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+	}
+	else
+		alc_fixup_headset_mode(codec, fix, action);
+}
+
+static void alc_fixup_headset_mode_alc668(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		int val;
+		alc_write_coef_idx(codec, 0xc4, 0x8000);
+		val = alc_read_coef_idx(codec, 0xc2);
+		alc_write_coef_idx(codec, 0xc2, val & 0xfe);
+		snd_hda_set_pin_ctl_cache(codec, 0x18, 0);
+	}
+	alc_fixup_headset_mode(codec, fix, action);
+}
+
 static void alc271_hp_gate_mic_jack(struct hda_codec *codec,
 				    const struct hda_fixup *fix,
 				    int action)
@@ -2837,6 +3152,10 @@ enum {
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
+	ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC269_FIXUP_DELL2_MIC_NO_PRESENCE,
+	ALC269_FIXUP_HEADSET_MODE,
+	ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC,
 	ALC271_FIXUP_AMIC_MIC2,
 	ALC271_FIXUP_HP_GATE_MIC_JACK,
 	ALC269_FIXUP_ACER_AC700,
@@ -2996,6 +3315,35 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC269_FIXUP_DELL1_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ 0x1a, 0x01a1913d }, /* use as headphone mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
+	[ALC269_FIXUP_DELL2_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x16, 0x21014020 }, /* dock line out */
+			{ 0x19, 0x21a19030 }, /* dock mic */
+			{ 0x1a, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
+	[ALC269_FIXUP_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_mode,
+	},
+	[ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_mode_no_hp_mic,
+	},
 	[ALC271_FIXUP_AMIC_MIC2] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -3030,6 +3378,26 @@ static const struct hda_fixup alc269_fixups[] = {
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
+	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05be, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05c4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05c5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05c6, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05c7, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05c8, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05c9, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05ca, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05cb, "Dell", ALC269_FIXUP_DELL2_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05e9, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05ea, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05eb, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05ec, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05ed, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05ee, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05f3, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05f4, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05f5, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05f6, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x18e6, "HP", ALC269_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x1973, "HP Pavilion", ALC269_FIXUP_HP_MUTE_LED_MIC1),
@@ -3536,6 +3904,8 @@ enum {
 	ALC662_FIXUP_NO_JACK_DETECT,
 	ALC662_FIXUP_ZOTAC_Z68,
 	ALC662_FIXUP_INV_DMIC,
+	ALC668_FIXUP_DELL_MIC_NO_PRESENCE,
+	ALC668_FIXUP_HEADSET_MODE,
 };
 
 static const struct hda_fixup alc662_fixups[] = {
@@ -3696,6 +4066,20 @@ static const struct hda_fixup alc662_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_inv_dmic_0x12,
 	},
+	[ALC668_FIXUP_DELL_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a1913d }, /* use as headphone mic, without its own jack detect */
+			{ 0x1b, 0x03a1113c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC668_FIXUP_HEADSET_MODE
+	},
+	[ALC668_FIXUP_HEADSET_MODE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_mode_alc668,
+	},
 };
 
 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -3704,6 +4088,8 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x031c, "Gateway NV79", ALC662_FIXUP_SKU_IGNORE),
 	SND_PCI_QUIRK(0x1025, 0x0349, "eMachines eM250", ALC662_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x038b, "Acer Aspire 8943G", ALC662_FIXUP_ASPIRE),
+	SND_PCI_QUIRK(0x1028, 0x05d8, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1028, 0x05db, "Dell", ALC668_FIXUP_DELL_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x1043, 0x8469, "ASUS mobo", ALC662_FIXUP_NO_JACK_DETECT),
 	SND_PCI_QUIRK(0x105b, 0x0cd6, "Foxconn", ALC662_FIXUP_ASUS_MODE2),
-- 
1.7.9.5
