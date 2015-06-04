From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v6 2/3] ALSA: hdac_ext: add hdac extended
	controller
Date: Thu,  4 Jun 2015 15:23:21 +0530
Message-ID: <1433411602-5444-3-git-send-email-vinod.koul@intel.com>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7638B26069E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 11:52:10 +0200 (CEST)
In-Reply-To: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

The controller needs to support the new capabilities and allow reading,
parsing and initializing of these capabilities, so this patch does it

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h         | 174 +++++++++++++++++++++
 sound/hda/ext/Makefile              |   2 +-
 sound/hda/ext/hdac_ext_controller.c | 295 ++++++++++++++++++++++++++++++++++++
 3 files changed, 470 insertions(+), 1 deletion(-)
 create mode 100644 sound/hda/ext/hdac_ext_controller.c

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index df1f8ae64693..b17d7f91f6ac 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -90,4 +90,178 @@ void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *chip, bool enable);
 			       (snd_hdac_ext_bus_ppcap_readb(dev, reg) & \
 				~(mask)) | (val))
 
+void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *chip,
+				 bool enable, int index);
+/*
+ * macros for spcap register read/write
+ */
+#define _snd_hdac_ext_bus_spbcap_write(type, dev, reg, value)	\
+	((dev)->bus.io_ops->reg_write ## type(value,		\
+	(dev)->spbcap_addr + (reg)))
+#define _snd_hdac_ext_bus_spbcap_read(type, dev, reg)		\
+	((dev)->bus.io_ops->reg_read ## type((dev)->spbcap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_bus_spbcap_writel(dev, reg, value) \
+	_snd_hdac_ext_bus_spbcap_write(l, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_spbcap_writew(dev, reg, value) \
+	_snd_hdac_ext_bus_spbcap_write(w, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_spbcap_writeb(dev, reg, value) \
+	_snd_hdac_ext_bus_spbcap_write(b, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_spbcap_readl(dev, reg) \
+	_snd_hdac_ext_bus_spbcap_read(l, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_bus_spbcap_readw(dev, reg) \
+	_snd_hdac_ext_bus_spbcap_read(w, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_bus_spbcap_readb(dev, reg) \
+	_snd_hdac_ext_bus_spbcap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_bus_spbcap_updatel(dev, reg, mask, val) \
+	snd_hdac_ext_bus_spbcap_writel(dev, reg, \
+			       (snd_hdac_ext_bus_spbcap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_bus_spbcap_updatew(dev, reg, mask, val) \
+	snd_hdac_ext_bus_spbcap_writew(dev, reg, \
+			       (snd_hdac_ext_bus_spbcap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_bus_spbcap_updateb(dev, reg, mask, val) \
+	snd_hdac_ext_bus_spbcap_writeb(dev, reg, \
+			       (snd_hdac_ext_bus_spbcap_readb(dev, reg) & \
+				~(mask)) | (val))
+
+int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *bus);
+int snd_hdac_ext_bus_map_codec_to_link(struct hdac_ext_bus *bus, int addr);
+struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *bus,
+						const char *codec_name);
+
+/*
+ * macros for mlcap register read/write
+ */
+#define _snd_hdac_ext_bus_mlcap_write(type, dev, reg, value)		\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->mlcap_addr + (reg)))
+#define _snd_hdac_ext_bus_mlcap_read(type, dev, reg)			\
+	((dev)->bus.io_ops->reg_read ## type((dev)->mlcap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_bus_mlcap_writel(dev, reg, value) \
+	_snd_hdac_ext_bus_mlcap_write(l, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_mlcap_writew(dev, reg, value) \
+	_snd_hdac_ext_bus_mlcap_write(w, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_mlcap_writeb(dev, reg, value) \
+	_snd_hdac_ext_bus_mlcap_write(b, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_mlcap_readl(dev, reg) \
+	_snd_hdac_ext_bus_mlcap_read(l, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_bus_mlcap_readw(dev, reg) \
+	_snd_hdac_ext_bus_mlcap_read(w, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_bus_mlcap_readb(dev, reg) \
+	_snd_hdac_ext_bus_mlcap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_bus_mlcap_updatel(dev, reg, mask, val) \
+	snd_hdac_ext_bus_mlcap_writel(dev, reg, \
+			       (snd_hdac_ext_bus_mlcap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_bus_mlcap_updatew(dev, reg, mask, val) \
+	snd_hdac_ext_bus_mlcap_writew(dev, reg, \
+			       (snd_hdac_ext_bus_mlcap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_bus_mlcap_updateb(dev, reg, mask, val) \
+	snd_hdac_ext_bus_mlcap_writeb(dev, reg, \
+			       (snd_hdac_ext_bus_mlcap_readb(dev, reg) & \
+				~(mask)) | (val))
+
+/*
+ * macros for gtscap register read/write
+ */
+#define _snd_hdac_ext_bus_gtscap_write(type, dev, reg, value)	\
+	((dev)->bus.io_ops->reg_write ## type(value,		\
+	(dev)->gtscap_addr + (reg)))
+#define _snd_hdac_ext_bus_gtscap_read(type, dev, reg)		\
+	((dev)->bus.io_ops->reg_read ## type((dev)->gtscap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_bus_gtscap_writel(dev, reg, value) \
+	_snd_hdac_ext_bus_gtscap_write(l, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_gtscap_writew(dev, reg, value) \
+	_snd_hdac_ext_bus_gtscap_write(w, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_gtscap_writeb(dev, reg, value) \
+	_snd_hdac_ext_bus_gtscap_write(b, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_bus_gtscap_readl(dev, reg) \
+	_snd_hdac_ext_bus_gtscap_read(l, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_bus_gtscap_readw(dev, reg) \
+	_snd_hdac_ext_bus_gtscap_read(w, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_bus_gtscap_readb(dev, reg) \
+	_snd_hdac_ext_bus_gtscap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_bus_gtscap_updatel(dev, reg, mask, val) \
+	snd_hdac_ext_bus_gtscap_writel(dev, reg, \
+			       (snd_hdac_ext_bus_gtscap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_bus_gtscap_updatew(dev, reg, mask, val) \
+	snd_hdac_ext_bus_gtscap_writew(dev, reg, \
+			       (snd_hdac_ext_bus_gtscap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_bus_gtscap_updateb(dev, reg, mask, val) \
+	snd_hdac_ext_bus_gtscap_writeb(dev, reg, \
+			       (snd_hdac_ext_bus_gtscap_readb(dev, reg) & \
+				~(mask)) | (val))
+enum hdac_ext_stream_type {
+	HDAC_EXT_STREAM_TYPE_COUPLED = 0,
+	HDAC_EXT_STREAM_TYPE_HOST,
+	HDAC_EXT_STREAM_TYPE_LINK
+};
+
+struct hdac_ext_link {
+	struct hdac_bus *bus;
+	int index;
+	void __iomem *ml_addr; /* link output stream reg pointer */
+	u32 lcaps;   /* link capablities */
+	u16 lsdiid;  /* link sdi identifier */
+	char codec[HDA_MAX_CODECS][32]; /* codecs connectes to the link */
+	struct list_head list;
+};
+
+int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link);
+int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link);
+void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
+				 int stream);
+void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
+				 int stream);
+
+/*
+ * macros for mutilink register read/ write
+ */
+#define _snd_hdac_ext_link_write(type, dev, reg, value)			\
+	((dev)->bus->io_ops->reg_write ## type(value, (dev)->ml_addr + (reg)))
+#define _snd_hdac_ext_link_read(type, dev, reg)				\
+	((dev)->bus->io_ops->reg_read ## type((dev)->ml_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_link_writel(dev, reg, value) \
+	_snd_hdac_ext_link_write(l, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_link_writew(dev, reg, value) \
+	_snd_hdac_ext_link_write(w, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_link_writeb(dev, reg, value) \
+	_snd_hdac_ext_link_write(b, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_link_readl(dev, reg) \
+	_snd_hdac_ext_link_read(l, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_link_readw(dev, reg) \
+	_snd_hdac_ext_link_read(w, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_link_readb(dev, reg) \
+	_snd_hdac_ext_link_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_link_updatel(dev, reg, mask, val) \
+	snd_hdac_ext_link_writel(dev, reg, \
+			       (snd_hdac_ext_link_readl(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_link_updatew(dev, reg, mask, val) \
+	snd_hdac_ext_link_writew(dev, reg, \
+			       (snd_hdac_ext_link_readw(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_link_updateb(dev, reg, mask, val) \
+	snd_hdac_ext_link_writeb(dev, reg, \
+			       (snd_hdac_ext_link_readb(dev, reg) & \
+				~(mask)) | (val))
 #endif /* __SOUND_HDAUDIO_EXT_H */
diff --git a/sound/hda/ext/Makefile b/sound/hda/ext/Makefile
index 2e583e664916..934b7bf5d87f 100644
--- a/sound/hda/ext/Makefile
+++ b/sound/hda/ext/Makefile
@@ -1,3 +1,3 @@
-snd-hda-ext-core-objs := hdac_ext_bus.o
+snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o
 
 obj-$(CONFIG_SND_HDA_EXT_CORE) += snd-hda-ext-core.o
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
new file mode 100644
index 000000000000..ab68d8165085
--- /dev/null
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -0,0 +1,295 @@
+/*
+ *  hdac-ext-controller.c - HD-audio extended controller functions.
+ *
+ *  Copyright (C) 2014-2015 Intel Corp
+ *  Author: Jeeja KP <jeeja.kp@intel.com>
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
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/export.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/hda_register.h>
+#include <sound/hdaudio_ext.h>
+
+/**
+ * snd_hdac_ext_bus_parse_capabilities - parse capablity structure
+ * @sbus: the pointer to extended bus object
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *sbus)
+{
+	unsigned int cur_cap;
+	unsigned int offset;
+	struct hdac_bus *bus = &sbus->bus;
+
+	offset = snd_hdac_chip_readl(bus, LLCH);
+
+	if (offset < 0)
+		return -EIO;
+
+	sbus->ppcap = false;
+	sbus->mlcap = false;
+	sbus->spbcap = false;
+	sbus->gtscap = false;
+
+	/* Lets walk the linked capabilities list */
+	do {
+		cur_cap = _snd_hdac_chip_read(l, bus, offset);
+
+		if (cur_cap < 0)
+			return -EIO;
+
+		dev_dbg(bus->dev, "Capability version: 0x%x\n",
+				((cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF));
+
+		dev_dbg(bus->dev, "HDA capability ID: 0x%x\n",
+				(cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF);
+
+		switch ((cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF) {
+		case AZX_ML_CAP_ID:
+			dev_dbg(bus->dev, "Found ML capability\n");
+			sbus->mlcap = true;
+			sbus->mlcap_addr = bus->remap_addr + offset;
+			break;
+
+		case AZX_GTS_CAP_ID:
+			dev_dbg(bus->dev, "Found GTS capability offset=%x\n", offset);
+			sbus->gtscap = true;
+			sbus->gtscap_addr = bus->remap_addr + offset;
+			break;
+
+		case AZX_PP_CAP_ID:
+			/* PP capability found, the Audio DSP is present */
+			dev_dbg(bus->dev, "Found PP capability offset=%x\n", offset);
+			sbus->ppcap = true;
+			sbus->ppcap_addr = bus->remap_addr + offset;
+			break;
+
+		case AZX_SPB_CAP_ID:
+			/* SPIB capability found, handler function */
+			dev_dbg(bus->dev, "Found SPB capability\n");
+			sbus->spbcap = true;
+			sbus->spbcap_addr = bus->remap_addr + offset;
+			break;
+
+		default:
+			dev_dbg(bus->dev, "Unknown capability %d\n", cur_cap);
+			break;
+		}
+
+		/* read the offset of next capabiity */
+		offset = cur_cap & AZX_CAP_HDR_NXT_PTR_MASK;
+	} while (offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_parse_capabilities);
+
+/*
+ * processing pipe helpers - these helpers are useful for dealing with HDA
+ * new capability of processing pipelines
+ */
+
+/**
+ * snd_hdac_ext_bus_ppcap_enable - enable/disable processing pipe capability
+ * @sbus: HD-audio extended core bus
+ * @enable: flag to turn on/off the capability
+ */
+void snd_hdac_ext_bus_ppcap_enable(struct hdac_ext_bus *sbus, bool enable)
+{
+	struct hdac_bus *bus = &sbus->bus;
+
+	if (!sbus->ppcap) {
+		dev_err(bus->dev, "Address of PP capability is NULL");
+		return;
+	}
+
+	if (enable)
+		snd_hdac_ext_bus_ppcap_updatel(sbus, PP_PPCTL, 0, AZX_PPCTL_GPROCEN);
+	else
+		snd_hdac_ext_bus_ppcap_updatel(sbus, PP_PPCTL, AZX_PPCTL_GPROCEN, 0);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_enable);
+
+/**
+ * snd_hdac_ext_bus_ppcap_int_enable - ppcap interrupt enable/disable
+ * @sbus: HD-audio extended core bus
+ * @enable: flag to enable/disable interrupt
+ */
+void snd_hdac_ext_bus_ppcap_int_enable(struct hdac_ext_bus *sbus, bool enable)
+{
+	struct hdac_bus *bus = &sbus->bus;
+
+	if (!sbus->ppcap) {
+		dev_err(bus->dev, "Address of PP capability is NULL\n");
+		return;
+	}
+
+	if (enable)
+		snd_hdac_ext_bus_ppcap_updatel(sbus, PP_PPCTL, 0, AZX_PPCTL_PIE);
+	else
+		snd_hdac_ext_bus_ppcap_updatel(sbus, PP_PPCTL, AZX_PPCTL_PIE, 0);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_ppcap_int_enable);
+
+/*
+ * Multilink helpers - these helpers are useful for dealing with HDA
+ * new multilink capability
+ */
+
+/**
+ * snd_hdac_ext_bus_get_ml_capabilities - get multilink capability
+ * @sbus: HD-audio extended core bus
+ *
+ * This will parse all links and read the mlink capabilities and add them
+ * in hlink_list of extended hdac bus
+ * Note: this will be freed on bus exit by driver
+ */
+int snd_hdac_ext_bus_get_ml_capabilities(struct hdac_ext_bus *sbus)
+{
+	int idx;
+	u32 link_count;
+	struct hdac_ext_link *hlink;
+	struct hdac_bus *bus = &sbus->bus;
+
+	link_count = snd_hdac_ext_bus_mlcap_readl(sbus, ML_MLCD) + 1;
+
+	dev_dbg(bus->dev, "In %s Link count: %d\n", __func__, link_count);
+
+	for (idx = 0; idx < link_count; idx++) {
+		hlink  = kzalloc(sizeof(*hlink), GFP_KERNEL);
+		if (!hlink)
+			return -ENOMEM;
+		hlink->index = idx;
+		hlink->bus = bus;
+		hlink->ml_addr = sbus->mlcap_addr +
+					AZX_ML_BASE +
+					(AZX_ML_INTERVAL *
+					idx);
+		hlink->lcaps  = snd_hdac_ext_link_readl(hlink, ML_LCAP);
+		hlink->lsdiid = snd_hdac_ext_link_readw(hlink, ML_LSDIID);
+
+		list_add_tail(&hlink->list, &sbus->hlink_list);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_get_ml_capabilities);
+
+/**
+ * snd_hdac_ext_bus_map_codec_to_link - maps codec to link
+ * @sbus: HD-audio extended core bus
+ * @addr: codec address
+ */
+int snd_hdac_ext_bus_map_codec_to_link(struct hdac_ext_bus *sbus, int addr)
+{
+	struct hdac_ext_link *hlink;
+	struct hdac_bus *bus = &sbus->bus;
+
+	list_for_each_entry(hlink, &sbus->hlink_list, list) {
+		/* check if SDI bit number is same as Codec address */
+		dev_dbg(bus->dev, "lsdid for %d link %x\n", hlink->index, hlink->lsdiid);
+		if (!hlink->lsdiid)
+			continue;
+
+		if (hlink->lsdiid && (0x1 << addr)) {
+			snprintf(hlink->codec[addr],
+					sizeof(hlink->codec[addr]),
+					"codec#%d", addr);
+			break;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_map_codec_to_link);
+
+/**
+ * snd_hdac_ext_bus_get_link_index - get link based on codec name
+ * @sbus: HD-audio extended core bus
+ * @codec_name: codec name
+ */
+struct hdac_ext_link *snd_hdac_ext_bus_get_link(struct hdac_ext_bus *sbus,
+						 const char *codec_name)
+{
+	int i;
+	struct hdac_ext_link *hlink = NULL;
+
+	list_for_each_entry(hlink, &sbus->hlink_list, list) {
+		for (i = 0; i < HDA_MAX_CODECS; i++) {
+			if (!hlink->codec[i][0])
+				break;
+			if (!strncmp(hlink->codec[i], codec_name,
+					strlen(codec_name)))
+				return hlink;
+		}
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_get_link);
+
+static int check_hdac_link_power_active(struct hdac_ext_link *link, bool enable)
+{
+	int timeout;
+	u32 val;
+	int mask = (1 << AZX_MLCTL_CPA);
+
+	udelay(3);
+	timeout = 50;
+
+	do {
+		val = snd_hdac_ext_link_readl(link, ML_LCTL);
+		if (enable) {
+			if (((val & mask) >> AZX_MLCTL_CPA))
+				return 0;
+		} else {
+			if (!((val & mask) >> AZX_MLCTL_CPA))
+				return 0;
+		}
+		udelay(3);
+	} while (--timeout);
+
+	return -EIO;
+}
+
+/**
+ * snd_hdac_ext_bus_link_power_up -power up hda link
+ * @link: HD-audio extended link
+ */
+int snd_hdac_ext_bus_link_power_up(struct hdac_ext_link *link)
+{
+	snd_hdac_ext_link_updatel(link, ML_LCTL, 0, AZX_MLCTL_SPA);
+
+	return check_hdac_link_power_active(link, true);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_up);
+
+/**
+ * snd_hdac_ext_bus_link_power_down -power down hda link
+ * @link: HD-audio extended link
+ */
+int snd_hdac_ext_bus_link_power_down(struct hdac_ext_link *link)
+{
+	snd_hdac_ext_link_updatel(link, ML_LCTL, AZX_MLCTL_SPA, 0);
+
+	return check_hdac_link_power_active(link, false);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_link_power_down);
+
+MODULE_DESCRIPTION("HDA extended core");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1
