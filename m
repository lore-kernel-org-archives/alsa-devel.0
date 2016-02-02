From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH for-4.6] ALSA: dummy: Implement timer backend
	switching more safely
Date: Tue,  2 Feb 2016 15:46:50 +0100
Message-ID: <1454424410-20473-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0143A265104
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 15:46:55 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B5391AC8E
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 14:46:54 +0000 (UTC)
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

Currently the selected timer backend is referred at any moment from
the running PCM callbacks.  When the backend is switched, it's
possible to lead to inconsistency from the running backend.  This was
pointed by syzkaller fuzzer, and the commit [7ee96216c31a: ALSA:
dummy: Disable switching timer backend via sysfs] disabled the dynamic
switching for avoiding the crash.

This patch improves the handling of timer backend switching.  It keeps
the reference to the selected backend during the whole operation of an
opened stream so that it won't be changed by other streams.

Together with this change, the hrtimer parameter is reenabled as
writable now.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

This is a patch for 4.6, not meant for 4.5 as a fix for now.

 sound/drivers/dummy.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index bde33308f0d6..c0f8f613f1f1 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -87,7 +87,7 @@ MODULE_PARM_DESC(pcm_substreams, "PCM substreams # (1-128) for dummy driver.");
 module_param(fake_buffer, bool, 0444);
 MODULE_PARM_DESC(fake_buffer, "Fake buffer allocations.");
 #ifdef CONFIG_HIGH_RES_TIMERS
-module_param(hrtimer, bool, 0444);
+module_param(hrtimer, bool, 0644);
 MODULE_PARM_DESC(hrtimer, "Use hrtimer as the timer source.");
 #endif
 
@@ -109,6 +109,9 @@ struct dummy_timer_ops {
 	snd_pcm_uframes_t (*pointer)(struct snd_pcm_substream *);
 };
 
+#define get_dummy_ops(substream) \
+	(*(const struct dummy_timer_ops **)(substream)->runtime->private_data)
+
 struct dummy_model {
 	const char *name;
 	int (*playback_constraints)(struct snd_pcm_runtime *runtime);
@@ -137,7 +140,6 @@ struct snd_dummy {
 	int iobox;
 	struct snd_kcontrol *cd_volume_ctl;
 	struct snd_kcontrol *cd_switch_ctl;
-	const struct dummy_timer_ops *timer_ops;
 };
 
 /*
@@ -231,6 +233,8 @@ static struct dummy_model *dummy_models[] = {
  */
 
 struct dummy_systimer_pcm {
+	/* ops must be the first item */
+	const struct dummy_timer_ops *timer_ops;
 	spinlock_t lock;
 	struct timer_list timer;
 	unsigned long base_time;
@@ -366,6 +370,8 @@ static const struct dummy_timer_ops dummy_systimer_ops = {
  */
 
 struct dummy_hrtimer_pcm {
+	/* ops must be the first item */
+	const struct dummy_timer_ops *timer_ops;
 	ktime_t base_time;
 	ktime_t period_time;
 	atomic_t running;
@@ -492,31 +498,25 @@ static const struct dummy_timer_ops dummy_hrtimer_ops = {
 
 static int dummy_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 {
-	struct snd_dummy *dummy = snd_pcm_substream_chip(substream);
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
-		return dummy->timer_ops->start(substream);
+		return get_dummy_ops(substream)->start(substream);
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
-		return dummy->timer_ops->stop(substream);
+		return get_dummy_ops(substream)->stop(substream);
 	}
 	return -EINVAL;
 }
 
 static int dummy_pcm_prepare(struct snd_pcm_substream *substream)
 {
-	struct snd_dummy *dummy = snd_pcm_substream_chip(substream);
-
-	return dummy->timer_ops->prepare(substream);
+	return get_dummy_ops(substream)->prepare(substream);
 }
 
 static snd_pcm_uframes_t dummy_pcm_pointer(struct snd_pcm_substream *substream)
 {
-	struct snd_dummy *dummy = snd_pcm_substream_chip(substream);
-
-	return dummy->timer_ops->pointer(substream);
+	return get_dummy_ops(substream)->pointer(substream);
 }
 
 static struct snd_pcm_hardware dummy_pcm_hardware = {
@@ -562,17 +562,19 @@ static int dummy_pcm_open(struct snd_pcm_substream *substream)
 	struct snd_dummy *dummy = snd_pcm_substream_chip(substream);
 	struct dummy_model *model = dummy->model;
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	const struct dummy_timer_ops *ops;
 	int err;
 
-	dummy->timer_ops = &dummy_systimer_ops;
+	ops = &dummy_systimer_ops;
 #ifdef CONFIG_HIGH_RES_TIMERS
 	if (hrtimer)
-		dummy->timer_ops = &dummy_hrtimer_ops;
+		ops = &dummy_hrtimer_ops;
 #endif
 
-	err = dummy->timer_ops->create(substream);
+	err = ops->create(substream);
 	if (err < 0)
 		return err;
+	get_dummy_ops(substream) = ops;
 
 	runtime->hw = dummy->pcm_hw;
 	if (substream->pcm->device & 1) {
@@ -594,7 +596,7 @@ static int dummy_pcm_open(struct snd_pcm_substream *substream)
 			err = model->capture_constraints(substream->runtime);
 	}
 	if (err < 0) {
-		dummy->timer_ops->free(substream);
+		get_dummy_ops(substream)->free(substream);
 		return err;
 	}
 	return 0;
@@ -602,8 +604,7 @@ static int dummy_pcm_open(struct snd_pcm_substream *substream)
 
 static int dummy_pcm_close(struct snd_pcm_substream *substream)
 {
-	struct snd_dummy *dummy = snd_pcm_substream_chip(substream);
-	dummy->timer_ops->free(substream);
+	get_dummy_ops(substream)->free(substream);
 	return 0;
 }
 
-- 
2.7.0
