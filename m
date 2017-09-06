From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/3] ALSA: ymfpci: Use common error handling
 code in snd_card_ymfpci_probe()
Date: Wed, 6 Sep 2017 21:46:52 +0200
Message-ID: <c3b3d66c-1fb1-8bb9-cf00-674fd4e20afb@users.sourceforge.net>
References: <dafe6d86-1bfd-41a8-e189-bde7ae30dea9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC4D266A8A
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 21:47:05 +0200 (CEST)
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
Date: Wed, 6 Sep 2017 20:45:11 +0200

* Add a jump target so that a bit of exception handling can be better
  reused at the end of this function.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix a few source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/ymfpci/ymfpci.c | 62 +++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index 4faf3e1ed06a..eafdee384059 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -268,10 +268,9 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 	if ((err = snd_ymfpci_create(card, pci,
 				     old_legacy_ctrl,
 			 	     &chip)) < 0) {
-		snd_card_free(card);
 		release_and_free_resource(mpu_res);
 		release_and_free_resource(fm_res);
-		return err;
+		goto free_card;
 	}
 	chip->fm_res = fm_res;
 	chip->mpu_res = mpu_res;
@@ -283,35 +282,31 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 		card->shortname,
 		chip->reg_area_phys,
 		chip->irq);
-	if ((err = snd_ymfpci_pcm(chip, 0)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
-	if ((err = snd_ymfpci_pcm_spdif(chip, 1)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_ymfpci_pcm(chip, 0);
+	if (err < 0)
+		goto free_card;
+
+	err = snd_ymfpci_pcm_spdif(chip, 1);
+	if (err < 0)
+		goto free_card;
+
 	err = snd_ymfpci_mixer(chip, rear_switch[dev]);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	if (chip->ac97->ext_id & AC97_EI_SDAC) {
 		err = snd_ymfpci_pcm_4ch(chip, 2);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
+		if (err < 0)
+			goto free_card;
+
 		err = snd_ymfpci_pcm2(chip, 3);
-		if (err < 0) {
-			snd_card_free(card);
-			return err;
-		}
-	}
-	if ((err = snd_ymfpci_timer(chip, 0)) < 0) {
-		snd_card_free(card);
-		return err;
+		if (err < 0)
+			goto free_card;
 	}
+	err = snd_ymfpci_timer(chip, 0);
+	if (err < 0)
+		goto free_card;
+
 	if (chip->mpu_res) {
 		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_YMFPCI,
 					       mpu_port[dev],
@@ -336,21 +331,24 @@ static int snd_card_ymfpci_probe(struct pci_dev *pci,
 			legacy_ctrl &= ~YMFPCI_LEGACY_FMEN;
 			pci_write_config_word(pci, PCIR_DSXG_LEGACY, legacy_ctrl);
 		} else if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-			snd_card_free(card);
 			dev_err(card->dev, "cannot create opl3 hwdep\n");
-			return err;
+			goto free_card;
 		}
 	}
 
 	snd_ymfpci_create_gameport(chip, dev, legacy_ctrl, legacy_ctrl2);
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto free_card;
+
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_card_ymfpci_remove(struct pci_dev *pci)
-- 
2.14.1
