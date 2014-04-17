From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 4/6] sound: lx_core: Remove dead code
Date: Thu, 17 Apr 2014 11:51:19 +0200
Message-ID: <1397728281-26050-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1397728281-26050-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id AA2D42650BC
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 11:55:08 +0200 (CEST)
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

Some code was never compiled because hidden between an #if 0 .. #endif
structure, and even when removing these, it was never actually used elsewhere.
Remove it entirely.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 sound/pci/lx6464es/lx_core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 9e0acba82751..0ad6358b5fe2 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -1041,10 +1041,6 @@ static int lx_interrupt_handle_async_events(struct lx6464es *chip, u32 irqsrc,
 
 	u64 orun_mask;
 	u64 urun_mask;
-#if 0
-	int has_underrun   = (irqsrc & MASK_SYS_STATUS_URUN) ? 1 : 0;
-	int has_overrun    = (irqsrc & MASK_SYS_STATUS_ORUN) ? 1 : 0;
-#endif
 	int eb_pending_out = (irqsrc & MASK_SYS_STATUS_EOBO) ? 1 : 0;
 	int eb_pending_in  = (irqsrc & MASK_SYS_STATUS_EOBI) ? 1 : 0;
 
-- 
1.9.1
