From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcxhr: Fix missing mutex unlock
Date: Thu, 21 Apr 2016 17:40:51 +0200
Message-ID: <1461253251-21005-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 737672612CC
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 17:40:52 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id F33E2ABB4
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 15:40:49 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

The commit [9bef72bdb26e: ALSA: pcxhr: Use nonatomic PCM ops]
converted to non-atomic PCM ops, but shamelessly with an unbalanced
mutex locking, which leads to the hangup easily.  Fix it.

Fixes: 9bef72bdb26e ('ALSA: pcxhr: Use nonatomic PCM ops')
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116441
Cc: <stable@vger.kernel.org> # 3.18+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/pcxhr/pcxhr_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/pcxhr/pcxhr_core.c b/sound/pci/pcxhr/pcxhr_core.c
index c5194f5b150a..d7e71f309299 100644
--- a/sound/pci/pcxhr/pcxhr_core.c
+++ b/sound/pci/pcxhr/pcxhr_core.c
@@ -1341,5 +1341,6 @@ irqreturn_t pcxhr_threaded_irq(int irq, void *dev_id)
 	}
 
 	pcxhr_msg_thread(mgr);
+	mutex_unlock(&mgr->lock);
 	return IRQ_HANDLED;
 }
-- 
2.8.1
