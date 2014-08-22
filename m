From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] sound: pci: ct20k1reg: Fix typo in include guard
Date: Fri, 22 Aug 2014 11:23:09 +0200
Message-ID: <1408699389-7272-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 sound/pci/ctxfi/ct20k1reg.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/pci/ctxfi/ct20k1reg.h b/sound/pci/ctxfi/ct20k1reg.h
index f2e34e3..5851249 100644
--- a/sound/pci/ctxfi/ct20k1reg.h
+++ b/sound/pci/ctxfi/ct20k1reg.h
@@ -7,7 +7,7 @@
  */
 
 #ifndef CT20K1REG_H
-#define CT20k1REG_H
+#define CT20K1REG_H
 
 /* 20k1 registers */
 #define 	DSPXRAM_START 			0x000000
@@ -632,5 +632,3 @@
 #define I2SD_R    0x19L
 
 #endif /* CT20K1REG_H */
-
-
-- 
1.9.2
