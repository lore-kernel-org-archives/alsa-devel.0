From: Aaron Plattner <aplattner@nvidia.com>
Subject: [PATCH] ALSA: hda - Add new GPU codec ID 0x10de0072 to
	snd-hda
Date: Tue, 6 Jan 2015 13:40:14 -0800
Message-ID: <1420580414-2662-1-git-send-email-aplattner@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 by alsa0.perex.cz (Postfix) with ESMTP id F31002612D0
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 22:40:32 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Vendor ID 0x10de0072 is used by a yet-to-be-named GPU chip.

Signed-off-by: Aaron Plattner <aplattner@nvidia.com>
---
Do you think it would make sense to add some kind of wildcard match for
0x10de* -> patch_nvhdmi?

 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 5f13d2d18079..b422e406a9cb 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3353,6 +3353,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x10de0067, .name = "MCP67 HDMI",	.patch = patch_nvhdmi_2ch },
 { .id = 0x10de0070, .name = "GPU 70 HDMI/DP",	.patch = patch_nvhdmi },
 { .id = 0x10de0071, .name = "GPU 71 HDMI/DP",	.patch = patch_nvhdmi },
+{ .id = 0x10de0072, .name = "GPU 72 HDMI/DP",	.patch = patch_nvhdmi },
 { .id = 0x10de8001, .name = "MCP73 HDMI",	.patch = patch_nvhdmi_2ch },
 { .id = 0x11069f80, .name = "VX900 HDMI/DP",	.patch = patch_via_hdmi },
 { .id = 0x11069f81, .name = "VX900 HDMI/DP",	.patch = patch_via_hdmi },
@@ -3413,6 +3414,7 @@ MODULE_ALIAS("snd-hda-codec-id:10de0060");
 MODULE_ALIAS("snd-hda-codec-id:10de0067");
 MODULE_ALIAS("snd-hda-codec-id:10de0070");
 MODULE_ALIAS("snd-hda-codec-id:10de0071");
+MODULE_ALIAS("snd-hda-codec-id:10de0072");
 MODULE_ALIAS("snd-hda-codec-id:10de8001");
 MODULE_ALIAS("snd-hda-codec-id:11069f80");
 MODULE_ALIAS("snd-hda-codec-id:11069f81");
-- 
2.2.1
