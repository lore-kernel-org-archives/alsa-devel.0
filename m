From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v2 2/2] sound: dummy, avoid race with timer
Date: Mon, 19 Jan 2015 10:56:41 +0100
Message-ID: <1421661401-10533-1-git-send-email-jslaby@suse.cz>
References: <s5hwq4jqewi.wl-tiwai@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hwq4jqewi.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

There is a race between timer and process contexts. Process context
does not disable irqs, so when a timer ticks inside process' critical
section, the system can deadlock. Fix this by a traditional _irqsave
variant of spin_lock.

[v2] removed ->pointer change as it is called with BH off

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/drivers/dummy.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index d11baaf0f0b4..0791210cb4e7 100644
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
 
-- 
2.2.1
