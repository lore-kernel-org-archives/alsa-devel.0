From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: ymfpci: Use common error handling
 code in snd_ymfpci_create()
Date: Wed, 6 Sep 2017 21:48:11 +0200
Message-ID: <f2b7317e-b45d-a817-a307-d0208af65f56@users.sourceforge.net>
References: <dafe6d86-1bfd-41a8-e189-bde7ae30dea9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by alsa0.perex.cz (Postfix) with ESMTP id D698F266A8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 21:48:20 +0200 (CEST)
In-Reply-To: <dafe6d86-1bfd-41a8-e189-bde7ae30dea9@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 6 Sep 2017 21:12:51 +0200

* Add a jump target so that a bit of exception handling can be better
  reused at the end of this function.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix a few source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ymfpci/ymfpci_main.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index edfd58248082..8ca2e41e5827 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -2399,59 +2399,60 @@ int snd_ymfpci_create(struct snd_card *card,
 		dev_err(chip->card->dev,
 			"unable to grab memory region 0x%lx-0x%lx\n",
 			chip->reg_area_phys, chip->reg_area_phys + 0x8000 - 1);
-		snd_ymfpci_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_chip;
 	}
 	if (request_irq(pci->irq, snd_ymfpci_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
 		dev_err(chip->card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_ymfpci_free(chip);
-		return -EBUSY;
+		err = -EBUSY;
+		goto free_chip;
 	}
 	chip->irq = pci->irq;
 
 	snd_ymfpci_aclink_reset(pci);
 	if (snd_ymfpci_codec_ready(chip, 0) < 0) {
-		snd_ymfpci_free(chip);
-		return -EIO;
+		err = -EIO;
+		goto free_chip;
 	}
 
 	err = snd_ymfpci_request_firmware(chip);
 	if (err < 0) {
 		dev_err(chip->card->dev, "firmware request failed: %d\n", err);
-		snd_ymfpci_free(chip);
-		return err;
+		goto free_chip;
 	}
 	snd_ymfpci_download_image(chip);
 
 	udelay(100); /* seems we need a delay after downloading image.. */
 
 	if (snd_ymfpci_memalloc(chip) < 0) {
-		snd_ymfpci_free(chip);
-		return -EIO;
+		err = -EIO;
+		goto free_chip;
 	}
 
-	if ((err = snd_ymfpci_ac3_init(chip)) < 0) {
-		snd_ymfpci_free(chip);
-		return err;
-	}
+	err = snd_ymfpci_ac3_init(chip);
+	if (err < 0)
+		goto free_chip;
 
 #ifdef CONFIG_PM_SLEEP
 	chip->saved_regs = kmalloc(YDSXGR_NUM_SAVED_REGS * sizeof(u32),
 				   GFP_KERNEL);
 	if (chip->saved_regs == NULL) {
-		snd_ymfpci_free(chip);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto free_chip;
 	}
 #endif
 
-	if ((err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops)) < 0) {
-		snd_ymfpci_free(chip);
-		return err;
-	}
+	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
+	if (err < 0)
+		goto free_chip;
 
 	snd_ymfpci_proc_init(card, chip);
 
 	*rchip = chip;
 	return 0;
+
+free_chip:
+	snd_ymfpci_free(chip);
+	return err;
 }
-- 
2.14.1
