From: Dylan Reid <dgreid@chromium.org>
Subject: [RFCv2 05/22] ALSA: hda - Add function pointer for
	disabling MSI
Date: Fri, 28 Feb 2014 15:41:16 -0800
Message-ID: <1393630893-29010-6-git-send-email-dgreid@chromium.org>
References: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f201.google.com (mail-pd0-f201.google.com
 [209.85.192.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E99A2659B5
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 00:42:52 +0100 (CET)
Received: by mail-pd0-f201.google.com with SMTP id x10so174853pdj.0
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:42:51 -0800 (PST)
In-Reply-To: <1393630893-29010-1-git-send-email-dgreid@chromium.org>
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
 sound/pci/hda/hda_intel.c | 23 ++++++++++++++++++-----
 sound/pci/hda/hda_priv.h  |  4 ++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7630622..c4b6447 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -600,11 +600,8 @@ static unsigned int azx_rirb_get_response(struct hda_bus *bus,
 		dev_warn(chip->card->dev,
 			 "No response from codec, disabling MSI: last cmd=0x%08x\n",
 			 chip->last_cmd[addr]);
-		free_irq(chip->irq, chip);
-		chip->irq = -1;
-		pci_disable_msi(chip->pci);
-		chip->msi = 0;
-		if (azx_acquire_irq(chip, 1) < 0) {
+		if (chip->ops->disable_msi_reset_irq &&
+		    chip->ops->disable_msi_reset_irq(chip) < 0) {
 			bus->rirb_error = 1;
 			return -1;
 		}
@@ -3469,6 +3466,21 @@ static u8 pci_azx_readb(u8 *addr)
 	return readb(addr);
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
 static const struct hda_controller_ops pci_hda_ops = {
 	.writel = pci_azx_writel,
 	.readl = pci_azx_readl,
@@ -3476,6 +3488,7 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.readw = pci_azx_readw,
 	.writeb = pci_azx_writeb,
 	.readb = pci_azx_readb,
+	.disable_msi_reset_irq = disable_msi_reset_irq,
 };
 
 static int azx_probe(struct pci_dev *pci,
diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 17afe90..c231c11 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -285,6 +285,8 @@ struct azx_rb {
 	u32 res[AZX_MAX_CODECS];	/* last read value */
 };
 
+struct azx;
+
 /* Functions to read/write to hda registers. */
 struct hda_controller_ops {
 	/* Register Access */
@@ -294,6 +296,8 @@ struct hda_controller_ops {
 	u16 (*readw)(u16 *addr);
 	void (*writeb)(u8 value, u8 *addr);
 	u8 (*readb)(u8 *addr);
+	/* Disable msi if supported, PCI only */
+	int (*disable_msi_reset_irq)(struct azx *);
 };
 
 struct azx_pcm {
-- 
1.8.1.3.605.g02339dd
