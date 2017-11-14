From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: emu10k1: Use common error handling code
 in two functions
Date: Tue, 14 Nov 2017 16:46:12 +0100
Message-ID: <8c7233f8-c8e5-8b22-5b58-233f7b6cab1d@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D89C266A73
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 16:46:56 +0100 (CET)
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 Nov 2017 16:40:32 +0100

* Add jump targets so that a bit of exception handling can be better reused
  at the end of these functions.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix ten affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/emu10k1/emu10k1x.c | 62 +++++++++++++++++++++-----------------------
 sound/pci/emu10k1/emupcm.c   | 31 +++++++++++++---------
 2 files changed, 49 insertions(+), 44 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 2c2b12a06177..4f700907b566 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -1569,38 +1569,33 @@ static int snd_emu10k1x_probe(struct pci_dev *pci,
 	if (err < 0)
 		return err;
 
-	if ((err = snd_emu10k1x_create(card, pci, &chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_emu10k1x_create(card, pci, &chip);
+	if (err < 0)
+		goto free_card;
 
-	if ((err = snd_emu10k1x_pcm(chip, 0)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = snd_emu10k1x_pcm(chip, 1)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = snd_emu10k1x_pcm(chip, 2)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_emu10k1x_pcm(chip, 0);
+	if (err < 0)
+		goto free_card;
 
-	if ((err = snd_emu10k1x_ac97(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_emu10k1x_pcm(chip, 1);
+	if (err < 0)
+		goto free_card;
 
-	if ((err = snd_emu10k1x_mixer(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_emu10k1x_pcm(chip, 2);
+	if (err < 0)
+		goto free_card;
+
+	err = snd_emu10k1x_ac97(chip);
+	if (err < 0)
+		goto free_card;
+
+	err = snd_emu10k1x_mixer(chip);
+	if (err < 0)
+		goto free_card;
 	
-	if ((err = snd_emu10k1x_midi(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_emu10k1x_midi(chip);
+	if (err < 0)
+		goto free_card;
 
 	snd_emu10k1x_proc_init(chip);
 
@@ -1609,14 +1604,17 @@ static int snd_emu10k1x_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx irq %i",
 		card->shortname, chip->port, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto free_card;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_emu10k1x_remove(struct pci_dev *pci)
diff --git a/sound/pci/emu10k1/emupcm.c b/sound/pci/emu10k1/emupcm.c
index 2683b9717215..088741f90f91 100644
--- a/sound/pci/emu10k1/emupcm.c
+++ b/sound/pci/emu10k1/emupcm.c
@@ -1143,23 +1143,26 @@ static int snd_emu10k1_playback_open(struct snd_pcm_substream *substream)
 	runtime->private_data = epcm;
 	runtime->private_free = snd_emu10k1_pcm_free_substream;
 	runtime->hw = snd_emu10k1_playback;
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0) {
-		kfree(epcm);
-		return err;
-	}
-	if ((err = snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 256, UINT_MAX)) < 0) {
-		kfree(epcm);
-		return err;
-	}
+	err = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
+		goto free_pcm;
+
+	err = snd_pcm_hw_constraint_minmax(runtime,
+					   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
+					   256,
+					   UINT_MAX);
+	if (err < 0)
+		goto free_pcm;
+
 	if (emu->card_capabilities->emu_model && emu->emu1010.internal_clock == 0)
 		sample_rate = 44100;
 	else
 		sample_rate = 48000;
 	err = snd_pcm_hw_rule_noresample(runtime, sample_rate);
-	if (err < 0) {
-		kfree(epcm);
-		return err;
-	}
+	if (err < 0)
+		goto free_pcm;
+
 	mix = &emu->pcm_mixer[substream->number];
 	for (i = 0; i < 4; i++)
 		mix->send_routing[0][i] = mix->send_routing[1][i] = mix->send_routing[2][i] = i;
@@ -1170,6 +1173,10 @@ static int snd_emu10k1_playback_open(struct snd_pcm_substream *substream)
 	mix->epcm = epcm;
 	snd_emu10k1_pcm_mixer_notify(emu, substream->number, 1);
 	return 0;
+
+free_pcm:
+	kfree(epcm);
+	return err;
 }
 
 static int snd_emu10k1_playback_close(struct snd_pcm_substream *substream)
-- 
2.15.0
