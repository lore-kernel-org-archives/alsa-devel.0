From: Hui Wang <hui.wang@canonical.com>
Subject: [PATCH v2 2/2] ALSA: hda - Add keycode map for alc input device
Date: Mon, 28 Dec 2015 11:35:25 +0800
Message-ID: <1451273725-28359-2-git-send-email-hui.wang@canonical.com>
References: <1451273725-28359-1-git-send-email-hui.wang@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1451273725-28359-1-git-send-email-hui.wang@canonical.com>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: stable@vger.kernel.org, kailang@realtek.com, hui.wang@canonical.com
List-Id: alsa-devel@alsa-project.org

Then users can remap the keycode from userspace. If without the remap,
the input device will pass KEY_MICMUTE to userspace, but in X11 layer,
it uses KEY_F20 rather than KEY_MICMUTE for XF86AudioMicMute. After
adding the keycode map, users can remap the keycode to any value users
want.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 257b839..3a89d82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -67,6 +67,10 @@ enum {
 	ALC_HEADSET_TYPE_OMTP,
 };
 
+enum {
+	ALC_KEY_MICMUTE_INDEX,
+};
+
 struct alc_customize_define {
 	unsigned int  sku_cfg;
 	unsigned char port_connectivity;
@@ -123,6 +127,7 @@ struct alc_spec {
 	unsigned int pll_coef_idx, pll_coef_bit;
 	unsigned int coef0;
 	struct input_dev *kb_dev;
+	u8 alc_mute_keycode_map[1];
 };
 
 /*
@@ -3462,24 +3467,32 @@ static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 
 	/* GPIO2 just toggles on a keypress/keyrelease cycle. Therefore
 	   send both key on and key off event for every interrupt. */
-	input_report_key(spec->kb_dev, KEY_MICMUTE, 1);
+	input_report_key(spec->kb_dev, spec->alc_mute_keycode_map[ALC_KEY_MICMUTE_INDEX], 1);
 	input_sync(spec->kb_dev);
-	input_report_key(spec->kb_dev, KEY_MICMUTE, 0);
+	input_report_key(spec->kb_dev, spec->alc_mute_keycode_map[ALC_KEY_MICMUTE_INDEX], 0);
 	input_sync(spec->kb_dev);
 }
 
 static int alc_register_micmute_input_device(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
+	int i;
 
 	spec->kb_dev = input_allocate_device();
 	if (!spec->kb_dev) {
 		codec_err(codec, "Out of memory (input_allocate_device)\n");
 		return -ENOMEM;
 	}
+
+	spec->alc_mute_keycode_map[ALC_KEY_MICMUTE_INDEX] = KEY_MICMUTE;
+
 	spec->kb_dev->name = "Microphone Mute Button";
 	spec->kb_dev->evbit[0] = BIT_MASK(EV_KEY);
-	spec->kb_dev->keybit[BIT_WORD(KEY_MICMUTE)] = BIT_MASK(KEY_MICMUTE);
+	spec->kb_dev->keycodesize = sizeof(spec->alc_mute_keycode_map[0]);
+	spec->kb_dev->keycodemax = ARRAY_SIZE(spec->alc_mute_keycode_map);
+	spec->kb_dev->keycode = spec->alc_mute_keycode_map;
+	for (i = 0; i < ARRAY_SIZE(spec->alc_mute_keycode_map); i++)
+		set_bit(spec->alc_mute_keycode_map[i], spec->kb_dev->keybit);
 
 	if (input_register_device(spec->kb_dev)) {
 		codec_err(codec, "input_register_device failed\n");
-- 
1.9.1
