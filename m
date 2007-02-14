From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: es1688
Date: Wed, 14 Feb 2007 08:26:19 +0100
Message-ID: <45D2B99B.7000706@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010902010407090208070704"
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
--------------010902010407090208070704
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

es1688: port to isa_bus infrastructure. very slight reorganization of 
the auto-probe code to be a bit easier on the eye (if not the senses).

Signed-off-by: Rene Herman <rene.herman@gmail.com>

Rene.

--------------010902010407090208070704
Content-Type: text/plain;
 name="es1688.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="es1688.diff"

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 7f29f56..f7d0c5f 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -22,7 +22,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
@@ -35,8 +35,11 @@ #define SNDRV_LEGACY_FIND_FREE_IRQ
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
+#define CRD_NAME "Generic ESS ES1688/ES688 AudioDrive"
+#define DEV_NAME "es1688"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
-MODULE_DESCRIPTION("ESS ESx688 AudioDrive");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESS,ES688 PnP AudioDrive,pnp:ESS0100},"
 	        "{ESS,ES1688 PnP AudioDrive,pnp:ESS0102},"
@@ -53,189 +56,143 @@ static int mpu_irq[SNDRV_CARDS] = SNDRV_
 static int dma8[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3 */
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for ESx688 soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for ESx688 soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable ESx688 soundcard.");
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for ESx688 driver.");
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for ESx688 driver.");
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for ESx688 driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for ESx688 driver.");
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
 module_param_array(dma8, int, NULL, 0444);
-MODULE_PARM_DESC(dma8, "8-bit DMA # for ESx688 driver.");
-
-static struct platform_device *devices[SNDRV_CARDS];
+MODULE_PARM_DESC(dma8, "8-bit DMA # for " CRD_NAME " driver.");
 
-#define PFX	"es1688: "
+static int __devinit snd_es1688_match(struct device *dev, unsigned int n)
+{
+	return enable[n];
+}
 
-static int __init snd_es1688_probe(struct platform_device *pdev)
+static int __devinit snd_es1688_probe(struct device *dev, unsigned int n)
 {
-	int dev = pdev->id;
+	static unsigned long possible_ports[] = {0x220, 0x240, 0x260};
 	static int possible_irqs[] = {5, 9, 10, 7, -1};
 	static int possible_dmas[] = {1, 3, 0, -1};
-	int xirq, xdma, xmpu_irq;
+	int i, xirq, xdma;
+
 	struct snd_card *card;
 	struct snd_es1688 *chip;
 	struct snd_opl3 *opl3;
 	struct snd_pcm *pcm;
-	int err;
+	int error;
+
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
+		return -EINVAL;
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
+	error = -EBUSY;
 
-	xirq = irq[dev];
+	xirq = irq[n];
 	if (xirq == SNDRV_AUTO_IRQ) {
-		if ((xirq = snd_legacy_find_free_irq(possible_irqs)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free IRQ\n");
-			err = -EBUSY;
-			goto _err;
+		xirq = snd_legacy_find_free_irq(possible_irqs);
+		if (xirq < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free IRQ\n", dev->bus_id);
+			goto out;
 		}
 	}
-	xmpu_irq = mpu_irq[dev];
-	xdma = dma8[dev];
+
+	xdma = dma8[n];
 	if (xdma == SNDRV_AUTO_DMA) {
-		if ((xdma = snd_legacy_find_free_dma(possible_dmas)) < 0) {
-			snd_printk(KERN_ERR PFX "unable to find a free DMA\n");
-			err = -EBUSY;
-			goto _err;
+		xdma = snd_legacy_find_free_dma(possible_dmas);
+		if (xdma < 0) {
+			snd_printk(KERN_ERR "%s: unable to find a free DMA\n", dev->bus_id);
+			goto out;
 		}
 	}
 
-	if (port[dev] != SNDRV_AUTO_PORT) {
-		if ((err = snd_es1688_create(card, port[dev], mpu_port[dev],
-					     xirq, xmpu_irq, xdma,
-					     ES1688_HW_AUTO, &chip)) < 0)
-			goto _err;
-	} else {
-		/* auto-probe legacy ports */
-		static unsigned long possible_ports[] = {
-			0x220, 0x240, 0x260,
-		};
-		int i;
-		for (i = 0; i < ARRAY_SIZE(possible_ports); i++) {
-			err = snd_es1688_create(card, possible_ports[i],
-						mpu_port[dev],
-						xirq, xmpu_irq, xdma,
-						ES1688_HW_AUTO, &chip);
-			if (err >= 0) {
-				port[dev] = possible_ports[i];
-				break;
-			}
-		}
-		if (i >= ARRAY_SIZE(possible_ports))
-			goto _err;
-	}
+	if (port[n] == SNDRV_AUTO_PORT)
+		for (i = 0; i < ARRAY_SIZE(possible_ports) && error < 0; i++)
+			error = snd_es1688_create(card, possible_ports[i], mpu_port[n],
+					xirq, mpu_irq[n], xdma, ES1688_HW_AUTO, &chip);
+	else
+		error = snd_es1688_create(card, port[n], mpu_port[n],
+				xirq, mpu_irq[n], xdma, ES1688_HW_AUTO, &chip);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_es1688_pcm(chip, 0, &pcm)) < 0)
-		goto _err;
+	error = snd_es1688_pcm(chip, 0, &pcm);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_es1688_mixer(chip)) < 0)
-		goto _err;
+	error = snd_es1688_mixer(chip);
+	if (error < 0)
+		goto out;
 
 	strcpy(card->driver, "ES1688");
 	strcpy(card->shortname, pcm->name);
 	sprintf(card->longname, "%s at 0x%lx, irq %i, dma %i", pcm->name, chip->port, xirq, xdma);
 
-	if ((snd_opl3_create(card, chip->port, chip->port + 2, OPL3_HW_OPL3, 0, &opl3)) < 0) {
-		printk(KERN_WARNING PFX "opl3 not detected at 0x%lx\n", chip->port);
-	} else {
-		if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0)
-			goto _err;
+	if (snd_opl3_create(card, chip->port, chip->port + 2, OPL3_HW_OPL3, 0, &opl3) < 0)
+		printk(KERN_WARNING "%s: opl3 not detected at 0x%lx\n", dev->bus_id, chip->port);
+	else {
+		error =	snd_opl3_hwdep_new(opl3, 0, 1, NULL);
+		if (error < 0)
+			goto out;
 	}
 
-	if (xmpu_irq >= 0 && xmpu_irq != SNDRV_AUTO_IRQ && chip->mpu_port > 0) {
-		if ((err = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688,
-					       chip->mpu_port, 0,
-					       xmpu_irq,
-					       IRQF_DISABLED,
-					       NULL)) < 0)
-			goto _err;
+	if (mpu_irq[n] >= 0 && mpu_irq[n] != SNDRV_AUTO_IRQ && chip->mpu_port > 0) {
+		error = snd_mpu401_uart_new(card, 0, MPU401_HW_ES1688, chip->mpu_port,
+				0, mpu_irq[n], IRQF_DISABLED, NULL);
+		if (error < 0)
+			goto out;
 	}
 
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
 
-static int snd_es1688_remove(struct platform_device *devptr)
+static int __devexit snd_es1688_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
-#define ES1688_DRIVER	"snd_es1688"
-
-static struct platform_driver snd_es1688_driver = {
+static struct isa_driver snd_es1688_driver = {
+	.match		= snd_es1688_match,
 	.probe		= snd_es1688_probe,
 	.remove		= snd_es1688_remove,
-	/* FIXME: suspend/resume */
+#if 0	/* FIXME */
+	.suspend	= snd_es1688_suspend,
+	.resume		= snd_es1688_resume,
+#endif
 	.driver		= {
-		.name	= ES1688_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_es1688_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_es1688_driver);
-}
-
 static int __init alsa_card_es1688_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_es1688_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(ES1688_DRIVER,
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
-		printk(KERN_ERR "ESS AudioDrive ES1688 soundcard not found or device busy\n");
-#endif
-		snd_es1688_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_es1688_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_es1688_exit(void)
 {
-	snd_es1688_unregister_all();
+	isa_unregister_driver(&snd_es1688_driver);
 }
 
-module_init(alsa_card_es1688_init)
-module_exit(alsa_card_es1688_exit)
+module_init(alsa_card_es1688_init);
+module_exit(alsa_card_es1688_exit);

--------------010902010407090208070704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------010902010407090208070704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------010902010407090208070704--
