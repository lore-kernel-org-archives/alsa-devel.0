From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Fix time account regression
Date: Tue, 25 Oct 2016 16:03:28 +0200
Message-ID: <20161025140328.23778-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A2F592614A0
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 16:03:30 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0379EAAD1
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 14:03:29 +0000 (UTC)
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

The recent rewrite of the sequencer time accounting using timespec64
in the commit [3915bf294652: ALSA: seq_timer: use monotonic times
internally] introduced a bad regression.  Namely, the time reported
back doesn't increase but goes back and forth.

The culprit was obvious: the delta is stored to the result (cur_time =
delta), instead of adding the delta (cur_time += delta)!

Let's fix it.

Fixes: 3915bf294652 ('ALSA: seq_timer: use monotonic times internally')
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=177571
Reported-by: Yves Guillemot <yc.guillemot@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index dcc102813aef..37d9cfbc29f9 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -448,8 +448,8 @@ snd_seq_real_time_t snd_seq_timer_get_cur_time(struct snd_seq_timer *tmr)
 
 		ktime_get_ts64(&tm);
 		tm = timespec64_sub(tm, tmr->last_update);
-		cur_time.tv_nsec = tm.tv_nsec;
-		cur_time.tv_sec = tm.tv_sec;
+		cur_time.tv_nsec += tm.tv_nsec;
+		cur_time.tv_sec += tm.tv_sec;
 		snd_seq_sanity_real_time(&cur_time);
 	}
 	spin_unlock_irqrestore(&tmr->lock, flags);
-- 
2.10.1
