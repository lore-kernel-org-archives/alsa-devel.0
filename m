From: libin.yang@linux.intel.com
Subject: [RFC: PATCH] ALSA: hda - clear IRQ statu twice on some
	Intel platforms
Date: Mon, 22 Feb 2016 15:39:50 +0800
Message-ID: <1456126790-13480-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C34E260789
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 08:44:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

On some Intel platforms, we found the interrupt issue in
the below scenario:
1. driver is in irq handler
2. there is another interrupt from HW after interrupt status
   is cleared and before exiting from interrupt handler
3. exit from the current irq handling

After exiting the irq handler, it should raise another
interrupt for driver to handle the new interrupt. But actually,
it failed to raise the interrupt and driver will never have
chance to clear the interrupt status.

The patch clears the interrupt status again just before exiting
for interrupt handler. This can reduce the contest dramatically.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/hda_controller.c |  3 +++
 sound/pci/hda/hda_controller.h |  3 +++
 sound/pci/hda/hda_intel.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index 37cf9ce..2ca95c7 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -963,6 +963,9 @@ irqreturn_t azx_interrupt(int irq, void *dev_id)
 		azx_writeb(chip, RIRBSTS, RIRB_INT_MASK);
 	}
 
+	if (chip->post_irq)
+		chip->post_irq(chip);
+
 	spin_unlock(&bus->reg_lock);
 
 	return IRQ_HANDLED;
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index ec63bbf..ce59997 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -146,6 +146,9 @@ struct azx {
 	const struct firmware *fw;
 #endif
 
+	/* callback at the end of interrupt handler  */
+	void (*post_irq)(struct azx *);
+
 	/* flags */
 	int bdl_pos_adj;
 	int poll_count;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4045dca..6a47d88 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1663,6 +1663,43 @@ static int azx_create(struct snd_card *card, struct pci_dev *pci,
 	return 0;
 }
 
+/* HSW, BDW, SKL and BXT need do post_irq() */
+#define INTEL_IRQ_POST(chip) \
+	(((chip)->pci->vendor == PCI_VENDOR_ID_INTEL) && \
+	 (((chip)->pci->device == 0x0a0c) || \
+	 ((chip)->pci->device == 0x0c0c) || \
+	 ((chip)->pci->device == 0x0d0c) || \
+	 ((chip)->pci->device == 0x160c) || \
+	 ((chip)->pci->device == 0xa170) || \
+	 ((chip)->pci->device == 0x9d70) || \
+	 ((chip)->pci->device == 0x5a98)))
+
+
+/* on some intel platforms, if there occurs an interrupt
+ * when irq is being handled, interrupt signal will not be raised
+ * after the irq handler returns. And the interrupt status may never
+ * be cleared.
+ * So let's clear all the interrupt status before return from irq handler.
+ * This can help to reduce the contest between the irq handler and the signal.
+ */
+static void intel_post_irq(struct azx *chip)
+{
+	struct hdac_bus *bus = azx_bus(chip);
+	struct hdac_stream *azx_dev;
+
+	list_for_each_entry(azx_dev, &bus->stream_list, list)
+		snd_hdac_stream_writeb(azx_dev, SD_STS, SD_INT_MASK);
+
+	/* clear STATESTS */
+	snd_hdac_chip_writew(bus, STATESTS, STATESTS_INT_MASK);
+
+	/* clear rirb status */
+	snd_hdac_chip_writeb(bus, RIRBSTS, RIRB_INT_MASK);
+
+	/* clear int status */
+	snd_hdac_chip_writel(bus, INTSTS, AZX_INT_CTRL_EN | AZX_INT_ALL_STREAM);
+}
+
 static int azx_first_init(struct azx *chip)
 {
 	int dev = chip->dev_index;
@@ -1717,6 +1754,9 @@ static int azx_first_init(struct azx *chip)
 	if (chip->pci->vendor == PCI_VENDOR_ID_AMD)
 		dma_bits = 40;
 
+	if (INTEL_IRQ_POST(chip))
+		chip->post_irq = intel_post_irq;
+
 	/* disable SB600 64bit support for safety */
 	if (chip->pci->vendor == PCI_VENDOR_ID_ATI) {
 		struct pci_dev *p_smbus;
-- 
1.9.1
