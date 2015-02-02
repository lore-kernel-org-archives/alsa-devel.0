From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 09/14] ALSA: timer: Propagate the error at
	initialization
Date: Mon,  2 Feb 2015 11:24:33 +0100
Message-ID: <1422872678-4815-10-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F5542604F7
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E700EAD32
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:39 +0000 (UTC)
In-Reply-To: <1422872678-4815-1-git-send-email-tiwai@suse.de>
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

... instead of just printing errors.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 777a45e08e53..28b673d4f812 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1942,6 +1942,15 @@ static const struct file_operations snd_timer_f_ops =
 	.fasync = 	snd_timer_user_fasync,
 };
 
+/* unregister the system timer */
+static void snd_timer_free_all(void)
+{
+	struct snd_timer *timer, *n;
+
+	list_for_each_entry_safe(timer, n, &snd_timer_list, device_list)
+		snd_timer_free(timer);
+}
+
 /*
  *  ENTRY functions
  */
@@ -1955,25 +1964,28 @@ static int __init alsa_timer_init(void)
 			      "system timer");
 #endif
 
-	if ((err = snd_timer_register_system()) < 0)
+	err = snd_timer_register_system();
+	if (err < 0) {
 		pr_err("ALSA: unable to register system timer (%i)\n", err);
-	if ((err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
-				       &snd_timer_f_ops, NULL, "timer")) < 0)
+		return err;
+	}
+
+	err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
+				  &snd_timer_f_ops, NULL, "timer");
+	if (err < 0) {
 		pr_err("ALSA: unable to register timer device (%i)\n", err);
+		snd_timer_free_all();
+		return err;
+	}
+
 	snd_timer_proc_init();
 	return 0;
 }
 
 static void __exit alsa_timer_exit(void)
 {
-	struct list_head *p, *n;
-
 	snd_unregister_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0);
-	/* unregister the system timer */
-	list_for_each_safe(p, n, &snd_timer_list) {
-		struct snd_timer *timer = list_entry(p, struct snd_timer, device_list);
-		snd_timer_free(timer);
-	}
+	snd_timer_free_all();
 	snd_timer_proc_done();
 #ifdef SNDRV_OSS_INFO_DEV_TIMERS
 	snd_oss_info_unregister(SNDRV_OSS_INFO_DEV_TIMERS, SNDRV_CARDS - 1);
-- 
2.2.2
