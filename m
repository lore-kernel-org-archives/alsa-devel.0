From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 06/22] ALSA: hda - remove unused clear of
	STATESTS
Date: Fri, 28 Feb 2014 15:41:17 -0800
Message-ID: <1393630893-29010-7-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f201.google.com (mail-ig0-f201.google.com
 [209.85.213.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F3DA2659A1
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-ig0-f201.google.com with SMTP id l13so323024iga.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

Although the code was updated last year the "#if 0" surrounding it
dates back to the original git commit.  The function will be moved to
a new file, no need to carry the dead code.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c4b6447..7cdb4dd 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1081,11 +1081,6 @@ static irqreturn_t azx_interrupt(int irq, void *dev_id)
 		azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 	}
 
-#if 0
-	/* clear state status int */
-	if (azx_readw(chip, STATESTS) & 0x04)
-		azx_writew(chip, STATESTS, 0x04);
-#endif
 	spin_unlock(&chip->reg_lock);
 	
 	return IRQ_HANDLED;
-- 
1.8.1.3.605.g02339dd
