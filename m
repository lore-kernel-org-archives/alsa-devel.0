From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: es1968: Adjust 16 function calls
 together with a variable assignment
Date: Wed, 15 Nov 2017 10:27:49 +0100
Message-ID: <12f2cc3e-7a5b-4406-1286-e5834490c414@users.sourceforge.net>
References: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B2A5266E67
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 10:27:57 +0100 (CET)
In-Reply-To: <e1e9e0cc-0378-c2fe-015d-15555fd61a23@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 14 Nov 2017 22:45:01 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/es1968.c | 78 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 0b1845ca6005..d68980087f93 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -1620,7 +1620,8 @@ static int snd_es1968_capture_open(struct snd_pcm_substream *substream)
 	es->mode = ESM_MODE_CAPTURE;
 
 	/* get mixbuffer */
-	if ((es->mixbuf = snd_es1968_new_memory(chip, ESM_MIXBUF_SIZE)) == NULL) {
+	es->mixbuf = snd_es1968_new_memory(chip, ESM_MIXBUF_SIZE);
+	if (!es->mixbuf) {
 		snd_es1968_free_apu_pair(chip, apu1);
 		snd_es1968_free_apu_pair(chip, apu2);
 		kfree(es);
@@ -1717,11 +1718,14 @@ static void es1968_measure_clock(struct es1968 *chip)
 		chip->clock = 48000; /* default clock value */
 
 	/* search 2 APUs (although one apu is enough) */
-	if ((apu = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_PLAY)) < 0) {
+	apu = snd_es1968_alloc_apu_pair(chip, ESM_APU_PCM_PLAY);
+	if (apu < 0) {
 		dev_err(chip->card->dev, "Hmm, cannot find empty APU pair!?\n");
 		return;
 	}
-	if ((memory = snd_es1968_new_memory(chip, CLOCK_MEASURE_BUFSIZE)) == NULL) {
+
+	memory = snd_es1968_new_memory(chip, CLOCK_MEASURE_BUFSIZE);
+	if (!memory) {
 		dev_warn(chip->card->dev,
 			 "cannot allocate dma buffer - using default clock %d\n",
 			 chip->clock);
@@ -1813,7 +1817,8 @@ snd_es1968_pcm(struct es1968 *chip, int device)
 	int err;
 
 	/* get DMA buffer */
-	if ((err = snd_es1968_init_dmabuf(chip)) < 0)
+	err = snd_es1968_init_dmabuf(chip);
+	if (err < 0)
 		return err;
 
 	/* set PCMBAR */
@@ -1822,9 +1827,10 @@ snd_es1968_pcm(struct es1968 *chip, int device)
 	wave_set_register(chip, 0x01FE, chip->dma.addr >> 12);
 	wave_set_register(chip, 0x01FF, chip->dma.addr >> 12);
 
-	if ((err = snd_pcm_new(chip->card, "ESS Maestro", device,
-			       chip->playback_streams,
-			       chip->capture_streams, &pcm)) < 0)
+	err = snd_pcm_new(chip->card, "ESS Maestro", device,
+			  chip->playback_streams,
+			  chip->capture_streams, &pcm);
+	if (err < 0)
 		return err;
 
 	pcm->private_data = chip;
@@ -1973,9 +1979,9 @@ static void es1968_update_hw_volume(struct work_struct *work)
 static irqreturn_t snd_es1968_interrupt(int irq, void *dev_id)
 {
 	struct es1968 *chip = dev_id;
-	u32 event;
+	u32 event = inb(chip->io_port + 0x1A);
 
-	if (!(event = inb(chip->io_port + 0x1A)))
+	if (!event)
 		return IRQ_NONE;
 
 	outw(inw(chip->io_port + 4) & 1, chip->io_port + 4);
@@ -2030,13 +2036,15 @@ snd_es1968_mixer(struct es1968 *chip)
 		.read = snd_es1968_ac97_read,
 	};
 
-	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
+	err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus);
+	if (err < 0)
 		return err;
 	pbus->no_vra = 1; /* ES1968 doesn't need VRA */
 
 	memset(&ac97, 0, sizeof(ac97));
 	ac97.private_data = chip;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97)) < 0)
+	err = snd_ac97_mixer(pbus, &ac97, &chip->ac97);
+	if (err < 0)
 		return err;
 
 #ifndef CONFIG_SND_ES1968_INPUT
@@ -2686,7 +2694,8 @@ static int snd_es1968_create(struct snd_card *card,
 	*chip_ret = NULL;
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(28)) < 0 ||
@@ -2718,7 +2727,8 @@ static int snd_es1968_create(struct snd_card *card,
 	chip->playback_streams = play_streams;
 	chip->capture_streams = capt_streams;
 
-	if ((err = pci_request_regions(pci, "ESS Maestro")) < 0) {
+	err = pci_request_regions(pci, "ESS Maestro");
+	if (err < 0) {
 		kfree(chip);
 		pci_disable_device(pci);
 		return err;
@@ -2764,7 +2774,8 @@ static int snd_es1968_create(struct snd_card *card,
 
 	snd_es1968_chip_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_es1968_free(chip);
 		return err;
 	}
@@ -2829,14 +2840,16 @@ static int snd_es1968_probe(struct pci_dev *pci,
 		total_bufsize[dev] = 128;
 	if (total_bufsize[dev] > 4096)
 		total_bufsize[dev] = 4096;
-	if ((err = snd_es1968_create(card, pci,
-				     total_bufsize[dev] * 1024, /* in bytes */
-				     pcm_substreams_p[dev], 
-				     pcm_substreams_c[dev],
-				     pci_id->driver_data,
-				     use_pm[dev],
-				     radio_nr[dev],
-				     &chip)) < 0) {
+
+	err = snd_es1968_create(card, pci,
+				total_bufsize[dev] * 1024, /* in bytes */
+				pcm_substreams_p[dev],
+				pcm_substreams_c[dev],
+				pci_id->driver_data,
+				use_pm[dev],
+				radio_nr[dev],
+				&chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -2857,12 +2870,14 @@ static int snd_es1968_probe(struct pci_dev *pci,
 		break;
 	}
 
-	if ((err = snd_es1968_pcm(chip, 0)) < 0) {
+	err = snd_es1968_pcm(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 
-	if ((err = snd_es1968_mixer(chip)) < 0) {
+	err = snd_es1968_mixer(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -2880,13 +2895,13 @@ static int snd_es1968_probe(struct pci_dev *pci,
 		}
 	}
 	if (enable_mpu[dev]) {
-		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
-					       chip->io_port + ESM_MPU401_PORT,
-					       MPU401_INFO_INTEGRATED |
-					       MPU401_INFO_IRQ_HOOK,
-					       -1, &chip->rmidi)) < 0) {
+		err = snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					  chip->io_port + ESM_MPU401_PORT,
+					  MPU401_INFO_INTEGRATED |
+					  MPU401_INFO_IRQ_HOOK,
+					  -1, &chip->rmidi);
+		if (err < 0)
 			dev_warn(card->dev, "skipping MPU-401 MIDI support..\n");
-		}
 	}
 
 	snd_es1968_create_gameport(chip, dev);
@@ -2907,7 +2922,8 @@ static int snd_es1968_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at 0x%lx, irq %i",
 		card->shortname, chip->io_port, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
