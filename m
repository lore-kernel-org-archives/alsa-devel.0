From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda - add codec ID for Broxton display
	audio codec
Date: Mon,  6 Jul 2015 10:44:26 +0800
Message-ID: <1436150666-106766-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6830F2604ED
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 04:53:46 +0200 (CEST)
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
Cc: Libin Yang <libin.yang@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch adds codec ID (0x8086280a) and module alias for Broxton
display codec.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 2f24338..9515891 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3527,6 +3527,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x80862807, .name = "Haswell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862808, .name = "Broadwell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862809, .name = "Skylake HDMI",	.patch = patch_generic_hdmi },
+{ .id = 0x8086280a, .name = "Broxton HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862880, .name = "CedarTrail HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862882, .name = "Valleyview2 HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862883, .name = "Braswell HDMI",	.patch = patch_generic_hdmi },
@@ -3591,6 +3592,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862806");
 MODULE_ALIAS("snd-hda-codec-id:80862807");
 MODULE_ALIAS("snd-hda-codec-id:80862808");
 MODULE_ALIAS("snd-hda-codec-id:80862809");
+MODULE_ALIAS("snd-hda-codec-id:8086280a");
 MODULE_ALIAS("snd-hda-codec-id:80862880");
 MODULE_ALIAS("snd-hda-codec-id:80862882");
 MODULE_ALIAS("snd-hda-codec-id:80862883");
-- 
1.9.1
