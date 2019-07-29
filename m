From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH] ALSA: pcm: fix lost wakeup event scenarios in
	snd_pcm_drain
Date: Mon, 29 Jul 2019 17:10:36 +0200
Message-ID: <1564413036-3165-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Yuki Tsunashima <ytsunashima@jp.adit-jv.com>, Suresh Udipi <sudipi@jp.adit-jv.com>
List-Id: alsa-devel@alsa-project.org

From: Yuki Tsunashima <ytsunashima@jp.adit-jv.com>

lost wakeup can occur after enabling irq, therefore put task
into interruptible before enabling interrupts,

without this change, task can be put to sleep and snd_pcm_drain
will delay

Signed-off-by: Yuki Tsunashima <ytsunashima@jp.adit-jv.com>
Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
[ported from 4.9]
Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
---
 sound/core/pcm_native.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 860543a..fe333c8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1874,6 +1874,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		if (!to_check)
 			break; /* all drained */
 		init_waitqueue_entry(&wait, current);
+		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&to_check->sleep, &wait);
 		snd_pcm_stream_unlock_irq(substream);
 		if (runtime->no_period_wakeup)
@@ -1886,7 +1887,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 			}
 			tout = msecs_to_jiffies(tout * 1000);
 		}
-		tout = schedule_timeout_interruptible(tout);
+		tout = schedule_timeout(tout);
 
 		snd_pcm_stream_lock_irq(substream);
 		group = snd_pcm_stream_group_ref(substream);
-- 
2.7.4
