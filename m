From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/6] ALSA: seq: Rewrite sequencer device
	binding with standard bus
Date: Mon, 16 Feb 2015 17:55:41 +0100
Message-ID: <1424105744-2187-4-git-send-email-tiwai@suse.de>
References: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F2D42606AD
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:46 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B92BDABB1
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

We've used the old house-made code for binding the sequencer device
and driver.  This can be far better implemented with the standard
bus nowadays.

This patch refactors the whole sequencer binding code with the bus
/sys/bus/snd_seq.  The devices appear as id-card-device on this bus
and are bound with the drivers corresponding to the given id like the
former implementation.  The module autoload is also kept like before.

There is no change in API functions by this patch, and almost all
transitions are kept inside seq_device.c.  The proc file output will
change slightly but kept compatible as much as possible.

Further integration works will follow in later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_device.h  |   3 +
 sound/core/seq/seq_device.c | 541 ++++++++++++++------------------------------
 2 files changed, 170 insertions(+), 374 deletions(-)

diff --git a/include/sound/seq_device.h b/include/sound/seq_device.h
index d52433563da2..ea256b825146 100644
--- a/include/sound/seq_device.h
+++ b/include/sound/seq_device.h
@@ -43,8 +43,11 @@ struct snd_seq_device {
 	void *private_data;	/* private data for the caller */
 	void (*private_free)(struct snd_seq_device *device);
 	struct list_head list;	/* link to next device */
+	struct device dev;
 };
 
+#define to_seq_dev(_dev) \
+	container_of(_dev, struct snd_seq_device, dev)
 
 /* driver operators
  * init_device:
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 075a66c0cc6a..d3320ffe43c2 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -36,6 +36,7 @@
  *
  */
 
+#include <linux/device.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <sound/core.h>
@@ -51,77 +52,57 @@ MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ALSA sequencer device management");
 MODULE_LICENSE("GPL");
 
-/* driver state */
-#define DRIVER_EMPTY		0
-#define DRIVER_LOADED		(1<<0)
-#define DRIVER_REQUESTED	(1<<1)
-#define DRIVER_LOCKED		(1<<2)
-#define DRIVER_REQUESTING	(1<<3)
+struct snd_seq_driver {
+	struct device_driver driver;
+	char id[ID_LEN];
+	int argsize;
+	struct snd_seq_dev_ops ops;
+};
 
-struct ops_list {
-	char id[ID_LEN];	/* driver id */
-	int driver;		/* driver state */
-	int used;		/* reference counter */
-	int argsize;		/* argument size */
+#define to_seq_drv(_drv) \
+	container_of(_drv, struct snd_seq_driver, driver)
 
-	/* operators */
-	struct snd_seq_dev_ops ops;
+/*
+ * bus definition
+ */
+static int snd_seq_bus_match(struct device *dev, struct device_driver *drv)
+{
+	struct snd_seq_device *sdev = to_seq_dev(dev);
+	struct snd_seq_driver *sdrv = to_seq_drv(drv);
 
-	/* registered devices */
-	struct list_head dev_list;	/* list of devices */
-	int num_devices;	/* number of associated devices */
-	int num_init_devices;	/* number of initialized devices */
-	struct mutex reg_mutex;
+	return strcmp(sdrv->id, sdev->id) == 0 &&
+		sdrv->argsize == sdev->argsize;
+}
 
-	struct list_head list;	/* next driver */
+static struct bus_type snd_seq_bus_type = {
+	.name = "snd_seq",
+	.match = snd_seq_bus_match,
 };
 
-
-static LIST_HEAD(opslist);
-static int num_ops;
-static DEFINE_MUTEX(ops_mutex);
+/*
+ * proc interface -- just for compatibility
+ */
 #ifdef CONFIG_PROC_FS
 static struct snd_info_entry *info_entry;
-#endif
 
-/*
- * prototypes
- */
-static int snd_seq_device_free(struct snd_seq_device *dev);
-static int snd_seq_device_dev_free(struct snd_device *device);
-static int snd_seq_device_dev_register(struct snd_device *device);
-static int snd_seq_device_dev_disconnect(struct snd_device *device);
-
-static int init_device(struct snd_seq_device *dev, struct ops_list *ops);
-static int free_device(struct snd_seq_device *dev, struct ops_list *ops);
-static struct ops_list *find_driver(char *id, int create_if_empty);
-static struct ops_list *create_driver(char *id);
-static void unlock_driver(struct ops_list *ops);
-static void remove_drivers(void);
+static int print_dev_info(struct device *dev, void *data)
+{
+	struct snd_seq_device *sdev = to_seq_dev(dev);
+	struct snd_info_buffer *buffer = data;
 
-/*
- * show all drivers and their status
- */
+	snd_iprintf(buffer, "snd-%s,%s,%d\n", sdev->id,
+		    dev->driver ? "loaded" : "empty",
+		    dev->driver ? 1 : 0);
+	return 0;
+}
 
-#ifdef CONFIG_PROC_FS
 static void snd_seq_device_info(struct snd_info_entry *entry,
 				struct snd_info_buffer *buffer)
 {
-	struct ops_list *ops;
-
-	mutex_lock(&ops_mutex);
-	list_for_each_entry(ops, &opslist, list) {
-		snd_iprintf(buffer, "snd-%s%s%s%s,%d\n",
-				ops->id,
-				ops->driver & DRIVER_LOADED ? ",loaded" : (ops->driver == DRIVER_EMPTY ? ",empty" : ""),
-				ops->driver & DRIVER_REQUESTED ? ",requested" : "",
-				ops->driver & DRIVER_LOCKED ? ",locked" : "",
-				ops->num_devices);
-	}
-	mutex_unlock(&ops_mutex);
+	bus_for_each_dev(&snd_seq_bus_type, NULL, buffer, print_dev_info);
 }
 #endif
- 
+
 /*
  * load all registered drivers (called from seq_clientmgr.c)
  */
@@ -141,52 +122,29 @@ void snd_seq_autoload_unlock(void)
 }
 EXPORT_SYMBOL(snd_seq_autoload_unlock);
 
-static void autoload_drivers(void)
+static int request_seq_drv(struct device *dev, void *data)
 {
-	/* avoid reentrance */
-	if (atomic_inc_return(&snd_seq_in_init) == 1) {
-		struct ops_list *ops;
-
-		mutex_lock(&ops_mutex);
-		list_for_each_entry(ops, &opslist, list) {
-			if ((ops->driver & DRIVER_REQUESTING) &&
-			    !(ops->driver & DRIVER_REQUESTED)) {
-				ops->used++;
-				mutex_unlock(&ops_mutex);
-				ops->driver |= DRIVER_REQUESTED;
-				request_module("snd-%s", ops->id);
-				mutex_lock(&ops_mutex);
-				ops->used--;
-			}
-		}
-		mutex_unlock(&ops_mutex);
-	}
-	atomic_dec(&snd_seq_in_init);
-}
+	struct snd_seq_device *sdev = to_seq_dev(dev);
 
-static void call_autoload(struct work_struct *work)
-{
-	autoload_drivers();
+	if (!dev->driver)
+		request_module("snd-%s", sdev->id);
+	return 0;
 }
 
-static DECLARE_WORK(autoload_work, call_autoload);
-
-static void try_autoload(struct ops_list *ops)
+static void autoload_drivers(struct work_struct *work)
 {
-	if (!ops->driver) {
-		ops->driver |= DRIVER_REQUESTING;
-		schedule_work(&autoload_work);
-	}
+	/* avoid reentrance */
+	if (atomic_inc_return(&snd_seq_in_init) == 1)
+		bus_for_each_dev(&snd_seq_bus_type, NULL, NULL,
+				 request_seq_drv);
+	atomic_dec(&snd_seq_in_init);
 }
 
+static DECLARE_WORK(autoload_work, autoload_drivers);
+
 static void queue_autoload_drivers(void)
 {
-	struct ops_list *ops;
-
-	mutex_lock(&ops_mutex);
-	list_for_each_entry(ops, &opslist, list)
-		try_autoload(ops);
-	mutex_unlock(&ops_mutex);
+	schedule_work(&autoload_work);
 }
 
 void snd_seq_autoload_init(void)
@@ -206,10 +164,51 @@ void snd_seq_device_load_drivers(void)
 }
 EXPORT_SYMBOL(snd_seq_device_load_drivers);
 #else
-#define try_autoload(ops) /* NOP */
+#define queue_autoload_drivers() /* NOP */
 #endif
 
 /*
+ * device management
+ */
+static int snd_seq_device_dev_free(struct snd_device *device)
+{
+	struct snd_seq_device *dev = device->device_data;
+
+	put_device(&dev->dev);
+	return 0;
+}
+
+static int snd_seq_device_dev_register(struct snd_device *device)
+{
+	struct snd_seq_device *dev = device->device_data;
+	int err;
+
+	err = device_add(&dev->dev);
+	if (err < 0)
+		return err;
+	if (!dev->dev.driver)
+		queue_autoload_drivers();
+	return 0;
+}
+
+static int snd_seq_device_dev_disconnect(struct snd_device *device)
+{
+	struct snd_seq_device *dev = device->device_data;
+
+	device_del(&dev->dev);
+	return 0;
+}
+
+static void snd_seq_dev_release(struct device *dev)
+{
+	struct snd_seq_device *sdev = to_seq_dev(dev);
+
+	if (sdev->private_free)
+		sdev->private_free(sdev);
+	kfree(sdev);
+}
+
+/*
  * register a sequencer device
  * card = card info
  * device = device number (if any)
@@ -220,7 +219,6 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 		       struct snd_seq_device **result)
 {
 	struct snd_seq_device *dev;
-	struct ops_list *ops;
 	int err;
 	static struct snd_device_ops dops = {
 		.dev_free = snd_seq_device_dev_free,
@@ -234,15 +232,9 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 	if (snd_BUG_ON(!id))
 		return -EINVAL;
 
-	ops = find_driver(id, 1);
-	if (ops == NULL)
-		return -ENOMEM;
-
-	dev = kzalloc(sizeof(*dev)*2 + argsize, GFP_KERNEL);
-	if (dev == NULL) {
-		unlock_driver(ops);
+	dev = kzalloc(sizeof(*dev) + argsize, GFP_KERNEL);
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	/* set up device info */
 	dev->card = card;
@@ -251,20 +243,19 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 	dev->argsize = argsize;
 	dev->status = SNDRV_SEQ_DEVICE_FREE;
 
-	/* add this device to the list */
-	mutex_lock(&ops->reg_mutex);
-	list_add_tail(&dev->list, &ops->dev_list);
-	ops->num_devices++;
-	mutex_unlock(&ops->reg_mutex);
+	device_initialize(&dev->dev);
+	dev->dev.parent = &card->card_dev;
+	dev->dev.bus = &snd_seq_bus_type;
+	dev->dev.release = snd_seq_dev_release;
+	dev_set_name(&dev->dev, "%s-%d-%d", dev->id, card->number, device);
 
-	if ((err = snd_device_new(card, SNDRV_DEV_SEQUENCER, dev, &dops)) < 0) {
-		snd_seq_device_free(dev);
+	/* add this device to the list */
+	err = snd_device_new(card, SNDRV_DEV_SEQUENCER, dev, &dops);
+	if (err < 0) {
+		put_device(&dev->dev);
 		return err;
 	}
 	
-	try_autoload(ops);
-	unlock_driver(ops);
-
 	if (result)
 		*result = dev;
 
@@ -273,82 +264,33 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 EXPORT_SYMBOL(snd_seq_device_new);
 
 /*
- * free the existing device
- */
-static int snd_seq_device_free(struct snd_seq_device *dev)
-{
-	struct ops_list *ops;
-
-	if (snd_BUG_ON(!dev))
-		return -EINVAL;
-
-	ops = find_driver(dev->id, 0);
-	if (ops == NULL)
-		return -ENXIO;
-
-	/* remove the device from the list */
-	mutex_lock(&ops->reg_mutex);
-	list_del(&dev->list);
-	ops->num_devices--;
-	mutex_unlock(&ops->reg_mutex);
-
-	free_device(dev, ops);
-	if (dev->private_free)
-		dev->private_free(dev);
-	kfree(dev);
-
-	unlock_driver(ops);
-
-	return 0;
-}
-
-static int snd_seq_device_dev_free(struct snd_device *device)
-{
-	struct snd_seq_device *dev = device->device_data;
-	return snd_seq_device_free(dev);
-}
-
-/*
- * register the device
+ * driver binding - just pass to each driver callback
  */
-static int snd_seq_device_dev_register(struct snd_device *device)
+static int snd_seq_drv_probe(struct device *dev)
 {
-	struct snd_seq_device *dev = device->device_data;
-	struct ops_list *ops;
-
-	ops = find_driver(dev->id, 0);
-	if (ops == NULL)
-		return -ENOENT;
-
-	/* initialize this device if the corresponding driver was
-	 * already loaded
-	 */
-	if (ops->driver & DRIVER_LOADED)
-		init_device(dev, ops);
+	struct snd_seq_driver *sdrv = to_seq_drv(dev->driver);
+	struct snd_seq_device *sdev = to_seq_dev(dev);
+	int err;
 
-	unlock_driver(ops);
+	err = sdrv->ops.init_device(sdev);
+	if (err < 0)
+		return err;
+	sdev->status = SNDRV_SEQ_DEVICE_REGISTERED;
 	return 0;
 }
-EXPORT_SYMBOL(snd_seq_device_register_driver);
 
-/*
- * disconnect the device
- */
-static int snd_seq_device_dev_disconnect(struct snd_device *device)
+static int snd_seq_drv_remove(struct device *dev)
 {
-	struct snd_seq_device *dev = device->device_data;
-	struct ops_list *ops;
-
-	ops = find_driver(dev->id, 0);
-	if (ops == NULL)
-		return -ENOENT;
-
-	free_device(dev, ops);
+	struct snd_seq_driver *sdrv = to_seq_drv(dev->driver);
+	struct snd_seq_device *sdev = to_seq_dev(dev);
+	int err;
 
-	unlock_driver(ops);
+	err = sdrv->ops.free_device(sdev);
+	if (err < 0)
+		return err;
+	sdev->status = SNDRV_SEQ_DEVICE_FREE;
 	return 0;
 }
-EXPORT_SYMBOL(snd_seq_device_unregister_driver);
 
 /*
  * register device driver
@@ -358,226 +300,66 @@ EXPORT_SYMBOL(snd_seq_device_unregister_driver);
 int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry,
 				   int argsize)
 {
-	struct ops_list *ops;
-	struct snd_seq_device *dev;
+	struct snd_seq_driver *sdrv;
+	int err;
 
 	if (id == NULL || entry == NULL ||
 	    entry->init_device == NULL || entry->free_device == NULL)
 		return -EINVAL;
 
-	ops = find_driver(id, 1);
-	if (ops == NULL)
+	sdrv = kzalloc(sizeof(*sdrv), GFP_KERNEL);
+	if (!sdrv)
 		return -ENOMEM;
-	if (ops->driver & DRIVER_LOADED) {
-		pr_warn("ALSA: seq: driver_register: driver '%s' already exists\n", id);
-		unlock_driver(ops);
-		return -EBUSY;
-	}
-
-	mutex_lock(&ops->reg_mutex);
-	/* copy driver operators */
-	ops->ops = *entry;
-	ops->driver |= DRIVER_LOADED;
-	ops->argsize = argsize;
 
-	/* initialize existing devices if necessary */
-	list_for_each_entry(dev, &ops->dev_list, list) {
-		init_device(dev, ops);
-	}
-	mutex_unlock(&ops->reg_mutex);
-
-	unlock_driver(ops);
-
-	return 0;
+	sdrv->driver.name = id;
+	sdrv->driver.bus = &snd_seq_bus_type;
+	sdrv->driver.probe = snd_seq_drv_probe;
+	sdrv->driver.remove = snd_seq_drv_remove;
+	strlcpy(sdrv->id, id, sizeof(sdrv->id));
+	sdrv->argsize = argsize;
+	sdrv->ops = *entry;
+
+	err = driver_register(&sdrv->driver);
+	if (err < 0)
+		kfree(sdrv);
+	return err;
 }
+EXPORT_SYMBOL(snd_seq_device_register_driver);
 
-
-/*
- * create driver record
+/* callback to find a specific driver; data is a pointer to the id string ptr.
+ * when the id matches, store the driver pointer in return and break the loop.
  */
-static struct ops_list * create_driver(char *id)
+static int find_drv(struct device_driver *drv, void *data)
 {
-	struct ops_list *ops;
-
-	ops = kzalloc(sizeof(*ops), GFP_KERNEL);
-	if (ops == NULL)
-		return ops;
-
-	/* set up driver entry */
-	strlcpy(ops->id, id, sizeof(ops->id));
-	mutex_init(&ops->reg_mutex);
-	/*
-	 * The ->reg_mutex locking rules are per-driver, so we create
-	 * separate per-driver lock classes:
-	 */
-	lockdep_set_class(&ops->reg_mutex, (struct lock_class_key *)id);
-
-	ops->driver = DRIVER_EMPTY;
-	INIT_LIST_HEAD(&ops->dev_list);
-	/* lock this instance */
-	ops->used = 1;
-
-	/* register driver entry */
-	mutex_lock(&ops_mutex);
-	list_add_tail(&ops->list, &opslist);
-	num_ops++;
-	mutex_unlock(&ops_mutex);
-
-	return ops;
-}
+	struct snd_seq_driver *sdrv = to_seq_drv(drv);
+	void **ptr = (void **)data;
 
+	if (strcmp(sdrv->id, *ptr))
+		return 0; /* id don't match, continue the loop */
+	*ptr = sdrv;
+	return 1; /* break the loop */
+}
 
 /*
  * unregister the specified driver
  */
 int snd_seq_device_unregister_driver(char *id)
 {
-	struct ops_list *ops;
-	struct snd_seq_device *dev;
+	struct snd_seq_driver *sdrv = (struct snd_seq_driver *)id;
 
-	ops = find_driver(id, 0);
-	if (ops == NULL)
+	if (!bus_for_each_drv(&snd_seq_bus_type, NULL, &sdrv, find_drv))
 		return -ENXIO;
-	if (! (ops->driver & DRIVER_LOADED) ||
-	    (ops->driver & DRIVER_LOCKED)) {
-		pr_err("ALSA: seq: driver_unregister: cannot unload driver '%s': status=%x\n",
-			   id, ops->driver);
-		unlock_driver(ops);
-		return -EBUSY;
-	}
-
-	/* close and release all devices associated with this driver */
-	mutex_lock(&ops->reg_mutex);
-	ops->driver |= DRIVER_LOCKED; /* do not remove this driver recursively */
-	list_for_each_entry(dev, &ops->dev_list, list) {
-		free_device(dev, ops);
-	}
-
-	ops->driver = 0;
-	if (ops->num_init_devices > 0)
-		pr_err("ALSA: seq: free_driver: init_devices > 0!! (%d)\n",
-			   ops->num_init_devices);
-	mutex_unlock(&ops->reg_mutex);
-
-	unlock_driver(ops);
-
-	/* remove empty driver entries */
-	remove_drivers();
-
+	driver_unregister(&sdrv->driver);
+	kfree(sdrv);
 	return 0;
 }
-
-
-/*
- * remove empty driver entries
- */
-static void remove_drivers(void)
-{
-	struct list_head *head;
-
-	mutex_lock(&ops_mutex);
-	head = opslist.next;
-	while (head != &opslist) {
-		struct ops_list *ops = list_entry(head, struct ops_list, list);
-		if (! (ops->driver & DRIVER_LOADED) &&
-		    ops->used == 0 && ops->num_devices == 0) {
-			head = head->next;
-			list_del(&ops->list);
-			kfree(ops);
-			num_ops--;
-		} else
-			head = head->next;
-	}
-	mutex_unlock(&ops_mutex);
-}
-
-/*
- * initialize the device - call init_device operator
- */
-static int init_device(struct snd_seq_device *dev, struct ops_list *ops)
-{
-	if (! (ops->driver & DRIVER_LOADED))
-		return 0; /* driver is not loaded yet */
-	if (dev->status != SNDRV_SEQ_DEVICE_FREE)
-		return 0; /* already initialized */
-	if (ops->argsize != dev->argsize) {
-		pr_err("ALSA: seq: incompatible device '%s' for plug-in '%s' (%d %d)\n",
-			   dev->name, ops->id, ops->argsize, dev->argsize);
-		return -EINVAL;
-	}
-	if (ops->ops.init_device(dev) >= 0) {
-		dev->status = SNDRV_SEQ_DEVICE_REGISTERED;
-		ops->num_init_devices++;
-	} else {
-		pr_err("ALSA: seq: init_device failed: %s: %s\n",
-			   dev->name, dev->id);
-	}
-
-	return 0;
-}
-
-/*
- * release the device - call free_device operator
- */
-static int free_device(struct snd_seq_device *dev, struct ops_list *ops)
-{
-	int result;
-
-	if (! (ops->driver & DRIVER_LOADED))
-		return 0; /* driver is not loaded yet */
-	if (dev->status != SNDRV_SEQ_DEVICE_REGISTERED)
-		return 0; /* not registered */
-	if (ops->argsize != dev->argsize) {
-		pr_err("ALSA: seq: incompatible device '%s' for plug-in '%s' (%d %d)\n",
-			   dev->name, ops->id, ops->argsize, dev->argsize);
-		return -EINVAL;
-	}
-	if ((result = ops->ops.free_device(dev)) >= 0 || result == -ENXIO) {
-		dev->status = SNDRV_SEQ_DEVICE_FREE;
-		dev->driver_data = NULL;
-		ops->num_init_devices--;
-	} else {
-		pr_err("ALSA: seq: free_device failed: %s: %s\n",
-			   dev->name, dev->id);
-	}
-
-	return 0;
-}
-
-/*
- * find the matching driver with given id
- */
-static struct ops_list * find_driver(char *id, int create_if_empty)
-{
-	struct ops_list *ops;
-
-	mutex_lock(&ops_mutex);
-	list_for_each_entry(ops, &opslist, list) {
-		if (strcmp(ops->id, id) == 0) {
-			ops->used++;
-			mutex_unlock(&ops_mutex);
-			return ops;
-		}
-	}
-	mutex_unlock(&ops_mutex);
-	if (create_if_empty)
-		return create_driver(id);
-	return NULL;
-}
-
-static void unlock_driver(struct ops_list *ops)
-{
-	mutex_lock(&ops_mutex);
-	ops->used--;
-	mutex_unlock(&ops_mutex);
-}
-
+EXPORT_SYMBOL(snd_seq_device_unregister_driver);
 
 /*
  * module part
  */
 
-static int __init alsa_seq_device_init(void)
+static int __init seq_dev_proc_init(void)
 {
 #ifdef CONFIG_PROC_FS
 	info_entry = snd_info_create_module_entry(THIS_MODULE, "drivers",
@@ -594,17 +376,28 @@ static int __init alsa_seq_device_init(void)
 	return 0;
 }
 
+static int __init alsa_seq_device_init(void)
+{
+	int err;
+
+	err = bus_register(&snd_seq_bus_type);
+	if (err < 0)
+		return err;
+	err = seq_dev_proc_init();
+	if (err < 0)
+		bus_unregister(&snd_seq_bus_type);
+	return err;
+}
+
 static void __exit alsa_seq_device_exit(void)
 {
 #ifdef CONFIG_MODULES
 	cancel_work_sync(&autoload_work);
 #endif
-	remove_drivers();
 #ifdef CONFIG_PROC_FS
 	snd_info_free_entry(info_entry);
 #endif
-	if (num_ops)
-		pr_err("ALSA: seq: drivers not released (%d)\n", num_ops);
+	bus_unregister(&snd_seq_bus_type);
 }
 
 module_init(alsa_seq_device_init)
-- 
2.3.0
