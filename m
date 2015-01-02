From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/21] ALSA: es18xx: Remove always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:38 +0100
Message-ID: <1420197895-17696-5-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 62ED72604CE
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:03 +0100 (CET)
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

snd_es18xx_pcm() takes a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/isa/es18xx.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index b481bb8..6cc2d2b 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1687,16 +1687,13 @@ static struct snd_pcm_ops snd_es18xx_capture_ops = {
 	.pointer =	snd_es18xx_capture_pointer,
 };
 
-static int snd_es18xx_pcm(struct snd_card *card, int device,
-			  struct snd_pcm **rpcm)
+static int snd_es18xx_pcm(struct snd_card *card, int device)
 {
 	struct snd_es18xx *chip = card->private_data;
         struct snd_pcm *pcm;
 	char str[16];
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	sprintf(str, "ES%x", chip->version);
 	if (chip->caps & ES18XX_PCM2)
 		err = snd_pcm_new(card, str, device, 2, 1, &pcm);
@@ -1722,9 +1719,6 @@ static int snd_es18xx_pcm(struct snd_card *card, int device,
 					      snd_dma_isa_data(),
 					      64*1024,
 					      chip->dma1 > 3 || chip->dma2 > 3 ? 128*1024 : 64*1024);
-
-        if (rpcm)
-        	*rpcm = pcm;
 	return 0;
 }
 
@@ -2154,7 +2148,7 @@ static int snd_audiodrive_probe(struct snd_card *card, int dev)
 			chip->port,
 			irq[dev], dma1[dev]);
 
-	err = snd_es18xx_pcm(card, 0, NULL);
+	err = snd_es18xx_pcm(card, 0);
 	if (err < 0)
 		return err;
 
-- 
1.8.0
