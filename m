From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: hda - Make snd_hda_bus_type public
Date: Wed, 18 Mar 2015 16:16:31 +0100
Message-ID: <1426691797-17178-2-git-send-email-tiwai@suse.de>
References: <1426691797-17178-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 13DF1265133
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 16:16:42 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ABD9DAD05
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 15:16:40 +0000 (UTC)
In-Reply-To: <1426691797-17178-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Define the common hd-audio driver and device types to bind over
snd_hda_bus_type publicly.  This allows to implement other type of
device and driver code over hd-audio bus.

Now both struct hda_codec and struct hda_codec_driver inherit these
new struct hdac_device and struct hdac_driver, respectively.

The bus registration is done in subsys_initcall() to assure it
before any other driver registrations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h   | 42 ++++++++++++++++++++++++++++++++++++++++++
 sound/Kconfig             |  2 ++
 sound/Makefile            |  2 +-
 sound/hda/Kconfig         |  2 ++
 sound/hda/Makefile        |  3 +++
 sound/hda/hda_bus_type.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 sound/pci/hda/Kconfig     |  1 +
 sound/pci/hda/hda_bind.c  | 47 ++++++++++++++---------------------------------
 sound/pci/hda/hda_codec.c |  1 +
 sound/pci/hda/hda_codec.h | 11 +++++------
 10 files changed, 113 insertions(+), 40 deletions(-)
 create mode 100644 include/sound/hdaudio.h
 create mode 100644 sound/hda/Kconfig
 create mode 100644 sound/hda/Makefile
 create mode 100644 sound/hda/hda_bus_type.c

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
new file mode 100644
index 000000000000..2381509bee9f
--- /dev/null
+++ b/include/sound/hdaudio.h
@@ -0,0 +1,42 @@
+/*
+ * HD-audio core stuff
+ */
+
+#ifndef __SOUND_HDAUDIO_H
+#define __SOUND_HDAUDIO_H
+
+#include <linux/device.h>
+
+/*
+ * exported bus type
+ */
+extern struct bus_type snd_hda_bus_type;
+
+/*
+ * HD-audio codec base device
+ */
+struct hdac_device {
+	struct device dev;
+	int type;
+};
+
+/* device/driver type used for matching */
+enum {
+	HDA_DEV_CORE,
+	HDA_DEV_LEGACY,
+};
+
+#define dev_to_hdac_dev(_dev)	container_of(_dev, struct hdac_device, dev)
+
+/*
+ * HD-audio codec base driver
+ */
+struct hdac_driver {
+	struct device_driver driver;
+	int type;
+	int (*match)(struct hdac_device *dev, struct hdac_driver *drv);
+};
+
+#define drv_to_hdac_driver(_drv) container_of(_drv, struct hdac_driver, driver)
+
+#endif /* __SOUND_HDAUDIO_H */
diff --git a/sound/Kconfig b/sound/Kconfig
index c710ce2c5c37..5a240e050ae6 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -76,6 +76,8 @@ source "sound/isa/Kconfig"
 
 source "sound/pci/Kconfig"
 
+source "sound/hda/Kconfig"
+
 source "sound/ppc/Kconfig"
 
 source "sound/aoa/Kconfig"
diff --git a/sound/Makefile b/sound/Makefile
index ce9132b1c395..77320709fd26 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_SOUND_PRIME) += sound_firmware.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
 obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
-	firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/
+	firewire/ sparc/ spi/ parisc/ pcmcia/ mips/ soc/ atmel/ hda/
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
new file mode 100644
index 000000000000..4f428ccf64ad
--- /dev/null
+++ b/sound/hda/Kconfig
@@ -0,0 +1,2 @@
+config SND_HDA_CORE
+	tristate
diff --git a/sound/hda/Makefile b/sound/hda/Makefile
new file mode 100644
index 000000000000..59c8d1feb5aa
--- /dev/null
+++ b/sound/hda/Makefile
@@ -0,0 +1,3 @@
+snd-hda-core-objs := hda_bus_type.o
+
+obj-$(CONFIG_SND_HDA_CORE) += snd-hda-core.o
diff --git a/sound/hda/hda_bus_type.c b/sound/hda/hda_bus_type.c
new file mode 100644
index 000000000000..519914a12e8a
--- /dev/null
+++ b/sound/hda/hda_bus_type.c
@@ -0,0 +1,42 @@
+/*
+ * HD-audio bus
+ */
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/export.h>
+#include <sound/hdaudio.h>
+
+MODULE_DESCRIPTION("HD-audio bus");
+MODULE_LICENSE("GPL");
+
+static int hda_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct hdac_device *hdev = dev_to_hdac_dev(dev);
+	struct hdac_driver *hdrv = drv_to_hdac_driver(drv);
+
+	if (hdev->type != hdrv->type)
+		return 0;
+	if (hdrv->match)
+		return hdrv->match(hdev, hdrv);
+	return 1;
+}
+
+struct bus_type snd_hda_bus_type = {
+	.name = "hdaudio",
+	.match = hda_bus_match,
+};
+EXPORT_SYMBOL_GPL(snd_hda_bus_type);
+
+static int __init hda_bus_init(void)
+{
+	return bus_register(&snd_hda_bus_type);
+}
+
+static void __exit hda_bus_exit(void)
+{
+	bus_unregister(&snd_hda_bus_type);
+}
+
+subsys_initcall(hda_bus_init);
+module_exit(hda_bus_exit);
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7f0f2c5a4e97..a5ed1c181784 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -5,6 +5,7 @@ config SND_HDA
 	select SND_PCM
 	select SND_VMASTER
 	select SND_KCTL_JACK
+	select SND_HDA_CORE
 
 config SND_HDA_INTEL
 	tristate "HD Audio PCI"
diff --git a/sound/pci/hda/hda_bind.c b/sound/pci/hda/hda_bind.c
index 1f40ce3c1696..e3bd2807b644 100644
--- a/sound/pci/hda/hda_bind.c
+++ b/sound/pci/hda/hda_bind.c
@@ -47,11 +47,11 @@ static struct hda_vendor_id hda_vendor_ids[] = {
 /*
  * find a matching codec preset
  */
-static int hda_bus_match(struct device *dev, struct device_driver *drv)
+static int hda_codec_match(struct hdac_device *dev, struct hdac_driver *drv)
 {
-	struct hda_codec *codec = container_of(dev, struct hda_codec, dev);
+	struct hda_codec *codec = container_of(dev, struct hda_codec, core);
 	struct hda_codec_driver *driver =
-		container_of(drv, struct hda_codec_driver, driver);
+		container_of(drv, struct hda_codec_driver, core);
 	const struct hda_codec_preset *preset;
 	/* check probe_id instead of vendor_id if set */
 	u32 id = codec->probe_id ? codec->probe_id : codec->vendor_id;
@@ -154,20 +154,22 @@ static void hda_codec_driver_shutdown(struct device *dev)
 int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
 			       struct module *owner)
 {
-	drv->driver.name = name;
-	drv->driver.owner = owner;
-	drv->driver.bus = &snd_hda_bus_type;
-	drv->driver.probe = hda_codec_driver_probe;
-	drv->driver.remove = hda_codec_driver_remove;
-	drv->driver.shutdown = hda_codec_driver_shutdown;
-	drv->driver.pm = &hda_codec_driver_pm;
-	return driver_register(&drv->driver);
+	drv->core.driver.name = name;
+	drv->core.driver.owner = owner;
+	drv->core.driver.bus = &snd_hda_bus_type;
+	drv->core.driver.probe = hda_codec_driver_probe;
+	drv->core.driver.remove = hda_codec_driver_remove;
+	drv->core.driver.shutdown = hda_codec_driver_shutdown;
+	drv->core.driver.pm = &hda_codec_driver_pm;
+	drv->core.type = HDA_DEV_LEGACY;
+	drv->core.match = hda_codec_match;
+	return driver_register(&drv->core.driver);
 }
 EXPORT_SYMBOL_GPL(__hda_codec_driver_register);
 
 void hda_codec_driver_unregister(struct hda_codec_driver *drv)
 {
-	driver_unregister(&drv->driver);
+	driver_unregister(&drv->core.driver);
 }
 EXPORT_SYMBOL_GPL(hda_codec_driver_unregister);
 
@@ -319,24 +321,3 @@ int snd_hda_codec_configure(struct hda_codec *codec)
 	return err;
 }
 EXPORT_SYMBOL_GPL(snd_hda_codec_configure);
-
-/*
- * bus registration
- */
-struct bus_type snd_hda_bus_type = {
-	.name = "hdaudio",
-	.match = hda_bus_match,
-};
-
-static int __init hda_codec_init(void)
-{
-	return bus_register(&snd_hda_bus_type);
-}
-
-static void __exit hda_codec_exit(void)
-{
-	bus_unregister(&snd_hda_bus_type);
-}
-
-module_init(hda_codec_init);
-module_exit(hda_codec_exit);
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 7e38d6f7314b..e14f9f562874 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1294,6 +1294,7 @@ int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,
 	dev_set_name(dev, "hdaudioC%dD%d", card->number, codec_addr);
 	dev_set_drvdata(dev, codec); /* for sysfs */
 	device_enable_async_suspend(dev);
+	codec->core.type = HDA_DEV_LEGACY;
 
 	codec->bus = bus;
 	codec->card = card;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 148e84ce61cf..9874d5b6a8a7 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -26,6 +26,7 @@
 #include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/hwdep.h>
+#include <sound/hdaudio.h>
 #include <sound/hda_verbs.h>
 
 /*
@@ -172,7 +173,7 @@ struct hda_codec_preset {
 #define HDA_CODEC_ID_GENERIC		0x00000201
 
 struct hda_codec_driver {
-	struct device_driver driver;
+	struct hdac_driver core;
 	const struct hda_codec_preset *preset;
 };
 
@@ -276,7 +277,7 @@ struct hda_pcm {
 
 /* codec information */
 struct hda_codec {
-	struct device dev;
+	struct hdac_device core;
 	struct hda_bus *bus;
 	struct snd_card *card;
 	unsigned int addr;	/* codec addr*/
@@ -409,10 +410,8 @@ struct hda_codec {
 	struct snd_array verbs;
 };
 
-#define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, dev)
-#define hda_codec_dev(_dev)	(&(_dev)->dev)
-
-extern struct bus_type snd_hda_bus_type;
+#define dev_to_hda_codec(_dev)	container_of(_dev, struct hda_codec, core.dev)
+#define hda_codec_dev(_dev)	(&(_dev)->core.dev)
 
 /* direction */
 enum {
-- 
2.3.3
