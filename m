From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/18] ALSA: aloop: Use setup_timer() and
	mod_timer()
Date: Mon, 19 Jan 2015 12:11:15 +0100
Message-ID: <1421665891-14475-3-git-send-email-tiwai@suse.de>
References: <1421665891-14475-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8239B2606BF
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 12:11:36 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DBF80AD75
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 11:11:35 +0000 (UTC)
In-Reply-To: <1421665891-14475-1-git-send-email-tiwai@suse.de>
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

No functional change, refactoring with the standard helpers.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 7ea53399404d..7f9126efc1e5 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -181,8 +181,7 @@ static void loopback_timer_start(struct loopback_pcm *dpcm)
 	}
 	tick = dpcm->period_size_frac - dpcm->irq_pos;
 	tick = (tick + dpcm->pcm_bps - 1) / dpcm->pcm_bps;
-	dpcm->timer.expires = jiffies + tick;
-	add_timer(&dpcm->timer);
+	mod_timer(&dpcm->timer, jiffies + tick);
 }
 
 /* call in cable->lock */
-- 
2.2.1
