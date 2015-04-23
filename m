From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/8] ALSA: core: Manage asound root directory
	with snd_info_entry
Date: Thu, 23 Apr 2015 16:49:26 +0200
Message-ID: <1429800570-10153-5-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 86DE0265969
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 27A78AD6B
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

This makes easier to release the all children.  Further cleanups will
follow.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 52 ++++++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 38 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 96451a130199..55c626eeb061 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -78,14 +78,13 @@ struct snd_info_private_data {
 };
 
 static int snd_info_version_init(void);
-static int snd_info_version_done(void);
 static void snd_info_disconnect(struct snd_info_entry *entry);
 
 /*
 
  */
 
-static struct proc_dir_entry *snd_proc_root;
+static struct snd_info_entry *snd_proc_root;
 struct snd_info_entry *snd_seq_root;
 EXPORT_SYMBOL(snd_seq_root);
 
@@ -462,14 +461,17 @@ static struct snd_info_entry *create_subdir(struct module *mod,
 	return entry;
 }
 
+static struct snd_info_entry *snd_info_create_entry(const char *name);
+
 int __init snd_info_init(void)
 {
-	struct proc_dir_entry *p;
-
-	p = proc_mkdir("asound", NULL);
-	if (p == NULL)
+	snd_proc_root = snd_info_create_entry("asound");
+	if (!snd_proc_root)
 		return -ENOMEM;
-	snd_proc_root = p;
+	snd_proc_root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	snd_proc_root->p = proc_mkdir("asound", NULL);
+	if (!snd_proc_root->p)
+		goto error;
 #ifdef CONFIG_SND_OSSEMUL
 	snd_oss_root = create_subdir(THIS_MODULE, "oss");
 	if (!snd_oss_root)
@@ -487,10 +489,7 @@ int __init snd_info_init(void)
 	return 0;
 
  error:
-#ifdef CONFIG_SND_OSSEMUL
-	snd_info_free_entry(snd_oss_root);
-#endif
-	proc_remove(snd_proc_root);
+	snd_info_free_entry(snd_proc_root);
 	return -ENOMEM;
 }
 
@@ -499,25 +498,11 @@ int __exit snd_info_done(void)
 	snd_card_info_done();
 	snd_minor_info_oss_done();
 	snd_minor_info_done();
-	snd_info_version_done();
-	if (snd_proc_root) {
-#if IS_ENABLED(CONFIG_SND_SEQUENCER)
-		snd_info_free_entry(snd_seq_root);
-#endif
-#ifdef CONFIG_SND_OSSEMUL
-		snd_info_free_entry(snd_oss_root);
-#endif
-		proc_remove(snd_proc_root);
-	}
+	snd_info_free_entry(snd_proc_root);
 	return 0;
 }
 
 /*
-
- */
-
-
-/*
  * create a card proc file
  * called from init.c
  */
@@ -551,7 +536,7 @@ int snd_info_card_register(struct snd_card *card)
 	if (!strcmp(card->id, card->proc_root->name))
 		return 0;
 
-	p = proc_symlink(card->id, snd_proc_root, card->proc_root->name);
+	p = proc_symlink(card->id, snd_proc_root->p, card->proc_root->name);
 	if (p == NULL)
 		return -ENOMEM;
 	card->proc_root_link = p;
@@ -570,7 +555,7 @@ void snd_info_card_id_change(struct snd_card *card)
 	}
 	if (strcmp(card->id, card->proc_root->name))
 		card->proc_root_link = proc_symlink(card->id,
-						    snd_proc_root,
+						    snd_proc_root->p,
 						    card->proc_root->name);
 	mutex_unlock(&info_mutex);
 }
@@ -815,7 +800,7 @@ int snd_info_register(struct snd_info_entry * entry)
 
 	if (snd_BUG_ON(!entry))
 		return -ENXIO;
-	root = entry->parent == NULL ? snd_proc_root : entry->parent->p;
+	root = entry->parent == NULL ? snd_proc_root->p : entry->parent->p;
 	mutex_lock(&info_mutex);
 	if (S_ISDIR(entry->mode)) {
 		p = proc_mkdir_mode(entry->name, entry->mode, root);
@@ -850,8 +835,6 @@ EXPORT_SYMBOL(snd_info_register);
 
  */
 
-static struct snd_info_entry *snd_info_version_entry;
-
 static void snd_info_version_read(struct snd_info_entry *entry, struct snd_info_buffer *buffer)
 {
 	snd_iprintf(buffer,
@@ -871,13 +854,6 @@ static int __init snd_info_version_init(void)
 		snd_info_free_entry(entry);
 		return -ENOMEM;
 	}
-	snd_info_version_entry = entry;
-	return 0;
-}
-
-static int __exit snd_info_version_done(void)
-{
-	snd_info_free_entry(snd_info_version_entry);
 	return 0;
 }
 
-- 
2.3.5
