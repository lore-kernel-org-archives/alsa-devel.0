From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 29/37] ALSA: firewire-motu: add skeleton
	for Mark of the unicorn (MOTU) FireWire series
Date: Sat, 11 Jul 2015 23:12:40 +0900
Message-ID: <1436623968-10780-30-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DDF32605B6
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:06 +0200 (CEST)
In-Reply-To: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds an new driver for MOTU FireWire series. In this commit,
this driver just creates/removes card instance according to bus event.
More functionalities will be added in following commits.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig       |  11 ++++
 sound/firewire/Makefile      |   1 +
 sound/firewire/motu/Makefile |   2 +
 sound/firewire/motu/motu.c   | 127 +++++++++++++++++++++++++++++++++++++++++++
 sound/firewire/motu/motu.h   |  34 ++++++++++++
 5 files changed, 175 insertions(+)
 create mode 100644 sound/firewire/motu/Makefile
 create mode 100644 sound/firewire/motu/motu.c
 create mode 100644 sound/firewire/motu/motu.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 12993fa..7ee8e3e 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -147,4 +147,15 @@ config SND_FIREWIRE_TASCAM
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-tascam.
 
+config SND_FIREWIRE_MOTU
+	tristate "Mark of the unicorn FireWire series support"
+	select SND_FIREWIRE_LIB
+	select SND_HWDEP
+	help
+	 Say Y here to enable support for FireWire devices which MOTU produced:
+	  * 828 Mk II
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called snd-firewire-motu.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 6ae50f5..8923abf 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += digi00x/
 obj-$(CONFIG_SND_FIREWIRE_TASCAM) += tascam/
+obj-$(CONFIG_SND_FIREWIRE_MOTU) += motu/
diff --git a/sound/firewire/motu/Makefile b/sound/firewire/motu/Makefile
new file mode 100644
index 0000000..f4cfd14
--- /dev/null
+++ b/sound/firewire/motu/Makefile
@@ -0,0 +1,2 @@
+snd-firewire-motu-objs := motu.o
+obj-m += snd-firewire-motu.o
diff --git a/sound/firewire/motu/motu.c b/sound/firewire/motu/motu.c
new file mode 100644
index 0000000..929899dd
--- /dev/null
+++ b/sound/firewire/motu/motu.c
@@ -0,0 +1,127 @@
+/*
+ * motu.c - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "motu.h"
+
+MODULE_DESCRIPTION("MOTU FireWire driver");
+MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
+MODULE_LICENSE("GPL v2");
+
+static void name_card(struct snd_motu *motu)
+{
+	struct fw_device *fw_dev = fw_parent_device(motu->unit);
+	struct fw_csr_iterator it;
+	int key, val;
+	u32 version = 0;
+
+	fw_csr_iterator_init(&it, motu->unit->directory);
+	while (fw_csr_iterator_next(&it, &key, &val)) {
+		switch (key) {
+		case CSR_VERSION:
+			version = be32_to_cpu(val);
+			break;
+		}
+	}
+
+	strcpy(motu->card->driver, "MOTU");
+	snprintf(motu->card->longname, sizeof(motu->card->longname),
+		 "MOTU (version:%d), GUID %08x%08x at %s, S%d",
+		 be32_to_cpu(version),
+		 fw_dev->config_rom[3], fw_dev->config_rom[4],
+		 dev_name(&motu->unit->device), 100 << fw_dev->max_speed);
+}
+
+static void motu_card_free(struct snd_card *card)
+{
+	struct snd_motu *motu = card->private_data;
+
+	fw_unit_put(motu->unit);
+
+	mutex_destroy(&motu->mutex);
+}
+
+static int motu_probe(struct fw_unit *unit, const struct ieee1394_device_id *id)
+{
+	struct snd_card *card;
+	struct snd_motu *motu;
+	int err;
+
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(*motu), &card);
+	if (err < 0)
+		return err;
+
+	motu = card->private_data;
+	motu->card = card;
+	motu->unit = fw_unit_get(unit);
+	card->private_free = motu_card_free;
+
+	mutex_init(&motu->mutex);
+
+	name_card(motu);
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto error;
+
+	dev_set_drvdata(&unit->device, motu);
+
+	return 0;
+error:
+	snd_card_free(card);
+	return err;
+}
+
+static void motu_remove(struct fw_unit *unit)
+{
+	struct snd_motu *motu = dev_get_drvdata(&unit->device);
+
+	/* No need to wait for releasing card object in this context. */
+	snd_card_free_when_closed(motu->card);
+}
+
+static void motu_bus_reset(struct fw_unit *unit)
+{
+	return;
+}
+
+static const struct ieee1394_device_id motu_id_table[] = {
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID |
+				  IEEE1394_MATCH_SPECIFIER_ID,
+		.vendor_id	= 0x0001f2,
+		.specifier_id	= 0x0001f2,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(ieee1394, motu_id_table);
+
+static struct fw_driver motu_driver = {
+	.driver   = {
+		.owner	= THIS_MODULE,
+		.name	= KBUILD_MODNAME,
+		.bus	= &fw_bus_type,
+	},
+	.probe    = motu_probe,
+	.update   = motu_bus_reset,
+	.remove   = motu_remove,
+	.id_table = motu_id_table,
+};
+
+static int __init alsa_motu_init(void)
+{
+	return driver_register(&motu_driver.driver);
+}
+
+static void __exit alsa_motu_exit(void)
+{
+	driver_unregister(&motu_driver.driver);
+}
+
+module_init(alsa_motu_init);
+module_exit(alsa_motu_exit);
diff --git a/sound/firewire/motu/motu.h b/sound/firewire/motu/motu.h
new file mode 100644
index 0000000..df16750
--- /dev/null
+++ b/sound/firewire/motu/motu.h
@@ -0,0 +1,34 @@
+/*
+ * motu.h - a part of driver for MOTU FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef SOUND_FIREWIRE_MOTU_H_INCLUDED
+#define SOUND_FIREWIRE_MOTU_H_INCLUDED
+
+#include <linux/device.h>
+#include <linux/firewire.h>
+#include <linux/firewire-constants.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+
+#include "../amdtp-stream.h"
+#include "../iso-resources.h"
+#include "../lib.h"
+
+struct snd_motu {
+	struct snd_card *card;
+	struct fw_unit *unit;
+
+	struct mutex mutex;
+};
+
+#endif
-- 
2.1.4
