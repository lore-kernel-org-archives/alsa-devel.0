From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 13/48] ALSA: ens137x: Use standard printk
	helpers
Date: Wed, 26 Feb 2014 16:53:15 +0100
Message-ID: <1393430030-26704-14-git-send-email-tiwai@suse.de>
References: <1393430030-26704-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id DD80E2657A1
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 16:53:53 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6ECD475031
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 15:53:53 +0000 (UTC)
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
 sound/pci/ens1370.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 0f89d2a2090e..29cd339ffc37 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -525,7 +525,7 @@ static unsigned int snd_es1371_wait_src_ready(struct ensoniq * ensoniq)
 			return r;
 		cond_resched();
 	}
-	snd_printk(KERN_ERR "wait src ready timeout 0x%lx [0x%x]\n",
+	dev_err(ensoniq->card->dev, "wait src ready timeout 0x%lx [0x%x]\n",
 		   ES_REG(ensoniq, 1371_SMPRATE), r);
 	return 0;
 }
@@ -587,7 +587,7 @@ static void snd_es1370_codec_write(struct snd_ak4531 *ak4531,
 	unsigned long end_time = jiffies + HZ / 10;
 
 #if 0
-	printk(KERN_DEBUG
+	dev_dbg(ensoniq->card->dev,
 	       "CODEC WRITE: reg = 0x%x, val = 0x%x (0x%x), creg = 0x%x\n",
 	       reg, val, ES_1370_CODEC_WRITE(reg, val), ES_REG(ensoniq, 1370_CODEC));
 #endif
@@ -598,7 +598,7 @@ static void snd_es1370_codec_write(struct snd_ak4531 *ak4531,
 		}
 		schedule_timeout_uninterruptible(1);
 	} while (time_after(end_time, jiffies));
-	snd_printk(KERN_ERR "codec write timeout, status = 0x%x\n",
+	dev_err(ensoniq->card->dev, "codec write timeout, status = 0x%x\n",
 		   inl(ES_REG(ensoniq, STATUS)));
 }
 
@@ -649,7 +649,7 @@ static void snd_es1371_codec_write(struct snd_ac97 *ac97,
 		}
 	}
 	mutex_unlock(&ensoniq->src_mutex);
-	snd_printk(KERN_ERR "codec write timeout at 0x%lx [0x%x]\n",
+	dev_err(ensoniq->card->dev, "codec write timeout at 0x%lx [0x%x]\n",
 		   ES_REG(ensoniq, 1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
 }
 
@@ -706,8 +706,8 @@ static unsigned short snd_es1371_codec_read(struct snd_ac97 *ac97,
 			}
 			mutex_unlock(&ensoniq->src_mutex);
 			if (++fail > 10) {
-				snd_printk(KERN_ERR "codec read timeout (final) "
-					   "at 0x%lx, reg = 0x%x [0x%x]\n",
+				dev_err(ensoniq->card->dev,
+					"codec read timeout (final) at 0x%lx, reg = 0x%x [0x%x]\n",
 					   ES_REG(ensoniq, 1371_CODEC), reg,
 					   inl(ES_REG(ensoniq, 1371_CODEC)));
 				return 0;
@@ -716,7 +716,7 @@ static unsigned short snd_es1371_codec_read(struct snd_ac97 *ac97,
 		}
 	}
 	mutex_unlock(&ensoniq->src_mutex);
-	snd_printk(KERN_ERR "es1371: codec read timeout at 0x%lx [0x%x]\n",
+	dev_err(ensoniq->card->dev, "codec read timeout at 0x%lx [0x%x]\n",
 		   ES_REG(ensoniq, 1371_CODEC), inl(ES_REG(ensoniq, 1371_CODEC)));
 	return 0;
 }
@@ -1796,7 +1796,7 @@ static int snd_ensoniq_1370_mixer(struct ensoniq *ensoniq)
 #ifdef SUPPORT_JOYSTICK
 
 #ifdef CHIP1371
-static int snd_ensoniq_get_joystick_port(int dev)
+static int snd_ensoniq_get_joystick_port(struct ensoniq *ensoniq, int dev)
 {
 	switch (joystick_port[dev]) {
 	case 0: /* disabled */
@@ -1808,12 +1808,13 @@ static int snd_ensoniq_get_joystick_port(int dev)
 		return joystick_port[dev];
 
 	default:
-		printk(KERN_ERR "ens1371: invalid joystick port %#x", joystick_port[dev]);
+		dev_err(ensoniq->card->dev,
+			"invalid joystick port %#x", joystick_port[dev]);
 		return 0;
 	}
 }
 #else
-static inline int snd_ensoniq_get_joystick_port(int dev)
+static int snd_ensoniq_get_joystick_port(struct ensoniq *ensoniq, int dev)
 {
 	return joystick[dev] ? 0x200 : 0;
 }
@@ -1824,7 +1825,7 @@ static int snd_ensoniq_create_gameport(struct ensoniq *ensoniq, int dev)
 	struct gameport *gp;
 	int io_port;
 
-	io_port = snd_ensoniq_get_joystick_port(dev);
+	io_port = snd_ensoniq_get_joystick_port(ensoniq, dev);
 
 	switch (io_port) {
 	case 0:
@@ -1835,14 +1836,16 @@ static int snd_ensoniq_create_gameport(struct ensoniq *ensoniq, int dev)
 			if (request_region(io_port, 8, "ens137x: gameport"))
 				break;
 		if (io_port > 0x218) {
-			printk(KERN_WARNING "ens137x: no gameport ports available\n");
+			dev_warn(ensoniq->card->dev,
+				 "no gameport ports available\n");
 			return -EBUSY;
 		}
 		break;
 
 	default:
 		if (!request_region(io_port, 8, "ens137x: gameport")) {
-			printk(KERN_WARNING "ens137x: gameport io port %#x in use\n",
+			dev_warn(ensoniq->card->dev,
+				 "gameport io port %#x in use\n",
 			       io_port);
 			return -EBUSY;
 		}
@@ -1851,7 +1854,8 @@ static int snd_ensoniq_create_gameport(struct ensoniq *ensoniq, int dev)
 
 	ensoniq->gameport = gp = gameport_allocate_port();
 	if (!gp) {
-		printk(KERN_ERR "ens137x: cannot allocate memory for gameport\n");
+		dev_err(ensoniq->card->dev,
+			"cannot allocate memory for gameport\n");
 		release_region(io_port, 8);
 		return -ENOMEM;
 	}
@@ -2082,8 +2086,7 @@ static int snd_ensoniq_resume(struct device *dev)
 	pci_set_power_state(pci, PCI_D0);
 	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
-		printk(KERN_ERR DRIVER_NAME ": pci_enable_device failed, "
-		       "disabling device\n");
+		dev_err(dev, "pci_enable_device failed, disabling device\n");
 		snd_card_disconnect(card);
 		return -EIO;
 	}
@@ -2137,7 +2140,7 @@ static int snd_ensoniq_create(struct snd_card *card,
 	ensoniq->port = pci_resource_start(pci, 0);
 	if (request_irq(pci->irq, snd_audiopci_interrupt, IRQF_SHARED,
 			KBUILD_MODNAME, ensoniq)) {
-		snd_printk(KERN_ERR "unable to grab IRQ %d\n", pci->irq);
+		dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 		snd_ensoniq_free(ensoniq);
 		return -EBUSY;
 	}
@@ -2145,7 +2148,7 @@ static int snd_ensoniq_create(struct snd_card *card,
 #ifdef CHIP1370
 	if (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci),
 				16, &ensoniq->dma_bug) < 0) {
-		snd_printk(KERN_ERR "unable to allocate space for phantom area - dma_bug\n");
+		dev_err(card->dev, "unable to allocate space for phantom area - dma_bug\n");
 		snd_ensoniq_free(ensoniq);
 		return -EBUSY;
 	}
-- 
1.9.0
