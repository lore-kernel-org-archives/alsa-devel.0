Return-Path: <SRS0=BIVw=Y7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9FEC5DF60
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D312084C
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BdGvW+HQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D312084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2BBA1697;
	Thu,  7 Nov 2019 20:22:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2BBA1697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573154612;
	bh=QX3i6MgvIqscdvcoh/3XRkouDg9qVcVp0I6BAXBW5sM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BdGvW+HQFP+Hptlu1RlgGZtKrSvujML+5Pn0Fk+NubIRof6P7OyYCI2DA07U1NxY2
	 mKp6hXJxJsdMgD1DMMdUvx1e8pvuIbr4Ka8GCz6zSBurHkS7hhq64A1JSg3wTRZ4UO
	 5Bzl4/eCFy8GUYaMdyP3dl8Vs9YKe17hhFjJiGow=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FD96F8060F;
	Thu,  7 Nov 2019 20:20:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2AB6FF805FE; Thu,  7 Nov 2019 20:20:18 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A460F8049B
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 20:20:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A460F8049B
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 28C98B1E8
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2019 19:20:13 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  7 Nov 2019 20:20:08 +0100
Message-Id: <20191107192008.32331-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191107192008.32331-1-tiwai@suse.de>
References: <20191107192008.32331-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 3/3] ALSA: timer: Fix possible race at
	assigning a timer instance
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

When a new timer instance is created and assigned to the active link
in snd_timer_open(), the caller still doesn't (can't) set its callback
and callback data.  In both the user-timer and the sequencer-timer
code, they do manually set up the callbacks after calling
snd_timer_open().  This has a potential risk of race when the timer
instance is added to the already running timer target, as the callback
might get triggered during setting up the callback itself.

This patch tries to address it by changing the API usage slightly:

- An empty timer instance is created at first via the new function
  snd_timer_instance_new().  This object isn't linked to the timer
  list yet.
- The caller sets up the callbacks and others stuff for the new timer
  instance.
- The caller invokes snd_timer_open() with this instance, so that it's
  linked to the target timer.

For closing, do similarly:

- Call snd_timer_close().  This unlinks the timer instance from the
  timer list.
- Free the timer instance via snd_timer_instance_free() after that.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/timer.h      |  4 +-
 sound/core/seq/seq_timer.c | 18 ++++++---
 sound/core/timer.c         | 97 +++++++++++++++++++++++-----------------------
 3 files changed, 63 insertions(+), 56 deletions(-)

diff --git a/include/sound/timer.h b/include/sound/timer.h
index 8a13c09c85f7..a53e37bcd746 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -118,7 +118,9 @@ int snd_timer_global_new(char *id, int device, struct snd_timer **rtimer);
 int snd_timer_global_free(struct snd_timer *timer);
 int snd_timer_global_register(struct snd_timer *timer);
 
-int snd_timer_open(struct snd_timer_instance **ti, char *owner, struct snd_timer_id *tid, unsigned int slave_id);
+struct snd_timer_instance *snd_timer_instance_new(const char *owner);
+void snd_timer_instance_free(struct snd_timer_instance *timeri);
+int snd_timer_open(struct snd_timer_instance *timeri, struct snd_timer_id *tid, unsigned int slave_id);
 void snd_timer_close(struct snd_timer_instance *timeri);
 unsigned long snd_timer_resolution(struct snd_timer_instance *timeri);
 int snd_timer_start(struct snd_timer_instance *timeri, unsigned int ticks);
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 161f3170bd7e..63dc7bdb622d 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -272,7 +272,13 @@ int snd_seq_timer_open(struct snd_seq_queue *q)
 		return -EINVAL;
 	if (tmr->alsa_id.dev_class != SNDRV_TIMER_CLASS_SLAVE)
 		tmr->alsa_id.dev_sclass = SNDRV_TIMER_SCLASS_SEQUENCER;
-	err = snd_timer_open(&t, str, &tmr->alsa_id, q->queue);
+	t = snd_timer_instance_new(str);
+	if (!t)
+		return -ENOMEM;
+	t->callback = snd_seq_timer_interrupt;
+	t->callback_data = q;
+	t->flags |= SNDRV_TIMER_IFLG_AUTO;
+	err = snd_timer_open(t, &tmr->alsa_id, q->queue);
 	if (err < 0 && tmr->alsa_id.dev_class != SNDRV_TIMER_CLASS_SLAVE) {
 		if (tmr->alsa_id.dev_class != SNDRV_TIMER_CLASS_GLOBAL ||
 		    tmr->alsa_id.device != SNDRV_TIMER_GLOBAL_SYSTEM) {
@@ -282,16 +288,14 @@ int snd_seq_timer_open(struct snd_seq_queue *q)
 			tid.dev_sclass = SNDRV_TIMER_SCLASS_SEQUENCER;
 			tid.card = -1;
 			tid.device = SNDRV_TIMER_GLOBAL_SYSTEM;
-			err = snd_timer_open(&t, str, &tid, q->queue);
+			err = snd_timer_open(t, &tid, q->queue);
 		}
 	}
 	if (err < 0) {
 		pr_err("ALSA: seq fatal error: cannot create timer (%i)\n", err);
+		snd_timer_instance_free(t);
 		return err;
 	}
-	t->callback = snd_seq_timer_interrupt;
-	t->callback_data = q;
-	t->flags |= SNDRV_TIMER_IFLG_AUTO;
 	spin_lock_irq(&tmr->lock);
 	tmr->timeri = t;
 	spin_unlock_irq(&tmr->lock);
@@ -310,8 +314,10 @@ int snd_seq_timer_close(struct snd_seq_queue *q)
 	t = tmr->timeri;
 	tmr->timeri = NULL;
 	spin_unlock_irq(&tmr->lock);
-	if (t)
+	if (t) {
 		snd_timer_close(t);
+		snd_timer_instance_free(t);
+	}
 	return 0;
 }
 
diff --git a/sound/core/timer.c b/sound/core/timer.c
index c0a73913ec62..9091030f4a89 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -88,12 +88,11 @@ static void snd_timer_reschedule(struct snd_timer * timer, unsigned long ticks_l
 
 /*
  * create a timer instance with the given owner string.
- * when timer is not NULL, increments the module counter
  */
-static struct snd_timer_instance *snd_timer_instance_new(char *owner,
-							 struct snd_timer *timer)
+struct snd_timer_instance *snd_timer_instance_new(const char *owner)
 {
 	struct snd_timer_instance *timeri;
+
 	timeri = kzalloc(sizeof(*timeri), GFP_KERNEL);
 	if (timeri == NULL)
 		return NULL;
@@ -108,15 +107,20 @@ static struct snd_timer_instance *snd_timer_instance_new(char *owner,
 	INIT_LIST_HEAD(&timeri->slave_list_head);
 	INIT_LIST_HEAD(&timeri->slave_active_head);
 
-	timeri->timer = timer;
-	if (timer && !try_module_get(timer->module)) {
+	return timeri;
+}
+EXPORT_SYMBOL(snd_timer_instance_new);
+
+void snd_timer_instance_free(struct snd_timer_instance *timeri)
+{
+	if (timeri) {
+		if (timeri->private_free)
+			timeri->private_free(timeri);
 		kfree(timeri->owner);
 		kfree(timeri);
-		return NULL;
 	}
-
-	return timeri;
 }
+EXPORT_SYMBOL(snd_timer_instance_free);
 
 /*
  * find a timer instance from the given timer id
@@ -236,12 +240,11 @@ static void snd_timer_close_locked(struct snd_timer_instance *timeri,
  * open a timer instance
  * when opening a master, the slave id must be here given.
  */
-int snd_timer_open(struct snd_timer_instance **ti,
-		   char *owner, struct snd_timer_id *tid,
+int snd_timer_open(struct snd_timer_instance *timeri,
+		   struct snd_timer_id *tid,
 		   unsigned int slave_id)
 {
 	struct snd_timer *timer;
-	struct snd_timer_instance *timeri = NULL;
 	struct device *card_dev_to_put = NULL;
 	int err;
 
@@ -259,22 +262,14 @@ int snd_timer_open(struct snd_timer_instance **ti,
 			err = -EBUSY;
 			goto unlock;
 		}
-		timeri = snd_timer_instance_new(owner, NULL);
-		if (!timeri) {
-			err = -ENOMEM;
-			goto unlock;
-		}
 		timeri->slave_class = tid->dev_sclass;
 		timeri->slave_id = tid->device;
 		timeri->flags |= SNDRV_TIMER_IFLG_SLAVE;
 		list_add_tail(&timeri->open_list, &snd_timer_slave_list);
 		num_slaves++;
 		err = snd_timer_check_slave(timeri);
-		if (err < 0) {
-			snd_timer_close_locked(timeri, &card_dev_to_put);
-			timeri = NULL;
-		}
-		goto unlock;
+		if (err < 0)
+			goto close;
 	}
 
 	/* open a master instance */
@@ -304,45 +299,40 @@ int snd_timer_open(struct snd_timer_instance **ti,
 		err = -EBUSY;
 		goto unlock;
 	}
-	timeri = snd_timer_instance_new(owner, timer);
-	if (!timeri) {
-		err = -ENOMEM;
+	if (!try_module_get(timer->module)) {
+		err = -EBUSY;
 		goto unlock;
 	}
 	/* take a card refcount for safe disconnection */
-	if (timer->card)
+	if (timer->card) {
 		get_device(&timer->card->card_dev);
-	timeri->slave_class = tid->dev_sclass;
-	timeri->slave_id = slave_id;
+		card_dev_to_put = &timer->card->card_dev;
+	}
 
 	if (list_empty(&timer->open_list_head) && timer->hw.open) {
 		err = timer->hw.open(timer);
 		if (err) {
-			kfree(timeri->owner);
-			kfree(timeri);
-			timeri = NULL;
-
-			if (timer->card)
-				card_dev_to_put = &timer->card->card_dev;
 			module_put(timer->module);
 			goto unlock;
 		}
 	}
 
+	timeri->timer = timer;
+	timeri->slave_class = tid->dev_sclass;
+	timeri->slave_id = slave_id;
+
 	list_add_tail(&timeri->open_list, &timer->open_list_head);
 	timer->num_instances++;
 	err = snd_timer_check_master(timeri);
-	if (err < 0) {
+ close:
+	if (err < 0)
 		snd_timer_close_locked(timeri, &card_dev_to_put);
-		timeri = NULL;
-	}
 
  unlock:
 	mutex_unlock(&register_mutex);
 	/* put_device() is called after unlock for avoiding deadlock */
-	if (card_dev_to_put)
+	if (err < 0 && card_dev_to_put)
 		put_device(card_dev_to_put);
-	*ti = timeri;
 	return err;
 }
 EXPORT_SYMBOL(snd_timer_open);
@@ -363,9 +353,11 @@ static void snd_timer_close_locked(struct snd_timer_instance *timeri,
 		spin_unlock_irq(&timer->lock);
 	}
 
-	list_del(&timeri->open_list);
-	if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
-		num_slaves--;
+	if (!list_empty(&timeri->open_list)) {
+		list_del_init(&timeri->open_list);
+		if (timeri->flags & SNDRV_TIMER_IFLG_SLAVE)
+			num_slaves--;
+	}
 
 	/* force to stop the timer */
 	snd_timer_stop(timeri);
@@ -384,6 +376,7 @@ static void snd_timer_close_locked(struct snd_timer_instance *timeri,
 		/* remove slave links */
 		spin_lock_irq(&slave_active_lock);
 		spin_lock(&timer->lock);
+		timeri->timer = NULL;
 		list_for_each_entry_safe(slave, tmp, &timeri->slave_list_head,
 					 open_list) {
 			list_move_tail(&slave->open_list, &snd_timer_slave_list);
@@ -401,11 +394,6 @@ static void snd_timer_close_locked(struct snd_timer_instance *timeri,
 			timer = NULL;
 	}
 
-	if (timeri->private_free)
-		timeri->private_free(timeri);
-	kfree(timeri->owner);
-	kfree(timeri);
-
 	if (timer) {
 		if (list_empty(&timer->open_list_head) && timer->hw.close)
 			timer->hw.close(timer);
@@ -1480,8 +1468,10 @@ static int snd_timer_user_release(struct inode *inode, struct file *file)
 		tu = file->private_data;
 		file->private_data = NULL;
 		mutex_lock(&tu->ioctl_lock);
-		if (tu->timeri)
+		if (tu->timeri) {
 			snd_timer_close(tu->timeri);
+			snd_timer_instance_free(tu->timeri);
+		}
 		mutex_unlock(&tu->ioctl_lock);
 		kfree(tu->queue);
 		kfree(tu->tqueue);
@@ -1722,6 +1712,7 @@ static int snd_timer_user_tselect(struct file *file,
 	tu = file->private_data;
 	if (tu->timeri) {
 		snd_timer_close(tu->timeri);
+		snd_timer_instance_free(tu->timeri);
 		tu->timeri = NULL;
 	}
 	if (copy_from_user(&tselect, _tselect, sizeof(tselect))) {
@@ -1731,9 +1722,11 @@ static int snd_timer_user_tselect(struct file *file,
 	sprintf(str, "application %i", current->pid);
 	if (tselect.id.dev_class != SNDRV_TIMER_CLASS_SLAVE)
 		tselect.id.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
-	err = snd_timer_open(&tu->timeri, str, &tselect.id, current->pid);
-	if (err < 0)
+	tu->timeri = snd_timer_instance_new(str);
+	if (!tu->timeri) {
+		err = -ENOMEM;
 		goto __err;
+	}
 
 	tu->timeri->flags |= SNDRV_TIMER_IFLG_FAST;
 	tu->timeri->callback = tu->tread
@@ -1742,6 +1735,12 @@ static int snd_timer_user_tselect(struct file *file,
 	tu->timeri->callback_data = (void *)tu;
 	tu->timeri->disconnect = snd_timer_user_disconnect;
 
+	err = snd_timer_open(tu->timeri, &tselect.id, current->pid);
+	if (err < 0) {
+		snd_timer_instance_free(tu->timeri);
+		tu->timeri = NULL;
+	}
+
       __err:
 	return err;
 }
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
