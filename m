From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda - add id for Atom Cedar Trail HDMI codec
Date: Thu, 23 Feb 2012 15:07:44 +0800
Message-ID: <20120223070744.GA5505@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 797692412D
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 08:07:51 +0100 (CET)
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

--- sound.orig/sound/pci/hda/patch_hdmi.c	2012-02-23 14:51:19.562540743 +0800
+++ sound/sound/pci/hda/patch_hdmi.c	2012-02-23 15:05:51.774522844 +0800
@@ -1913,6 +1913,7 @@ static const struct hda_codec_preset snd
 { .id = 0x80862805, .name = "CougarPoint HDMI",	.patch = patch_generic_hdmi },
 { .id = 0x80862806, .name = "PantherPoint HDMI", .patch = patch_generic_hdmi },
 { .id = 0x808629fb, .name = "Crestline HDMI",	.patch = patch_generic_hdmi },
+{ .id = 0x80862880, .name = "CedarTrail HDMI",	.patch = patch_generic_hdmi },
 {} /* terminator */
 };
 
@@ -1959,6 +1960,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862804"
 MODULE_ALIAS("snd-hda-codec-id:80862805");
 MODULE_ALIAS("snd-hda-codec-id:80862806");
 MODULE_ALIAS("snd-hda-codec-id:808629fb");
+MODULE_ALIAS("snd-hda-codec-id:80862880");
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("HDMI HD-audio codec");
