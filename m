From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: pcm: Update the state properly before
	notification
Date: Thu,  6 Nov 2014 12:17:46 +0100
Message-ID: <1415272666-543-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 015C326516D
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 12:17:58 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D8249ADA8
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 11:17:57 +0000 (UTC)
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

Some state changes (e.g. snd_pcm_stop()) sets the runtime state after
calling snd_timer_notify().  This is basically racy, since the
notification may wakes up the user even before the state change.
Although the possibility is low, we should set the state before the
notifications.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ca224fa2a33a..dfb5031969f8 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1052,10 +1052,10 @@ static void snd_pcm_post_stop(struct snd_pcm_substream *substream, int state)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	if (runtime->status->state != state) {
 		snd_pcm_trigger_tstamp(substream);
+		runtime->status->state = state;
 		if (substream->timer)
 			snd_timer_notify(substream->timer, SNDRV_TIMER_EVENT_MSTOP,
 					 &runtime->trigger_tstamp);
-		runtime->status->state = state;
 	}
 	wake_up(&runtime->sleep);
 	wake_up(&runtime->tsleep);
@@ -1204,11 +1204,11 @@ static void snd_pcm_post_suspend(struct snd_pcm_substream *substream, int state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
+	runtime->status->suspended_state = runtime->status->state;
+	runtime->status->state = SNDRV_PCM_STATE_SUSPENDED;
 	if (substream->timer)
 		snd_timer_notify(substream->timer, SNDRV_TIMER_EVENT_MSUSPEND,
 				 &runtime->trigger_tstamp);
-	runtime->status->suspended_state = runtime->status->state;
-	runtime->status->state = SNDRV_PCM_STATE_SUSPENDED;
 	wake_up(&runtime->sleep);
 	wake_up(&runtime->tsleep);
 }
@@ -1311,10 +1311,10 @@ static void snd_pcm_post_resume(struct snd_pcm_substream *substream, int state)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
+	runtime->status->state = runtime->status->suspended_state;
 	if (substream->timer)
 		snd_timer_notify(substream->timer, SNDRV_TIMER_EVENT_MRESUME,
 				 &runtime->trigger_tstamp);
-	runtime->status->state = runtime->status->suspended_state;
 }
 
 static struct action_ops snd_pcm_action_resume = {
-- 
2.1.3
