From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH] azx_probe() cleanup
Date: Thu, 20 Nov 2008 09:24:52 +0800
Message-ID: <20081120012452.GA26665@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga101.ch.intel.com (mga07.intel.com [143.182.124.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 873032438D
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 02:25:04 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Replace 5 free-and-return-err blocks with goto-out-free ones.
This makes the main logic more outstanding.

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/hda_intel.c |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

--- sound-2.6.orig/sound/pci/hda/hda_intel.c
+++ sound-2.6/sound/pci/hda/hda_intel.c
@@ -2317,40 +2317,30 @@ static int __devinit azx_probe(struct pc
 	}
 
 	err = azx_create(card, pci, dev, pci_id->driver_data, &chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto out_free;
 	card->private_data = chip;
 
 	/* create codec instances */
 	err = azx_codec_create(chip, model[dev], probe_mask[dev]);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto out_free;
 
 	/* create PCM streams */
 	err = snd_hda_build_pcms(chip->bus);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto out_free;
 
 	/* create mixer controls */
 	err = azx_mixer_create(chip);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto out_free;
 
 	snd_card_set_dev(card, &pci->dev);
 
 	err = snd_card_register(card);
-	if (err < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	if (err < 0)
+		goto out_free;
 
 	pci_set_drvdata(pci, card);
 	chip->running = 1;
@@ -2359,6 +2349,9 @@ static int __devinit azx_probe(struct pc
 
 	dev++;
 	return err;
+out_free:
+	snd_card_free(card);
+	return err;
 }
 
 static void __devexit azx_remove(struct pci_dev *pci)
