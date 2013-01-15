From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 17/20] ALSA: hda/realtek - Generic mute LED
	implementation for HP laptops
Date: Tue, 15 Jan 2013 12:05:44 +0100
Message-ID: <1358247947-13992-18-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BEE93265329
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id A96C6A5237
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

As David Henningsson recently suggested, some HP laptops use an unused
mic pin for controlling a mute LED, and this information is provided
via DMI string "HP_Mute_LED_X_Y" string.  This patch adds the generic
support for such cases, as we've already done in patch_sigmatel.c.
This is applied generically to all devices with ID 0x103c.

But as we don't know whether the device 103c:1586 really contains
HP_Mute_LED_X_Y DMI string, still keep the static setup for this
device using the mic2 pin 0x19.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 76 +++++++++++++++++++++++++++----------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eb889d2..fab31d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -27,6 +27,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <sound/core.h>
@@ -82,6 +83,10 @@ struct alc_spec {
 	unsigned int inv_dmic_muted:1; /* R-ch of inv d-mic is muted? */
 	hda_nid_t inv_dmic_pin;
 
+	/* mute LED for HP laptops, see alc269_fixup_mic_mute_hook() */
+	int mute_led_polarity;
+	hda_nid_t mute_led_nid;
+
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
 #ifdef CONFIG_PM
@@ -2653,39 +2658,54 @@ static void alc269_fixup_quanta_mute(struct hda_codec *codec,
 	spec->gen.automute_hook = alc269_quanta_automute;
 }
 
-/* update mute-LED according to the speaker mute state via mic1 VREF pin */
-static void alc269_fixup_mic1_mute_hook(void *private_data, int enabled)
+/* update mute-LED according to the speaker mute state via mic VREF pin */
+static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 {
 	struct hda_codec *codec = private_data;
-	unsigned int pinval = AC_PINCTL_IN_EN + (enabled ?
-			      AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80);
-	snd_hda_set_pin_ctl_cache(codec, 0x18, pinval);
+	struct alc_spec *spec = codec->spec;
+	unsigned int pinval;
+
+	if (spec->mute_led_polarity)
+		enabled = !enabled;
+	pinval = AC_PINCTL_IN_EN |
+		(enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80);
+	if (spec->mute_led_nid)
+		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
 }
 
-static void alc269_fixup_mic1_mute(struct hda_codec *codec,
-				   const struct hda_fixup *fix, int action)
+static void alc269_fixup_hp_mute_led(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->gen.vmaster_mute.hook = alc269_fixup_mic1_mute_hook;
+	const struct dmi_device *dev = NULL;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	while ((dev = dmi_find_device(DMI_DEV_TYPE_OEM_STRING, NULL, dev))) {
+		int pol, pin;
+		if (sscanf(dev->name, "HP_Mute_LED_%d_%x", &pol, &pin) != 2)
+			continue;
+		if (pin < 0x0a || pin >= 0x10)
+			break;
+		spec->mute_led_polarity = pol;
+		spec->mute_led_nid = pin - 0x0a + 0x18;
+		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
+		snd_printd("Detected mute LED for %x:%d\n", spec->mute_led_nid,
+			   spec->mute_led_polarity);
+		break;
 	}
 }
 
-/* update mute-LED according to the speaker mute state via mic2 VREF pin */
-static void alc269_fixup_mic2_mute_hook(void *private_data, int enabled)
-{
-	struct hda_codec *codec = private_data;
-	unsigned int pinval = enabled ? 0x20 : 0x24;
-	snd_hda_set_pin_ctl_cache(codec, 0x19, pinval);
-}
-
-static void alc269_fixup_mic2_mute(struct hda_codec *codec,
-				   const struct hda_fixup *fix, int action)
+static void alc269_fixup_hp_mute_led_mic2(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
-		spec->gen.vmaster_mute.hook = alc269_fixup_mic2_mute_hook;
+		spec->mute_led_polarity = 0;
+		spec->mute_led_nid = 0x19;
+		spec->gen.vmaster_mute.hook = alc269_fixup_mic_mute_hook;
 		spec->gen.vmaster_mute_enum = 1;
 	}
 }
@@ -2721,8 +2741,8 @@ enum {
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
 	ALC269VB_FIXUP_DMIC,
-	ALC269_FIXUP_MIC1_MUTE_LED,
-	ALC269_FIXUP_MIC2_MUTE_LED,
+	ALC269_FIXUP_HP_MUTE_LED,
+	ALC269_FIXUP_HP_MUTE_LED_MIC2,
 	ALC269_FIXUP_INV_DMIC,
 	ALC269_FIXUP_LENOVO_DOCK,
 	ALC269_FIXUP_PINCFG_NO_HP_TO_LINEOUT,
@@ -2850,13 +2870,13 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 	},
-	[ALC269_FIXUP_MIC1_MUTE_LED] = {
+	[ALC269_FIXUP_HP_MUTE_LED] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc269_fixup_mic1_mute,
+		.v.func = alc269_fixup_hp_mute_led,
 	},
-	[ALC269_FIXUP_MIC2_MUTE_LED] = {
+	[ALC269_FIXUP_HP_MUTE_LED_MIC2] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc269_fixup_mic2_mute,
+		.v.func = alc269_fixup_hp_mute_led_mic2,
 	},
 	[ALC269_FIXUP_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -2897,8 +2917,8 @@ static const struct hda_fixup alc269_fixups[] = {
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x029b, "Acer 1810TZ", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x0349, "Acer AOD260", ALC269_FIXUP_INV_DMIC),
-	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_MIC2_MUTE_LED),
-	SND_PCI_QUIRK(0x103c, 0x1972, "HP Pavilion 17", ALC269_FIXUP_MIC1_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
+	SND_PCI_QUIRK_VENDOR(0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
-- 
1.8.1
