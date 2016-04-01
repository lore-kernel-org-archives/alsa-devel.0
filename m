From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: timer: Use mod_timer() for rearming the
	system timer
Date: Fri,  1 Apr 2016 12:58:57 +0200
Message-ID: <1459508337-23302-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 010E7260524
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 12:58:59 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4275AC64
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 10:58:57 +0000 (UTC)
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
Cc: Jiri Slaby <jslaby@suse.cz>
List-Id: alsa-devel@alsa-project.org

ALSA system timer backend stops the timer via del_timer() without sync
and leaves del_timer_sync() at the close instead.  This is because of
the restriction by the design of ALSA timer: namely, the stop callback
may be called from the timer handler, and calling the sync shall lead
to a hangup.  However, this also triggers a kernel BUG() when the
timer is rearmed immediately after stopping without sync:
 kernel BUG at kernel/time/timer.c:966!
 Call Trace:
  <IRQ>
  [<ffffffff8239c94e>] snd_timer_s_start+0x13e/0x1a0
  [<ffffffff8239e1f4>] snd_timer_interrupt+0x504/0xec0
  [<ffffffff8122fca0>] ? debug_check_no_locks_freed+0x290/0x290
  [<ffffffff8239ec64>] snd_timer_s_function+0xb4/0x120
  [<ffffffff81296b72>] call_timer_fn+0x162/0x520
  [<ffffffff81296add>] ? call_timer_fn+0xcd/0x520
  [<ffffffff8239ebb0>] ? snd_timer_interrupt+0xec0/0xec0
  ....

It's the place where add_timer() checks the pending timer.  It's clear
that this may happen after the immediate restart without sync in our
cases.

So, the workaround here is just to use mod_timer() instead of
add_timer().  This looks like a band-aid fix, but it's a right move,
as snd_timer_interrupt() takes care of the continuous rearm of timer.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index ea4d999113ef..6469bedda2f3 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1019,8 +1019,8 @@ static int snd_timer_s_start(struct snd_timer * timer)
 		njiff += timer->sticks - priv->correction;
 		priv->correction = 0;
 	}
-	priv->last_expires = priv->tlist.expires = njiff;
-	add_timer(&priv->tlist);
+	priv->last_expires = njiff;
+	mod_timer(&priv->tlist, njiff);
 	return 0;
 }
 
-- 
2.7.4
