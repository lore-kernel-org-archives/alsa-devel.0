From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/4] ALSA: riptide: Adjust 13 function calls
 together with a variable assignment
Date: Fri, 17 Nov 2017 10:47:38 +0100
Message-ID: <4dcb7c19-6683-7955-e9d7-e9989c9873e6@users.sourceforge.net>
References: <0eef2699-f28a-c1e0-9351-268b5eb7e0c1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 91AF6266B67
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 10:48:20 +0100 (CET)
In-Reply-To: <0eef2699-f28a-c1e0-9351-268b5eb7e0c1@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 17 Nov 2017 09:43:55 +0100

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix affected source code places.

* Replace the specification of two data structures by pointer dereferences
  as the parameter for the operator "sizeof" to make the corresponding size
  determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/riptide/riptide.c | 53 ++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 44f3b48d47b1..22d15ea7e210 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1564,10 +1564,12 @@ snd_riptide_hw_params(struct snd_pcm_substream *substream,
 		    (int)sgdlist->bytes);
 	if (sgdlist->area)
 		snd_dma_free_pages(sgdlist);
-	if ((err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
-				       snd_dma_pci_data(chip->pci),
-				       sizeof(struct sgd) * (DESC_MAX_MASK + 1),
-				       sgdlist)) < 0) {
+
+	err = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
+				  snd_dma_pci_data(chip->pci),
+				  sizeof(struct sgd) * (DESC_MAX_MASK + 1),
+				  sgdlist);
+	if (err < 0) {
 		snd_printk(KERN_ERR "Riptide: failed to alloc %d dma bytes\n",
 			   (int)sizeof(struct sgd) * (DESC_MAX_MASK + 1));
 		return err;
@@ -1695,11 +1697,10 @@ static const struct snd_pcm_ops snd_riptide_capture_ops = {
 static int snd_riptide_pcm(struct snd_riptide *chip, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "RIPTIDE", device,
+			      PLAYBACK_SUBSTREAMS, 1, &pcm);
 
-	if ((err =
-	     snd_pcm_new(chip->card, "RIPTIDE", device, PLAYBACK_SUBSTREAMS, 1,
-			 &pcm)) < 0)
+	if (err < 0)
 		return err;
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK,
 			&snd_riptide_playback_ops);
@@ -1786,14 +1787,16 @@ static int snd_riptide_initialize(struct snd_riptide *chip)
 
 	cif = chip->cif;
 	if (!cif) {
-		if ((cif = kzalloc(sizeof(struct cmdif), GFP_KERNEL)) == NULL)
+		cif = kzalloc(sizeof(*cif), GFP_KERNEL);
+		if (!cif)
 			return -ENOMEM;
 		cif->hwport = (struct riptideport *)chip->port;
 		spin_lock_init(&cif->lock);
 		chip->cif = cif;
 	}
 	cif->is_reset = 0;
-	if ((err = riptide_reset(cif, chip)) != 0)
+	err = riptide_reset(cif, chip);
+	if (err)
 		return err;
 	device_id = chip->device_id;
 	switch (device_id) {
@@ -1817,7 +1820,8 @@ static int snd_riptide_free(struct snd_riptide *chip)
 	if (!chip)
 		return 0;
 
-	if ((cif = chip->cif)) {
+	cif = chip->cif;
+	if (cif) {
 		SET_GRESET(cif->hwport);
 		udelay(100);
 		UNSET_GRESET(cif->hwport);
@@ -1850,9 +1854,12 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 	};
 
 	*rchip = NULL;
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
-	if (!(chip = kzalloc(sizeof(struct snd_riptide), GFP_KERNEL)))
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
 		return -ENOMEM;
 
 	spin_lock_init(&chip->lock);
@@ -1866,8 +1873,8 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 	chip->cif = NULL;
 	tasklet_init(&chip->riptide_tq, riptide_handleirq, (unsigned long)chip);
 
-	if ((chip->res_port =
-	     request_region(chip->port, 64, "RIPTIDE")) == NULL) {
+	chip->res_port = request_region(chip->port, 64, "RIPTIDE");
+	if (!chip->res_port) {
 		snd_printk(KERN_ERR
 			   "Riptide: unable to grab region 0x%lx-0x%lx\n",
 			   chip->port, chip->port + 64 - 1);
@@ -1887,12 +1894,14 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 	chip->irq = pci->irq;
 	chip->device_id = pci->device;
 	pci_set_master(pci);
-	if ((err = snd_riptide_initialize(chip)) < 0) {
+	err = snd_riptide_initialize(chip);
+	if (err < 0) {
 		snd_riptide_free(chip);
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_riptide_free(chip);
 		return err;
 	}
@@ -1922,7 +1931,9 @@ snd_riptide_proc_read(struct snd_info_entry *entry,
 	for (i = 0; i < 64; i += 4)
 		snd_iprintf(buffer, "%c%02x: %08x",
 			    (i % 16) ? ' ' : '\n', i, inl(chip->port + i));
-	if ((cif = chip->cif)) {
+
+	cif = chip->cif;
+	if (cif) {
 		snd_iprintf(buffer,
 			    "\nVersion: ASIC: %d CODEC: %d AUXDSP: %d PROG: %d",
 			    chip->firmware.firmware.ASIC,
@@ -1994,12 +2005,14 @@ static int snd_riptide_mixer(struct snd_riptide *chip)
 	ac97.private_data = chip;
 	ac97.scaps = AC97_SCAP_SKIP_MODEM;
 
-	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus)) < 0)
+	err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus);
+	if (err < 0)
 		return err;
 
 	chip->ac97_bus = pbus;
 	ac97.pci = chip->pci;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97)) < 0)
+	err = snd_ac97_mixer(pbus, &ac97, &chip->ac97);
+	if (err < 0)
 		return err;
 	return err;
 }
-- 
2.15.0
