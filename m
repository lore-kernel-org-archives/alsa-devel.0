From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/3] ALSA: es1938: Use common error handling
 code in snd_es1938_probe()
Date: Tue, 14 Nov 2017 21:37:30 +0100
Message-ID: <b14bbbef-d134-1a1e-476b-d751c3db2071@users.sourceforge.net>
References: <afd9d456-ae8e-b2f6-a682-a27c1fa4209b@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 470002674D7
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 21:38:07 +0100 (CET)
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
Date: Tue, 14 Nov 2017 21:06:05 +0100

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/es1938.c | 48 ++++++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 83d652bdef51..b19e611345d1 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -1810,16 +1810,15 @@ static int snd_es1938_probe(struct pci_dev *pci,
 	for (idx = 0; idx < 5; idx++) {
 		if (pci_resource_start(pci, idx) == 0 ||
 		    !(pci_resource_flags(pci, idx) & IORESOURCE_IO)) {
-		    	snd_card_free(card);
-		    	return -ENODEV;
+			err = -ENODEV;
+			goto free_card;
 		}
 	}
 
 	err = snd_es1938_create(card, pci, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	strcpy(card->driver, "ES1938");
@@ -1830,15 +1829,13 @@ static int snd_es1938_probe(struct pci_dev *pci,
 		chip->irq);
 
 	err = snd_es1938_new_pcm(chip, 0);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	err = snd_es1938_mixer(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	if (snd_opl3_create(card,
 			    SLSB_REG(chip, FMLOWADDR),
 			    SLSB_REG(chip, FMHIGHADDR),
@@ -1847,15 +1844,12 @@ static int snd_es1938_probe(struct pci_dev *pci,
 			   SLSB_REG(chip, FMLOWADDR));
 	} else {
 		err = snd_opl3_timer_new(opl3, 0, 1);
-		if (err < 0) {
-	                snd_card_free(card);
-	                return err;
-		}
+		if (err < 0)
+			goto free_card;
+
 		err = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
-		if (err < 0) {
-	                snd_card_free(card);
-	                return err;
-		}
+		if (err < 0)
+			goto free_card;
 	}
 	if (snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
 				chip->mpu_port,
@@ -1871,14 +1865,16 @@ static int snd_es1938_probe(struct pci_dev *pci,
 	snd_es1938_create_gameport(chip);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	pci_set_drvdata(pci, card);
 	dev++;
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_es1938_remove(struct pci_dev *pci)
-- 
2.15.0
