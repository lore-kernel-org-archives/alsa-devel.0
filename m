From: Hui Wang <jason77.wang@gmail.com>
Subject: [V2 PATCH] ALSA: hda - Enable mute/mic-mute LEDs for
	more Thinkpads with Conexant codec
Date: Wed, 27 Nov 2013 14:47:26 +0800
Message-ID: <1385534846-20829-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id B9E40261AED
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 07:49:56 +0100 (CET)
Received: by mail-pb0-f50.google.com with SMTP id rr13so9744848pbb.37
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 22:49:55 -0800 (PST)
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
the codecs have different minor Vendor Id and minor Subsystem Id,
they all belong to the cxt5066 family, this change can make the
mute/mic-mute LEDs support more generic among cxt_5066 family.

This design refers to the similar solution for the realtek codec
ALC269 family in the patch_realtek.c.

Cc: Alex Hung <alex.hung@canonical.com>
Cc: David Henningsson <david.henningsson@canonical.com>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/patch_conexant.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index c205bb1..1f2717f 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -3244,9 +3244,29 @@ enum {
 #if IS_ENABLED(CONFIG_THINKPAD_ACPI)
 
 #include <linux/thinkpad_acpi.h>
+#include <acpi/acpi.h>
 
 static int (*led_set_func)(int, bool);
 
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
 static void update_tpacpi_mute_led(void *private_data, int enabled)
 {
 	struct hda_codec *codec = private_data;
@@ -3279,6 +3299,8 @@ static void cxt_fixup_thinkpad_acpi(struct hda_codec *codec,
 	bool removefunc = false;
 
 	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!is_thinkpad(codec))
+			return;
 		if (!led_set_func)
 			led_set_func = symbol_request(tpacpi_led_set);
 		if (!led_set_func) {
@@ -3494,6 +3516,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "Lenovo IdeaPad U310", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x397b, "Lenovo S205", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK_VENDOR(0x17aa, "Thinkpad", CXT_FIXUP_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x1c06, 0x2011, "Lemote A1004", CXT_PINCFG_LEMOTE_A1004),
 	SND_PCI_QUIRK(0x1c06, 0x2012, "Lemote A1205", CXT_PINCFG_LEMOTE_A1205),
 	{}
-- 
1.8.1.2
