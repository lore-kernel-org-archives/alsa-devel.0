From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda - add Intel Panther Point HDMI codec id
Date: Fri, 20 May 2011 15:35:43 +0800
Message-ID: <20110520073543.GA14685@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 25391103824
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 09:35:47 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_hdmi.c |    2 ++
 1 file changed, 2 insertions(+)

--- sound-2.6.orig/sound/pci/hda/patch_hdmi.c	2011-05-20 14:29:50.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_hdmi.c	2011-05-20 14:31:23.000000000 +0800
@@ -1659,6 +1659,7 @@ static struct hda_codec_preset snd_hda_p
 { .id = 0x80862803, .name = "Eaglelake HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862804, .name = "IbexPeak HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862805, .name = "CougarPoint HDMI",	.patch = patch_generic_hdmi },
+{ .id = 0x80862806, .name = "PantherPoint HDMI", .patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
 {} /* terminator */
 };
@@ -1704,6 +1705,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862802"
 MODULE_ALIAS("snd-hda-codec-id:80862803");
 MODULE_ALIAS("snd-hda-codec-id:80862804");
 MODULE_ALIAS("snd-hda-codec-id:80862805");
+MODULE_ALIAS("snd-hda-codec-id:80862806");
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
 
 MODULE_LICENSE("GPL");
