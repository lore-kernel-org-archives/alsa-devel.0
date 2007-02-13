From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: cs4231
Date: Tue, 13 Feb 2007 07:16:17 +0100
Message-ID: <45D157B1.4090506@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070905050608010107080405"
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
--------------070905050608010107080405
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

cs4231 -- done exactly the same as ad1848. Has been tested (so have 
ad1848 and adlib; forgot to mention).

Rene.

--------------070905050608010107080405
Content-Type: text/plain;
 name="cs4231.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs4231.diff"

diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 696a5c8..ac40411 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -23,7 +23,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
@@ -32,8 +32,11 @@ #include <sound/cs4231.h>
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
+#define CRD_NAME "Generic CS4231"
+#define DEV_NAME "cs4231"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
-MODULE_DESCRIPTION("Generic CS4231");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Crystal Semiconductors,CS4231}}");
 
@@ -48,132 +51,136 @@ static int dma1[SNDRV_CARDS] = SNDRV_DEF
 static int dma2[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3,5,6,7 */
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for CS4231 soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for CS4231 soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable CS4231 soundcard.");
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for CS4231 driver.");
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(mpu_port, long, NULL, 0444);
-MODULE_PARM_DESC(mpu_port, "MPU-401 port # for CS4231 driver.");
+MODULE_PARM_DESC(mpu_port, "MPU-401 port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for CS4231 driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
 module_param_array(mpu_irq, int, NULL, 0444);
-MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for CS4231 driver.");
+MODULE_PARM_DESC(mpu_irq, "MPU-401 IRQ # for " CRD_NAME " driver.");
 module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "DMA1 # for CS4231 driver.");
+MODULE_PARM_DESC(dma1, "DMA1 # for " CRD_NAME " driver.");
 module_param_array(dma2, int, NULL, 0444);
-MODULE_PARM_DESC(dma2, "DMA2 # for CS4231 driver.");
+MODULE_PARM_DESC(dma2, "DMA2 # for " CRD_NAME " driver.");
 
-static struct platform_device *devices[SNDRV_CARDS];
+static int __devinit snd_cs4231_match(struct device *dev, unsigned int n)
+{
+	if (!enable[n])
+		return 0;
 
+	if (port[n] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
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
 
-static int __init snd_cs4231_probe(struct platform_device *pdev)
+static int __devinit snd_cs4231_probe(struct device *dev, unsigned int n)
 {
-	int dev = pdev->id;
 	struct snd_card *card;
-	struct snd_pcm *pcm;
 	struct snd_cs4231 *chip;
-	int err;
+	struct snd_pcm *pcm;
+	int error;
 
-	if (port[dev] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR "specify port\n");
-		return -EINVAL;
-	}
-	if (irq[dev] == SNDRV_AUTO_IRQ) {
-		snd_printk(KERN_ERR "specify irq\n");
-		return -EINVAL;
-	}
-	if (dma1[dev] == SNDRV_AUTO_DMA) {
-		snd_printk(KERN_ERR "specify dma1\n");
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
 		return -EINVAL;
-	}
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
-	if ((err = snd_cs4231_create(card, port[dev], -1,
-				     irq[dev],
-				     dma1[dev],
-				     dma2[dev],
-				     CS4231_HW_DETECT,
-				     0, &chip)) < 0)
-		goto _err;
+
+	error = snd_cs4231_create(card, port[n], -1, irq[n], dma1[n], dma2[n],
+			CS4231_HW_DETECT, 0, &chip);
+	if (error < 0)
+		goto out;
+
 	card->private_data = chip;
 
-	if ((err = snd_cs4231_pcm(chip, 0, &pcm)) < 0)
-		goto _err;
+	error = snd_cs4231_pcm(chip, 0, &pcm);
+	if (error < 0)
+		goto out;
 
 	strcpy(card->driver, "CS4231");
 	strcpy(card->shortname, pcm->name);
+
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		pcm->name, chip->port, irq[dev], dma1[dev]);
-	if (dma2[dev] >= 0)
-		sprintf(card->longname + strlen(card->longname), "&%d", dma2[dev]);
-
-	if ((err = snd_cs4231_mixer(chip)) < 0)
-		goto _err;
-	if ((err = snd_cs4231_timer(chip, 0, NULL)) < 0)
-		goto _err;
-
-	if (mpu_port[dev] > 0 && mpu_port[dev] != SNDRV_AUTO_PORT) {
-		if (mpu_irq[dev] == SNDRV_AUTO_IRQ)
-			mpu_irq[dev] = -1;
+		pcm->name, chip->port, irq[n], dma1[n]);
+	if (dma2[n] >= 0)
+		sprintf(card->longname + strlen(card->longname), "&%d", dma2[n]);
+
+	error = snd_cs4231_mixer(chip);
+	if (error < 0)
+		goto out;
+
+	error = snd_cs4231_timer(chip, 0, NULL);
+	if (error < 0)
+		goto out;
+
+	if (mpu_port[n] > 0 && mpu_port[n] != SNDRV_AUTO_PORT) {
+		if (mpu_irq[n] == SNDRV_AUTO_IRQ)
+			mpu_irq[n] = -1;
 		if (snd_mpu401_uart_new(card, 0, MPU401_HW_CS4232,
-					mpu_port[dev], 0,
-					mpu_irq[dev],
-					mpu_irq[dev] >= 0 ? IRQF_DISABLED : 0,
+					mpu_port[n], 0, mpu_irq[n],
+					mpu_irq[n] >= 0 ? IRQF_DISABLED : 0,
 					NULL) < 0)
-			printk(KERN_WARNING "cs4231: MPU401 not detected\n");
+			printk(KERN_WARNING "%s: MPU401 not detected\n", dev->bus_id);
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
 
-static int __devexit snd_cs4231_remove(struct platform_device *devptr)
+static int __devexit snd_cs4231_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int snd_cs4231_suspend(struct platform_device *dev, pm_message_t state)
+static int snd_cs4231_suspend(struct device *dev, unsigned int n, pm_message_t state)
 {
-	struct snd_card *card;
-	struct snd_cs4231 *chip;
-	card = platform_get_drvdata(dev);
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct snd_cs4231 *chip = card->private_data;
+
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	chip = card->private_data;
 	chip->suspend(chip);
 	return 0;
 }
 
-static int snd_cs4231_resume(struct platform_device *dev)
+static int snd_cs4231_resume(struct device *dev, unsigned int n)
 {
-	struct snd_card *card;
-	struct snd_cs4231 *chip;
-	card = platform_get_drvdata(dev);
-	chip = card->private_data;
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct snd_cs4231 *chip = card->private_data;
+
 	chip->resume(chip);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 	return 0;
 }
 #endif
 
-#define SND_CS4231_DRIVER	"snd_cs4231"
-
-static struct platform_driver snd_cs4231_driver = {
+static struct isa_driver snd_cs4231_driver = {
+	.match		= snd_cs4231_match,
 	.probe		= snd_cs4231_probe,
 	.remove		= __devexit_p(snd_cs4231_remove),
 #ifdef CONFIG_PM
@@ -181,57 +188,19 @@ #ifdef CONFIG_PM
 	.resume		= snd_cs4231_resume,
 #endif
 	.driver		= {
-		.name	= SND_CS4231_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_cs4231_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_cs4231_driver);
-}
-
 static int __init alsa_card_cs4231_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_cs4231_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(SND_CS4231_DRIVER,
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
-		printk(KERN_ERR "CS4231 soundcard not found or device busy\n");
-#endif
-		snd_cs4231_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_cs4231_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_cs4231_exit(void)
 {
-	snd_cs4231_unregister_all();
+	isa_unregister_driver(&snd_cs4231_driver);
 }
 
-module_init(alsa_card_cs4231_init)
-module_exit(alsa_card_cs4231_exit)
+module_init(alsa_card_cs4231_init);
+module_exit(alsa_card_cs4231_exit);

--------------070905050608010107080405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------070905050608010107080405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070905050608010107080405--
