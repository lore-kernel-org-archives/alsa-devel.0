From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/14] ALSA: fireface: add skeleton for RME
	Fireface series
Date: Fri, 31 Mar 2017 22:05:59 +0900
Message-ID: <20170331130612.18331-2-o-takashi@sakamocchi.jp>
References: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 7F62526722D
 for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2017 15:06:21 +0200 (CEST)
In-Reply-To: <20170331130612.18331-1-o-takashi@sakamocchi.jp>
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

Three types of firmware have released by RME GmbH; for Fireface 400, for
Fireface 800 and for UCX/802/UFX. It's reasonable that these models use
different protocol for communication. Currently, I've investigated
Fireface 400 and nothing others.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig           |   6 +++
 sound/firewire/Makefile          |   1 +
 sound/firewire/fireface/Makefile |   2 +
 sound/firewire/fireface/ff.c     | 113 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/fireface/ff.h     |  28 ++++++++++
 5 files changed, 150 insertions(+)
 create mode 100644 sound/firewire/fireface/Makefile
 create mode 100644 sound/firewire/fireface/ff.c
 create mode 100644 sound/firewire/fireface/ff.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 6acfacf..b75a822 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -152,4 +152,10 @@ config SND_FIREWIRE_MOTU
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-motu.
 
+config SND_FIREFACE
+	tristate "RME Fireface series support"
+	select SND_FIREWIRE_LIB
+	help
+	 Say Y here to include support for RME fireface series.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 9388ded..1b98fa3 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_SND_BEBOB) += bebob/
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += digi00x/
 obj-$(CONFIG_SND_FIREWIRE_TASCAM) += tascam/
 obj-$(CONFIG_SND_FIREWIRE_MOTU) += motu/
+obj-$(CONFIG_SND_FIREFACE) += fireface/
diff --git a/sound/firewire/fireface/Makefile b/sound/firewire/fireface/Makefile
new file mode 100644
index 0000000..2c64ef6
--- /dev/null
+++ b/sound/firewire/fireface/Makefile
@@ -0,0 +1,2 @@
+snd-fireface-objs := ff.o
+obj-$(CONFIG_SND_FIREFACE) += snd-fireface.o
diff --git a/sound/firewire/fireface/ff.c b/sound/firewire/fireface/ff.c
new file mode 100644
index 0000000..358bba2
--- /dev/null
+++ b/sound/firewire/fireface/ff.c
@@ -0,0 +1,113 @@
+/*
+ * ff.c - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "ff.h"
+
+#define OUI_RME	0x000a35
+
+MODULE_DESCRIPTION("RME Fireface series Driver");
+MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
+MODULE_LICENSE("GPL v2");
+
+static void name_card(struct snd_ff *ff)
+{
+	struct fw_device *fw_dev = fw_parent_device(ff->unit);
+	const char *const model = "Fireface Skeleton";
+
+	strcpy(ff->card->driver, "Fireface");
+	strcpy(ff->card->shortname, model);
+	strcpy(ff->card->mixername, model);
+	snprintf(ff->card->longname, sizeof(ff->card->longname),
+		 "RME %s, GUID %08x%08x at %s, S%d", model,
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&ff->unit->device), 100 << fw_dev->max_speed);
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
+	dev_set_drvdata(&unit->device, ff);
+
+	mutex_init(&ff->mutex);
+
+	name_card(ff);
+
+	err = snd_card_register(card);
+	if (err < 0) {
+		snd_card_free(card);
+		return err;
+	}
+
+	return 0;
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
diff --git a/sound/firewire/fireface/ff.h b/sound/firewire/fireface/ff.h
new file mode 100644
index 0000000..64d488e
--- /dev/null
+++ b/sound/firewire/fireface/ff.h
@@ -0,0 +1,28 @@
+/*
+ * ff.h - a part of driver for RME Fireface series
+ *
+ * Copyright (c) 2015-2017 Takashi Sakamoto
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
+
+struct snd_ff {
+	struct snd_card *card;
+	struct fw_unit *unit;
+	struct mutex mutex;
+};
+#endif
-- 
2.9.3
