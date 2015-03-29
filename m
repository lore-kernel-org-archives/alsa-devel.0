From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/11] ALSA: digi00x: add skeleton for Digi
	002/003 device driver
Date: Mon, 30 Mar 2015 00:05:21 +0900
Message-ID: <1427641531-9047-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 927192604BE
 for <alsa-devel@alsa-project.org>; Sun, 29 Mar 2015 17:05:43 +0200 (CEST)
In-Reply-To: <1427641531-9047-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: damien@zamaudio.com, robin@gareus.org, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit adds a new driver for Digidesign 002/003 family. Currently
this driver just creates/removes card instance according to bus event.

Digidesign 002/003 family consists of:
 * Agere FW802B for IEEE 1394 PHY layer
 * PDI 1394L40 for IEEE 1394 LINK layer and IEC 61883 interface
 * ALTERA ACEX EP1K50 for IEC 61883 layer and DSP controller
 * ADSP-21065L for signal processing

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig           |   8 +++
 sound/firewire/Makefile          |   1 +
 sound/firewire/digi00x/Makefile  |   2 +
 sound/firewire/digi00x/digi00x.c | 136 +++++++++++++++++++++++++++++++++++++++
 sound/firewire/digi00x/digi00x.h |  33 ++++++++++
 5 files changed, 180 insertions(+)
 create mode 100644 sound/firewire/digi00x/Makefile
 create mode 100644 sound/firewire/digi00x/digi00x.c
 create mode 100644 sound/firewire/digi00x/digi00x.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index ecec547..594b6d1 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -118,4 +118,12 @@ config SND_BEBOB
           To compile this driver as a module, choose M here: the module
           will be called snd-bebob.
 
+config SND_DIGI00X
+	tristate "Digidesign 002/003 family support"
+	help
+	 Say Y here to include support for Digidesign 002/003 family.
+
+         To compile this driver as a module, choose M here: the module
+         will be called snd-digi00x.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 8b37f08..9b99ab2 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
+obj-$(CONFIG_SND_DIGI00X) += digi00x/
diff --git a/sound/firewire/digi00x/Makefile b/sound/firewire/digi00x/Makefile
new file mode 100644
index 0000000..e30e233
--- /dev/null
+++ b/sound/firewire/digi00x/Makefile
@@ -0,0 +1,2 @@
+snd-digi00x-objs := digi00x.o
+obj-m += snd-digi00x.o
diff --git a/sound/firewire/digi00x/digi00x.c b/sound/firewire/digi00x/digi00x.c
new file mode 100644
index 0000000..6f427a2
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x.c
@@ -0,0 +1,136 @@
+/*
+ * digi00x.c - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "digi00x.h"
+
+MODULE_DESCRIPTION("Digidesign 002/003 Driver");
+MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
+MODULE_LICENSE("GPL v2");
+
+#define VENDOR_DIGIDESIGN	0x00a07e
+#define MODEL_DIGI00X		0x000002
+
+static int name_card(struct snd_dg00x *dg00x)
+{
+	struct fw_device *fw_dev = fw_parent_device(dg00x->unit);
+	char name[32] = {0};
+	char *model;
+	int err;
+
+	err = fw_csr_string(dg00x->unit->directory, CSR_MODEL, name,
+			    sizeof(name));
+	if (err < 0)
+		return err;
+
+	model = name;
+	if (model[0] == ' ')
+		model = strchr(model, ' ') + 1;
+
+	strcpy(dg00x->card->driver, "Digi00x");
+	strcpy(dg00x->card->shortname, model);
+	strcpy(dg00x->card->mixername, model);
+	snprintf(dg00x->card->longname, sizeof(dg00x->card->longname),
+		 "Digidesign %s, GUID %08x%08x at %s, S%d", model,
+		 cpu_to_be32(fw_dev->config_rom[3]),
+		 cpu_to_be32(fw_dev->config_rom[4]),
+		 dev_name(&dg00x->unit->device), 100 << fw_dev->max_speed);
+
+	return 0;
+}
+
+static void dg00x_card_free(struct snd_card *card)
+{
+	struct snd_dg00x *dg00x = card->private_data;
+
+	fw_unit_put(dg00x->unit);
+
+	mutex_destroy(&dg00x->mutex);
+}
+
+static int snd_dg00x_probe(struct fw_unit *unit,
+			   const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_dg00x *dg00x;
+	int err;
+
+	/* create card */
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(struct snd_dg00x), &card);
+	if (err < 0)
+		return err;
+	card->private_free = dg00x_card_free;
+
+	/* initialize myself */
+	dg00x = card->private_data;
+	dg00x->card = card;
+	dg00x->unit = fw_unit_get(unit);
+
+	mutex_init(&dg00x->mutex);
+	spin_lock_init(&dg00x->lock);
+
+	err = name_card(dg00x);
+	if (err < 0)
+		goto error;
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto error;
+
+	dev_set_drvdata(&unit->device, dg00x);
+
+	return err;
+error:
+	snd_card_free(card);
+	return err;
+}
+
+static void snd_dg00x_remove(struct fw_unit *unit)
+{
+	struct snd_dg00x *dg00x = dev_get_drvdata(&unit->device);
+
+	/* No need to wait for releasing card object in this context. */
+	snd_card_free_when_closed(dg00x->card);
+}
+
+
+static const struct ieee1394_device_id snd_dg00x_id_table[] = {
+	/* Both of 002/003 use the same ID. */
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_MODEL_ID,
+		.vendor_id = VENDOR_DIGIDESIGN,
+		.model_id = MODEL_DIGI00X,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, snd_dg00x_id_table);
+
+static struct fw_driver dg00x_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "snd-digi00x",
+		.bus = &fw_bus_type,
+	},
+	.probe    = snd_dg00x_probe,
+	.remove   = snd_dg00x_remove,
+	.id_table = snd_dg00x_id_table,
+};
+
+static int __init snd_dg00x_init(void)
+{
+	return driver_register(&dg00x_driver.driver);
+}
+
+static void __exit snd_dg00x_exit(void)
+{
+	driver_unregister(&dg00x_driver.driver);
+}
+
+module_init(snd_dg00x_init);
+module_exit(snd_dg00x_exit);
diff --git a/sound/firewire/digi00x/digi00x.h b/sound/firewire/digi00x/digi00x.h
new file mode 100644
index 0000000..59425cd
--- /dev/null
+++ b/sound/firewire/digi00x/digi00x.h
@@ -0,0 +1,33 @@
+/*
+ * digi00x.h - a part of driver for Digidesign Digi 002/003 family
+ *
+ * Copyright (c) 2014-2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#ifndef SOUND_DIGI00X_H_INCLUDED
+#define SOUND_DIGI00X_H_INCLUDED
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
+struct snd_dg00x {
+	struct snd_card *card;
+	struct fw_unit *unit;
+	int card_index;
+
+	struct mutex mutex;
+	spinlock_t lock;
+};
+
+#endif
-- 
2.1.0
