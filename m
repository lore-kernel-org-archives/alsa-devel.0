From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/5] ALSA: seq: Fix leftovers at probe error
	path
Date: Wed,  1 Aug 2018 18:11:58 +0200
Message-ID: <20180801161200.3930-4-tiwai@suse.de>
References: <20180801161200.3930-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2D92677D5
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 18:12:02 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 2760FAD38
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 16:12:02 +0000 (UTC)
In-Reply-To: <20180801161200.3930-1-tiwai@suse.de>
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

The sequencer core module doesn't call some destructors in the error
path of the init code, which may leave some resources.

This patch mainly fix these leaks by calling the destructors
appropriately at alsa_seq_init().  Also the patch brings a few
cleanups along with it, namely:

- Expand the old "if ((err = xxx) < 0)" coding style
- Get rid of empty seq_queue_init() and its caller
- Change snd_seq_info_done() to void

Last but not least, a couple of functions lose __exit annotation since
they are called also in alsa_seq_init().

No functional changes but minor code cleanups.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq.c           | 26 ++++++++++++++++----------
 sound/core/seq/seq_clientmgr.c |  2 +-
 sound/core/seq/seq_info.c      | 10 ++--------
 sound/core/seq/seq_info.h      |  6 +++---
 sound/core/seq/seq_queue.c     | 12 +-----------
 sound/core/seq/seq_queue.h     |  3 ---
 6 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index e685eccdc741..7de98d71f2aa 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -84,26 +84,32 @@ static int __init alsa_seq_init(void)
 {
 	int err;
 
-	if ((err = client_init_data()) < 0)
-		goto error;
-
-	/* init event queues */
-	if ((err = snd_seq_queues_init()) < 0)
+	err = client_init_data();
+	if (err < 0)
 		goto error;
 
 	/* register sequencer device */
-	if ((err = snd_sequencer_device_init()) < 0)
+	err = snd_sequencer_device_init();
+	if (err < 0)
 		goto error;
 
 	/* register proc interface */
-	if ((err = snd_seq_info_init()) < 0)
-		goto error;
+	err = snd_seq_info_init();
+	if (err < 0)
+		goto error_device;
 
 	/* register our internal client */
-	if ((err = snd_seq_system_client_init()) < 0)
-		goto error;
+	err = snd_seq_system_client_init();
+	if (err < 0)
+		goto error_info;
 
 	snd_seq_autoload_init();
+	return 0;
+
+ error_info:
+	snd_seq_info_done();
+ error_device:
+	snd_sequencer_device_done();
  error:
 	return err;
 }
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 6fd4b074b206..a0b768e2f697 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2543,7 +2543,7 @@ int __init snd_sequencer_device_init(void)
 /* 
  * unregister sequencer device 
  */
-void __exit snd_sequencer_device_done(void)
+void snd_sequencer_device_done(void)
 {
 	snd_unregister_device(&seq_dev);
 	put_device(&seq_dev);
diff --git a/sound/core/seq/seq_info.c b/sound/core/seq/seq_info.c
index 97015447b9b3..b27fedd435b6 100644
--- a/sound/core/seq/seq_info.c
+++ b/sound/core/seq/seq_info.c
@@ -50,7 +50,7 @@ create_info_entry(char *name, void (*read)(struct snd_info_entry *,
 	return entry;
 }
 
-static void free_info_entries(void)
+void snd_seq_info_done(void)
 {
 	snd_info_free_entry(queues_entry);
 	snd_info_free_entry(clients_entry);
@@ -70,12 +70,6 @@ int __init snd_seq_info_init(void)
 	return 0;
 
  error:
-	free_info_entries();
+	snd_seq_info_done();
 	return -ENOMEM;
 }
-
-int __exit snd_seq_info_done(void)
-{
-	free_info_entries();
-	return 0;
-}
diff --git a/sound/core/seq/seq_info.h b/sound/core/seq/seq_info.h
index f8549f81a645..2cdf8f6e63f5 100644
--- a/sound/core/seq/seq_info.h
+++ b/sound/core/seq/seq_info.h
@@ -30,11 +30,11 @@ void snd_seq_info_queues_read(struct snd_info_entry *entry, struct snd_info_buff
 
 
 #ifdef CONFIG_SND_PROC_FS
-int snd_seq_info_init( void );
-int snd_seq_info_done( void );
+int snd_seq_info_init(void);
+void snd_seq_info_done(void);
 #else
 static inline int snd_seq_info_init(void) { return 0; }
-static inline int snd_seq_info_done(void) { return 0; }
+static inline void snd_seq_info_done(void) {}
 #endif
 
 #endif
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index b377f5048352..3b3ac96f1f5f 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -159,18 +159,8 @@ static void queue_delete(struct snd_seq_queue *q)
 
 /*----------------------------------------------------------------*/
 
-/* setup queues */
-int __init snd_seq_queues_init(void)
-{
-	/*
-	memset(queue_list, 0, sizeof(queue_list));
-	num_queues = 0;
-	*/
-	return 0;
-}
-
 /* delete all existing queues */
-void __exit snd_seq_queues_delete(void)
+void snd_seq_queues_delete(void)
 {
 	int i;
 
diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
index 719093489a2c..76db43b79a2b 100644
--- a/sound/core/seq/seq_queue.h
+++ b/sound/core/seq/seq_queue.h
@@ -63,9 +63,6 @@ struct snd_seq_queue {
 /* get the number of current queues */
 int snd_seq_queue_get_cur_queues(void);
 
-/* init queues structure */
-int snd_seq_queues_init(void);
-
 /* delete queues */ 
 void snd_seq_queues_delete(void);
 
-- 
2.18.0
