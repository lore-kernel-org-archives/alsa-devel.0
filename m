From: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
Subject: [PATCH] sound: oss: sb_common: Used kmemdup instead of kmalloc and memcpy
Date: Mon, 25 Mar 2013 15:50:34 +0200
Message-ID: <1364219434-11920-1-git-send-email-gheorghiuandru@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Alexandru Gheorghiu <gheorghiuandru@gmail.com>
List-Id: alsa-devel@alsa-project.org

Used kmemdup instead of replicating it's behaviour with kmalloc followed
by memcpy.
Patch found using coccinelle.

Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
---
 sound/oss/sb_common.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/oss/sb_common.c b/sound/oss/sb_common.c
index 7d42c54..851a1da 100644
--- a/sound/oss/sb_common.c
+++ b/sound/oss/sb_common.c
@@ -626,13 +626,12 @@ int sb_dsp_detect(struct address_info *hw_config, int pci, int pciio, struct sb_
 	 */
 
 
-	detected_devc = kmalloc(sizeof(sb_devc), GFP_KERNEL);
+	detected_devc = kmemdup(devc, sizeof(sb_devc), GFP_KERNEL);
 	if (detected_devc == NULL)
 	{
 		printk(KERN_ERR "sb: Can't allocate memory for device information\n");
 		return 0;
 	}
-	memcpy(detected_devc, devc, sizeof(sb_devc));
 	MDB(printk(KERN_INFO "SB %d.%02d detected OK (%x)\n", devc->major, devc->minor, hw_config->io_base));
 	return 1;
 }
-- 
1.7.9.5
