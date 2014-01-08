From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Split Thinkpad ACPI-related code
Date: Wed,  8 Jan 2014 11:48:28 +0100
Message-ID: <1389178108-11218-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F76826510B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 11:48:29 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DD595AC44
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 10:48:28 +0000 (UTC)
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

Both patch_realtek.c and patch_conexant.c contain the fairy same code
snippet for supporting Thinkpad ACPI LED controls.  Split them into
thinkpad_helper.c and include it from both places.  Although this
isn't the best approach from the code size POV, the probability for
coexistence of both Realtek and Conexant codecs on a single machine is
pretty low, thus it'll end up with less memory footprint than
splitting to yet another module.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c  | 100 ++--------------------------------------
 sound/pci/hda/patch_realtek.c   |  93 ++-----------------------------------
 sound/pci/hda/thinkpad_helper.c |  99 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 105 insertions(+), 187 deletions(-)
 create mode 100644 sound/pci/hda/thinkpad_helper.c

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 6df4c35b48c5..4e0ec146553d 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3240,102 +3240,8 @@ enum {
 	CXT_FIXUP_THINKPAD_ACPI,
 };
 
-#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
-
-#include <linux/thinkpad_acpi.h>
-#include <linux/acpi.h>
-
-static int (*led_set_func)(int, bool);
-
-static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
-				 void **rv)
-{
-	bool *found = context;
-	*found = true;
-	return AE_OK;
-}
-
-static bool is_thinkpad(struct hda_codec *codec)
-{
-	bool found = false;
-	if (codec->subsystem_id >> 16 != 0x17aa)
-		return false;
-	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
-		return true;
-	found = false;
-	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
-}
-
-static void update_tpacpi_mute_led(void *private_data, int enabled)
-{
-	struct hda_codec *codec = private_data;
-	struct conexant_spec *spec = codec->spec;
-
-	if (spec->dynamic_eapd)
-		cx_auto_vmaster_hook(private_data, enabled);
-
-	if (led_set_func)
-		led_set_func(TPACPI_LED_MUTE, !enabled);
-}
-
-static void update_tpacpi_micmute_led(struct hda_codec *codec,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	if (!ucontrol || !led_set_func)
-		return;
-	if (strcmp("Capture Switch", ucontrol->id.name) == 0 && ucontrol->id.index == 0) {
-		/* TODO: How do I verify if it's a mono or stereo here? */
-		bool val = ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1];
-		led_set_func(TPACPI_LED_MICMUTE, !val);
-	}
-}
-
-static void cxt_fixup_thinkpad_acpi(struct hda_codec *codec,
-				  const struct hda_fixup *fix, int action)
-{
-	struct conexant_spec *spec = codec->spec;
-
-	bool removefunc = false;
-
-	if (action == HDA_FIXUP_ACT_PROBE) {
-		if (!is_thinkpad(codec))
-			return;
-		if (!led_set_func)
-			led_set_func = symbol_request(tpacpi_led_set);
-		if (!led_set_func) {
-			snd_printk(KERN_WARNING "Failed to find thinkpad-acpi symbol tpacpi_led_set\n");
-			return;
-		}
-
-		removefunc = true;
-		if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
-			spec->gen.vmaster_mute.hook = update_tpacpi_mute_led;
-			removefunc = false;
-		}
-		if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) {
-			if (spec->gen.num_adc_nids > 1)
-				snd_printdd("Skipping micmute LED control due to several ADCs");
-			else {
-				spec->gen.cap_sync_hook = update_tpacpi_micmute_led;
-				removefunc = false;
-			}
-		}
-	}
-
-	if (led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
-		symbol_put(tpacpi_led_set);
-		led_set_func = NULL;
-	}
-}
-
-#else
-
-static void cxt_fixup_thinkpad_acpi(struct hda_codec *codec,
-				  const struct hda_fixup *fix, int action)
-{
-}
-
-#endif
+/* for hda_fixup_thinkpad_acpi() */
+#include "thinkpad_helper.c"
 
 static void cxt_fixup_stereo_dmic(struct hda_codec *codec,
 				  const struct hda_fixup *fix, int action)
@@ -3492,7 +3398,7 @@ static const struct hda_fixup cxt_fixups[] = {
 	},
 	[CXT_FIXUP_THINKPAD_ACPI] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = cxt_fixup_thinkpad_acpi,
+		.v.func = hda_fixup_thinkpad_acpi,
 	},
 };
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 74b496b0d179..d35cf3dc6711 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3781,95 +3781,8 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
 	}
 }
 
-#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
-
-#include <linux/thinkpad_acpi.h>
-#include <linux/acpi.h>
-
-static int (*led_set_func)(int, bool);
-
-static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
-				 void **rv)
-{
-	bool *found = context;
-	*found = true;
-	return AE_OK;
-}
-
-static bool is_thinkpad(struct hda_codec *codec)
-{
-	bool found = false;
-	if (codec->subsystem_id >> 16 != 0x17aa)
-		return false;
-	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
-		return true;
-	found = false;
-	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
-}
-
-static void update_tpacpi_mute_led(void *private_data, int enabled)
-{
-	if (led_set_func)
-		led_set_func(TPACPI_LED_MUTE, !enabled);
-}
-
-static void update_tpacpi_micmute_led(struct hda_codec *codec,
-				      struct snd_ctl_elem_value *ucontrol)
-{
-	if (!ucontrol || !led_set_func)
-		return;
-	if (strcmp("Capture Switch", ucontrol->id.name) == 0 && ucontrol->id.index == 0) {
-		/* TODO: How do I verify if it's a mono or stereo here? */
-		bool val = ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1];
-		led_set_func(TPACPI_LED_MICMUTE, !val);
-	}
-}
-
-static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
-				  const struct hda_fixup *fix, int action)
-{
-	struct alc_spec *spec = codec->spec;
-	bool removefunc = false;
-
-	if (action == HDA_FIXUP_ACT_PROBE) {
-		if (!is_thinkpad(codec))
-			return;
-		if (!led_set_func)
-			led_set_func = symbol_request(tpacpi_led_set);
-		if (!led_set_func) {
-			snd_printk(KERN_WARNING "Failed to find thinkpad-acpi symbol tpacpi_led_set\n");
-			return;
-		}
-
-		removefunc = true;
-		if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
-			spec->gen.vmaster_mute.hook = update_tpacpi_mute_led;
-			removefunc = false;
-		}
-		if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) {
-			if (spec->gen.num_adc_nids > 1)
-				snd_printdd("Skipping micmute LED control due to several ADCs");
-			else {
-				spec->gen.cap_sync_hook = update_tpacpi_micmute_led;
-				removefunc = false;
-			}
-		}
-	}
-
-	if (led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
-		symbol_put(tpacpi_led_set);
-		led_set_func = NULL;
-	}
-}
-
-#else
-
-static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
-				  const struct hda_fixup *fix, int action)
-{
-}
-
-#endif
+/* for hda_fixup_thinkpad_acpi() */
+#include "thinkpad_helper.c"
 
 enum {
 	ALC269_FIXUP_SONY_VAIO,
@@ -4273,7 +4186,7 @@ static const struct hda_fixup alc269_fixups[] = {
 	},
 	[ALC269_FIXUP_THINKPAD_ACPI] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc_fixup_thinkpad_acpi,
+		.v.func = hda_fixup_thinkpad_acpi,
 	},
 	[ALC255_FIXUP_DELL1_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
new file mode 100644
index 000000000000..8492b8a3ce47
--- /dev/null
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -0,0 +1,99 @@
+/* Helper functions for Thinkpad LED control;
+ * to be included from codec driver
+ */
+
+#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
+
+#include <linux/acpi.h>
+#include <linux/thinkpad_acpi.h>
+
+static int (*led_set_func)(int, bool);
+
+static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
+				 void **rv)
+{
+	bool *found = context;
+	*found = true;
+	return AE_OK;
+}
+
+static bool is_thinkpad(struct hda_codec *codec)
+{
+	bool found = false;
+	if (codec->subsystem_id >> 16 != 0x17aa)
+		return false;
+	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
+		return true;
+	found = false;
+	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
+}
+
+static void update_tpacpi_mute_led(void *private_data, int enabled)
+{
+	struct hda_codec *codec = private_data;
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->vmaster_mute.hook)
+		spec->vmaster_mute.hook(private_data, enabled);
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
+static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	bool removefunc = false;
+
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!is_thinkpad(codec))
+			return;
+		if (!led_set_func)
+			led_set_func = symbol_request(tpacpi_led_set);
+		if (!led_set_func) {
+			snd_printk(KERN_WARNING "Failed to find thinkpad-acpi symbol tpacpi_led_set\n");
+			return;
+		}
+
+		removefunc = true;
+		if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
+			spec->vmaster_mute.hook = update_tpacpi_mute_led;
+			removefunc = false;
+		}
+		if (led_set_func(TPACPI_LED_MICMUTE, false) >= 0) {
+			if (spec->num_adc_nids > 1)
+				snd_printdd("Skipping micmute LED control due to several ADCs");
+			else {
+				spec->cap_sync_hook = update_tpacpi_micmute_led;
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
+#else /* CONFIG_THINKPAD_ACPI */
+
+static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+}
+
+#endif /* CONFIG_THINKPAD_ACPI */
-- 
1.8.5.2
