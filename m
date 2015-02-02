From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/14] ALSA: timer: Handle the device directly
Date: Mon,  2 Feb 2015 11:24:34 +0100
Message-ID: <1422872678-4815-11-git-send-email-tiwai@suse.de>
References: <1422872678-4815-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7275A26050A
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 11:24:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 038F2AD57
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 10:24:40 +0000 (UTC)
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

This is a relatively straightforward change, using the struct device
directly for managing the ALSA timer device.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/timer.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 28b673d4f812..dae40ac11e04 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -1951,6 +1951,8 @@ static void snd_timer_free_all(void)
 		snd_timer_free(timer);
 }
 
+static struct device timer_dev;
+
 /*
  *  ENTRY functions
  */
@@ -1959,6 +1961,9 @@ static int __init alsa_timer_init(void)
 {
 	int err;
 
+	snd_device_initialize(&timer_dev, NULL);
+	dev_set_name(&timer_dev, "timer");
+
 #ifdef SNDRV_OSS_INFO_DEV_TIMERS
 	snd_oss_info_register(SNDRV_OSS_INFO_DEV_TIMERS, SNDRV_CARDS - 1,
 			      "system timer");
@@ -1967,14 +1972,17 @@ static int __init alsa_timer_init(void)
 	err = snd_timer_register_system();
 	if (err < 0) {
 		pr_err("ALSA: unable to register system timer (%i)\n", err);
+		put_device(&timer_dev);
 		return err;
 	}
 
-	err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
-				  &snd_timer_f_ops, NULL, "timer");
+	err = snd_register_device_for_dev(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
+					  &snd_timer_f_ops, NULL,
+					  &timer_dev, NULL, NULL);
 	if (err < 0) {
 		pr_err("ALSA: unable to register timer device (%i)\n", err);
 		snd_timer_free_all();
+		put_device(&timer_dev);
 		return err;
 	}
 
@@ -1986,6 +1994,7 @@ static void __exit alsa_timer_exit(void)
 {
 	snd_unregister_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0);
 	snd_timer_free_all();
+	put_device(&timer_dev);
 	snd_timer_proc_done();
 #ifdef SNDRV_OSS_INFO_DEV_TIMERS
 	snd_oss_info_unregister(SNDRV_OSS_INFO_DEV_TIMERS, SNDRV_CARDS - 1);
-- 
2.2.2
