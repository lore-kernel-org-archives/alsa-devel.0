From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ALSA: off by 1 in snd_emu10k1_wait()
Date: Thu, 16 Apr 2009 23:54:04 +0200
Message-ID: <49E7A8FC.9040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 81F6D103800
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 23:54:03 +0200 (CEST)
Received: by ewy10 with SMTP id 10so668336ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2009 14:54:03 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is this useful? It was in Linus' git tree.
----------------------------->8-----------------8<------------------------------
With `while (count++ < 16384)' count reaches 16385.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 4bfc31d..c1a5aa1 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -490,7 +490,7 @@ void snd_emu10k1_wait(struct snd_emu10k1 *emu, unsigned int wait)
 			if (newtime != curtime)
 				break;
 		}
-		if (count >= 16384)
+		if (count > 16384)
 			break;
 		curtime = newtime;
 	}
