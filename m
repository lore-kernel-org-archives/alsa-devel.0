From: Dylan Reid <dgreid@chromium.org>
Subject: [RFC 08/19] ALSA: hda - Add function pointer for
	disabling MSI
Date: Thu, 27 Feb 2014 22:35:51 -0800
Message-ID: <1393569362-27285-9-git-send-email-dgreid@chromium.org>
References: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f73.google.com (mail-yh0-f73.google.com
 [209.85.213.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D4B3265086
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 07:37:13 +0100 (CET)
Received: by mail-yh0-f73.google.com with SMTP id f73so34073yha.2
 for <alsa-devel@alsa-project.org>; Thu, 27 Feb 2014 22:37:12 -0800 (PST)
In-Reply-To: <1393569362-27285-1-git-send-email-dgreid@chromium.org>
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, swarren@wwwdotorg.org
List-Id: alsa-devel@alsa-project.org

This is a PCI-only feature, but adding a callback for it in the chip
structure breaks the PCI dependency in the RIRB code allowing the
logic there to be re-used by the platform HDA driver.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/hda_intel.c | 22 +++++++++++++++++-----
 sound/pci/hda/hda_priv.h  |  3 +++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 33dc7ae..eaf8c78 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -543,11 +543,7 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		dev_warn(chip->card->dev,
 			 "No response from codec, disabling MSI: last cmd=0x%08x\n",
 			 chip->last_cmd[addr]);
-		free_irq(chip->irq, chip);
-		chip->irq = -1;
-		pci_disable_msi(chip->pci);
-		chip->msi = 0;
-		if (azx_acquire_irq(chip, 1) < 0) {
+		if (chip->disable_msi_reset_irq(chip) < 0) {
 			bus->rirb_error = 1;
 			return -1;
 		}
@@ -1924,6 +1920,21 @@ static void azx_probe_work(struct work_struct *work)
 	azx_probe_continue(container_of(work, struct azx, probe_work));
 }
 
+static int disable_msi_reset_irq(struct azx *chip)
+{
+	int err;
+
+	free_irq(chip->irq, chip);
+	chip->irq = -1;
+	pci_disable_msi(chip->pci);
+	chip->msi = 0;
+	err = azx_acquire_irq(chip, 1);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 /*
  * constructor
  */
@@ -1961,6 +1972,7 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	chip->driver_type = driver_caps & 0xff;
 	check_msi(chip);
 	chip->dev_index = dev;
+	chip->disable_msi_reset_irq = disable_msi_reset_irq;
 	INIT_WORK(&chip->irq_pending_work, azx_irq_pending_work);
 	INIT_LIST_HEAD(&chip->pcm_list);
 	INIT_LIST_HEAD(&chip->list);
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 0e3bba1..f1fa6f4 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -378,6 +378,9 @@ struct azx {
 	/* for debugging */
 	unsigned int last_cmd[AZX_MAX_CODECS];
 
+	/* disable msi if supported, PCI only */
+	int (*disable_msi_reset_irq)(struct azx *);
+
 	/* for pending irqs */
 	struct work_struct irq_pending_work;
 
-- 
1.8.1.3.605.g02339dd
