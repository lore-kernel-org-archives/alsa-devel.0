From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/6] ALSA: seq: Don't compile
	snd_seq_device_load_drivers() for built-in
Date: Mon, 16 Feb 2015 17:55:40 +0100
Message-ID: <1424105744-2187-3-git-send-email-tiwai@suse.de>
References: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F19452606A5
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9381ABD0
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_device.h  | 4 ++++
 sound/core/seq/seq_device.c | 9 +++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/sound/seq_device.h b/include/sound/seq_device.h
index 2b5f24cc7548..d52433563da2 100644
--- a/include/sound/seq_device.h
+++ b/include/sound/seq_device.h
@@ -67,7 +67,11 @@ struct snd_seq_dev_ops {
 /*
  * prototypes
  */
+#ifdef CONFIG_MODULES
 void snd_seq_device_load_drivers(void);
+#else
+#define snd_seq_device_load_drivers()
+#endif
 int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize, struct snd_seq_device **result);
 int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry, int argsize);
 int snd_seq_device_unregister_driver(char *id);
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index a752a79a8d3a..075a66c0cc6a 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -198,19 +198,16 @@ void snd_seq_autoload_init(void)
 #endif
 }
 EXPORT_SYMBOL(snd_seq_autoload_init);
-#else
-#define try_autoload(ops) /* NOP */
-#endif
-
 
 void snd_seq_device_load_drivers(void)
 {
-#ifdef CONFIG_MODULES
 	queue_autoload_drivers();
 	flush_work(&autoload_work);
-#endif
 }
 EXPORT_SYMBOL(snd_seq_device_load_drivers);
+#else
+#define try_autoload(ops) /* NOP */
+#endif
 
 /*
  * register a sequencer device
-- 
2.3.0
