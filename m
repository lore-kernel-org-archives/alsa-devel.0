From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] sound: dummy, use setup_timer and mod_timer
Date: Mon, 19 Jan 2015 10:42:54 +0100
Message-ID: <1421660576-8435-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, Roman Kollar <rkollar@mail.muni.cz>, Jiri Slaby <jslaby@suse.cz>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Roman Kollar <rkollar@mail.muni.cz>

Use setup_timer and mod_timer instead of structure assignments as it
is the preferred way to setup and set the timer.

Signed-off-by: Roman Kollar <rkollar@mail.muni.cz>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/dummy.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 5d0dfb787cec..d11baaf0f0b4 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -245,9 +245,8 @@ struct dummy_systimer_pcm {
 
 static void dummy_systimer_rearm(struct dummy_systimer_pcm *dpcm)
 {
-	dpcm->timer.expires = jiffies +
-		(dpcm->frac_period_rest + dpcm->rate - 1) / dpcm->rate;
-	add_timer(&dpcm->timer);
+	mod_timer(&dpcm->timer, jiffies +
+		(dpcm->frac_period_rest + dpcm->rate - 1) / dpcm->rate);
 }
 
 static void dummy_systimer_update(struct dummy_systimer_pcm *dpcm)
@@ -340,9 +339,8 @@ static int dummy_systimer_create(struct snd_pcm_substream *substream)
 	if (!dpcm)
 		return -ENOMEM;
 	substream->runtime->private_data = dpcm;
-	init_timer(&dpcm->timer);
-	dpcm->timer.data = (unsigned long) dpcm;
-	dpcm->timer.function = dummy_systimer_callback;
+	setup_timer(&dpcm->timer, dummy_systimer_callback,
+			(unsigned long) dpcm);
 	spin_lock_init(&dpcm->lock);
 	dpcm->substream = substream;
 	return 0;
-- 
2.2.1
