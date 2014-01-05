From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/8] oxfw: Add skelton for OXFW970/971 based
	devices
Date: Sun,  5 Jan 2014 20:13:30 +0900
Message-ID: <1388920417-5584-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A0BF265172
 for <alsa-devel@alsa-project.org>; Sun,  5 Jan 2014 12:13:51 +0100 (CET)
In-Reply-To: <1388920417-5584-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit add a new driver for BeBoB based devices with no functionality.
This driver just create/remove card instance according to callbacks.

OXFW970/971 are chipsets produced by Oxford Semiconductor for Multi-Channel
Isochronous Streaming FireWire Audio Controller.

Current supported devices:
 - Behringer F-Control Audio 202
 - Mackie Onyx-i series (former model)
 - Mackie Onyx Satellite

Devices possible to be supported if identifying IDs:
 - Mackie, d.2 pro
 - Mackie, d.4 pro
 - Mackie, U.420
 - Mackie, U.420d
 - Mackie, Tapco Link.Firewire/

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig       |  17 +++++
 sound/firewire/Makefile      |   1 +
 sound/firewire/oxfw/Makefile |   2 +
 sound/firewire/oxfw/oxfw.c   | 162 +++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/oxfw/oxfw.h   |  42 +++++++++++
 5 files changed, 224 insertions(+)
 create mode 100644 sound/firewire/oxfw/Makefile
 create mode 100644 sound/firewire/oxfw/oxfw.c
 create mode 100644 sound/firewire/oxfw/oxfw.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index b2c5a7e..f5a466d 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -117,4 +117,21 @@ config SND_BEBOB
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
 
+config SND_OXFW
+	tristate "Oxford Semiconductor OXFW970/971 support"
+	select SND_FIREWIRE_LIB
+	select SND_RAWMIDI
+	select SND_PCM
+	select SND_HWDEP
+        help
+	 Say Y here to include support for FireWire devices based on
+	 Oxford Semiconductor OXFW970/971. SND_FIREWIRE_SPEAKERS also
+	 supports this chipset but this driver supports recording devices:
+	  * Behringer F-Control Audio 202
+	  * Mackie Onyx-i series (former model)
+	  * Mackie Onyx Satellite
+
+          To compile this driver as a module, choose M here: the module
+          will be called snd-oxfw.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index fad8d49..cbcd6ef 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
+obj-$(CONFIG_SND_OXFW) += oxfw/
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
new file mode 100644
index 0000000..9ca49c0
--- /dev/null
+++ b/sound/firewire/oxfw/Makefile
@@ -0,0 +1,2 @@
+snd-oxfw-objs := oxfw.o
+obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
new file mode 100644
index 0000000..34be292
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw.c
@@ -0,0 +1,162 @@
+/*
+ * oxfw.c - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+/*
+ * OXFW970/971 are chipsets produced by Oxford Semiconductor for Multi-Channel
+ * Isochronous Streaming FireWire Audio Controller.
+ */
+#include "oxfw.h"
+
+MODULE_DESCRIPTION("Oxford Semiconductor OXFW970/971 driver");
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
+MODULE_PARM_DESC(enable, "enable OXFW970/971 sound card");
+
+static DEFINE_MUTEX(devices_mutex);
+static unsigned int devices_used;
+
+#define	VEN_BEHRINGER	0x001564
+#define	VEN_LOUD	0x000ff2
+
+static void
+oxfw_card_free(struct snd_card *card)
+{
+	struct snd_oxfw *oxfw = card->private_data;
+
+	if (oxfw->card_index >= 0) {
+		mutex_lock(&devices_mutex);
+		devices_used &= ~BIT(oxfw->card_index);
+		mutex_unlock(&devices_mutex);
+	}
+
+	mutex_destroy(&oxfw->mutex);
+
+	return;
+}
+
+static int
+oxfw_probe(struct fw_unit *unit,
+	    const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_oxfw *oxfw;
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
+			      THIS_MODULE, sizeof(struct snd_oxfw), &card);
+	if (err < 0)
+		goto end;
+	card->private_free = oxfw_card_free;
+
+	oxfw = card->private_data;
+	oxfw->card = card;
+	oxfw->device = fw_parent_device(unit);
+	oxfw->unit = unit;
+	oxfw->card_index = -1;
+	mutex_init(&oxfw->mutex);
+	spin_lock_init(&oxfw->lock);
+
+	snd_card_set_dev(card, &unit->device);
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		goto error;
+	}
+	dev_set_drvdata(&unit->device, oxfw);
+	devices_used |= BIT(card_index);
+	oxfw->card_index = card_index;
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
+oxfw_update(struct fw_unit *unit)
+{
+	return;
+}
+
+static void
+oxfw_remove(struct fw_unit *unit)
+{
+	struct snd_oxfw *oxfw = dev_get_drvdata(&unit->device);
+
+	snd_card_disconnect(oxfw->card);
+	snd_card_free_when_closed(oxfw->card);
+}
+
+static const struct ieee1394_device_id oxfw_id_table[] = {
+	/* Behringer, F-Control Audio 202 */
+	SND_OXFW_DEV_ENTRY(VEN_BEHRINGER, 0x00fc22),
+	/* Mackie, Onyx-i (former model) */
+	SND_OXFW_DEV_ENTRY(VEN_LOUD, 0x081216),
+	/* Mackie, Onyx Sattelite */
+	SND_OXFW_DEV_ENTRY(VEN_LOUD, 0x00200f),
+	/* IDs are unknown but able to be supported */
+	/*  Mackie, d.2 pro */
+	/*  Mackie, d.4 pro */
+	/*  Mackie, U.420 */
+	/*  Mackie, U.420d */
+	/*  Mackie, Tapco Link.Firewire */
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
+
+static struct fw_driver oxfw_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= KBUILD_MODNAME,
+		.bus	= &fw_bus_type,
+	},
+	.probe    = oxfw_probe,
+	.update	  = oxfw_update,
+	.remove   = oxfw_remove,
+	.id_table = oxfw_id_table,
+};
+
+static int __init
+snd_oxfw_init(void)
+{
+	return driver_register(&oxfw_driver.driver);
+}
+
+static void __exit
+snd_oxfw_exit(void)
+{
+	driver_unregister(&oxfw_driver.driver);
+	mutex_destroy(&devices_mutex);
+}
+
+module_init(snd_oxfw_init);
+module_exit(snd_oxfw_exit);
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
new file mode 100644
index 0000000..3aee9e7
--- /dev/null
+++ b/sound/firewire/oxfw/oxfw.h
@@ -0,0 +1,42 @@
+/*
+ * oxford.h - a part of driver for OXFW970/971 based devices
+ *
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef SOUND_OXFW_H_INCLUDED
+#define SOUND_OXFW_H_INCLUDED
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
+struct snd_oxfw {
+	struct snd_card *card;
+	struct fw_device *device;
+	struct fw_unit *unit;
+	int card_index;
+
+	struct mutex mutex;
+	spinlock_t lock;
+};
+
+#define SND_OXFW_DEV_ENTRY(vendor, model) \
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
