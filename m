From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: sgalaxy
Date: Thu, 01 Mar 2007 16:53:10 +0100
Message-ID: <45E6F6E6.20406@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020309020700000309080806"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020309020700000309080806
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

===
sgalaxy: port to isa_bus infrastructure

Signed-of-by: Rene Herman <rene.herman@gmail.com>
===

Has been tested and again works same as before. Which, again, is to say 
not quite right. When you load the driver, the card starts emitting a 
very loud "hum". It seems to be working otherwise, but it's hard to say 
for sure; the hum literally is so loud that you can't hear anything else.

I'll debug that later; sgalaxy is a thin layer around ad1848-lib and 
given that normal ad1848 works fine, this should not be very hard to 
track down. The fix is going to make for a different patch anyway 
though, so thought I'd submit this one now.

This driver, like sb8 did, only did auto-probing halfways. It required 
the port values to be passed in and then allocated an IRQ and DMA 
channel itself. This again mandates those being passed in manually as 
well. Also again: if you insist, I'll add back the probes instead.

Rene.


--------------020309020700000309080806
Content-Type: text/plain;
 name="sgalaxy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sgalaxy.diff"

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
diff --git a/sound/isa/sgalaxy.c b/sound/isa/sgalaxy.c
index 4fcd0f4..91b61e7 100644
--- a/sound/isa/sgalaxy.c
+++ b/sound/isa/sgalaxy.c
@@ -24,7 +24,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/interrupt.h>
@@ -34,12 +34,13 @@ #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/ad1848.h>
 #include <sound/control.h>
-#define SNDRV_LEGACY_FIND_FREE_IRQ
-#define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
+#define CRD_NAME "Aztech Sound Galaxy"
+#define DEV_NAME "sgalaxy"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Christopher Butler <chrisb@sandy.force9.co.uk>");
-MODULE_DESCRIPTION("Aztech Sound Galaxy");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Aztech Systems,Sound Galaxy}}");
 
@@ -52,35 +53,51 @@ static int irq[SNDRV_CARDS] = SNDRV_DEFA
 static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for Sound Galaxy soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for Sound Galaxy soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(sbport, long, NULL, 0444);
-MODULE_PARM_DESC(sbport, "Port # for Sound Galaxy SB driver.");
+MODULE_PARM_DESC(sbport, "Port # for " CRD_NAME " SB driver.");
 module_param_array(wssport, long, NULL, 0444);
-MODULE_PARM_DESC(wssport, "Port # for Sound Galaxy WSS driver.");
+MODULE_PARM_DESC(wssport, "Port # for " CRD_NAME " WSS driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for Sound Galaxy driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "DMA1 # for Sound Galaxy driver.");
+MODULE_PARM_DESC(dma1, "DMA1 # for " CRD_NAME " driver.");
 
-static struct platform_device *devices[SNDRV_CARDS];
+static int __devinit snd_sgalaxy_match(struct device *dev, unsigned int n)
+{
+	if (!enable[n])
+		return 0;
+
+	if (sbport[n] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify sbport\n", dev->bus_id);
+		return 0;
+	}
+	if (wssport[n] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify wssport\n", dev->bus_id);
+		return 0;
+	}
+	if (irq[n] == SNDRV_AUTO_IRQ) {
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		return 0;
+	}
+	if (dma1[n] == SNDRV_AUTO_DMA) {
+		snd_printk(KERN_ERR "%s: please specify dma1\n", dev->bus_id);
+		return 0;
+	}
+	return 1;
+}
 
 #define SGALAXY_AUXC_LEFT 18
 #define SGALAXY_AUXC_RIGHT 19
 
-#define PFX	"sgalaxy: "
-
-/*
-
- */
-
 #define AD1848P1( port, x ) ( port + c_d_c_AD1848##x )
 
 /* from lowlevel/sb/sb.c - to avoid having to allocate a struct snd_sb for the */
 /* short time we actually need it.. */
 
-static int snd_sgalaxy_sbdsp_reset(unsigned long port)
+static int __devinit snd_sgalaxy_sbdsp_reset(unsigned long port)
 {
 	int i;
 
@@ -96,7 +113,7 @@ static int snd_sgalaxy_sbdsp_reset(unsig
 	return 0;
 }
 
-static int __init snd_sgalaxy_sbdsp_command(unsigned long port, unsigned char val)
+static int __devinit snd_sgalaxy_sbdsp_command(unsigned long port, unsigned char val)
 {
 	int i;
        	
@@ -114,67 +131,67 @@ static irqreturn_t snd_sgalaxy_dummy_int
 	return IRQ_NONE;
 }
 
-static int __init snd_sgalaxy_setup_wss(unsigned long port, int irq, int dma)
+static int __devinit snd_sgalaxy_detect(struct device *dev, unsigned int n)
 {
 	static int interrupt_bits[] = {-1, -1, -1, -1, -1, -1, -1, 0x08, -1, 
 				       0x10, 0x18, 0x20, -1, -1, -1, -1};
 	static int dma_bits[] = {1, 2, 0, 3};
-	int tmp, tmp1;
+	int tmp;
 
-	if ((tmp = inb(port + 3)) == 0xff)
-	{
-		snd_printdd("I/O address dead (0x%lx)\n", port);
+#if 0
+	snd_printdd("%s: switching to WSS mode\n", dev->bus_id);
+#endif
+
+	/* switch to WSS mode */
+	snd_sgalaxy_sbdsp_reset(sbport[n]);
+
+	snd_sgalaxy_sbdsp_command(sbport[n], 9);
+	snd_sgalaxy_sbdsp_command(sbport[n], 0);
+
+	udelay(400);
+
+	tmp = inb(wssport[n] + 3);
+	if (tmp == 0xff) {
+		snd_printdd("I/O address dead (%#lx)\n", wssport[n]);
 		return 0;
 	}
+
 #if 0
-	snd_printdd("WSS signature = 0x%x\n", tmp);
+	snd_printdd("%s: WSS signature = %#x\n", dev->bus_id, tmp);
 #endif
 
-        if ((tmp & 0x3f) != 0x04 &&
-            (tmp & 0x3f) != 0x0f &&
-            (tmp & 0x3f) != 0x00) {
-		snd_printdd("No WSS signature detected on port 0x%lx\n",
-			    port + 3);
+	tmp &= 0x3f;
+        if (tmp != 0x04 && tmp != 0x0f && tmp != 0x00) {
+		snd_printdd("%s: No WSS signature detected on port %#lx\n",
+			dev->bus_id, wssport[n] + 3);	
 		return 0;
 	}
 
 #if 0
-	snd_printdd(PFX "setting up IRQ/DMA for WSS\n");
+	snd_printdd("%s: setting up IRQ/DMA for WSS\n", dev->bus_id);
 #endif
 
         /* initialize IRQ for WSS codec */
-        tmp = interrupt_bits[irq % 16];
+        tmp = interrupt_bits[irq[n] % 16];
         if (tmp < 0)
                 return -EINVAL;
 
-	if (request_irq(irq, snd_sgalaxy_dummy_interrupt, IRQF_DISABLED, "sgalaxy", NULL)) {
-		snd_printk(KERN_ERR "sgalaxy: can't grab irq %d\n", irq);
+	if (request_irq(irq[n], snd_sgalaxy_dummy_interrupt, IRQF_DISABLED,
+			"sgalaxy", NULL)) {
+		snd_printk(KERN_ERR "%s: can't grab irq %d\n", dev->bus_id,
+			irq[n]);
 		return -EIO;
 	}
 
-        outb(tmp | 0x40, port);
-        tmp1 = dma_bits[dma % 4];
-        outb(tmp | tmp1, port);
+	tmp |= 0x40;
+	outb(tmp, wssport[n]);
 
-	free_irq(irq, NULL);
-
-	return 0;
-}
-
-static int __init snd_sgalaxy_detect(int dev, int irq, int dma)
-{
-#if 0
-	snd_printdd(PFX "switching to WSS mode\n");
-#endif
-
-	/* switch to WSS mode */
-	snd_sgalaxy_sbdsp_reset(sbport[dev]);
+	tmp |= dma_bits[dma1[n] % 4];
+        outb(tmp, wssport[n]);
 
-	snd_sgalaxy_sbdsp_command(sbport[dev], 9);
-	snd_sgalaxy_sbdsp_command(sbport[dev], 0);
+	free_irq(irq[n], NULL);
 
-	udelay(400);
-	return snd_sgalaxy_setup_wss(wssport[dev], irq, dma);
+	return 0;
 }
 
 static struct ad1848_mix_elem snd_sgalaxy_controls[] = {
@@ -182,131 +199,116 @@ AD1848_DOUBLE("Aux Playback Switch", 0, 
 AD1848_DOUBLE("Aux Playback Volume", 0, SGALAXY_AUXC_LEFT, SGALAXY_AUXC_RIGHT, 0, 0, 31, 0)
 };
 
-static int __init snd_sgalaxy_mixer(struct snd_ad1848 *chip)
+static int __devinit snd_sgalaxy_mixer(struct snd_ad1848 *chip)
 {
 	struct snd_card *card = chip->card;
 	struct snd_ctl_elem_id id1, id2;
-	unsigned int idx;
-	int err;
+	int error, i;
 
 	memset(&id1, 0, sizeof(id1));
 	memset(&id2, 0, sizeof(id2));
+
 	id1.iface = id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+
 	/* reassign AUX0 to LINE */
 	strcpy(id1.name, "Aux Playback Switch");
 	strcpy(id2.name, "Line Playback Switch");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
+	error = snd_ctl_rename_id(card, &id1, &id2);
+	if (error < 0)
+		return error;
+
 	strcpy(id1.name, "Aux Playback Volume");
 	strcpy(id2.name, "Line Playback Volume");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
+	error = snd_ctl_rename_id(card, &id1, &id2);
+	if (error < 0)
+		return error;
+
 	/* reassign AUX1 to FM */
-	strcpy(id1.name, "Aux Playback Switch"); id1.index = 1;
+	id1.index = 1;
+
+	strcpy(id1.name, "Aux Playback Switch");
 	strcpy(id2.name, "FM Playback Switch");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
+	error = snd_ctl_rename_id(card, &id1, &id2);
+	if (error < 0)
+		return error;
+
 	strcpy(id1.name, "Aux Playback Volume");
 	strcpy(id2.name, "FM Playback Volume");
-	if ((err = snd_ctl_rename_id(card, &id1, &id2)) < 0)
-		return err;
+	error = snd_ctl_rename_id(card, &id1, &id2);
+	if (error < 0)
+		return error;
+
 	/* build AUX2 input */
-	for (idx = 0; idx < ARRAY_SIZE(snd_sgalaxy_controls); idx++) {
-		if ((err = snd_ad1848_add_ctl_elem(chip, &snd_sgalaxy_controls[idx])) < 0)
-			return err;
+	for (i = 0; i < ARRAY_SIZE(snd_sgalaxy_controls); i++) {
+		error = snd_ad1848_add_ctl_elem(chip, &snd_sgalaxy_controls[i]);
+		if (error < 0)
+			return error;
 	}
 	return 0;
 }
 
-static int __init snd_sgalaxy_probe(struct platform_device *devptr)
+static int __devinit snd_sgalaxy_probe(struct device *dev, unsigned int n)
 {
-	int dev = devptr->id;
-	static int possible_irqs[] = {7, 9, 10, 11, -1};
-	static int possible_dmas[] = {1, 3, 0, -1};
-	int err, xirq, xdma1;
 	struct snd_card *card;
 	struct snd_ad1848 *chip;
+	int error;
 
-	if (sbport[dev] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR PFX "specify SB port\n");
-		return -EINVAL;
-	}
-	if (wssport[dev] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR PFX "specify WSS port\n");
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
 		return -EINVAL;
-	}
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
-
-	xirq = irq[dev];
-	if (xirq == SNDRV_AUTO_IRQ) {
-		if ((xirq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free IRQ\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
-	xdma1 = dma1[dev];
-        if (xdma1 == SNDRV_AUTO_DMA) {
-		if ((xdma1 = snd_legacy_find_free_dma(possible_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA\n");
-			err = -EBUSY;
-			goto _err;
-		}
-	}
 
-	if ((err = snd_sgalaxy_detect(dev, xirq, xdma1)) < 0)
-		goto _err;
+	error = snd_sgalaxy_detect(dev, n);
+	if (error < 0)
+		goto out;
+
+	error = snd_ad1848_create(card, wssport[n] + 4, irq[n], dma1[n],
+			AD1848_HW_DETECT, &chip);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_ad1848_create(card, wssport[dev] + 4,
-				     xirq, xdma1,
-				     AD1848_HW_DETECT, &chip)) < 0)
-		goto _err;
 	card->private_data = chip;
 
-	if ((err = snd_ad1848_pcm(chip, 0, NULL)) < 0) {
-		snd_printdd(PFX "error creating new ad1848 PCM device\n");
-		goto _err;
-	}
-	if ((err = snd_ad1848_mixer(chip)) < 0) {
-		snd_printdd(PFX "error creating new ad1848 mixer\n");
-		goto _err;
-	}
-	if ((err = snd_sgalaxy_mixer(chip)) < 0) {
-		snd_printdd(PFX "the mixer rewrite failed\n");
-		goto _err;
-	}
+	error = snd_ad1848_pcm(chip, 0, NULL);
+	if (error < 0)
+		goto out;
+
+	error = snd_ad1848_mixer(chip);
+	if (error < 0) 
+		goto out;
+
+	error = snd_sgalaxy_mixer(chip);
+	if (error < 0) 
+		goto out;
 
 	strcpy(card->driver, "Sound Galaxy");
 	strcpy(card->shortname, "Sound Galaxy");
-	sprintf(card->longname, "Sound Galaxy at 0x%lx, irq %d, dma %d",
-		wssport[dev], xirq, xdma1);
+	sprintf(card->longname, "Sound Galaxy at %#lx, irq %d, dma %d",
+		wssport[n], irq[n], dma1[n]);
 
-	snd_card_set_dev(card, &devptr->dev);
+	snd_card_set_dev(card, dev);
 
-	if ((err = snd_card_register(card)) < 0)
-		goto _err;
+	error = snd_card_register(card);
+	if (error < 0)
+		goto out;
 
-	platform_set_drvdata(devptr, card);
+	dev_set_drvdata(dev, card);
 	return 0;
 
- _err:
-	snd_card_free(card);
-	return err;
+out:	snd_card_free(card);
+	return error;
 }
 
-static int __devexit snd_sgalaxy_remove(struct platform_device *devptr)
+static int __devexit snd_sgalaxy_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int snd_sgalaxy_suspend(struct platform_device *pdev, pm_message_t state)
+static int snd_sgalaxy_suspend(struct device *dev, unsigned int n, pm_message_t state)
 {
-	struct snd_card *card = platform_get_drvdata(pdev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ad1848 *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
@@ -314,9 +316,9 @@ static int snd_sgalaxy_suspend(struct pl
 	return 0;
 }
 
-static int snd_sgalaxy_resume(struct platform_device *pdev)
+static int snd_sgalaxy_resume(struct device *dev, unsigned int n)
 {
-	struct snd_card *card = platform_get_drvdata(pdev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ad1848 *chip = card->private_data;
 
 	chip->resume(chip);
@@ -328,9 +330,8 @@ static int snd_sgalaxy_resume(struct pla
 }
 #endif
 
-#define SND_SGALAXY_DRIVER	"snd_sgalaxy"
-
-static struct platform_driver snd_sgalaxy_driver = {
+static struct isa_driver snd_sgalaxy_driver = {
+	.match		= snd_sgalaxy_match,
 	.probe		= snd_sgalaxy_probe,
 	.remove		= __devexit_p(snd_sgalaxy_remove),
 #ifdef CONFIG_PM
@@ -338,57 +339,19 @@ #ifdef CONFIG_PM
 	.resume		= snd_sgalaxy_resume,
 #endif
 	.driver		= {
-		.name	= SND_SGALAXY_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_sgalaxy_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_sgalaxy_driver);
-}
-
 static int __init alsa_card_sgalaxy_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_sgalaxy_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(SND_SGALAXY_DRIVER,
-							 i, NULL, 0);
-		if (IS_ERR(device))
-			continue;
-		if (!platform_get_drvdata(device)) {
-			platform_device_unregister(device);
-			continue;
-		}
-		devices[i] = device;
-		cards++;
-	}
-	if (!cards) {
-#ifdef MODULE
-		snd_printk(KERN_ERR "Sound Galaxy soundcard not found or device busy\n");
-#endif
-		snd_sgalaxy_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_sgalaxy_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_sgalaxy_exit(void)
 {
-	snd_sgalaxy_unregister_all();
+	isa_unregister_driver(&snd_sgalaxy_driver);
 }
 
-module_init(alsa_card_sgalaxy_init)
-module_exit(alsa_card_sgalaxy_exit)
+module_init(alsa_card_sgalaxy_init);
+module_exit(alsa_card_sgalaxy_exit);

--------------020309020700000309080806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020309020700000309080806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020309020700000309080806--
