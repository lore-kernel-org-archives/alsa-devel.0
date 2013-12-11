From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/8] fireworks: Add skelton for Fireworks based
	devices
Date: Wed, 11 Dec 2013 18:15:52 +0900
Message-ID: <1386753359-12458-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BBB0261691
 for <alsa-devel@alsa-project.org>; Wed, 11 Dec 2013 10:16:30 +0100 (CET)
In-Reply-To: <1386753359-12458-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This commit add a new driver with no functionality. This driver just
create/remove card instance according to callbacks.

Current supported devices:
 - Mackie Onyx 400F/1200F
 - Echo AudioFire8(until 2009 July)/AudioFire12
 - Echo AudioFire2/4/8(since 2009 July)/Pre8
 - Echo Fireworks 8/HDMI
 - Gibson Robot Interface pack/GoldTop

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig               |  15 +++
 sound/firewire/Makefile              |   1 +
 sound/firewire/fireworks/Makefile    |   2 +
 sound/firewire/fireworks/fireworks.c | 195 +++++++++++++++++++++++++++++++++++
 sound/firewire/fireworks/fireworks.h |  52 ++++++++++
 5 files changed, 265 insertions(+)
 create mode 100644 sound/firewire/fireworks/Makefile
 create mode 100644 sound/firewire/fireworks/fireworks.c
 create mode 100644 sound/firewire/fireworks/fireworks.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index b3e274f..46f9f25 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -61,4 +61,19 @@ config SND_SCS1X
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-scs1x.
 
+config SND_FIREWORKS
+	tristate "Echo Fireworks board module support"
+	select SND_FIREWIRE_LIB
+	help
+	  Say Y here to include support for FireWire devices based
+	  on Echo Digital Audio Fireworks board:
+	   * Mackie Onyx 400F/1200F
+	   * Echo AudioFire8(until 2009 July)/AudioFire12
+	   * Echo AudioFire2/4/8(since 2009 July)/Pre8
+	   * Echo Fireworks 8/HDMI
+	   * Gibson Robot Interface Pack/GoldTop
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-fireworks.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 5099550..5cd39dc 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SND_DICE) += snd-dice.o
 obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
+obj-$(CONFIG_SND_FIREWORKS) += fireworks/
diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
new file mode 100644
index 0000000..99f6fc3
--- /dev/null
+++ b/sound/firewire/fireworks/Makefile
@@ -0,0 +1,2 @@
+snd-fireworks-objs := fireworks.o
+obj-m += snd-fireworks.o
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
new file mode 100644
index 0000000..3b62387
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks.c
@@ -0,0 +1,195 @@
+/*
+ * fireworks.c - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2009-2010 Clemens Ladisch
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
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
+/*
+ * Fireworks is a board module which Echo Audio produces. This board module
+ * consists of three chipsets:
+ *  - Communication chipset for IEEE1394 PHY/Link and IEC 61883-1/6
+ *  - DSP or/and FPGA for signal processing
+ *  - Flash Memory to store firmwares
+ */
+
+#include "fireworks.h"
+
+MODULE_DESCRIPTION("Echo Fireworks driver");
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
+MODULE_PARM_DESC(enable, "enable Fireworks sound card");
+
+static DEFINE_MUTEX(devices_mutex);
+static unsigned int devices_used;
+
+#define VENDOR_LOUD			0x000ff2
+#define  MODEL_MACKIE_400F		0x00400f
+#define  MODEL_MACKIE_1200F		0x01200f
+
+#define VENDOR_ECHO			0x001486
+#define  MODEL_ECHO_AUDIOFIRE_12	0x00af12
+#define  MODEL_ECHO_AUDIOFIRE_12HD	0x0af12d
+#define  MODEL_ECHO_AUDIOFIRE_12_APPLE	0x0af12a
+/* This is applied for AudioFire8 (until 2009 July) */
+#define  MODEL_ECHO_AUDIOFIRE_8		0x000af8
+#define  MODEL_ECHO_AUDIOFIRE_2		0x000af2
+#define  MODEL_ECHO_AUDIOFIRE_4		0x000af4
+/* AudioFire9 is applied for AudioFire8(since 2009 July) and AudioFirePre8 */
+#define  MODEL_ECHO_AUDIOFIRE_9		0x000af9
+/* unknown as product */
+#define  MODEL_ECHO_FIREWORKS_8		0x0000f8
+#define  MODEL_ECHO_FIREWORKS_HDMI	0x00afd1
+
+#define VENDOR_GIBSON			0x00075b
+/* for Robot Interface Pack of Dark Fire, Dusk Tiger, Les Paul Standard 2010 */
+#define  MODEL_GIBSON_RIP		0x00afb2
+/* unknown as product */
+#define  MODEL_GIBSON_GOLDTOP		0x00afb9
+
+static void
+efw_card_free(struct snd_card *card)
+{
+	struct snd_efw *efw = card->private_data;
+
+	if (efw->card_index >= 0) {
+		mutex_lock(&devices_mutex);
+		devices_used &= ~BIT(efw->card_index);
+		mutex_unlock(&devices_mutex);
+	}
+
+	mutex_destroy(&efw->mutex);
+
+	return;
+}
+
+static int
+efw_probe(struct fw_unit *unit,
+	  const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_efw *efw;
+	int card_index, err;
+
+	mutex_lock(&devices_mutex);
+
+	/* check registered cards */
+	for (card_index = 0; card_index < SNDRV_CARDS; ++card_index)
+		if (!(devices_used & BIT(card_index)) && enable[card_index])
+			break;
+	if (card_index >= SNDRV_CARDS) {
+		err = -ENOENT;
+		goto end;
+	}
+
+	err = snd_card_create(index[card_index], id[card_index],
+			      THIS_MODULE, sizeof(struct snd_efw), &card);
+	if (err < 0)
+		goto end;
+	card->private_free = efw_card_free;
+
+	efw = card->private_data;
+	efw->card = card;
+	efw->device = fw_parent_device(unit);
+	efw->unit = unit;
+	efw->card_index = -1;
+	mutex_init(&efw->mutex);
+	spin_lock_init(&efw->lock);
+
+	strcpy(efw->card->driver, "Fireworks");
+	strcpy(efw->card->shortname, "Fireworks");
+	strcpy(efw->card->longname, "Fireworks");
+	strcpy(efw->card->mixername, "Fireworks");
+
+	snd_card_set_dev(card, &unit->device);
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		goto end;
+	}
+	dev_set_drvdata(&unit->device, efw);
+	devices_used |= BIT(card_index);
+	efw->card_index = card_index;
+end:
+	mutex_unlock(&devices_mutex);
+	return err;
+}
+
+static void efw_update(struct fw_unit *unit)
+{
+	return;
+}
+
+static void efw_remove(struct fw_unit *unit)
+{
+	struct snd_efw *efw = dev_get_drvdata(&unit->device);
+	snd_card_disconnect(efw->card);
+	snd_card_free_when_closed(efw->card);
+	return;
+}
+
+static const struct ieee1394_device_id efw_id_table[] = {
+	SND_EFW_DEV_ENTRY(VENDOR_LOUD, MODEL_MACKIE_400F),
+	SND_EFW_DEV_ENTRY(VENDOR_LOUD, MODEL_MACKIE_1200F),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_8),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_12),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_12HD),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_12_APPLE),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_2),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_4),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_AUDIOFIRE_9),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_FIREWORKS_8),
+	SND_EFW_DEV_ENTRY(VENDOR_ECHO, MODEL_ECHO_FIREWORKS_HDMI),
+	SND_EFW_DEV_ENTRY(VENDOR_GIBSON, MODEL_GIBSON_RIP),
+	SND_EFW_DEV_ENTRY(VENDOR_GIBSON, MODEL_GIBSON_GOLDTOP),
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, efw_id_table);
+
+static struct fw_driver efw_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "snd-fireworks",
+		.bus = &fw_bus_type,
+	},
+	.probe    = efw_probe,
+	.update   = efw_update,
+	.remove   = efw_remove,
+	.id_table = efw_id_table,
+};
+
+static int __init snd_efw_init(void)
+{
+	return driver_register(&efw_driver.driver);
+}
+
+static void __exit snd_efw_exit(void)
+{
+	driver_unregister(&efw_driver.driver);
+	mutex_destroy(&devices_mutex);
+}
+
+module_init(snd_efw_init);
+module_exit(snd_efw_exit);
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
new file mode 100644
index 0000000..ed745d0
--- /dev/null
+++ b/sound/firewire/fireworks/fireworks.h
@@ -0,0 +1,52 @@
+/*
+ * fireworks.h - a part of driver for Fireworks based devices
+ *
+ * Copyright (c) 2009-2010 Clemens Ladisch
+ * Copyright (c) 2013 Takashi Sakamoto
+ *
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
+#ifndef SOUND_FIREWORKS_H_INCLUDED
+#define SOUND_FIREWORKS_H_INCLUDED
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
+struct snd_efw {
+	struct snd_card *card;
+	struct fw_device *device;
+	struct fw_unit *unit;
+	int card_index;
+
+	struct mutex mutex;
+	spinlock_t lock;
+};
+
+#define SND_EFW_DEV_ENTRY(vendor, model) \
+{ \
+	.match_flags	= IEEE1394_MATCH_VENDOR_ID | \
+			  IEEE1394_MATCH_MODEL_ID, \
+	.vendor_id	= vendor,\
+	.model_id	= model \
+}
+
+#endif
-- 
1.8.3.2
