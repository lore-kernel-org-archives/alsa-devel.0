From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] pci: use pci_ioremap_bar() in sound/
Date: Mon, 20 Oct 2008 21:53:46 -0700
Message-ID: <20081020215346.01d2c67b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B47E103808
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 06:53:48 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


>From 6666b6edd4a0c496932ef1640b742cc72f9c57d8 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 28 Sep 2008 16:20:09 -0700
Subject: [PATCH] pci: use pci_ioremap_bar() in sound/

Use the newly introduced pci_ioremap_bar() function in sound/.
pci_ioremap_bar() just takes a pci device and a bar number, with the goal
of making it really hard to get wrong, while also having a central place
to stick sanity checks.

CC: tiwai@suse.de
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 sound/pci/ad1889.c        |    2 +-
 sound/pci/atiixp.c        |    2 +-
 sound/pci/atiixp_modem.c  |    2 +-
 sound/pci/au88x0/au88x0.c |    3 +--
 sound/pci/bt87x.c         |    3 +--
 sound/pci/cs4281.c        |    4 ++--
 sound/pci/cs5530.c        |    2 +-
 sound/pci/hda/hda_intel.c |    2 +-
 sound/pci/mixart/mixart.c |    3 +--
 9 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 92f3a97..a7f38e6 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -932,7 +932,7 @@ snd_ad1889_create(struct snd_card *card,
 		goto free_and_ret;
 
 	chip->bar = pci_resource_start(pci, 0);
-	chip->iobase = ioremap_nocache(chip->bar, pci_resource_len(pci, 0));
+	chip->iobase = pci_ioremap_bar(pci, 0);
 	if (chip->iobase == NULL) {
 		printk(KERN_ERR PFX "unable to reserve region.\n");
 		err = -EBUSY;
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 085a52b..226fe82 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -1609,7 +1609,7 @@ static int __devinit snd_atiixp_create(struct snd_card *card,
 		return err;
 	}
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = ioremap_nocache(chip->addr, pci_resource_len(pci, 0));
+	chip->remap_addr = pci_ioremap_bar(pci, 0);
 	if (chip->remap_addr == NULL) {
 		snd_printk(KERN_ERR "AC'97 space ioremap problem\n");
 		snd_atiixp_free(chip);
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 2f10630..0e6e5cc 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -1252,7 +1252,7 @@ static int __devinit snd_atiixp_create(struct snd_card *card,
 		return err;
 	}
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = ioremap_nocache(chip->addr, pci_resource_len(pci, 0));
+	chip->remap_addr = pci_ioremap_bar(pci, 0);
 	if (chip->remap_addr == NULL) {
 		snd_printk(KERN_ERR "AC'97 space ioremap problem\n");
 		snd_atiixp_free(chip);
diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
index 68368e4..a36d4d1 100644
--- a/sound/pci/au88x0/au88x0.c
+++ b/sound/pci/au88x0/au88x0.c
@@ -180,8 +180,7 @@ snd_vortex_create(struct snd_card *card, struct pci_dev *pci, vortex_t ** rchip)
 	if ((err = pci_request_regions(pci, CARD_NAME_SHORT)) != 0)
 		goto regions_out;
 
-	chip->mmio = ioremap_nocache(pci_resource_start(pci, 0),
-	                             pci_resource_len(pci, 0));
+	chip->mmio = pci_ioremap_bar(pci, 0);
 	if (!chip->mmio) {
 		printk(KERN_ERR "MMIO area remap failed.\n");
 		err = -ENOMEM;
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index 3aa8d97..1aa1c04 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -749,8 +749,7 @@ static int __devinit snd_bt87x_create(struct snd_card *card,
 		pci_disable_device(pci);
 		return err;
 	}
-	chip->mmio = ioremap_nocache(pci_resource_start(pci, 0),
-				     pci_resource_len(pci, 0));
+	chip->mmio = pci_ioremap_bar(pci, 0);
 	if (!chip->mmio) {
 		snd_printk(KERN_ERR "cannot remap io memory\n");
 		err = -ENOMEM;
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index ef9308f..192e784 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -1382,8 +1382,8 @@ static int __devinit snd_cs4281_create(struct snd_card *card,
 	chip->ba0_addr = pci_resource_start(pci, 0);
 	chip->ba1_addr = pci_resource_start(pci, 1);
 
-	chip->ba0 = ioremap_nocache(chip->ba0_addr, pci_resource_len(pci, 0));
-	chip->ba1 = ioremap_nocache(chip->ba1_addr, pci_resource_len(pci, 1));
+	chip->ba0 = pci_ioremap_bar(pci, 0);
+	chip->ba1 = pci_ioremap_bar(pci, 1);
 	if (!chip->ba0 || !chip->ba1) {
 		snd_cs4281_free(chip);
 		return -ENOMEM;
diff --git a/sound/pci/cs5530.c b/sound/pci/cs5530.c
index 7ff8b68..4d9378d 100644
--- a/sound/pci/cs5530.c
+++ b/sound/pci/cs5530.c
@@ -132,7 +132,7 @@ static int __devinit snd_cs5530_create(struct snd_card *card,
 	}
 	chip->pci_base = pci_resource_start(pci, 0);
 
-	mem = ioremap_nocache(chip->pci_base, pci_resource_len(pci, 0));
+	mem = pci_ioremap_bar(pci, 0);
 	if (mem == NULL) {
 		kfree(chip);
 		pci_disable_device(pci);
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 9f316c1..f080f8c 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2158,7 +2158,7 @@ static int __devinit azx_create(struct snd_card *card, struct pci_dev *pci,
 	}
 
 	chip->addr = pci_resource_start(pci, 0);
-	chip->remap_addr = ioremap_nocache(chip->addr, pci_resource_len(pci,0));
+	chip->remap_addr = pci_ioremap_bar(pci, 0);
 	if (chip->remap_addr == NULL) {
 		snd_printk(KERN_ERR SFX "ioremap error\n");
 		err = -ENXIO;
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index 2d0dce6..ae7601f 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -1314,8 +1314,7 @@ static int __devinit snd_mixart_probe(struct pci_dev *pci,
 	}
 	for (i = 0; i < 2; i++) {
 		mgr->mem[i].phys = pci_resource_start(pci, i);
-		mgr->mem[i].virt = ioremap_nocache(mgr->mem[i].phys,
-						   pci_resource_len(pci, i));
+		mgr->mem[i].virt = pci_ioremap_bar(pci, i);
 		if (!mgr->mem[i].virt) {
 		        printk(KERN_ERR "unable to remap resource 0x%lx\n",
 			       mgr->mem[i].phys);
-- 
1.5.5.1


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
