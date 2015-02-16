From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/6] ALSA: seq: Define driver object in each
	driver
Date: Mon, 16 Feb 2015 17:55:43 +0100
Message-ID: <1424105744-2187-6-git-send-email-tiwai@suse.de>
References: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F38132606A6
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:45 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B95B9ACF2
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 16:55:45 +0000 (UTC)
In-Reply-To: <1424105744-2187-1-git-send-email-tiwai@suse.de>
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

This patch moves the driver object initialization and allocation to
each driver's module init/exit code like other normal drivers.  The
snd_seq_driver struct is now published in seq_device.h, and each
driver is responsible to define it with proper driver attributes
(name, probe and remove) with snd_seq_driver specific attributes as id
and argsize fields.  The helper functions snd_seq_driver_register(),
snd_seq_driver_unregister() and module_snd_seq_driver() are used for
simplifying codes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_device.h         | 27 +++++++----
 sound/core/seq/oss/seq_oss.c       | 20 +++++---
 sound/core/seq/oss/seq_oss_synth.c |  6 ++-
 sound/core/seq/oss/seq_oss_synth.h |  4 +-
 sound/core/seq/seq_device.c        | 93 ++++----------------------------------
 sound/core/seq/seq_midi.c          | 28 ++++++++----
 sound/drivers/opl3/opl3_seq.c      | 34 ++++++--------
 sound/drivers/opl4/opl4_seq.c      | 33 ++++++--------
 sound/isa/sb/emu8000_synth.c       | 35 ++++++--------
 sound/pci/emu10k1/emu10k1_synth.c  | 35 ++++++--------
 10 files changed, 124 insertions(+), 191 deletions(-)

diff --git a/include/sound/seq_device.h b/include/sound/seq_device.h
index b13cd2930d32..ddc0d504cf39 100644
--- a/include/sound/seq_device.h
+++ b/include/sound/seq_device.h
@@ -41,8 +41,10 @@ struct snd_seq_device {
 #define to_seq_dev(_dev) \
 	container_of(_dev, struct snd_seq_device, dev)
 
+/* sequencer driver */
+
 /* driver operators
- * init_device:
+ * probe:
  *	Initialize the device with given parameters.
  *	Typically,
  *		1. call snd_hwdep_new
@@ -50,15 +52,19 @@ struct snd_seq_device {
  *		3. call snd_hwdep_register
  *		4. store the instance to dev->driver_data pointer.
  *		
- * free_device:
+ * remove:
  *	Release the private data.
  *	Typically, call snd_device_free(dev->card, dev->driver_data)
  */
-struct snd_seq_dev_ops {
-	int (*init_device)(struct snd_seq_device *dev);
-	int (*free_device)(struct snd_seq_device *dev);
+struct snd_seq_driver {
+	struct device_driver driver;
+	char *id;
+	int argsize;
 };
 
+#define to_seq_drv(_drv) \
+	container_of(_drv, struct snd_seq_driver, driver)
+
 /*
  * prototypes
  */
@@ -69,12 +75,17 @@ void snd_seq_device_load_drivers(void);
 #endif
 int snd_seq_device_new(struct snd_card *card, int device, const char *id,
 		       int argsize, struct snd_seq_device **result);
-int snd_seq_device_register_driver(const char *id,
-				   struct snd_seq_dev_ops *entry, int argsize);
-int snd_seq_device_unregister_driver(const char *id);
 
 #define SNDRV_SEQ_DEVICE_ARGPTR(dev) (void *)((char *)(dev) + sizeof(struct snd_seq_device))
 
+int __must_check __snd_seq_driver_register(struct snd_seq_driver *drv,
+					   struct module *mod);
+#define snd_seq_driver_register(drv) \
+	__snd_seq_driver_register(drv, THIS_MODULE)
+void snd_seq_driver_unregister(struct snd_seq_driver *drv);
+
+#define module_snd_seq_driver(drv) \
+	module_driver(drv, snd_seq_driver_register, snd_seq_driver_unregister)
 
 /*
  * id strings for generic devices
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index 16d42679e43f..ae1814aa767e 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -65,13 +65,19 @@ static unsigned int odev_poll(struct file *file, poll_table * wait);
  * module interface
  */
 
+static struct snd_seq_driver seq_oss_synth_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe = snd_seq_oss_synth_probe,
+		.remove = snd_seq_oss_synth_remove,
+	},
+	.id = SNDRV_SEQ_DEV_ID_OSS,
+	.argsize = sizeof(struct snd_seq_oss_reg),
+};
+
 static int __init alsa_seq_oss_init(void)
 {
 	int rc;
-	static struct snd_seq_dev_ops ops = {
-		snd_seq_oss_synth_register,
-		snd_seq_oss_synth_unregister,
-	};
 
 	snd_seq_autoload_lock();
 	if ((rc = register_device()) < 0)
@@ -86,8 +92,8 @@ static int __init alsa_seq_oss_init(void)
 		goto error;
 	}
 
-	if ((rc = snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_OSS, &ops,
-						 sizeof(struct snd_seq_oss_reg))) < 0) {
+	rc = snd_seq_driver_register(&seq_oss_synth_driver);
+	if (rc < 0) {
 		snd_seq_oss_delete_client();
 		unregister_proc();
 		unregister_device();
@@ -104,7 +110,7 @@ static int __init alsa_seq_oss_init(void)
 
 static void __exit alsa_seq_oss_exit(void)
 {
-	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_OSS);
+	snd_seq_driver_unregister(&seq_oss_synth_driver);
 	snd_seq_oss_delete_client();
 	unregister_proc();
 	unregister_device();
diff --git a/sound/core/seq/oss/seq_oss_synth.c b/sound/core/seq/oss/seq_oss_synth.c
index 701feb71b700..835edc80f918 100644
--- a/sound/core/seq/oss/seq_oss_synth.c
+++ b/sound/core/seq/oss/seq_oss_synth.c
@@ -98,8 +98,9 @@ snd_seq_oss_synth_init(void)
  * registration of the synth device
  */
 int
-snd_seq_oss_synth_register(struct snd_seq_device *dev)
+snd_seq_oss_synth_probe(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	int i;
 	struct seq_oss_synth *rec;
 	struct snd_seq_oss_reg *reg = SNDRV_SEQ_DEVICE_ARGPTR(dev);
@@ -149,8 +150,9 @@ snd_seq_oss_synth_register(struct snd_seq_device *dev)
 
 
 int
-snd_seq_oss_synth_unregister(struct snd_seq_device *dev)
+snd_seq_oss_synth_remove(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	int index;
 	struct seq_oss_synth *rec = dev->driver_data;
 	unsigned long flags;
diff --git a/sound/core/seq/oss/seq_oss_synth.h b/sound/core/seq/oss/seq_oss_synth.h
index dbdfcbb80eaa..74ac55f166b6 100644
--- a/sound/core/seq/oss/seq_oss_synth.h
+++ b/sound/core/seq/oss/seq_oss_synth.h
@@ -28,8 +28,8 @@
 #include <sound/seq_device.h>
 
 void snd_seq_oss_synth_init(void);
-int snd_seq_oss_synth_register(struct snd_seq_device *dev);
-int snd_seq_oss_synth_unregister(struct snd_seq_device *dev);
+int snd_seq_oss_synth_probe(struct device *dev);
+int snd_seq_oss_synth_remove(struct device *dev);
 void snd_seq_oss_synth_setup(struct seq_oss_devinfo *dp);
 void snd_seq_oss_synth_setup_midi(struct seq_oss_devinfo *dp);
 void snd_seq_oss_synth_cleanup(struct seq_oss_devinfo *dp);
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 49daf6e3a387..48b20f009598 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -52,16 +52,6 @@ MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA sequencer device management");
 MODULE_LICENSE("GPL");
 
-struct snd_seq_driver {
-	struct device_driver driver;
-	const char *id;
-	int argsize;
-	struct snd_seq_dev_ops ops;
-};
-
-#define to_seq_drv(_drv) \
-	container_of(_drv, struct snd_seq_driver, driver)
-
 /*
  * bus definition
  */
@@ -263,86 +253,23 @@ int snd_seq_device_new(struct snd_card *card, int device, const char *id,
 EXPORT_SYMBOL(snd_seq_device_new);
 
 /*
- * driver binding - just pass to each driver callback
+ * driver registration
  */
-static int snd_seq_drv_probe(struct device *dev)
+int __snd_seq_driver_register(struct snd_seq_driver *drv, struct module *mod)
 {
-	struct snd_seq_driver *sdrv = to_seq_drv(dev->driver);
-	struct snd_seq_device *sdev = to_seq_dev(dev);
-
-	return sdrv->ops.init_device(sdev);
-}
-
-static int snd_seq_drv_remove(struct device *dev)
-{
-	struct snd_seq_driver *sdrv = to_seq_drv(dev->driver);
-	struct snd_seq_device *sdev = to_seq_dev(dev);
-
-	return sdrv->ops.free_device(sdev);
-}
-
-/*
- * register device driver
- * id = driver id
- * entry = driver operators - duplicated to each instance
- */
-int snd_seq_device_register_driver(const char *id,
-				   struct snd_seq_dev_ops *entry, int argsize)
-{
-	struct snd_seq_driver *sdrv;
-	int err;
-
-	if (id == NULL || entry == NULL ||
-	    entry->init_device == NULL || entry->free_device == NULL)
+	if (WARN_ON(!drv->driver.name || !drv->id))
 		return -EINVAL;
-
-	sdrv = kzalloc(sizeof(*sdrv), GFP_KERNEL);
-	if (!sdrv)
-		return -ENOMEM;
-
-	sdrv->driver.name = id;
-	sdrv->driver.bus = &snd_seq_bus_type;
-	sdrv->driver.probe = snd_seq_drv_probe;
-	sdrv->driver.remove = snd_seq_drv_remove;
-	sdrv->id = id;
-	sdrv->argsize = argsize;
-	sdrv->ops = *entry;
-
-	err = driver_register(&sdrv->driver);
-	if (err < 0)
-		kfree(sdrv);
-	return err;
-}
-EXPORT_SYMBOL(snd_seq_device_register_driver);
-
-/* callback to find a specific driver; data is a pointer to the id string ptr.
- * when the id matches, store the driver pointer in return and break the loop.
- */
-static int find_drv(struct device_driver *drv, void *data)
-{
-	struct snd_seq_driver *sdrv = to_seq_drv(drv);
-	void **ptr = (void **)data;
-
-	if (strcmp(sdrv->id, *ptr))
-		return 0; /* id don't match, continue the loop */
-	*ptr = sdrv;
-	return 1; /* break the loop */
+	drv->driver.bus = &snd_seq_bus_type;
+	drv->driver.owner = mod;
+	return driver_register(&drv->driver);
 }
+EXPORT_SYMBOL_GPL(__snd_seq_driver_register);
 
-/*
- * unregister the specified driver
- */
-int snd_seq_device_unregister_driver(const char *id)
+void snd_seq_driver_unregister(struct snd_seq_driver *drv)
 {
-	struct snd_seq_driver *sdrv = (struct snd_seq_driver *)id;
-
-	if (!bus_for_each_drv(&snd_seq_bus_type, NULL, &sdrv, find_drv))
-		return -ENXIO;
-	driver_unregister(&sdrv->driver);
-	kfree(sdrv);
-	return 0;
+	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL(snd_seq_device_unregister_driver);
+EXPORT_SYMBOL_GPL(snd_seq_driver_unregister);
 
 /*
  * module part
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 68fec776da26..79c73119cedc 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -273,8 +273,9 @@ static void snd_seq_midisynth_delete(struct seq_midisynth *msynth)
 
 /* register new midi synth port */
 static int
-snd_seq_midisynth_register_port(struct snd_seq_device *dev)
+snd_seq_midisynth_probe(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct seq_midisynth_client *client;
 	struct seq_midisynth *msynth, *ms;
 	struct snd_seq_port_info *port;
@@ -427,8 +428,9 @@ snd_seq_midisynth_register_port(struct snd_seq_device *dev)
 
 /* release midi synth port */
 static int
-snd_seq_midisynth_unregister_port(struct snd_seq_device *dev)
+snd_seq_midisynth_remove(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct seq_midisynth_client *client;
 	struct seq_midisynth *msynth;
 	struct snd_card *card = dev->card;
@@ -457,23 +459,29 @@ snd_seq_midisynth_unregister_port(struct snd_seq_device *dev)
 	return 0;
 }
 
+static struct snd_seq_driver seq_midisynth_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe = snd_seq_midisynth_probe,
+		.remove = snd_seq_midisynth_remove,
+	},
+	.id = SNDRV_SEQ_DEV_ID_MIDISYNTH,
+	.argsize = 0,
+};
 
 static int __init alsa_seq_midi_init(void)
 {
-	static struct snd_seq_dev_ops ops = {
-		snd_seq_midisynth_register_port,
-		snd_seq_midisynth_unregister_port,
-	};
-	memset(&synths, 0, sizeof(synths));
+	int err;
+
 	snd_seq_autoload_lock();
-	snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_MIDISYNTH, &ops, 0);
+	err = snd_seq_driver_register(&seq_midisynth_driver);
 	snd_seq_autoload_unlock();
-	return 0;
+	return err;
 }
 
 static void __exit alsa_seq_midi_exit(void)
 {
-	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_MIDISYNTH);
+	snd_seq_driver_unregister(&seq_midisynth_driver);
 }
 
 module_init(alsa_seq_midi_init)
diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index a9f618e06a22..fdae5d7f421f 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -216,8 +216,9 @@ static int snd_opl3_synth_create_port(struct snd_opl3 * opl3)
 
 /* ------------------------------ */
 
-static int snd_opl3_seq_new_device(struct snd_seq_device *dev)
+static int snd_opl3_seq_probe(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_opl3 *opl3;
 	int client, err;
 	char name[32];
@@ -257,8 +258,9 @@ static int snd_opl3_seq_new_device(struct snd_seq_device *dev)
 	return 0;
 }
 
-static int snd_opl3_seq_delete_device(struct snd_seq_device *dev)
+static int snd_opl3_seq_remove(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_opl3 *opl3;
 
 	opl3 = *(struct snd_opl3 **)SNDRV_SEQ_DEVICE_ARGPTR(dev);
@@ -275,22 +277,14 @@ static int snd_opl3_seq_delete_device(struct snd_seq_device *dev)
 	return 0;
 }
 
-static int __init alsa_opl3_seq_init(void)
-{
-	static struct snd_seq_dev_ops ops =
-	{
-		snd_opl3_seq_new_device,
-		snd_opl3_seq_delete_device
-	};
-
-	return snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_OPL3, &ops,
-					      sizeof(struct snd_opl3 *));
-}
-
-static void __exit alsa_opl3_seq_exit(void)
-{
-	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_OPL3);
-}
+static struct snd_seq_driver opl3_seq_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe = snd_opl3_seq_probe,
+		.remove = snd_opl3_seq_remove,
+	},
+	.id = SNDRV_SEQ_DEV_ID_OPL3,
+	.argsize = sizeof(struct snd_opl3 *),
+};
 
-module_init(alsa_opl3_seq_init)
-module_exit(alsa_opl3_seq_exit)
+module_snd_seq_driver(opl3_seq_driver);
diff --git a/sound/drivers/opl4/opl4_seq.c b/sound/drivers/opl4/opl4_seq.c
index 99197699c55a..03d6202f4829 100644
--- a/sound/drivers/opl4/opl4_seq.c
+++ b/sound/drivers/opl4/opl4_seq.c
@@ -124,8 +124,9 @@ static void snd_opl4_seq_free_port(void *private_data)
 	snd_midi_channel_free_set(opl4->chset);
 }
 
-static int snd_opl4_seq_new_device(struct snd_seq_device *dev)
+static int snd_opl4_seq_probe(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_opl4 *opl4;
 	int client;
 	struct snd_seq_port_callback pcallbacks;
@@ -180,8 +181,9 @@ static int snd_opl4_seq_new_device(struct snd_seq_device *dev)
 	return 0;
 }
 
-static int snd_opl4_seq_delete_device(struct snd_seq_device *dev)
+static int snd_opl4_seq_remove(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_opl4 *opl4;
 
 	opl4 = *(struct snd_opl4 **)SNDRV_SEQ_DEVICE_ARGPTR(dev);
@@ -195,21 +197,14 @@ static int snd_opl4_seq_delete_device(struct snd_seq_device *dev)
 	return 0;
 }
 
-static int __init alsa_opl4_synth_init(void)
-{
-	static struct snd_seq_dev_ops ops = {
-		snd_opl4_seq_new_device,
-		snd_opl4_seq_delete_device
-	};
-
-	return snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_OPL4, &ops,
-					      sizeof(struct snd_opl4 *));
-}
-
-static void __exit alsa_opl4_synth_exit(void)
-{
-	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_OPL4);
-}
+static struct snd_seq_driver opl4_seq_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe = snd_opl4_seq_probe,
+		.remove = snd_opl4_seq_remove,
+	},
+	.id = SNDRV_SEQ_DEV_ID_OPL4,
+	.argsize = sizeof(struct snd_opl4 *),
+};
 
-module_init(alsa_opl4_synth_init)
-module_exit(alsa_opl4_synth_exit)
+module_snd_seq_driver(opl4_seq_driver);
diff --git a/sound/isa/sb/emu8000_synth.c b/sound/isa/sb/emu8000_synth.c
index 72332dfada9a..4aa719cad331 100644
--- a/sound/isa/sb/emu8000_synth.c
+++ b/sound/isa/sb/emu8000_synth.c
@@ -34,8 +34,9 @@ MODULE_LICENSE("GPL");
 /*
  * create a new hardware dependent device for Emu8000
  */
-static int snd_emu8000_new_device(struct snd_seq_device *dev)
+static int snd_emu8000_probe(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_emu8000 *hw;
 	struct snd_emux *emu;
 
@@ -93,8 +94,9 @@ static int snd_emu8000_new_device(struct snd_seq_device *dev)
 /*
  * free all resources
  */
-static int snd_emu8000_delete_device(struct snd_seq_device *dev)
+static int snd_emu8000_remove(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_emu8000 *hw;
 
 	if (dev->driver_data == NULL)
@@ -114,21 +116,14 @@ static int snd_emu8000_delete_device(struct snd_seq_device *dev)
  *  INIT part
  */
 
-static int __init alsa_emu8000_init(void)
-{
-	
-	static struct snd_seq_dev_ops ops = {
-		snd_emu8000_new_device,
-		snd_emu8000_delete_device,
-	};
-	return snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_EMU8000, &ops,
-					      sizeof(struct snd_emu8000*));
-}
-
-static void __exit alsa_emu8000_exit(void)
-{
-	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_EMU8000);
-}
-
-module_init(alsa_emu8000_init)
-module_exit(alsa_emu8000_exit)
+static struct snd_seq_driver emu8000_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe = snd_emu8000_probe,
+		.remove = snd_emu8000_remove,
+	},
+	.id = SNDRV_SEQ_DEV_ID_EMU8000,
+	.argsize = sizeof(struct snd_emu8000 *),
+};
+
+module_snd_seq_driver(emu8000_driver);
diff --git a/sound/pci/emu10k1/emu10k1_synth.c b/sound/pci/emu10k1/emu10k1_synth.c
index 4c41c903a840..5457d5613f6b 100644
--- a/sound/pci/emu10k1/emu10k1_synth.c
+++ b/sound/pci/emu10k1/emu10k1_synth.c
@@ -29,8 +29,9 @@ MODULE_LICENSE("GPL");
 /*
  * create a new hardware dependent device for Emu10k1
  */
-static int snd_emu10k1_synth_new_device(struct snd_seq_device *dev)
+static int snd_emu10k1_synth_probe(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_emux *emux;
 	struct snd_emu10k1 *hw;
 	struct snd_emu10k1_synth_arg *arg;
@@ -79,8 +80,9 @@ static int snd_emu10k1_synth_new_device(struct snd_seq_device *dev)
 	return 0;
 }
 
-static int snd_emu10k1_synth_delete_device(struct snd_seq_device *dev)
+static int snd_emu10k1_synth_remove(struct device *_dev)
 {
+	struct snd_seq_device *dev = to_seq_dev(_dev);
 	struct snd_emux *emux;
 	struct snd_emu10k1 *hw;
 	unsigned long flags;
@@ -104,21 +106,14 @@ static int snd_emu10k1_synth_delete_device(struct snd_seq_device *dev)
  *  INIT part
  */
 
-static int __init alsa_emu10k1_synth_init(void)
-{
-	
-	static struct snd_seq_dev_ops ops = {
-		snd_emu10k1_synth_new_device,
-		snd_emu10k1_synth_delete_device,
-	};
-	return snd_seq_device_register_driver(SNDRV_SEQ_DEV_ID_EMU10K1_SYNTH, &ops,
-					      sizeof(struct snd_emu10k1_synth_arg));
-}
-
-static void __exit alsa_emu10k1_synth_exit(void)
-{
-	snd_seq_device_unregister_driver(SNDRV_SEQ_DEV_ID_EMU10K1_SYNTH);
-}
-
-module_init(alsa_emu10k1_synth_init)
-module_exit(alsa_emu10k1_synth_exit)
+static struct snd_seq_driver emu10k1_synth_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.probe = snd_emu10k1_synth_probe,
+		.remove = snd_emu10k1_synth_remove,
+	},
+	.id = SNDRV_SEQ_DEV_ID_EMU10K1_SYNTH,
+	.argsize = sizeof(struct snd_emu10k1_synth_arg),
+};
+
+module_snd_seq_driver(emu10k1_synth_driver);
-- 
2.3.0
