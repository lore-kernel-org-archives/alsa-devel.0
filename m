From: Chanho Min <chanho.min@lge.com>
Subject: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date: Mon, 26 Nov 2018 14:36:37 +0900
Message-ID: <1543210597-6717-1-git-send-email-chanho.min@lge.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@kernel.org>, Vinod Koul <vkoul@kernel.org>, Daniel Mentz <danielmentz@google.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Seungho Park <seungho1.park@lge.com>, Jongsung Kim <neidhard.kim@lge.com>, Wonmin Jung <wonmin.jung@lge.com>, Jaehyun Kim <jehn.kim@lge.com>, Hyonwoo Park <hyonwoo.park@lge.com>, Chanho Min <chanho.min@lge.com>
List-Id: alsa-devel@alsa-project.org

Commit 67ec1072b053 ("ALSA: pcm: Fix rwsem deadlock for non-atomic PCM stream")
fixes deadlock for non-atomic PCM stream. But, This patch causes antother stuck.
If writer is RT thread and reader is a normal thread, the reader thread will
be difficult to get scheduled. It may not give chance to release readlocks
and writer gets stuck for a long time if they are pinned to single cpu.

The deadlock described in the previous commit is because the linux rwsem
queues like a FIFO. So, we might need non-FIFO writelock, not non-block one.

My suggestion is that the writer gives reader a chance to be scheduled by using
the minimum msleep() instaed of spinning without blocking by writer. Also,
The *_nonblock may be changed to *_nonfifo appropriately to this concept.
In terms of performance, when trylock is failed, this minimum periodic msleep
will have the same performance as the tick-based schedule()/wake_up_q().

Suggested-by: Wonmin Jung <wonmin.jung@lge.com>
Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 sound/core/pcm_native.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 66c90f4..bdca0e1 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -36,6 +36,7 @@
 #include <sound/timer.h>
 #include <sound/minors.h>
 #include <linux/uio.h>
+#include <linux/delay.h>
 
 #include "pcm_local.h"
 
@@ -91,12 +92,12 @@ static DECLARE_RWSEM(snd_pcm_link_rwsem);
  * and this may lead to a deadlock when the code path takes read sem
  * twice (e.g. one in snd_pcm_action_nonatomic() and another in
  * snd_pcm_stream_lock()).  As a (suboptimal) workaround, let writer to
- * spin until it gets the lock.
+ * sleep until all the readers are completed without blocking by writer.
  */
-static inline void down_write_nonblock(struct rw_semaphore *lock)
+static inline void down_write_nonfifo(struct rw_semaphore *lock)
 {
 	while (!down_write_trylock(lock))
-		cond_resched();
+		msleep(1);
 }
 
 #define PCM_LOCK_DEFAULT	0
@@ -1967,7 +1968,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 		res = -ENOMEM;
 		goto _nolock;
 	}
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (substream->runtime->status->state == SNDRV_PCM_STATE_OPEN ||
 	    substream->runtime->status->state != substream1->runtime->status->state ||
@@ -2014,7 +2015,7 @@ static int snd_pcm_unlink(struct snd_pcm_substream *substream)
 	struct snd_pcm_substream *s;
 	int res = 0;
 
-	down_write_nonblock(&snd_pcm_link_rwsem);
+	down_write_nonfifo(&snd_pcm_link_rwsem);
 	write_lock_irq(&snd_pcm_link_rwlock);
 	if (!snd_pcm_stream_linked(substream)) {
 		res = -EALREADY;
-- 
2.1.4
