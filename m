From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: pcm: Use snd_pcm_stop_xrun() for
	xrun injection
Date: Wed,  4 Jul 2018 15:34:32 +0200
Message-ID: <20180704133432.13925-2-tiwai@suse.de>
References: <20180704133432.13925-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA61267214
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 15:34:37 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2061CAE6C
 for <alsa-devel@alsa-project.org>; Wed,  4 Jul 2018 13:34:37 +0000 (UTC)
In-Reply-To: <20180704133432.13925-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Basically the xrun injection routine can simply call the standard
helper snd_pcm_stop_xrun(), but with one exception: it may be called
even when the stream is closed.

Make snd_pcm_stop_xrun() more robust and check the NULL runtime state,
and simplify xrun injection code by calling it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm.c        | 7 +------
 sound/core/pcm_native.c | 2 +-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 6f037a4b8b52..fdb9b92fc8d6 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -492,13 +492,8 @@ static void snd_pcm_xrun_injection_write(struct snd_info_entry *entry,
 					 struct snd_info_buffer *buffer)
 {
 	struct snd_pcm_substream *substream = entry->private_data;
-	struct snd_pcm_runtime *runtime;
 
-	snd_pcm_stream_lock_irq(substream);
-	runtime = substream->runtime;
-	if (runtime && runtime->status->state == SNDRV_PCM_STATE_RUNNING)
-		__snd_pcm_xrun(substream);
-	snd_pcm_stream_unlock_irq(substream);
+	snd_pcm_stop_xrun(substream);
 }
 
 static void snd_pcm_xrun_debug_read(struct snd_info_entry *entry,
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 20174d0c0527..66c90f486af9 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1339,7 +1339,7 @@ int snd_pcm_stop_xrun(struct snd_pcm_substream *substream)
 	unsigned long flags;
 
 	snd_pcm_stream_lock_irqsave(substream, flags);
-	if (snd_pcm_running(substream))
+	if (substream->runtime && snd_pcm_running(substream))
 		__snd_pcm_xrun(substream);
 	snd_pcm_stream_unlock_irqrestore(substream, flags);
 	return 0;
-- 
2.18.0
