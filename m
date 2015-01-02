From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 12/21] ALSA: cs4281: Remove always NULL
	parameters
Date: Fri,  2 Jan 2015 12:24:46 +0100
Message-ID: <1420197895-17696-13-git-send-email-lars@metafoo.de>
References: <1420197895-17696-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-227.synserver.de (smtp-out-232.synserver.de
 [212.40.185.232])
 by alsa0.perex.cz (Postfix) with ESMTP id C707A26053E
 for <alsa-devel@alsa-project.org>; Fri,  2 Jan 2015 12:25:15 +0100 (CET)
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

snd_cs4281_pcm() and snd_cs4281_midi() take a pointer to a pointer of a
PCM/MIDI object where if this parameter is provided the newly allocated
object is stored. All callers pass NULL though, so remove the parameter.
This makes the code a bit shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/pci/cs4281.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 4c49b5c..05a4337 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -973,14 +973,11 @@ static struct snd_pcm_ops snd_cs4281_capture_ops = {
 	.pointer =	snd_cs4281_pointer,
 };
 
-static int snd_cs4281_pcm(struct cs4281 *chip, int device,
-			  struct snd_pcm **rpcm)
+static int snd_cs4281_pcm(struct cs4281 *chip, int device)
 {
 	struct snd_pcm *pcm;
 	int err;
 
-	if (rpcm)
-		*rpcm = NULL;
 	err = snd_pcm_new(chip->card, "CS4281", device, 1, 1, &pcm);
 	if (err < 0)
 		return err;
@@ -996,8 +993,6 @@ static int snd_cs4281_pcm(struct cs4281 *chip, int device,
 	snd_pcm_lib_preallocate_pages_for_all(pcm, SNDRV_DMA_TYPE_DEV,
 					      snd_dma_pci_data(chip->pci), 64*1024, 512*1024);
 
-	if (rpcm)
-		*rpcm = pcm;
 	return 0;
 }
 
@@ -1788,14 +1783,11 @@ static struct snd_rawmidi_ops snd_cs4281_midi_input =
 	.trigger =	snd_cs4281_midi_input_trigger,
 };
 
-static int snd_cs4281_midi(struct cs4281 *chip, int device,
-			   struct snd_rawmidi **rrawmidi)
+static int snd_cs4281_midi(struct cs4281 *chip, int device)
 {
 	struct snd_rawmidi *rmidi;
 	int err;
 
-	if (rrawmidi)
-		*rrawmidi = NULL;
 	if ((err = snd_rawmidi_new(chip->card, "CS4281", device, 1, 1, &rmidi)) < 0)
 		return err;
 	strcpy(rmidi->name, "CS4281");
@@ -1804,8 +1796,6 @@ static int snd_cs4281_midi(struct cs4281 *chip, int device,
 	rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT | SNDRV_RAWMIDI_INFO_INPUT | SNDRV_RAWMIDI_INFO_DUPLEX;
 	rmidi->private_data = chip;
 	chip->rmidi = rmidi;
-	if (rrawmidi)
-		*rrawmidi = rmidi;
 	return 0;
 }
 
@@ -1941,11 +1931,11 @@ static int snd_cs4281_probe(struct pci_dev *pci,
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs4281_pcm(chip, 0, NULL)) < 0) {
+	if ((err = snd_cs4281_pcm(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_cs4281_midi(chip, 0, NULL)) < 0) {
+	if ((err = snd_cs4281_midi(chip, 0)) < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
1.8.0
