From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] firewire: move fw_device reference counting from drivers to
	core
Date: Sat, 27 Aug 2011 18:53:03 +0200
Message-ID: <20110827185303.16263e89@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: linux1394-devel@lists.sourceforge.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

fw_unit device drivers invariably need to talk to the fw_unit's parent
(an fw_device) and grandparent (an fw_card).  firewire-core already
maintains an fw_card reference for the entire lifetime of an fw_device.
Likewise, let firewire-core maintain an fw_device reference for the
entire lifetime of an fw_unit so that fw_unit drivers don't have to.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Depends on patch "firewire: sbp2: remove obsolete reference counting",
http://marc.info/?l=linux1394-devel&m=131445207126341 .

Clemens needs to pick up the dice.c hunk when he merges or rebases.

 drivers/firewire/core-device.c |    2 ++
 drivers/firewire/core.h        |   13 +++++++++++++
 include/linux/firewire.h       |   12 ------------
 sound/firewire/dice.c          |    5 -----
 sound/firewire/isight.c        |    4 +---
 sound/firewire/speakers.c      |    4 ----
 6 files changed, 16 insertions(+), 24 deletions(-)

Index: b/drivers/firewire/core-device.c
===================================================================
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -641,6 +641,7 @@ static void fw_unit_release(struct devic
 {
 	struct fw_unit *unit = fw_unit(dev);
 
+	fw_device_put(fw_parent_device(unit));
 	kfree(unit);
 }
 
@@ -692,6 +693,7 @@ static void create_units(struct fw_devic
 		if (device_register(&unit->device) < 0)
 			goto skip_unit;
 
+		fw_device_get(device);
 		continue;
 
 	skip_unit:
Index: b/drivers/firewire/core.h
===================================================================
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -1,6 +1,7 @@
 #ifndef _FIREWIRE_CORE_H
 #define _FIREWIRE_CORE_H
 
+#include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/list.h>
 #include <linux/idr.h>
@@ -141,6 +142,18 @@ extern struct rw_semaphore fw_device_rws
 extern struct idr fw_device_idr;
 extern int fw_cdev_major;
 
+static inline struct fw_device *fw_device_get(struct fw_device *device)
+{
+	get_device(&device->device);
+
+	return device;
+}
+
+static inline void fw_device_put(struct fw_device *device)
+{
+	put_device(&device->device);
+}
+
 struct fw_device *fw_device_get_by_devt(dev_t devt);
 int fw_device_set_broadcast_channel(struct device *dev, void *gen);
 void fw_node_event(struct fw_card *card, struct fw_node *node, int event);
Index: b/include/linux/firewire.h
===================================================================
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -204,18 +204,6 @@ static inline int fw_device_is_shutdown(
 	return atomic_read(&device->state) == FW_DEVICE_SHUTDOWN;
 }
 
-static inline struct fw_device *fw_device_get(struct fw_device *device)
-{
-	get_device(&device->device);
-
-	return device;
-}
-
-static inline void fw_device_put(struct fw_device *device)
-{
-	put_device(&device->device);
-}
-
 int fw_device_enable_phys_dma(struct fw_device *device);
 
 /*
Index: b/sound/firewire/dice.c
===================================================================
--- a/sound/firewire/dice.c
+++ b/sound/firewire/dice.c
@@ -1033,12 +1033,10 @@ static int dice_create_hwdep(struct dice
 static void dice_card_free(struct snd_card *card)
 {
 	struct dice *dice = card->private_data;
-	struct fw_device *dev = fw_parent_device(dice->unit);
 
 	amdtp_out_stream_destroy(&dice->stream);
 	fw_core_remove_address_handler(&dice->notification_handler);
 	fw_unit_put(dice->unit);
-	fw_device_put(dev);
 	mutex_destroy(&dice->mutex);
 }
 
@@ -1106,7 +1104,6 @@ static void __devinit dice_card_strings(
 static int __devinit dice_probe(struct device *unit_dev)
 {
 	struct fw_unit *unit = fw_unit(unit_dev);
-	struct fw_device *fw_dev = fw_parent_device(unit);
 	struct snd_card *card;
 	struct dice *dice;
 	__be32 clock_sel;
@@ -1121,7 +1118,6 @@ static int __devinit dice_probe(struct d
 	dice->card = card;
 	spin_lock_init(&dice->lock);
 	mutex_init(&dice->mutex);
-	fw_device_get(fw_dev);
 	dice->unit = fw_unit_get(unit);
 	init_waitqueue_head(&dice->hwdep_wait);
 
@@ -1191,7 +1187,6 @@ err_notification_handler:
 	fw_core_remove_address_handler(&dice->notification_handler);
 err_unit:
 	fw_unit_put(dice->unit);
-	fw_device_put(fw_dev);
 	mutex_destroy(&dice->mutex);
 error:
 	snd_card_free(card);
Index: b/sound/firewire/isight.c
===================================================================
--- a/sound/firewire/isight.c
+++ b/sound/firewire/isight.c
@@ -612,7 +612,6 @@ static void isight_card_free(struct snd_
 
 	fw_iso_resources_destroy(&isight->resources);
 	fw_unit_put(isight->unit);
-	fw_device_put(isight->device);
 	mutex_destroy(&isight->mutex);
 }
 
@@ -645,7 +644,7 @@ static int isight_probe(struct device *u
 	isight->card = card;
 	mutex_init(&isight->mutex);
 	isight->unit = fw_unit_get(unit);
-	isight->device = fw_device_get(fw_dev);
+	isight->device = fw_dev;
 	isight->audio_base = get_unit_base(unit);
 	if (!isight->audio_base) {
 		dev_err(&unit->device, "audio unit base not found\n");
@@ -682,7 +681,6 @@ static int isight_probe(struct device *u
 
 err_unit:
 	fw_unit_put(isight->unit);
-	fw_device_put(isight->device);
 	mutex_destroy(&isight->mutex);
 error:
 	snd_card_free(card);
Index: b/sound/firewire/speakers.c
===================================================================
--- a/sound/firewire/speakers.c
+++ b/sound/firewire/speakers.c
@@ -656,12 +656,10 @@ static u32 fwspk_read_firmware_version(s
 static void fwspk_card_free(struct snd_card *card)
 {
 	struct fwspk *fwspk = card->private_data;
-	struct fw_device *dev = fw_parent_device(fwspk->unit);
 
 	amdtp_out_stream_destroy(&fwspk->stream);
 	cmp_connection_destroy(&fwspk->connection);
 	fw_unit_put(fwspk->unit);
-	fw_device_put(dev);
 	mutex_destroy(&fwspk->mutex);
 }
 
@@ -718,7 +716,6 @@ static int __devinit fwspk_probe(struct
 	fwspk = card->private_data;
 	fwspk->card = card;
 	mutex_init(&fwspk->mutex);
-	fw_device_get(fw_dev);
 	fwspk->unit = fw_unit_get(unit);
 	fwspk->device_info = fwspk_detect(fw_dev);
 	if (!fwspk->device_info) {
@@ -767,7 +764,6 @@ err_connection:
 	cmp_connection_destroy(&fwspk->connection);
 err_unit:
 	fw_unit_put(fwspk->unit);
-	fw_device_put(fw_dev);
 	mutex_destroy(&fwspk->mutex);
 error:
 	snd_card_free(card);


-- 
Stefan Richter
-=====-==-== =--- ==-==
http://arcgraph.de/sr/

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
