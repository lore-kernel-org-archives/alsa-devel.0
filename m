From: Mihai Burduselu <michelcatalin@gmail.com>
Subject: [PATCH] ALSA: vx: remove 'out of memory' message
Date: Sun, 26 Feb 2017 01:30:38 +0200
Message-ID: <20170225233038.5681-1-michelcatalin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id ECDFC266B0F
 for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2017 00:31:09 +0100 (CET)
Received: by mail-wm0-f66.google.com with SMTP id u63so8138512wmu.2
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 15:31:09 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: michelcatalin@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Reported by checkpatch.pl
Signed-off-by: Mihai Burduselu <michelcatalin@gmail.com>
---
 sound/drivers/vx/vx_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index 289f041706cd..f684fffd1397 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -795,10 +795,8 @@ struct vx_core *snd_vx_create(struct snd_card *card, struct snd_vx_hardware *hw,
 		return NULL;
 
 	chip = kzalloc(sizeof(*chip) + extra_size, GFP_KERNEL);
-	if (! chip) {
-		snd_printk(KERN_ERR "vx_core: no memory\n");
+	if (! chip)
 		return NULL;
-	}
 	mutex_init(&chip->lock);
 	chip->irq = -1;
 	chip->hw = hw;
-- 
2.11.0
