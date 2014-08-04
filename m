From: libin.yang@intel.com
Subject: [PATCH 2/2] ALSA: hda - add codec ID for Braswell
	display audio codec
Date: Mon,  4 Aug 2014 09:22:45 +0800
Message-ID: <1407115365-115321-2-git-send-email-libin.yang@intel.com>
References: <1407115365-115321-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A268265309
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 03:25:18 +0200 (CEST)
In-Reply-To: <1407115365-115321-1-git-send-email-libin.yang@intel.com>
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
Cc: Libin Yang <libin.yang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

This patch adds codec ID (0x80862883) and module alias for Braswell
display codec.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/patch_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a21090b..36badba 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -3356,6 +3356,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x80862808, .name = "Broadwell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862880, .name = "CedarTrail HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862882, .name = "Valleyview2 HDMI",	.patch = patch_generic_hdmi },
+{ .id = 0x80862883, .name = "Braswell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
 {} /* terminator */
 };
@@ -3415,6 +3416,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862807");
 MODULE_ALIAS("snd-hda-codec-id:80862808");
 MODULE_ALIAS("snd-hda-codec-id:80862880");
 MODULE_ALIAS("snd-hda-codec-id:80862882");
+MODULE_ALIAS("snd-hda-codec-id:80862883");
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
 
 MODULE_LICENSE("GPL");
-- 
1.9.1
