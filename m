From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] ALSA: nm256: Use common error handling
 code in snd_nm256_probe()
Date: Thu, 16 Nov 2017 18:08:26 +0100
Message-ID: <5e96250a-b436-4b33-0ffa-3f9a51346827@users.sourceforge.net>
References: <d98a2685-ddf9-1cba-839a-d12c5ff8d3ba@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C149266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:08:32 +0100 (CET)
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
Date: Thu, 16 Nov 2017 17:51:17 +0100

This issue was detected by using the Coccinelle software.

* Add a jump target so that a bit of exception handling can be better
  reused at the end of this function.

  This issue was detected by using the Coccinelle software.

* The script "checkpatch.pl" pointed information out like the following.

  ERROR: do not use assignment in if condition

  Thus fix two affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/nm256/nm256.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 35ce5b3fd81a..3d6106800ae9 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1706,8 +1706,8 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		break;
 	default:
 		dev_err(&pci->dev, "invalid device id 0x%x\n", pci->device);
-		snd_card_free(card);
-		return -EINVAL;
+		err = -EINVAL;
+		goto free_card;
 	}
 
 	if (vaio_hack)
@@ -1723,10 +1723,9 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		capture_bufsize = 128;
 
 	err = snd_nm256_create(card, pci, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
+
 	card->private_data = chip;
 
 	if (reset_workaround) {
@@ -1739,11 +1738,13 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		chip->reset_workaround_2 = 1;
 	}
 
-	if ((err = snd_nm256_pcm(chip, 0)) < 0 ||
-	    (err = snd_nm256_mixer(chip)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_nm256_pcm(chip, 0);
+	if (err < 0)
+		goto free_card;
+
+	err = snd_nm256_mixer(chip);
+	if (err < 0)
+		goto free_card;
 
 	sprintf(card->shortname, "NeoMagic %s", card->driver);
 	sprintf(card->longname, "%s at 0x%lx & 0x%lx, irq %d",
@@ -1751,13 +1752,15 @@ static int snd_nm256_probe(struct pci_dev *pci,
 		chip->buffer_addr, chip->cport_addr, chip->irq);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto free_card;
 
 	pci_set_drvdata(pci, card);
 	return 0;
+
+free_card:
+	snd_card_free(card);
+	return err;
 }
 
 static void snd_nm256_remove(struct pci_dev *pci)
-- 
2.15.0
