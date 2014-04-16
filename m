From: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCHv3 1/2] ALSA: hda/hdmi - Add Nvidia Tegra124 HDMI support
Date: Wed, 16 Apr 2014 14:39:31 -0700
Message-ID: <1397684372-1639-1-git-send-email-dgreid@chromium.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: tiwai-l3A5Bk7waGM@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Sumit Bhattacharya <sumitb-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Sumit Bhattacharya <sumitb-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add the Tegra 12x HDMI controller id to patch_hdmi.

Signed-off-by: Sumit Bhattacharya <sumitb-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Signed-off-by: Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
