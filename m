From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ALSA: seq_oss: Use standard printk
	helpers
Date: Wed, 12 Feb 2014 12:33:12 +0100
Message-ID: <1392204792-12655-11-git-send-email-tiwai@suse.de>
References: <1392204792-12655-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 86A9D265295
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:33:18 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 00936AC86
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:33:18 +0000 (UTC)
In-Reply-To: <1392204792-12655-1-git-send-email-tiwai@suse.de>
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

Use the standard pr_xxx() helpers instead of home-baked snd_print*().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss.c       |  8 ++++----
 sound/core/seq/oss/seq_oss_init.c  | 12 ++++++------
 sound/core/seq/oss/seq_oss_midi.c  |  4 ++--
 sound/core/seq/oss/seq_oss_readq.c |  4 ++--
 sound/core/seq/oss/seq_oss_synth.c |  8 ++++----
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 972368abde64..16d42679e43f 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -226,14 +226,14 @@ register_device(void)
 	if ((rc = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_SEQUENCER,
 					  NULL, 0,
 					  &seq_oss_f_ops, NULL)) < 0) {
-		snd_printk(KERN_ERR "can't register device seq\n");
+		pr_err("ALSA: seq_oss: can't register device seq\n");
 		mutex_unlock(&register_mutex);
 		return rc;
 	}
 	if ((rc = snd_register_oss_device(SNDRV_OSS_DEVICE_TYPE_MUSIC,
 					  NULL, 0,
 					  &seq_oss_f_ops, NULL)) < 0) {
-		snd_printk(KERN_ERR "can't register device music\n");
+		pr_err("ALSA: seq_oss: can't register device music\n");
 		snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_SEQUENCER, NULL, 0);
 		mutex_unlock(&register_mutex);
 		return rc;
@@ -247,9 +247,9 @@ unregister_device(void)
 {
 	mutex_lock(&register_mutex);
 	if (snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_MUSIC, NULL, 0) < 0)		
-		snd_printk(KERN_ERR "error unregister device music\n");
+		pr_err("ALSA: seq_oss: error unregister device music\n");
 	if (snd_unregister_oss_device(SNDRV_OSS_DEVICE_TYPE_SEQUENCER, NULL, 0) < 0)
-		snd_printk(KERN_ERR "error unregister device seq\n");
+		pr_err("ALSA: seq_oss: error unregister device seq\n");
 	mutex_unlock(&register_mutex);
 }
 
diff --git a/sound/core/seq/oss/seq_oss_init.c b/sound/core/seq/oss/seq_oss_init.c
index b0ac6accf301..b9184d20c39f 100644
--- a/sound/core/seq/oss/seq_oss_init.c
+++ b/sound/core/seq/oss/seq_oss_init.c
@@ -189,7 +189,7 @@ snd_seq_oss_open(struct file *file, int level)
 
 	dp = kzalloc(sizeof(*dp), GFP_KERNEL);
 	if (!dp) {
-		snd_printk(KERN_ERR "can't malloc device info\n");
+		pr_err("ALSA: seq_oss: can't malloc device info\n");
 		return -ENOMEM;
 	}
 
@@ -204,7 +204,7 @@ snd_seq_oss_open(struct file *file, int level)
 
 	dp->index = i;
 	if (i >= SNDRV_SEQ_OSS_MAX_CLIENTS) {
-		snd_printk(KERN_ERR "too many applications\n");
+		pr_err("ALSA: seq_oss: too many applications\n");
 		rc = -ENOMEM;
 		goto _error;
 	}
@@ -214,7 +214,7 @@ snd_seq_oss_open(struct file *file, int level)
 	snd_seq_oss_midi_setup(dp);
 
 	if (dp->synth_opened == 0 && dp->max_mididev == 0) {
-		/* snd_printk(KERN_ERR "no device found\n"); */
+		/* pr_err("ALSA: seq_oss: no device found\n"); */
 		rc = -ENODEV;
 		goto _error;
 	}
@@ -222,7 +222,7 @@ snd_seq_oss_open(struct file *file, int level)
 	/* create port */
 	rc = create_port(dp);
 	if (rc < 0) {
-		snd_printk(KERN_ERR "can't create port\n");
+		pr_err("ALSA: seq_oss: can't create port\n");
 		goto _error;
 	}
 
@@ -263,7 +263,7 @@ snd_seq_oss_open(struct file *file, int level)
 	/* initialize timer */
 	dp->timer = snd_seq_oss_timer_new(dp);
 	if (!dp->timer) {
-		snd_printk(KERN_ERR "can't alloc timer\n");
+		pr_err("ALSA: seq_oss: can't alloc timer\n");
 		rc = -ENOMEM;
 		goto _error;
 	}
@@ -390,7 +390,7 @@ delete_seq_queue(int queue)
 	qinfo.queue = queue;
 	rc = call_ctl(SNDRV_SEQ_IOCTL_DELETE_QUEUE, &qinfo);
 	if (rc < 0)
-		printk(KERN_ERR "seq-oss: unable to delete queue %d (%d)\n", queue, rc);
+		pr_err("ALSA: seq_oss: unable to delete queue %d (%d)\n", queue, rc);
 	return rc;
 }
 
diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index 97f958b46542..3a4569669efa 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -174,7 +174,7 @@ snd_seq_oss_midi_check_new_port(struct snd_seq_port_info *pinfo)
 	 * allocate midi info record
 	 */
 	if ((mdev = kzalloc(sizeof(*mdev), GFP_KERNEL)) == NULL) {
-		snd_printk(KERN_ERR "can't malloc midi info\n");
+		pr_err("ALSA: seq_oss: can't malloc midi info\n");
 		return -ENOMEM;
 	}
 
@@ -190,7 +190,7 @@ snd_seq_oss_midi_check_new_port(struct snd_seq_port_info *pinfo)
 
 	/* create MIDI coder */
 	if (snd_midi_event_new(MAX_MIDI_EVENT_BUF, &mdev->coder) < 0) {
-		snd_printk(KERN_ERR "can't malloc midi coder\n");
+		pr_err("ALSA: seq_oss: can't malloc midi coder\n");
 		kfree(mdev);
 		return -ENOMEM;
 	}
diff --git a/sound/core/seq/oss/seq_oss_readq.c b/sound/core/seq/oss/seq_oss_readq.c
index 73661c4ab82a..654d17a5023c 100644
--- a/sound/core/seq/oss/seq_oss_readq.c
+++ b/sound/core/seq/oss/seq_oss_readq.c
@@ -48,12 +48,12 @@ snd_seq_oss_readq_new(struct seq_oss_devinfo *dp, int maxlen)
 	struct seq_oss_readq *q;
 
 	if ((q = kzalloc(sizeof(*q), GFP_KERNEL)) == NULL) {
-		snd_printk(KERN_ERR "can't malloc read queue\n");
+		pr_err("ALSA: seq_oss: can't malloc read queue\n");
 		return NULL;
 	}
 
 	if ((q->q = kcalloc(maxlen, sizeof(union evrec), GFP_KERNEL)) == NULL) {
-		snd_printk(KERN_ERR "can't malloc read queue buffer\n");
+		pr_err("ALSA: seq_oss: can't malloc read queue buffer\n");
 		kfree(q);
 		return NULL;
 	}
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 7333bfe827a7..701feb71b700 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -106,7 +106,7 @@ snd_seq_oss_synth_register(struct snd_seq_device *dev)
 	unsigned long flags;
 
 	if ((rec = kzalloc(sizeof(*rec), GFP_KERNEL)) == NULL) {
-		snd_printk(KERN_ERR "can't malloc synth info\n");
+		pr_err("ALSA: seq_oss: can't malloc synth info\n");
 		return -ENOMEM;
 	}
 	rec->seq_device = -1;
@@ -130,7 +130,7 @@ snd_seq_oss_synth_register(struct snd_seq_device *dev)
 	if (i >= max_synth_devs) {
 		if (max_synth_devs >= SNDRV_SEQ_OSS_MAX_SYNTH_DEVS) {
 			spin_unlock_irqrestore(&register_lock, flags);
-			snd_printk(KERN_ERR "no more synth slot\n");
+			pr_err("ALSA: seq_oss: no more synth slot\n");
 			kfree(rec);
 			return -ENOMEM;
 		}
@@ -162,7 +162,7 @@ snd_seq_oss_synth_unregister(struct snd_seq_device *dev)
 	}
 	if (index >= max_synth_devs) {
 		spin_unlock_irqrestore(&register_lock, flags);
-		snd_printk(KERN_ERR "can't unregister synth\n");
+		pr_err("ALSA: seq_oss: can't unregister synth\n");
 		return -EINVAL;
 	}
 	synth_devs[index] = NULL;
@@ -247,7 +247,7 @@ snd_seq_oss_synth_setup(struct seq_oss_devinfo *dp)
 		if (info->nr_voices > 0) {
 			info->ch = kcalloc(info->nr_voices, sizeof(struct seq_oss_chinfo), GFP_KERNEL);
 			if (!info->ch) {
-				snd_printk(KERN_ERR "Cannot malloc\n");
+				pr_err("ALSA: seq_oss: Cannot malloc voices\n");
 				rec->oper.close(&info->arg);
 				module_put(rec->oper.owner);
 				snd_use_lock_free(&rec->use_lock);
-- 
1.8.5.2
