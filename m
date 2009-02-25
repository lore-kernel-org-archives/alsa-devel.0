From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] snd-powermac: timeout reaches -1
Date: Wed, 25 Feb 2009 13:40:26 +0100
Message-ID: <49A53C3A.7090101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id D96901037FE
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 13:40:27 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 6so1788ywa.2
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 04:40:26 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

If unsuccessful, timeout reaches -1 after the loop.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/ppc/burgundy.c b/sound/ppc/burgundy.c
index f860d39..45a7629 100644
--- a/sound/ppc/burgundy.c
+++ b/sound/ppc/burgundy.c
@@ -35,7 +35,7 @@ snd_pmac_burgundy_busy_wait(struct snd_pmac *chip)
 	int timeout = 50;
 	while ((in_le32(&chip->awacs->codec_ctrl) & MASK_NEWECMD) && timeout--)
 		udelay(1);
-	if (! timeout)
+	if (timeout < 0)
 		printk(KERN_DEBUG "burgundy_busy_wait: timeout\n");
 }
