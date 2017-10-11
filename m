From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 1/2] ALSA: add snd_card_disconnect_sync()
Date: Wed, 11 Oct 2017 12:16:17 +0200
Message-ID: <20171011101618.8736-2-tiwai@suse.de>
References: <20171011101618.8736-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E9820266EA7
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 12:16:26 +0200 (CEST)
In-Reply-To: <20171011101618.8736-1-tiwai@suse.de>
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
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org

In case of user unbind ALSA driver during playing back / capturing,
each driver needs to stop and remove it correctly. One note here is
that we can't cancel from remove function in such case, because
unbind operation doesn't check return value from remove function.
So, we *must* stop and remove in this case.

For this purpose, we need to sync (= wait) until the all top-level
operations are canceled at remove function.
For example, snd_card_free() processes the disconnection procedure at
first, then waits for the completion. That's how the hot-unplug works
safely. It's implemented, at least, in the top-level driver removal.

Now for the lower level driver, we need a similar strategy. Notify to
the toplevel for hot-unplug (disconnect in ALSA), and sync with the
stop operation, then continue the rest of its own remove procedure.

This patch adds snd_card_disconnect_sync(), and driver can use it from
remove function.

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/core.h |  2 ++
 sound/core/init.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/sound/core.h b/include/sound/core.h
index 4104a9d1001f..5f181b875c2f 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -133,6 +133,7 @@ struct snd_card {
 	struct device card_dev;		/* cardX object for sysfs */
 	const struct attribute_group *dev_groups[4]; /* assigned sysfs attr */
 	bool registered;		/* card_dev is registered? */
+	wait_queue_head_t remove_sleep;
 
 #ifdef CONFIG_PM
 	unsigned int power_state;	/* power state */
@@ -240,6 +241,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 		 struct snd_card **card_ret);
 
 int snd_card_disconnect(struct snd_card *card);
+void snd_card_disconnect_sync(struct snd_card *card);
 int snd_card_free(struct snd_card *card);
 int snd_card_free_when_closed(struct snd_card *card);
 void snd_card_set_id(struct snd_card *card, const char *id);
diff --git a/sound/core/init.c b/sound/core/init.c
index 32ebe2f6bc59..168ae03d3a1c 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -255,6 +255,7 @@ int snd_card_new(struct device *parent, int idx, const char *xid,
 #ifdef CONFIG_PM
 	init_waitqueue_head(&card->power_sleep);
 #endif
+	init_waitqueue_head(&card->remove_sleep);
 
 	device_initialize(&card->card_dev);
 	card->card_dev.parent = parent;
@@ -452,6 +453,35 @@ int snd_card_disconnect(struct snd_card *card)
 }
 EXPORT_SYMBOL(snd_card_disconnect);
 
+/**
+ * snd_card_disconnect_sync - disconnect card and wait until files get closed
+ * @card: card object to disconnect
+ *
+ * This calls snd_card_disconnect() for disconnecting all belonging components
+ * and waits until all pending files get closed.
+ * It assures that all accesses from user-space finished so that the driver
+ * can release its resources gracefully.
+ */
+void snd_card_disconnect_sync(struct snd_card *card)
+{
+	int err;
+
+	err = snd_card_disconnect(card);
+	if (err < 0) {
+		dev_err(card->dev,
+			"snd_card_disconnect error (%d), skipping sync\n",
+			err);
+		return;
+	}
+
+	spin_lock_irq(&card->files_lock);
+	wait_event_lock_irq(card->remove_sleep,
+			    list_empty(&card->files_list),
+			    card->files_lock);
+	spin_unlock_irq(&card->files_lock);
+}
+EXPORT_SYMBOL_GPL(snd_card_disconnect_sync);
+
 static int snd_card_do_free(struct snd_card *card)
 {
 #if IS_ENABLED(CONFIG_SND_MIXER_OSS)
@@ -957,6 +987,8 @@ int snd_card_file_remove(struct snd_card *card, struct file *file)
 			break;
 		}
 	}
+	if (list_empty(&card->files_list))
+		wake_up_all(&card->remove_sleep);
 	spin_unlock(&card->files_lock);
 	if (!found) {
 		dev_err(card->dev, "card file remove problem (%p)\n", file);
-- 
2.14.2
