From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: core: Use common error handling code in
	two functions
Date: Tue, 22 Aug 2017 21:12:02 +0200
Message-ID: <b8c9e41b-a47e-1d99-3d1a-5d39772e4b54@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id B5219266998
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 21:12:21 +0200 (CEST)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 22 Aug 2017 21:01:01 +0200

Add jump targets so that a bit of exception handling can be better reused
at the end of these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/pcm.c   | 30 ++++++++++++++++++------------
 sound/core/timer.c | 10 ++++++----
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 89c7485519cb..048df9658f50 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -783,21 +783,27 @@ static int _snd_pcm_new(struct snd_card *card, const char *id, int device,
 	INIT_LIST_HEAD(&pcm->list);
 	if (id)
 		strlcpy(pcm->id, id, sizeof(pcm->id));
-	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK, playback_count)) < 0) {
-		snd_pcm_free(pcm);
-		return err;
-	}
-	if ((err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_CAPTURE, capture_count)) < 0) {
-		snd_pcm_free(pcm);
-		return err;
-	}
-	if ((err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops)) < 0) {
-		snd_pcm_free(pcm);
-		return err;
-	}
+
+	err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+				 playback_count);
+	if (err < 0)
+		goto free_pcm;
+
+	err = snd_pcm_new_stream(pcm, SNDRV_PCM_STREAM_CAPTURE, capture_count);
+	if (err < 0)
+		goto free_pcm;
+
+	err = snd_device_new(card, SNDRV_DEV_PCM, pcm, &ops);
+	if (err < 0)
+		goto free_pcm;
+
 	if (rpcm)
 		*rpcm = pcm;
 	return 0;
+
+free_pcm:
+	snd_pcm_free(pcm);
+	return err;
 }
 
 /**
diff --git a/sound/core/timer.c b/sound/core/timer.c
index a9b9a277e00c..6d73a63f6e2b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2096,8 +2096,7 @@ static int __init alsa_timer_init(void)
 	err = snd_timer_register_system();
 	if (err < 0) {
 		pr_err("ALSA: unable to register system timer (%i)\n", err);
-		put_device(&timer_dev);
-		return err;
+		goto put_timer;
 	}
 
 	err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
@@ -2105,12 +2104,15 @@ static int __init alsa_timer_init(void)
 	if (err < 0) {
 		pr_err("ALSA: unable to register timer device (%i)\n", err);
 		snd_timer_free_all();
-		put_device(&timer_dev);
-		return err;
+		goto put_timer;
 	}
 
 	snd_timer_proc_init();
 	return 0;
+
+put_timer:
+	put_device(&timer_dev);
+	return err;
 }
 
 static void __exit alsa_timer_exit(void)
-- 
2.14.0
