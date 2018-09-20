From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/7] ALSA: core: Add managed card creation
Date: Thu, 20 Sep 2018 17:54:57 +0200
Message-ID: <20180920155502.7534-3-tiwai@suse.de>
References: <20180920155502.7534-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3851D26788C
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 17:55:05 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 3B6ADAF57
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2018 15:55:05 +0000 (UTC)
In-Reply-To: <20180920155502.7534-1-tiwai@suse.de>
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

Per popular demands, this patch adds a new ALSA core API function,
snd_devm_card_new(), to create a snd_card object in a managed way via
devres.  When a card object is created by this new function, it's
released automatically at the device release.  It includes also the
call of snd_card_free().

However, the story isn't that simple.  A caveat is that We have to
call snd_card_new(), more specifically, the disconnection part, at
very first of the whole resource release procedure.  This assures that
the exposed devices are deleted and sync with the all accessing
processes getting closed.

For achieving it, snd_card_register() adds a new devres action to
trigger snd_card_free() automatically when the given card object is a
"managed" one.  Since usually snd_card_register() is the last step of
the initialization, this should work in most cases.

With all these tricks, some drivers can get rid of the whole the
driver remove callback.

About a bit of implementation details: the patch adds two new flags to
snd_card object, managed and releasing.  The former indicates that the
object was created via snd_devm_card_new(), and the latter is used for
avoiding the double-free of snd_card_free() calls.  Both flags are
fairly internal and likely uninteresting to normal users.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  5 +++
 sound/core/init.c    | 95 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 36a5934cf4b1..6ff75f92ec7d 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -133,6 +133,8 @@ struct snd_card {
 	struct device card_dev;		/* cardX object for sysfs */
 	const struct attribute_group *dev_groups[4]; /* assigned sysfs attr */
 	bool registered;		/* card_dev is registered? */
+	bool managed;			/* managed via devres */
+	bool releasing;			/* during card free process */
 	wait_queue_head_t remove_sleep;
 
 #ifdef CONFIG_PM
@@ -239,6 +241,9 @@ extern int (*snd_mixer_oss_notify_callback)(struct snd_card *card, int cmd);
 int snd_card_new(struct device *parent, int idx, const char *xid,
 		 struct module *module, int extra_size,
 		 struct snd_card **card_ret);
+int snd_devm_card_new(struct device *parent, int idx, const char *xid,
+		      struct module *module, int extra_size,
+		      struct snd_card **card_ret);
 
 int snd_card_disconnect(struct snd_card *card);
 void snd_card_disconnect_sync(struct snd_card *card);
diff --git a/sound/core/init.c b/sound/core/init.c
index 4849c611c0fe..2eade57db4b4 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -173,6 +173,9 @@ void snd_device_initialize(struct device *dev, struct snd_card *card)
 }
 EXPORT_SYMBOL_GPL(snd_device_initialize);
 
+static int snd_card_init(struct snd_card *card, struct device *parent,
+			 int idx, const char *xid, struct module *module,
+			 int extra_size);
 static int snd_card_do_free(struct snd_card *card);
 static const struct attribute_group card_dev_attr_group;
 
@@ -214,6 +217,73 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	card = kzalloc(sizeof(*card) + extra_size, GFP_KERNEL);
 	if (!card)
 		return -ENOMEM;
+
+	err = snd_card_init(card, parent, idx, xid, module, extra_size);
+	if (err < 0) {
+		kfree(card);
+		return err;
+	}
+
+	*card_ret = card;
+	return 0;
+}
+EXPORT_SYMBOL(snd_card_new);
+
+static void __snd_card_release(struct device *dev, void *data)
+{
+	snd_card_free(data);
+}
+
+/**
+ * snd_devm_card_new - managed snd_card object creation
+ * @parent: the parent device object
+ * @idx: card index (address) [0 ... (SNDRV_CARDS-1)]
+ * @xid: card identification (ASCII string)
+ * @module: top level module for locking
+ * @extra_size: allocate this extra size after the main soundcard structure
+ * @card_ret: the pointer to store the created card instance
+ *
+ * This function works like snd_card_new() but manages the allocated resource
+ * via devres, i.e. you don't need to free explicitly.
+ *
+ * When a snd_card object is created with this function and registered via
+ * snd_card_register(), the very first devres action to call snd_card_free()
+ * is added automatically.  In that way, the resource disconnection is assured
+ * at first, then released in the expected order.
+ */
+int snd_devm_card_new(struct device *parent, int idx, const char *xid,
+		      struct module *module, int extra_size,
+		      struct snd_card **card_ret)
+{
+	struct snd_card *card;
+	int err;
+
+	*card_ret = NULL;
+	if (extra_size < 0)
+		extra_size = 0;
+	card = devres_alloc(__snd_card_release, sizeof(*card) + extra_size,
+			    GFP_KERNEL);
+	if (!card)
+		return -ENOMEM;
+	card->managed = true;
+	err = snd_card_init(card, parent, idx, xid, module, extra_size);
+	if (err < 0) {
+		devres_free(card);
+		return err;
+	}
+
+	devres_add(parent, card);
+	*card_ret = card;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_devm_card_new);
+
+static int snd_card_init(struct snd_card *card, struct device *parent,
+			 int idx, const char *xid, struct module *module,
+			 int extra_size)
+{
+	int err;
+
 	if (extra_size > 0)
 		card->private_data = (char *)card + sizeof(struct snd_card);
 	if (xid)
@@ -235,7 +305,6 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 		mutex_unlock(&snd_card_mutex);
 		dev_err(parent, "cannot find the slot for index %d (range 0-%i), error: %d\n",
 			 idx, snd_ecards_limit - 1, err);
-		kfree(card);
 		return err;
 	}
 	set_bit(idx, snd_cards_lock);		/* lock it */
@@ -282,7 +351,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 		dev_err(parent, "unable to create card info\n");
 		goto __error_ctl;
 	}
-	*card_ret = card;
+
 	return 0;
 
       __error_ctl:
@@ -291,7 +360,6 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 	put_device(&card->card_dev);
   	return err;
 }
-EXPORT_SYMBOL(snd_card_new);
 
 /* return non-zero if a card is already locked */
 int snd_card_locked(int card)
@@ -484,6 +552,7 @@ EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
 
 static int snd_card_do_free(struct snd_card *card)
 {
+	card->releasing = true;
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
@@ -498,7 +567,8 @@ static int snd_card_do_free(struct snd_card *card)
 	}
 	if (card->release_completion)
 		complete(card->release_completion);
-	kfree(card);
+	if (!card->managed)
+		kfree(card);
 	return 0;
 }
 
@@ -539,6 +609,9 @@ int snd_card_free(struct snd_card *card)
 	struct completion released;
 	int ret;
 
+	if (card->releasing)
+		return 0;
+
 	init_completion(&released);
 	card->release_completion = &released;
 	ret = snd_card_free_when_closed(card);
@@ -748,6 +821,11 @@ int snd_card_add_dev_attr(struct snd_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_card_add_dev_attr);
 
+static void trigger_card_free(void *data)
+{
+	snd_card_free(data);
+}
+
 /**
  *  snd_card_register - register the soundcard
  *  @card: soundcard structure
@@ -771,6 +849,15 @@ int snd_card_register(struct snd_card *card)
 		if (err < 0)
 			return err;
 		card->registered = true;
+	} else {
+		if (card->managed)
+			devm_remove_action(card->dev, trigger_card_free, card);
+	}
+
+	if (card->managed) {
+		err = devm_add_action(card->dev, trigger_card_free, card);
+		if (err < 0)
+			return err;
 	}
 
 	if ((err = snd_device_register_all(card)) < 0)
-- 
2.18.0
