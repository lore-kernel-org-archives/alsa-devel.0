From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: hrtimer: make hrtimer_hw const and __initconst
Date: Tue, 19 Sep 2017 16:44:38 +0530
Message-ID: <1505819678-1512-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is only used during a copy operation. Also, make
it __initconst as it is only used during the init phase and after this
it is not referenced anywhere.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/core/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/hrtimer.c b/sound/core/hrtimer.c
index 1ac0c42..5603e49 100644
--- a/sound/core/hrtimer.c
+++ b/sound/core/hrtimer.c
@@ -127,7 +127,7 @@ static int snd_hrtimer_stop(struct snd_timer *t)
 	return 0;
 }
 
-static struct snd_timer_hardware hrtimer_hw = {
+static const struct snd_timer_hardware hrtimer_hw __initconst = {
 	.flags =	SNDRV_TIMER_HW_AUTO | SNDRV_TIMER_HW_TASKLET,
 	.open =		snd_hrtimer_open,
 	.close =	snd_hrtimer_close,
-- 
1.9.1
