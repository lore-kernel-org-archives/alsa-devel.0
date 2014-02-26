From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 45/48] ALSA: vx222: Use standard printk helpers
Date: Wed, 26 Feb 2014 16:53:47 +0100
Message-ID: <1393430030-26704-46-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A9AA2657E8
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:54 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 06AB67504A
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:54 +0000 (UTC)
In-Reply-To: <1393430030-26704-1-git-send-email-tiwai@suse.de>
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

Convert with dev_err() and co from snd_printk(), etc.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/vx222/vx222.c     |  7 +++----
 sound/pci/vx222/vx222_ops.c | 19 ++++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 4323556c13f8..ff9074d22607 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -170,7 +170,7 @@ static int snd_vx222_create(struct snd_card *card, struct pci_dev *pci,
 
 	if (request_irq(pci->irq, snd_vx_irq_handler, IRQF_SHARED,
 			KBUILD_MODNAME, chip)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_vx222_free(chip);
 		return -EBUSY;
 	}
@@ -228,7 +228,7 @@ static int snd_vx222_probe(struct pci_dev *pci,
 
 	sprintf(card->longname, "%s at 0x%lx & 0x%lx, irq %i",
 		card->shortname, vx->port[0], vx->port[1], vx->core.irq);
-	snd_printdd("%s at 0x%lx & 0x%lx, irq %i\n",
+	dev_dbg(card->dev, "%s at 0x%lx & 0x%lx, irq %i\n",
 		    card->shortname, vx->port[0], vx->port[1], vx->core.irq);
 
 #ifdef SND_VX_FW_LOADER
@@ -279,8 +279,7 @@ static int snd_vx222_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR "vx222: pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index a69e774d0b13..2d1570273e99 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -108,7 +108,7 @@ static void vx2_outb(struct vx_core *chip, int offset, unsigned char val)
 {
 	outb(val, vx2_reg_addr(chip, offset));
 	/*
-	printk(KERN_DEBUG "outb: %x -> %x\n", val, vx2_reg_addr(chip, offset));
+	dev_dbg(chip->card->dev, "outb: %x -> %x\n", val, vx2_reg_addr(chip, offset));
 	*/
 }
 
@@ -129,7 +129,7 @@ static unsigned int vx2_inl(struct vx_core *chip, int offset)
 static void vx2_outl(struct vx_core *chip, int offset, unsigned int val)
 {
 	/*
-	printk(KERN_DEBUG "outl: %x -> %x\n", val, vx2_reg_addr(chip, offset));
+	dev_dbg(chip->card->dev, "outl: %x -> %x\n", val, vx2_reg_addr(chip, offset));
 	*/
 	outl(val, vx2_reg_addr(chip, offset));
 }
@@ -173,7 +173,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
 	unsigned int data;
 
-	snd_printdd("testing xilinx...\n");
+	dev_dbg(_chip->card->dev, "testing xilinx...\n");
 	/* This test uses several write/read sequences on TEST0 and TEST1 bits
 	 * to figure out whever or not the xilinx was correctly loaded
 	 */
@@ -183,7 +183,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 	vx_inl(chip, ISR);
 	data = vx_inl(chip, STATUS);
 	if ((data & VX_STATUS_VAL_TEST0_MASK) == VX_STATUS_VAL_TEST0_MASK) {
-		snd_printdd("bad!\n");
+		dev_dbg(_chip->card->dev, "bad!\n");
 		return -ENODEV;
 	}
 
@@ -192,7 +192,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 	vx_inl(chip, ISR);
 	data = vx_inl(chip, STATUS);
 	if (! (data & VX_STATUS_VAL_TEST0_MASK)) {
-		snd_printdd("bad! #2\n");
+		dev_dbg(_chip->card->dev, "bad! #2\n");
 		return -ENODEV;
 	}
 
@@ -203,7 +203,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 		vx_inl(chip, ISR);
 		data = vx_inl(chip, STATUS);
 		if ((data & VX_STATUS_VAL_TEST1_MASK) == VX_STATUS_VAL_TEST1_MASK) {
-			snd_printdd("bad! #3\n");
+			dev_dbg(_chip->card->dev, "bad! #3\n");
 			return -ENODEV;
 		}
 
@@ -212,11 +212,11 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 		vx_inl(chip, ISR);
 		data = vx_inl(chip, STATUS);
 		if (! (data & VX_STATUS_VAL_TEST1_MASK)) {
-			snd_printdd("bad! #4\n");
+			dev_dbg(_chip->card->dev, "bad! #4\n");
 			return -ENODEV;
 		}
 	}
-	snd_printdd("ok, xilinx fine.\n");
+	dev_dbg(_chip->card->dev, "ok, xilinx fine.\n");
 	return 0;
 }
 
@@ -397,7 +397,8 @@ static int vx2_load_xilinx_binary(struct vx_core *chip, const struct firmware *x
 		i = vx_inl(chip, GPIOC);
 		if (i & 0x0100)
 			return 0;
-		snd_printk(KERN_ERR "vx222: xilinx test failed after load, GPIOC=0x%x\n", i);
+		dev_err(chip->card->dev,
+			"xilinx test failed after load, GPIOC=0x%x\n", i);
 		return -EINVAL;
 	}
 
-- 
1.9.0
