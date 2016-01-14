From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 1/1] ALSA: hda - Use acpi_dev_present()
Date: Thu, 14 Jan 2016 22:05:03 +0100
Message-ID: <d0a9aefc9315fb3ec6cb3dad1d4260bf16456424.1452790983.git.lukas@wunner.de>
References: <cover.1452790983.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [176.9.242.54]) by alsa0.perex.cz (Postfix) with ESMTP id D860326058E
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 22:06:09 +0100 (CET)
In-Reply-To: <cover.1452790983.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use shiny new acpi_dev_present() and remove all the boilerplate
to search for a particular ACPI device. No functional change.
Cf. 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").

Cc: Hui Wang <hui.wang@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Hui Wang <hui.wang@canonical.com>
---
 sound/pci/hda/thinkpad_helper.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index 0a4ad5f..59ab6ce 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -10,23 +10,10 @@
 static int (*led_set_func)(int, bool);
 static void (*old_vmaster_hook)(void *, int);
 
-static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
-				 void **rv)
-{
-	bool *found = context;
-	*found = true;
-	return AE_OK;
-}
-
 static bool is_thinkpad(struct hda_codec *codec)
 {
-	bool found = false;
-	if (codec->core.subsystem_id >> 16 != 0x17aa)
-		return false;
-	if (ACPI_SUCCESS(acpi_get_devices("LEN0068", acpi_check_cb, &found, NULL)) && found)
-		return true;
-	found = false;
-	return ACPI_SUCCESS(acpi_get_devices("IBM0068", acpi_check_cb, &found, NULL)) && found;
+	return (codec->core.subsystem_id >> 16 == 0x17aa) &&
+	       (acpi_dev_present("LEN0068") || acpi_dev_present("IBM0068"));
 }
 
 static void update_tpacpi_mute_led(void *private_data, int enabled)
-- 
2.1.0
