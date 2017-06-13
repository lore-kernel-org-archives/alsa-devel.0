From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: pcm: Allow dropping stream directly
	after resume
Date: Tue, 13 Jun 2017 16:18:09 +0200
Message-ID: <20170613141812.21220-4-tiwai@suse.de>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E9295266D52
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2E6B7AE85
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 14:18:14 +0000 (UTC)
In-Reply-To: <20170613141812.21220-1-tiwai@suse.de>
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

So far, the PCM core refuses DROP ioctl when the stream in the
suspended state.  This was basically to avoid the invalid state change
*during* the suspend.  But since we protect the power change globally
in the common PCM ioctl caller side, it's guaranteed that
snd_pcm_drop() is called at the right power state.  So we can assume
that the drop of stream is safe immediately after SUSPENDED state.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index bd1b74aa2068..69cf9b02ac70 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1883,8 +1883,7 @@ static int snd_pcm_drop(struct snd_pcm_substream *substream)
 	runtime = substream->runtime;
 
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED ||
-	    runtime->status->state == SNDRV_PCM_STATE_SUSPENDED)
+	    runtime->status->state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;
 
 	snd_pcm_stream_lock_irq(substream);
-- 
2.13.1
