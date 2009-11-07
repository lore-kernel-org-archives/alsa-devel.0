From: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
Subject: [PATCH - alsa-lib 1/1] Defined symbols exposing the
	hrtimer to applications.
Date: Sun,  8 Nov 2009 00:01:06 +0100
Message-ID: <1257634866-24071-1-git-send-email-pedro.lopez.cabanillas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Pedro Lopez-Cabanillas <pedro.lopez.cabanillas@gmail.com>
---
 include/sound/asound.h |    1 +
 include/timer.h        |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/sound/asound.h b/include/sound/asound.h
index 62d1e57..fa88938 100644
--- a/include/sound/asound.h
+++ b/include/sound/asound.h
@@ -593,6 +593,7 @@ enum sndrv_timer_slave_class {
 #define SNDRV_TIMER_GLOBAL_SYSTEM	0
 #define SNDRV_TIMER_GLOBAL_RTC		1
 #define SNDRV_TIMER_GLOBAL_HPET		2
+#define SNDRV_TIMER_GLOBAL_HRTIMER	3
 
 /* info flags */
 #define SNDRV_TIMER_FLG_SLAVE		(1<<0)	/* cannot be controlled */
diff --git a/include/timer.h b/include/timer.h
index 4d06e31..2803f53 100644
--- a/include/timer.h
+++ b/include/timer.h
@@ -115,6 +115,8 @@ typedef struct _snd_timer_tread {
 #define SND_TIMER_GLOBAL_RTC 	1
 /** global timer - HPET */
 #define SND_TIMER_GLOBAL_HPET	2
+/** global timer - HRTIMER */
+#define SND_TIMER_GLOBAL_HRTIMER 3
 
 /** timer open mode flag - non-blocking behaviour */
 #define SND_TIMER_OPEN_NONBLOCK		(1<<0)
-- 
1.6.4.2
