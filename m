From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ALSA: echoaudio: Use common error handling
 code in two functions
Date: Mon, 13 Nov 2017 22:02:05 +0100
Message-ID: <1780a481-5400-16db-8f09-26a4b6127c90@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D9AD3267422
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 22:02:18 +0100 (CET)
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 13 Nov 2017 21:57:57 +0100

* Add jump targets so that a bit of exception handling can be better reused
  at the end of these functions.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix six affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/echoaudio/echoaudio.c | 55 ++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index d68f99e076a8..ae58c48aaaf9 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1913,7 +1913,8 @@ static int snd_echo_create(struct snd_card *card,
 
 	pci_write_config_byte(pci, PCI_LATENCY_TIMER, 0xC0);
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	pci_set_master(pci);
 
@@ -1945,11 +1946,11 @@ static int snd_echo_create(struct snd_card *card,
 	if (sz > PAGE_SIZE)
 		sz = PAGE_SIZE;		/* We map only the required part */
 
-	if ((chip->iores = request_mem_region(chip->dsp_registers_phys, sz,
-					      ECHOCARD_NAME)) == NULL) {
+	chip->iores = request_mem_region(chip->dsp_registers_phys, sz,
+					 ECHOCARD_NAME);
+	if (!chip->iores) {
 		dev_err(chip->card->dev, "cannot get memory region\n");
-		snd_echo_free(chip);
-		return -EBUSY;
+		goto e_busy;
 	}
 	chip->dsp_registers = (volatile u32 __iomem *)
 		ioremap_nocache(chip->dsp_registers_phys, sz);
@@ -1957,8 +1958,7 @@ static int snd_echo_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "cannot grab irq\n");
-		snd_echo_free(chip);
-		return -EBUSY;
+		goto e_busy;
 	}
 	chip->irq = pci->irq;
 	dev_dbg(card->dev, "pci=%p irq=%d subdev=%04x Init hardware...\n",
@@ -1970,8 +1970,8 @@ static int snd_echo_create(struct snd_card *card,
 				sizeof(struct comm_page),
 				&chip->commpage_dma_buf) < 0) {
 		dev_err(chip->card->dev, "cannot allocate the comm page\n");
-		snd_echo_free(chip);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_sound_chip;
 	}
 	chip->comm_page_phys = chip->commpage_dma_buf.addr;
 	chip->comm_page = (struct comm_page *)chip->commpage_dma_buf.area;
@@ -1981,17 +1981,22 @@ static int snd_echo_create(struct snd_card *card,
 		err = set_mixer_defaults(chip);
 	if (err < 0) {
 		dev_err(card->dev, "init_hw err=%d\n", err);
-		snd_echo_free(chip);
-		return err;
+		goto free_sound_chip;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_echo_free(chip);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto free_sound_chip;
+
 	*rchip = chip;
 	/* Init done ! */
 	return 0;
+
+e_busy:
+	err = -EBUSY;
+free_sound_chip:
+	snd_echo_free(chip);
+	return err;
 }
 
 
@@ -2020,10 +2025,9 @@ static int snd_echo_probe(struct pci_dev *pci,
 		return err;
 
 	chip = NULL;	/* Tells snd_echo_create to allocate chip */
-	if ((err = snd_echo_create(card, pci, &chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_echo_create(card, pci, &chip);
+	if (err < 0)
+		goto free_card;
 
 	strcpy(card->driver, "Echo_" ECHOCARD_NAME);
 	strcpy(card->shortname, chip->card_name);
@@ -2036,18 +2040,18 @@ static int snd_echo_probe(struct pci_dev *pci,
 		card->shortname, pci_id->subdevice & 0x000f, dsp,
 		chip->dsp_registers_phys, chip->irq);
 
-	if ((err = snd_echo_new_pcm(chip)) < 0) {
+	err = snd_echo_new_pcm(chip);
+	if (err < 0) {
 		dev_err(chip->card->dev, "new pcm error %d\n", err);
-		snd_card_free(card);
-		return err;
+		goto free_card;
 	}
 
 #ifdef ECHOCARD_HAS_MIDI
 	if (chip->has_midi) {	/* Some Mia's do not have midi */
-		if ((err = snd_echo_midi_create(card, chip)) < 0) {
+		err = snd_echo_midi_create(card, chip);
+		if (err < 0) {
 			dev_err(chip->card->dev, "new midi error %d\n", err);
-			snd_card_free(card);
-			return err;
+			goto free_card;
 		}
 	}
 #endif
@@ -2152,6 +2156,7 @@ static int snd_echo_probe(struct pci_dev *pci,
 
 ctl_error:
 	dev_err(card->dev, "new control error %d\n", err);
+free_card:
 	snd_card_free(card);
 	return err;
 }
-- 
2.15.0
