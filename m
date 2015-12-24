From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH 2/2] ALSA: hda - Add keycode map for alc input device
Date: Thu, 24 Dec 2015 11:46:38 +0800
Message-ID: <1450928798-31191-2-git-send-email-hui.wang@canonical.com>
References: <1450928798-31191-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1450928798-31191-1-git-send-email-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

Then users can remap the keycode from userspace. If without the remap,
the input device will pass KEY_MICMUTE to userspace, but in X11 layer,
it uses KEY_F20 rather than KEY_MICMUTE for XF86AudioMicMute. After
adding the keycode map, users can remap the keycode to any value users
want.

And there are two places to register the input device, to make the
code simple and clean, we move the two same code sections into a
function.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 68 +++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8adff4f..97f22ad 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -67,6 +67,14 @@ enum {
 	ALC_HEADSET_TYPE_OMTP,
 };
 
+enum {
+	ALC_KEY_MICMUTE_INDEX,
+};
+
+static u8 alc_mute_keycode_map[] = {
+	KEY_MICMUTE,	/* index=0, microphone mute key code */
+};
+
 struct alc_customize_define {
 	unsigned int  sku_cfg;
 	unsigned char port_connectivity;
@@ -3462,12 +3470,40 @@ static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 
 	/* GPIO2 just toggles on a keypress/keyrelease cycle. Therefore
 	   send both key on and key off event for every interrupt. */
-	input_report_key(spec->kb_dev, KEY_MICMUTE, 1);
+	input_report_key(spec->kb_dev, alc_mute_keycode_map[ALC_KEY_MICMUTE_INDEX], 1);
 	input_sync(spec->kb_dev);
-	input_report_key(spec->kb_dev, KEY_MICMUTE, 0);
+	input_report_key(spec->kb_dev, alc_mute_keycode_map[ALC_KEY_MICMUTE_INDEX], 0);
 	input_sync(spec->kb_dev);
 }
 
+static int alc_register_micmute_input_device(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	int i;
+
+	spec->kb_dev = input_allocate_device();
+	if (!spec->kb_dev) {
+		codec_err(codec, "Out of memory (input_allocate_device)\n");
+		return -ENOMEM;
+	}
+	spec->kb_dev->name = "Microphone Mute Button";
+	spec->kb_dev->evbit[0] = BIT_MASK(EV_KEY);
+	spec->kb_dev->keycodesize = sizeof(alc_mute_keycode_map[0]);
+	spec->kb_dev->keycodemax = ARRAY_SIZE(alc_mute_keycode_map);
+	spec->kb_dev->keycode = alc_mute_keycode_map;
+	for (i = 0; i < ARRAY_SIZE(alc_mute_keycode_map); i++)
+		set_bit(alc_mute_keycode_map[i], spec->kb_dev->keybit);
+
+	if (input_register_device(spec->kb_dev)) {
+		codec_err(codec, "input_register_device failed\n");
+		input_free_device(spec->kb_dev);
+		spec->kb_dev = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 					     const struct hda_fixup *fix, int action)
 {
@@ -3485,20 +3521,8 @@ static void alc280_fixup_hp_gpio2_mic_hotkey(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->kb_dev = input_allocate_device();
-		if (!spec->kb_dev) {
-			codec_err(codec, "Out of memory (input_allocate_device)\n");
+		if (alc_register_micmute_input_device(codec) != 0)
 			return;
-		}
-		spec->kb_dev->name = "Microphone Mute Button";
-		spec->kb_dev->evbit[0] = BIT_MASK(EV_KEY);
-		spec->kb_dev->keybit[BIT_WORD(KEY_MICMUTE)] = BIT_MASK(KEY_MICMUTE);
-		if (input_register_device(spec->kb_dev)) {
-			codec_err(codec, "input_register_device failed\n");
-			input_free_device(spec->kb_dev);
-			spec->kb_dev = NULL;
-			return;
-		}
 
 		snd_hda_add_verbs(codec, gpio_init);
 		snd_hda_codec_write_cache(codec, codec->core.afg, 0,
@@ -3542,20 +3566,8 @@ static void alc233_fixup_lenovo_line2_mic_hotkey(struct hda_codec *codec,
 	struct alc_spec *spec = codec->spec;
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->kb_dev = input_allocate_device();
-		if (!spec->kb_dev) {
-			codec_err(codec, "Out of memory (input_allocate_device)\n");
+		if (alc_register_micmute_input_device(codec) != 0)
 			return;
-		}
-		spec->kb_dev->name = "Microphone Mute Button";
-		spec->kb_dev->evbit[0] = BIT_MASK(EV_KEY);
-		spec->kb_dev->keybit[BIT_WORD(KEY_MICMUTE)] = BIT_MASK(KEY_MICMUTE);
-		if (input_register_device(spec->kb_dev)) {
-			codec_err(codec, "input_register_device failed\n");
-			input_free_device(spec->kb_dev);
-			spec->kb_dev = NULL;
-			return;
-		}
 
 		snd_hda_add_verbs(codec, gpio_init);
 		snd_hda_jack_detect_enable_callback(codec, 0x1b,
-- 
1.9.1
