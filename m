From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH] ALSA nvhdmi: Add missing codec IDs
Date: Fri, 10 Sep 2010 10:59:13 -0600
Message-ID: <1284137953-28711-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 71AC51037F2
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 18:59:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: stable@kernel.org
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Adds codec IDs for various other NVIDIA GPUs to the NVIDIA HDMI audio
driver.

This is a backport of 9cf2657d05f9f9e04c3e113d68bf7cef5a942070
suitable for inclusion into 2.6.34 and 2.6.35.

... but subset so that it solely adds new IDs, and doesn't reformat
nor rename any existing IDs.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/pci/hda/patch_nvhdmi.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/patch_nvhdmi.c b/sound/pci/hda/patch_nvhdmi.c
index b0652ac..dccfcf4 100644
--- a/sound/pci/hda/patch_nvhdmi.c
+++ b/sound/pci/hda/patch_nvhdmi.c
@@ -559,6 +559,21 @@ static struct hda_codec_preset snd_hda_preset_nvhdmi[] = {
 	  .patch = patch_nvhdmi_8ch_89 },
 	{ .id = 0x10de000d, .name = "GT240 HDMI",
 	  .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0010, .name = "GPU 10 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0011, .name = "GPU 11 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0012, .name = "GPU 12 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0013, .name = "GPU 13 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0014, .name = "GPU 14 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0018, .name = "GPU 18 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0019, .name = "GPU 19 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de001a, .name = "GPU 1a HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de001b, .name = "GPU 1b HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de001c, .name = "GPU 1c HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0040, .name = "GPU 40 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0041, .name = "GPU 41 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0042, .name = "GPU 42 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0043, .name = "GPU 43 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
+	{ .id = 0x10de0044, .name = "GPU 44 HDMI/DP", .patch = patch_nvhdmi_8ch_89 },
 	{ .id = 0x10de0067, .name = "MCP67 HDMI", .patch = patch_nvhdmi_2ch },
 	{ .id = 0x10de8001, .name = "MCP73 HDMI", .patch = patch_nvhdmi_2ch },
 	{} /* terminator */
@@ -573,6 +588,21 @@ MODULE_ALIAS("snd-hda-codec-id:10de000a");
 MODULE_ALIAS("snd-hda-codec-id:10de000b");
 MODULE_ALIAS("snd-hda-codec-id:10de000c");
 MODULE_ALIAS("snd-hda-codec-id:10de000d");
+MODULE_ALIAS("snd-hda-codec-id:10de0010");
+MODULE_ALIAS("snd-hda-codec-id:10de0011");
+MODULE_ALIAS("snd-hda-codec-id:10de0012");
+MODULE_ALIAS("snd-hda-codec-id:10de0013");
+MODULE_ALIAS("snd-hda-codec-id:10de0014");
+MODULE_ALIAS("snd-hda-codec-id:10de0018");
+MODULE_ALIAS("snd-hda-codec-id:10de0019");
+MODULE_ALIAS("snd-hda-codec-id:10de001a");
+MODULE_ALIAS("snd-hda-codec-id:10de001b");
+MODULE_ALIAS("snd-hda-codec-id:10de001c");
+MODULE_ALIAS("snd-hda-codec-id:10de0040");
+MODULE_ALIAS("snd-hda-codec-id:10de0041");
+MODULE_ALIAS("snd-hda-codec-id:10de0042");
+MODULE_ALIAS("snd-hda-codec-id:10de0043");
+MODULE_ALIAS("snd-hda-codec-id:10de0044");
 MODULE_ALIAS("snd-hda-codec-id:10de0067");
 MODULE_ALIAS("snd-hda-codec-id:10de8001");
 
-- 
1.6.0.6
nvpublic
