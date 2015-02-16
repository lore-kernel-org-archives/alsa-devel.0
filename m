From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6/6] ALSA: seq: Drop snd_seq_autoload_lock()
	and _unlock()
Date: Mon, 16 Feb 2015 17:55:44 +0100
Message-ID: <1424105744-2187-7-git-send-email-tiwai@suse.de>
References: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC612606A9
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:46 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BBD57AD39
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:55:45 +0000 (UTC)
In-Reply-To: <1424105744-2187-1-git-send-email-tiwai@suse.de>
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

The autoload lock became already superfluous due to the recent rework
of autoload code.  Let's drop them now.  This allows us to simplify a
few codes nicely.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_kernel.h   |  6 +-----
 sound/core/seq/oss/seq_oss.c |  2 --
 sound/core/seq/seq_device.c  | 19 +++++++------------
 sound/core/seq/seq_dummy.c   |  6 +-----
 sound/core/seq/seq_midi.c    | 18 +-----------------
 5 files changed, 10 insertions(+), 41 deletions(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index 18a2ac58b88f..feb58d455560 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -99,13 +99,9 @@ int snd_seq_event_port_attach(int client, struct snd_seq_port_callback *pcbp,
 int snd_seq_event_port_detach(int client, int port);
 
 #ifdef CONFIG_MODULES
-void snd_seq_autoload_lock(void);
-void snd_seq_autoload_unlock(void);
 void snd_seq_autoload_init(void);
-#define snd_seq_autoload_exit()	snd_seq_autoload_lock()
+void snd_seq_autoload_exit(void);
 #else
-#define snd_seq_autoload_lock()
-#define snd_seq_autoload_unlock()
 #define snd_seq_autoload_init()
 #define snd_seq_autoload_exit()
 #endif
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index ae1814aa767e..72873a46afeb 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -79,7 +79,6 @@ static int __init alsa_seq_oss_init(void)
 {
 	int rc;
 
-	snd_seq_autoload_lock();
 	if ((rc = register_device()) < 0)
 		goto error;
 	if ((rc = register_proc()) < 0) {
@@ -104,7 +103,6 @@ static int __init alsa_seq_oss_init(void)
 	snd_seq_oss_synth_init();
 
  error:
-	snd_seq_autoload_unlock();
 	return rc;
 }
 
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 48b20f009598..355b34269bd1 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -98,19 +98,8 @@ static void snd_seq_device_info(struct snd_info_entry *entry,
  */
 
 #ifdef CONFIG_MODULES
-/* avoid auto-loading during module_init() */
+/* flag to block auto-loading */
 static atomic_t snd_seq_in_init = ATOMIC_INIT(1); /* blocked as default */
-void snd_seq_autoload_lock(void)
-{
-	atomic_inc(&snd_seq_in_init);
-}
-EXPORT_SYMBOL(snd_seq_autoload_lock);
-
-void snd_seq_autoload_unlock(void)
-{
-	atomic_dec(&snd_seq_in_init);
-}
-EXPORT_SYMBOL(snd_seq_autoload_unlock);
 
 static int request_seq_drv(struct device *dev, void *data)
 {
@@ -147,6 +136,12 @@ void snd_seq_autoload_init(void)
 }
 EXPORT_SYMBOL(snd_seq_autoload_init);
 
+void snd_seq_autoload_exit(void)
+{
+	atomic_inc(&snd_seq_in_init);
+}
+EXPORT_SYMBOL(snd_seq_autoload_exit);
+
 void snd_seq_device_load_drivers(void)
 {
 	queue_autoload_drivers();
diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index 5d905d90d504..d3a2ec4f0561 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -214,11 +214,7 @@ delete_client(void)
 
 static int __init alsa_seq_dummy_init(void)
 {
-	int err;
-	snd_seq_autoload_lock();
-	err = register_client();
-	snd_seq_autoload_unlock();
-	return err;
+	return register_client();
 }
 
 static void __exit alsa_seq_dummy_exit(void)
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 79c73119cedc..5dd0ee258359 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -469,20 +469,4 @@ static struct snd_seq_driver seq_midisynth_driver = {
 	.argsize = 0,
 };
 
-static int __init alsa_seq_midi_init(void)
-{
-	int err;
-
-	snd_seq_autoload_lock();
-	err = snd_seq_driver_register(&seq_midisynth_driver);
-	snd_seq_autoload_unlock();
-	return err;
-}
-
-static void __exit alsa_seq_midi_exit(void)
-{
-	snd_seq_driver_unregister(&seq_midisynth_driver);
-}
-
-module_init(alsa_seq_midi_init)
-module_exit(alsa_seq_midi_exit)
+module_snd_seq_driver(seq_midisynth_driver);
-- 
2.3.0
