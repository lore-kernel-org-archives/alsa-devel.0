From: Rene Herman <rene.herman@gmail.com>
Subject: isa_bus: adlib
Date: Mon, 12 Feb 2007 03:53:47 +0100
Message-ID: <45CFD6BB.602@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060606080706000807090901"
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
--------------060606080706000807090901
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Good day.

Second one for adlib. Completely straightforward. Has been tested.

Rene

--------------060606080706000807090901
Content-Type: text/plain;
 name="adlib.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib.diff"

diff --git a/sound/isa/adlib.c b/sound/isa/adlib.c
index 1124344..ecdcd6e 100644
--- a/sound/isa/adlib.c
+++ b/sound/isa/adlib.c
@@ -5,13 +5,13 @@
 #include <sound/driver.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
+#include <linux/isa.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/opl3.h>
 
 #define CRD_NAME "AdLib FM"
-#define DRV_NAME "snd_adlib"
+#define DEV_NAME "adlib"
 
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Rene Herman");
@@ -31,133 +31,102 @@ MODULE_PARM_DESC(enable, "Enable " CRD_N
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 
-static struct platform_device *devices[SNDRV_CARDS];
+static int __devinit snd_adlib_match(struct device *dev, unsigned int n)
+{
+	int match;
+
+	match = enable[n];
+	if (!match)
+		goto out;
+
+	match = port[n] != SNDRV_AUTO_PORT;
+	if (!match)
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+
+out:	return match;
+}
 
 static void snd_adlib_free(struct snd_card *card)
 {
 	release_and_free_resource(card->private_data);
 }
 
-static int __devinit snd_adlib_probe(struct platform_device *device)
+static int __devinit snd_adlib_probe(struct device *dev, unsigned int n)
 {
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
+	int error;
 
-	int error, i = device->id;
-
-	if (port[i] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
-		error = -EINVAL;
-		goto out0;
-	}
-
-	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
+	card = snd_card_new(index[n], id[n], THIS_MODULE, 0);
 	if (!card) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create card\n");
-		error = -EINVAL;
-		goto out0;
+		snd_printk(KERN_ERR "%s: could not create card\n", dev->bus_id);
+		return -EINVAL;
 	}
 
-	card->private_data = request_region(port[i], 4, CRD_NAME);
+	card->private_data = request_region(port[n], 4, CRD_NAME);
 	if (!card->private_data) {
-		snd_printk(KERN_ERR DRV_NAME ": could not grab ports\n");
+		snd_printk(KERN_ERR "%s: could not grab ports\n", dev->bus_id);
 		error = -EBUSY;
-		goto out1;
+		goto out;
 	}
 	card->private_free = snd_adlib_free;
 
-	error = snd_opl3_create(card, port[i], port[i] + 2, OPL3_HW_AUTO, 1, &opl3);
+	strcpy(card->driver, DEV_NAME);
+	strcpy(card->shortname, CRD_NAME);
+	sprintf(card->longname, CRD_NAME " at %#lx", port[n]);
+
+	error = snd_opl3_create(card, port[n], port[n] + 2, OPL3_HW_AUTO, 1, &opl3);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create OPL\n");
-		goto out1;
+		snd_printk(KERN_ERR "%s: could not create OPL\n", dev->bus_id);
+		goto out;
 	}
 
 	error = snd_opl3_hwdep_new(opl3, 0, 0, NULL);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create FM\n");
-		goto out1;
+		snd_printk(KERN_ERR "%s: could not create FM\n", dev->bus_id);
+		goto out;
 	}
 
-	strcpy(card->driver, DRV_NAME);
-	strcpy(card->shortname, CRD_NAME);
-	sprintf(card->longname, CRD_NAME " at %#lx", port[i]);
-
-	snd_card_set_dev(card, &device->dev);
+	snd_card_set_dev(card, dev);
 
 	error = snd_card_register(card);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not register card\n");
-		goto out1;
+		snd_printk(KERN_ERR "%s: could not register card\n", dev->bus_id);
+		goto out;
 	}
 
-	platform_set_drvdata(device, card);
+	dev_set_drvdata(dev, card);
 	return 0;
 
-out1:	snd_card_free(card);
-out0:	return error;
+out:	snd_card_free(card);
+	return error;
 }
 
-static int __devexit snd_adlib_remove(struct platform_device *device)
+static int __devexit snd_adlib_remove(struct device *dev, unsigned int n)
 {
-	snd_card_free(platform_get_drvdata(device));
-	platform_set_drvdata(device, NULL);
+	snd_card_free(dev_get_drvdata(dev));
+	dev_set_drvdata(dev, NULL);
 	return 0;
 }
 
-static struct platform_driver snd_adlib_driver = {
+static struct isa_driver snd_adlib_driver = {
+	.match		= snd_adlib_match,
 	.probe		= snd_adlib_probe,
 	.remove		= __devexit_p(snd_adlib_remove),
 
 	.driver		= {
-		.name	= DRV_NAME
+		.name	= DEV_NAME
 	}
 };
 
 static int __init alsa_card_adlib_init(void)
 {
-	int i, cards;
-
-	if (platform_driver_register(&snd_adlib_driver) < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not register driver\n");
-		return -ENODEV;
-	}
-
-	for (cards = 0, i = 0; i < SNDRV_CARDS; i++) {
-		struct platform_device *device;
-
-		if (!enable[i])
-			continue;
-
-		device = platform_device_register_simple(DRV_NAME, i, NULL, 0);
-		if (IS_ERR(device))
-			continue;
-
-		if (!platform_get_drvdata(device)) {
-			platform_device_unregister(device);
-			continue;
-		}
-
-		devices[i] = device;
-		cards++;
-	}
-
-	if (!cards) {
-#ifdef MODULE
-		printk(KERN_ERR CRD_NAME " soundcard not found or device busy\n");
-#endif
-		platform_driver_unregister(&snd_adlib_driver);
-		return -ENODEV;
-	}
-	return 0;
+	return isa_register_driver(&snd_adlib_driver, SNDRV_CARDS);
 }
 
 static void __exit alsa_card_adlib_exit(void)
 {
-	int i;
-
-	for (i = 0; i < SNDRV_CARDS; i++)
-		platform_device_unregister(devices[i]);
-	platform_driver_unregister(&snd_adlib_driver);
+	isa_unregister_driver(&snd_adlib_driver);
 }
 
 module_init(alsa_card_adlib_init);

--------------060606080706000807090901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------060606080706000807090901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------060606080706000807090901--
