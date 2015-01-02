From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/21] ALSA: ad1816a: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:36 +0100
Message-ID: <1420197895-17696-3-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 63C902604B7
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:01 +0100 (CET)
In-Reply-To: <1420197895-17696-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

snd_ad1816a_pcm() and snd_ad1816a_timer() take a pointer to a pointer of a
PCM/timer where if this parameter is provided the newly allocated object is
stored. All callers pass NULL though, so remove the parameter. This makes
the code a bit cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/ad1816a.h         | 5 ++---
 sound/isa/ad1816a/ad1816a.c     | 5 ++---
 sound/isa/ad1816a/ad1816a_lib.c | 9 ++-------
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/sound/ad1816a.h b/include/sound/ad1816a.h
index abdf609..f2d3a6d 100644
--- a/include/sound/ad1816a.h
+++ b/include/sound/ad1816a.h
@@ -170,10 +170,9 @@ extern int snd_ad1816a_create(struct snd_card *card, unsigned long port,
 			      int irq, int dma1, int dma2,
 			      struct snd_ad1816a *chip);
 
-extern int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm);
+extern int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device);
 extern int snd_ad1816a_mixer(struct snd_ad1816a *chip);
-extern int snd_ad1816a_timer(struct snd_ad1816a *chip, int device,
-			     struct snd_timer **rtimer);
+extern int snd_ad1816a_timer(struct snd_ad1816a *chip, int device);
 #ifdef CONFIG_PM
 extern void snd_ad1816a_suspend(struct snd_ad1816a *chip);
 extern void snd_ad1816a_resume(struct snd_ad1816a *chip);
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index f481a41..7692265 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -142,7 +142,6 @@ static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 	struct snd_card *card;
 	struct snd_ad1816a *chip;
 	struct snd_opl3 *opl3;
-	struct snd_timer *timer;
 
 	error = snd_card_new(&pcard->card->dev,
 			     index[dev], id[dev], THIS_MODULE,
@@ -172,7 +171,7 @@ static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 	sprintf(card->longname, "%s, SS at 0x%lx, irq %d, dma %d&%d",
 		card->shortname, chip->port, irq[dev], dma1[dev], dma2[dev]);
 
-	if ((error = snd_ad1816a_pcm(chip, 0, NULL)) < 0) {
+	if ((error = snd_ad1816a_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return error;
 	}
@@ -182,7 +181,7 @@ static int snd_card_ad1816a_probe(int dev, struct pnp_card_link *pcard,
 		return error;
 	}
 
-	error = snd_ad1816a_timer(chip, 0, &timer);
+	error = snd_ad1816a_timer(chip, 0);
 	if (error < 0) {
 		snd_card_free(card);
 		return error;
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 01a0798..5f99102 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -675,7 +675,7 @@ static struct snd_pcm_ops snd_ad1816a_capture_ops = {
 	.pointer =	snd_ad1816a_capture_pointer,
 };
 
-int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm)
+int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device)
 {
 	int error;
 	struct snd_pcm *pcm;
@@ -697,13 +697,10 @@ int snd_ad1816a_pcm(struct snd_ad1816a *chip, int device, struct snd_pcm **rpcm)
 					      64*1024, chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
 
 	chip->pcm = pcm;
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
-int snd_ad1816a_timer(struct snd_ad1816a *chip, int device,
-		      struct snd_timer **rtimer)
+int snd_ad1816a_timer(struct snd_ad1816a *chip, int device)
 {
 	struct snd_timer *timer;
 	struct snd_timer_id tid;
@@ -720,8 +717,6 @@ int snd_ad1816a_timer(struct snd_ad1816a *chip, int device,
 	timer->private_data = chip;
 	chip->timer = timer;
 	timer->hw = snd_ad1816a_timer_table;
-	if (rtimer)
-		*rtimer = timer;
 	return 0;
 }
 
-- 
1.8.0
