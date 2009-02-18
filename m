From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OSS: missing parentheses?
Date: Wed, 18 Feb 2009 10:15:00 +0100
Message-ID: <499BD194.4070707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.189])
	by alsa0.perex.cz (Postfix) with ESMTP id D97C4243AD
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 10:15:01 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id 26so1834890fkx.0
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 01:15:01 -0800 (PST)
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

Please review.
--------------------------->8-------------8<------------------------------
Add missing parentheses

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/oss/pas2_card.c b/sound/oss/pas2_card.c
index 25f3a22..7f377ec 100644
--- a/sound/oss/pas2_card.c
+++ b/sound/oss/pas2_card.c
@@ -156,9 +156,7 @@ static int __init config_pas_hw(struct address_info *hw_config)
 						 * 0x80
 						 */ , 0xB88);
 
-	pas_write(0x80
-		  | joystick?0x40:0
-		  ,0xF388);
+	pas_write(0x80 | (joystick ? 0x40 : 0), 0xF388);
 
 	if (pas_irq < 0 || pas_irq > 15)
 	{
