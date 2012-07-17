From: Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] ALSA: hda - Add new GPU codec ID to snd-hda
Date: Mon, 16 Jul 2012 17:10:04 -0700
Message-ID: <1342483804-10888-1-git-send-email-aplattner@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: Aaron Plattner <aplattner@nvidia.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Vendor ID 0x10de0051 is used by a yet-to-be-named GPU chip.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
Acked-by: Andy Ritger <aritger@nvidia.com>
Reviewed-by: Daniel Dadap <ddadap@nvidia.com>
---
 sound/pci/hda/patch_hdmi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ad319d4..4efe741 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1902,6 +1902,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x10de0042, .name = "GPU 42 HDMI/DP",	.patch = patch_generic_hdmi },
 { .id = 0x10de0043, .name = "GPU 43 HDMI/DP",	.patch = patch_generic_hdmi },
 { .id = 0x10de0044, .name = "GPU 44 HDMI/DP",	.patch = patch_generic_hdmi },
+{ .id = 0x10de0051, .name = "GPU 51 HDMI/DP",	.patch = patch_generic_hdmi },
 { .id = 0x10de0067, .name = "MCP67 HDMI",	.patch = patch_nvhdmi_2ch },
 { .id = 0x10de8001, .name = "MCP73 HDMI",	.patch = patch_nvhdmi_2ch },
 { .id = 0x80860054, .name = "IbexPeak HDMI",	.patch = patch_generic_hdmi },
@@ -1948,6 +1949,7 @@ MODULE_ALIAS("snd-hda-codec-id:10de0041");
 MODULE_ALIAS("snd-hda-codec-id:10de0042");
 MODULE_ALIAS("snd-hda-codec-id:10de0043");
 MODULE_ALIAS("snd-hda-codec-id:10de0044");
+MODULE_ALIAS("snd-hda-codec-id:10de0051");
 MODULE_ALIAS("snd-hda-codec-id:10de0067");
 MODULE_ALIAS("snd-hda-codec-id:10de8001");
 MODULE_ALIAS("snd-hda-codec-id:17e80047");
-- 
1.7.9.5
