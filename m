From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 1/2] ALSA: hda - Add mic mute hotkey quirk for Lenovo ThinkCentre AIO
Date: Thu, 24 Dec 2015 11:46:37 +0800
Message-ID: <1450928798-31191-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

From: Kailang <kailang@realtek.com>

The Lenovo ThinkCenter AIO uses Line2 (NID 0x1b) to implement the
micmute hotkey, here we register an input device and use Line2 unsol
event to collect the hotkey pressing or releasing.

In the meanwhile, the micmute led is controlled by GPIO2, so we
use an existing function alc_fixup_gpio_mic_mute_hook() to control
the led.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kailang <kailang@realtek.com>
---
 sound/pci/hda/patch_realtek.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index fe96428..8adff4f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3528,6 +3528,59 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 	}
 }
 
+static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
+					     const struct hda_fixup *fix, int action)
+{
+	/* Line2 = mic mute hotkey
+	   GPIO2 = mic mute LED */
+	static const struct hda_verb gpio_init[] = {
+		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x04 },
+		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04 },
+		{}
+	};
+
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->kb_dev = input_allocate_device();
+		if (!spec->kb_dev) {
+			codec_err(codec, "Out of memory (input_allocate_device)\n");
+			return;
+		}
+		spec->kb_dev->name = "Microphone Mute Button";
+		spec->kb_dev->evbit[0] = BIT_MASK(EV_KEY);
+		spec->kb_dev->keybit[BIT_WORD(KEY_MICMUTE)] = BIT_MASK(KEY_MICMUTE);
+		if (input_register_device(spec->kb_dev)) {
+			codec_err(codec, "input_register_device failed\n");
+			input_free_device(spec->kb_dev);
+			spec->kb_dev = NULL;
+			return;
+		}
+
+		snd_hda_add_verbs(codec, gpio_init);
+		snd_hda_jack_detect_enable_callback(codec, 0x1b,
+						    gpio2_mic_hotkey_event);
+
+		spec->gen.cap_sync_hook = alc_fixup_gpio_mic_mute_hook;
+		spec->gpio_led = 0;
+		spec->mute_led_polarity = 0;
+		spec->gpio_mic_led_mask = 0x04;
+		return;
+	}
+
+	if (!spec->kb_dev)
+		return;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PROBE:
+		spec->init_amp = ALC_INIT_DEFAULT;
+		break;
+	case HDA_FIXUP_ACT_FREE:
+		input_unregister_device(spec->kb_dev);
+		spec->kb_dev = NULL;
+	}
+}
+
 static void alc269_fixup_hp_line1_mic1_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -4628,6 +4681,7 @@ enum {
 	ALC275_FIXUP_DELL_XPS,
 	ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE,
 	ALC293_FIXUP_LENOVO_SPK_NOISE,
+	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -5237,6 +5291,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_THINKPAD_ACPI
 	},
+	[ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc233_fixup_lenovo_line2_mic_hotkey,
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -5386,6 +5444,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x2223, "ThinkPad T550", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2226, "ThinkPad X250", ALC292_FIXUP_TPT440_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2233, "Thinkpad", ALC293_FIXUP_LENOVO_SPK_NOISE),
+	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "IdeaPad Y410P", ALC269_FIXUP_NO_SHUTUP),
 	SND_PCI_QUIRK(0x17aa, 0x5013, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
1.9.1
