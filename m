From: Chanho Min <chanho.min@lge.com>
Subject: [PATCH] ALSA: pcm: Fix starvation on
	down_write_nonblock()
Date: Sat, 24 Nov 2018 16:32:43 +0900
Message-ID: <1543044763-31843-1-git-send-email-chanho.min@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 68E5E2677E8
 for <alsa-devel@alsa-project.org>; Sat, 24 Nov 2018 08:33:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Daniel Mentz <danielmentz@google.com>
Cc: alsa-devel@alsa-project.org, Jaehyun Kim <jehn.kim@lge.com>, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>, linux-kernel@vger.kernel.org, Hyonwoo Park <hyonwoo.park@lge.com>, Wonmin Jung <wonmin.jung@lge.com>, Seungho Park <seungho1.park@lge.com>
List-Id: alsa-devel@alsa-project.org

Commit 67ec1072b053 (ALSA: pcm: Fix rwsem deadlock for non-atomic PCM stream)
fixes deadlock for non-atomic PCM stream. But, This patch causes antother stuck.
If writer is RT thread and reader is a normal thread, the reader thread will
be difficult to get scheduled. It may not give chance to release read locks
and writer gets stuck for a long time or forever if they are pinned to single
cpu.

To fix this, The writer gives reader a chance to be scheduled by using the
minimum msleep() instaed of spinning. This is for concept, We may need to
change the function name and comments or suggest another approach.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 sound/core/pcm_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 66c90f4..88d4aab 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -96,7 +96,7 @@ static DECLARE_RWSEM(snd_pcm_link_rwsem);
 static inline void down_write_nonblock(struct rw_semaphore *lock)
 {
 	while (!down_write_trylock(lock))
-		cond_resched();
+		msleep(1);
 }
 
 #define PCM_LOCK_DEFAULT	0
-- 
2.1.4
