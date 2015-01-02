From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/21] ALSA: es1688: Remove almost always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:37 +0100
Message-ID: <1420197895-17696-4-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 527AE2604CF
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:02 +0100 (CET)
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

snd_es1688_pcm() takes a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. This PCM is also
available from the pcm field of the snd_es1688 struct that got passed to the
same function. This patch updates all callers which passed a pointer to use
that field instead and then removes the parameter from the function. This
makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/es1688.h        | 3 +--
 sound/isa/es1688/es1688.c     | 7 +++----
 sound/isa/es1688/es1688_lib.c | 6 +-----
 sound/isa/gus/gusextreme.c    | 2 +-
 4 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/sound/es1688.h b/include/sound/es1688.h
index 1d636a2..b34f23a 100644
--- a/include/sound/es1688.h
+++ b/include/sound/es1688.h
@@ -115,8 +115,7 @@ int snd_es1688_create(struct snd_card *card,
 		      int mpu_irq,
 		      int dma8,
 		      unsigned short hardware);
-int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip, int device,
-		   struct snd_pcm **rpcm);
+int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip, int device);
 int snd_es1688_mixer(struct snd_card *card, struct snd_es1688 *chip);
 int snd_es1688_reset(struct snd_es1688 *chip);
 
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 76001fe0..1901c2b 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -138,10 +138,9 @@ static int snd_es1688_probe(struct snd_card *card, unsigned int n)
 {
 	struct snd_es1688 *chip = card->private_data;
 	struct snd_opl3 *opl3;
-	struct snd_pcm *pcm;
 	int error;
 
-	error = snd_es1688_pcm(card, chip, 0, &pcm);
+	error = snd_es1688_pcm(card, chip, 0);
 	if (error < 0)
 		return error;
 
@@ -150,9 +149,9 @@ static int snd_es1688_probe(struct snd_card *card, unsigned int n)
 		return error;
 
 	strlcpy(card->driver, "ES1688", sizeof(card->driver));
-	strlcpy(card->shortname, pcm->name, sizeof(card->shortname));
+	strlcpy(card->shortname, chip->pcm->name, sizeof(card->shortname));
 	snprintf(card->longname, sizeof(card->longname),
-		"%s at 0x%lx, irq %i, dma %i", pcm->name, chip->port,
+		"%s at 0x%lx, irq %i, dma %i", chip->pcm->name, chip->port,
 		 chip->irq, chip->dma8);
 
 	if (fm_port[n] == SNDRV_AUTO_PORT)
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index b545014..52aac84 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -728,8 +728,7 @@ static struct snd_pcm_ops snd_es1688_capture_ops = {
 	.pointer =		snd_es1688_capture_pointer,
 };
 
-int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip,
-		   int device, struct snd_pcm **rpcm)
+int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
@@ -749,9 +748,6 @@ int snd_es1688_pcm(struct snd_card *card, struct snd_es1688 *chip,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_isa_data(),
 					      64*1024, 64*1024);
-
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 28a1693..acc6552 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -284,7 +284,7 @@ static int snd_gusextreme_probe(struct device *dev, unsigned int n)
 	}
 	gus->codec_flag = 1;
 
-	error = snd_es1688_pcm(card, es1688, 0, NULL);
+	error = snd_es1688_pcm(card, es1688, 0);
 	if (error < 0)
 		goto out;
 
-- 
1.8.0
