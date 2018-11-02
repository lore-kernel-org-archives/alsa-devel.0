From: Ayman Bagabas <ayman.bagabas@gmail.com>
Subject: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
Date: Fri,  2 Nov 2018 00:11:15 -0400
Message-ID: <20181102041120.7603-4-ayman.bagabas@gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181102041120.7603-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ayman Bagabas <ayman.bagabas@gmail.com>, Kailang Yang <kailang@realtek.com>, Hui Wang <hui.wang@canonical.com>, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some of Huawei laptops come with a LED in the mic mute key. This patch
enables and disable this LED accordingly.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei_wmi.c |  1 +
 include/linux/huawei_wmi.h        |  7 +++++
 sound/pci/hda/huawei_wmi_helper.c | 48 +++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     | 10 +++++++
 4 files changed, 66 insertions(+)
 create mode 100644 include/linux/huawei_wmi.h
 create mode 100644 sound/pci/hda/huawei_wmi_helper.c

diff --git a/drivers/platform/x86/huawei_wmi.c b/drivers/platform/x86/huawei_wmi.c
index 83545217ac19..cc5492571727 100644
--- a/drivers/platform/x86/huawei_wmi.c
+++ b/drivers/platform/x86/huawei_wmi.c
@@ -26,6 +26,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
 #include <linux/wmi.h>
+#include <linux/huawei_wmi.h>
 
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI hotkeys");
diff --git a/include/linux/huawei_wmi.h b/include/linux/huawei_wmi.h
new file mode 100644
index 000000000000..69b656c5029b
--- /dev/null
+++ b/include/linux/huawei_wmi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HUAWEI_WMI_H__
+#define __HUAWEI_WMI_H__
+
+int huawei_wmi_micmute_led_set(bool on);
+
+#endif
diff --git a/sound/pci/hda/huawei_wmi_helper.c b/sound/pci/hda/huawei_wmi_helper.c
new file mode 100644
index 000000000000..77edb658cbf0
--- /dev/null
+++ b/sound/pci/hda/huawei_wmi_helper.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Helper functions for Huawei WMI Mic Mute LED;
+ * to be included from codec driver
+ */
+
+#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
+#include <linux/huawei_wmi.h>
+
+static int (*huawei_wmi_micmute_led_set_func)(bool);
+
+static void update_huawei_wmi_micmute_led(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	huawei_wmi_micmute_led_set_func(spec->micmute_led.led_value);
+}
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	bool removefunc = false;
+
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!huawei_wmi_micmute_led_set_func)
+			huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
+		if (!huawei_wmi_micmute_led_set_func) {
+			codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
+			return;
+		}
+		removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
+			|| (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
+
+	}
+
+	if (huawei_wmi_micmute_led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
+		symbol_put(huawei_wmi_micmute_led_set);
+		huawei_wmi_micmute_led_set_func = NULL;
+	}
+}
+
+#else
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+}
+
+#endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f7a39c7883c..d09457d2a4f3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5374,6 +5374,9 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
+/* for alc_fixup_huawei_micmute_led */
+#include "huawei_wmi_helper.c"
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -5494,6 +5497,7 @@ enum {
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -6348,6 +6352,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_huawei_wmi
+	},
 	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6363,6 +6371,8 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x21, 0x04211020},
 			{ },
 		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED
 	},
 	[ALC295_FIXUP_HP_X360] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.17.2
