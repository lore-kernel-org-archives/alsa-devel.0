From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] sound: hda_intel: add card number to irq
	description
Date: Mon, 21 Dec 2015 21:50:25 +0100
Message-ID: <56786611.9010203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id BD605260601
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 21:50:32 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id l126so85142803wml.0
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 12:50:32 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently the info in /proc/interrupts doesn't allow to figure out which
interrupt belongs to which card (HDMI, PCH, ..).
Therefore add card details to the interrupt description.
With the patch the info in /proc/interrupts looks like this:

PCI-MSI 442368-edge      snd_hda_intel:card1
PCI-MSI 49152-edge      snd_hda_intel:card0

This could be partially reused for the hda_tegra driver as it also
uses struct azx.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 sound/pci/hda/hda_controller.h | 2 ++
 sound/pci/hda/hda_intel.c      | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index ec63bbf..9c6344f 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -125,6 +125,8 @@ struct azx {
 	int num_streams;
 	const int *jackpoll_ms; /* per-card jack poll interval */
 
+	char irq_descr[32]; /* Interrupt description */
+
 	/* Register interaction. */
 	const struct hda_controller_ops *ops;
 
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 83800ac..ef4e06b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -725,7 +725,7 @@ static int azx_acquire_irq(struct azx *chip, int do_disconnect)
 
 	if (request_irq(chip->pci->irq, azx_interrupt,
 			chip->msi ? 0 : IRQF_SHARED,
-			KBUILD_MODNAME, chip)) {
+			chip->irq_descr, chip)) {
 		dev_err(chip->card->dev,
 			"unable to grab IRQ %d, disabling device\n",
 			chip->pci->irq);
@@ -1605,6 +1605,8 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	check_msi(chip);
 	chip->dev_index = dev;
 	chip->jackpoll_ms = jackpoll_ms;
+	snprintf(chip->irq_descr, sizeof(chip->irq_descr), "%s:%s",
+		 KBUILD_MODNAME, dev_name(&card->card_dev));
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_WORK(&hda->irq_pending_work, azx_irq_pending_work);
 	INIT_LIST_HEAD(&hda->list);
-- 
2.6.4
