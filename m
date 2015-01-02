From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 18/21] ALSA: riptide: Remove always NULL
	parameter
Date: Fri,  2 Jan 2015 12:24:52 +0100
Message-ID: <1420197895-17696-19-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id AA42A26055C
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:22 +0100 (CET)
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

snd_riptide_pcm() takes a pointer to a pointer of a PCM where if this
parameter is provided the newly allocated PCM is stored. All callers pass
NULL though, so remove the parameter. This makes the code a bit cleaner and
shorter.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/riptide/riptide.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 6abc2ac..121f2c0 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1706,14 +1706,11 @@ static struct snd_pcm_ops snd_riptide_capture_ops = {
 	.pointer = snd_riptide_pointer,
 };
 
-static int
-snd_riptide_pcm(struct snd_riptide *chip, int device, struct snd_pcm **rpcm)
+static int snd_riptide_pcm(struct snd_riptide *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	if ((err =
 	     snd_pcm_new(chip->card, "RIPTIDE", device, PLAYBACK_SUBSTREAMS, 1,
 			 &pcm)) < 0)
@@ -1729,8 +1726,6 @@ snd_riptide_pcm(struct snd_riptide *chip, int device, struct snd_pcm **rpcm)
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV_SG,
 					      snd_dma_pci_data(chip->pci),
 					      64 * 1024, 128 * 1024);
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -2092,7 +2087,7 @@ snd_card_riptide_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 	if (err < 0)
 		goto error;
 	card->private_data = chip;
-	err = snd_riptide_pcm(chip, 0, NULL);
+	err = snd_riptide_pcm(chip, 0);
 	if (err < 0)
 		goto error;
 	err = snd_riptide_mixer(chip);
-- 
1.8.0
