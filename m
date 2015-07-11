From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 17/37] ALSA: firewire-tascam: add skeleton
	for TASCAM FireWire series
Date: Sat, 11 Jul 2015 23:12:28 +0900
Message-ID: <1436623968-10780-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1436623968-10780-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id E963C2605AA
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 16:13:05 +0200 (CEST)
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

This commit adds a new driver for TASCAM FireWire series. In this commit,
this driver just creates/removes card instance according to bus event.
More functionalities will be added in following commits.

TASCAM FireWire series consists of:
 * PDI 1394P23 for IEEE 1394 PHY layer
 * PDI 1394L40 for IEEE 1394 LINK layer and IEC 61883 interface
 * XILINX XC9536XL
 * XILINX Spartan-II XC2S100
 * ATMEL AT91M42800A

I observed that these models don't work properly with 1394 OHCI controller
based on VT6315. It may be due to the PHY/LINK layer issues. Using 1394
OHCI controller produced by the other vendors such as Texas Instruments
may enable to work. Or adding another node on the bus.

Ilya Zimnovich had investigated TASCAM FireWire series in 2011, and
discover some features of his FW-1804. You can see a part of his research
in FFADO project.
http://subversion.ffado.org/wiki/Tascam

Some of my work are based on Ilya's investigation, while this series
doesn't support the FW_1804, because of a lack of config ROM
information and its protocol detail, especially for PCM channels.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig         |  11 +++
 sound/firewire/Makefile        |   1 +
 sound/firewire/tascam/Makefile |   2 +
 sound/firewire/tascam/tascam.c | 155 +++++++++++++++++++++++++++++++++++++++++
 sound/firewire/tascam/tascam.h |  29 ++++++++
 5 files changed, 198 insertions(+)
 create mode 100644 sound/firewire/tascam/Makefile
 create mode 100644 sound/firewire/tascam/tascam.c
 create mode 100644 sound/firewire/tascam/tascam.h

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index 80f3b57..ce51fdd 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -135,4 +135,15 @@ config SND_FIREWIRE_DIGI00X
 	 To compile this driver as a module, choose M here: the module
 	 will be called snd-firewire-digi00x.
 
+config SND_FIREWIRE_TASCAM
+	tristate "TASCAM FireWire series support"
+	select SND_FIREWIRE_LIB
+	help
+	 Say Y here to include support for TASCAM.
+	  * FW-1884
+	  * FW-1804
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called snd-firewire-tascam.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 5325d15..6ae50f5 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
 obj-$(CONFIG_SND_FIREWIRE_DIGI00X) += digi00x/
+obj-$(CONFIG_SND_FIREWIRE_TASCAM) += tascam/
diff --git a/sound/firewire/tascam/Makefile b/sound/firewire/tascam/Makefile
new file mode 100644
index 0000000..29bdbce
--- /dev/null
+++ b/sound/firewire/tascam/Makefile
@@ -0,0 +1,2 @@
+snd-firewire-tascam-objs := tascam.o
+obj-m += snd-firewire-tascam.o
diff --git a/sound/firewire/tascam/tascam.c b/sound/firewire/tascam/tascam.c
new file mode 100644
index 0000000..9f2d2a3
--- /dev/null
+++ b/sound/firewire/tascam/tascam.c
@@ -0,0 +1,155 @@
+/*
+ * tascam.c - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
+
+#include "tascam.h"
+
+MODULE_DESCRIPTION("TASCAM FireWire series Driver");
+MODULE_AUTHOR("Takashi Sakamoto <o-takashi@sakamocchi.jp>");
+MODULE_LICENSE("GPL v2");
+
+static int check_name(struct snd_tscm *tscm)
+{
+	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
+	char vendor[8];
+	char model[8];
+	__u32 data;
+
+	/* Retrieve model name. */
+	data = be32_to_cpu(fw_dev->config_rom[28]);
+	memcpy(model, &data, 4);
+	data = be32_to_cpu(fw_dev->config_rom[29]);
+	memcpy(model + 4, &data, 4);
+	model[7] = '\0';
+
+	/* Retrieve vendor name. */
+	data = be32_to_cpu(fw_dev->config_rom[23]);
+	memcpy(vendor, &data, 4);
+	data = be32_to_cpu(fw_dev->config_rom[24]);
+	memcpy(vendor + 4, &data, 4);
+	vendor[7] = '\0';
+
+	strcpy(tscm->card->driver, "FW-TASCAM");
+	strcpy(tscm->card->shortname, model);
+	strcpy(tscm->card->mixername, model);
+	snprintf(tscm->card->longname, sizeof(tscm->card->longname),
+		 "%s %s, GUID %08x%08x at %s, S%d", vendor, model,
+		 cpu_to_be32(fw_dev->config_rom[3]),
+		 cpu_to_be32(fw_dev->config_rom[4]),
+		 dev_name(&tscm->unit->device), 100 << fw_dev->max_speed);
+
+	return 0;
+}
+
+static void tscm_card_free(struct snd_card *card)
+{
+	struct snd_tscm *tscm = card->private_data;
+
+	fw_unit_put(tscm->unit);
+
+	mutex_destroy(&tscm->mutex);
+}
+
+static int snd_tscm_probe(struct fw_unit *unit,
+			   const struct ieee1394_device_id *entry)
+{
+	struct snd_card *card;
+	struct snd_tscm *tscm;
+	int err;
+
+	/* create card */
+	err = snd_card_new(&unit->device, -1, NULL, THIS_MODULE,
+			   sizeof(struct snd_tscm), &card);
+	if (err < 0)
+		return err;
+	card->private_free = tscm_card_free;
+
+	/* initialize myself */
+	tscm = card->private_data;
+	tscm->card = card;
+	tscm->unit = fw_unit_get(unit);
+
+	mutex_init(&tscm->mutex);
+
+	err = check_name(tscm);
+	if (err < 0)
+		goto error;
+
+	err = snd_card_register(card);
+	if (err < 0)
+		goto error;
+
+	dev_set_drvdata(&unit->device, tscm);
+
+	return err;
+error:
+	snd_card_free(card);
+	return err;
+}
+
+static void snd_tscm_update(struct fw_unit *unit)
+{
+	return;
+}
+
+static void snd_tscm_remove(struct fw_unit *unit)
+{
+	struct snd_tscm *tscm = dev_get_drvdata(&unit->device);
+
+	/* No need to wait for releasing card object in this context. */
+	snd_card_free_when_closed(tscm->card);
+}
+
+static const struct ieee1394_device_id snd_tscm_id_table[] = {
+	/* FW-1082 */
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_SPECIFIER_ID |
+			       IEEE1394_MATCH_VERSION,
+		.vendor_id = 0x00022e,
+		.specifier_id = 0x00022e,
+		.version = 0x800003,
+	},
+	/* FW-1884 */
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_SPECIFIER_ID |
+			       IEEE1394_MATCH_VERSION,
+		.vendor_id = 0x00022e,
+		.specifier_id = 0x00022e,
+		.version = 0x800000,
+	},
+	/* FW-1804 mey be supported if IDs are clear. */
+	/* FE-08 requires reverse-engineering because it just has faders. */
+	{}
+};
+MODULE_DEVICE_TABLE(ieee1394, snd_tscm_id_table);
+
+static struct fw_driver tscm_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "snd-firewire-tascam",
+		.bus = &fw_bus_type,
+	},
+	.probe    = snd_tscm_probe,
+	.update   = snd_tscm_update,
+	.remove   = snd_tscm_remove,
+	.id_table = snd_tscm_id_table,
+};
+
+static int __init snd_tscm_init(void)
+{
+	return driver_register(&tscm_driver.driver);
+}
+
+static void __exit snd_tscm_exit(void)
+{
+	driver_unregister(&tscm_driver.driver);
+}
+
+module_init(snd_tscm_init);
+module_exit(snd_tscm_exit);
diff --git a/sound/firewire/tascam/tascam.h b/sound/firewire/tascam/tascam.h
new file mode 100644
index 0000000..8aa5852
--- /dev/null
+++ b/sound/firewire/tascam/tascam.h
@@ -0,0 +1,29 @@
+/*
+ * tascam.h - a part of driver for TASCAM FireWire series
+ *
+ * Copyright (c) 2015 Takashi Sakamoto
+ *
+ * Licensed under the terms of the GNU General Public License, version 2.
+ */
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
+#include <sound/firewire.h>
+
+#include "../lib.h"
+
+struct snd_tscm {
+	struct snd_card *card;
+	struct fw_unit *unit;
+
+	struct mutex mutex;
+};
-- 
2.1.4
