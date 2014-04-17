From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 5/6] sound: lx_core: Remove useless #if 0 ..
	#endif
Date: Thu, 17 Apr 2014 11:51:20 +0200
Message-ID: <1397728281-26050-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id DE76C265122
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 11:55:09 +0200 (CEST)
In-Reply-To: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, iwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The code contained in these sections are only dev_dbg calls, that are already
removed whenever DEBUG isn't defined.

Remove the redundant constructs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/pci/lx6464es/lx_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 0ad6358b5fe2..7c070864dc62 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -515,7 +515,6 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 				*r_needed += 1;
 		}
 
-#if 0
 		dev_dbg(chip->card->dev,
 			"CMD_08_ASK_BUFFERS: needed %d, freed %d\n",
 			    *r_needed, *r_freed);
@@ -526,7 +525,6 @@ int lx_buffer_ask(struct lx6464es *chip, u32 pipe, int is_capture,
 					    chip->rmh.stat[i],
 					    chip->rmh.stat[i] & MASK_DATA_SIZE);
 		}
-#endif
 	}
 
 	spin_unlock_irqrestore(&chip->msg_lock, flags);
@@ -1191,7 +1189,6 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 	if (irqsrc & MASK_SYS_STATUS_CMD_DONE)
 		goto exit;
 
-#if 0
 	if (irqsrc & MASK_SYS_STATUS_EOBI)
 		dev_dbg(chip->card->dev, "interrupt: EOBI\n");
 
@@ -1203,7 +1200,6 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 
 	if (irqsrc & MASK_SYS_STATUS_ORUN)
 		dev_dbg(chip->card->dev, "interrupt: ORUN\n");
-#endif
 
 	if (async_pending) {
 		u64 notified_in_pipe_mask = 0;
@@ -1230,7 +1226,6 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 	}
 
 	if (async_escmd) {
-#if 0
 		/* backdoor for ethersound commands
 		 *
 		 * for now, we do not need this
@@ -1238,7 +1233,6 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 		 * */
 
 		dev_dbg(chip->card->dev, "interrupt requests escmd handling\n");
-#endif
 	}
 
 exit:
-- 
1.9.1
