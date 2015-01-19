From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/3] sound: dummy, avoid races with timer
Date: Mon, 19 Jan 2015 10:42:56 +0100
Message-ID: <1421660576-8435-3-git-send-email-jslaby@suse.cz>
References: <1421660576-8435-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1421660576-8435-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is a race between timer and process contexts. Process context
does not disable irqs, so when a timer ticks inside process' critical
section, the system can deadlock. Fix this by a traditional _irqsave
variant of spin_lock.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/dummy.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 6d6bf4093583..18a7cfc99078 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -271,10 +271,13 @@ static void dummy_systimer_update(struct dummy_systimer_pcm *dpcm)
 static int dummy_systimer_start(struct snd_pcm_substream *substream)
 {
 	struct dummy_systimer_pcm *dpcm = substream->runtime->private_data;
-	spin_lock(&dpcm->lock);
+	unsigned long flags;
+
+	spin_lock_irqsave(&dpcm->lock, flags);
 	dpcm->base_time = jiffies;
 	dummy_systimer_rearm(dpcm);
-	spin_unlock(&dpcm->lock);
+	spin_unlock_irqrestore(&dpcm->lock, flags);
+
 	return 0;
 }
 
@@ -322,12 +325,14 @@ static snd_pcm_uframes_t
 dummy_systimer_pointer(struct snd_pcm_substream *substream)
 {
 	struct dummy_systimer_pcm *dpcm = substream->runtime->private_data;
+	unsigned long flags;
 	snd_pcm_uframes_t pos;
 
-	spin_lock(&dpcm->lock);
+	spin_lock_irqsave(&dpcm->lock, flags);
 	dummy_systimer_update(dpcm);
 	pos = dpcm->frac_pos / HZ;
-	spin_unlock(&dpcm->lock);
+	spin_unlock_irqrestore(&dpcm->lock, flags);
+
 	return pos;
 }
 
-- 
2.2.1
