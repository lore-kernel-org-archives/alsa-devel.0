From: Kulikov Vasiliy <segooon@gmail.com>
Subject: [PATCH] oss: waveartist: simplify waveartist_sleep()
Date: Mon, 26 Jul 2010 12:29:22 +0400
Message-ID: <1280132962-8346-1-git-send-email-segooon@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel-janitors@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

waveartist_sleep() uses loop with schedule_timeout() to unconditionally
wait for msec. Use schedule_timeout_uninteruptible() instead.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 sound/oss/waveartist.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/oss/waveartist.c b/sound/oss/waveartist.c
index e688dde..5246874 100644
--- a/sound/oss/waveartist.c
+++ b/sound/oss/waveartist.c
@@ -184,14 +184,8 @@ waveartist_iack(wavnc_info *devc)
 static inline int
 waveartist_sleep(int timeout_ms)
 {
-	unsigned int timeout = timeout_ms * 10 * HZ / 100;
-
-	do {
-		set_current_state(TASK_INTERRUPTIBLE);
-		timeout = schedule_timeout(timeout);
-	} while (timeout);
-
-	return 0;
+	unsigned int timeout = msecs_to_jiffies(timeout_ms*100);
+	return schedule_timeout_interruptible(timeout);
 }
 
 static int
-- 
1.7.0.4
