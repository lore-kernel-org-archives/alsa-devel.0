From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ALSA: sparc: Add missing kfree in error path
Date: Fri, 17 Jul 2015 20:33:21 +0200
Message-ID: <1437158001-29890-1-git-send-email-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: alsa-devel@alsa-project.org

If 'of_ioremap' fails, then 'amd' should be freed, otherwise, there is a
memory leak.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/sparc/amd7930.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 1b1a89e..784ceb8 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -956,6 +956,7 @@ static int snd_amd7930_create(struct snd_card *card,
 	if (!amd->regs) {
 		snd_printk(KERN_ERR
 			   "amd7930-%d: Unable to map chip registers.\n", dev);
+		kfree(amd);
 		return -EIO;
 	}
 
-- 
2.1.4
