From: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Subject: [RFC 06/10] ASoC: hdac_hda: add ASoC based HDA codec
	driver
Date: Fri,  1 Dec 2017 14:44:04 +0530
Message-ID: <1512119648-2700-7-git-send-email-rakesh.a.ughreja@intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 57196267BF4
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 10:10:10 +0100 (CET)
In-Reply-To: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com
Cc: vinod.koul@intel.com, patches.audio@intel.com, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds ASoC based HDA codec driver that can be used with
all Intel platforms.

FIXME:
KConfig change allows users to compile legacy HDA codec drivers either
as ASoC or ALSA codec driver. This is not a good approach and need
suggestion to improve it.

Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
---
 sound/pci/hda/Kconfig         | 11 +++++
 sound/pci/hda/hda_codec.h     | 26 +++++++++++-
 sound/soc/codecs/Kconfig      |  6 +++
 sound/soc/codecs/Makefile     |  2 +
 sound/soc/codecs/hdac_hda.c   | 95 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/hdac_hda.h   | 16 ++++++++
 sound/soc/intel/skylake/skl.c | 18 +++++++-
 7 files changed, 171 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/codecs/hdac_hda.c
 create mode 100644 sound/soc/codecs/hdac_hda.h

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 7f3b5ed..010dd7d 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -215,6 +215,17 @@ config SND_HDA_GENERIC
 comment "Set to Y if you want auto-loading the codec driver"
 	depends on SND_HDA=y && SND_HDA_GENERIC=m
 
+config SND_ASOC_HDA_GENERIC
+        bool "Build HDA drivers as HDA ASoC Codec drivers"
+	select SND_SOC_HDAC_HDA
+        def_bool n
+        help
+          Select to build legacy HD-audio codec drivers as ASoC
+          codec drivers.
+
+comment "Set to Y if you want to enable support for HDA audio codec with
+	 DSP on Intel platforms"
+
 config SND_HDA_POWER_SAVE_DEFAULT
 	int "Default time-out for HD-audio power-save mode"
 	depends on PM
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 2d02d02..67ce2e6 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -104,9 +104,33 @@ int __hda_codec_driver_register(struct hda_codec_driver *drv, const char *name,
 #define hda_codec_driver_register(drv) \
 	__hda_codec_driver_register(drv, KBUILD_MODNAME, THIS_MODULE)
 void hda_codec_driver_unregister(struct hda_codec_driver *drv);
+
+/*
+ * FIXME:
+ * In this implementation one can compile codec drivers either as ALSA or as
+ * ASoC, but not both.
+ * This may be not the be the best way to build the HDA codec drivers as ALSA
+ * vs ASoC driver. Need to find a better way, where the driver can be built
+ * as ALSA as well as ASoC at the same time. Even though practically people
+ * would never use them at the same time. But may be disto guys may want to
+ * do it.
+ */
+
+#ifdef CONFIG_SND_ASOC_HDA_GENERIC
+int __hdac_hda_codec_driver_register(struct hda_codec_driver *drv,
+	const char *name, struct module *owner);
+#define hdac_hda_codec_driver_register(drv) \
+	__hdac_hda_codec_driver_register(drv, KBUILD_MODNAME, THIS_MODULE)
+void hdac_hda_codec_driver_unregister(struct hda_codec_driver *drv);
+
+#define module_hda_codec_driver(drv) \
+	module_driver(drv, hdac_hda_codec_driver_register, \
+			hdac_hda_codec_driver_unregister)
+#else
 #define module_hda_codec_driver(drv) \
 	module_driver(drv, hda_codec_driver_register, \
-		      hda_codec_driver_unregister)
+			hda_codec_driver_unregister)
+#endif
 
 /* ops set by the preset patch */
 struct hda_codec_ops {
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a42ddbc..196fcbc 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -79,6 +79,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ES7134
 	select SND_SOC_GTM601
 	select SND_SOC_HDAC_HDMI
+	select SND_SOC_HDAC_HDA
 	select SND_SOC_ICS43432
 	select SND_SOC_INNO_RK3036
 	select SND_SOC_ISABELLE if I2C
@@ -578,6 +579,11 @@ config SND_SOC_HDAC_HDMI
 	select SND_PCM_ELD
 	select HDMI
 
+config SND_SOC_HDAC_HDA
+	tristate
+	select SND_HDA_EXT_CORE
+	select SND_PCM_ELD
+
 config SND_SOC_ICS43432
 	tristate
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 0001069..84b33c9 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -73,6 +73,7 @@ snd-soc-es8328-i2c-objs := es8328-i2c.o
 snd-soc-es8328-spi-objs := es8328-spi.o
 snd-soc-gtm601-objs := gtm601.o
 snd-soc-hdac-hdmi-objs := hdac_hdmi.o
+snd-soc-hdac-hda-objs := hdac_hda.o
 snd-soc-ics43432-objs := ics43432.o
 snd-soc-inno-rk3036-objs := inno_rk3036.o
 snd-soc-isabelle-objs := isabelle.o
@@ -313,6 +314,7 @@ obj-$(CONFIG_SND_SOC_ES8328_I2C)+= snd-soc-es8328-i2c.o
 obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
+obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
 obj-$(CONFIG_SND_SOC_ICS43432)	+= snd-soc-ics43432.o
 obj-$(CONFIG_SND_SOC_INNO_RK3036)	+= snd-soc-inno-rk3036.o
 obj-$(CONFIG_SND_SOC_ISABELLE)	+= snd-soc-isabelle.o
diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
new file mode 100644
index 0000000..f9a3491
--- /dev/null
+++ b/sound/soc/codecs/hdac_hda.c
@@ -0,0 +1,95 @@
+/*
+ *  hdac_hda.c - ASoc HDA-HDA codec driver for Intel platforms
+ *
+ *  Copyright (C) 2015-2017 Intel Corp
+ *
+ *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/hdaudio_ext.h>
+#include <sound/hda_register.h>
+#include "../../hda/local.h"
+#include "../../pci/hda/hda_codec.h"
+#include "hdac_hda.h"
+
+static int hdac_hda_dev_probe(struct hdac_device *hdev)
+{
+	struct hdac_ext_link *hlink = NULL;
+	struct hdac_hda_priv *hda_pvt;
+
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+
+	/* hold the ref while we probe */
+	hlink = snd_hdac_ext_bus_get_link(hdev->bus, dev_name(&hdev->dev));
+	if (!hlink) {
+		dev_err(&hdev->dev, "hdac link not found\n");
+		return -EIO;
+	}
+	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
+
+	hda_pvt = hdac_to_hda_priv(hdev);
+	if (hda_pvt == NULL)
+		return -ENOMEM;
+
+	dev_set_drvdata(&hdev->dev, hda_pvt);
+	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
+
+	return 0;
+}
+
+static int hdac_hda_dev_remove(struct hdac_device *hdev)
+{
+	dev_dbg(&hdev->dev, "%s: entry\n", __func__);
+	return 0;
+}
+
+#define hdac_hda_runtime_suspend NULL
+#define hdac_hda_runtime_resume NULL
+
+static const struct dev_pm_ops hdac_hda_pm = {
+	SET_RUNTIME_PM_OPS(hdac_hda_runtime_suspend,
+				hdac_hda_runtime_resume, NULL)
+};
+
+int __hdac_hda_codec_driver_register(struct hda_codec_driver *drv,
+	const char *name, struct module *owner)
+{
+	struct hdac_driver *hdac_hda_driver = &drv->core;
+
+	hdac_hda_driver->driver.name = name;
+	hdac_hda_driver->driver.pm = &hdac_hda_pm;
+
+	hdac_hda_driver->id_table = drv->id;
+	hdac_hda_driver->probe = hdac_hda_dev_probe;
+	hdac_hda_driver->remove = hdac_hda_dev_remove;
+
+	return snd_hda_ext_driver_register(hdac_hda_driver);
+}
+EXPORT_SYMBOL_GPL(__hdac_hda_codec_driver_register);
+
+void hdac_hda_codec_driver_unregister(struct hda_codec_driver *drv)
+{
+	struct hdac_driver *hdac_hda_driver = &drv->core;
+
+	snd_hda_ext_driver_unregister(hdac_hda_driver);
+}
+EXPORT_SYMBOL_GPL(hdac_hda_codec_driver_unregister);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ASoC HDA codec driver");
+MODULE_AUTHOR("Rakesh Ughreja<rakesh.a.ughreja@intel.com>");
diff --git a/sound/soc/codecs/hdac_hda.h b/sound/soc/codecs/hdac_hda.h
new file mode 100644
index 0000000..b59f106
--- /dev/null
+++ b/sound/soc/codecs/hdac_hda.h
@@ -0,0 +1,16 @@
+#ifndef __HDAC_HDA_H__
+#define __HDAC_HDA_H__
+
+struct hdac_hda_priv {
+	struct hda_codec codec;
+	struct hda_bus *hbus;
+	int stream_tag;
+
+	struct snd_soc_codec *scodec;
+};
+
+#define hdac_to_hda_priv(_hdac) \
+			container_of(_hdac, struct hdac_hda_priv, codec.core)
+#define hdac_to_hda_codec(_hdac) container_of(_hdac, struct hda_codec, core)
+
+#endif /* __HDAC_HDA_H__ */
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 72a788a..7f1971f 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -36,6 +36,7 @@
 #include "skl-sst-dsp.h"
 #include "skl-sst-ipc.h"
 #include "../../../pci/hda/hda_codec.h"
+#include "../../../soc/codecs/hdac_hda.h"
 
 static struct skl_machine_pdata skl_dmic_data;
 
@@ -533,6 +534,7 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		(AC_VERB_PARAMETERS << 8) | AC_PAR_VENDOR_ID;
 	unsigned int res = -1;
 	struct skl *skl = bus_to_skl(bus);
+	struct hdac_hda_priv *hda_codec;
 	struct hdac_device *hdev;
 
 	mutex_lock(&bus->cmd_mutex);
@@ -543,10 +545,22 @@ static int probe_codec(struct hdac_bus *bus, int addr)
 		return -EIO;
 	dev_dbg(bus->dev, "codec #%d probed OK\n", addr);
 
-	hdev = devm_kzalloc(&skl->pci->dev, sizeof(*hdev), GFP_KERNEL);
-	if (!hdev)
+	/*
+	 * FIXME:
+	 * The legacy HDA controller driver allocates data structure
+	 * for hda_codec. Ideally it should allocate only hdac_device
+	 * so that it has no dependency on the data structure of the
+	 * codec driver. If legacy controller driver can be changed this
+	 * code change can be avoided.
+	 */
+	hda_codec = devm_kzalloc(&skl->pci->dev, sizeof(*hda_codec),
+								GFP_KERNEL);
+	if (!hda_codec)
 		return -ENOMEM;
 
+	hda_codec->hbus = skl_to_hbus(skl);
+	hdev = &hda_codec->codec.core;
+
 	return snd_hdac_ext_bus_device_init(bus, addr, hdev);
 }
 
-- 
2.7.4
