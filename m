From: mengdong.lin@intel.com
Subject: [PATCH 2/3] ALSA: hda - add codec ID for Broadwell
	display audio codec
Date: Wed,  8 Jan 2014 15:55:24 -0500
Message-ID: <c50bd159d82a7d0910f2130cf88a71496755f33f.1389214150.git.mengdong.lin@intel.com>
References: <cover.1389214150.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BAC8F265205
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 04:50:52 +0100 (CET)
In-Reply-To: <cover.1389214150.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This patch adds codec ID (0x80862808) and module alias for Broadwell
display codec.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 59b83f4..670da3e 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3273,6 +3273,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x80862805, .name = "CougarPoint HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862806, .name = "PantherPoint HDMI", .patch = patch_generic_hdmi },
 { .id = 0x80862807, .name = "Haswell HDMI",	.patch = patch_generic_hdmi },
+{ .id = 0x80862808, .name = "Broadwell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862880, .name = "CedarTrail HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862882, .name = "Valleyview2 HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
@@ -3328,6 +3329,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862804");
 MODULE_ALIAS("snd-hda-codec-id:80862805");
 MODULE_ALIAS("snd-hda-codec-id:80862806");
 MODULE_ALIAS("snd-hda-codec-id:80862807");
+MODULE_ALIAS("snd-hda-codec-id:80862808");
 MODULE_ALIAS("snd-hda-codec-id:80862880");
 MODULE_ALIAS("snd-hda-codec-id:80862882");
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
-- 
1.8.1.2
