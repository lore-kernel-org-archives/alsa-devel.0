From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Driver model ISA bus
Date: Mon, 01 May 2006 01:02:54 +0200
Message-ID: <4455421E.1050104@keyaccess.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090402080704000002050804"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl [213.51.130.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BFBE619D
	for <alsa-devel@alsa-project.org>; Mon,  1 May 2006 00:59:39 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090402080704000002050804
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

During the recent discussion about ISA and platform devices I suggested
a seperate ISA bus instead of the platform bus for ISA devices due to
platform devices not providing the driver a chance to fail registration.
Russel King suggested using the ".match" bus method with this bus and
this indeed works fine -- .match is supposed to verify whether or not a
given driver supports a given device, meaning that it's a perfect
opportunity for an ISA driver to say "no, we don't support this
non-existant device" after failing a probe if it wants to.

Unlike the platform bus therefore this isa bus also distributes the
.match method up to the driver same as the other methods (probe, remove,
shutdown, suspend, resume). probe() works as before with platform
devices, but a non-match makes the device fail the registration.

Since with these ISA devices the devices also only exist by virtue of
the driver itself creating them because it might want to drive them,
actual device creation is also internal. The usage model is now very 
nicely minimal:

static struct isa_driver snd_foo_isa_driver = {
	.nr_devices	= SNDRV_CARDS,

	.match		= snd_foo_match,
	.probe		= snd_foo_probe,
	.remove		= __devexit_p(snd_foo_remove),
	.shutdown	= snd_foo_shutdown,
	.suspend	= snd_foo_suspend,
	.resume		= snd_foo_resume,
	
	.driver		= {
		.name	= DEV_NAME
	}
};

static int __init alsa_card_foo_init(void)
{
	return isa_register_driver(&snd_foo_driver);
}

static void __exit alsa_card_foo_exit(void)
{
	isa_unregister_driver(&snd_foo_isa_driver);
}

This gives all options -- if we want to keep existing behaviour of a
non-loading driver if no devices are found, we can just move the
existing platform probe() methods to the ISA match() methods, with no
aditional probe() needed. If on the other hand we want to load if a
later bind could still succeed as PCI does then we might use the match 
method only for the prerequisits, with probe() further as before:

static int __devinit snd_foo_match(struct isa_dev *isa_dev)
{
	unsigned int i = isa_dev->id;

	if (!enable[i])
		return 0;

	if (port[i] == SNDRV_AUTO_PORT)
		return 0;

	return 1;
}

static int __devinit snd_foo_probe(struct isa_dev *isa_dev)
{
	struct snd_card *card;

	...

	isa_set_drvdata(dev, card);
	return 0;
}

static int __devexit snd_foo_remove(struct isa_dev *isa_dev)
{
         snd_card_free(isa_get_drvdata(isa_dev));
         isa_set_drvdata(isa_dev, NULL);
         return 0;
}

Would you like this as a setup / model?

I also briefly looked into integrating this with PnP but this does not
seem to be a good match. The pnp_protocol {get,set}_resources() methods
would need to callback into drivers same as with this ISA bus match()
callback but this is at a time there might not _be_ a driver yet. This
is still that same fundamental difference of the ISA device only
existing due to a driver telling us it might. Even if there's a clean
way around that, you only end up inventing fake but valid-form PnP IDs
and generally catering to the PnP layer without any practical advantage
over this very simple isa_bus. The thing I suggested earlier (if you
read it) about the user setting up the device from userspace by echoing
values into /sys is... well, cute, but a horrible idea from a user
standpoint. Trying to force ISA into the PnP model just turns into
massive interface wankage.

About the code -- most of it will speak for itself. There are only two
exported functions, isa_register_driver() and isa_unregister_driver()
sinec as said the devices are completely internal and tied to the
driver. The match() method is the important difference from the platform
bus:

int isa_bus_match(struct device *dev, struct device_driver *driver)
{
     struct isa_driver *isa_driver = to_isa_driver(driver);

     if (dev->platform_data == isa_driver) {
         if (!isa_driver->match || isa_driver->match(to_isa_dev(dev)))
             return 1;
         dev->platform_data = NULL;
     }
     return 0;
}

As a first step in the match(), this assures that this device does
belong to this driver by checking if dev->platform_data is set to this
driver; isa_register_driver() abuses platform_data for this. I believe
it's available, but if not, moving the isa_driver pointer to struct
isa_dev is fine as well. Platform devices compare strings but since
these devices are internal, we can do it this way.

Then if the driver did not supply a match() method, it considers the
driver to always match and returns success. If the driver did supply a 
match method (which is assumed to return 0 or 1 as a boolean result same 
as the bus match method; if you'd prefer then < / >= 0 is ofcourse also 
an option) it's left up to the driver. If we did not match we lastly 
reset dev->platform_data to indicate this to isa_register_driver().

isa_register_driver() is basically what upto now the init methods are
doing manually (even more closely after they would've been converted 
from use of the platform_device_register_simple() API). It just loops 
over the "nr_devices" which is given as part of in the isa_driver struct 
creating devices and registering them. It then checks for successfull 
matches through dev->platfornm_data still being set, sticks sucessfully 
matched devices into a simple list hanging off the driver and 
unregisters the others again.

(this is done without any locking -- do I need any?)

If any error occurs, or no devices matched at all, it backs everything
out again and returns the error or -ENODEV.

Comments appreciated. I added the (yet again) converted adlib driver, 
using the more PCI-like model for keeping things registered and using
the match() method only for the preconditions. As said though, the
division between match() and probe() is now entirely up to the driver
and if you'd prefer (short or long term) to simply keep the behaviour of 
not loading, that is accomplished simply by moving the rest of probe() 
to match() as well.

Note, this is not being submitted at this point -- I just want to see 
first if you'd like this from the ALSA side.

Rene.



--------------090402080704000002050804
Content-Type: text/plain;
 name="isa_bus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isa_bus.diff"

Index: local/sound/isa/adlib.c
===================================================================
--- local.orig/sound/isa/adlib.c	2006-04-30 23:10:10.000000000 +0200
+++ local/sound/isa/adlib.c	2006-04-30 23:11:33.000000000 +0200
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
@@ -31,36 +32,47 @@ MODULE_PARM_DESC(enable, "Enable " CRD_N
 module_param_array(port, long, NULL, 0444);
 MODULE_PARM_DESC(port, "Port # for " CRD_NAME " driver.");
 
-static struct platform_device *devices[SNDRV_CARDS];
+static int __devinit snd_adlib_match(struct isa_dev *isa_dev)
+{
+	unsigned int i	= isa_dev->id;
+	char *bus_id	= isa_dev->dev.bus_id;
+
+	if (!enable[i])
+		return 0;
+
+	if (port[i] == SNDRV_AUTO_PORT) {
+		snd_printk(KERN_ERR "%s: please specify port\n", bus_id);
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
+static int __devinit snd_adlib_probe(struct isa_dev *isa_dev)
 {
 	struct snd_card *card;
 	struct snd_opl3 *opl3;
 
-	int error, i = device->id;
+	int error;
 
-	if (port[i] == SNDRV_AUTO_PORT) {
-		snd_printk(KERN_ERR DRV_NAME ": please specify port\n");
-		error = -EINVAL;
-		goto out0;
-	}
+	unsigned int i	= isa_dev->id;
+	char *bus_id	= isa_dev->dev.bus_id;
 
 	card = snd_card_new(index[i], id[i], THIS_MODULE, 0);
 	if (!card) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create card\n");
+		snd_printk(KERN_ERR "%s: could not create card\n", bus_id);
 		error = -EINVAL;
 		goto out0;
 	}
 
 	card->private_data = request_region(port[i], 4, CRD_NAME);
 	if (!card->private_data) {
-		snd_printk(KERN_ERR DRV_NAME ": could not grab ports\n");
+		snd_printk(KERN_ERR "%s: could not grab ports\n", bus_id);
 		error = -EBUSY;
 		goto out1;
 	}
@@ -68,101 +80,62 @@ static int __devinit snd_adlib_probe(str
 
 	error = snd_opl3_create(card, port[i], port[i] + 2, OPL3_HW_AUTO, 1, &opl3);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create OPL\n");
+		snd_printk(KERN_ERR "%s: could not create OPL\n", bus_id);
 		goto out1;
 	}
 
 	error = snd_opl3_hwdep_new(opl3, 0, 0, NULL);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not create FM\n");
+		snd_printk(KERN_ERR "%s: could not create FM\n", bus_id);
 		goto out1;
 	}
 
 	strcpy(card->driver, DRV_NAME);
-	strcpy(card->shortname, CRD_NAME);
+	strcpy(card->shortname, DEV_NAME);
 	sprintf(card->longname, CRD_NAME " at %#lx", port[i]);
 
-	snd_card_set_dev(card, &device->dev);
+	snd_card_set_dev(card, &isa_dev->dev);
 
 	error = snd_card_register(card);
 	if (error < 0) {
-		snd_printk(KERN_ERR DRV_NAME ": could not register card\n");
+		snd_printk(KERN_ERR "%s: could not register card\n", bus_id);
 		goto out1;
 	}
 
-	platform_set_drvdata(device, card);
+	isa_set_drvdata(isa_dev, card);
 	return 0;
 
 out1:	snd_card_free(card);
 out0:	return error;
 }
 
-static int __devexit snd_adlib_remove(struct platform_device *device)
+static int __devexit snd_adlib_remove(struct isa_dev *isa_dev)
 {
-	snd_card_free(platform_get_drvdata(device));
-	platform_set_drvdata(device, NULL);
+	snd_card_free(isa_get_drvdata(isa_dev));
+	isa_set_drvdata(isa_dev, NULL);
 	return 0;
 }
 
-static struct platform_driver snd_adlib_driver = {
+static struct isa_driver snd_adlib_driver = {
+	.nr_devices	= SNDRV_CARDS,
+
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
-		device = platform_device_alloc(DRV_NAME, i);
-		if (!device)
-			continue;
-
-		if (platform_device_add(device) < 0) {
-			platform_device_put(device);
-			continue;
-		}
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
+	return isa_register_driver(&snd_adlib_driver);
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
Index: local/drivers/base/isa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/drivers/base/isa.c	2006-05-01 00:23:42.000000000 +0200
@@ -0,0 +1,169 @@
+/*
+ * ISA bus.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/isa.h>
+
+static struct device isa_bus = {
+	.bus_id		= "isa"
+};
+
+static int isa_bus_match(struct device *dev, struct device_driver *driver)
+{
+	struct isa_driver *isa_driver = to_isa_driver(driver);
+
+	if (dev->platform_data == isa_driver) {
+		if (!isa_driver->match || isa_driver->match(to_isa_dev(dev)))
+			return 1;
+		dev->platform_data = NULL;
+	}
+	return 0;
+}
+
+static int isa_bus_probe(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->probe)
+		return isa_driver->probe(to_isa_dev(dev));
+
+	return 0;
+}
+
+static int isa_bus_remove(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->remove)
+	       return isa_driver->remove(to_isa_dev(dev));
+
+	return 0;
+}
+
+static void isa_bus_shutdown(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->shutdown)
+		isa_driver->shutdown(to_isa_dev(dev));
+}
+
+static int isa_bus_suspend(struct device *dev, pm_message_t state)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->suspend)
+		return isa_driver->suspend(to_isa_dev(dev), state);
+
+	return 0;
+}
+
+static int isa_bus_resume(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->resume)
+	       return isa_driver->resume(to_isa_dev(dev));
+
+	return 0;
+}
+
+static struct bus_type isa_bus_type = {
+	.name		= "isa",
+	.match		= isa_bus_match,
+	.probe		= isa_bus_probe,
+	.remove		= isa_bus_remove,
+	.shutdown	= isa_bus_shutdown,
+	.suspend	= isa_bus_suspend,
+	.resume		= isa_bus_resume
+};
+
+static void isa_dev_release(struct device *dev)
+{
+	kfree(to_isa_dev(dev));
+}
+
+void isa_unregister_driver(struct isa_driver *isa_driver)
+{
+	struct isa_dev *isa_dev = isa_driver->devices;
+
+	while (isa_dev) {
+		struct device *dev = &isa_dev->dev;
+		isa_dev = isa_dev->next;
+		device_unregister(dev);
+	}
+	driver_unregister(&isa_driver->driver);
+}
+EXPORT_SYMBOL_GPL(isa_unregister_driver);
+
+int isa_register_driver(struct isa_driver *isa_driver)
+{
+	int error;
+	unsigned int id;
+
+	isa_driver->driver.bus	= &isa_bus_type;
+	isa_driver->devices	= NULL;
+
+	error = driver_register(&isa_driver->driver);
+	if (error)
+		return error;
+
+	for (id = 0; id < isa_driver->nr_devices; id++) {
+		struct isa_dev *isa_dev;
+
+		isa_dev = kzalloc(sizeof *isa_dev, GFP_KERNEL);
+		if (!isa_dev) {
+			error = -ENOMEM;
+			break;
+		}
+
+		isa_dev->dev.parent	= &isa_bus;
+		isa_dev->dev.bus	= &isa_bus_type;
+
+		snprintf(isa_dev->dev.bus_id, BUS_ID_SIZE, "%s.%u",
+				isa_driver->driver.name, id);
+
+		isa_dev->dev.platform_data	= isa_driver;
+		isa_dev->dev.release		= isa_dev_release;
+		isa_dev->id			= id;
+
+		error = device_register(&isa_dev->dev);
+		if (error) {
+			put_device(&isa_dev->dev);
+			break;
+		}
+
+		if (isa_dev->dev.platform_data) {
+			isa_dev->next = isa_driver->devices;
+			isa_driver->devices = isa_dev;
+		} else
+			device_unregister(&isa_dev->dev);
+	}
+
+	if (!error && !isa_driver->devices)
+		error = -ENODEV;
+
+	if (error)
+		isa_unregister_driver(isa_driver);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(isa_register_driver);
+
+static int __init isa_bus_init(void)
+{
+	int error;
+
+	error = bus_register(&isa_bus_type);
+	if (!error) {
+		error = device_register(&isa_bus);
+		if (error)
+			bus_unregister(&isa_bus_type);
+	}
+	return error;
+}
+
+device_initcall(isa_bus_init);
Index: local/include/linux/isa.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/include/linux/isa.h	2006-04-30 23:11:33.000000000 +0200
@@ -0,0 +1,40 @@
+/*
+ * ISA bus.
+ */
+
+#ifndef __LINUX_ISA_H
+#define __LINUX_ISA_H
+
+#include <linux/device.h>
+
+struct isa_dev {
+	struct device dev;
+	unsigned int id;
+	struct isa_dev *next;
+};
+
+#define to_isa_dev(x) container_of((x), struct isa_dev, dev)
+
+struct isa_driver {
+	unsigned int nr_devices;
+	struct isa_dev *devices;
+
+	int (*match)(struct isa_dev *);
+	int (*probe)(struct isa_dev *);
+	int (*remove)(struct isa_dev *);
+	void (*shutdown)(struct isa_dev *);
+	int (*suspend)(struct isa_dev *, pm_message_t);
+	int (*resume)(struct isa_dev *);
+
+	struct device_driver driver;
+};
+
+#define to_isa_driver(x) container_of((x), struct isa_driver, driver)
+
+#define isa_get_drvdata(x)	 dev_get_drvdata(&(x)->dev)
+#define isa_set_drvdata(x, data) dev_set_drvdata(&(x)->dev, (data))
+
+int isa_register_driver(struct isa_driver *);
+void isa_unregister_driver(struct isa_driver *);
+
+#endif /* __LINUX_ISA_H */
Index: local/drivers/base/Makefile
===================================================================
--- local.orig/drivers/base/Makefile	2006-04-30 23:10:10.000000000 +0200
+++ local/drivers/base/Makefile	2006-04-30 23:11:33.000000000 +0200
@@ -4,6 +4,7 @@ obj-y			:= core.o sys.o bus.o dd.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
+obj-$(CONFIG_ISA)	+= isa.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o

--------------090402080704000002050804--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
