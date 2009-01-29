From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cmi8330: add MPU-401 support
Date: Thu, 29 Jan 2009 11:48:14 +0100
Message-ID: <20090129114814.c7ba4003.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id DE9F110386B
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 11:44:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add MPU-401 port support for the chip.
Also, update some error messages and description.

---
 sound/isa/Kconfig   |    1 +
 sound/isa/cmi8330.c |   42 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index 7d80186..ed798bf 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -95,6 +95,7 @@ config SND_CMI8330
 	select SND_WSS_LIB
 	select SND_SB16_DSP
 	select SND_OPL3_LIB
+	select SND_MPU401_UART
 	help
 	  Say Y here to include support for soundcards based on the
 	  C-Media CMI8330 chip.
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index 1154379..9ca8122 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -31,11 +31,11 @@
  *  To quickly load the module,
  *
  *  modprobe -a snd-cmi8330 sbport=0x220 sbirq=5 sbdma8=1
- *    sbdma16=5 wssport=0x530 wssirq=11 wssdma=0
+ *    sbdma16=5 wssport=0x530 wssirq=11 wssdma=0 fmport=0x388
  *
  *  This card has two mixers and two PCM devices.  I've cheesed it such
  *  that recording and playback can be done through the same device.
- *  The driver "magically" routes the capturing to the AD1848 codec,
+ *  The driver "magically" routes the capturing to the CMI8330 codec,
  *  and playback to the SB16 codec.  This allows for full-duplex mode
  *  to some extent.
  *  The utilities in alsa-utils are aware of both devices, so passing
@@ -52,6 +52,7 @@
 #include <sound/core.h>
 #include <sound/wss.h>
 #include <sound/opl3.h>
+#include <sound/mpu401.h>
 #include <sound/sb.h>
 #include <sound/initval.h>
 
@@ -81,6 +82,8 @@ static long wssport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
 static int wssirq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 static int wssdma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;
 static long fmport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static long mpuport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;
+static int mpuirq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;
 
 module_param_array(index, int, NULL, 0444);
 MODULE_PARM_DESC(index, "Index value for CMI8330 soundcard.");
@@ -111,6 +114,10 @@ MODULE_PARM_DESC(wssdma, "DMA for CMI8330 WSS driver.");
 
 module_param_array(fmport, long, NULL, 0444);
 MODULE_PARM_DESC(fmport, "FM port # for CMI8330 driver.");
+module_param_array(mpuport, long, NULL, 0444);
+MODULE_PARM_DESC(mpuport, "MPU-401 port # for CMI8330 driver.");
+module_param_array(mpuirq, int, NULL, 0444);
+MODULE_PARM_DESC(mpuirq, "IRQ # for CMI8330 MPU-401 port.");
 #ifdef CONFIG_PNP
 static int isa_registered;
 static int pnp_registered;
@@ -153,6 +160,7 @@ struct snd_cmi8330 {
 #ifdef CONFIG_PNP
 	struct pnp_dev *cap;
 	struct pnp_dev *play;
+	struct pnp_dev *mpu;
 #endif
 	struct snd_card *card;
 	struct snd_wss *wss;
@@ -169,7 +177,7 @@ struct snd_cmi8330 {
 #ifdef CONFIG_PNP
 
 static struct pnp_card_device_id snd_cmi8330_pnpids[] = {
-	{ .id = "CMI0001", .devs = { { "@@@0001" }, { "@X@0001" } } },
+	{ .id = "CMI0001", .devs = { { "@@@0001" }, { "@X@0001" }, { "@H@0001" } } },
 	{ .id = "" }
 };
 
@@ -329,11 +337,15 @@ static int __devinit snd_cmi8330_pnp(int dev, struct snd_cmi8330 *acard,
 	if (acard->play == NULL)
 		return -EBUSY;
 
+	acard->mpu = pnp_request_card_device(card, id->devs[2].id, NULL);
+	if (acard->play == NULL)
+		return -EBUSY;
+
 	pdev = acard->cap;
 
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
-		snd_printk(KERN_ERR "CMI8330/C3D (AD1848) PnP configure failure\n");
+		snd_printk(KERN_ERR "CMI8330/C3D PnP configure failure\n");
 		return -EBUSY;
 	}
 	wssport[dev] = pnp_port_start(pdev, 0);
@@ -354,6 +366,17 @@ static int __devinit snd_cmi8330_pnp(int dev, struct snd_cmi8330 *acard,
 	sbdma16[dev] = pnp_dma(pdev, 1);
 	sbirq[dev] = pnp_irq(pdev, 0);
 
+	/* allocate MPU-401 resources */
+	pdev = acard->mpu;
+
+	err = pnp_activate_dev(pdev);
+	if (err < 0) {
+		snd_printk(KERN_ERR
+			   "CMI8330/C3D (MPU-401) PnP configure failure\n");
+		return -EBUSY;
+	}
+	mpuport[dev] = pnp_port_start(pdev, 0);
+	mpuirq[dev] = pnp_irq(pdev, 0);
 	return 0;
 }
 #endif
@@ -502,11 +525,11 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 			     wssdma[dev], -1,
 			     WSS_HW_DETECT, 0, &acard->wss);
 	if (err < 0) {
-		snd_printk(KERN_ERR PFX "(AD1848) device busy??\n");
+		snd_printk(KERN_ERR PFX "(CMI8330) device busy??\n");
 		return err;
 	}
 	if (acard->wss->hardware != WSS_HW_CMI8330) {
-		snd_printk(KERN_ERR PFX "(AD1848) not found during probe\n");
+		snd_printk(KERN_ERR PFX "(CMI8330) not found during probe\n");
 		return -ENODEV;
 	}
 
@@ -552,6 +575,13 @@ static int __devinit snd_cmi8330_probe(struct snd_card *card, int dev)
 		}
 	}
 
+	if (mpuport[dev] != SNDRV_AUTO_PORT) {
+		if (snd_mpu401_uart_new(card, 0, MPU401_HW_MPU401,
+					mpuport[dev], 0, mpuirq[dev],
+					IRQF_DISABLED, NULL) < 0)
+			printk(KERN_ERR PFX "no MPU-401 device at 0x%lx.\n",
+				mpuport[dev]);
+	}
 
 	strcpy(card->driver, "CMI8330/C3D");
 	strcpy(card->shortname, "C-Media CMI8330/C3D");
-- 
1.5.2.2


----------------------------------------------------------------------
Obdaruj swoja Walentynke ... lub siebie!
Wygraj nagrody! Sprawdz >> http://link.interia.pl/f203a 
