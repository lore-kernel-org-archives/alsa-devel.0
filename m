From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/24] ALSA: au1x00: convert to platform device
Date: Wed, 12 Feb 2014 11:35:26 +0100
Message-ID: <1392201340-27113-11-git-send-email-tiwai@suse.de>
References: <1392201340-27113-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E1F9B26500B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 11:35:50 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 80BB8AC5B
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 10:35:50 +0000 (UTC)
In-Reply-To: <1392201340-27113-1-git-send-email-tiwai@suse.de>
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

From: Manuel Lauss <mano@roarinelk.homelinux.net>

Make sound/mips/au1x00.c a proper platform_driver.

[minor coding style fixes and forward-ported by tiwai]

Cc: Charles Eidsness <charles@cooper-street.com>
Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/mips/au1x00.c | 252 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 153 insertions(+), 99 deletions(-)

diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 224f54be15a6..9ca8fd0c2201 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -37,6 +37,7 @@
 #include <linux/ioport.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <sound/core.h>
@@ -98,6 +99,7 @@ struct snd_au1000 {
 
 	struct snd_pcm *pcm;
 	struct audio_stream *stream[2];	/* playback & capture */
+	int dmaid[2];		/* tx(0)/rx(1) DMA ids */
 };
 
 /*--------------------------- Local Functions --------------------------------*/
@@ -465,15 +467,17 @@ snd_au1000_pcm_new(struct snd_au1000 *au1000)
 	spin_lock_init(&au1000->stream[CAPTURE]->dma_lock);
 
 	flags = claim_dma_lock();
-	if ((au1000->stream[PLAYBACK]->dma = request_au1000_dma(DMA_ID_AC97C_TX,
+	au1000->stream[PLAYBACK]->dma = request_au1000_dma(au1000->dmaid[0],
 			"AC97 TX", au1000_dma_interrupt, 0,
-			au1000->stream[PLAYBACK])) < 0) {
+			au1000->stream[PLAYBACK]);
+	if (au1000->stream[PLAYBACK]->dma < 0) {
 		release_dma_lock(flags);
 		return -EBUSY;
 	}
-	if ((au1000->stream[CAPTURE]->dma = request_au1000_dma(DMA_ID_AC97C_RX,
+	au1000->stream[CAPTURE]->dma = request_au1000_dma(au1000->dmaid[1],
 			"AC97 RX", au1000_dma_interrupt, 0,
-			au1000->stream[CAPTURE])) < 0){
+			au1000->stream[CAPTURE]);
+	if (au1000->stream[CAPTURE]->dma < 0){
 		release_dma_lock(flags);
 		return -EBUSY;
 	}
@@ -552,69 +556,12 @@ get the interrupt driven case to work efficiently */
 	spin_unlock(&au1000->ac97_lock);
 }
 
-static int
-snd_au1000_ac97_new(struct snd_au1000 *au1000)
-{
-	int err;
-	struct snd_ac97_bus *pbus;
-	struct snd_ac97_template ac97;
- 	static struct snd_ac97_bus_ops ops = {
-		.write = snd_au1000_ac97_write,
-		.read = snd_au1000_ac97_read,
-	};
-
-	if ((au1000->ac97_res_port = request_mem_region(CPHYSADDR(AC97C_CONFIG),
-	       		0x100000, "Au1x00 AC97")) == NULL) {
-		snd_printk(KERN_ERR "ALSA AC97: can't grap AC97 port\n");
-		return -EBUSY;
-	}
-	au1000->ac97_ioport = (struct au1000_ac97_reg *)
-		KSEG1ADDR(au1000->ac97_res_port->start);
-
-	spin_lock_init(&au1000->ac97_lock);
-
-	/* configure pins for AC'97
-	TODO: move to board_setup.c */
-	au_writel(au_readl(SYS_PINFUNC) & ~0x02, SYS_PINFUNC);
-
-	/* Initialise Au1000's AC'97 Control Block */
-	au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
-	udelay(10);
-	au1000->ac97_ioport->cntrl = AC97C_CE;
-	udelay(10);
-
-	/* Initialise External CODEC -- cold reset */
-	au1000->ac97_ioport->config = AC97C_RESET;
-	udelay(10);
-	au1000->ac97_ioport->config = 0x0;
-	mdelay(5);
-
-	/* Initialise AC97 middle-layer */
-	if ((err = snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus)) < 0)
- 		return err;
-
-	memset(&ac97, 0, sizeof(ac97));
-	ac97.private_data = au1000;
-	if ((err = snd_ac97_mixer(pbus, &ac97, &au1000->ac97)) < 0)
-		return err;
-
-	return 0;
-}
-
 /*------------------------------ Setup / Destroy ----------------------------*/
 
-void
-snd_au1000_free(struct snd_card *card)
+static void snd_au1000_free(struct snd_card *card)
 {
 	struct snd_au1000 *au1000 = card->private_data;
 
-	if (au1000->ac97_res_port) {
-		/* put internal AC97 block into reset */
-		au1000->ac97_ioport->cntrl = AC97C_RS;
-		au1000->ac97_ioport = NULL;
-		release_and_free_resource(au1000->ac97_res_port);
-	}
-
 	if (au1000->stream[PLAYBACK]) {
 	  	if (au1000->stream[PLAYBACK]->dma >= 0)
 			free_au1000_dma(au1000->stream[PLAYBACK]->dma);
@@ -626,71 +573,178 @@ snd_au1000_free(struct snd_card *card)
 			free_au1000_dma(au1000->stream[CAPTURE]->dma);
 		kfree(au1000->stream[CAPTURE]);
 	}
-}
 
+	if (au1000->ac97_res_port) {
+		/* put internal AC97 block into reset */
+		au1000->ac97_ioport->cntrl = AC97C_RS;
+		iounmap(au1000->ac97_ioport);
+		au1000->ac97_ioport = NULL;
+		release_and_free_resource(au1000->ac97_res_port);
+		au1000->ac97_res_port = NULL;
+	}
+}
 
-static struct snd_card *au1000_card;
+static struct snd_ac97_bus_ops ops = {
+	.write	= snd_au1000_ac97_write,
+	.read	= snd_au1000_ac97_read,
+};
 
-static int __init
-au1000_init(void)
+static int au1000_ac97_probe(struct platform_device *pdev)
 {
 	int err;
+	void __iomem *io;
+	struct resource *r;
 	struct snd_card *card;
 	struct snd_au1000 *au1000;
+	struct snd_ac97_bus *pbus;
+	struct snd_ac97_template ac97;
 
 	err = snd_card_create(-1, "AC97", THIS_MODULE,
-			      sizeof(struct snd_au1000), &card);
+				sizeof(struct snd_au1000), &card);
 	if (err < 0)
-		return err;
+		goto out0;
 
-	card->private_free = snd_au1000_free;
 	au1000 = card->private_data;
 	au1000->card = card;
 
-	au1000->stream[PLAYBACK] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
-	au1000->stream[CAPTURE ] = kmalloc(sizeof(struct audio_stream), GFP_KERNEL);
-	/* so that snd_au1000_free will work as intended */
- 	au1000->ac97_res_port = NULL;
-	if (au1000->stream[PLAYBACK])
-		au1000->stream[PLAYBACK]->dma = -1;
-	if (au1000->stream[CAPTURE ])
-		au1000->stream[CAPTURE ]->dma = -1;
-
-	if (au1000->stream[PLAYBACK] == NULL ||
-	    au1000->stream[CAPTURE ] == NULL) {
-		snd_card_free(card);
-		return -ENOMEM;
+	/* TX DMA ID */
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 0);
+	if (!r) {
+		err = -ENODEV;
+		snd_printk(KERN_INFO "no TX DMA platform resource!\n");
+		goto out1;
 	}
-
-	if ((err = snd_au1000_ac97_new(au1000)) < 0 ) {
-		snd_card_free(card);
-		return err;
+	au1000->dmaid[0] = r->start;
+
+	/* RX DMA ID */
+	r = platform_get_resource(pdev, IORESOURCE_DMA, 1);
+	if (!r) {
+		err = -ENODEV;
+		snd_printk(KERN_INFO "no RX DMA platform resource!\n");
+		goto out1;
 	}
-
-	if ((err = snd_au1000_pcm_new(au1000)) < 0) {
-		snd_card_free(card);
-		return err;
+	au1000->dmaid[1] = r->start;
+
+	au1000->stream[PLAYBACK] = kmalloc(sizeof(struct audio_stream),
+					   GFP_KERNEL);
+	if (!au1000->stream[PLAYBACK])
+		goto out1;
+	au1000->stream[PLAYBACK]->dma = -1;
+
+	au1000->stream[CAPTURE] = kmalloc(sizeof(struct audio_stream),
+					  GFP_KERNEL);
+	if (!au1000->stream[CAPTURE])
+		goto out2;
+	au1000->stream[CAPTURE]->dma = -1;
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!r)
+		goto out3;
+
+	err = -EBUSY;
+	au1000->ac97_res_port = request_mem_region(r->start,
+					r->end - r->start + 1, pdev->name);
+	if (!au1000->ac97_res_port) {
+		snd_printk(KERN_ERR "ALSA AC97: can't grab AC97 port\n");
+		goto out3;
 	}
 
+	io = ioremap(r->start, r->end - r->start + 1);
+	if (!io)
+		goto out4;
+
+	au1000->ac97_ioport = (struct au1000_ac97_reg *)io;
+
+	spin_lock_init(&au1000->ac97_lock);
+
+	/* configure pins for AC'97
+	TODO: move to board_setup.c */
+	au_writel(au_readl(SYS_PINFUNC) & ~0x02, SYS_PINFUNC);
+
+	/* Initialise Au1000's AC'97 Control Block */
+	au1000->ac97_ioport->cntrl = AC97C_RS | AC97C_CE;
+	udelay(10);
+	au1000->ac97_ioport->cntrl = AC97C_CE;
+	udelay(10);
+
+	/* Initialise External CODEC -- cold reset */
+	au1000->ac97_ioport->config = AC97C_RESET;
+	udelay(10);
+	au1000->ac97_ioport->config = 0x0;
+	mdelay(5);
+
+	/* Initialise AC97 middle-layer */
+	err = snd_ac97_bus(au1000->card, 0, &ops, au1000, &pbus);
+	if (err < 0)
+		goto out5;
+
+	/* from here on let ALSA call the special freeing function */
+	card->private_free = snd_au1000_free;
+
+	memset(&ac97, 0, sizeof(ac97));
+	ac97.private_data = au1000;
+	err = snd_ac97_mixer(pbus, &ac97, &au1000->ac97);
+	if (err < 0)
+		goto out1;
+
+	err = snd_au1000_pcm_new(au1000);
+	if (err < 0)
+		goto out1;
+
 	strcpy(card->driver, "Au1000-AC97");
 	strcpy(card->shortname, "AMD Au1000-AC97");
 	sprintf(card->longname, "AMD Au1000--AC97 ALSA Driver");
 
-	if ((err = snd_card_register(card)) < 0) {
-		snd_card_free(card);
-		return err;
-	}
+	err = snd_card_register(card);
+	if (err < 0)
+		goto out1;
 
 	printk(KERN_INFO "ALSA AC97: Driver Initialized\n");
-	au1000_card = card;
+
+	platform_set_drvdata(pdev, card);
+
 	return 0;
+
+out5:
+	au1000->ac97_ioport->cntrl = AC97C_RS;
+	iounmap(io);
+out4:
+	release_and_free_resource(au1000->ac97_res_port);
+out3:
+	kfree(au1000->stream[PLAYBACK]);
+out2:
+	kfree(au1000->stream[PLAYBACK]);
+out1:
+	snd_card_free(card);
+out0:
+	return err;
 }
 
-static void __exit au1000_exit(void)
+static int au1000_ac97_remove(struct platform_device *pdev)
 {
-	snd_card_free(au1000_card);
+	struct snd_card *card = platform_get_drvdata(pdev);
+	snd_card_free(card);
+	return 0;
 }
 
-module_init(au1000_init);
-module_exit(au1000_exit);
+struct platform_driver au1000_ac97c_driver = {
+	.driver	= {
+		.name	= "au1000-ac97c",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= au1000_ac97_probe,
+	.remove		= au1000_ac97_remove,
+};
+
+static int __init au1000_ac97_load(void)
+{
+	return platform_driver_register(&au1000_ac97c_driver);
+}
+
+static void __exit au1000_ac97_unload(void)
+{
+	platform_driver_unregister(&au1000_ac97c_driver);
+}
 
+module_init(au1000_ac97_load);
+module_exit(au1000_ac97_unload);
-- 
1.8.5.2
