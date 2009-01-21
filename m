From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] ad1816a: enable hardware timer
Date: Wed, 21 Jan 2009 15:14:09 +0100
Message-ID: <20090121151409.3d15bf9d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 86A39243EE
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 15:11:08 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Enable hardware timer with 10 usec resolution.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
This timer passes the test with the "timer" command
from the alsa-lib/test package. Amazing, that a whole
code was already in the driver just commented out.

 include/sound/ad1816a.h         |    2 ++
 sound/isa/ad1816a/ad1816a.c     |    7 +++++++
 sound/isa/ad1816a/ad1816a_lib.c |    5 -----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/sound/ad1816a.h b/include/sound/ad1816a.h
index b3aa62e..d010858 100644
--- a/include/sound/ad1816a.h
+++ b/include/sound/ad1816a.h
@@ -169,5 +169,7 @@ extern int snd_ad1816a_create(struct snd_card *card, unsigned long port,
 
 extern int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm);
 extern int snd_ad1816a_mixer(struct snd_ad1816a *chip);
+extern int snd_ad1816a_timer(struct snd_ad1816a *chip, int device,
+			     struct snd_timer **rtimer);
 
 #endif	/* __SOUND_AD1816A_H */
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 3810833..15f6010 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -156,6 +156,7 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 	struct snd_card_ad1816a *acard;
 	struct snd_ad1816a *chip;
 	struct snd_opl3 *opl3;
+	struct snd_timer *timer;
 
 	if ((card = snd_card_new(index[dev], id[dev], THIS_MODULE,
 				 sizeof(struct snd_card_ad1816a))) == NULL)
@@ -194,6 +195,12 @@ static int __devinit snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard
 		return error;
 	}
 
+	error = snd_ad1816a_timer(chip, 0, &timer);
+	if (error < 0) {
+		snd_card_free(card);
+		return error;
+	}
+
 	if (mpu_port[dev] > 0) {
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
 					mpu_port[dev], 0, mpu_irq[dev], IRQF_DISABLED,
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 3bfca7c..1c9e01e 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -377,7 +377,6 @@ static struct snd_pcm_hardware snd_ad1816a_capture = {
 	.fifo_size =		0,
 };
 
-#if 0 /* not used now */
 static int snd_ad1816a_timer_close(struct snd_timer *timer)
 {
 	struct snd_ad1816a *chip = snd_timer_chip(timer);
@@ -442,8 +441,6 @@ static struct snd_timer_hardware snd_ad1816a_timer_table = {
 	.start =	snd_ad1816a_timer_start,
 	.stop =		snd_ad1816a_timer_stop,
 };
-#endif /* not used now */
-
 
 static int snd_ad1816a_playback_open(struct snd_pcm_substream *substream)
 {
@@ -687,7 +684,6 @@ int __devinit snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_p
 	return 0;
 }
 
-#if 0 /* not used now */
 int __devinit snd_ad1816a_timer(struct snd_ad1816a *chip, int device, struct snd_timer **rtimer)
 {
 	struct snd_timer *timer;
@@ -709,7 +705,6 @@ int __devinit snd_ad1816a_timer(struct snd_ad1816a *chip, int device, struct snd
 		*rtimer = timer;
 	return 0;
 }
-#endif /* not used now */
 
 /*
  *
-- 
1.5.2.2



----------------------------------------------------------------------
Zobacz program TV na dzis!
sprawdz >>>http://link.interia.pl/f202a
