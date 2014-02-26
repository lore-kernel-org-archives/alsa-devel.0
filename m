From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 32/48] ALSA: emu10k1x: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:34 +0100
Message-ID: <1393430030-26704-33-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 507CA2657D5
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E709675042
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
 sound/pci/emu10k1/emu10k1x.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 3988eaa778cf..efe017526977 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -369,7 +369,8 @@ static void snd_emu10k1x_pcm_interrupt(struct emu10k1x *emu, struct emu10k1x_voi
 	if (epcm->substream == NULL)
 		return;
 #if 0
-	snd_printk(KERN_INFO "IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
+	dev_info(emu->card->dev,
+		 "IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
 		   epcm->substream->ops->pointer(epcm->substream),
 		   snd_pcm_lib_period_bytes(epcm->substream),
 		   snd_pcm_lib_buffer_bytes(epcm->substream));
@@ -487,7 +488,11 @@ static int snd_emu10k1x_pcm_trigger(struct snd_pcm_substream *substream,
 	int channel = epcm->voice->number;
 	int result = 0;
 
-//	snd_printk(KERN_INFO "trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n", (int)emu, cmd, (int)substream->ops->pointer(substream));
+	/*
+	dev_dbg(emu->card->dev,
+		"trigger - emu10k1x = 0x%x, cmd = %i, pointer = %d\n",
+		(int)emu, cmd, (int)substream->ops->pointer(substream));
+	*/
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -826,7 +831,7 @@ static irqreturn_t snd_emu10k1x_interrupt(int irq, void *dev_id)
 	// acknowledge the interrupt if necessary
 	outl(status, chip->port + IPR);
 
-	// snd_printk(KERN_INFO "interrupt %08x\n", status);
+	/* dev_dbg(chip->card->dev, "interrupt %08x\n", status); */
 	return IRQ_HANDLED;
 }
 
@@ -919,7 +924,7 @@ static int snd_emu10k1x_create(struct snd_card *card,
 		return err;
 	if (pci_set_dma_mask(pci, DMA_BIT_MASK(28)) < 0 ||
 	    pci_set_consistent_dma_mask(pci, DMA_BIT_MASK(28)) < 0) {
-		snd_printk(KERN_ERR "error to set 28bit mask DMA\n");
+		dev_err(card->dev, "error to set 28bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
@@ -940,14 +945,15 @@ static int snd_emu10k1x_create(struct snd_card *card,
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 8,
 					     "EMU10K1X")) == NULL) { 
-		snd_printk(KERN_ERR "emu10k1x: cannot allocate the port 0x%lx\n", chip->port);
+		dev_err(card->dev, "cannot allocate the port 0x%lx\n",
+			chip->port);
 		snd_emu10k1x_free(chip);
 		return -EBUSY;
 	}
 
 	if (request_irq(pci->irq, snd_emu10k1x_interrupt,
 			IRQF_SHARED, KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "emu10k1x: cannot grab irq %d\n", pci->irq);
+		dev_err(card->dev, "cannot grab irq %d\n", pci->irq);
 		snd_emu10k1x_free(chip);
 		return -EBUSY;
 	}
@@ -964,7 +970,7 @@ static int snd_emu10k1x_create(struct snd_card *card,
 	chip->revision = pci->revision;
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
-	snd_printk(KERN_INFO "Model %04x Rev %08x Serial %08x\n", chip->model,
+	dev_info(card->dev, "Model %04x Rev %08x Serial %08x\n", chip->model,
 		   chip->revision, chip->serial);
 
 	outl(0, chip->port + INTE);	
@@ -1248,7 +1254,9 @@ static void mpu401_clear_rx(struct emu10k1x *emu, struct emu10k1x_midi *mpu)
 		mpu401_read_data(emu, mpu);
 #ifdef CONFIG_SND_DEBUG
 	if (timeout <= 0)
-		snd_printk(KERN_ERR "cmd: clear rx timeout (status = 0x%x)\n", mpu401_read_stat(emu, mpu));
+		dev_err(emu->card->dev,
+			"cmd: clear rx timeout (status = 0x%x)\n",
+			mpu401_read_stat(emu, mpu));
 #endif
 }
 
@@ -1322,7 +1330,8 @@ static int snd_emu10k1x_midi_cmd(struct emu10k1x * emu,
 	}
 	spin_unlock_irqrestore(&midi->input_lock, flags);
 	if (!ok) {
-		snd_printk(KERN_ERR "midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
+		dev_err(emu->card->dev,
+			"midi_cmd: 0x%x failed at 0x%lx (status = 0x%x, data = 0x%x)!!!\n",
 			   cmd, emu->port,
 			   mpu401_read_stat(emu, midi),
 			   mpu401_read_data(emu, midi));
-- 
1.9.0
