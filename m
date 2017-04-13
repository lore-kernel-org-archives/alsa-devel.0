From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Don't break snd_use_lock_sync()
	loop by timeout
Date: Thu, 13 Apr 2017 14:12:49 +0200
Message-ID: <20170413121249.10763-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EAE626706A
 for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2017 14:12:58 +0200 (CEST)
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
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Dmitry Vyukov <dvyukov@google.com>
List-Id: alsa-devel@alsa-project.org

The snd_use_lock_sync() (thus its implementation
snd_use_lock_sync_helper()) has the 5 seconds timeout to break out of
the sync loop.  It was introduced from the beginning, just to be
"safer", in terms of avoiding the stupid bugs.

However, as Ben Hutchings suggested, this timeout rather introduces a
potential leak or use-after-free that was apparently fixed by the
commit 2d7d54002e39 ("ALSA: seq: Fix race during FIFO resize"):
for example, snd_seq_fifo_event_in() -> snd_seq_event_dup() ->
copy_from_user() could block for a long time, and snd_use_lock_sync()
goes timeout and still leaves the cell at releasing the pool.

For fixing such a problem, we remove the break by the timeout while
still keeping the warning.

Suggested-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_lock.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/core/seq/seq_lock.c b/sound/core/seq/seq_lock.c
index 3b693e924db7..12ba83367b1b 100644
--- a/sound/core/seq/seq_lock.c
+++ b/sound/core/seq/seq_lock.c
@@ -28,19 +28,16 @@
 /* wait until all locks are released */
 void snd_use_lock_sync_helper(snd_use_lock_t *lockp, const char *file, int line)
 {
-	int max_count = 5 * HZ;
+	int warn_count = 5 * HZ;
 
 	if (atomic_read(lockp) < 0) {
 		pr_warn("ALSA: seq_lock: lock trouble [counter = %d] in %s:%d\n", atomic_read(lockp), file, line);
 		return;
 	}
 	while (atomic_read(lockp) > 0) {
-		if (max_count == 0) {
-			pr_warn("ALSA: seq_lock: timeout [%d left] in %s:%d\n", atomic_read(lockp), file, line);
-			break;
-		}
+		if (warn_count-- == 0)
+			pr_warn("ALSA: seq_lock: waiting [%d left] in %s:%d\n", atomic_read(lockp), file, line);
 		schedule_timeout_uninterruptible(1);
-		max_count--;
 	}
 }
 
-- 
2.11.1
