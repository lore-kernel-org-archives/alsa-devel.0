From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/52] bebob: Add skelton for BeBoB based devices
Date: Wed, 29 Jan 2014 22:44:33 +0900
Message-ID: <1391003099-7109-27-git-send-email-o-takashi@sakamocchi.jp>
References: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1391003099-7109-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit add a new driver for BeBoB based devices with no functionality. This driver just create/remove
card instance according to callbacks.

BeBoB is 'BridgeCo enhanced Breakout Box'. This is installed to firewire devices with
DM1000/1000E/1100/1500 chipset. It gives common way for host system to handle BeBoB based devices.

Current supported devices:
 - Edirol FA-66/FA-101
 - PreSonus FIREBOX/FIREPOD/FP10/Inspire1394
 - BridgeCo RDAudio1/Audio5
 - Mackie Onyx 1220/1620/1640 (Firewire I/O Card)
 - Mackie d.2 (Firewire Option)
 - Stanton FinalScratch 2 (ScratchAmp)
 - Tascam IF-FW DM
 - Behringer XENIX UFX 1204/1604
 - Behringer Digital Mixer X32 series (X-UF Card)
 - Apogee Rosetta 200/Rosetta 400 (X-FireWire card)
 - Apogee DA-16X/AD-16X/DD-16X (X-FireWire card)
 - Apogee Ensemble
 - ESI Quotafire610
 - AcousticReality eARMasterOne
 - CME MatrixKFW
 - Phonix Helix Board 12 MkII/18 MkII/24 MkII
 - Phonic Helix Board 12 Universal/18 Universal/24 Universal
 - Lynx Aurora 8/16 (LT-FW)
 - ICON FireXon
 - PrismSound Orpheus/ADA-8XR

Devices possible to be supported if identifying IDs:
 - Apogee Mini-Me Firewire/Mini-DAC Firewire
 - Behringer F-Control Audio 610/1616
 - Cakewalk Sonar Power Studio 66
 - CME UF400e
 - ESI Quotafire XL
 - Infrasonic DewX/Windy6
 - Mackie Digital X Bus x.200/400
 - Phonic Helix Board 12/18/24
 - Phonic FireFly 202/302
 - Rolf Spuler Firewire Guitar

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig        |  30 +++++
 sound/firewire/Makefile       |   1 +
 sound/firewire/bebob/Makefile |   2 +
 sound/firewire/bebob/bebob.c  | 299 ++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/bebob/bebob.h  |  64 +++++++++
 5 files changed, 396 insertions(+)
 create mode 100644 sound/firewire/bebob/Makefile
 create mode 100644 sound/firewire/bebob/bebob.c
 create mode 100644 sound/firewire/bebob/bebob.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 875af02..9027b23 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -79,4 +79,34 @@ config SND_FIREWORKS
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-fireworks.
 
+config SND_BEBOB
+	tristate "BridgeCo DM1000/1500 with BeBoB firmware"
+	select SND_FIREWIRE_LIB
+        help
+	 Say Y here to include support for FireWire devices based
+	 on BridgeCo DM1000/1500 with BeBoB firmware:
+	  * Edirol FA-66/FA-101
+	  * PreSonus FIREBOX/FIREPOD/FP10/Inspire1394
+	  * BridgeCo RDAudio1/Audio5
+	  * Mackie Onyx 1220/1620/1640 (Firewire I/O Card)
+	  * Mackie d.2 (Firewire Option)
+	  * Stanton FinalScratch 2 (ScratchAmp)
+	  * Tascam IF-FW/DM
+	  * Behringer XENIX UFX 1204/1604
+	  * Behringer Digital Mixer X32 series (X-UF Card)
+	  * Apogee Rosetta 200/400 (X-FireWire card)
+	  * Apogee DA/AD/DD-16X (X-FireWire card)
+	  * Apogee Ensemble
+	  * ESI Quotafire610
+	  * AcousticReality eARMasterOne
+	  * CME MatrixKFW
+	  * Phonic Helix Board 12 MkII/18 MkII/24 MkII
+	  * Phonic Helix Board 12 Universal/18 Universal/24 Universal
+	  * Lynx Aurora 8/16 (LT-FW)
+	  * ICON FireXon
+	  * PrismSound Orpheus/ADA-8XR
+
+          To compile this driver as a module, choose M here: the module
+          will be called snd-bebob.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 5cd39dc..fad8d49 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
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
index 0000000..5619bd6
--- /dev/null
+++ b/sound/firewire/bebob/bebob.c
@@ -0,0 +1,299 @@
+/*
+ * bebob.c - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+/*
+ * BeBoB is 'BridgeCo enhanced Breakout Box'. This is installed to firewire
+ * devices with DM1000/1000E/1100/1500 chipset. It gives common way for host
+ * system to handle BeBoB based devices.
+ */
+
+#include "bebob.h"
+
+MODULE_DESCRIPTION("BridgeCo BeBoB driver");
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
+#define VEN_PRESONUS	0x00000a92
+#define VEN_BRIDGECO	0x000007f5
+#define VEN_MACKIE	0x0000000f
+#define VEN_STANTON	0x00001260
+#define VEN_TASCAM	0x0000022e
+#define VEN_BEHRINGER	0x00001564
+#define VEN_APOGEE	0x000003db
+#define VEN_ESI		0x00000f1b
+#define VEN_ACOUSTIC	0x00000002
+#define VEN_CME		0x0000000a
+#define VEN_PHONIC	0x00001496
+#define VEN_LYNX	0x000019e5
+#define VEN_ICON	0x00001a9e
+#define VEN_PRISMSOUND	0x00001198
+
+static int
+name_device(struct snd_bebob *bebob, unsigned int vendor_id)
+{
+	struct fw_device *fw_dev = fw_parent_device(bebob->unit);
+	char vendor[24] = {0};
+	char model[24] = {0};
+	u32 id;
+	u32 data[2] = {0};
+	u32 revision;
+	int err;
+
+	/* get vendor name from root directory */
+	err = fw_csr_string(fw_dev->config_rom + 5, CSR_VENDOR,
+			    vendor, sizeof(vendor));
+	if (err < 0)
+		goto end;
+
+	/* get model name from unit directory */
+	err = fw_csr_string(bebob->unit->directory, CSR_MODEL,
+			    model, sizeof(model));
+	if (err < 0)
+		goto end;
+
+	/* get hardware id */
+	err = snd_bebob_read_quad(bebob->unit, INFO_OFFSET_HW_MODEL_ID,
+				  &id);
+	if (err < 0)
+		goto end;
+
+	/* get hardware revision */
+	err = snd_bebob_read_quad(bebob->unit, INFO_OFFSET_HW_MODEL_REVISION,
+				  &revision);
+	if (err < 0)
+		goto end;
+
+	/* get GUID */
+	err = snd_bebob_read_block(bebob->unit, INFO_OFFSET_GUID,
+				   data, sizeof(data));
+	if (err < 0)
+		goto end;
+
+	strcpy(bebob->card->driver, "BeBoB");
+	strcpy(bebob->card->shortname, model);
+	snprintf(bebob->card->longname, sizeof(bebob->card->longname),
+		 "%s %s (id:%d, rev:%d), GUID %08x%08x at %s, S%d",
+		 vendor, model, id, revision,
+		 data[0], data[1], dev_name(&bebob->unit->device),
+		 100 << fw_dev->max_speed);
+	strcpy(bebob->card->mixername, model);
+end:
+	return err;
+}
+
+static void
+bebob_card_free(struct snd_card *card)
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
+bebob_probe(struct fw_unit *unit,
+	    const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_bebob *bebob;
+	unsigned int card_index;
+	int err;
+
+	mutex_lock(&devices_mutex);
+
+	for (card_index = 0; card_index < SNDRV_CARDS; card_index++) {
+		if (!(devices_used & BIT(card_index)) && enable[card_index])
+			break;
+	}
+	if (card_index >= SNDRV_CARDS) {
+		err = -ENOENT;
+		goto end;
+	}
+
+	err = snd_card_create(index[card_index], id[card_index],
+			THIS_MODULE, sizeof(struct snd_bebob), &card);
+	if (err < 0)
+		goto end;
+	card->private_free = bebob_card_free;
+
+	bebob = card->private_data;
+	bebob->card = card;
+	bebob->unit = unit;
+	bebob->card_index = -1;
+	mutex_init(&bebob->mutex);
+	spin_lock_init(&bebob->lock);
+
+	err = name_device(bebob, entry->vendor_id);
+	if (err < 0)
+		goto error;
+
+	snd_card_set_dev(card, &unit->device);
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		goto error;
+	}
+	dev_set_drvdata(&unit->device, bebob);
+	devices_used |= BIT(card_index);
+	bebob->card_index = card_index;
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
+bebob_update(struct fw_unit *unit)
+{
+	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+	fcp_bus_reset(bebob->unit);
+}
+
+
+static void bebob_remove(struct fw_unit *unit)
+{
+	struct snd_bebob *bebob = dev_get_drvdata(&unit->device);
+	snd_card_disconnect(bebob->card);
+	snd_card_free_when_closed(bebob->card);
+}
+
+static const struct ieee1394_device_id bebob_id_table[] = {
+	/* Edirol, FA-66 */
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010049),
+	/* Edirol, FA-101 */
+	SND_BEBOB_DEV_ENTRY(VEN_EDIROL, 0x00010048),
+	/* Presonus, FIREBOX */
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010000),
+	/* PreSonus, FIREPOD/FP10 */
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010066),
+	/* PreSonus, Inspire1394 */
+	SND_BEBOB_DEV_ENTRY(VEN_PRESONUS, 0x00010001),
+	/* BridgeCo, RDAudio1 */
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010048),
+	/* BridgeCo, Audio5 */
+	SND_BEBOB_DEV_ENTRY(VEN_BRIDGECO, 0x00010049),
+	/* Mackie, Onyx 1220/1620/1640 (Firewire I/O Card) */
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010065),
+	/* Mackie, d.2 (Firewire Option) */
+	SND_BEBOB_DEV_ENTRY(VEN_MACKIE, 0x00010067),
+	/* Stanton, ScratchAmp */
+	SND_BEBOB_DEV_ENTRY(VEN_STANTON, 0x00000001),
+	/* Tascam, IF-FW DM */
+	SND_BEBOB_DEV_ENTRY(VEN_TASCAM, 0x00010067),
+	/* Behringer, XENIX UFX 1204 */
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00001204),
+	/* Behringer, XENIX UFX 1604 */
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00001604),
+	/* Behringer, Digital Mixer X32 series (X-UF Card) */
+	SND_BEBOB_DEV_ENTRY(VEN_BEHRINGER, 0x00000006),
+	/* Apogee Electronics, Rosetta 200/400 (X-FireWire card) */
+	/* Apogee Electronics, DA/AD/DD-16X (X-FireWire card) */
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00010048),
+	/* Apogee Electronics, Ensemble */
+	SND_BEBOB_DEV_ENTRY(VEN_APOGEE, 0x00001eee),
+	/* ESI, Quatafire610 */
+	SND_BEBOB_DEV_ENTRY(VEN_ESI, 0x00010064),
+	/* AcousticReality, eARMasterOne */
+	SND_BEBOB_DEV_ENTRY(VEN_ACOUSTIC, 0x00000002),
+	/* CME, MatrixKFW */
+	SND_BEBOB_DEV_ENTRY(VEN_CME, 0x00030000),
+	/* Phonic, Helix Board 12 MkII */
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00050000),
+	/* Phonic, Helix Board 18 MkII */
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00060000),
+	/* Phonic, Helix Board 24 MkII */
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00070000),
+	/* Phonic, Helix Board 12 Universal/18 Universal/24 Universal */
+	SND_BEBOB_DEV_ENTRY(VEN_PHONIC, 0x00000000),
+	/* Lynx, Aurora 8/16 (LT-FW) */
+	SND_BEBOB_DEV_ENTRY(VEN_LYNX, 0x00000001),
+	/* ICON, FireXon */
+	SND_BEBOB_DEV_ENTRY(VEN_ICON, 0x00000001),
+	/* PrismSound, Orpheus */
+	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x00010048),
+	/* PrismSound, ADA-8XR */
+	SND_BEBOB_DEV_ENTRY(VEN_PRISMSOUND, 0x0000ada8),
+	/* IDs are unknown but able to be supported */
+	/*  Apogee, Mini-ME Firewire */
+	/*  Apogee, Mini-DAC Firewire */
+	/*  Behringer, F-Control Audio 1616 */
+	/*  Behringer, F-Control Audio 610 */
+	/*  Cakawalk, Sonar Power Studio 66 */
+	/*  CME, UF400e */
+	/*  ESI, Quotafire XL */
+	/*  Infrasonic, DewX */
+	/*  Infrasonic, Windy6 */
+	/*  Mackie, Digital X Bus x.200 */
+	/*  Mackie, Digital X Bus x.400 */
+	/*  Phonic, HB 12 */
+	/*  Phonic, HB 24 */
+	/*  Phonic, HB 18 */
+	/*  Phonic, FireFly 202 */
+	/*  Phonic, FireFly 302 */
+	/*  Rolf Spuler, Firewire Guitar */
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, bebob_id_table);
+
+static struct fw_driver bebob_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "snd-bebob",
+		.bus	= &fw_bus_type,
+	},
+	.probe    = bebob_probe,
+	.update	  = bebob_update,
+	.remove   = bebob_remove,
+	.id_table = bebob_id_table,
+};
+
+static int __init
+snd_bebob_init(void)
+{
+	return driver_register(&bebob_driver.driver);
+}
+
+static void __exit
+snd_bebob_exit(void)
+{
+	driver_unregister(&bebob_driver.driver);
+	mutex_destroy(&devices_mutex);
+}
+
+module_init(snd_bebob_init);
+module_exit(snd_bebob_exit);
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
new file mode 100644
index 0000000..173f4558
--- /dev/null
+++ b/sound/firewire/bebob/bebob.h
@@ -0,0 +1,64 @@
+/*
+ * bebob.h - a part of driver for BeBoB based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
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
+/* basic register addresses on DM1000 */
+#define BEBOB_ADDR_REG_INFO	0xffffc8020000
+#define BEBOB_ADDR_REG_REQ	0xffffc8021000
+
+struct snd_bebob {
+	struct snd_card *card;
+	struct fw_unit *unit;
+	int card_index;
+
+	struct mutex mutex;
+	spinlock_t lock;
+};
+
+static inline int
+snd_bebob_read_block(struct fw_unit *unit, u64 addr, void *buf, int size)
+{
+	return snd_fw_transaction(unit, TCODE_READ_BLOCK_REQUEST,
+				  BEBOB_ADDR_REG_INFO + addr,
+				  buf, size, 0);
+}
+
+static inline int
+snd_bebob_read_quad(struct fw_unit *unit, u64 addr, u32 *buf)
+{
+	return snd_fw_transaction(unit, TCODE_READ_QUADLET_REQUEST,
+				  BEBOB_ADDR_REG_INFO + addr,
+				  (void *)buf, sizeof(u32), 0);
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


------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
