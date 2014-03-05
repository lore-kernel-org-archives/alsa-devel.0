From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: emu10k1: Fix possible NULL dereference
Date: Wed,  5 Mar 2014 12:18:24 +0100
Message-ID: <1394018304-23949-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 244F1265953
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 12:18:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The previous dev_err() conversion resulted in a code that may give
NULL dereference in snd_emu10k1_ptr_write().  Since it's a sanity
check, better to be replaced with a debug macro like other places in
this driver.

Fixes: 6f002b02166c ('ALSA: emu10k1: Use standard printk helpers')
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/io.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/sound/pci/emu10k1/io.c b/sound/pci/emu10k1/io.c
index 81c75b4528d9..706b4f0c6806 100644
--- a/sound/pci/emu10k1/io.c
+++ b/sound/pci/emu10k1/io.c
@@ -71,11 +71,8 @@ void snd_emu10k1_ptr_write(struct snd_emu10k1 *emu, unsigned int reg, unsigned i
 	unsigned long flags;
 	unsigned int mask;
 
-	if (!emu) {
-		dev_err(emu->card->dev, "ptr_write: emu is null!\n");
-		dump_stack();
+	if (snd_BUG_ON(!emu))
 		return;
-	}
 	mask = emu->audigy ? A_PTR_ADDRESS_MASK : PTR_ADDRESS_MASK;
 	regptr = ((reg << 16) & mask) | (chn & PTR_CHANNELNUM_MASK);
 
-- 
1.9.0
