From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/8] ALSA: core: Fix possible memory leaks at
	error path in info.c
Date: Thu, 23 Apr 2015 16:49:24 +0200
Message-ID: <1429800570-10153-3-git-send-email-tiwai@suse.de>
References: <1429800570-10153-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D6C8264F74
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 16:49:38 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 145C6AD28
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

snd_info_init() just returns an error without releasing the previously
assigned resources at error path.  The assigned proc and info entries
have to be released properly.

While we are at it, refactor the code a bit, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 62 +++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 8c1275f0fcbd..9c6db5c24da7 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -446,6 +446,22 @@ static const struct file_operations snd_info_text_entry_ops =
 	.read =			seq_read,
 };
 
+static struct snd_info_entry *create_subdir(struct module *mod,
+					    const char *name)
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_module_entry(mod, name, NULL);
+	if (!entry)
+		return NULL;
+	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
+	if (snd_info_register(entry) < 0) {
+		snd_info_free_entry(entry);
+		return NULL;
+	}
+	return entry;
+}
+
 int __init snd_info_init(void)
 {
 	struct proc_dir_entry *p;
@@ -455,36 +471,27 @@ int __init snd_info_init(void)
 		return -ENOMEM;
 	snd_proc_root = p;
 #ifdef CONFIG_SND_OSSEMUL
-	{
-		struct snd_info_entry *entry;
-		if ((entry = snd_info_create_module_entry(THIS_MODULE, "oss", NULL)) == NULL)
-			return -ENOMEM;
-		entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			return -ENOMEM;
-		}
-		snd_oss_root = entry;
-	}
+	snd_oss_root = create_subdir(THIS_MODULE, "oss");
+	if (!snd_oss_root)
+		goto error;
 #endif
 #if IS_ENABLED(CONFIG_SND_SEQUENCER)
-	{
-		struct snd_info_entry *entry;
-		if ((entry = snd_info_create_module_entry(THIS_MODULE, "seq", NULL)) == NULL)
-			return -ENOMEM;
-		entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
-		if (snd_info_register(entry) < 0) {
-			snd_info_free_entry(entry);
-			return -ENOMEM;
-		}
-		snd_seq_root = entry;
-	}
+	snd_seq_root = create_subdir(THIS_MODULE, "seq");
+	if (!snd_seq_root)
+		goto error;
 #endif
 	snd_info_version_init();
 	snd_minor_info_init();
 	snd_minor_info_oss_init();
 	snd_card_info_init();
 	return 0;
+
+ error:
+#ifdef CONFIG_SND_OSSEMUL
+	snd_info_free_entry(snd_oss_root);
+#endif
+	proc_remove(snd_proc_root);
+	return -ENOMEM;
 }
 
 int __exit snd_info_done(void)
@@ -523,13 +530,9 @@ int snd_info_card_create(struct snd_card *card)
 		return -ENXIO;
 
 	sprintf(str, "card%i", card->number);
-	if ((entry = snd_info_create_module_entry(card->module, str, NULL)) == NULL)
-		return -ENOMEM;
-	entry->mode = S_IFDIR | S_IRUGO | S_IXUGO;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
+	entry = create_subdir(card->module, str);
+	if (!entry)
 		return -ENOMEM;
-	}
 	card->proc_root = entry;
 	return 0;
 }
@@ -758,7 +761,6 @@ EXPORT_SYMBOL(snd_info_create_card_entry);
 static void snd_info_disconnect(struct snd_info_entry *entry)
 {
 	struct list_head *p, *n;
-	struct proc_dir_entry *root;
 
 	list_for_each_safe(p, n, &entry->children) {
 		snd_info_disconnect(list_entry(p, struct snd_info_entry, list));
@@ -767,8 +769,6 @@ static void snd_info_disconnect(struct snd_info_entry *entry)
 	if (! entry->p)
 		return;
 	list_del_init(&entry->list);
-	root = entry->parent == NULL ? snd_proc_root : entry->parent->p;
-	snd_BUG_ON(!root);
 	proc_remove(entry->p);
 	entry->p = NULL;
 }
-- 
2.3.5
