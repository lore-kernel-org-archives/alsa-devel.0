From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 3/3] ALSA: sonicvibes: Use common error
 handling code in snd_sonicvibes_create()
Date: Sat, 18 Nov 2017 16:33:04 +0100
Message-ID: <2aa5fdc3-de4d-54f2-2d3e-ae5e4f87153d@users.sourceforge.net>
References: <663ac54c-baf9-ac11-50fd-d8b407d1eacf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D26267353
 for <alsa-devel@alsa-project.org>; Sat, 18 Nov 2017 16:33:13 +0100 (CET)
In-Reply-To: <663ac54c-baf9-ac11-50fd-d8b407d1eacf@users.sourceforge.net>
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
To: alsa-devel@alsa-project.org, Bhumika Goyal <bhumirks@gmail.com>, David Howells <dhowells@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 18 Nov 2017 16:12:12 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/pci/sonicvibes.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 75fc64839df0..c2147484c95d 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -1266,14 +1266,14 @@ static int snd_sonicvibes_create(struct snd_card *card,
 	    dma_set_coherent_mask(&pci->dev, DMA_BIT_MASK(24)) < 0) {
 		dev_err(card->dev,
 			"architecture does not support 24bit PCI busmaster DMA\n");
-		pci_disable_device(pci);
-                return -ENXIO;
+		err = -ENXIO;
+		goto disable_device;
         }
 
 	sonic = kzalloc(sizeof(*sonic), GFP_KERNEL);
 	if (sonic == NULL) {
-		pci_disable_device(pci);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto disable_device;
 	}
 	spin_lock_init(&sonic->reg_lock);
 	sonic->card = card;
@@ -1283,8 +1283,7 @@ static int snd_sonicvibes_create(struct snd_card *card,
 	err = pci_request_regions(pci, "S3 SonicVibes");
 	if (err < 0) {
 		kfree(sonic);
-		pci_disable_device(pci);
-		return err;
+		goto disable_device;
 	}
 
 	sonic->sb_port = pci_resource_start(pci, 0);
@@ -1296,8 +1295,7 @@ static int snd_sonicvibes_create(struct snd_card *card,
 	if (request_irq(pci->irq, snd_sonicvibes_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, sonic)) {
 		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
-		snd_sonicvibes_free(sonic);
-		return -EBUSY;
+		goto e_busy;
 	}
 	sonic->irq = pci->irq;
 
@@ -1325,20 +1323,18 @@ static int snd_sonicvibes_create(struct snd_card *card,
 
 	sonic->res_dmaa = request_region(dmaa, 0x10, "S3 SonicVibes DDMA-A");
 	if (!sonic->res_dmaa) {
-		snd_sonicvibes_free(sonic);
 		dev_err(card->dev,
 			"unable to grab DDMA-A port at 0x%x-0x%x\n",
 			dmaa, dmaa + 0x10 - 1);
-		return -EBUSY;
+		goto e_busy;
 	}
 
 	sonic->res_dmac = request_region(dmac, 0x10, "S3 SonicVibes DDMA-C");
 	if (!sonic->res_dmac) {
-		snd_sonicvibes_free(sonic);
 		dev_err(card->dev,
 			"unable to grab DDMA-C port at 0x%x-0x%x\n",
 			dmac, dmac + 0x10 - 1);
-		return -EBUSY;
+		goto e_busy;
 	}
 
 	pci_read_config_dword(pci, 0x40, &sonic->dmaa_port);
@@ -1395,15 +1391,23 @@ static int snd_sonicvibes_create(struct snd_card *card,
 #endif
 	sonic->revision = snd_sonicvibes_in(sonic, SV_IREG_REVISION);
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, sonic, &ops);
-	if (err < 0) {
-		snd_sonicvibes_free(sonic);
-		return err;
-	}
+	if (err < 0)
+		goto free_sound_chip;
 
 	snd_sonicvibes_proc_init(sonic);
 
 	*rsonic = sonic;
 	return 0;
+
+disable_device:
+	pci_disable_device(pci);
+	return err;
+
+e_busy:
+	err = -EBUSY;
+free_sound_chip:
+	snd_sonicvibes_free(sonic);
+	return err;
 }
 
 /*
-- 
2.15.0
