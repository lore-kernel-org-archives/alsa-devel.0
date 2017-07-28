From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/5] ALSA: sound/core: constify snd_timer_hardware structures
Date: Fri, 28 Jul 2017 18:38:26 +0530
Message-ID: <1501247311-19803-2-git-send-email-bhumirks@gmail.com>
References: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_timer_hardware structures as const as their only usage is
during a copy operation. As they are not modified anywhere, they can be
made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/core/hrtimer.c   | 2 +-
 sound/core/pcm_timer.c | 2 +-
 sound/core/timer.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index 1ac0c42..1ba70bc 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -127,7 +127,7 @@ static int snd_hrtimer_stop(struct snd_timer *t)
 	return 0;
 }
 
-static struct snd_timer_hardware hrtimer_hw = {
+static const struct snd_timer_hardware hrtimer_hw = {
 	.flags =	SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_TASKLET,
 	.open =		snd_hrtimer_open,
 	.close =	snd_hrtimer_close,
diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
index 11389f1..3aa2152 100644
--- a/sound/core/pcm_timer.c
+++ b/sound/core/pcm_timer.c
@@ -90,7 +90,7 @@ static int snd_pcm_timer_stop(struct snd_timer * timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_pcm_timer =
+static const struct snd_timer_hardware snd_pcm_timer =
 {
 	.flags =	SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_SLAVE,
 	.resolution =	0,
diff --git a/sound/core/timer.c b/sound/core/timer.c
index a9b9a27..e156aa8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1086,7 +1086,7 @@ static int snd_timer_s_close(struct snd_timer *timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_timer_system =
+static const struct snd_timer_hardware snd_timer_system =
 {
 	.flags =	SNDRV_TIMER_HW_FIRST | SNDRV_TIMER_HW_TASKLET,
 	.resolution =	1000000000L / HZ,
-- 
1.9.1
