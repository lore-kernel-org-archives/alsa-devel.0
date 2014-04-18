From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCHv4 1/2] ALSA: hda/hdmi - Add Nvidia Tegra124
	HDMI support
Date: Fri, 18 Apr 2014 14:43:49 -0700
Message-ID: <1397857429-8984-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f74.google.com (mail-qa0-f74.google.com
 [209.85.216.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F93A2619D0
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 23:44:09 +0200 (CEST)
Received: by mail-qa0-f74.google.com with SMTP id w8so356707qac.1
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 14:44:08 -0700 (PDT)
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
Cc: tiwai@suse.de, Sumit Bhattacharya <sumitb@nvidia.com>, Dylan Reid <dgreid@chromium.org>, thierry.reding@gmail.com, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

From: Sumit Bhattacharya <sumitb@nvidia.com>

Add the Tegra 12x HDMI controller id to patch_hdmi.

Signed-off-by: Sumit Bhattacharya <sumitb@nvidia.com>
Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
No changes since v1.
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0cb5b89..b5d1371 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3322,6 +3322,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x10de001a, .name = "GPU 1a HDMI/DP",	.patch = patch_nvhdmi },
 { .id = 0x10de001b, .name = "GPU 1b HDMI/DP",	.patch = patch_nvhdmi },
 { .id = 0x10de001c, .name = "GPU 1c HDMI/DP",	.patch = patch_nvhdmi },
+{ .id = 0x10de0028, .name = "Tegra12x HDMI",	.patch = patch_nvhdmi },
 { .id = 0x10de0040, .name = "GPU 40 HDMI/DP",	.patch = patch_nvhdmi },
 { .id = 0x10de0041, .name = "GPU 41 HDMI/DP",	.patch = patch_nvhdmi },
 { .id = 0x10de0042, .name = "GPU 42 HDMI/DP",	.patch = patch_nvhdmi },
@@ -3377,6 +3378,7 @@ MODULE_ALIAS("snd-hda-codec-id:10de0019");
 MODULE_ALIAS("snd-hda-codec-id:10de001a");
 MODULE_ALIAS("snd-hda-codec-id:10de001b");
 MODULE_ALIAS("snd-hda-codec-id:10de001c");
+MODULE_ALIAS("snd-hda-codec-id:10de0028");
 MODULE_ALIAS("snd-hda-codec-id:10de0040");
 MODULE_ALIAS("snd-hda-codec-id:10de0041");
 MODULE_ALIAS("snd-hda-codec-id:10de0042");
-- 
1.8.1.3.605.g02339dd
