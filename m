From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: [PATCH] ad1848-lib: remove open_mutex
Date: Wed, 19 Sep 2007 18:06:31 +0200
Message-ID: <20070919180631.2de17850.krzysztof.h1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 19CDB245F6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 17:59:02 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so181599nfd
	for <alsa-devel@alsa-project.org>; Wed, 19 Sep 2007 08:59:01 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes open_mutex from the ad1848-lib as
open and close operations are called only from pcm layer
and mutexed there with pcm->open_mutex.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

Another step into crusade against the ad1848-lib. Inspired by
Trent's comments about missing locking I have checked and
open and close operations are already mutexed in the pcm layer
by similarly called pcm->open_mutex. The OSS pcm layer
also uses the pcm->open_mutex.

Is it right thing to do? (Takashi, Jaroslav)?

Regards,
Krzysztof

diff -urp linux-ref/include/sound/ad1848.h linux-2.6.23/include/sound/ad1848.h
--- linux-ref/include/sound/ad1848.h	2007-09-12 13:33:51.000000000 +0200
+++ linux-2.6.23/include/sound/ad1848.h	2007-09-19 17:54:30.000000000 +0200
@@ -154,7 +154,6 @@ struct snd_ad1848 {
 #endif
 
 	spinlock_t reg_lock;
-	struct mutex open_mutex;
 };
 
 /* exported functions */
diff -urp linux-ref/sound/isa/ad1848/ad1848_lib.c linux-2.6.23/sound/isa/ad1848/ad1848_lib.c
--- linux-ref/sound/isa/ad1848/ad1848_lib.c	2007-09-12 13:33:51.000000000 +0200
+++ linux-2.6.23/sound/isa/ad1848/ad1848_lib.c	2007-09-19 17:59:38.000000000 +0200
@@ -391,11 +391,9 @@ static int snd_ad1848_open(struct snd_ad
 {
 	unsigned long flags;
 
-	mutex_lock(&chip->open_mutex);
-	if (chip->mode & AD1848_MODE_OPEN) {
-		mutex_unlock(&chip->open_mutex);
+	if (chip->mode & AD1848_MODE_OPEN)
 		return -EAGAIN;
-	}
+
 	snd_ad1848_mce_down(chip);
 
 #ifdef SNDRV_DEBUG_MCE
@@ -436,7 +434,6 @@ static int snd_ad1848_open(struct snd_ad
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->mode = mode;
-	mutex_unlock(&chip->open_mutex);
 
 	return 0;
 }
@@ -445,11 +442,8 @@ static void snd_ad1848_close(struct snd_
 {
 	unsigned long flags;
 
-	mutex_lock(&chip->open_mutex);
-	if (!chip->mode) {
-		mutex_unlock(&chip->open_mutex);
+	if (!chip->mode)
 		return;
-	}
 	/* disable IRQ */
 	spin_lock_irqsave(&chip->reg_lock, flags);
 	outb(0, AD1848P(chip, STATUS));	/* clear IRQ */
@@ -475,7 +469,6 @@ static void snd_ad1848_close(struct snd_
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 
 	chip->mode = 0;
-	mutex_unlock(&chip->open_mutex);
 }
 
 /*
@@ -893,7 +886,6 @@ int snd_ad1848_create(struct snd_card *c
 	if (chip == NULL)
 		return -ENOMEM;
 	spin_lock_init(&chip->reg_lock);
-	mutex_init(&chip->open_mutex);
 	chip->card = card;
 	chip->port = port;
 	chip->irq = -1;
