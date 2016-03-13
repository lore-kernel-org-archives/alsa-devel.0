From: Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] ALSA: hda - Add new GPU codec ID 0x10de0082 to snd-hda
Date: Sun, 13 Mar 2016 13:58:57 -0700
Message-ID: <1457902737-8680-1-git-send-email-aplattner@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Aaron Plattner <aplattner@nvidia.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Vendor ID 0x10de0082 is used by a yet-to-be-named GPU chip.

This chip also has the 2-ch audio swapping bug, so patch_nvhdmi is
appropriate here.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
Another day, another new chip with the same stupid bug.  The hardware folks
still claim they're going to fix it someday.

 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index bcbc4ee10130..651a9ee494db 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3659,6 +3659,7 @@ HDA_CODEC_ENTRY(0x10de0070, "GPU 70 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0071, "GPU 71 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0072, "GPU 72 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de007d, "GPU 7d HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de0082, "GPU 82 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de0083, "GPU 83 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),
-- 
2.7.3
