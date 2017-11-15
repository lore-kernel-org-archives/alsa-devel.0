From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: intel8x0m: Adjust 12 function calls
 together with a variable assignment
Date: Wed, 15 Nov 2017 22:05:13 +0100
Message-ID: <4b5be7ac-8c5b-0b3d-ee9f-ae749cca4ddf@users.sourceforge.net>
References: <fb982b27-f9b8-959b-9bb6-17f217aa3220@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id ED565267587
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 22:05:51 +0100 (CET)
In-Reply-To: <fb982b27-f9b8-959b-9bb6-17f217aa3220@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bhumika Goyal <bhumirks@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 15 Nov 2017 21:34:23 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/intel8x0m.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 3a4769a97d29..ab798533a6bc 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -372,7 +372,8 @@ static unsigned short snd_intel8x0m_codec_read(struct snd_ac97 *ac97,
 		res = 0xffff;
 	} else {
 		res = iagetword(chip, reg + ac97->num * 0x80);
-		if ((tmp = igetdword(chip, ICHREG(GLOB_STA))) & ICH_RCS) {
+		tmp = igetdword(chip, ICHREG(GLOB_STA));
+		if (tmp & ICH_RCS) {
 			/* reset RCS and preserve other R/WC bits */
 			iputdword(chip, ICHREG(GLOB_STA),
 				  tmp & ~(ICH_SRI|ICH_PRI|ICH_TRI|ICH_GSCI));
@@ -847,7 +848,8 @@ static int snd_intel8x0m_mixer(struct intel8x0m *chip, int ac97_clock)
 
 	glob_sta = igetdword(chip, ICHREG(GLOB_STA));
 
-	if ((err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus)) < 0)
+	err = snd_ac97_bus(chip->card, 0, &ops, chip, &pbus);
+	if (err < 0)
 		goto __err;
 	pbus->private_free = snd_intel8x0m_mixer_free_ac97_bus;
 	if (ac97_clock >= 8000 && ac97_clock <= 48000)
@@ -856,7 +858,8 @@ static int snd_intel8x0m_mixer(struct intel8x0m *chip, int ac97_clock)
 
 	ac97.pci = chip->pci;
 	ac97.num = glob_sta & ICH_SCR ? 1 : 0;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &x97)) < 0) {
+	err = snd_ac97_mixer(pbus, &ac97, &x97);
+	if (err < 0) {
 		dev_err(chip->card->dev,
 			"Unable to initialize codec #%d\n", ac97.num);
 		if (ac97.num == 0)
@@ -974,7 +977,8 @@ static int snd_intel8x0m_chip_init(struct intel8x0m *chip, int probing)
 	unsigned int i;
 	int err;
 	
-	if ((err = snd_intel8x0m_ich_chip_init(chip, probing)) < 0)
+	err = snd_intel8x0m_ich_chip_init(chip, probing);
+	if (err < 0)
 		return err;
 	iagetword(chip, 0);	/* clear semaphore flag */
 
@@ -1125,7 +1129,8 @@ static int snd_intel8x0m_create(struct snd_card *card,
 
 	*r_intel8x0m = NULL;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -1139,7 +1144,8 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	chip->pci = pci;
 	chip->irq = -1;
 
-	if ((err = pci_request_regions(pci, card->shortname)) < 0) {
+	err = pci_request_regions(pci, card->shortname);
+	if (err < 0) {
 		kfree(chip);
 		pci_disable_device(pci);
 		return err;
@@ -1224,12 +1230,14 @@ static int snd_intel8x0m_create(struct snd_card *card,
 	chip->int_sta_reg = ICH_REG_GLOB_STA;
 	chip->int_sta_mask = int_sta_masks;
 
-	if ((err = snd_intel8x0m_chip_init(chip, 1)) < 0) {
+	err = snd_intel8x0m_chip_init(chip, 1);
+	if (err < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
 	}
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0) {
 		snd_intel8x0m_free(chip);
 		return err;
 	}
@@ -1286,17 +1294,20 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	}
 	strcat(card->shortname," Modem");
 
-	if ((err = snd_intel8x0m_create(card, pci, pci_id->driver_data, &chip)) < 0) {
+	err = snd_intel8x0m_create(card, pci, pci_id->driver_data, &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
 	card->private_data = chip;
 
-	if ((err = snd_intel8x0m_mixer(chip, ac97_clock)) < 0) {
+	err = snd_intel8x0m_mixer(chip, ac97_clock);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-	if ((err = snd_intel8x0m_pcm(chip)) < 0) {
+	err = snd_intel8x0m_pcm(chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1306,7 +1317,8 @@ static int snd_intel8x0m_probe(struct pci_dev *pci,
 	sprintf(card->longname, "%s at irq %i",
 		card->shortname, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
