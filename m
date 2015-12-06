From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/3] fireface: add skeleton for RME Fireface
	series
Date: Sun,  6 Dec 2015 22:23:42 +0900
Message-ID: <1449408224-13955-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E1026548B
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 14:23:49 +0100 (CET)
In-Reply-To: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a new driver for RME Fireface series. This commit just
creates/removes card instance according to IEEE 1394 bus event. More
functions will be added in following commits.

Just after appearing on IEEE 1394 bus, this unit generates several bus
resets. This is due to loading and enabling firmware from on-board flash
memory. Therefore, it's better to postopone calling snd_card_register()
(not yet).

Three types of firmware have been released by RME GmbH; for Fireface 400,
for Fireface 800 and for UCX/802/UFX. It's reasonable that these models
use different protocol for communication. Currently, I've investigated
Fireface 400 and nothing others.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig             |   7 ++
 sound/firewire/Makefile            |   1 +
 sound/firewire/fireface/Makefile   |   2 +
 sound/firewire/fireface/fireface.c | 139 +++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/fireface.h |  41 +++++++++++
 5 files changed, 190 insertions(+)
 create mode 100644 sound/firewire/fireface/Makefile
 create mode 100644 sound/firewire/fireface/fireface.c
 create mode 100644 sound/firewire/fireface/fireface.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index e92a6d9..0eef3b4 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -148,4 +148,11 @@ config SND_FIREWIRE_TASCAM
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-tascam.
 
+config SND_FIREFACE
+	tristate "RME Fireface series support"
+	select SND_FIREWIRE_LIB
+	help
+	 Say Y here to include support for RME fireface series.
+	  * Fireface 400
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index f5fb625..8cd4d2d 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += digi00x/
 obj-$(CONFIG_SND_FIREWIRE_TASCAM) += tascam/
+obj-$(CONFIG_SND_FIREFACE) += fireface/
diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
new file mode 100644
index 0000000..f7113ab
--- /dev/null
+++ b/sound/firewire/fireface/Makefile
@@ -0,0 +1,2 @@
+snd-fireface-objs := fireface.o
+obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
new file mode 100644
index 0000000..7e21667
--- /dev/null
+++ b/sound/firewire/fireface/fireface.c
@@ -0,0 +1,139 @@
+/*
+ * fireface.c - a part of driver for RMW Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "fireface.h"
+
+#define OUI_RME	0x000a35
+
+MODULE_DESCRIPTION("RME Fireface series Driver");
+MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
+MODULE_LICENSE("GPL v2");
+
+static int identify_model(struct snd_ff *ff,
+			  const struct ieee1394_device_id *entry)
+{
+	struct fw_device *fw_dev = fw_parent_device(ff->unit);
+	const char *model;
+
+	/* TODO: how to detect all of models? */
+	model = "Fireface 400";
+
+	strcpy(ff->card->driver, "Fireface");
+	strcpy(ff->card->shortname, model);
+	strcpy(ff->card->mixername, model);
+	snprintf(ff->card->longname, sizeof(ff->card->longname),
+		 "RME %s, GUID %08x%08x at %s, S%d", model,
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&ff->unit->device), 100 << fw_dev->max_speed);
+
+	return 0;
+}
+
+static void ff_card_free(struct snd_card *card)
+{
+	struct snd_ff *ff = card->private_data;
+
+	fw_unit_put(ff->unit);
+
+	mutex_destroy(&ff->mutex);
+}
+
+static int snd_ff_probe(struct fw_unit *unit,
+			   const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_ff *ff;
+	int err;
+
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(struct snd_ff), &card);
+	if (err < 0)
+		return err;
+	card->private_free = ff_card_free;
+
+	/* initialize myself */
+	ff = card->private_data;
+	ff->card = card;
+	ff->unit = fw_unit_get(unit);
+
+	mutex_init(&ff->mutex);
+	spin_lock_init(&ff->lock);
+	dev_set_drvdata(&unit->device, ff);
+
+	err = identify_model(ff, entry);
+	if (err < 0)
+		goto error;
+
+	/*
+	 * TODO: the rest of work should be done in workqueue because of some
+	 * bus resets.
+	 */
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto error;
+
+	return err;
+error:
+	snd_card_free(card);
+	return err;
+}
+
+static void snd_ff_update(struct fw_unit *unit)
+{
+	return;
+}
+
+static void snd_ff_remove(struct fw_unit *unit)
+{
+	struct snd_ff *ff = dev_get_drvdata(&unit->device);
+
+	/* No need to wait for releasing card object in this context. */
+	snd_card_free_when_closed(ff->card);
+}
+
+static const struct ieee1394_device_id snd_ff_id_table[] = {
+	/* Fireface 400 */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_SPECIFIER_ID |
+				  IEEE1394_MATCH_VERSION |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= OUI_RME,
+		.specifier_id	= 0x000a35,
+		.version	= 0x000002,
+		.model_id	= 0x101800,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, snd_ff_id_table);
+
+static struct fw_driver ff_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "snd-fireface",
+		.bus	= &fw_bus_type,
+	},
+	.probe    = snd_ff_probe,
+	.update   = snd_ff_update,
+	.remove   = snd_ff_remove,
+	.id_table = snd_ff_id_table,
+};
+
+static int __init snd_ff_init(void)
+{
+	return driver_register(&ff_driver.driver);
+}
+
+static void __exit snd_ff_exit(void)
+{
+	driver_unregister(&ff_driver.driver);
+}
+
+module_init(snd_ff_init);
+module_exit(snd_ff_exit);
diff --git a/sound/firewire/fireface/fireface.h b/sound/firewire/fireface/fireface.h
new file mode 100644
index 0000000..e72d53f
--- /dev/null
+++ b/sound/firewire/fireface/fireface.h
@@ -0,0 +1,41 @@
+/*
+ * fireface.h - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2016 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef SOUND_FIREFACE_H_INCLUDED
+#define SOUND_FIREFACE_H_INCLUDED
+
+#include <linux/device.h>
+#include <linux/firewire.h>
+#include <linux/firewire-constants.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/compat.h>
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/info.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/firewire.h>
+#include <sound/hwdep.h>
+#include <sound/rawmidi.h>
+
+#include "../lib.h"
+#include "../amdtp-stream.h"
+#include "../iso-resources.h"
+
+struct snd_ff {
+	struct snd_card *card;
+	struct fw_unit *unit;
+
+	struct mutex mutex;
+	spinlock_t lock;
+};
+#endif
-- 
2.5.0
