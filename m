From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/3] sound: dummy, use del_timer_sync
Date: Mon, 19 Jan 2015 10:42:55 +0100
Message-ID: <1421660576-8435-2-git-send-email-jslaby@suse.cz>
References: <1421660576-8435-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421660576-8435-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Wait for the timer to really quit, not only by ensuring it is not in
the critical section.

BTW the spin_lock in here does not disable BH, so that it could
deadlock.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/dummy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index d11baaf0f0b4..6d6bf4093583 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -281,9 +281,9 @@ static int dummy_systimer_start(struct snd_pcm_substream *substream)
 static int dummy_systimer_stop(struct snd_pcm_substream *substream)
 {
 	struct dummy_systimer_pcm *dpcm = substream->runtime->private_data;
-	spin_lock(&dpcm->lock);
-	del_timer(&dpcm->timer);
-	spin_unlock(&dpcm->lock);
+
+	del_timer_sync(&dpcm->timer);
+
 	return 0;
 }
 
-- 
2.2.1
