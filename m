From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 3/6] sound: lx_core: Fix dev_dbg typo
Date: Thu, 17 Apr 2014 11:51:18 +0200
Message-ID: <1397728281-26050-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id D6DEF2608EA
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 11:55:07 +0200 (CEST)
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

Commit be4e6d3c0fa0 ("ALSA: lx6464es: Use standard printk helpers") converted
the custom printk helpers that were used before to standard dev_* functions.
One of the dev_dbg calls had a typo, that was hidden away by an #if 0 .. #endif

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/pci/lx6464es/lx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 652f6dfc7e1a..9e0acba82751 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -1197,7 +1197,7 @@ irqreturn_t lx_interrupt(int irq, void *dev_id)
 
 #if 0
 	if (irqsrc & MASK_SYS_STATUS_EOBI)
-		dev_dgg(chip->card->dev, "interrupt: EOBI\n");
+		dev_dbg(chip->card->dev, "interrupt: EOBI\n");
 
 	if (irqsrc & MASK_SYS_STATUS_EOBO)
 		dev_dbg(chip->card->dev, "interrupt: EOBO\n");
-- 
1.9.1
