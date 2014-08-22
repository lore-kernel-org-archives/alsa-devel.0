From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] sound: pci: ca0132_regs.h: Fix typo in include guard
Date: Fri, 22 Aug 2014 11:22:09 +0200
Message-ID: <1408699329-7218-1-git-send-email-linux@rasmusvillemoes.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 sound/pci/hda/ca0132_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/ca0132_regs.h b/sound/pci/hda/ca0132_regs.h
index 07e7609..8371274 100644
--- a/sound/pci/hda/ca0132_regs.h
+++ b/sound/pci/hda/ca0132_regs.h
@@ -20,7 +20,7 @@
  */
 
 #ifndef __CA0132_REGS_H
-#define __CA0312_REGS_H
+#define __CA0132_REGS_H
 
 #define DSP_CHIP_OFFSET                0x100000
 #define DSP_DBGCNTL_MODULE_OFFSET      0xE30
-- 
1.9.2
