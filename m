From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 04/11] ALSA: info: Add standard helpers for
	card proc file entries
Date: Mon,  4 Feb 2019 16:20:29 +0100
Message-ID: <20190204152036.14102-5-tiwai@suse.de>
References: <20190204152036.14102-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ACBBB2674C0
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 16:20:39 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 533D3AEC8
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 15:20:39 +0000 (UTC)
In-Reply-To: <20190204152036.14102-1-tiwai@suse.de>
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

Two new helper functions are added here for cleaning up the existing
lengthy calls.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/info.h | 35 +++++++++++++++++++++++++++++++++++
 sound/core/info.c    | 31 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/sound/info.h b/include/sound/info.h
index becdf66d2825..96530f7599e1 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -160,6 +160,13 @@ static inline void snd_info_set_text_ops(struct snd_info_entry *entry,
 	entry->c.text.read = read;
 }
 
+int snd_card_rw_proc_new(struct snd_card *card, const char *name,
+			 void *private_data,
+			 void (*read)(struct snd_info_entry *,
+				      struct snd_info_buffer *),
+			 void (*write)(struct snd_info_entry *entry,
+				       struct snd_info_buffer *buffer));
+
 int snd_info_check_reserved_words(const char *str);
 
 #else
@@ -189,10 +196,38 @@ static inline int snd_card_proc_new(struct snd_card *card, const char *name,
 static inline void snd_info_set_text_ops(struct snd_info_entry *entry __attribute__((unused)),
 					 void *private_data,
 					 void (*read)(struct snd_info_entry *, struct snd_info_buffer *)) {}
+static inline int snd_card_rw_proc_new(struct snd_card *card, const char *name,
+				       void *private_data,
+				       void (*read)(struct snd_info_entry *,
+						    struct snd_info_buffer *),
+				       void (*write)(struct snd_info_entry *entry,
+						     struct snd_info_buffer *buffer))
+{
+	return 0;
+}
 static inline int snd_info_check_reserved_words(const char *str) { return 1; }
 
 #endif
 
+/**
+ * snd_card_ro_proc_new - Create a read-only text proc file entry for the card
+ * @card: the card instance
+ * @name: the file name
+ * @private_data: the arbitrary private data
+ * @read: the read callback
+ *
+ * This proc file entry will be registered via snd_card_register() call, and
+ * it will be removed automatically at the card removal, too.
+ */
+static inline int
+snd_card_ro_proc_new(struct snd_card *card, const char *name,
+		     void *private_data,
+		     void (*read)(struct snd_info_entry *,
+				  struct snd_info_buffer *))
+{
+	return snd_card_rw_proc_new(card, name, private_data, read, NULL);
+}
+
 /*
  * OSS info part
  */
diff --git a/sound/core/info.c b/sound/core/info.c
index 2dfb6389c084..6f047582d0a5 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -863,6 +863,37 @@ int snd_info_register(struct snd_info_entry * entry)
 }
 EXPORT_SYMBOL(snd_info_register);
 
+/**
+ * snd_card_ro_proc_new - Create a read/write text proc file entry for the card
+ * @card: the card instance
+ * @name: the file name
+ * @private_data: the arbitrary private data
+ * @read: the read callback
+ *
+ * This proc file entry will be registered via snd_card_register() call, and
+ * it will be removed automatically at the card removal, too.
+ */
+int snd_card_rw_proc_new(struct snd_card *card, const char *name,
+			 void *private_data,
+			 void (*read)(struct snd_info_entry *,
+				      struct snd_info_buffer *),
+			 void (*write)(struct snd_info_entry *entry,
+				       struct snd_info_buffer *buffer))
+{
+	struct snd_info_entry *entry;
+
+	entry = snd_info_create_card_entry(card, name, card->proc_root);
+	if (!entry)
+		return -ENOMEM;
+	snd_info_set_text_ops(entry, private_data, read);
+	if (write) {
+		entry->mode |= 0200;
+		entry->c.text.write = write;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_card_rw_proc_new);
+
 /*
 
  */
-- 
2.16.4
