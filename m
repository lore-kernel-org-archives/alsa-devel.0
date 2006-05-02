From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Re: Driver model ISA bus
Date: Wed, 03 May 2006 00:17:06 +0200
Message-ID: <4457DA62.4060305@keyaccess.nl>
References: <4455421E.1050104@keyaccess.nl> <s5h64kozl5w.wl%tiwai@suse.de> <Pine.LNX.4.61.0605021415090.9548@tm8103.perex-int.cz> <4457D9B2.1080306@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030509080305080203080908"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl [213.51.130.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 327EF19D
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 00:16:57 +0200 (MEST)
In-Reply-To: <4457D9B2.1080306@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Russell King <rmk+lkml@arm.linux.org.uk>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030509080305080203080908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

> in the next message I'll attach a converted snd-adlib again

Generated against 2.6.17-rc3. Hope that's new enough. Haven't gotten 
around to fiddling with mercurial yet.

Just as an example anyway; I'll do the conversion of all the ISA drivers 
if the bus is accepted upstream.

Rene.

--------------030509080305080203080908
Content-Type: text/plain;
 name="adlib_isa_bus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="adlib_isa_bus.diff"

Index: linux-2.6.17-rc3/sound/isa/adlib.c
===================================================================
--- linux-2.6.17-rc3.orig/sound/isa/adlib.c	2006-05-02 23:47:30.000000000 +0200
+++ linux-2.6.17-rc3/sound/isa/adlib.c	2006-05-02 23:48:28.000000000 +0200
@@ -5,13 +5,14 @@
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
+#define DRV_NAME "snd-" DEV_NAME
 
 MODULE_DESCRIPTION(CRD_NAME);
 MODULE_AUTHOR("Rene Herman");
@@ -31,36 +32,41 @@ MODULE_PARM_DESC(enable, "Enable " CRD_N
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 
-static struct platform_device *devices[SNDRV_CARDS];
+static int __devinit snd_adlib_match(struct device *dev, unsigned int i)
+{
+	if (!enable[i])
+		return 0;
+
+	if (port[i] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify port\n", dev->bus_id);
+		return 0;
+	}
+
+	return 1;
+}
 
 static void snd_adlib_free(struct snd_card *card)
 {
 	release_and_free_resource(card->private_data);
 }
 
-static int __devinit snd_adlib_probe(struct platform_device *device)
+static int __devinit snd_adlib_probe(struct device *dev, unsigned int i)
 {
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 
-	int error, i = device->id;
-
-	if (port[i] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
-		error = -EINVAL;
-		goto out0;
-	}
+	int error;
 
 	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
 	if (!card) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create card\n");
+		snd_printk(KERN_ERR "%s: could not create card\n", dev->bus_id);
 		error = -EINVAL;
 		goto out0;
 	}
 
 	card->private_data = request_region(port[i], 4, CRD_NAME);
 	if (!card->private_data) {
-		snd_printk(KERN_ERR DRV_NAME ": could not grab ports\n");
+		snd_printk(KERN_ERR "%s: could not grab ports\n", dev->bus_id);
 		error = -EBUSY;
 		goto out1;
 	}
@@ -68,96 +74,60 @@ static int __devinit snd_adlib_probe(str
 
 	error = snd_opl3_create(card, port[i], port[i] + 2, OPL3_HW_AUTO, 1, &opl3);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create OPL\n");
+		snd_printk(KERN_ERR "%s: could not create OPL\n", dev->bus_id);
 		goto out1;
 	}
 
 	error = snd_opl3_hwdep_new(opl3, 0, 0, NULL);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create FM\n");
+		snd_printk(KERN_ERR "%s: could not create FM\n", dev->bus_id);
 		goto out1;
 	}
 
 	strcpy(card->driver, DRV_NAME);
-	strcpy(card->shortname, CRD_NAME);
+	strcpy(card->shortname, DEV_NAME);
 	sprintf(card->longname, CRD_NAME " at %#lx", port[i]);
 
-	snd_card_set_dev(card, &device->dev);
+	snd_card_set_dev(card, dev);
 
 	error = snd_card_register(card);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not register card\n");
+		snd_printk(KERN_ERR "%s: could not register card\n", dev->bus_id);
 		goto out1;
 	}
 
-	platform_set_drvdata(device, card);
+	dev_set_drvdata(dev, card);
 	return 0;
 
 out1:	snd_card_free(card);
 out0:	return error;
 }
 
-static int __devexit snd_adlib_remove(struct platform_device *device)
+static int __devexit snd_adlib_remove(struct device *dev, unsigned int i)
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

--------------030509080305080203080908--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
