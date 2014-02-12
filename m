From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: Use standard device refcount for
	card accounting
Date: Wed, 12 Feb 2014 12:20:13 +0100
Message-ID: <1392204013-12334-4-git-send-email-tiwai@suse.de>
References: <1392204013-12334-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A057A2650C3
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 12:20:14 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 90AFCABFB
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:20:14 +0000 (UTC)
In-Reply-To: <1392204013-12334-1-git-send-email-tiwai@suse.de>
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

Drop the own refcount but use the standard device refcounting via
get_device() and put_device().  Introduce a new completion to snd_card
instead of the wait queue for syncing the last release, which is used
in snd_card_free().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h   |  7 +++----
 sound/core/init.c      | 53 ++++++++++++++------------------------------------
 sound/core/sound.c     |  2 +-
 sound/core/sound_oss.c |  2 +-
 4 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index f072e596f21a..f410a49862fd 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -42,6 +42,7 @@
 /* forward declarations */
 struct pci_dev;
 struct module;
+struct completion;
 
 /* device allocation stuff */
 
@@ -126,9 +127,7 @@ struct snd_card {
 								state */
 	spinlock_t files_lock;		/* lock the files for this card */
 	int shutdown;			/* this card is going down */
-	int free_on_last_close;		/* free in context of file_release */
-	wait_queue_head_t shutdown_sleep;
-	atomic_t refcount;		/* refcount for disconnection */
+	struct completion *release_completion;
 	struct device *dev;		/* device assigned to this card */
 	struct device card_dev;		/* cardX object for sysfs */
 	bool registered;		/* card_dev is registered? */
@@ -302,7 +301,7 @@ int snd_card_info_done(void);
 int snd_component_add(struct snd_card *card, const char *component);
 int snd_card_file_add(struct snd_card *card, struct file *file);
 int snd_card_file_remove(struct snd_card *card, struct file *file);
-void snd_card_unref(struct snd_card *card);
+#define snd_card_unref(card)	put_device(&(card)->card_dev)
 
 #define snd_card_set_dev(card, devptr) ((card)->dev = (devptr))
 
diff --git a/sound/core/init.c b/sound/core/init.c
index 46a9e7cb1c04..3fdb4e2ce5ea 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -28,6 +28,7 @@
 #include <linux/time.h>
 #include <linux/ctype.h>
 #include <linux/pm.h>
+#include <linux/completion.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -235,8 +236,6 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	INIT_LIST_HEAD(&card->ctl_files);
 	spin_lock_init(&card->files_lock);
 	INIT_LIST_HEAD(&card->files_list);
-	init_waitqueue_head(&card->shutdown_sleep);
-	atomic_set(&card->refcount, 0);
 #ifdef CONFIG_PM
 	mutex_init(&card->power_lock);
 	init_waitqueue_head(&card->power_sleep);
@@ -466,58 +465,36 @@ static int snd_card_do_free(struct snd_card *card)
 		snd_printk(KERN_WARNING "unable to free card info\n");
 		/* Not fatal error */
 	}
+	if (card->release_completion)
+		complete(card->release_completion);
 	kfree(card);
 	return 0;
 }
 
-/**
- * snd_card_unref - release the reference counter
- * @card: the card instance
- *
- * Decrements the reference counter.  When it reaches to zero, wake up
- * the sleeper and call the destructor if needed.
- */
-void snd_card_unref(struct snd_card *card)
-{
-	if (atomic_dec_and_test(&card->refcount)) {
-		wake_up(&card->shutdown_sleep);
-		if (card->free_on_last_close)
-			put_device(&card->card_dev);
-	}
-}
-EXPORT_SYMBOL(snd_card_unref);
-
 int snd_card_free_when_closed(struct snd_card *card)
 {
-	int ret;
-
-	atomic_inc(&card->refcount);
-	ret = snd_card_disconnect(card);
-	if (ret) {
-		atomic_dec(&card->refcount);
+	int ret = snd_card_disconnect(card);
+	if (ret)
 		return ret;
-	}
-
-	card->free_on_last_close = 1;
-	if (atomic_dec_and_test(&card->refcount))
-		put_device(&card->card_dev);
+	put_device(&card->card_dev);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_card_free_when_closed);
 
 int snd_card_free(struct snd_card *card)
 {
-	int ret = snd_card_disconnect(card);
+	struct completion released;
+	int ret;
+
+	init_completion(&released);
+	card->release_completion = &released;
+	ret = snd_card_free_when_closed(card);
 	if (ret)
 		return ret;
-
 	/* wait, until all devices are ready for the free operation */
-	wait_event(card->shutdown_sleep, !atomic_read(&card->refcount));
-	put_device(&card->card_dev);
+	wait_for_completion(&released);
 	return 0;
 }
-
 EXPORT_SYMBOL(snd_card_free);
 
 /* retrieve the last word of shortname or longname */
@@ -924,7 +901,7 @@ int snd_card_file_add(struct snd_card *card, struct file *file)
 		return -ENODEV;
 	}
 	list_add(&mfile->list, &card->files_list);
-	atomic_inc(&card->refcount);
+	get_device(&card->card_dev);
 	spin_unlock(&card->files_lock);
 	return 0;
 }
@@ -967,7 +944,7 @@ int snd_card_file_remove(struct snd_card *card, struct file *file)
 		return -ENOENT;
 	}
 	kfree(found);
-	snd_card_unref(card);
+	put_device(&card->card_dev);
 	return 0;
 }
 
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 437c25ea6403..4aaa53161644 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -118,7 +118,7 @@ void *snd_lookup_minor_data(unsigned int minor, int type)
 	if (mreg && mreg->type == type) {
 		private_data = mreg->private_data;
 		if (private_data && mreg->card_ptr)
-			atomic_inc(&mreg->card_ptr->refcount);
+			get_device(&mreg->card_ptr->card_dev);
 	} else
 		private_data = NULL;
 	mutex_unlock(&sound_mutex);
diff --git a/sound/core/sound_oss.c b/sound/core/sound_oss.c
index b19184d45f19..573a65eb2b79 100644
--- a/sound/core/sound_oss.c
+++ b/sound/core/sound_oss.c
@@ -55,7 +55,7 @@ void *snd_lookup_oss_minor_data(unsigned int minor, int type)
 	if (mreg && mreg->type == type) {
 		private_data = mreg->private_data;
 		if (private_data && mreg->card_ptr)
-			atomic_inc(&mreg->card_ptr->refcount);
+			get_device(&mreg->card_ptr->card_dev);
 	} else
 		private_data = NULL;
 	mutex_unlock(&sound_oss_mutex);
-- 
1.8.5.2
