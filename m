From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/8] ALSA: core: Remove child proc file
	elements recursively
Date: Thu, 23 Apr 2015 16:49:25 +0200
Message-ID: <1429800570-10153-4-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B803264ED3
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 20C0AAD31
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 14:49:38 +0000 (UTC)
In-Reply-To: <1429800570-10153-1-git-send-email-tiwai@suse.de>
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

This patch changes the way to managing the resource release of proc
files: namely, let snd_info_free_entry() freeing the whole children.
Then we can drop the snd_device_*() management and snd_card_proc_new()
can be merely a wrapper to snd_info_create_card_entry().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/info.h |  9 ++++--
 sound/core/info.c    | 79 +++++++++-------------------------------------------
 2 files changed, 20 insertions(+), 68 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index ff8962ebece5..3e2fda3c75ee 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -24,6 +24,7 @@
 
 #include <linux/poll.h>
 #include <linux/seq_file.h>
+#include <sound/core.h>
 
 /* buffer for information */
 struct snd_info_buffer {
@@ -146,8 +147,12 @@ void snd_info_card_id_change(struct snd_card *card);
 int snd_info_register(struct snd_info_entry *entry);
 
 /* for card drivers */
-int snd_card_proc_new(struct snd_card *card, const char *name,
-		      struct snd_info_entry **entryp);
+static inline int snd_card_proc_new(struct snd_card *card, const char *name,
+				    struct snd_info_entry **entryp)
+{
+	*entryp = snd_info_create_card_entry(card, name, card->proc_root);
+	return *entryp ? 0 : -ENOMEM;
+}
 
 static inline void snd_info_set_text_ops(struct snd_info_entry *entry, 
 	void *private_data,
diff --git a/sound/core/info.c b/sound/core/info.c
index 9c6db5c24da7..96451a130199 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -760,92 +760,39 @@ EXPORT_SYMBOL(snd_info_create_card_entry);
 
 static void snd_info_disconnect(struct snd_info_entry *entry)
 {
-	struct list_head *p, *n;
+	struct snd_info_entry *p, *n;
 
-	list_for_each_safe(p, n, &entry->children) {
-		snd_info_disconnect(list_entry(p, struct snd_info_entry, list));
-	}
-
-	if (! entry->p)
+	if (!entry->p)
 		return;
+	list_for_each_entry_safe(p, n, &entry->children, list)
+		snd_info_disconnect(p);
 	list_del_init(&entry->list);
 	proc_remove(entry->p);
 	entry->p = NULL;
 }
 
-static int snd_info_dev_free_entry(struct snd_device *device)
-{
-	struct snd_info_entry *entry = device->device_data;
-	snd_info_free_entry(entry);
-	return 0;
-}
-
-static int snd_info_dev_register_entry(struct snd_device *device)
-{
-	struct snd_info_entry *entry = device->device_data;
-	return snd_info_register(entry);
-}
-
-/**
- * snd_card_proc_new - create an info entry for the given card
- * @card: the card instance
- * @name: the file name
- * @entryp: the pointer to store the new info entry
- *
- * Creates a new info entry and assigns it to the given card.
- * Unlike snd_info_create_card_entry(), this function registers the
- * info entry as an ALSA device component, so that it can be
- * unregistered/released without explicit call.
- * Also, you don't have to register this entry via snd_info_register(),
- * since this will be registered by snd_card_register() automatically.
- *
- * The parent is assumed as card->proc_root.
- *
- * For releasing this entry, use snd_device_free() instead of
- * snd_info_free_entry(). 
- *
- * Return: Zero if successful, or a negative error code on failure.
- */
-int snd_card_proc_new(struct snd_card *card, const char *name,
-		      struct snd_info_entry **entryp)
-{
-	static struct snd_device_ops ops = {
-		.dev_free = snd_info_dev_free_entry,
-		.dev_register =	snd_info_dev_register_entry,
-		/* disconnect is done via snd_info_card_disconnect() */
-	};
-	struct snd_info_entry *entry;
-	int err;
-
-	entry = snd_info_create_card_entry(card, name, card->proc_root);
-	if (! entry)
-		return -ENOMEM;
-	if ((err = snd_device_new(card, SNDRV_DEV_INFO, entry, &ops)) < 0) {
-		snd_info_free_entry(entry);
-		return err;
-	}
-	if (entryp)
-		*entryp = entry;
-	return 0;
-}
-
-EXPORT_SYMBOL(snd_card_proc_new);
-
 /**
  * snd_info_free_entry - release the info entry
  * @entry: the info entry
  *
- * Releases the info entry.  Don't call this after registered.
+ * Releases the info entry.
  */
 void snd_info_free_entry(struct snd_info_entry * entry)
 {
-	if (entry == NULL)
+	struct snd_info_entry *p, *n;
+
+	if (!entry)
 		return;
 	if (entry->p) {
 		mutex_lock(&info_mutex);
 		snd_info_disconnect(entry);
 		mutex_unlock(&info_mutex);
 	}
+
+	/* free all children at first */
+	list_for_each_entry_safe(p, n, &entry->children, list)
+		snd_info_free_entry(p);
+
 	kfree(entry->name);
 	if (entry->private_free)
 		entry->private_free(entry);
-- 
2.3.5
