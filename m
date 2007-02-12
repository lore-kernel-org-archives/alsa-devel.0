From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: ad1848
Date: Mon, 12 Feb 2007 03:52:03 +0100
Message-ID: <45CFD653.4050401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050505050905010700020109"
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
--------------050505050905010700020109
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

Quite some time ago by now I announced I would be transferring ALSA ISA 
drivers to the new isa_bus infrastructure. All sorts of crap intervened 
but I'm finding some time currently. I will be submitting them one or a 
few drivers at a time...

As a reminder; as a general principle in the driver model, drivers load 
even if they can't immediately bind to their hardware -- it's generally 
possible to bind the driver to some specific hardware later by echoing a 
device id into the driver's "bind" sysfs-attribute.

Due to old non-pnp ISA devices not being generically discoverable, the 
isa_bus keeps all device creation internal and distributes the bus's 
.match() method up to the driver, allowing the driver to decide whether 
or not to load.

Following the above mentioned general principle of loading even if the 
driver can't immediately bind to the hardware, the suggested use of the 
.match() method in these ALSA drivers is only for the prerequisites. Ie, 
check that the user wants the card enabled (the "enable" param) and that 
values such as port, irq and dma have been passed in so that a later 
bind could conceivably succeed.

With this setup for example things such as loading multiple drivers for 
one card and binding and unbinding them alternately works nicely. You'd 
do things such as

echo -n ad1848.0 >/sys/bus/isa/drivers/ad1848/unbind

where "ad1848.0" is the device id existing under /sys/devices/isa and 
under that same driver directory when it's bound (and where "ad1848" is 
the same as the ALSA card->driver, bringing some consistency to the name 
strings) to have the driver "let go" of the hardware so that you can try 
to drive the same hardware with sns-cs4232 for example. If you'd later 
want to bind the driver again, a

echo -n ad1848.0 >/sys/bus/isa/drivers/ad1848/bind

should do it.

Attched is the first one for ad1848. It's a straightforward transfer 
from the old platform devices and has been tested. It contains one 
unrelated change; s/dma1/dma/ since this driver only accepts one dma 
channel.

Rene.

--------------050505050905010700020109
Content-Type: text/plain;
 name="ad1848.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ad1848.diff"

diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 99908e4..0750373 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -24,7 +24,7 @@
 #include <sound/driver.h>
 #include <linux/init.h>
 #include <linux/err.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <linux/time.h>
 #include <linux/wait.h>
 #include <linux/moduleparam.h>
@@ -32,8 +32,11 @@ #include <sound/core.h>
 #include <sound/ad1848.h>
 #include <sound/initval.h>
 
+#define CRD_NAME "Generic AD1848/AD1847/CS4248"
+#define DEV_NAME "ad1848"
+
+MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Tugrul Galatali <galatalt@stuy.edu>, Jaroslav Kysela <perex@suse.cz>");
-MODULE_DESCRIPTION("AD1848/AD1847/CS4248");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Analog Devices,AD1848},"
 	        "{Analog Devices,AD1847},"
@@ -44,99 +47,111 @@ static char *id[SNDRV_CARDS] = SNDRV_DEF
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
 static long port[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* PnP setup */
 static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 5,7,9,11,12,15 */
-static int dma1[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3,5,6,7 */
+static int dma[SNDRV_CARDS] = SNDRV_DEFAULT_DMA;	/* 0,1,3,5,6,7 */
 static int thinkpad[SNDRV_CARDS];			/* Thinkpad special case */
 
 module_param_array(index, int, NULL, 0444);
-MODULE_PARM_DESC(index, "Index value for AD1848 soundcard.");
+MODULE_PARM_DESC(index, "Index value for " CRD_NAME " soundcard.");
 module_param_array(id, charp, NULL, 0444);
-MODULE_PARM_DESC(id, "ID string for AD1848 soundcard.");
+MODULE_PARM_DESC(id, "ID string for " CRD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, 0444);
-MODULE_PARM_DESC(enable, "Enable AD1848 soundcard.");
+MODULE_PARM_DESC(enable, "Enable " CRD_NAME " soundcard.");
 module_param_array(port, long, NULL, 0444);
-MODULE_PARM_DESC(port, "Port # for AD1848 driver.");
+MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 module_param_array(irq, int, NULL, 0444);
-MODULE_PARM_DESC(irq, "IRQ # for AD1848 driver.");
-module_param_array(dma1, int, NULL, 0444);
-MODULE_PARM_DESC(dma1, "DMA1 # for AD1848 driver.");
+MODULE_PARM_DESC(irq, "IRQ # for " CRD_NAME " driver.");
+module_param_array(dma, int, NULL, 0444);
+MODULE_PARM_DESC(dma, "DMA # for " CRD_NAME " driver.");
 module_param_array(thinkpad, bool, NULL, 0444);
 MODULE_PARM_DESC(thinkpad, "Enable only for the onboard CS4248 of IBM Thinkpad 360/750/755 series.");
 
-static struct platform_device *devices[SNDRV_CARDS];
+static int __devinit snd_ad1848_match(struct device *dev, unsigned int n)
+{
+	int match;
+
+	match = enable[n];
+	if (!match)
+		goto out;
 
+	match = port[n] != SNDRV_AUTO_PORT;
+	if (!match) {
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		goto out;
+	}
 
-static int __init snd_ad1848_probe(struct platform_device *pdev)
+	match = irq[n] != SNDRV_AUTO_IRQ;
+	if (!match) {
+		snd_printk(KERN_ERR "%s: please specify IRQ\n", dev->bus_id);
+		goto out;
+	}
+
+	match = dma[n] != SNDRV_AUTO_DMA;
+	if (!match) {
+		snd_printk(KERN_ERR "%s: please specify DMA channel\n", dev->bus_id);
+		goto out;
+	}
+
+out:	return match;
+}
+
+static int __devinit snd_ad1848_probe(struct device *dev, unsigned int n)
 {
-	int dev = pdev->id;
 	struct snd_card *card;
 	struct snd_ad1848 *chip;
 	struct snd_pcm *pcm;
-	int err;
+	int error;
 
-	if (port[dev] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR "ad1848: specify port\n");
-		return -EINVAL;
-	}
-	if (irq[dev] == SNDRV_AUTO_IRQ) {
-		snd_printk(KERN_ERR "ad1848: specify irq\n");
-		return -EINVAL;
-	}
-	if (dma1[dev] == SNDRV_AUTO_DMA) {
-		snd_printk(KERN_ERR "ad1848: specify dma1\n");
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
+	if (!card)
 		return -EINVAL;
-	}
 
-	card = snd_card_new(index[dev], id[dev], THIS_MODULE, 0);
-	if (card == NULL)
-		return -ENOMEM;
+	error = snd_ad1848_create(card, port[n], irq[n], dma[n],
+			thinkpad[n] ? AD1848_HW_THINKPAD : AD1848_HW_DETECT, &chip);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_ad1848_create(card, port[dev],
-				     irq[dev],
-				     dma1[dev],
-				     thinkpad[dev] ? AD1848_HW_THINKPAD : AD1848_HW_DETECT,
-				     &chip)) < 0)
-		goto _err;
 	card->private_data = chip;
 
-	if ((err = snd_ad1848_pcm(chip, 0, &pcm)) < 0)
-		goto _err;
+	error = snd_ad1848_pcm(chip, 0, &pcm);
+	if (error < 0)
+		goto out;
 
-	if ((err = snd_ad1848_mixer(chip)) < 0)
-		goto _err;
+	error = snd_ad1848_mixer(chip);
+	if (error < 0)
+		goto out;
 
-	strcpy(card->driver, "AD1848");
+	strcpy(card->driver, DEV_NAME);
 	strcpy(card->shortname, pcm->name);
 
 	sprintf(card->longname, "%s at 0x%lx, irq %d, dma %d",
-		pcm->name, chip->port, irq[dev], dma1[dev]);
-
-	if (thinkpad[dev])
+		pcm->name, chip->port, irq[n], dma[n]);
+	if (thinkpad[n])
 		strcat(card->longname, " [Thinkpad]");
 
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
 
-static int __devexit snd_ad1848_remove(struct platform_device *devptr)
+static int __devexit snd_ad1848_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(devptr));
-	platform_set_drvdata(devptr, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int snd_ad1848_suspend(struct platform_device *pdev, pm_message_t state)
+static int snd_ad1848_suspend(struct device *dev, unsigned int n, pm_message_t state)
 {
-	struct snd_card *card = platform_get_drvdata(pdev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ad1848 *chip = card->private_data;
 
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
@@ -144,9 +159,9 @@ static int snd_ad1848_suspend(struct pla
 	return 0;
 }
 
-static int snd_ad1848_resume(struct platform_device *pdev)
+static int snd_ad1848_resume(struct device *dev, unsigned int n)
 {
-	struct snd_card *card = platform_get_drvdata(pdev);
+	struct snd_card *card = dev_get_drvdata(dev);
 	struct snd_ad1848 *chip = card->private_data;
 
 	chip->resume(chip);
@@ -155,9 +170,8 @@ static int snd_ad1848_resume(struct plat
 }
 #endif
 
-#define SND_AD1848_DRIVER	"snd_ad1848"
-
-static struct platform_driver snd_ad1848_driver = {
+static struct isa_driver snd_ad1848_driver = {
+	.match		= snd_ad1848_match,
 	.probe		= snd_ad1848_probe,
 	.remove		= __devexit_p(snd_ad1848_remove),
 #ifdef CONFIG_PM
@@ -165,57 +179,19 @@ #ifdef CONFIG_PM
 	.resume		= snd_ad1848_resume,
 #endif
 	.driver		= {
-		.name	= SND_AD1848_DRIVER
-	},
+		.name	= DEV_NAME
+	}
 };
 
-static void __init_or_module snd_ad1848_unregister_all(void)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(devices); ++i)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_ad1848_driver);
-}
-
 static int __init alsa_card_ad1848_init(void)
 {
-	int i, cards, err;
-
-	err = platform_driver_register(&snd_ad1848_driver);
-	if (err < 0)
-		return err;
-
-	cards = 0;
-	for (i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-		if (! enable[i])
-			continue;
-		device = platform_device_register_simple(SND_AD1848_DRIVER,
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
-		printk(KERN_ERR "AD1848 soundcard not found or device busy\n");
-#endif
-		snd_ad1848_unregister_all();
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_ad1848_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_ad1848_exit(void)
 {
-	snd_ad1848_unregister_all();
+	isa_unregister_driver(&snd_ad1848_driver);
 }
 
-module_init(alsa_card_ad1848_init)
-module_exit(alsa_card_ad1848_exit)
+module_init(alsa_card_ad1848_init);
+module_exit(alsa_card_ad1848_exit);

--------------050505050905010700020109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------050505050905010700020109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------050505050905010700020109--
