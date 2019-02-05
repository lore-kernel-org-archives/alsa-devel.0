From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: info: Move card id proc creation
	into info.c
Date: Tue,  5 Feb 2019 17:07:57 +0100
Message-ID: <20190205160758.9172-4-tiwai@suse.de>
References: <20190205160758.9172-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A34AD2678FD
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2019 17:08:01 +0100 (CET)
In-Reply-To: <20190205160758.9172-1-tiwai@suse.de>
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

The creation of card's id proc file can be moved gracefully into
info.c.  Also, the assignment of card->proc_id is superfluous and can
be dropped.  So let's do it.

Basically this is no functional change but code refactoring, but one
potential behavior change is that now it returns properly the error
code from snd_info_card_register().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  1 -
 sound/core/info.c    | 11 ++++++++++-
 sound/core/init.c    | 33 ++++-----------------------------
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 36a5934cf4b1..e923c23e05dd 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -120,7 +120,6 @@ struct snd_card {
 	struct list_head ctl_files;	/* active control files */
 
 	struct snd_info_entry *proc_root;	/* root for soundcard specific files */
-	struct snd_info_entry *proc_id;	/* the card id */
 	struct proc_dir_entry *proc_root_link;	/* number link to real id */
 
 	struct list_head files_list;	/* all files associated to this card */
diff --git a/sound/core/info.c b/sound/core/info.c
index 12b80e6d9ee4..f8e054b9f1ae 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -504,6 +504,14 @@ int __exit snd_info_done(void)
 	return 0;
 }
 
+static void snd_card_id_read(struct snd_info_entry *entry,
+			     struct snd_info_buffer *buffer)
+{
+	struct snd_card *card = entry->private_data;
+
+	snd_iprintf(buffer, "%s\n", card->id);
+}
+
 /*
  * create a card proc file
  * called from init.c
@@ -521,7 +529,8 @@ int snd_info_card_create(struct snd_card *card)
 	if (!entry)
 		return -ENOMEM;
 	card->proc_root = entry;
-	return 0;
+
+	return snd_card_ro_proc_new(card, "id", card, snd_card_id_read);
 }
 
 /*
diff --git a/sound/core/init.c b/sound/core/init.c
index 5252a9ce13dc..0c4dc40376a7 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -100,33 +100,6 @@ int (*snd_mixer_oss_notify_callback)(struct snd_card *card, int free_flag);
 EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
 #endif
 
-#ifdef CONFIG_SND_PROC_FS
-static void snd_card_id_read(struct snd_info_entry *entry,
-			     struct snd_info_buffer *buffer)
-{
-	struct snd_card *card = entry->private_data;
-
-	snd_iprintf(buffer, "%s\n", card->id);
-}
-
-static int init_info_for_card(struct snd_card *card)
-{
-	struct snd_info_entry *entry;
-
-	entry = snd_info_create_card_entry(card, "id", card->proc_root);
-	if (!entry) {
-		dev_dbg(card->dev, "unable to create card entry\n");
-		return -ENOMEM;
-	}
-	snd_info_set_text_ops(entry, card, snd_card_id_read);
-	card->proc_id = entry;
-
-	return snd_info_card_register(card);
-}
-#else /* !CONFIG_SND_PROC_FS */
-#define init_info_for_card(card)
-#endif
-
 static int check_empty_slot(struct module *module, int slot)
 {
 	return !slots[slot] || !*slots[slot];
@@ -493,7 +466,6 @@ static int snd_card_do_free(struct snd_card *card)
 	snd_device_free_all(card);
 	if (card->private_free)
 		card->private_free(card);
-	snd_info_free_entry(card->proc_id);
 	if (snd_info_card_free(card) < 0) {
 		dev_warn(card->dev, "unable to free card info\n");
 		/* Not fatal error */
@@ -797,7 +769,10 @@ int snd_card_register(struct snd_card *card)
 	}
 	snd_cards[card->number] = card;
 	mutex_unlock(&snd_card_mutex);
-	init_info_for_card(card);
+	err = snd_info_card_register(card);
+	if (err < 0)
+		return err;
+
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_REGISTER);
-- 
2.16.4
