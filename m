From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] AC97 bus interface for ad-hoc drivers
Date: Fri, 29 Jul 2005 13:51:56 +0100
Message-ID: <1122641516.3117.38.camel@localhost.localdomain>
References: <1121775624.14604.14.camel@cearnarfon>
	 <s5hbr4old2a.wl%tiwai@suse.de>
	 <Pine.LNX.4.63.0507270856510.21762@localhost.localdomain>
	 <1122582399.5371.90.camel@localhost.localdomain>
	 <s5h4qaddh5w.wl%tiwai@suse.de>
	 <1122636040.3117.28.camel@localhost.localdomain>
	 <s5hwtn9c0of.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-c2uJjmdorrk8x6LBxM8V"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hwtn9c0of.wl%tiwai@suse.de>
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
Cc: Nicolas Pitre <nico@cam.org>, alsa-devel@lists.sourceforge.net, Bill Gatliff <bgat@billgatliff.com>
List-Id: alsa-devel@alsa-project.org


--=-c2uJjmdorrk8x6LBxM8V
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've made the review changes and as requested I've pasted the RFC by
Nicolas below:-

"I would like to know what people think of the following patch.  It 
allows for a codec on an AC97 bus to be shared with other drivers which 
are completely unrelated to audio.  It registers a new bus type, and 
whenever a codec instance is created then a device for it is also 
registered with the driver model using that bus type.  This allows, for 
example, to use the extra features of the UCB1400 like the touchscreen 
interface and the additional GPIOs and ADCs available on that chip for 
battery monitoring.  I have a working UCB1400 touchscreen driver here 
that simply registers with the driver model happily working alongside 
with audio features using this."

Changes over RFC:-
 
  o Now matches codec name within codec group.
  o Added ac97_dev_release() to stop kernel complaining about no release
method for device.
  o Added "config SND_AC97_BUS" to sound/pci/Kconfig and moved "config
SND_AC97_CODEC" out with the PCI=n statement.
  o module is now called snd-ac97-bus

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Signed-off-by: Nicolas Pitre <nico@cam.org>

Liam 

--=-c2uJjmdorrk8x6LBxM8V
Content-Disposition: attachment; filename=ac97_bus.diff
Content-Type: text/x-patch; name=ac97_bus.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -1,11 +1,15 @@
 # ALSA PCI drivers
 
-menu "PCI devices"
-	depends on SND!=n && PCI
-
 config SND_AC97_CODEC
 	tristate
 	select SND_PCM
+	select SND_AC97_BUS
+
+config SND_AC97_BUS
+	tristate
+
+menu "PCI devices"
+	depends on SND!=n && PCI
 
 config SND_ALI5451
 	tristate "ALi M5451 PCI Audio Controller"
diff --git a/sound/pci/ac97/ac97_bus.c b/sound/pci/ac97/ac97_bus.c
new file mode 100644
--- /dev/null
+++ b/sound/pci/ac97/ac97_bus.c
@@ -0,0 +1,79 @@
+/*
+ * Linux driver model AC97 bus interface
+ *
+ * Author:	Nicolas Pitre
+ * Created:	Jan 14, 2005
+ * Copyright:	(C) MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/string.h>
+
+/*
+ * Codec families have names seperated by commas, so we search for an
+ * individual codec name within the family string. 
+ */
+static int ac97_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return (strstr(dev->bus_id, drv->name) != NULL);
+}
+
+static int ac97_bus_suspend(struct device *dev, pm_message_t state)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->suspend) {
+		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
+		if (ret == 0)
+			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
+		if (ret == 0)
+			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
+	}
+	return ret;
+}
+
+static int ac97_bus_resume(struct device *dev)
+{
+	int ret = 0;
+
+	if (dev->driver && dev->driver->resume) {
+		ret = dev->driver->resume(dev, RESUME_POWER_ON);
+		if (ret == 0)
+			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
+		if (ret == 0)
+			ret = dev->driver->resume(dev, RESUME_ENABLE);
+	}
+	return ret;
+}
+
+struct bus_type ac97_bus_type = {
+	.name		= "ac97",
+	.match		= ac97_bus_match,
+	.suspend	= ac97_bus_suspend,
+	.resume		= ac97_bus_resume,
+};
+
+static int __init ac97_bus_init(void)
+{
+	return bus_register(&ac97_bus_type);
+}
+
+subsys_initcall(ac97_bus_init);
+
+static void __exit ac97_bus_exit(void)
+{
+	bus_unregister(&ac97_bus_type);
+}
+
+module_exit(ac97_bus_exit);
+
+EXPORT_SYMBOL(ac97_bus_type);
+
+MODULE_LICENSE("GPL");
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -992,6 +992,8 @@ static int snd_ac97_free(ac97_t *ac97)
 {
 	if (ac97) {
 		snd_ac97_proc_done(ac97);
+		if (ac97->dev.bus)
+			device_unregister(&ac97->dev);
 		if (ac97->bus) {
 			ac97->bus->codec[ac97->num] = NULL;
 			if (ac97->bus->shared_type) {
@@ -1007,6 +1009,11 @@ static int snd_ac97_free(ac97_t *ac97)
 	return 0;
 }
 
+/* stop no dev release warning */
+static void ac97_dev_release(struct device * dev)
+{
+}
+
 static int snd_ac97_dev_free(snd_device_t *device)
 {
 	ac97_t *ac97 = device->device_data;
@@ -2117,6 +2136,17 @@ int snd_ac97_mixer(ac97_bus_t *bus, ac97
 		snd_ac97_free(ac97);
 		return err;
 	}
+
+	ac97->dev.bus = &ac97_bus_type;
+	ac97->dev.parent = ac97->bus->card->dev;
+	ac97->dev.platform_data = ac97;
+	ac97->dev.release = ac97_dev_release;
+	strncpy(ac97->dev.bus_id, snd_ac97_get_short_name(ac97), BUS_ID_SIZE);
+	if ((err = device_register(&ac97->dev)) < 0) {
+		ac97->dev.bus = NULL;
+		snd_ac97_free(ac97);
+		return err;
+	}
 	*rac97 = ac97;
 
 	if (bus->shared_type) {
diff --git a/include/sound/ac97_codec.h b/include/sound/ac97_codec.h
--- a/include/sound/ac97_codec.h
+++ b/include/sound/ac97_codec.h
@@ -26,6 +26,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include "pcm.h"
 #include "control.h"
 #include "info.h"
@@ -520,6 +524,7 @@ struct _snd_ac97 {
 	/* jack-sharing info */
 	unsigned char indep_surround;
 	unsigned char channel_mode;
+	struct device dev;
 };
 
 /* conditions */
@@ -599,4 +604,8 @@ struct ac97_enum {
 	unsigned short mask;
 	const char **texts;
 };
+
+/* ad hoc AC97 device driver access */
+extern struct bus_type ac97_bus_type;
+
 #endif /* __SOUND_AC97_CODEC_H */
diff --git a/sound/pci/ac97/Makefile b/sound/pci/ac97/Makefile
--- a/sound/pci/ac97/Makefile
+++ b/sound/pci/ac97/Makefile
@@ -10,9 +10,11 @@ snd-ac97-codec-objs += ac97_proc.o
 endif
 
 snd-ak4531-codec-objs := ak4531_codec.o
+snd-ac97-bus-objs := ac97_bus.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o
 obj-$(CONFIG_SND_ENS1370) += snd-ak4531-codec.o
+obj-$(CONFIG_SND_AC97_BUS) += snd-ac97-bus.o
 
 obj-m := $(sort $(obj-m))

--=-c2uJjmdorrk8x6LBxM8V--



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO September
19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
