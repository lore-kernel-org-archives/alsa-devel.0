From: Wang Xingchao <xingchao.wang@linux.intel.com>
Subject: [PATCH 3/3] ALSA: hda - use azx_writew() for 16-bit
	length register
Date: Mon, 22 Jul 2013 03:19:18 -0400
Message-ID: <1374477558-14074-3-git-send-email-xingchao.wang@linux.intel.com>
References: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A2CF261737
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 08:43:54 +0200 (CEST)
In-Reply-To: <1374477558-14074-1-git-send-email-xingchao.wang@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de, david.henningsson@canonical.com
Cc: Wang Xingchao <xingchao.wang@linux.intel.com>, xingchao.wang@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Register STATESTS is 16-bit length, use correct API for read/write.

Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a7ac7fd..c6f7c19 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1160,7 +1160,7 @@ static int azx_reset(struct azx *chip, int full_reset)
 		goto __skip;
 
 	/* clear STATESTS */
-	azx_writeb(chip, STATESTS, STATESTS_INT_MASK);
+	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
 
 	/* reset controller */
 	azx_enter_link_reset(chip);
@@ -1242,7 +1242,7 @@ static void azx_int_clear(struct azx *chip)
 	}
 
 	/* clear STATESTS */
-	azx_writeb(chip, STATESTS, STATESTS_INT_MASK);
+	azx_writew(chip, STATESTS, STATESTS_INT_MASK);
 
 	/* clear rirb status */
 	azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
@@ -1451,8 +1451,8 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 
 #if 0
 	/* clear state status int */
-	if (azx_readb(chip, STATESTS) & 0x04)
-		azx_writeb(chip, STATESTS, 0x04);
+	if (azx_readw(chip, STATESTS) & 0x04)
+		azx_writew(chip, STATESTS, 0x04);
 #endif
 	spin_unlock(&chip->reg_lock);
 	
-- 
1.8.3.2
