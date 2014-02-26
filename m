From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 31/48] ALSA: echoaudio: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:33 +0100
Message-ID: <1393430030-26704-32-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C0F2657C8
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id D72B07503D
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/echoaudio/echoaudio.c     | 21 +++++++++++----------
 sound/pci/echoaudio/echoaudio_dsp.c |  9 +++++----
 sound/pci/echoaudio/midi.c          |  3 ++-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 1ef77c0d39ec..166ec0c120d4 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -58,7 +58,8 @@ static int get_firmware(const struct firmware **fw_entry,
 	snprintf(name, sizeof(name), "ea/%s", card_fw[fw_index].data);
 	err = request_firmware(fw_entry, name, pci_device(chip));
 	if (err < 0)
-		snd_printk(KERN_ERR "get_firmware(): Firmware not available (%d)\n", err);
+		dev_err(chip->card->dev,
+			"get_firmware(): Firmware not available (%d)\n", err);
 #ifdef CONFIG_PM_SLEEP
 	else
 		chip->fw_cache[fw_index] = *fw_entry;
@@ -563,7 +564,7 @@ static int init_engine(struct snd_pcm_substream *substream,
 	err = snd_pcm_lib_malloc_pages(substream,
 				       params_buffer_bytes(hw_params));
 	if (err < 0) {
-		snd_printk(KERN_ERR "malloc_pages err=%d\n", err);
+		dev_err(chip->card->dev, "malloc_pages err=%d\n", err);
 		spin_lock_irq(&chip->lock);
 		free_pipes(chip, pipe);
 		spin_unlock_irq(&chip->lock);
@@ -1990,7 +1991,7 @@ static int snd_echo_create(struct snd_card *card,
 	if ((chip->iores = request_mem_region(chip->dsp_registers_phys, sz,
 					      ECHOCARD_NAME)) == NULL) {
 		snd_echo_free(chip);
-		snd_printk(KERN_ERR "cannot get memory region\n");
+		dev_err(chip->card->dev, "cannot get memory region\n");
 		return -EBUSY;
 	}
 	chip->dsp_registers = (volatile u32 __iomem *)
@@ -1999,7 +2000,7 @@ static int snd_echo_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		snd_echo_free(chip);
-		snd_printk(KERN_ERR "cannot grab irq\n");
+		dev_err(chip->card->dev, "cannot grab irq\n");
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
@@ -2012,7 +2013,7 @@ static int snd_echo_create(struct snd_card *card,
 				sizeof(struct comm_page),
 				&chip->commpage_dma_buf) < 0) {
 		snd_echo_free(chip);
-		snd_printk(KERN_ERR "cannot allocate the comm page\n");
+		dev_err(chip->card->dev, "cannot allocate the comm page\n");
 		return -ENOMEM;
 	}
 	chip->comm_page_phys = chip->commpage_dma_buf.addr;
@@ -2081,7 +2082,7 @@ static int snd_echo_probe(struct pci_dev *pci,
 		chip->dsp_registers_phys, chip->irq);
 
 	if ((err = snd_echo_new_pcm(chip)) < 0) {
-		snd_printk(KERN_ERR "new pcm error %d\n", err);
+		dev_err(chip->card->dev, "new pcm error %d\n", err);
 		snd_card_free(card);
 		return err;
 	}
@@ -2089,7 +2090,7 @@ static int snd_echo_probe(struct pci_dev *pci,
 #ifdef ECHOCARD_HAS_MIDI
 	if (chip->has_midi) {	/* Some Mia's do not have midi */
 		if ((err = snd_echo_midi_create(card, chip)) < 0) {
-			snd_printk(KERN_ERR "new midi error %d\n", err);
+			dev_err(chip->card->dev, "new midi error %d\n", err);
 			snd_card_free(card);
 			return err;
 		}
@@ -2188,14 +2189,14 @@ static int snd_echo_probe(struct pci_dev *pci,
 	err = snd_card_register(card);
 	if (err < 0)
 		goto ctl_error;
-	snd_printk(KERN_INFO "Card registered: %s\n", card->longname);
+	dev_info(card->dev, "Card registered: %s\n", card->longname);
 
 	pci_set_drvdata(pci, chip);
 	dev++;
 	return 0;
 
 ctl_error:
-	snd_printk(KERN_ERR "new control error %d\n", err);
+	dev_err(card->dev, "new control error %d\n", err);
 	snd_card_free(card);
 	return err;
 }
@@ -2291,7 +2292,7 @@ static int snd_echo_resume(struct device *dev)
 	if (request_irq(pci->irq, snd_echo_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		snd_echo_free(chip);
-		snd_printk(KERN_ERR "cannot grab irq\n");
+		dev_err(chip->card->dev, "cannot grab irq\n");
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
diff --git a/sound/pci/echoaudio/echoaudio_dsp.c b/sound/pci/echoaudio/echoaudio_dsp.c
index d8c670c9d62c..5a6a217b82e0 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.c
+++ b/sound/pci/echoaudio/echoaudio_dsp.c
@@ -53,7 +53,7 @@ static int wait_handshake(struct echoaudio *chip)
 		udelay(1);
 	}
 
-	snd_printk(KERN_ERR "wait_handshake(): Timeout waiting for DSP\n");
+	dev_err(chip->card->dev, "wait_handshake(): Timeout waiting for DSP\n");
 	return -EBUSY;
 }
 
@@ -149,7 +149,8 @@ static int read_sn(struct echoaudio *chip)
 
 	for (i = 0; i < 5; i++) {
 		if (read_dsp(chip, &sn[i])) {
-			snd_printk(KERN_ERR "Failed to read serial number\n");
+			dev_err(chip->card->dev,
+				"Failed to read serial number\n");
 			return -EIO;
 		}
 	}
@@ -184,7 +185,7 @@ static int load_asic_generic(struct echoaudio *chip, u32 cmd, short asic)
 
 	err = get_firmware(&fw, chip, asic);
 	if (err < 0) {
-		snd_printk(KERN_WARNING "Firmware not found !\n");
+		dev_warn(chip->card->dev, "Firmware not found !\n");
 		return err;
 	}
 
@@ -247,7 +248,7 @@ static int install_resident_loader(struct echoaudio *chip)
 
 	i = get_firmware(&fw, chip, FW_361_LOADER);
 	if (i < 0) {
-		snd_printk(KERN_WARNING "Firmware not found !\n");
+		dev_warn(chip->card->dev, "Firmware not found !\n");
 		return i;
 	}
 
diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index abfd51c2530e..7f4dfae0323a 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -221,7 +221,8 @@ static void snd_echo_midi_output_write(unsigned long data)
 		DE_MID(("Try to send %d bytes...\n", bytes));
 		sent = write_midi(chip, buf, bytes);
 		if (sent < 0) {
-			snd_printk(KERN_ERR "write_midi() error %d\n", sent);
+			dev_err(chip->card->dev,
+				"write_midi() error %d\n", sent);
 			/* retry later */
 			sent = 9000;
 			chip->midi_full = 1;
-- 
1.9.0
