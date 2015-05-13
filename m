From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Add Conexant codecs CX20721, CX20722, CX20723 and CX20724
Date: Wed, 13 May 2015 13:28:54 +0200
Message-ID: <1431516534-7861-1-git-send-email-david.henningsson@canonical.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: 1454656@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for Conexant HD Audio codecs
CX20721, CX20722, CX20723 and CX20724.

Cc: stable@vger.kernel.org
BugLink: https://bugs.launchpad.net/bugs/1454656
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index f8f0dfb..78b719b 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -968,6 +968,14 @@ static const struct hda_codec_preset snd_hda_preset_conexant[] = {
 	  .patch = patch_conexant_auto },
 	{ .id = 0x14f150b9, .name = "CX20665",
 	  .patch = patch_conexant_auto },
+	{ .id = 0x14f150f1, .name = "CX20721",
+	  .patch = patch_conexant_auto },
+	{ .id = 0x14f150f2, .name = "CX20722",
+	  .patch = patch_conexant_auto },
+	{ .id = 0x14f150f3, .name = "CX20723",
+	  .patch = patch_conexant_auto },
+	{ .id = 0x14f150f4, .name = "CX20724",
+	  .patch = patch_conexant_auto },
 	{ .id = 0x14f1510f, .name = "CX20751/2",
 	  .patch = patch_conexant_auto },
 	{ .id = 0x14f15110, .name = "CX20751/2",
@@ -1002,6 +1010,10 @@ MODULE_ALIAS("snd-hda-codec-id:14f150ab");
 MODULE_ALIAS("snd-hda-codec-id:14f150ac");
 MODULE_ALIAS("snd-hda-codec-id:14f150b8");
 MODULE_ALIAS("snd-hda-codec-id:14f150b9");
+MODULE_ALIAS("snd-hda-codec-id:14f150f1");
+MODULE_ALIAS("snd-hda-codec-id:14f150f2");
+MODULE_ALIAS("snd-hda-codec-id:14f150f3");
+MODULE_ALIAS("snd-hda-codec-id:14f150f4");
 MODULE_ALIAS("snd-hda-codec-id:14f1510f");
 MODULE_ALIAS("snd-hda-codec-id:14f15110");
 MODULE_ALIAS("snd-hda-codec-id:14f15111");
-- 
1.9.1
