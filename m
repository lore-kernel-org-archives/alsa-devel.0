From: Wang Xingchao <xingchao.wang@intel.com>
Subject: [PATCH] ALSA: hda - add Haswell HDMI pci id
Date: Wed, 13 Jun 2012 10:23:52 +0800
Message-ID: <1339554232-3410-2-git-send-email-xingchao.wang@intel.com>
References: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A1B4104417
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jun 2012 04:28:18 +0200 (CEST)
In-Reply-To: <1339554232-3410-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, fengguang.wu@intel.com, xingchao.wang@intel.com
List-Id: alsa-devel@alsa-project.org

0x80862807 is HDMI id for Haswell HDA.

Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
---
 sound/pci/hda/patch_hdmi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ad319d4..1e94086 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1911,6 +1911,7 @@ static const struct hda_codec_preset snd_hda_preset_hdmi[] = {
 { .id = 0x80862804, .name = "IbexPeak HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862805, .name = "CougarPoint HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862806, .name = "PantherPoint HDMI", .patch = patch_generic_hdmi },
+{ .id = 0x80862807, .name = "Haswell HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862880, .name = "CedarTrail HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
 {} /* terminator */
@@ -1958,6 +1959,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862803");
 MODULE_ALIAS("snd-hda-codec-id:80862804");
 MODULE_ALIAS("snd-hda-codec-id:80862805");
 MODULE_ALIAS("snd-hda-codec-id:80862806");
+MODULE_ALIAS("snd-hda-codec-id:80862807");
 MODULE_ALIAS("snd-hda-codec-id:80862880");
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
 
-- 
1.7.9.5
