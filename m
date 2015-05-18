From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: info: Register proc entries
	recursively, too
Date: Mon, 18 May 2015 09:57:02 +0200
Message-ID: <1431935824-8670-3-git-send-email-tiwai@suse.de>
References: <1431935824-8670-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C7BB2604A9
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 09:57:07 +0200 (CEST)
In-Reply-To: <1431935824-8670-1-git-send-email-tiwai@suse.de>
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
Cc: libin.yang@intel.com, han.lu@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The commit [c560a6797e3b: ALSA: core: Remove child proc file elements
recursively] converted snd_card_proc_new() with the normal
snd_info_*() call and removed snd_device chain for such info
entries. However, it misses one point: the creation of the proc entry
was managed by snd_device chain in the former code, and now it's also
gone, which results in no proc files creation at all.  Mea culpa.

This patch makes snd_info_card_register() creating the all pending
child proc entries in a shot.  Also, since snd_card_register() might
be called multiple times, this function is also changed to be callable
multiple times.

Along with the changes above, now the linked list of snd_info_entry is
added at creation time instead of snd_info_register() for keeping eyes
of pending info entries.

Fixes: c560a6797e3b ('ALSA: core: Remove child proc file elements recursively')
Reported-by: "Lu, Han" <han.lu@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 37 ++++++++++++++++++++++++++++++++++---
 sound/core/init.c | 18 ++++++------------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 566279374683..13b174464cc8 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -515,22 +515,51 @@ int snd_info_card_create(struct snd_card *card)
 	return 0;
 }
 
+/* register all pending info entries */
+static int snd_info_register_recursive(struct snd_info_entry *entry)
+{
+	struct snd_info_entry *p;
+	int err;
+
+	if (!entry->p) {
+		err = snd_info_register(entry);
+		if (err < 0)
+			return err;
+	}
+
+	list_for_each_entry(p, &entry->children, list) {
+		err = snd_info_register_recursive(p);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 /*
  * register the card proc file
  * called from init.c
+ * can be called multiple times for reinitialization
  */
 int snd_info_card_register(struct snd_card *card)
 {
 	struct proc_dir_entry *p;
+	int err;
 
 	if (snd_BUG_ON(!card))
 		return -ENXIO;
 
+	err = snd_info_register_recursive(card->proc_root);
+	if (err < 0)
+		return err;
+
 	if (!strcmp(card->id, card->proc_root->name))
 		return 0;
 
+	if (card->proc_root_link)
+		return 0;
 	p = proc_symlink(card->id, snd_proc_root->p, card->proc_root->name);
-	if (p == NULL)
+	if (!p)
 		return -ENOMEM;
 	card->proc_root_link = p;
 	return 0;
@@ -705,6 +734,8 @@ struct snd_info_entry *snd_info_create_module_entry(struct module * module,
 	if (entry) {
 		entry->module = module;
 		entry->parent = parent;
+		if (parent)
+			list_add_tail(&entry->list, &parent->children);
 	}
 	return entry;
 }
@@ -730,6 +761,8 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
 		entry->module = card->module;
 		entry->card = card;
 		entry->parent = parent;
+		if (parent)
+			list_add_tail(&entry->list, &parent->children);
 	}
 	return entry;
 }
@@ -816,8 +849,6 @@ int snd_info_register(struct snd_info_entry * entry)
 		proc_set_size(p, entry->size);
 	}
 	entry->p = p;
-	if (entry->parent)
-		list_add_tail(&entry->list, &entry->parent->children);
 	mutex_unlock(&info_mutex);
 	return 0;
 }
diff --git a/sound/core/init.c b/sound/core/init.c
index 769a783757ff..f8abd2d8144e 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -107,26 +107,20 @@ static void snd_card_id_read(struct snd_info_entry *entry,
 	snd_iprintf(buffer, "%s\n", entry->card->id);
 }
 
-static inline int init_info_for_card(struct snd_card *card)
+static int init_info_for_card(struct snd_card *card)
 {
 	int err;
 	struct snd_info_entry *entry;
 
-	if ((err = snd_info_card_register(card)) < 0) {
-		dev_dbg(card->dev, "unable to create card info\n");
-		return err;
-	}
-	if ((entry = snd_info_create_card_entry(card, "id", card->proc_root)) == NULL) {
+	entry = snd_info_create_card_entry(card, "id", card->proc_root);
+	if (!entry) {
 		dev_dbg(card->dev, "unable to create card entry\n");
 		return err;
 	}
 	entry->c.text.read = snd_card_id_read;
-	if (snd_info_register(entry) < 0) {
-		snd_info_free_entry(entry);
-		entry = NULL;
-	}
 	card->proc_id = entry;
-	return 0;
+
+	return snd_info_card_register(card);
 }
 #else /* !CONFIG_PROC_FS */
 #define init_info_for_card(card)
@@ -756,7 +750,7 @@ int snd_card_register(struct snd_card *card)
 	if (snd_cards[card->number]) {
 		/* already registered */
 		mutex_unlock(&snd_card_mutex);
-		return 0;
+		return snd_info_card_register(card); /* register pending info */
 	}
 	if (*card->id) {
 		/* make a unique id name from the given string */
-- 
2.3.6
