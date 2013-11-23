From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/13] bebob: Add skelton for BridgeCo BeBoB
	based devices
Date: Sat, 23 Nov 2013 15:09:13 +0900
Message-ID: <1385186965-8303-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 0051B265304
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2013 07:09:34 +0100 (CET)
In-Reply-To: <1385186965-8303-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This commit add a new driver with no functionality.
This driver just reacts to Firewire bus events and create/remove card instance.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig        |  20 +++
 sound/firewire/Makefile       |   1 +
 sound/firewire/bebob/Makefile |   2 +
 sound/firewire/bebob/bebob.c  | 274 ++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob.h  |  74 ++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 sound/firewire/bebob/Makefile
 create mode 100644 sound/firewire/bebob/bebob.c
 create mode 100644 sound/firewire/bebob/bebob.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index b3e274f..5349652 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -61,4 +61,24 @@ config SND_SCS1X
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-scs1x.
 
+config SND_BEBOB
+	tristate "BridgeCo BeBoB chipset support"
+	select SND_FIREWIRE_LIB
+        help
+	 Say Y here to include support for FireWire devices based
+	 on BridgeCo BeBoB chipset:
+	  * Edirol FA-66/FA-101
+	  * Mackie OnyxFirewire
+	  * Tascam  IF-FW/DM
+	  * Behringer X32
+	  * Apogee Rosetta200
+	  * ESI Quotafire610
+	  * AcousticReality eARMasterOne
+	  * CME MatrixKFW
+	  * Phonic HB24U
+	  * BridgeCo RDAudio1/Audio5
+
+          To compile this driver as a module, choose M here: the module
+          will be called snd-fireworks.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 5099550..f2d1c5c 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SND_DICE) += snd-dice.o
 obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
+obj-$(CONFIG_SND_BEBOB) += bebob/
diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
new file mode 100644
index 0000000..c6f0141
--- /dev/null
+++ b/sound/firewire/bebob/Makefile
@@ -0,0 +1,2 @@
+snd-bebob-objs := bebob.o
+obj-m += snd-bebob.o
diff --git a/sound/firewire/bebob/bebob.c b/sound/firewire/bebob/bebob.c
new file mode 100644
index 0000000..bec4b6f
--- /dev/null
+++ b/sound/firewire/bebob/bebob.c
@@ -0,0 +1,274 @@
+/*
+ * bebob.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "bebob.h"
+
+MODULE_DESCRIPTION("bridgeCo BeBoB driver");
+MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
+MODULE_LICENSE("GPL v2");
+
+static int index[SNDRV_CARDS]	= SNDRV_DEFAULT_IDX;
+static char *id[SNDRV_CARDS]	= SNDRV_DEFAULT_STR;
+static bool enable[SNDRV_CARDS]	= SNDRV_DEFAULT_ENABLE_PNP;
+
+module_param_array(index, int, NULL, 0444);
+MODULE_PARM_DESC(index, "card index");
+module_param_array(id, charp, NULL, 0444);
+MODULE_PARM_DESC(id, "ID string");
+module_param_array(enable, bool, NULL, 0444);
+MODULE_PARM_DESC(enable, "enable BeBoB sound card");
+
+static DEFINE_MUTEX(devices_mutex);
+static unsigned int devices_used;
+
+/* Offsets from information register. */
+#define INFO_OFFSET_GUID		0x10
+#define INFO_OFFSET_HW_MODEL_ID		0x18
+#define INFO_OFFSET_HW_MODEL_REVISION	0x1c
+
+#define VEN_EDIROL	0x000040ab
+#define VEN_BRIDGECO	0x000007f5
+#define VEN_MACKIE	0x0000000f
+#define VEN_TASCOM	0x0000022e
+#define VEN_BEHRINGER	0x00001564
+#define VEN_APOGEE	0x000003db
+#define VEN_ESI		0x00000f1b
+#define VEN_ACOUSTIC	0x00000002
+#define VEN_CME		0x0000000a
+#define VEN_PHONIC	0x00001496
+
+static int
+name_device(struct snd_bebob *bebob, unsigned int vendor_id)
+{
+	char vendor[24] = {};
+	char model[24] = {};
+	u32 id;
+	u32 data[2] = {};
+	u32 revision;
+	int err;
+
+	/* get vendor name */
+	if (vendor_id == VEN_EDIROL)
+		strcpy(vendor, "Edirol");
+	else if (vendor_id == VEN_BRIDGECO)
+		strcpy(vendor, "BridgeCo");
+	else if (vendor_id == VEN_MACKIE)
+		strcpy(vendor, "Mackie");
+	else if (vendor_id == VEN_TASCOM)
+		strcpy(vendor, "Tacsom");
+	else if (vendor_id == VEN_BEHRINGER)
+		strcpy(vendor, "Behringer");
+	else if (vendor_id == VEN_APOGEE)
+		strcpy(vendor, "Apogee");
+	else if (vendor_id == VEN_ESI)
+		strcpy(vendor, "ESI");
+	else if (vendor_id == VEN_ACOUSTIC)
+		strcpy(vendor, "AcousticReality");
+	else if (vendor_id == VEN_CME)
+		strcpy(vendor, "CME");
+	else if (vendor_id == VEN_PHONIC)
+		strcpy(vendor, "Phonic");
+
+	/* get model name */
+	err = fw_csr_string(bebob->unit->directory, CSR_MODEL,
+			    model, sizeof(model));
+	if (err < 0)
+		goto end;
+
+	/* get hardware id */
+	err = snd_bebob_read_quad(bebob, INFO_OFFSET_HW_MODEL_ID,
+				  &id, sizeof(id));
+	if (err < 0)
+		goto end;
+
+	/* get hardware revision */
+	err = snd_bebob_read_quad(bebob, INFO_OFFSET_HW_MODEL_REVISION,
+				  &revision, sizeof(revision));
+	if (err < 0)
+		goto end;
+
+	/* get GUID */
+	err = snd_bebob_read_block(bebob, INFO_OFFSET_GUID,
+				   data, sizeof(data));
+	if (err < 0)
+		goto end;
+
+	strcpy(bebob->card->driver, "BeBoB");
+	strcpy(bebob->card->shortname, model);
+	snprintf(bebob->card->longname, sizeof(bebob->card->longname),
+		 "%s %s (id:%d, rev:%d), GUID %08x%08x at %s, S%d",
+		 vendor, model, id, revision,
+		 data[0], data[1],
+		 dev_name(&bebob->unit->device),
+		 100 << bebob->device->max_speed);
+end:
+	return err;
+}
+
+static void
+snd_bebob_card_free(struct snd_card *card)
+{
+	struct snd_bebob *bebob = card->private_data;
+
+	if (bebob->card_index >= 0) {
+		mutex_lock(&devices_mutex);
+		devices_used &= ~BIT(bebob->card_index);
+		mutex_unlock(&devices_mutex);
+	}
+
+	mutex_destroy(&bebob->mutex);
+
+	return;
+}
+
+static int
+snd_bebob_probe(struct fw_unit *unit,
+		const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_bebob *bebob;
+	unsigned int card_index;
+	int err;
+
+	mutex_lock(&devices_mutex);
+
+	/* check registered cards */
+	for (card_index = 0; card_index < SNDRV_CARDS; card_index++) {
+		if (!(devices_used & BIT(card_index)) && enable[card_index])
+			break;
+	}
+	if (card_index >= SNDRV_CARDS) {
+		err = -ENOENT;
+		goto end;
+	}
+
+	/* create card */
+	err = snd_card_create(index[card_index], id[card_index],
+			THIS_MODULE, sizeof(struct snd_bebob), &card);
+	if (err < 0)
+		goto end;
+	card->private_free = snd_bebob_card_free;
+
+	/* initialize myself */
+	bebob = card->private_data;
+	bebob->card = card;
+	bebob->device = fw_parent_device(unit);
+	bebob->unit = unit;
+	bebob->card_index = -1;
+	mutex_init(&bebob->mutex);
+	spin_lock_init(&bebob->lock);
+
+	/* name device with communication */
+	err = name_device(bebob, entry->vendor_id);
+	if (err < 0)
+		goto error;
+
+	/* register card and device */
+	snd_card_set_dev(card, &unit->device);
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		goto error;
+	}
+	dev_set_drvdata(&unit->device, bebob);
+	devices_used |= BIT(card_index);
+	bebob->card_index = card_index;
+
+	/* proved */
+	err = 0;
+end:
+	mutex_unlock(&devices_mutex);
+	return err;
+error:
+	snd_card_free(card);
+	mutex_unlock(&devices_mutex);
+	return err;
+}
+
+static void
+snd_bebob_update(struct fw_unit *unit)
+{
+	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+	fcp_bus_reset(bebob->unit);
+}
+
+
+static void snd_bebob_remove(struct fw_unit *unit)
+{
+	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+	snd_card_disconnect(bebob->card);
+	snd_card_free_when_closed(bebob->card);
+}
+
+static const struct ieee1394_device_id snd_bebob_id_table[] = {
+	/* Edirol, FA-66 */
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010049),
+	/* Edirol, FA-101 */
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010048),
+	/* BridgeCo, RDAudio1 */
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010048),
+	/* BridgeCo, Audio5 */
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049),
+	/* Mackie, OnyxFirewire */
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065),
+	/* Mackie, OnyxFirewire */
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067),
+	/* Tascam, IF-FW/DM */
+	SND_BEBOB_DEV_ENTRY(VEN_TASCOM, 0x00010067),
+	/* Behringer, X32 */
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00000006),
+	/* ApogeeElectronics, Rosetta200 */
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048),
+	/* ESI, Quatafire610 */
+	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064),
+	/* AcousticReality, eARMasterOne */
+	SND_BEBOB_DEV_ENTRY(VEN_ACOUSTIC, 0x00000002),
+	/* CME, MatrixKFW */
+	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000),
+	/* Phonic, HB24U */
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000),
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, snd_bebob_id_table);
+
+static struct fw_driver snd_bebob_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "snd-bebob",
+		.bus	= &fw_bus_type,
+	},
+	.probe    = snd_bebob_probe,
+	.update	  = snd_bebob_update,
+	.remove   = snd_bebob_remove,
+	.id_table = snd_bebob_id_table,
+};
+
+static int __init
+snd_bebob_init(void)
+{
+	return driver_register(&snd_bebob_driver.driver);
+}
+
+static void __exit
+snd_bebob_exit(void)
+{
+	driver_unregister(&snd_bebob_driver.driver);
+	mutex_destroy(&devices_mutex);
+}
+
+module_init(snd_bebob_init);
+module_exit(snd_bebob_exit);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
new file mode 100644
index 0000000..60d875e
--- /dev/null
+++ b/sound/firewire/bebob/bebob.h
@@ -0,0 +1,74 @@
+/*
+ * bebob.h - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2.
+ *
+ * This driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this driver; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef SOUND_BEBOB_H_INCLUDED
+#define SOUND_BEBOB_H_INCLUDED
+
+#include <linux/compat.h>
+#include <linux/device.h>
+#include <linux/firewire.h>
+#include <linux/firewire-constants.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+
+#include "../lib.h"
+#include "../fcp.h"
+
+/* basic register addresses on bebob chip */
+#define BEBOB_ADDR_REG_INFO	0xffffc8020000
+#define BEBOB_ADDR_REG_REQ	0xffffc8021000
+
+struct snd_bebob {
+        struct snd_card *card;
+        struct fw_device *device;
+        struct fw_unit *unit;
+        int card_index;
+
+        struct mutex mutex;
+        spinlock_t lock;
+};
+
+static inline int
+snd_bebob_read_block(struct snd_bebob *bebob, u64 addr, void *buf, int size)
+{
+	return snd_fw_transaction(bebob->unit, TCODE_READ_BLOCK_REQUEST,
+				  BEBOB_ADDR_REG_INFO + addr,
+				  buf, size, 0);
+}
+
+static inline int
+snd_bebob_read_quad(struct snd_bebob *bebob, u64 addr, void *buf, int size)
+{
+	return snd_fw_transaction(bebob->unit, TCODE_READ_QUADLET_REQUEST,
+				  BEBOB_ADDR_REG_INFO + addr,
+				  buf, size, 0);
+}
+
+#define SND_BEBOB_DEV_ENTRY(vendor, model) \
+{ \
+	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
+			  IEEE1394_MATCH_MODEL_ID, \
+	.vendor_id	= vendor, \
+	.model_id	= model, \
+}
+
+#endif
-- 
1.8.3.2
