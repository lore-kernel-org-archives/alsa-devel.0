From: Tobias Klauser <tklauser@nuerscht.ch>
Subject: [PATCH] sound: Create and use DMA_28BIT_MASK
Date: Sun, 26 Feb 2006 15:44:12 +0100
Message-ID: <20060226144412.GA1397__21862.7554517754$1140966562$gmane$org@neon.tklauser.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 81D60190
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 15:44:23 +0100 (MET)
Received: from herakles.nuerscht.net (unknown [85.10.227.118])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id D2E8A9926C
	for <alsa-devel@alsa-project.org>; Sun, 26 Feb 2006 15:44:22 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kernel-janitors@lists.osdl.org
Cc: akpm@osdl.org, perex@suse.cz, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch introduces the DMA_28BIT_MASK constant in dma-mapping.h
ALSA drivers using this mask are changed to use the new constant.

Signed-off-by: Tobias Klauser <tklauser@nuerscht.ch>

---

 include/linux/dma-mapping.h  |    1 +
 sound/pci/ad1889.c           |    7 ++++---
 sound/pci/emu10k1/emu10k1x.c |   13 +++++++------
 sound/pci/es1968.c           |    5 +++--
 sound/pci/ice1712/ice1712.c  |    5 +++--
 sound/pci/maestro3.c         |    5 +++--
 sound/pci/mixart/mixart.c    |    3 ++-
 sound/pci/pcxhr/pcxhr.c      |    3 ++-
 8 files changed, 25 insertions(+), 17 deletions(-)

99c5d8c1b63887d6ae17ecc9623fcf6488b114bc
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2d80cc7..a873106 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -20,6 +20,7 @@ enum dma_data_direction {
 #define DMA_31BIT_MASK	0x000000007fffffffULL
 #define DMA_30BIT_MASK	0x000000003fffffffULL
 #define DMA_29BIT_MASK	0x000000001fffffffULL
+#define DMA_28BIT_MASK	0x000000000fffffffULL
 
 #include <asm/dma-mapping.h>
 
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index a208075..2aa5a7f 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -34,6 +34,7 @@
 
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/compiler.h>
@@ -909,10 +910,10 @@ snd_ad1889_create(struct snd_card *card,
 
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	
+
 	/* check PCI availability (32bit DMA) */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		printk(KERN_ERR PFX "error setting 32-bit DMA mask.\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index 1107c8e..2208dbd 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
@@ -893,24 +894,24 @@ static int __devinit snd_emu10k1x_create
 	static struct snd_device_ops ops = {
 		.dev_free = snd_emu10k1x_dev_free,
 	};
-  
+
 	*rchip = NULL;
-  
+
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "error to set 28bit mask DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
 	}
-  
+
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
 	if (chip == NULL) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
-  
+
 	chip->card = card;
 	chip->pci = pci;
 	chip->irq = -1;
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 3747a43..5155fbc 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -100,6 +100,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/gameport.h>
 #include <linux/moduleparam.h>
@@ -2559,8 +2560,8 @@ static int __devinit snd_es1968_create(s
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index ef6f185..c34f933 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -53,6 +53,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
@@ -2538,8 +2539,8 @@ static int __devinit snd_ice1712_create(
 	if ((err = pci_enable_device(pci)) < 0)
 		return err;
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index d3ef0cc..8bc0849 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -37,6 +37,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/moduleparam.h>
@@ -2657,8 +2658,8 @@ snd_m3_create(struct snd_card *card, str
 		return -EIO;
 
 	/* check, if we can restrict PCI DMA transfers to 28 bits */
-	if (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
-	    pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_28BIT_MASK) < 0 ||
+	    pci_set_consistent_dma_mask(pci, DMA_28BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 28bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index b218e1d..80ef405 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -25,6 +25,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
 #include <sound/initval.h>
@@ -1288,7 +1289,7 @@ static int __devinit snd_mixart_probe(st
 	pci_set_master(pci);
 
 	/* check if we can restrict PCI DMA transfers to 32 bits */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index b2cba75..54bcc08 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/moduleparam.h>
 #include <sound/core.h>
@@ -1215,7 +1216,7 @@ static int __devinit pcxhr_probe(struct 
 	pci_set_master(pci);
 
 	/* check if we can restrict PCI DMA transfers to 32 bits */
-	if (pci_set_dma_mask(pci, 0xffffffff) < 0) {
+	if (pci_set_dma_mask(pci, DMA_32BIT_MASK) < 0) {
 		snd_printk(KERN_ERR "architecture does not support 32bit PCI busmaster DMA\n");
 		pci_disable_device(pci);
 		return -ENXIO;
-- 
1.2.3



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
