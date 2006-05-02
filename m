From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Re: Driver model ISA bus
Date: Wed, 03 May 2006 00:14:10 +0200
Message-ID: <4457D9B2.1080306@keyaccess.nl>
References: <4455421E.1050104@keyaccess.nl> <s5h64kozl5w.wl%tiwai@suse.de> <Pine.LNX.4.61.0605021415090.9548@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000003010500010402090404"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl [213.51.130.201])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA8F619D
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 00:14:10 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0605021415090.9548@tm8103.perex-int.cz>
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
--------------000003010500010402090404
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jaroslav Kysela wrote:

> On Tue, 2 May 2006, Takashi Iwai wrote:
> 
>> Yep, I like this implementation.  It's pretty straightforward.
> 
> Acked-by: Jaroslav Kysela <perex@suse.cz>
> 
> I like it too. It removes really most of duplicated code.

Okay, great, thanks. I've tweaked it a _bit_ more. The device creation 
is all internal to the bus and isa_dev's only leaked out due to being 
passed to the driver callbacks. Keeping them really internal is much 
cleaner. Other than the "struct device *" we only want the ->id, so 
let's just pass that directly. Ie:

static int snd_foo_probe(struct device *dev, unsigned int i)

Makes for nicer code as well as with snd_card_set_dev(card, dev) versus 
snd_card_set_dev(card, &isa_dev.dev) and the like...

Second tweak -- move nr_devices from the isa_driver struct to a 
parameter to isa_register_driver(). Ie,

int __init alsa_card_foo_init(void)
{
	return isa_register_driver(&snd_foo_isa_driver, SNDRV_CARDS);
}

That count is only being used by isa_register_driver() so belongs there 
really, not as part of the driver struct. I doubt anyone will ever want 
to do so, but in theory you could call isa_register_driver() with the 
same driver struct but a different count depending on options, or do 
more calls then one, or ...

Attached applies against both 2.6.16.11 and 2.6.17-rc3. If no specific 
comments, further wishes or NAKs after all, I'll submit this. I think 
it's nice -- in the next message I'll attach a converted snd-adlib again 
and I like how that gets reallyreally minimal this way...

Rene.


--------------000003010500010402090404
Content-Type: text/plain;
 name="isa_bus-3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="isa_bus-3.diff"

Index: local/drivers/base/isa.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ local/drivers/base/isa.c	2006-05-02 23:18:34.000000000 +0200
@@ -0,0 +1,180 @@
+/*
+ * ISA bus.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/isa.h>
+
+static struct device isa_bus = {
+	.bus_id		= "isa"
+};
+
+struct isa_dev {
+	struct device dev;
+	struct device *next;
+	unsigned int id;
+};
+
+#define to_isa_dev(x) container_of((x), struct isa_dev, dev)
+
+static int isa_bus_match(struct device *dev, struct device_driver *driver)
+{
+	struct isa_driver *isa_driver = to_isa_driver(driver);
+
+	if (dev->platform_data == isa_driver) {
+		if (!isa_driver->match ||
+			isa_driver->match(dev, to_isa_dev(dev)->id))
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
+		return isa_driver->probe(dev, to_isa_dev(dev)->id);
+
+	return 0;
+}
+
+static int isa_bus_remove(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->remove)
+		return isa_driver->remove(dev, to_isa_dev(dev)->id);
+
+	return 0;
+}
+
+static void isa_bus_shutdown(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->shutdown)
+		isa_driver->shutdown(dev, to_isa_dev(dev)->id);
+}
+
+static int isa_bus_suspend(struct device *dev, pm_message_t state)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->suspend)
+		return isa_driver->suspend(dev, to_isa_dev(dev)->id, state);
+
+	return 0;
+}
+
+static int isa_bus_resume(struct device *dev)
+{
+	struct isa_driver *isa_driver = dev->platform_data;
+
+	if (isa_driver->resume)
+		return isa_driver->resume(dev, to_isa_dev(dev)->id);
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
+	struct device *dev = isa_driver->devices;
+
+	while (dev) {
+		struct device *tmp = to_isa_dev(dev)->next;
+		device_unregister(dev);
+		dev = tmp;
+	}
+	driver_unregister(&isa_driver->driver);
+}
+EXPORT_SYMBOL_GPL(isa_unregister_driver);
+
+int isa_register_driver(struct isa_driver *isa_driver, unsigned int ndev)
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
+	for (id = 0; id < ndev; id++) {
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
+			isa_driver->devices = &isa_dev->dev;
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
+++ local/include/linux/isa.h	2006-05-02 23:17:18.000000000 +0200
@@ -0,0 +1,28 @@
+/*
+ * ISA bus.
+ */
+
+#ifndef __LINUX_ISA_H
+#define __LINUX_ISA_H
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+
+struct isa_driver {
+	int (*match)(struct device *, unsigned int);
+	int (*probe)(struct device *, unsigned int);
+	int (*remove)(struct device *, unsigned int);
+	void (*shutdown)(struct device *, unsigned int);
+	int (*suspend)(struct device *, unsigned int, pm_message_t);
+	int (*resume)(struct device *, unsigned int);
+
+	struct device_driver driver;
+	struct device *devices;
+};
+
+#define to_isa_driver(x) container_of((x), struct isa_driver, driver)
+
+int isa_register_driver(struct isa_driver *, unsigned int);
+void isa_unregister_driver(struct isa_driver *);
+
+#endif /* __LINUX_ISA_H */
Index: local/drivers/base/Makefile
===================================================================
--- local.orig/drivers/base/Makefile	2006-05-02 22:44:00.000000000 +0200
+++ local/drivers/base/Makefile	2006-05-02 22:45:32.000000000 +0200
@@ -4,6 +4,7 @@ obj-y			:= core.o sys.o bus.o dd.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o map.o dmapool.o \
 			   attribute_container.o transport_class.o
+obj-$(CONFIG_ISA)	+= isa.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o

--------------000003010500010402090404--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
