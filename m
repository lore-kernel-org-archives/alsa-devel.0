From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v3 4/5] sound: pci: ctxfi: cthw20k2.c: sparse warning of incorrect type
Date: Sun, 21 Sep 2014 21:33:40 +0530
Message-ID: <1411315421-24138-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1411315421-24138-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411315421-24138-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

fixed sparse warning of incorrect type (different address spaces)

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 sound/pci/ctxfi/cthw20k2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 665eeb2..25ef60b 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -2112,7 +2112,7 @@ static int hw_card_shutdown(struct hw *hw)
 	hw->irq	= -1;
 
 	if (hw->mem_base)
-		iounmap((void *)hw->mem_base);
+		iounmap((void __iomem *)hw->mem_base);
 
 	hw->mem_base = (unsigned long)NULL;
 
@@ -2234,12 +2234,12 @@ static int hw_resume(struct hw *hw, struct card_conf *info)
 
 static u32 hw_read_20kx(struct hw *hw, u32 reg)
 {
-	return readl((void *)(hw->mem_base + reg));
+	return readl((void __iomem *)(hw->mem_base + reg));
 }
 
 static void hw_write_20kx(struct hw *hw, u32 reg, u32 data)
 {
-	writel(data, (void *)(hw->mem_base + reg));
+	writel(data, (void __iomem *)(hw->mem_base + reg));
 }
 
 static struct hw ct20k2_preset = {
-- 
1.8.1.2
