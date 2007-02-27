From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: sb8
Date: Tue, 27 Feb 2007 22:30:29 +0100
Message-ID: <45E4A2F5.3080607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050409090805090408070404"
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
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050409090805090408070404
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

===
sb8:  port to isa_bus infrastructure.

Signed-of-by: Rene Herman <rene.herman@gmail.com>
===

Hi, you probably noticed I'm doing the "old isa only" (as opposed to 
isa-pnp) first and that I was at GUS -- have skipped GUS Max for the 
moment since I was offered a card (and like to test the drivers) but 
that person is for the moment not getting back to me.

1. sb8 only probed for it's port, and then failed the load with "can't 
grab irq 65535". This does away with the port autoprobe as well; if you 
insist, I can add back irq and dma autoprobe instead as well.

2. I wanted to do away with the "X chip detected, try snd-x instead" 
failure-modes. For example a cs4236 can be driven by lesser drivers such 
as ad1848 and cs4231 as well which is useful at least for debugging.

However, when I tried driving an SB16 with the SB8 driver, it didn't 
actually work. Would you happen to know/remember if this is expected? Or 
is it a "bug"?

Has been tested with a SB Pro, and works great. Has also been tested 
with a couple of SB 2.1's and while those to seem to have a problem 
(inability to set the volumes to anything other than max and probably 
related, a rather disturbed sound reproduction) that's not a difference 
with the original. As said, also tested with an SB16 for which both 
original and this do not work.

Rene.


--------------050409090805090408070404
Content-Type: text/plain;
 name="sb8.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sb8.diff"

diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index 268ebd3..bdc6fb6 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -22,7 +22,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/moduleparam.h>
@@ -31,8 +31,11 @@ #include <sound/sb.h>
 #include <sound/opl3.h>
 #include <sound/initval.h>
 
+#define CRD_NAME "Sound Blaster 1.0/2.0/Pro"
+#define DEV_NAME "sb8"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
-MODULE_DESCRIPTION("Sound Blaster 1.0/2.0/Pro");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB 1.0/SB 2.0/SB Pro}}");
 
@@ -44,166 +47,168 @@ static int irq[SNDRV_CARDS] = SNDRV_DEFA
 static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 1,3 */
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for Sound Blaster soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for Sound Blaster soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable Sound Blaster soundcard.");
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for SB8 driver.");
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for SB8 driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(dma8, int, NULL, 0444);
-MODULE_PARM_DESC(dma8, "8-bit DMA # for SB8 driver.");
-
-static struct platform_device *devices[SNDRV_CARDS];
+MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
 
 struct snd_sb8 {
-	struct resource *fm_res;	/* used to block FM i/o region for legacy cards */
+	struct resource *fm_res; /* used to block FM region for legacy cards */
 	struct snd_sb *chip;
 };
 
+static int __devinit snd_sb8_match(struct device *dev, unsigned int n)
+{
+	if (!enable[n])
+		return 0;
+
+	if (port[n] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		return 0;
+	}
+	if (irq[n] == SNDRV_AUTO_IRQ) {
+		snd_printk(KERN_ERR "%s: please specify irq\n", dev->bus_id);
+		return 0;
+	}
+	if (dma8[n] == SNDRV_AUTO_DMA) {
+		snd_printk(KERN_ERR "%s: please specify dma8\n", dev->bus_id);
+		return 0;
+	}
+	return 1;
+}
+
 static irqreturn_t snd_sb8_interrupt(int irq, void *dev_id)
 {
 	struct snd_sb *chip = dev_id;
 
-	if (chip->open & SB_OPEN_PCM) {
+	if (chip->open & SB_OPEN_PCM)
 		return snd_sb8dsp_interrupt(chip);
-	} else {
-		return snd_sb8dsp_midi_interrupt(chip);
-	}
+
+	return snd_sb8dsp_midi_interrupt(chip);
 }
 
 static void snd_sb8_free(struct snd_card *card)
 {
-	struct snd_sb8 *acard = (struct snd_sb8 *)card->private_data;
+	struct snd_sb8 *acard = card->private_data;
 
-	if (acard == NULL)
-		return;
 	release_and_free_resource(acard->fm_res);
 }
 
-static int __init snd_sb8_probe(struct platform_device *pdev)
+static int __init snd_sb8_probe(struct device *dev, unsigned int n)
 {
-	int dev = pdev->id;
 	struct snd_sb *chip;
 	struct snd_card *card;
 	struct snd_sb8 *acard;
 	struct snd_opl3 *opl3;
-	int err;
+	int error;
+
+	card = snd_card_new(index[n], id[n], THIS_MODULE, sizeof *acard);
+	if (!card)
+		return -EINVAL;
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE,
-			    sizeof(struct snd_sb8));
-	if (card == NULL)
-		return -ENOMEM;
 	acard = card->private_data;
-	card->private_free = snd_sb8_free;
 
 	/* block the 0x388 port to avoid PnP conflicts */
 	acard->fm_res = request_region(0x388, 4, "SoundBlaster FM");
 
-	if (port[dev] != SNDRV_AUTO_PORT) {
-		if ((err = snd_sbdsp_create(card, port[dev], irq[dev],
-					    snd_sb8_interrupt,
-					    dma8[dev],
-					    -1,
-					    SB_HW_AUTO,
-					    &chip)) < 0)
-			goto _err;
-	} else {
-		/* auto-probe legacy ports */
-		static unsigned long possible_ports[] = {
-			0x220, 0x240, 0x260,
-		};
-		int i;
-		for (i = 0; i < ARRAY_SIZE(possible_ports); i++) {
-			err = snd_sbdsp_create(card, possible_ports[i],
-					       irq[dev],
-					       snd_sb8_interrupt,
-					       dma8[dev],
-					       -1,
-					       SB_HW_AUTO,
-					       &chip);
-			if (err >= 0) {
-				port[dev] = possible_ports[i];
-				break;
-			}
-		}
-		if (i >= ARRAY_SIZE(possible_ports))
-			goto _err;
-	}
+	card->private_free = snd_sb8_free;
+
+	error = snd_sbdsp_create(card, port[n], irq[n], snd_sb8_interrupt,
+			dma8[n], -1, SB_HW_AUTO, &chip);
+	if (error < 0)
+		goto out;
+
 	acard->chip = chip;
-			
-	if (chip->hardware >= SB_HW_16) {
-		if (chip->hardware == SB_HW_ALS100)
-			snd_printk(KERN_WARNING "ALS100 chip detected at 0x%lx, try snd-als100 module\n",
-				    port[dev]);
-		else
-			snd_printk(KERN_WARNING "SB 16 chip detected at 0x%lx, try snd-sb16 module\n",
-				   port[dev]);
-		err = -ENODEV;
-		goto _err;
-	}
 
-	if ((err = snd_sb8dsp_pcm(chip, 0, NULL)) < 0)
-		goto _err;
+	error = -ENODEV;
+
+	switch (chip->hardware) {
+	case SB_HW_DT019X:
+		snd_printk(KERN_WARNING "%s: DT-019x/ALS007 chip detected at "
+			"%#lx, try snd-dt019x module\n", dev->bus_id, port[n]);
+		goto out;
+	
+	case SB_HW_ALS100:
+		snd_printk(KERN_WARNING "%s: ALS100 chip detected at "
+			"%#lx, try snd-als100 module\n", dev->bus_id, port[n]);
+		goto out;
+	
+	default:
+		if (chip->hardware <= SB_HW_PRO)
+			break;
+
+		snd_printk(KERN_WARNING "%s: SB 16 chip detected at "
+			"%#lx, try snd-sb16 module\n", dev->bus_id, port[n]);
+		goto out;
+	}
+	
+	error = snd_sb8dsp_pcm(chip, 0, NULL);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_sbmixer_new(chip)) < 0)
-		goto _err;
+	error = snd_sbmixer_new(chip);
+	if (error < 0)
+		goto out;
 
 	if (chip->hardware == SB_HW_10 || chip->hardware == SB_HW_20) {
-		if ((err = snd_opl3_create(card, chip->port + 8, 0,
-					   OPL3_HW_AUTO, 1,
-					   &opl3)) < 0) {
-			snd_printk(KERN_WARNING "sb8: no OPL device at 0x%lx\n", chip->port + 8);
-		}
+		error = snd_opl3_create(card, chip->port + 8, 0,
+				OPL3_HW_AUTO, 1, &opl3);
+		if (error < 0)
+			snd_printk(KERN_WARNING "%s: no OPL device at %#lx\n",
+				dev->bus_id, chip->port + 8);
 	} else {
-		if ((err = snd_opl3_create(card, chip->port, chip->port + 2,
-					   OPL3_HW_AUTO, 1,
-					   &opl3)) < 0) {
-			snd_printk(KERN_WARNING "sb8: no OPL device at 0x%lx-0x%lx\n",
-				   chip->port, chip->port + 2);
-		}
+		error = snd_opl3_create(card, chip->port, chip->port + 2,
+				OPL3_HW_AUTO, 1, &opl3);
+		if (error < 0)
+			snd_printk(KERN_WARNING "%s: no OPL device at %#lx-%#lx\n",
+				dev->bus_id, chip->port, chip->port + 2);
 	}
-	if (err >= 0) {
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0)
-			goto _err;
+	if (error >= 0) {
+		error = snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (error < 0)
+			goto out;
 	}
 
-	if ((err = snd_sb8dsp_midi(chip, 0, NULL)) < 0)
-		goto _err;
+	error = snd_sb8dsp_midi(chip, 0, NULL);
+	if (error < 0)
+		goto out;
 
 	strcpy(card->driver, chip->hardware == SB_HW_PRO ? "SB Pro" : "SB8");
 	strcpy(card->shortname, chip->name);
-	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		chip->name,
-		chip->port,
-		irq[dev], dma8[dev]);
+	sprintf(card->longname, "%s at %#lx, irq %d, dma %d", chip->name,
+		chip->port, chip->irq, chip->dma8);
 
-	snd_card_set_dev(card, &pdev->dev);
+	snd_card_set_dev(card, dev);
 
-	if ((err = snd_card_register(card)) < 0)
-		goto _err;
+	error = snd_card_register(card);
+	if (error < 0)
+		goto out;
 
-	platform_set_drvdata(pdev, card);
+	dev_set_drvdata(dev, card);
 	return 0;
 
- _err:
-	snd_card_free(card);
-	return err;
+out:	snd_card_free(card);
+	return error;
 }
 
-static int snd_sb8_remove(struct platform_device *pdev)
+static int snd_sb8_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(pdev));
-	platform_set_drvdata(pdev, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int snd_sb8_suspend(struct platform_device *dev, pm_message_t state)
+static int snd_sb8_suspend(struct device *dev, unsigned int n, pm_message_t state)
 {
-	struct snd_card *card = platform_get_drvdata(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_sb8 *acard = card->private_data;
 	struct snd_sb *chip = acard->chip;
 
@@ -213,9 +218,9 @@ static int snd_sb8_suspend(struct platfo
 	return 0;
 }
 
-static int snd_sb8_resume(struct platform_device *dev)
+static int snd_sb8_resume(struct device *dev, unsigned int n)
 {
-	struct snd_card *card = platform_get_drvdata(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_sb8 *acard = card->private_data;
 	struct snd_sb *chip = acard->chip;
 
@@ -226,9 +231,8 @@ static int snd_sb8_resume(struct platfor
 }
 #endif
 
-#define SND_SB8_DRIVER	"snd_sb8"
-
-static struct platform_driver snd_sb8_driver = {
+static struct isa_driver snd_sb8_driver = {
+	.match		= snd_sb8_match,
 	.probe		= snd_sb8_probe,
 	.remove		= snd_sb8_remove,
 #ifdef CONFIG_PM
@@ -236,57 +240,19 @@ #ifdef CONFIG_PM
 	.resume		= snd_sb8_resume,
 #endif
 	.driver		= {
-		.name	= SND_SB8_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_sb8_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_sb8_driver);
-}
-
 static int __init alsa_card_sb8_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_sb8_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(SND_SB8_DRIVER,
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
-		snd_printk(KERN_ERR "Sound Blaster soundcard not found or device busy\n");
-#endif
-		snd_sb8_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_sb8_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_sb8_exit(void)
 {
-	snd_sb8_unregister_all();
+	isa_unregister_driver(&snd_sb8_driver);
 }
 
-module_init(alsa_card_sb8_init)
-module_exit(alsa_card_sb8_exit)
+module_init(alsa_card_sb8_init);
+module_exit(alsa_card_sb8_exit);

--------------050409090805090408070404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050409090805090408070404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------050409090805090408070404--
