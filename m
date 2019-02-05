From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: info: Drop unused
	snd_info_entry.card field
Date: Tue,  5 Feb 2019 17:07:55 +0100
Message-ID: <20190205160758.9172-2-tiwai@suse.de>
References: <20190205160758.9172-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CB5A2674C5
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

It's referred only in snd_card_id_read() which can receive the card
object via private_data.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/info.h | 1 -
 sound/core/info.c    | 4 +---
 sound/core/init.c    | 6 ++++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/include/sound/info.h b/include/sound/info.h
index 96530f7599e1..97fdda41e076 100644
--- a/include/sound/info.h
+++ b/include/sound/info.h
@@ -82,7 +82,6 @@ struct snd_info_entry {
 		struct snd_info_entry_ops *ops;
 	} c;
 	struct snd_info_entry *parent;
-	struct snd_card *card;
 	struct module *module;
 	void *private_data;
 	void (*private_free)(struct snd_info_entry *entry);
diff --git a/sound/core/info.c b/sound/core/info.c
index 92edc9488b5b..76800326ac56 100644
--- a/sound/core/info.c
+++ b/sound/core/info.c
@@ -750,10 +750,8 @@ struct snd_info_entry *snd_info_create_card_entry(struct snd_card *card,
 	if (!parent)
 		parent = card->proc_root;
 	entry = snd_info_create_entry(name, parent);
-	if (entry) {
+	if (entry)
 		entry->module = card->module;
-		entry->card = card;
-	}
 	return entry;
 }
 EXPORT_SYMBOL(snd_info_create_card_entry);
diff --git a/sound/core/init.c b/sound/core/init.c
index 4849c611c0fe..5252a9ce13dc 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -104,7 +104,9 @@ EXPORT_SYMBOL(snd_mixer_oss_notify_callback);
 static void snd_card_id_read(struct snd_info_entry *entry,
 			     struct snd_info_buffer *buffer)
 {
-	snd_iprintf(buffer, "%s\n", entry->card->id);
+	struct snd_card *card = entry->private_data;
+
+	snd_iprintf(buffer, "%s\n", card->id);
 }
 
 static int init_info_for_card(struct snd_card *card)
@@ -116,7 +118,7 @@ static int init_info_for_card(struct snd_card *card)
 		dev_dbg(card->dev, "unable to create card entry\n");
 		return -ENOMEM;
 	}
-	entry->c.text.read = snd_card_id_read;
+	snd_info_set_text_ops(entry, card, snd_card_id_read);
 	card->proc_id = entry;
 
 	return snd_info_card_register(card);
-- 
2.16.4
