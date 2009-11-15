From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 02/11] intelhdmi - fix channel mapping slot mask
Date: Sun, 15 Nov 2009 19:32:21 +0800
Message-ID: <20091115114439.548649432@intel.com>
References: <20091115113219.606666087@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 0330624155
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 12:46:13 +0100 (CET)
Content-Disposition: inline; filename=hdmi-channel-mapping-fix.patch
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
Cc: alsa-devel@alsa-project.org, Wu Fengguang <fengguang.wu@intel.com>, Shane W <shane-alsa@csy.ca>, =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_intelhdmi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:14:39.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_intelhdmi.c	2009-11-02 15:14:46.000000000 +0800
@@ -433,7 +433,7 @@ static void hdmi_debug_channel_mapping(s
 		slot = snd_hda_codec_read(codec, nid, 0,
 						AC_VERB_GET_HDMI_CHAN_SLOT, i);
 		printk(KERN_DEBUG "HDMI: ASP channel %d => slot %d\n",
-						slot >> 4, slot & 0x7);
+						slot >> 4, slot & 0xf);
 	}
 #endif
 }
