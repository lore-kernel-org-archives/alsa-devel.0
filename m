From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: intel8x0: Adjust 15 function calls
 together with a variable assignment
Date: Wed, 15 Nov 2017 20:49:29 +0100
Message-ID: <260ad3a3-ace2-b82f-4716-2fd96ba188b5@users.sourceforge.net>
References: <981b2716-2828-6478-46b3-5f8f3c36db46@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF46267064
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 20:49:41 +0100 (CET)
In-Reply-To: <981b2716-2828-6478-46b3-5f8f3c36db46@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Laura Abbott <labbott@redhat.com>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 20:00:12 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/intel8x0.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 4c24346340f4..2d7e0fb163f9 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -581,7 +581,8 @@ static unsigned short snd_intel8x0_codec_read(struct snd_ac97 *ac97,
 		res = 0xffff;
 	} else {
 		res = iagetword(chip, reg + ac97->num * 0x80);
-		if ((tmp = igetdword(chip, ICHREG(GLOB_STA))) & ICH_RCS) {
+		tmp = igetdword(chip, ICHREG(GLOB_STA));
+		if (tmp & ICH_RCS) {
 			/* reset RCS and preserve other R/WC bits */
 			iputdword(chip, ICHREG(GLOB_STA), tmp &
 				  ~(chip->codec_ready_bits | ICH_GSCI));
@@ -602,7 +603,8 @@ static void snd_intel8x0_codec_read_test(struct intel8x0 *chip,
 
 	if (snd_intel8x0_codec_semaphore(chip, codec) >= 0) {
 		iagetword(chip, codec * 0x80);
-		if ((tmp = igetdword(chip, ICHREG(GLOB_STA))) & ICH_RCS) {
+		tmp = igetdword(chip, ICHREG(GLOB_STA));
+		if (tmp & ICH_RCS) {
 			/* reset RCS and preserve other R/WC bits */
 			iputdword(chip, ICHREG(GLOB_STA), tmp &
 				  ~(chip->codec_ready_bits | ICH_GSCI));
@@ -1180,7 +1182,10 @@ static int snd_intel8x0_pcm_open(struct snd_pcm_substream *substream, struct ich
 		runtime->hw.buffer_bytes_max = 64*1024;
 		runtime->hw.period_bytes_max = 64*1024;
 	}
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+
+	err = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
 		return err;
 	runtime->private_data = ichdev;
 	return 0;
@@ -2274,7 +2279,9 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 			udelay(1);
 		}
 	}
-	if ((err = snd_ac97_bus(chip->card, 0, ops, chip, &pbus)) < 0)
+
+	err = snd_ac97_bus(chip->card, 0, ops, chip, &pbus);
+	if (err < 0)
 		goto __err;
 	pbus->private_free = snd_intel8x0_mixer_free_ac97_bus;
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
@@ -2290,7 +2297,8 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
 	ac97.pci = chip->pci;
 	for (i = 0; i < codecs; i++) {
 		ac97.num = i;
-		if ((err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i])) < 0) {
+		err = snd_ac97_mixer(pbus, &ac97, &chip->ac97[i]);
+		if (err < 0) {
 			if (err != -EACCES)
 				dev_err(chip->card->dev,
 					"Unable to initialize codec #%d\n", i);
@@ -2575,11 +2583,13 @@ static int snd_intel8x0_chip_init(struct intel8x0 *chip, int probing)
 	int err;
 	
 	if (chip->device_type != DEVICE_ALI) {
-		if ((err = snd_intel8x0_ich_chip_init(chip, probing)) < 0)
+		err = snd_intel8x0_ich_chip_init(chip, probing);
+		if (err < 0)
 			return err;
 		iagetword(chip, 0);	/* clear semaphore flag */
 	} else {
-		if ((err = snd_intel8x0_ali_chip_init(chip, probing)) < 0)
+		err = snd_intel8x0_ali_chip_init(chip, probing);
+		if (err < 0)
 			return err;
 	}
 
@@ -3035,7 +3045,8 @@ static int snd_intel8x0_create(struct snd_card *card,
 
 	*r_intel8x0 = NULL;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -3061,7 +3072,8 @@ static int snd_intel8x0_create(struct snd_card *card,
 	    pci->device == PCI_DEVICE_ID_INTEL_440MX)
 		chip->fix_nocache = 1; /* enable workaround */
 
-	if ((err = pci_request_regions(pci, card->shortname)) < 0) {
+	err = pci_request_regions(pci, card->shortname);
+	if (err < 0) {
 		kfree(chip);
 		pci_disable_device(pci);
 		return err;
@@ -3178,7 +3190,8 @@ static int snd_intel8x0_create(struct snd_card *card,
 	for (i = 0; i < chip->max_codecs; i++)
 		chip->codec_isr_bits |= chip->codec_bit[i];
 
-	if ((err = snd_intel8x0_chip_init(chip, 1)) < 0) {
+	err = snd_intel8x0_chip_init(chip, 1);
+	if (err < 0) {
 		snd_intel8x0_free(chip);
 		return err;
 	}
@@ -3192,7 +3205,8 @@ static int snd_intel8x0_create(struct snd_card *card,
 	}
 	chip->irq = pci->irq;
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_intel8x0_free(chip);
 		return err;
 	}
@@ -3299,18 +3313,20 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 			buggy_irq = 0;
 	}
 
-	if ((err = snd_intel8x0_create(card, pci, pci_id->driver_data,
-				       &chip)) < 0) {
+	err = snd_intel8x0_create(card, pci, pci_id->driver_data, &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	card->private_data = chip;
 
-	if ((err = snd_intel8x0_mixer(chip, ac97_clock, ac97_quirk)) < 0) {
+	err = snd_intel8x0_mixer(chip, ac97_clock, ac97_quirk);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_intel8x0_pcm(chip)) < 0) {
+	err = snd_intel8x0_pcm(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -3330,7 +3346,8 @@ static int snd_intel8x0_probe(struct pci_dev *pci,
 		}
 	}
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
