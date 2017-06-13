From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: pcm: Apply power lock globally to
	common ioctls
Date: Tue, 13 Jun 2017 16:18:08 +0200
Message-ID: <20170613141812.21220-3-tiwai@suse.de>
References: <20170613141812.21220-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EC5CE266F05
 for <alsa-devel@alsa-project.org>; Tue, 13 Jun 2017 16:18:14 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2E0AEAE83
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

All PCM common ioctls should run only in the powered up state, but
currently only a few ioctls do the proper snd_power_lock() and
snd_power_wait() invocations.  Instead of adding to each place, do it
commonly in the caller side, so that all these ioctls are assured to
be operated at the power up state.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 56 +++++++++++++++++--------------------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 798bca967c0e..bd1b74aa2068 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -1540,14 +1540,7 @@ static const struct action_ops snd_pcm_action_resume = {
 
 static int snd_pcm_resume(struct snd_pcm_substream *substream)
 {
-	struct snd_card *card = substream->pcm->card;
-	int res;
-
-	snd_power_lock(card);
-	if ((res = snd_power_wait(card, SNDRV_CTL_POWER_D0)) >= 0)
-		res = snd_pcm_action_lock_irq(&snd_pcm_action_resume, substream, 0);
-	snd_power_unlock(card);
-	return res;
+	return snd_pcm_action_lock_irq(&snd_pcm_action_resume, substream, 0);
 }
 
 #else
@@ -1566,17 +1559,9 @@ static int snd_pcm_resume(struct snd_pcm_substream *substream)
  */
 static int snd_pcm_xrun(struct snd_pcm_substream *substream)
 {
-	struct snd_card *card = substream->pcm->card;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	int result;
 
-	snd_power_lock(card);
-	if (runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
-		result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-		if (result < 0)
-			goto _unlock;
-	}
-
 	snd_pcm_stream_lock_irq(substream);
 	switch (runtime->status->state) {
 	case SNDRV_PCM_STATE_XRUN:
@@ -1589,8 +1574,6 @@ static int snd_pcm_xrun(struct snd_pcm_substream *substream)
 		result = -EBADFD;
 	}
 	snd_pcm_stream_unlock_irq(substream);
- _unlock:
-	snd_power_unlock(card);
 	return result;
 }
 
@@ -1694,8 +1677,6 @@ static const struct action_ops snd_pcm_action_prepare = {
 static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 			   struct file *file)
 {
-	int res;
-	struct snd_card *card = substream->pcm->card;
 	int f_flags;
 
 	if (file)
@@ -1703,12 +1684,8 @@ static int snd_pcm_prepare(struct snd_pcm_substream *substream,
 	else
 		f_flags = substream->f_flags;
 
-	snd_power_lock(card);
-	if ((res = snd_power_wait(card, SNDRV_CTL_POWER_D0)) >= 0)
-		res = snd_pcm_action_nonatomic(&snd_pcm_action_prepare,
-					       substream, f_flags);
-	snd_power_unlock(card);
-	return res;
+	return snd_pcm_action_nonatomic(&snd_pcm_action_prepare,
+					substream, f_flags);
 }
 
 /*
@@ -1805,15 +1782,6 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	if (runtime->status->state == SNDRV_PCM_STATE_OPEN)
 		return -EBADFD;
 
-	snd_power_lock(card);
-	if (runtime->status->state == SNDRV_PCM_STATE_SUSPENDED) {
-		result = snd_power_wait(card, SNDRV_CTL_POWER_D0);
-		if (result < 0) {
-			snd_power_unlock(card);
-			return result;
-		}
-	}
-
 	if (file) {
 		if (file->f_flags & O_NONBLOCK)
 			nonblock = 1;
@@ -1896,7 +1864,6 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
  unlock:
 	snd_pcm_stream_unlock_irq(substream);
 	up_read(&snd_pcm_link_rwsem);
-	snd_power_unlock(card);
 
 	return result;
 }
@@ -2798,7 +2765,7 @@ static int snd_pcm_tstamp(struct snd_pcm_substream *substream, int __user *_arg)
 	return 0;
 }
 		
-static int snd_pcm_common_ioctl1(struct file *file,
+static int snd_pcm_common_ioctl(struct file *file,
 				 struct snd_pcm_substream *substream,
 				 unsigned int cmd, void __user *arg)
 {
@@ -2873,6 +2840,21 @@ static int snd_pcm_common_ioctl1(struct file *file,
 	return -ENOTTY;
 }
 
+static int snd_pcm_common_ioctl1(struct file *file,
+				 struct snd_pcm_substream *substream,
+				 unsigned int cmd, void __user *arg)
+{
+	struct snd_card *card = substream->pcm->card;
+	int res;
+
+	snd_power_lock(card);
+	res = snd_power_wait(card, SNDRV_CTL_POWER_D0);
+	if (res >= 0)
+		res = snd_pcm_common_ioctl(file, substream, cmd, arg);
+	snd_power_unlock(card);
+	return res;
+}
+
 static int snd_pcm_playback_ioctl1(struct file *file,
 				   struct snd_pcm_substream *substream,
 				   unsigned int cmd, void __user *arg)
-- 
2.13.1
