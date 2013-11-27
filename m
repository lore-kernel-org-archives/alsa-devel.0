From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH] ALSA: hda - Enable mute/mic-mute LEDs for more
	Thinkpads with Conexant codec
Date: Wed, 27 Nov 2013 11:26:52 +0800
Message-ID: <1385522812-29678-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id A08652619F1
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 04:29:21 +0100 (CET)
Received: by mail-pd0-f169.google.com with SMTP id v10so9071412pde.0
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 19:29:20 -0800 (PST)
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
Cc: hui.wang@canonical.com, alex.hung@canonical.com, yk@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Most Thinkpad Edge series laptops use conexant codec, so far although
the codecs have different minor Vendor Id and minor Subsystem Id, but
they all belong to the cxt_5066 family, this change can make the
mute/mic-mute LEDs support more generic among cxt_5066 family.

Cc: Alex Hung <alex.hung@canonical.com>
Cc: David Henningsson <david.henningsson@canonical.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/hda_local.h      | 22 ++++++++++++++++++++++
 sound/pci/hda/patch_conexant.c |  3 +++
 sound/pci/hda/patch_realtek.c  | 20 --------------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index d398b64..1155958 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -777,4 +777,26 @@ void snd_hdmi_write_eld_info(struct hdmi_eld *eld,
 #define SND_PRINT_CHANNEL_ALLOCATION_ADVISED_BUFSIZE 80
 void snd_print_channel_allocation(int spk_alloc, char *buf, int buflen);
 
+#if IS_ENABLED(CONFIG_THINKPAD_ACPI)
+#include <acpi/acpi.h>
+
+static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
+				 void **rv)
+{
+	bool *found = context;
+	*found = true;
+	return AE_OK;
+}
+
+static inline bool is_thinkpad(struct hda_codec *codec)
+{
+	bool found = false;
+	if (codec->subsystem_id >> 16 != 0x17aa)
+		return false;
+	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
+		return true;
+	found = false;
+	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
+}
+#endif
 #endif /* __SOUND_HDA_LOCAL_H */
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index c205bb1..8063ae9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3279,6 +3279,8 @@ static void cxt_fixup_thinkpad_acpi(struct hda_codec *codec,
 	bool removefunc = false;
 
 	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!is_thinkpad(codec))
+			return;
 		if (!led_set_func)
 			led_set_func = symbol_request(tpacpi_led_set);
 		if (!led_set_func) {
@@ -3494,6 +3496,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	{}
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5e42059..bedf35f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3673,29 +3673,9 @@ static void alc290_fixup_mono_speakers(struct hda_codec *codec,
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 
 #include <linux/thinkpad_acpi.h>
-#include <acpi/acpi.h>
 
 static int (*led_set_func)(int, bool);
 
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
 static void update_tpacpi_mute_led(void *private_data, int enabled)
 {
 	if (led_set_func)
-- 
1.8.1.2
