From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/21] ALSA: fm801: Remove always NULL parameter
Date: Fri,  2 Jan 2015 12:24:50 +0100
Message-ID: <1420197895-17696-17-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id 536C8260554
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:21 +0100 (CET)
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

snd_fm801_pcm() takes a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/fm801.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index d167aff..9a2122f 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -704,13 +704,11 @@ static struct snd_pcm_ops snd_fm801_capture_ops = {
 	.pointer =	snd_fm801_capture_pointer,
 };
 
-static int snd_fm801_pcm(struct fm801 *chip, int device, struct snd_pcm **rpcm)
+static int snd_fm801_pcm(struct fm801 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err = snd_pcm_new(chip->card, "FM801", device, 1, 1, &pcm)) < 0)
 		return err;
 
@@ -726,16 +724,10 @@ static int snd_fm801_pcm(struct fm801 *chip, int device, struct snd_pcm **rpcm)
 					      snd_dma_pci_data(chip->pci),
 					      chip->multichannel ? 128*1024 : 64*1024, 128*1024);
 
-	err = snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
+	return snd_pcm_add_chmap_ctls(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 				     snd_pcm_alt_chmaps,
 				     chip->multichannel ? 6 : 2, 0,
 				     NULL);
-	if (err < 0)
-		return err;
-
-	if (rpcm)
-		*rpcm = pcm;
-	return 0;
 }
 
 /*
@@ -1340,7 +1332,7 @@ static int snd_card_fm801_probe(struct pci_dev *pci,
 	if (chip->tea575x_tuner & TUNER_ONLY)
 		goto __fm801_tuner_only;
 
-	if ((err = snd_fm801_pcm(chip, 0, NULL)) < 0) {
+	if ((err = snd_fm801_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
1.8.0
