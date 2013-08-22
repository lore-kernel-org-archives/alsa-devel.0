From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Fix ALC283 headphone pop-noise
	better
Date: Thu, 22 Aug 2013 10:21:08 +0200
Message-ID: <1377159669-32767-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2773426536B
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 10:19:25 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F0D2FA0FED
 for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2013 10:19:22 +0200 (CEST)
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

From: Kailang Yang <kailang@realtek.com>

Fixed ALC283 D3 to D0 and D0 to D3 Headphone pop noise.
The previous fix [c5177c86: ALSA: hda - Fix the noise after suspend on
ALC283 codec] doesn't work sufficiently for some laptops.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 111 +++++++++++++++++++++++++++++-------------
 1 file changed, 76 insertions(+), 35 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7d00639..4bdccd1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2527,6 +2527,7 @@ enum {
 	ALC269_TYPE_ALC269VD,
 	ALC269_TYPE_ALC280,
 	ALC269_TYPE_ALC282,
+	ALC269_TYPE_ALC283,
 	ALC269_TYPE_ALC284,
 	ALC269_TYPE_ALC286,
 };
@@ -2552,6 +2553,7 @@ static int alc269_parse_auto_config(struct hda_codec *codec)
 	case ALC269_TYPE_ALC269VB:
 	case ALC269_TYPE_ALC269VD:
 	case ALC269_TYPE_ALC282:
+	case ALC269_TYPE_ALC283:
 	case ALC269_TYPE_ALC286:
 		ssids = alc269_ssids;
 		break;
@@ -2586,6 +2588,74 @@ static void alc269_shutup(struct hda_codec *codec)
 	snd_hda_shutup_pins(codec);
 }
 
+static void alc283_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	bool hp_pin_sense;
+	int val;
+
+	if (!hp_pin)
+		return;
+	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+
+	/* Index 0x43 Direct Drive HP AMP LPM Control 1 */
+	/* Headphone capless set to high power mode */
+	alc_write_coef_idx(codec, 0x43, 0x9004);
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+	if (hp_pin_sense)
+		msleep(85);
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT);
+
+	if (hp_pin_sense)
+		msleep(85);
+	/* Index 0x46 Combo jack auto switch control 2 */
+	/* 3k pull low control for Headset jack. */
+	val = alc_read_coef_idx(codec, 0x46);
+	alc_write_coef_idx(codec, 0x46, val & ~(3 << 12));
+	/* Headphone capless set to normal mode */
+	alc_write_coef_idx(codec, 0x43, 0x9614);
+}
+
+static void alc283_shutup(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	bool hp_pin_sense;
+	int val;
+
+	if (!hp_pin) {
+		alc269_shutup(codec);
+		return;
+	}
+
+	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
+
+	alc_write_coef_idx(codec, 0x43, 0x9004);
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+	if (hp_pin_sense)
+		msleep(85);
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	val = alc_read_coef_idx(codec, 0x46);
+	alc_write_coef_idx(codec, 0x46, val | (3 << 12));
+
+	if (hp_pin_sense)
+		msleep(85);
+	snd_hda_shutup_pins(codec);
+	alc_write_coef_idx(codec, 0x43, 0x9614);
+}
+
 static void alc5505_coef_set(struct hda_codec *codec, unsigned int index_reg,
 			     unsigned int val)
 {
@@ -2715,12 +2785,6 @@ static int alc269_resume(struct hda_codec *codec)
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_resume(codec);
 
-	/* clear the power-save mode for ALC283 */
-	if (codec->vendor_id == 0x10ec0283) {
-		alc_write_coef_idx(codec, 0x4, 0xaf01);
-		alc_write_coef_idx(codec, 0x6, 0x2104);
-	}
-
 	return 0;
 }
 #endif /* CONFIG_PM */
@@ -3815,30 +3879,6 @@ static void alc269_fill_coef(struct hda_codec *codec)
 	alc_write_coef_idx(codec, 0x4, val | (1<<11));
 }
 
-/* don't clear mic pin; otherwise it results in noise in D3 */
-static void alc283_headset_shutup(struct hda_codec *codec)
-{
-	int i;
-
-	if (codec->bus->shutdown)
-		return;
-
-	for (i = 0; i < codec->init_pins.used; i++) {
-		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
-		/* use read here for syncing after issuing each verb */
-		if (pin->nid != 0x19)
-			snd_hda_codec_read(codec, pin->nid, 0,
-					   AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
-	}
-
-	alc_write_coef_idx(codec, 0x4, 0x0f01); /* power save */
-	alc_write_coef_idx(codec, 0x6, 0x2100); /* power save */
-	snd_hda_codec_write(codec, 0x19, 0,
-			AC_VERB_SET_PIN_WIDGET_CONTROL,
-			PIN_VREFHIZ);
-	codec->pins_shutup = 1;
-}
-
 /*
  */
 static int patch_alc269(struct hda_codec *codec)
@@ -3853,9 +3893,6 @@ static int patch_alc269(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 
-	if (codec->vendor_id == 0x10ec0283)
-		spec->shutup = alc283_headset_shutup;
-
 	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -3897,11 +3934,15 @@ static int patch_alc269(struct hda_codec *codec)
 	case 0x10ec0290:
 		spec->codec_variant = ALC269_TYPE_ALC280;
 		break;
-	case 0x10ec0233:
 	case 0x10ec0282:
-	case 0x10ec0283:
 		spec->codec_variant = ALC269_TYPE_ALC282;
 		break;
+	case 0x10ec0233:
+	case 0x10ec0283:
+		spec->codec_variant = ALC269_TYPE_ALC283;
+		spec->shutup = alc283_shutup;
+		spec->init_hook = alc283_init;
+		break;
 	case 0x10ec0284:
 	case 0x10ec0292:
 		spec->codec_variant = ALC269_TYPE_ALC284;
-- 
1.8.3.4
