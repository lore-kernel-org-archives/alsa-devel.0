From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: core: Don't refer to snd_cards array
	directly
Date: Tue, 16 Apr 2019 20:44:15 +0200
Message-ID: <20190416184415.27837-2-tiwai@suse.de>
References: <20190416184415.27837-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4FFAF896E2
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 20:44:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BBE0AAF3B
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 18:44:16 +0000 (UTC)
In-Reply-To: <20190416184415.27837-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The snd_cards[] array holds the card pointers that have been currently
registered, and it's exported for the external modules that may need
to refer a card object.  But accessing to this array can be racy
against the driver probe or removal, as the card registration or free
may happen concurrently.

This patch gets rid of the direct access to snd_cards[] array and
provides a helper function to give the card object from the index
number with a refcount management.  Then the caller can access to the
given card object safely, and releases it via snd_card_unref().

While we're at it, add a proper comment to snd_card_unref() and make
it an inlined function for type-safety, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h       | 16 ++++++++++++++--
 sound/core/init.c          | 23 +++++++++++++++++++++--
 sound/core/oss/mixer_oss.c | 16 ++++++++++++----
 sound/core/sound.c         |  5 ++++-
 sound/last.c               | 10 +++++++---
 5 files changed, 58 insertions(+), 12 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index e923c23e05dd..c90ebbc8d9c4 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -226,7 +226,6 @@ int copy_from_user_toio(volatile void __iomem *dst, const void __user *src, size
 
 /* init.c */
 
-extern struct snd_card *snd_cards[SNDRV_CARDS];
 int snd_card_locked(int card);
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 #define SND_MIXER_OSS_NOTIFY_REGISTER	0
@@ -251,7 +250,20 @@ int snd_card_add_dev_attr(struct snd_card *card,
 int snd_component_add(struct snd_card *card, const char *component);
 int snd_card_file_add(struct snd_card *card, struct file *file);
 int snd_card_file_remove(struct snd_card *card, struct file *file);
-#define snd_card_unref(card)	put_device(&(card)->card_dev)
+
+struct snd_card *snd_card_ref(int card);
+
+/**
+ * snd_card_unref - Unreference the card object
+ * @card: the card object to unreference
+ *
+ * Call this function for the card object that was obtained via snd_card_ref()
+ * or snd_lookup_minor_data().
+ */
+static inline void snd_card_unref(struct snd_card *card)
+{
+	put_device(&card->card_dev);
+}
 
 #define snd_card_set_dev(card, devptr) ((card)->dev = (devptr))
 
diff --git a/sound/core/init.c b/sound/core/init.c
index 079c12d64b0e..d64416f0a281 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -49,8 +49,7 @@ static const struct file_operations snd_shutdown_f_ops;
 
 /* locked for registering/using */
 static DECLARE_BITMAP(snd_cards_lock, SNDRV_CARDS);
-struct snd_card *snd_cards[SNDRV_CARDS];
-EXPORT_SYMBOL(snd_cards);
+static struct snd_card *snd_cards[SNDRV_CARDS];
 
 static DEFINE_MUTEX(snd_card_mutex);
 
@@ -268,6 +267,26 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 }
 EXPORT_SYMBOL(snd_card_new);
 
+/**
+ * snd_card_ref - Get the card object from the index
+ * @idx: the card index
+ *
+ * Returns a card object corresponding to the given index or NULL if not found.
+ * Release the object via snd_card_unref().
+ */
+struct snd_card *snd_card_ref(int idx)
+{
+	struct snd_card *card;
+
+	mutex_lock(&snd_card_mutex);
+	card = snd_cards[idx];
+	if (card)
+		get_device(&card->card_dev);
+	mutex_unlock(&snd_card_mutex);
+	return card;
+}
+EXPORT_SYMBOL_GPL(snd_card_ref);
+
 /* return non-zero if a card is already locked */
 int snd_card_locked(int card)
 {
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index 64d904bee8bb..c8618678649c 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -1403,24 +1403,32 @@ static int snd_mixer_oss_notify_handler(struct snd_card *card, int cmd)
 
 static int __init alsa_mixer_oss_init(void)
 {
+	struct snd_card *card;
 	int idx;
 	
 	snd_mixer_oss_notify_callback = snd_mixer_oss_notify_handler;
 	for (idx = 0; idx < SNDRV_CARDS; idx++) {
-		if (snd_cards[idx])
-			snd_mixer_oss_notify_handler(snd_cards[idx], SND_MIXER_OSS_NOTIFY_REGISTER);
+		card = snd_card_ref(idx);
+		if (card) {
+			snd_mixer_oss_notify_handler(card, SND_MIXER_OSS_NOTIFY_REGISTER);
+			snd_card_unref(card);
+		}
 	}
 	return 0;
 }
 
 static void __exit alsa_mixer_oss_exit(void)
 {
+	struct snd_card *card;
 	int idx;
 
 	snd_mixer_oss_notify_callback = NULL;
 	for (idx = 0; idx < SNDRV_CARDS; idx++) {
-		if (snd_cards[idx])
-			snd_mixer_oss_notify_handler(snd_cards[idx], SND_MIXER_OSS_NOTIFY_FREE);
+		card = snd_card_ref(idx);
+		if (card) {
+			snd_mixer_oss_notify_handler(card, SND_MIXER_OSS_NOTIFY_FREE);
+			snd_card_unref(card);
+		}
 	}
 }
 
diff --git a/sound/core/sound.c b/sound/core/sound.c
index b30f027eb0fe..a9ad4379523b 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -134,8 +134,11 @@ static struct snd_minor *autoload_device(unsigned int minor)
 	if (dev == SNDRV_MINOR_CONTROL) {
 		/* /dev/aloadC? */
 		int card = SNDRV_MINOR_CARD(minor);
-		if (snd_cards[card] == NULL)
+		struct snd_card *ref = snd_card_ref(card);
+		if (!ref)
 			snd_request_card(card);
+		else
+			snd_card_unref(ref);
 	} else if (dev == SNDRV_MINOR_GLOBAL) {
 		/* /dev/aloadSEQ */
 		snd_request_other(minor);
diff --git a/sound/last.c b/sound/last.c
index 43f222825038..4f5a624ab438 100644
--- a/sound/last.c
+++ b/sound/last.c
@@ -24,14 +24,18 @@
 
 static int __init alsa_sound_last_init(void)
 {
+	struct snd_card *card;
 	int idx, ok = 0;
 	
 	printk(KERN_INFO "ALSA device list:\n");
-	for (idx = 0; idx < SNDRV_CARDS; idx++)
-		if (snd_cards[idx] != NULL) {
-			printk(KERN_INFO "  #%i: %s\n", idx, snd_cards[idx]->longname);
+	for (idx = 0; idx < SNDRV_CARDS; idx++) {
+		card = snd_card_ref(idx);
+		if (card) {
+			printk(KERN_INFO "  #%i: %s\n", idx, card->longname);
+			snd_card_unref(card);
 			ok++;
 		}
+	}
 	if (ok == 0)
 		printk(KERN_INFO "  No soundcards found.\n");
 	return 0;
-- 
2.16.4
