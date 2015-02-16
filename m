From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/6] ALSA: seq: Move EXPORT_SYMBOL() after each
	function
Date: Mon, 16 Feb 2015 17:55:39 +0100
Message-ID: <1424105744-2187-2-git-send-email-tiwai@suse.de>
References: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ED3862606A3
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:45 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B943AAC97
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

... to follow the standard coding style.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_device.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 0631bdadd12b..a752a79a8d3a 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -133,11 +133,13 @@ void snd_seq_autoload_lock(void)
 {
 	atomic_inc(&snd_seq_in_init);
 }
+EXPORT_SYMBOL(snd_seq_autoload_lock);
 
 void snd_seq_autoload_unlock(void)
 {
 	atomic_dec(&snd_seq_in_init);
 }
+EXPORT_SYMBOL(snd_seq_autoload_unlock);
 
 static void autoload_drivers(void)
 {
@@ -195,10 +197,12 @@ void snd_seq_autoload_init(void)
 	queue_autoload_drivers();
 #endif
 }
+EXPORT_SYMBOL(snd_seq_autoload_init);
 #else
 #define try_autoload(ops) /* NOP */
 #endif
 
+
 void snd_seq_device_load_drivers(void)
 {
 #ifdef CONFIG_MODULES
@@ -206,6 +210,7 @@ void snd_seq_device_load_drivers(void)
 	flush_work(&autoload_work);
 #endif
 }
+EXPORT_SYMBOL(snd_seq_device_load_drivers);
 
 /*
  * register a sequencer device
@@ -268,6 +273,7 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 
 	return 0;
 }
+EXPORT_SYMBOL(snd_seq_device_new);
 
 /*
  * free the existing device
@@ -326,6 +332,7 @@ static int snd_seq_device_dev_register(struct snd_device *device)
 	unlock_driver(ops);
 	return 0;
 }
+EXPORT_SYMBOL(snd_seq_device_register_driver);
 
 /*
  * disconnect the device
@@ -344,6 +351,7 @@ static int snd_seq_device_dev_disconnect(struct snd_device *device)
 	unlock_driver(ops);
 	return 0;
 }
+EXPORT_SYMBOL(snd_seq_device_unregister_driver);
 
 /*
  * register device driver
@@ -604,13 +612,3 @@ static void __exit alsa_seq_device_exit(void)
 
 module_init(alsa_seq_device_init)
 module_exit(alsa_seq_device_exit)
-
-EXPORT_SYMBOL(snd_seq_device_load_drivers);
-EXPORT_SYMBOL(snd_seq_device_new);
-EXPORT_SYMBOL(snd_seq_device_register_driver);
-EXPORT_SYMBOL(snd_seq_device_unregister_driver);
-#ifdef CONFIG_MODULES
-EXPORT_SYMBOL(snd_seq_autoload_init);
-EXPORT_SYMBOL(snd_seq_autoload_lock);
-EXPORT_SYMBOL(snd_seq_autoload_unlock);
-#endif
-- 
2.3.0
