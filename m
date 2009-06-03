From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] burgundy: timeout message is off by one.
Date: Thu, 04 Jun 2009 01:53:21 +0200
Message-ID: <4A270CF1.4030902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E3691038C3
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 23:53:14 +0200 (CEST)
Received: by bwz11 with SMTP id 11so331440bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 03 Jun 2009 14:53:14 -0700 (PDT)
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

Timeout message is off by one.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/ppc/burgundy.c b/sound/ppc/burgundy.c
index 45a7629..d2c0a4e 100644
--- a/sound/ppc/burgundy.c
+++ b/sound/ppc/burgundy.c
@@ -46,12 +46,12 @@ snd_pmac_burgundy_extend_wait(struct snd_pmac *chip)
 	timeout = 50;
 	while (!(in_le32(&chip->awacs->codec_stat) & MASK_EXTEND) && timeout--)
 		udelay(1);
-	if (! timeout)
+	if (timeout < 0)
 		printk(KERN_DEBUG "burgundy_extend_wait: timeout #1\n");
 	timeout = 50;
 	while ((in_le32(&chip->awacs->codec_stat) & MASK_EXTEND) && timeout--)
 		udelay(1);
-	if (! timeout)
+	if (timeout < 0)
 		printk(KERN_DEBUG "burgundy_extend_wait: timeout #2\n");
 }
