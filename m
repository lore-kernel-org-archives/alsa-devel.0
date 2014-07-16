From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add NULL check to all PM ops in
	hda_intel.c
Date: Wed, 16 Jul 2014 16:33:26 +0200
Message-ID: <1405521206-12486-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C9E02651B9
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 16:33:27 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id EC1BEAB5D
 for <alsa-devel@alsa-project.org>; Wed, 16 Jul 2014 14:33:26 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Since devptr can be NULL due to asynchronous probe, all PM ops should
have NULL checks at the beginning.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 45 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8edcee5f034d..387fc73a5c89 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -772,10 +772,15 @@ static int azx_suspend(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	struct azx *chip;
+	struct hda_intel *hda;
 	struct azx_pcm *p;
 
+	if (!card)
+		return 0;
+
+	chip = card->private_data;
+	hda = container_of(chip, struct hda_intel, chip);
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
@@ -806,9 +811,14 @@ static int azx_resume(struct device *dev)
 {
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	struct azx *chip;
+	struct hda_intel *hda;
 
+	if (!card)
+		return 0;
+
+	chip = card->private_data;
+	hda = container_of(chip, struct hda_intel, chip);
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
@@ -844,9 +854,14 @@ static int azx_resume(struct device *dev)
 static int azx_runtime_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	struct azx *chip;
+	struct hda_intel *hda;
 
+	if (!card)
+		return 0;
+
+	chip = card->private_data;
+	hda = container_of(chip, struct hda_intel, chip);
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
@@ -869,12 +884,17 @@ static int azx_runtime_suspend(struct device *dev)
 static int azx_runtime_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	struct azx *chip;
+	struct hda_intel *hda;
 	struct hda_bus *bus;
 	struct hda_codec *codec;
 	int status;
 
+	if (!card)
+		return 0;
+
+	chip = card->private_data;
+	hda = container_of(chip, struct hda_intel, chip);
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
@@ -910,9 +930,14 @@ static int azx_runtime_resume(struct device *dev)
 static int azx_runtime_idle(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
-	struct azx *chip = card->private_data;
-	struct hda_intel *hda = container_of(chip, struct hda_intel, chip);
+	struct azx *chip;
+	struct hda_intel *hda;
+
+	if (!card)
+		return 0;
 
+	chip = card->private_data;
+	hda = container_of(chip, struct hda_intel, chip);
 	if (chip->disabled || hda->init_failed)
 		return 0;
 
-- 
2.0.1
