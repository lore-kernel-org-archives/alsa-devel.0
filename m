From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2 2/3] ALSA: seq: bind seq driver automatically
Date: Fri, 17 Oct 2014 10:50:06 +0200
Message-ID: <1413535807-21017-3-git-send-email-tiwai@suse.de>
References: <1413535807-21017-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 98D75261582
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 10:50:13 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 37DE2ACCD
 for <alsa-devel@alsa-project.org>; Fri, 17 Oct 2014 08:50:13 +0000 (UTC)
In-Reply-To: <1413535807-21017-1-git-send-email-tiwai@suse.de>
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

Currently the sequencer module binding is performed independently from
the card module itself.  The reason behind it is to keep the sequencer
stuff optional and allow the system running without it (e.g. for using
PCM or rawmidi only).  This works in most cases, but a remaining
problem is that the binding isn't done automatically when a new driver
module is probed.  Typically this becomes visible when a hotplug
driver like usb audio is used.

This patch tries to address this and other potential issues.  First,
the seq-binder (seq_device.c) tries to load a missing driver module at
creating a new device object.  This is done asynchronously in a workq
for avoiding the deadlock (modprobe call in module init path).

This action, however, should be enabled only when the sequencer stuff
was already initialized, i.e. snd-seq module was already loaded.  For
that, a new function, snd_seq_autoload_init() is introduced here; this
clears the blocking of autoloading, and also tries to load all pending
driver modules.

Reported-by: Adam Goode <agoode@chromium.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_kernel.h  |  4 ++
 sound/core/seq/seq.c        |  3 ++
 sound/core/seq/seq_device.c | 92 +++++++++++++++++++++++++++++++++------------
 3 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index 2398521f0998..eea5400fe373 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -108,9 +108,13 @@ int snd_seq_event_port_detach(int client, int port);
 #ifdef CONFIG_MODULES
 void snd_seq_autoload_lock(void);
 void snd_seq_autoload_unlock(void);
+void snd_seq_autoload_init(void);
+#define snd_seq_autoload_exit()	snd_seq_autoload_lock()
 #else
 #define snd_seq_autoload_lock()
 #define snd_seq_autoload_unlock()
+#define snd_seq_autoload_init()
+#define snd_seq_autoload_exit()
 #endif
 
 #endif /* __SOUND_SEQ_KERNEL_H */
diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index 712110561082..bebdd2e920ca 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -110,6 +110,7 @@ static int __init alsa_seq_init(void)
 	if ((err = snd_seq_system_client_init()) < 0)
 		goto error;
 
+	snd_seq_autoload_init();
  error:
 	snd_seq_autoload_unlock();
 	return err;
@@ -131,6 +132,8 @@ static void __exit alsa_seq_exit(void)
 
 	/* release event memory */
 	snd_sequencer_memory_done();
+
+	snd_seq_autoload_exit();
 }
 
 module_init(alsa_seq_init)
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 775ea9390110..ebee034f8ab5 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -56,6 +56,7 @@ MODULE_LICENSE("GPL");
 #define DRIVER_LOADED		(1<<0)
 #define DRIVER_REQUESTED	(1<<1)
 #define DRIVER_LOCKED		(1<<2)
+#define DRIVER_REQUESTING	(1<<3)
 
 struct ops_list {
 	char id[ID_LEN];	/* driver id */
@@ -127,7 +128,7 @@ static void snd_seq_device_info(struct snd_info_entry *entry,
 
 #ifdef CONFIG_MODULES
 /* avoid auto-loading during module_init() */
-static atomic_t snd_seq_in_init = ATOMIC_INIT(0);
+static atomic_t snd_seq_in_init = ATOMIC_INIT(1); /* blocked as default */
 void snd_seq_autoload_lock(void)
 {
 	atomic_inc(&snd_seq_in_init);
@@ -137,32 +138,72 @@ void snd_seq_autoload_unlock(void)
 {
 	atomic_dec(&snd_seq_in_init);
 }
-#endif
 
-void snd_seq_device_load_drivers(void)
+static void autoload_drivers(void)
 {
-#ifdef CONFIG_MODULES
-	struct ops_list *ops;
+	/* avoid reentrance */
+	if (atomic_inc_return(&snd_seq_in_init) == 1) {
+		struct ops_list *ops;
+
+		mutex_lock(&ops_mutex);
+		list_for_each_entry(ops, &opslist, list) {
+			if ((ops->driver & DRIVER_REQUESTING) &&
+			    !(ops->driver & DRIVER_REQUESTED)) {
+				ops->used++;
+				mutex_unlock(&ops_mutex);
+				ops->driver |= DRIVER_REQUESTED;
+				request_module("snd-%s", ops->id);
+				mutex_lock(&ops_mutex);
+				ops->used--;
+			}
+		}
+		mutex_unlock(&ops_mutex);
+	}
+	atomic_dec(&snd_seq_in_init);
+}
 
-	/* Calling request_module during module_init()
-	 * may cause blocking.
-	 */
-	if (atomic_read(&snd_seq_in_init))
-		return;
+static void call_autoload(struct work_struct *work)
+{
+	autoload_drivers();
+}
 
-	mutex_lock(&ops_mutex);
-	list_for_each_entry(ops, &opslist, list) {
-		if (! (ops->driver & DRIVER_LOADED) &&
-		    ! (ops->driver & DRIVER_REQUESTED)) {
-			ops->used++;
-			mutex_unlock(&ops_mutex);
-			ops->driver |= DRIVER_REQUESTED;
-			request_module("snd-%s", ops->id);
-			mutex_lock(&ops_mutex);
-			ops->used--;
-		}
+static DECLARE_WORK(autoload_work, call_autoload);
+
+static void try_autoload(struct ops_list *ops)
+{
+	if (!ops->driver) {
+		ops->driver |= DRIVER_REQUESTING;
+		schedule_work(&autoload_work);
 	}
+}
+
+static void queue_autoload_drivers(void)
+{
+	struct ops_list *ops;
+
+	mutex_lock(&ops_mutex);
+	list_for_each_entry(ops, &opslist, list)
+		try_autoload(ops);
 	mutex_unlock(&ops_mutex);
+}
+
+void snd_seq_autoload_init(void)
+{
+	atomic_dec(&snd_seq_in_init);
+#ifdef CONFIG_SND_SEQUENCER_MODULE
+	/* initial autoload only when snd-seq is a module */
+	queue_autoload_drivers();
+#endif
+}
+#else
+#define try_autoload() /* NOP */
+#endif
+
+void snd_seq_device_load_drivers(void)
+{
+#ifdef CONFIG_MODULES
+	queue_autoload_drivers();
+	flush_work(&autoload_work);
 #endif
 }
 
@@ -214,13 +255,14 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 	ops->num_devices++;
 	mutex_unlock(&ops->reg_mutex);
 
-	unlock_driver(ops);
-	
 	if ((err = snd_device_new(card, SNDRV_DEV_SEQUENCER, dev, &dops)) < 0) {
 		snd_seq_device_free(dev);
 		return err;
 	}
 	
+	try_autoload(ops);
+	unlock_driver(ops);
+
 	if (result)
 		*result = dev;
 
@@ -554,6 +596,9 @@ static int __init alsa_seq_device_init(void)
 
 static void __exit alsa_seq_device_exit(void)
 {
+#ifdef CONFIG_MODULES
+	cancel_work_sync(&autoload_work);
+#endif
 	remove_drivers();
 #ifdef CONFIG_PROC_FS
 	snd_info_free_entry(info_entry);
@@ -570,6 +615,7 @@ EXPORT_SYMBOL(snd_seq_device_new);
 EXPORT_SYMBOL(snd_seq_device_register_driver);
 EXPORT_SYMBOL(snd_seq_device_unregister_driver);
 #ifdef CONFIG_MODULES
+EXPORT_SYMBOL(snd_seq_autoload_init);
 EXPORT_SYMBOL(snd_seq_autoload_lock);
 EXPORT_SYMBOL(snd_seq_autoload_unlock);
 #endif
-- 
2.1.2
