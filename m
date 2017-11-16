From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] ALSA: nm256: Adjust five function calls
 together with a variable assignment
Date: Thu, 16 Nov 2017 18:07:27 +0100
Message-ID: <60be8c64-bbd1-51b7-4ada-60a2f926bf91@users.sourceforge.net>
References: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 83BAA266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:08:05 +0100 (CET)
In-Reply-To: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 16 Nov 2017 17:37:26 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/nm256/nm256.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index b97f4ea6b56c..35ce5b3fd81a 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1334,7 +1334,8 @@ snd_nm256_mixer(struct nm256 *chip)
 	if (! chip->ac97_regs)
 		return -ENOMEM;
 
-	if ((err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus)) < 0)
+	err = snd_ac97_bus(chip->card, 0, &ops, NULL, &pbus);
+	if (err < 0)
 		return err;
 
 	memset(&ac97, 0, sizeof(ac97));
@@ -1493,7 +1494,8 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 
 	*chip_ret = NULL;
 
-	if ((err = pci_enable_device(pci)) < 0)
+	err = pci_enable_device(pci);
+	if (err < 0)
 		return err;
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
@@ -1585,7 +1587,8 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 		chip->buffer_end = buffer_top;
 	else {
 		/* get buffer end pointer from signature */
-		if ((err = snd_nm256_peek_for_sig(chip)) < 0)
+		err = snd_nm256_peek_for_sig(chip);
+		if (err < 0)
 			goto __error;
 	}
 
@@ -1635,7 +1638,8 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci,
 
 	// pci_set_master(pci); /* needed? */
 	
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0)
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
 		goto __error;
 
 	*chip_ret = chip;
@@ -1717,7 +1721,9 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		capture_bufsize = 4;
 	if (capture_bufsize > 128)
 		capture_bufsize = 128;
-	if ((err = snd_nm256_create(card, pci, &chip)) < 0) {
+
+	err = snd_nm256_create(card, pci, &chip);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
@@ -1744,7 +1750,8 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		card->shortname,
 		chip->buffer_addr, chip->cport_addr, chip->irq);
 
-	if ((err = snd_card_register(card)) < 0) {
+	err = snd_card_register(card);
+	if (err < 0) {
 		snd_card_free(card);
 		return err;
 	}
-- 
2.15.0
