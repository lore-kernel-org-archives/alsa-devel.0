From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] ALSA: hda - hdmi: Fix missing ELD change event on plug/unplug
Date: Sun, 19 Oct 2014 19:25:19 +0300
Message-ID: <1413735919-2795-1-git-send-email-anssi.hannula@iki.fi>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The ELD ALSA control change event is sent by hdmi_present_sense() when
eld_changed is true.

Currently, it is only true when the ELD buffer contents have been
modified. However, the user-visible ELD controls also change to a
zero-length value and back when eld_valid is unset/set, and no event is
currently sent in such cases (such as when unplugging or replugging a
sink).

Fix the code to always set eld_changed if eld_valid value is changed,
and therefore to always send the change event when the user-visible
value changes.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: David Henningsson <david.henningsson@canonical.com>
Cc: <stable@vger.kernel.org> # 3.9+
---

 sound/pci/hda/patch_hdmi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 39862e98551c..9dc9cf8c90e9 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1583,19 +1583,22 @@ static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 		}
 	}
 
-	if (pin_eld->eld_valid && !eld->eld_valid) {
-		update_eld = true;
+	if (pin_eld->eld_valid != eld->eld_valid)
 		eld_changed = true;
-	}
+
+	if (pin_eld->eld_valid && !eld->eld_valid)
+		update_eld = true;
+
 	if (update_eld) {
 		bool old_eld_valid = pin_eld->eld_valid;
 		pin_eld->eld_valid = eld->eld_valid;
-		eld_changed = pin_eld->eld_size != eld->eld_size ||
+		if (pin_eld->eld_size != eld->eld_size ||
 			      memcmp(pin_eld->eld_buffer, eld->eld_buffer,
-				     eld->eld_size) != 0;
-		if (eld_changed)
+				     eld->eld_size) != 0) {
 			memcpy(pin_eld->eld_buffer, eld->eld_buffer,
 			       eld->eld_size);
+			eld_changed = true;
+		}
 		pin_eld->eld_size = eld->eld_size;
 		pin_eld->info = eld->info;
 
-- 
1.8.4.5
