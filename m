From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 3/3] ALSA: hda - add connection to thinkpad_acpi to control mute/micmute LEDs
Date: Wed, 16 Oct 2013 23:10:33 +0200
Message-ID: <1381957833-13788-4-git-send-email-david.henningsson@canonical.com>
References: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1381957833-13788-1-git-send-email-david.henningsson@canonical.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, platform-driver-x86@vger.kernel.org, ibm-acpi@hmh.eng.br, alex.hung@canonical.com, hui.wang@canonical.com
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   92 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index ec68eae..993b25c 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3208,11 +3208,17 @@ static int cx_auto_init(struct hda_codec *codec)
 	return 0;
 }
 
+static void cx_auto_free(struct hda_codec *codec)
+{
+	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_FREE);
+	snd_hda_gen_free(codec);
+}
+
 static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_controls = cx_auto_build_controls,
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
-	.free = snd_hda_gen_free,
+	.free = cx_auto_free,
 	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -3232,8 +3238,84 @@ enum {
 	CXT_FIXUP_HEADPHONE_MIC_PIN,
 	CXT_FIXUP_HEADPHONE_MIC,
 	CXT_FIXUP_GPIO1,
+	CXT_FIXUP_THINKPAD_ACPI,
 };
 
+#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
+
+#include <linux/thinkpad_acpi.h>
+
+static int (*led_set_func)(int, bool);
+
+static void update_tpacpi_mute_led(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct conexant_spec *spec = codec->spec;
+
+	if (spec->dynamic_eapd)
+		cx_auto_vmaster_hook(private_data, enabled);
+
+	if (led_set_func)
+		led_set_func(TPACPI_LED_MUTE, !enabled);
+}
+
+static void update_tpacpi_micmute_led(struct hda_codec *codec,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	if (!ucontrol || !led_set_func)
+		return;
+	if (strcmp("Capture Switch", ucontrol->id.name) == 0 && ucontrol->id.index == 0) {
+		/* TODO: How do I verify if it's a mono or stereo here? */
+		bool val = ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1];
+		led_set_func(TPACPI_LED_MICMUTE, !val);
+	}
+}
+
+static void cxt_fixup_thinkpad_acpi(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	bool removefunc = false;
+
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!led_set_func)
+			led_set_func = symbol_request(tpacpi_led_set);
+		if (!led_set_func) {
+			snd_printk(KERN_WARNING "Failed to find thinkpad-acpi symbol tpacpi_led_set\n");
+			return;
+		}
+
+		removefunc = true;
+		if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
+			spec->gen.vmaster_mute.hook = update_tpacpi_mute_led;
+			removefunc = false;
+		}
+		if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) {
+			if (spec->gen.num_adc_nids > 1)
+				snd_printdd("Skipping micmute LED control due to several ADCs");
+			else {
+				spec->gen.cap_sync_hook = update_tpacpi_micmute_led;
+				removefunc = false;
+			}
+		}
+	}
+
+	if (led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
+		symbol_put(tpacpi_led_set);
+		led_set_func = NULL;
+	}
+}
+
+#else
+
+static void cxt_fixup_thinkpad_acpi(struct hda_codec *codec,
+				  const struct hda_fixup *fix, int action)
+{
+}
+
+#endif
+
 static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
 {
@@ -3344,6 +3426,8 @@ static const struct hda_fixup cxt_fixups[] = {
 	[CXT_PINCFG_LENOVO_TP410] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_lenovo_tp410,
+		.chained = true,
+		.chain_id = CXT_FIXUP_THINKPAD_ACPI,
 	},
 	[CXT_PINCFG_LEMOTE_A1004] = {
 		.type = HDA_FIXUP_PINS,
@@ -3385,6 +3469,10 @@ static const struct hda_fixup cxt_fixups[] = {
 			{ }
 		},
 	},
+	[CXT_FIXUP_THINKPAD_ACPI] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_thinkpad_acpi,
+	},
 };
 
 static const struct snd_pci_quirk cxt5051_fixups[] = {
@@ -3507,7 +3595,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	return 0;
 
  error:
-	snd_hda_gen_free(codec);
+	cx_auto_free(codec);
 	return err;
 }
 
-- 
1.7.9.5
