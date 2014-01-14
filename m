From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Fix endless vmaster hook call in
	thinkpad_helper.c
Date: Tue, 14 Jan 2014 14:59:44 +0100
Message-ID: <1389707984-5450-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A1BE22616FF
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 14:59:44 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 78C57AC35
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 13:59:44 +0000 (UTC)
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

The new vmaster hook, update_tpacpi_mute_led(), calls the original
vmaster hook, but I forgot to save the original hook function but keep
calling the updated one, which of course results in a stupid endless
loop.  Fixed now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/thinkpad_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/thinkpad_helper.c b/sound/pci/hda/thinkpad_helper.c
index 8492b8a3ce47..5799fbc24c28 100644
--- a/sound/pci/hda/thinkpad_helper.c
+++ b/sound/pci/hda/thinkpad_helper.c
@@ -8,6 +8,7 @@
 #include <linux/thinkpad_acpi.h>
 
 static int (*led_set_func)(int, bool);
+static void (*old_vmaster_hook)(void *, int);
 
 static acpi_status acpi_check_cb(acpi_handle handle, u32 lvl, void *context,
 				 void **rv)
@@ -30,11 +31,8 @@ static bool is_thinkpad(struct hda_codec *codec)
 
 static void update_tpacpi_mute_led(void *private_data, int enabled)
 {
-	struct hda_codec *codec = private_data;
-	struct hda_gen_spec *spec = codec->spec;
-
-	if (spec->vmaster_mute.hook)
-		spec->vmaster_mute.hook(private_data, enabled);
+	if (old_vmaster_hook)
+		old_vmaster_hook(private_data, enabled);
 
 	if (led_set_func)
 		led_set_func(TPACPI_LED_MUTE, !enabled);
@@ -70,6 +68,7 @@ static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
 
 		removefunc = true;
 		if (led_set_func(TPACPI_LED_MUTE, false) >= 0) {
+			old_vmaster_hook = spec->vmaster_mute.hook;
 			spec->vmaster_mute.hook = update_tpacpi_mute_led;
 			removefunc = false;
 		}
@@ -86,6 +85,7 @@ static void hda_fixup_thinkpad_acpi(struct hda_codec *codec,
 	if (led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
 		symbol_put(tpacpi_led_set);
 		led_set_func = NULL;
+		old_vmaster_hook = NULL;
 	}
 }
 
-- 
1.8.5.2
