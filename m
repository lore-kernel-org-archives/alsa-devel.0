From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add missing terminating entry to SND_HDA_PIN_QUIRK macro
Date: Fri, 24 Oct 2014 10:00:38 +0200
Message-ID: <1414137638-8678-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Without this terminating entry, the pin matching would continue
across random memory until a zero or a non-matching entry was found.

The result being that in some cases, the pin quirk would not be
applied correctly.

Cc: stable@vger.kernel.org
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_local.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index 7eb44e7..62658f2 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -419,7 +419,7 @@ struct snd_hda_pin_quirk {
 	  .subvendor = _subvendor,\
 	  .name = _name,\
 	  .value = _value,\
-	  .pins = (const struct hda_pintbl[]) { _pins } \
+	  .pins = (const struct hda_pintbl[]) { _pins, {0, 0}} \
 	}
 #else
 
@@ -427,7 +427,7 @@ struct snd_hda_pin_quirk {
 	{ .codec = _codec,\
 	  .subvendor = _subvendor,\
 	  .value = _value,\
-	  .pins = (const struct hda_pintbl[]) { _pins } \
+	  .pins = (const struct hda_pintbl[]) { _pins, {0, 0}} \
 	}
 
 #endif
-- 
1.9.1
