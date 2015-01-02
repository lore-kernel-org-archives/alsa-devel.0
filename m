From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 06/21] ALSA: msnd: Remove always NULL parameter
Date: Fri,  2 Jan 2015 12:24:40 +0100
Message-ID: <1420197895-17696-7-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 60BE02604D0
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:05 +0100 (CET)
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

snd_msnd_pcm() takes a pointer to a pointer of a PCM where if this parameter
is provided the newly allocated PCM is stored. All callers pass NULL though,
so remove the parameter. This makes the code a bit cleaner and shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/isa/msnd/msnd.c          | 6 +-----
 sound/isa/msnd/msnd.h          | 2 +-
 sound/isa/msnd/msnd_pinnacle.c | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/isa/msnd/msnd.c b/sound/isa/msnd/msnd.c
index 1cee18f..835d4aa 100644
--- a/sound/isa/msnd/msnd.c
+++ b/sound/isa/msnd/msnd.c
@@ -679,8 +679,7 @@ static struct snd_pcm_ops snd_msnd_capture_ops = {
 };
 
 
-int snd_msnd_pcm(struct snd_card *card, int device,
-			struct snd_pcm **rpcm)
+int snd_msnd_pcm(struct snd_card *card, int device)
 {
 	struct snd_msnd *chip = card->private_data;
 	struct snd_pcm	*pcm;
@@ -696,9 +695,6 @@ int snd_msnd_pcm(struct snd_card *card, int device,
 	pcm->private_data = chip;
 	strcpy(pcm->name, "Hurricane");
 
-
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 EXPORT_SYMBOL(snd_msnd_pcm);
diff --git a/sound/isa/msnd/msnd.h b/sound/isa/msnd/msnd.h
index dbac3a4..5f3c7dc 100644
--- a/sound/isa/msnd/msnd.h
+++ b/sound/isa/msnd/msnd.h
@@ -297,7 +297,7 @@ int snd_msnd_disable_irq(struct snd_msnd *chip);
 void snd_msnd_dsp_halt(struct snd_msnd *chip, struct file *file);
 int snd_msnd_DAPQ(struct snd_msnd *chip, int start);
 int snd_msnd_DARQ(struct snd_msnd *chip, int start);
-int snd_msnd_pcm(struct snd_card *card, int device, struct snd_pcm **rpcm);
+int snd_msnd_pcm(struct snd_card *card, int device);
 
 int snd_msndmidi_new(struct snd_card *card, int device);
 void snd_msndmidi_input_read(void *mpu);
diff --git a/sound/isa/msnd/msnd_pinnacle.c b/sound/isa/msnd/msnd_pinnacle.c
index 5016bf9..65b3682 100644
--- a/sound/isa/msnd/msnd_pinnacle.c
+++ b/sound/isa/msnd/msnd_pinnacle.c
@@ -582,7 +582,7 @@ static int snd_msnd_attach(struct snd_card *card)
 	if (err < 0)
 		goto err_release_region;
 
-	err = snd_msnd_pcm(card, 0, NULL);
+	err = snd_msnd_pcm(card, 0);
 	if (err < 0) {
 		printk(KERN_ERR LOGNAME ": error creating new PCM device\n");
 		goto err_release_region;
-- 
1.8.0
