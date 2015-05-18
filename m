From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: info: Move list addition to
	snd_info_create_entry()
Date: Mon, 18 May 2015 09:57:03 +0200
Message-ID: <1431935824-8670-4-git-send-email-tiwai@suse.de>
References: <1431935824-8670-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AD5E2604A3
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

Just a minor refactoring, no functional changes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/info.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/sound/core/info.c b/sound/core/info.c
index 13b174464cc8..76cdf1d21f17 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -455,11 +455,12 @@ static struct snd_info_entry *create_subdir(struct module *mod,
 	return entry;
 }
 
-static struct snd_info_entry *snd_info_create_entry(const char *name);
+static struct snd_info_entry *
+snd_info_create_entry(const char *name, struct snd_info_entry *parent);
 
 int __init snd_info_init(void)
 {
-	snd_proc_root = snd_info_create_entry("asound");
+	snd_proc_root = snd_info_create_entry("asound", NULL);
 	if (!snd_proc_root)
 		return -ENOMEM;
 	snd_proc_root->mode = S_IFDIR | S_IRUGO | S_IXUGO;
@@ -688,6 +689,7 @@ EXPORT_SYMBOL(snd_info_get_str);
 /**
  * snd_info_create_entry - create an info entry
  * @name: the proc file name
+ * @parent: the parent directory
  *
  * Creates an info entry with the given file name and initializes as
  * the default state.
@@ -697,7 +699,8 @@ EXPORT_SYMBOL(snd_info_get_str);
  *
  * Return: The pointer of the new instance, or %NULL on failure.
  */
-static struct snd_info_entry *snd_info_create_entry(const char *name)
+static struct snd_info_entry *
+snd_info_create_entry(const char *name, struct snd_info_entry *parent)
 {
 	struct snd_info_entry *entry;
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -713,6 +716,9 @@ static struct snd_info_entry *snd_info_create_entry(const char *name)
 	mutex_init(&entry->access);
 	INIT_LIST_HEAD(&entry->children);
 	INIT_LIST_HEAD(&entry->list);
+	entry->parent = parent;
+	if (parent)
+		list_add_tail(&entry->list, &parent->children);
 	return entry;
 }
 
@@ -730,13 +736,9 @@ struct snd_info_entry *snd_info_create_module_entry(struct module * module,
 					       const char *name,
 					       struct snd_info_entry *parent)
 {
-	struct snd_info_entry *entry = snd_info_create_entry(name);
-	if (entry) {
+	struct snd_info_entry *entry = snd_info_create_entry(name, parent);
+	if (entry)
 		entry->module = module;
-		entry->parent = parent;
-		if (parent)
-			list_add_tail(&entry->list, &parent->children);
-	}
 	return entry;
 }
 
@@ -756,13 +758,10 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
 					     const char *name,
 					     struct snd_info_entry * parent)
 {
-	struct snd_info_entry *entry = snd_info_create_entry(name);
+	struct snd_info_entry *entry = snd_info_create_entry(name, parent);
 	if (entry) {
 		entry->module = card->module;
 		entry->card = card;
-		entry->parent = parent;
-		if (parent)
-			list_add_tail(&entry->list, &parent->children);
 	}
 	return entry;
 }
-- 
2.3.6
