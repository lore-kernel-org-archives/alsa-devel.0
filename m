From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: es1938: Adjust 14 function calls
 together with a variable assignment
Date: Tue, 14 Nov 2017 21:36:22 +0100
Message-ID: <7c1ad5fd-cf24-7c81-9ea7-4dfbe666bd33@users.sourceforge.net>
References: <afd9d456-ae8e-b2f6-a682-a27c1fa4209b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C453A2674D7
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 21:36:29 +0100 (CET)
In-Reply-To: <afd9d456-ae8e-b2f6-a682-a27c1fa4209b@users.sourceforge.net>
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
Date: Tue, 14 Nov 2017 21:00:32 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/es1938.c | 54 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 19 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 9d248eb2e26c..83d652bdef51 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -312,7 +312,8 @@ static void snd_es1938_write_cmd(struct es1938 *chip, unsigned char cmd)
 	int i;
 	unsigned char v;
 	for (i = 0; i < WRITE_LOOP_TIMEOUT; i++) {
-		if (!(v = inb(SLSB_REG(chip, READSTATUS)) & 0x80)) {
+		v = inb(SLSB_REG(chip, READSTATUS));
+		if (!(v & 0x80)) {
 			outb(cmd, SLSB_REG(chip, WRITEDATA));
 			return;
 		}
@@ -328,9 +329,13 @@ static int snd_es1938_get_byte(struct es1938 *chip)
 {
 	int i;
 	unsigned char v;
-	for (i = GET_LOOP_TIMEOUT; i; i--)
-		if ((v = inb(SLSB_REG(chip, STATUS))) & 0x80)
+
+	for (i = GET_LOOP_TIMEOUT; i; i--) {
+		v = inb(SLSB_REG(chip, STATUS));
+		if (v & 0x80)
 			return inb(SLSB_REG(chip, READDATA));
+	}
+
 	dev_err(chip->card->dev, "get_byte timeout: status 0x02%x\n", v);
 	return -ENODEV;
 }
@@ -885,11 +890,10 @@ static int snd_es1938_pcm_hw_params(struct snd_pcm_substream *substream,
 				    struct snd_pcm_hw_params *hw_params)
 
 {
-	int err;
+	int err = snd_pcm_lib_malloc_pages(substream,
+					   params_buffer_bytes(hw_params));
 
-	if ((err = snd_pcm_lib_malloc_pages(substream, params_buffer_bytes(hw_params))) < 0)
-		return err;
-	return 0;
+	return (err < 0) ? err : 0;
 }
 
 static int snd_es1938_pcm_hw_free(struct snd_pcm_substream *substream)
@@ -1035,9 +1039,9 @@ static const struct snd_pcm_ops snd_es1938_capture_ops = {
 static int snd_es1938_new_pcm(struct es1938 *chip, int device)
 {
 	struct snd_pcm *pcm;
-	int err;
+	int err = snd_pcm_new(chip->card, "es-1938-1946", device, 2, 1, &pcm);
 
-	if ((err = snd_pcm_new(chip->card, "es-1938-1946", device, 2, 1, &pcm)) < 0)
+	if (err < 0)
 		return err;
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &snd_es1938_playback_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &snd_es1938_capture_ops);
@@ -1594,7 +1598,8 @@ static int snd_es1938_create(struct snd_card *card,
 	*rchip = NULL;
 
 	/* enable PCI device */
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
         /* check, if we can restrict PCI DMA transfers to 24 bits */
 	if (dma_set_mask(&pci->dev, DMA_BIT_MASK(24)) < 0 ||
@@ -1615,7 +1620,8 @@ static int snd_es1938_create(struct snd_card *card,
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
-	if ((err = pci_request_regions(pci, "ESS Solo-1")) < 0) {
+	err = pci_request_regions(pci, "ESS Solo-1");
+	if (err < 0) {
 		kfree(chip);
 		pci_disable_device(pci);
 		return err;
@@ -1640,7 +1646,8 @@ static int snd_es1938_create(struct snd_card *card,
 
 	snd_es1938_chip_init(chip);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_es1938_free(chip);
 		return err;
 	}
@@ -1771,7 +1778,9 @@ static int snd_es1938_mixer(struct es1938 *chip)
 				kctl->private_free = snd_es1938_hwv_free;
 				break;
 			}
-		if ((err = snd_ctl_add(card, kctl)) < 0)
+
+		err = snd_ctl_add(card, kctl);
+		if (err < 0)
 			return err;
 	}
 	return 0;
@@ -1805,7 +1814,9 @@ static int snd_es1938_probe(struct pci_dev *pci,
 		    	return -ENODEV;
 		}
 	}
-	if ((err = snd_es1938_create(card, pci, &chip)) < 0) {
+
+	err = snd_es1938_create(card, pci, &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1818,11 +1829,13 @@ static int snd_es1938_probe(struct pci_dev *pci,
 		chip->revision,
 		chip->irq);
 
-	if ((err = snd_es1938_new_pcm(chip, 0)) < 0) {
+	err = snd_es1938_new_pcm(chip, 0);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_es1938_mixer(chip)) < 0) {
+	err = snd_es1938_mixer(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1833,11 +1846,13 @@ static int snd_es1938_probe(struct pci_dev *pci,
 		dev_err(card->dev, "OPL3 not detected at 0x%lx\n",
 			   SLSB_REG(chip, FMLOWADDR));
 	} else {
-	        if ((err = snd_opl3_timer_new(opl3, 0, 1)) < 0) {
+		err = snd_opl3_timer_new(opl3, 0, 1);
+		if (err < 0) {
 	                snd_card_free(card);
 	                return err;
 		}
-	        if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
+		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (err < 0) {
 	                snd_card_free(card);
 	                return err;
 		}
@@ -1855,7 +1870,8 @@ static int snd_es1938_probe(struct pci_dev *pci,
 
 	snd_es1938_create_gameport(chip);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
