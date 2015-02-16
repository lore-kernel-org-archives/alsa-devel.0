From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/6] ALSA: seq: Clean up device and driver
	structs
Date: Mon, 16 Feb 2015 17:55:42 +0100
Message-ID: <1424105744-2187-5-git-send-email-tiwai@suse.de>
References: <1424105744-2187-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD67260692
 for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2015 17:55:45 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B9578ACEA
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

Use const string pointer instead of copying the id string to each
object.  Also drop the status and list fields of snd_seq_device struct
that are no longer used.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/seq_device.h  | 18 ++++++------------
 sound/core/seq/seq_device.c | 31 ++++++++++---------------------
 2 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/include/sound/seq_device.h b/include/sound/seq_device.h
index ea256b825146..b13cd2930d32 100644
--- a/include/sound/seq_device.h
+++ b/include/sound/seq_device.h
@@ -25,24 +25,16 @@
  * registered device information
  */
 
-#define ID_LEN	32
-
-/* status flag */
-#define SNDRV_SEQ_DEVICE_FREE		0
-#define SNDRV_SEQ_DEVICE_REGISTERED	1
-
 struct snd_seq_device {
 	/* device info */
 	struct snd_card *card;	/* sound card */
 	int device;		/* device number */
-	char id[ID_LEN];	/* driver id */
+	const char *id;		/* driver id */
 	char name[80];		/* device name */
 	int argsize;		/* size of the argument */
 	void *driver_data;	/* private data for driver */
-	int status;		/* flag - read only */
 	void *private_data;	/* private data for the caller */
 	void (*private_free)(struct snd_seq_device *device);
-	struct list_head list;	/* link to next device */
 	struct device dev;
 };
 
@@ -75,9 +67,11 @@ void snd_seq_device_load_drivers(void);
 #else
 #define snd_seq_device_load_drivers()
 #endif
-int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize, struct snd_seq_device **result);
-int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry, int argsize);
-int snd_seq_device_unregister_driver(char *id);
+int snd_seq_device_new(struct snd_card *card, int device, const char *id,
+		       int argsize, struct snd_seq_device **result);
+int snd_seq_device_register_driver(const char *id,
+				   struct snd_seq_dev_ops *entry, int argsize);
+int snd_seq_device_unregister_driver(const char *id);
 
 #define SNDRV_SEQ_DEVICE_ARGPTR(dev) (void *)((char *)(dev) + sizeof(struct snd_seq_device))
 
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index d3320ffe43c2..49daf6e3a387 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -54,7 +54,7 @@ MODULE_LICENSE("GPL");
 
 struct snd_seq_driver {
 	struct device_driver driver;
-	char id[ID_LEN];
+	const char *id;
 	int argsize;
 	struct snd_seq_dev_ops ops;
 };
@@ -215,8 +215,8 @@ static void snd_seq_dev_release(struct device *dev)
  * id = id of driver
  * result = return pointer (NULL allowed if unnecessary)
  */
-int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
-		       struct snd_seq_device **result)
+int snd_seq_device_new(struct snd_card *card, int device, const char *id,
+		       int argsize, struct snd_seq_device **result)
 {
 	struct snd_seq_device *dev;
 	int err;
@@ -239,9 +239,8 @@ int snd_seq_device_new(struct snd_card *card, int device, char *id, int argsize,
 	/* set up device info */
 	dev->card = card;
 	dev->device = device;
-	strlcpy(dev->id, id, sizeof(dev->id));
+	dev->id = id;
 	dev->argsize = argsize;
-	dev->status = SNDRV_SEQ_DEVICE_FREE;
 
 	device_initialize(&dev->dev);
 	dev->dev.parent = &card->card_dev;
@@ -270,26 +269,16 @@ static int snd_seq_drv_probe(struct device *dev)
 {
 	struct snd_seq_driver *sdrv = to_seq_drv(dev->driver);
 	struct snd_seq_device *sdev = to_seq_dev(dev);
-	int err;
 
-	err = sdrv->ops.init_device(sdev);
-	if (err < 0)
-		return err;
-	sdev->status = SNDRV_SEQ_DEVICE_REGISTERED;
-	return 0;
+	return sdrv->ops.init_device(sdev);
 }
 
 static int snd_seq_drv_remove(struct device *dev)
 {
 	struct snd_seq_driver *sdrv = to_seq_drv(dev->driver);
 	struct snd_seq_device *sdev = to_seq_dev(dev);
-	int err;
 
-	err = sdrv->ops.free_device(sdev);
-	if (err < 0)
-		return err;
-	sdev->status = SNDRV_SEQ_DEVICE_FREE;
-	return 0;
+	return sdrv->ops.free_device(sdev);
 }
 
 /*
@@ -297,8 +286,8 @@ static int snd_seq_drv_remove(struct device *dev)
  * id = driver id
  * entry = driver operators - duplicated to each instance
  */
-int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry,
-				   int argsize)
+int snd_seq_device_register_driver(const char *id,
+				   struct snd_seq_dev_ops *entry, int argsize)
 {
 	struct snd_seq_driver *sdrv;
 	int err;
@@ -315,7 +304,7 @@ int snd_seq_device_register_driver(char *id, struct snd_seq_dev_ops *entry,
 	sdrv->driver.bus = &snd_seq_bus_type;
 	sdrv->driver.probe = snd_seq_drv_probe;
 	sdrv->driver.remove = snd_seq_drv_remove;
-	strlcpy(sdrv->id, id, sizeof(sdrv->id));
+	sdrv->id = id;
 	sdrv->argsize = argsize;
 	sdrv->ops = *entry;
 
@@ -343,7 +332,7 @@ static int find_drv(struct device_driver *drv, void *data)
 /*
  * unregister the specified driver
  */
-int snd_seq_device_unregister_driver(char *id)
+int snd_seq_device_unregister_driver(const char *id)
 {
 	struct snd_seq_driver *sdrv = (struct snd_seq_driver *)id;
 
-- 
2.3.0
