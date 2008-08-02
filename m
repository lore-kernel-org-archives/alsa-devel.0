From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] wss_lib: remove open_mutex
Date: Sat, 2 Aug 2008 07:48:46 +0200
Message-ID: <20080802074846.91839fb6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 12FE024611
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Aug 2008 07:43:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Open and close operations are mutexed in higher layer
so remove open_mutex inside the driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-alsa/include/sound/wss.h linux-mm/include/sound/wss.h
--- linux-alsa/include/sound/wss.h	2008-07-31 20:39:54.000000000 +0200
+++ linux-mm/include/sound/wss.h	2008-08-02 07:42:41.256261329 +0200
@@ -110,7 +110,6 @@ struct snd_wss {
 
 	spinlock_t reg_lock;
 	struct mutex mce_mutex;
-	struct mutex open_mutex;
 
 	int (*rate_constraint) (struct snd_pcm_runtime *runtime);
 	void (*set_playback_format) (struct snd_wss *chip,
diff -urp linux-alsa/sound/isa/wss/wss_lib.c linux-mm/sound/isa/wss/wss_lib.c
--- linux-alsa/sound/isa/wss/wss_lib.c	2008-07-31 20:39:59.000000000 +0200
+++ linux-mm/sound/isa/wss/wss_lib.c	2008-08-02 07:42:41.352275508 +0200
@@ -837,15 +837,11 @@ static int snd_wss_open(struct snd_wss *
 {
 	unsigned long flags;
 
-	mutex_lock(&chip->open_mutex);
 	if ((chip->mode & mode) ||
-	    ((chip->mode & WSS_MODE_OPEN) && chip->single_dma)) {
-		mutex_unlock(&chip->open_mutex);
+	    ((chip->mode & WSS_MODE_OPEN) && chip->single_dma))
 		return -EAGAIN;
-	}
 	if (chip->mode & WSS_MODE_OPEN) {
 		chip->mode |= mode;
-		mutex_unlock(&chip->open_mutex);
 		return 0;
 	}
 	/* ok. now enable and ack CODEC IRQ */
@@ -871,7 +867,6 @@ static int snd_wss_open(struct snd_wss *
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->mode = mode;
-	mutex_unlock(&chip->open_mutex);
 	return 0;
 }
 
@@ -879,10 +874,8 @@ static void snd_wss_close(struct snd_wss
 {
 	unsigned long flags;
 
-	mutex_lock(&chip->open_mutex);
 	chip->mode &= ~mode;
 	if (chip->mode & WSS_MODE_OPEN) {
-		mutex_unlock(&chip->open_mutex);
 		return;
 	}
 	snd_wss_calibrate_mute(chip, 1);
@@ -922,7 +915,6 @@ static void snd_wss_close(struct snd_wss
 	snd_wss_calibrate_mute(chip, 0);
 
 	chip->mode = 0;
-	mutex_unlock(&chip->open_mutex);
 }
 
 /*
@@ -1712,7 +1704,6 @@ static int snd_wss_new(struct snd_card *
 
 	spin_lock_init(&chip->reg_lock);
 	mutex_init(&chip->mce_mutex);
-	mutex_init(&chip->open_mutex);
 	chip->card = card;
 	chip->rate_constraint = snd_wss_xrate;
 	chip->set_playback_format = snd_wss_playback_format;
@@ -1868,7 +1859,6 @@ int snd_wss_pcm(struct snd_wss *chip, in
 
 	spin_lock_init(&chip->reg_lock);
 	mutex_init(&chip->mce_mutex);
-	mutex_init(&chip->open_mutex);
 
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_wss_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_wss_capture_ops);

----------------------------------------------------------------------
Najciekawsze miejsca w Polsce i na swiecie!
Zobacz >>> http://link.interia.pl/f1e60
