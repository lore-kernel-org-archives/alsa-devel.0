From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 3/7] ASoC: hda - adds SoC controller and
	stream operations
Date: Wed, 29 Apr 2015 01:24:26 +0530
Message-ID: <1430250870-3169-4-git-send-email-vinod.koul@intel.com>
References: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CF341264F38
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 21:57:33 +0200 (CEST)
In-Reply-To: <1430250870-3169-1-git-send-email-vinod.koul@intel.com>
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

From: Jeeja KP <jeeja.kp@intel.com>

Adds ASoC HDA library for generic HDA SoC controller and stream operations
This will be used by SKL HDA driver

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hdaudio.h         |  343 ++++++++++++++++++++++++++++++
 sound/soc/hda/Makefile              |    2 +-
 sound/soc/hda/soc-hdac-controller.c |  289 ++++++++++++++++++++++++++
 sound/soc/hda/soc-hdac-stream.c     |  390 +++++++++++++++++++++++++++++++++++
 4 files changed, 1023 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/soc-hdaudio.h
 create mode 100644 sound/soc/hda/soc-hdac-controller.c
 create mode 100644 sound/soc/hda/soc-hdac-stream.c

diff --git a/include/sound/soc-hdaudio.h b/include/sound/soc-hdaudio.h
new file mode 100644
index 000000000000..4e90d25ecf2b
--- /dev/null
+++ b/include/sound/soc-hdaudio.h
@@ -0,0 +1,343 @@
+#ifndef __SOUND_SOC_HDAUDIO_H
+#define __SOUND_SOC_HDAUDIO_H
+
+#include <sound/core.h>
+#include <sound/initval.h>
+#include <sound/hda_register.h>
+#include <sound/hdaudio.h>
+
+struct soc_hdac_bus {
+	struct hdac_bus bus;
+	int num_streams;
+
+	bool ppcap;
+	bool spbcap;
+	bool mlcap;
+	bool gtscap;
+
+	void __iomem *ppcap_addr;
+	void __iomem *spbcap_addr;
+	void __iomem *mlcap_addr;
+	void __iomem *gtscap_addr;
+
+	/* linked list of hda links */
+	struct list_head hlink_list;
+};
+
+#define hdac_bus(sbus)	(&(sbus)->bus)
+#define bus_to_soc_hdac_bus(_bus) \
+	container_of(_bus, struct soc_hdac_bus, bus)
+
+int snd_soc_hdac_bus_parse_capabilities(struct soc_hdac_bus *sbus);
+void snd_soc_hdac_bus_ppcap_enable(struct soc_hdac_bus *chip, bool enable);
+void snd_soc_hdac_bus_ppcap_int_enable(struct soc_hdac_bus *chip, bool enable);
+
+/*
+ * macros for ppcap register read/write
+ */
+#define _soc_hdac_bus_ppcap_write(type, dev, reg, value)			\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->ppcap_addr + (reg)))
+#define _soc_hdac_bus_ppcap_read(type, dev, reg)				\
+	((dev)->bus.io_ops->reg_read ## type((dev)->ppcap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_ppcap_writel(dev, reg, value) \
+	_soc_hdac_bus_ppcap_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_ppcap_writew(dev, reg, value) \
+	_soc_hdac_bus_ppcap_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_ppcap_writeb(dev, reg, value) \
+	_soc_hdac_bus_ppcap_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_ppcap_readl(dev, reg) \
+	_soc_hdac_bus_ppcap_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_ppcap_readw(dev, reg) \
+	_soc_hdac_bus_ppcap_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_ppcap_readb(dev, reg) \
+	_soc_hdac_bus_ppcap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_ppcap_updatel(dev, reg, mask, val) \
+	soc_hdac_bus_ppcap_writel(dev, reg, \
+			       (soc_hdac_bus_ppcap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_ppcap_updatew(dev, reg, mask, val) \
+	soc_hdac_bus_ppcap_writew(dev, reg, \
+			       (soc_hdac_bus_ppcap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_ppcap_updateb(dev, reg, mask, val) \
+	soc_hdac_bus_ppcap_writeb(dev, reg, \
+			       (soc_hdac_bus_ppcap_readb(dev, reg) & \
+				~(mask)) | (val))
+
+void snd_soc_hdac_stream_spbcap_enable(struct soc_hdac_bus *chip,
+				 bool enable, int index);
+/*
+ * macros for spcap register read/write
+ */
+#define _soc_hdac_bus_spbcap_write(type, dev, reg, value)			\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->spbcap_addr + (reg)))
+#define _soc_hdac_bus_spbcap_read(type, dev, reg)				\
+	((dev)->bus.io_ops->reg_read ## type((dev)->spbcap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_spbcap_writel(dev, reg, value) \
+	_soc_hdac_bus_spbcap_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_spbcap_writew(dev, reg, value) \
+	_soc_hdac_bus_spbcap_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_spbcap_writeb(dev, reg, value) \
+	_soc_hdac_bus_spbcap_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_spbcap_readl(dev, reg) \
+	_soc_hdac_bus_spbcap_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_spbcap_readw(dev, reg) \
+	_soc_hdac_bus_spbcap_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_spbcap_readb(dev, reg) \
+	_soc_hdac_bus_spbcap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_spbcap_updatel(dev, reg, mask, val) \
+	soc_hdac_bus_spbcap_writel(dev, reg, \
+			       (soc_hdac_bus_spbcap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_spbcap_updatew(dev, reg, mask, val) \
+	soc_hdac_bus_spbcap_writew(dev, reg, \
+			       (soc_hdac_bus_spbcap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_spbcap_updateb(dev, reg, mask, val) \
+	soc_hdac_bus_spbcap_writeb(dev, reg, \
+			       (soc_hdac_bus_spbcap_readb(dev, reg) & \
+				~(mask)) | (val))
+
+int snd_soc_hdac_bus_get_ml_capablities(struct soc_hdac_bus *bus);
+int snd_soc_hdac_bus_map_codec_to_link(struct soc_hdac_bus *bus, int addr);
+struct soc_hdac_link *snd_soc_hdac_bus_get_link(struct soc_hdac_bus *bus,
+						const char *codec_name);
+
+/*
+ * macros for mlcap register read/write
+ */
+#define _soc_hdac_bus_mlcap_write(type, dev, reg, value)			\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->mlcap_addr + (reg)))
+#define _soc_hdac_bus_mlcap_read(type, dev, reg)				\
+	((dev)->bus.io_ops->reg_read ## type((dev)->mlcap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_mlcap_writel(dev, reg, value) \
+	_soc_hdac_bus_mlcap_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_mlcap_writew(dev, reg, value) \
+	_soc_hdac_bus_mlcap_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_mlcap_writeb(dev, reg, value) \
+	_soc_hdac_bus_mlcap_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_mlcap_readl(dev, reg) \
+	_soc_hdac_bus_mlcap_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_mlcap_readw(dev, reg) \
+	_soc_hdac_bus_mlcap_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_mlcap_readb(dev, reg) \
+	_soc_hdac_bus_mlcap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_mlcap_updatel(dev, reg, mask, val) \
+	soc_hdac_bus_mlcap_writel(dev, reg, \
+			       (soc_hdac_bus_mlcap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_mlcap_updatew(dev, reg, mask, val) \
+	soc_hdac_bus_mlcap_writew(dev, reg, \
+			       (soc_hdac_bus_mlcap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_mlcap_updateb(dev, reg, mask, val) \
+	soc_hdac_bus_mlcap_writeb(dev, reg, \
+			       (soc_hdac_bus_mlcap_readb(dev, reg) & \
+				~(mask)) | (val))
+
+/*
+ * macros for gtscap register read/write
+ */
+#define _soc_hdac_bus_gtscap_write(type, dev, reg, value)			\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->gtscap_addr + (reg)))
+#define _soc_hdac_bus_gtscap_read(type, dev, reg)				\
+	((dev)->bus.io_ops->reg_read ## type((dev)->gtscap_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_gtscap_writel(dev, reg, value) \
+	_soc_hdac_bus_gtscap_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_gtscap_writew(dev, reg, value) \
+	_soc_hdac_bus_gtscap_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_gtscap_writeb(dev, reg, value) \
+	_soc_hdac_bus_gtscap_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_bus_gtscap_readl(dev, reg) \
+	_soc_hdac_bus_gtscap_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_gtscap_readw(dev, reg) \
+	_soc_hdac_bus_gtscap_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_bus_gtscap_readb(dev, reg) \
+	_soc_hdac_bus_gtscap_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_bus_gtscap_updatel(dev, reg, mask, val) \
+	soc_hdac_bus_gtscap_writel(dev, reg, \
+			       (soc_hdac_bus_gtscap_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_gtscap_updatew(dev, reg, mask, val) \
+	soc_hdac_bus_gtscap_writew(dev, reg, \
+			       (soc_hdac_bus_gtscap_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_bus_gtscap_updateb(dev, reg, mask, val) \
+	soc_hdac_bus_gtscap_writeb(dev, reg, \
+			       (soc_hdac_bus_gtscap_readb(dev, reg) & \
+				~(mask)) | (val))
+enum hdac_stream_type {
+	HDAC_STREAM_TYPE_COUPLED = 0,
+	HDAC_STREAM_TYPE_HOST,
+	HDAC_STREAM_TYPE_LINK
+};
+
+struct soc_hdac_stream {
+	struct hdac_stream hstream;
+	unsigned int decoupled:1;
+	void __iomem *pphc_addr; /* processing pipe host stream reg pointer */
+	void __iomem *pplc_addr; /* processing pipe link stream reg pointer */
+	bool link_locked:1;
+	struct snd_pcm_substream *link_substream;
+	bool link_prepared;
+};
+
+#define hdac_stream(s)		(&(s)->hstream)
+#define stream_to_soc_hdac_stream(s) \
+	container_of(s, struct soc_hdac_stream, hstream)
+
+void snd_soc_hdac_stream_init(struct soc_hdac_bus *bus, struct soc_hdac_stream *azx_dev,
+			  int idx, int direction, int tag);
+struct soc_hdac_stream *snd_soc_hdac_stream_assign(struct soc_hdac_bus *bus,
+					   struct snd_pcm_substream *substream,
+					   int type);
+void snd_soc_hdac_stream_release(struct soc_hdac_stream *azx_dev, int type);
+void snd_soc_hdac_stream_decouple(struct soc_hdac_bus *bus,
+				struct soc_hdac_stream *azx_dev, bool decouple);
+void snd_soc_hdac_stop_streams(struct soc_hdac_bus *sbus);
+
+/*
+ * macros for host stream register read/write
+ */
+#define _soc_hdac_host_stream_write(type, dev, reg, value)			\
+	((dev)->hstream.bus->io_ops->reg_write ## type(value, (dev)->pphc_addr + (reg)))
+#define _soc_hdac_host_stream_read(type, dev, reg) \
+	((dev)->hstream.bus->io_ops->reg_read ## type((dev)->pphc_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_host_stream_writel(dev, reg, value) \
+	_soc_hdac_host_stream_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_host_stream_writew(dev, reg, value) \
+	_soc_hdac_host_stream_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_host_stream_writeb(dev, reg, value) \
+	_soc_hdac_host_stream_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_host_stream_readl(dev, reg) \
+	_soc_hdac_host_stream_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_host_stream_readw(dev, reg) \
+	_soc_hdac_host_stream_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_host_stream_readb(dev, reg) \
+	_soc_hdac_host_stream_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_host_stream_updatel(dev, reg, mask, val) \
+	soc_hdac_host_stream_writel(dev, reg, \
+			       (soc_hdac_host_stream_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_host_stream_updatew(dev, reg, mask, val) \
+	soc_hdac_host_stream_writew(dev, reg, \
+			       (soc_hdac_host_stream_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_host_stream_updateb(dev, reg, mask, val) \
+	soc_hdac_host_stream_writeb(dev, reg, \
+			       (soc_hdac_host_stream_readb(dev, reg) & \
+				~(mask)) | (val))
+
+void snd_soc_hdac_link_stream_start(struct soc_hdac_stream *hstream);
+void snd_soc_hdac_link_stream_clear(struct soc_hdac_stream *hstream);
+void snd_soc_hdac_link_stream_reset(struct soc_hdac_stream *hstream);
+int snd_soc_hdac_link_stream_setup(struct soc_hdac_stream *stream, int fmt);
+
+/*
+ * macros for link stream register read/write
+ */
+#define _soc_hdac_link_stream_write(type, dev, reg, value)			\
+	((dev)->hstream.bus->io_ops->reg_write ## type(value, (dev)->pplc_addr + (reg)))
+#define _soc_hdac_link_stream_read(type, dev, reg)				\
+	((dev)->hstream.bus->io_ops->reg_read ## type((dev)->pplc_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_link_stream_writel(dev, reg, value) \
+	_soc_hdac_link_stream_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_link_stream_writew(dev, reg, value) \
+	_soc_hdac_link_stream_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_link_stream_writeb(dev, reg, value) \
+	_soc_hdac_link_stream_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_link_stream_readl(dev, reg) \
+	_soc_hdac_link_stream_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_link_stream_readw(dev, reg) \
+	_soc_hdac_link_stream_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_link_stream_readb(dev, reg) \
+	_soc_hdac_link_stream_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_link_stream_updatel(dev, reg, mask, val) \
+	soc_hdac_link_stream_writel(dev, reg, \
+			       (soc_hdac_link_stream_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_link_stream_updatew(dev, reg, mask, val) \
+	soc_hdac_link_stream_writew(dev, reg, \
+			       (soc_hdac_link_stream_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_link_stream_updateb(dev, reg, mask, val) \
+	soc_hdac_link_stream_writeb(dev, reg, \
+			       (soc_hdac_link_stream_readb(dev, reg) & \
+				~(mask)) | (val))
+struct soc_hdac_link {
+	struct hdac_bus *bus;
+	int index;
+	void __iomem *ml_addr; /* link output stream reg pointer */
+	u32 lcaps;   /* link capablities */
+	u16 lsdiid;  /* link sdi identifier */
+	char codec[HDA_MAX_CODECS][32]; /* codecs connectes to the link */
+	struct list_head list;
+};
+
+int snd_soc_hdac_bus_link_power_up(struct soc_hdac_link *link);
+int snd_soc_hdac_bus_link_power_down(struct soc_hdac_link *link);
+void snd_soc_hdac_link_set_stream_id(struct soc_hdac_link *link,
+				 int stream);
+void snd_soc_hdac_link_clear_stream_id(struct soc_hdac_link *link,
+				 int stream);
+
+/*
+ * macros for mutilink register read/ write
+ */
+#define _soc_hdac_link_write(type, dev, reg, value)			\
+	((dev)->bus->io_ops->reg_write ## type(value, (dev)->ml_addr + (reg)))
+#define _soc_hdac_link_read(type, dev, reg)				\
+	((dev)->bus->io_ops->reg_read ## type((dev)->ml_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define soc_hdac_link_writel(dev, reg, value) \
+	_soc_hdac_link_write(l, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_link_writew(dev, reg, value) \
+	_soc_hdac_link_write(w, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_link_writeb(dev, reg, value) \
+	_soc_hdac_link_write(b, dev, AZX_REG_ ## reg, value)
+#define soc_hdac_link_readl(dev, reg) \
+	_soc_hdac_link_read(l, dev, AZX_REG_ ## reg)
+#define soc_hdac_link_readw(dev, reg) \
+	_soc_hdac_link_read(w, dev, AZX_REG_ ## reg)
+#define soc_hdac_link_readb(dev, reg) \
+	_soc_hdac_link_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define soc_hdac_link_updatel(dev, reg, mask, val) \
+	soc_hdac_link_writel(dev, reg, \
+			       (soc_hdac_link_readl(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_link_updatew(dev, reg, mask, val) \
+	soc_hdac_link_writew(dev, reg, \
+			       (soc_hdac_link_readw(dev, reg) & \
+				~(mask)) | (val))
+#define soc_hdac_link_updateb(dev, reg, mask, val) \
+	soc_hdac_link_writeb(dev, reg, \
+			       (soc_hdac_link_readb(dev, reg) & \
+				~(mask)) | (val))
+#endif /* __SOUND_SOC_HDAUDIO_H */
diff --git a/sound/soc/hda/Makefile b/sound/soc/hda/Makefile
index 9585ab180a55..ced2c2198dae 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -1,3 +1,3 @@
-snd-soc-hda-core-objs := soc-hda-codec.o
+snd-soc-hda-core-objs := soc-hdac-controller.o soc-hdac-stream.o soc-hda-codec.o
 
 obj-$(CONFIG_SND_SOC_HDA_CORE) += snd-soc-hda-core.o
diff --git a/sound/soc/hda/soc-hdac-controller.c b/sound/soc/hda/soc-hdac-controller.c
new file mode 100644
index 000000000000..662357cb0c3e
--- /dev/null
+++ b/sound/soc/hda/soc-hdac-controller.c
@@ -0,0 +1,289 @@
+/*
+ *  soc-hdac-controller.c - SoC HD-audio controller functions.
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
+#include <sound/core.h>
+#include <sound/hda_register.h>
+#include <sound/soc-hdaudio.h>
+
+/**
+ * snd_soc_hdac_bus_parse_capabilities - parse capablity structure
+ * @sbus - HD-audio soc core bus
+ */
+int snd_soc_hdac_bus_parse_capabilities(struct soc_hdac_bus *sbus)
+{
+	unsigned int cur_cap;
+	unsigned int offset;
+	struct hdac_bus *bus = &sbus->bus;
+
+	offset = snd_hdac_chip_readl(bus, LLCH);
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
+		dev_dbg(bus->dev,
+			"Capability version: 0x%x",
+			((cur_cap & CAP_HDR_VER_MASK) >> CAP_HDR_VER_OFF)
+			);
+
+		dev_dbg(bus->dev,
+			"HDA capability ID: 0x%x",
+			(cur_cap & CAP_HDR_ID_MASK) >> CAP_HDR_ID_OFF
+			);
+
+		switch ((cur_cap & CAP_HDR_ID_MASK) >> CAP_HDR_ID_OFF) {
+
+		case ML_CAP_ID:
+			dev_dbg(bus->dev, "Found ML capability");
+			sbus->mlcap = true;
+			sbus->mlcap_addr = bus->remap_addr + offset;
+			break;
+
+		case GTS_CAP_ID:
+			dev_dbg(bus->dev, "Found GTS capability");
+			sbus->gtscap = true;
+			sbus->gtscap_addr = bus->remap_addr + offset;
+			break;
+
+		case PP_CAP_ID:
+			/* PP capability found,
+			* the Audio DSP is present so let's handle it
+			*/
+			dev_dbg(bus->dev, "Found PP capability");
+			sbus->ppcap = true;
+			sbus->mlcap_addr = bus->remap_addr + offset;
+			/* Register the device in the system */
+			break;
+
+		case SPB_CAP_ID:
+			/* SPIB capability found, handler function */
+			dev_dbg(bus->dev, "Found SPB capability");
+			/* Setting the offset */
+			sbus->spbcap = true;
+			sbus->spbcap_addr = bus->remap_addr + offset;
+			break;
+
+		default:
+			dev_dbg(bus->dev, "Unknown capability\n");
+			break;
+		}
+
+		/* read the offset of next capabiity */
+		offset = cur_cap & CAP_HDR_NXT_PTR_MASK;
+	} while (offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_parse_capabilities);
+
+/* processing pipe helpers */
+
+/**
+ * snd_soc_hdac_bus_ppcap_enable - enable/disable processing pipe capablity
+ * @sbus - HD-audio soc core bus
+ * @enable - flag to turn on/off the capablity
+ */
+void snd_soc_hdac_bus_ppcap_enable(struct soc_hdac_bus *sbus, bool enable)
+{
+	struct hdac_bus *bus = &sbus->bus;
+
+	if (!sbus->ppcap) {
+		dev_err(bus->dev, "Address of PP capability is NULL");
+		return;
+	}
+
+	if (enable)
+		soc_hdac_bus_ppcap_updatew(sbus, PP_PPCTL, 0, PPCTL_GPROCEN);
+	else
+		soc_hdac_bus_ppcap_updatew(sbus, PP_PPCTL, PPCTL_GPROCEN, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_ppcap_enable);
+
+/**
+ * snd_soc_hdac_bus_ppcap_int_enable - ppcap interrupt enable/disable
+ * @sbus - HD-audio soc core bus
+ * @enable - flag to enable/disable interrupt
+ */
+void snd_soc_hdac_bus_ppcap_int_enable(struct soc_hdac_bus *sbus, bool enable)
+{
+	struct hdac_bus *bus = &sbus->bus;
+
+	if (!sbus->ppcap) {
+		dev_err(bus->dev, "Address of PP capability is NULL\n");
+		return;
+	}
+
+	if (enable)
+		soc_hdac_bus_ppcap_updatew(sbus, PP_PPCTL, 0, PPCTL_PIE);
+	else
+		soc_hdac_bus_ppcap_updatew(sbus, PP_PPCTL, PPCTL_PIE, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_ppcap_int_enable);
+
+/* Multilink helpers */
+
+/**
+ * snd_soc_hdac_bus_get_ml_capablities - get multilink capablity
+ * @sbus - HD-audio soc core bus
+ */
+int snd_soc_hdac_bus_get_ml_capablities(struct soc_hdac_bus *sbus)
+{
+	int idx = 0;
+	u32 link_count = 0;
+	struct soc_hdac_link *hlink;
+	struct hdac_bus *bus = &sbus->bus;
+
+	INIT_LIST_HEAD(&sbus->hlink_list);
+
+	link_count = soc_hdac_bus_mlcap_readb(sbus, ML_MLCD) + 1;
+
+	dev_dbg(bus->dev, "In %s Link count: %d\n", __func__, link_count);
+
+	for (idx = 0; idx < link_count; idx++) {
+		hlink  = devm_kzalloc(bus->dev, sizeof(*hlink), GFP_KERNEL);
+		if (!hlink)
+			return -ENOMEM;
+		hlink->index = idx;
+		hlink->bus = bus;
+		hlink->ml_addr = sbus->mlcap_addr +
+					ML_BASE +
+					(ML_INTERVAL *
+					idx);
+		hlink->lcaps  = soc_hdac_link_readw(hlink, ML_LCAP);
+		hlink->lsdiid = soc_hdac_link_readw(hlink, ML_LSDIID);
+
+		list_add(&hlink->list, &sbus->hlink_list);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_get_ml_capablities);
+
+/**
+ * snd_soc_hdac_bus_map_codec_to_link - maps codec to link
+ * @sbus - HD-audio soc core bus
+ * @addr - codec address
+ */
+int snd_soc_hdac_bus_map_codec_to_link(struct soc_hdac_bus *sbus, int addr)
+{
+	struct soc_hdac_link *hlink;
+	struct hdac_bus *bus = &sbus->bus;
+
+	list_for_each_entry(hlink, &sbus->hlink_list, list) {
+		/*check if SDI bit number == Codec address */
+		dev_dbg(bus->dev, "lsdid for %d link %x\n", hlink->index, hlink->lsdiid);
+		if (!(hlink->lsdiid))
+			continue;
+
+		if (hlink->lsdiid && (0x1 << addr)) {
+			snprintf(hlink->codec[addr],
+					sizeof(hlink->codec[addr]),
+					"codec#%03x.%d", addr, addr);
+			break;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_map_codec_to_link);
+
+/**
+ * snd_soc_hdac_bus_get_link_index - get link based on codec name
+ * @sbus - HD-audio soc core bus
+ * @codec_name - codec name
+ */
+struct soc_hdac_link *snd_soc_hdac_bus_get_link(struct soc_hdac_bus *sbus,
+						 const char *codec_name)
+{
+	int i = 0;
+	struct soc_hdac_link *hlink = NULL;
+
+	list_for_each_entry(hlink, &sbus->hlink_list, list) {
+		for (i = 0; i < 16 ; i++) {
+			if (strlen(hlink->codec[i]) == 0)
+				break;
+			if (!strncmp(hlink->codec[i], codec_name,
+					sizeof(codec_name)))
+				return hlink;
+		}
+	}
+	return hlink;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_get_link);
+
+/**
+ * snd_soc_hdac_bus_link_power_up -power up hda link
+ * @link - HD-audio soc link
+ */
+int snd_soc_hdac_bus_link_power_up(struct soc_hdac_link *link)
+{
+	int timeout;
+	u32 val;
+	int mask = (1 << MLCTL_CPA);
+
+	soc_hdac_link_updatel(link, ML_LCTL, 0, MLCTL_SPA);
+	udelay(3);
+	timeout = 300;
+
+	do {
+		val = soc_hdac_link_readl(link, ML_LCTL);
+		if (((val & mask) >> MLCTL_CPA))
+			return 0;
+	} while (--timeout);
+
+	return -EIO;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_link_power_up);
+
+/**
+ * snd_soc_hdac_bus_link_power_down -power up hda link
+ * @link - HD-audio soc link
+ */
+int snd_soc_hdac_bus_link_power_down(struct soc_hdac_link *link)
+{
+	int timeout;
+	int mask = (1 << MLCTL_CPA);
+	u32 val;
+
+	soc_hdac_link_updatel(link, ML_LCTL, MLCTL_SPA, 0);
+	udelay(3);
+	timeout = 300;
+
+	do {
+		val = soc_hdac_link_readl(link, ML_LCTL);
+		if (!((val & mask) >> MLCTL_CPA))
+			return 0;
+	} while (--timeout);
+
+	return -EIO;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_link_power_down);
+
+/* Module information */
+MODULE_AUTHOR("Jeeja KP <jeeja.kp@intel.com>");
+MODULE_DESCRIPTION("HDA SoC core");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/hda/soc-hdac-stream.c b/sound/soc/hda/soc-hdac-stream.c
new file mode 100644
index 000000000000..7a2c2242f780
--- /dev/null
+++ b/sound/soc/hda/soc-hdac-stream.c
@@ -0,0 +1,390 @@
+/*
+ *  soc-hdac-stream.c - SoC HD-audio stream  operations.
+ *
+ *  Copyright (C) 2015 Intel Corp
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
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/hdaudio.h>
+#include <sound/hda_register.h>
+#include <sound/soc-hdaudio.h>
+
+/**
+ * snd_soc_hdac_stream_init - initialize each stream (aka device)
+ * @bus: HD-audio soc core bus
+ * @stream: HD-audio soc core stream object to initialize
+ * @idx: stream index number
+ * @direction: stream direction (SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE)
+ * @tag: the tag id to assign
+ *
+ * Assign the starting bdl address to each stream (device) and initialize.
+ */
+void snd_soc_hdac_stream_init(struct soc_hdac_bus *sbus,
+				struct soc_hdac_stream *stream,
+				int idx, int direction, int tag)
+{
+	struct hdac_bus *bus = &sbus->bus;
+
+	if (sbus->ppcap) {
+		stream->pphc_addr = sbus->ppcap_addr +
+					PPHC_BASE +
+					PPHC_INTERVAL *
+					idx;
+
+		stream->pplc_addr = sbus->ppcap_addr +
+					PPLC_BASE +
+					PPLC_MULTI *
+					sbus->num_streams +
+					PPLC_INTERVAL *
+					idx;
+	}
+	stream->decoupled = false;
+	snd_hdac_stream_init(bus, &stream->hstream, idx, direction, tag);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_init);
+
+/**
+ * snd_soc_hdac_stream_decouple - decouple the hdac stream
+ * @bus: HD-audio soc core bus
+ * @stream: HD-audio soc core stream object to initialize
+ * @decouple: flag to decouple
+ */
+void snd_soc_hdac_stream_decouple(struct soc_hdac_bus *sbus,
+				struct soc_hdac_stream *stream, bool decouple)
+{
+	struct hdac_stream *hstream = &stream->hstream;
+	struct hdac_bus *bus = &sbus->bus;
+
+	spin_lock_irq(&bus->reg_lock);
+	if (decouple)
+		soc_hdac_bus_ppcap_updatew(sbus, PP_PPCTL, 0,
+						PPCTL_PROCEN(hstream->index));
+	else
+		soc_hdac_bus_ppcap_updatew(sbus, PP_PPCTL,
+					PPCTL_PROCEN(hstream->index), 0);
+	stream->decoupled = decouple;
+	spin_unlock_irq(&bus->reg_lock);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_decouple);
+
+/**
+ * snd_soc_hdac_linkstream_start - start a stream
+ * @stream: HD-audio soc core stream to start
+ */
+void snd_soc_hdac_link_stream_start(struct soc_hdac_stream *stream)
+{
+	soc_hdac_link_stream_updateb(stream, PPLCCTL,
+				0, PPLCCTL_RUN);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_stream_start);
+
+/**
+ * snd_soc_hdac_link_stream_clear - stop a stream DMA
+ * @stream: HD-audio soc core stream to stop
+ */
+void snd_soc_hdac_link_stream_clear(struct soc_hdac_stream *stream)
+{
+	soc_hdac_link_stream_updateb(stream, PPLCCTL,
+					PPLCCTL_RUN, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_stream_clear);
+
+/**
+ * snd_soc_hdac_link_stream_reset - reset a stream
+ * @stream: HD-audio soc core stream to reset
+ */
+void snd_soc_hdac_link_stream_reset(struct soc_hdac_stream *stream)
+{
+	unsigned char val;
+	int timeout;
+
+	snd_soc_hdac_link_stream_clear(stream);
+
+	soc_hdac_link_stream_updateb(stream, PPLCCTL, 0, PPLCCTL_STRST);
+	udelay(3);
+	timeout = 300;
+	do {
+		val = soc_hdac_link_stream_readb(stream, PPLCCTL) &
+			PPLCCTL_STRST;
+		if (val)
+			break;
+	} while (--timeout);
+	val &= ~PPLCCTL_STRST;
+	soc_hdac_link_stream_writeb(stream, PPLCCTL, val);
+	udelay(3);
+
+	timeout = 300;
+	/* waiting for hardware to report that the stream is out of reset */
+	do {
+		val = soc_hdac_link_stream_readb(stream, PPLCCTL) &
+			PPLCCTL_STRST;
+		if (!val)
+			break;
+	} while (--timeout);
+
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_stream_reset);
+
+/**
+ * snd_soc_hdac_link_stream_setup -  set up the SD for streaming
+ * @stream: HD-audio soc core stream to set up
+ * @fmt: stream format
+ */
+int snd_soc_hdac_link_stream_setup(struct soc_hdac_stream *stream, int fmt)
+{
+	struct hdac_stream *hstream = &stream->hstream;
+	unsigned int val;
+
+	/* make sure the run bit is zero for SD */
+	snd_soc_hdac_link_stream_clear(stream);
+	/* program the stream_tag */
+	val = soc_hdac_link_stream_readl(stream, PPLCCTL);
+	val = (val & ~PPLCCTL_STRM_MASK) |
+		(hstream->stream_tag << PPLCCTL_STRM_SHIFT);
+	soc_hdac_link_stream_writel(stream, PPLCCTL, val);
+
+	/* program the stream format */
+	/* this value needs to be the same as the one programmed */
+	soc_hdac_link_stream_writew(stream, PPLCFMT, fmt);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_stream_setup);
+
+/**
+ * snd_soc_hdac_link_set_stream_id - maps stream id to link output
+ * @link: HD-audio soc link to set up
+ * @stream: stream id
+ */
+void snd_soc_hdac_link_set_stream_id(struct soc_hdac_link *link,
+				 int stream)
+{
+	soc_hdac_link_updatew(link, ML_LOSIDV, (1 << stream), 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_set_stream_id);
+
+/**
+ * snd_soc_hdac_link_clear_stream_id - maps stream id to link output
+ * @link: HD-audio soc link to set up
+ * @stream: stream id
+ */
+void snd_soc_hdac_link_clear_stream_id(struct soc_hdac_link *link,
+				 int stream)
+{
+	soc_hdac_link_updatew(link, ML_LOSIDV, 0, (1 << stream));
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_clear_stream_id);
+
+static struct soc_hdac_stream *
+soc_hdac_link_stream_assign(struct soc_hdac_bus *sbus,
+				struct snd_pcm_substream *substream)
+{
+	struct soc_hdac_stream *res = NULL;
+	struct hdac_stream *stream = NULL;
+	struct hdac_bus *hbus = &sbus->bus;
+
+	list_for_each_entry(stream, &hbus->stream_list, list) {
+		struct soc_hdac_stream *hstream = container_of(stream,
+						struct soc_hdac_stream,
+						hstream);
+		if (stream->direction != substream->stream)
+			continue;
+
+		/* check if decoupled stream and  not in use is available */
+		if (hstream->decoupled && !hstream->link_locked) {
+			res = hstream;
+			break;
+		}
+
+		if (!hstream->link_locked) {
+			snd_soc_hdac_stream_decouple(sbus, hstream, true);
+			res = hstream;
+			break;
+		}
+	}
+	if (res) {
+		spin_lock_irq(&hbus->reg_lock);
+		res->link_locked = 1;
+		res->link_substream = substream;
+		spin_unlock_irq(&hbus->reg_lock);
+	}
+	return res;
+}
+
+static struct soc_hdac_stream *
+soc_hdac_host_stream_assign(struct soc_hdac_bus *sbus,
+				struct snd_pcm_substream *substream)
+{
+	struct soc_hdac_stream *res = NULL;
+	struct hdac_stream *stream = NULL;
+	struct hdac_bus *hbus = &sbus->bus;
+
+	/* make a non-zero unique key for the substream */
+	int key = (substream->pcm->device << 16) | (substream->number << 2) |
+			(substream->stream + 1);
+
+	list_for_each_entry(stream, &hbus->stream_list, list) {
+		struct soc_hdac_stream *hstream = container_of(stream,
+						struct soc_hdac_stream,
+						hstream);
+		if (stream->direction != substream->stream)
+			continue;
+
+		if (stream->assigned_key == key) {
+			if (!hstream->decoupled)
+				snd_soc_hdac_stream_decouple(sbus, hstream, true);
+			res = hstream;
+			break;
+		}
+	}
+	if (res) {
+		spin_lock_irq(&hbus->reg_lock);
+		res->hstream.opened = 1;
+		res->hstream.running = 0;
+		res->hstream.assigned_key = key;
+		res->hstream.substream = substream;
+		spin_unlock_irq(&hbus->reg_lock);
+	}
+	return res;
+}
+
+/**
+ * snd_soc_hdac_stream_assign - assign a stream for the PCM
+ * @bus: HD-audio soc core bus
+ * @substream: PCM substream to assign
+ * @type: type of stream (coupled, host or link stream)
+ *
+ * Based on the type of stream (coupled/host/link)
+ * if type is coupled , Looks for an unused stream for the given
+ * PCM substream, assign it and return the stream object.
+ * if type is host, Looks for an unused decoupled host stream for
+ * given pcm stream and assign it and return the stream object.
+ * if type is link, Looks for an unused decoupled link stream for a
+ * given pcm stream and assing it and return the stream object.
+ * If no stream is free, returns NULL. The function tries to keep using
+ * the same stream object when it's used beforehand. when a stream is
+ * decoupled, it becomes a host stream and link stream.
+ */
+struct soc_hdac_stream *snd_soc_hdac_stream_assign(struct soc_hdac_bus *sbus,
+					   struct snd_pcm_substream *substream,
+					   int type)
+{
+	struct soc_hdac_stream *hstream = NULL;
+	struct hdac_stream *stream = NULL;
+	struct hdac_bus *hbus = &sbus->bus;
+
+	if (type == HDAC_STREAM_TYPE_COUPLED) {
+		stream = snd_hdac_stream_assign(hbus, substream);
+		if (stream)
+			hstream = container_of(stream,
+					struct soc_hdac_stream, hstream);
+		return hstream;
+	}
+
+	if (!sbus->ppcap) {
+		dev_err(hbus->dev, "stream type not supported\n");
+		return NULL;
+	}
+
+	if (type == HDAC_STREAM_TYPE_HOST)
+		return soc_hdac_host_stream_assign(sbus, substream);
+	else if (type == HDAC_STREAM_TYPE_LINK)
+		return soc_hdac_link_stream_assign(sbus, substream);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_assign);
+
+/**
+ * snd_soc_hdac_stream_release - release the assigned stream
+ * @stream: HD-audio soc core stream to release
+ * @type: type of stream (coupled, host or link stream)
+ *
+ * Release the stream that has been assigned by snd_soc_hdac_stream_assign().
+ */
+void snd_soc_hdac_stream_release(struct soc_hdac_stream *stream, int type)
+{
+	struct hdac_bus *bus = stream->hstream.bus;
+	struct soc_hdac_bus *sbus = bus_to_soc_hdac_bus(bus);
+
+	if (type == HDAC_STREAM_TYPE_COUPLED)
+		snd_hdac_stream_release(&stream->hstream);
+	else if (type == HDAC_STREAM_TYPE_HOST) {
+		if (stream->decoupled && !stream->link_locked) {
+			snd_soc_hdac_stream_decouple(sbus, stream, false);
+			snd_hdac_stream_release(&stream->hstream);
+		}
+	} else if (type == HDAC_STREAM_TYPE_LINK) {
+		if (stream->decoupled)
+			snd_soc_hdac_stream_decouple(sbus, stream, false);
+		spin_lock_irq(&bus->reg_lock);
+		stream->link_locked = 0;
+		stream->link_substream = NULL;
+		spin_unlock_irq(&bus->reg_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_release);
+
+/**
+ * snd_soc_hdac_stream_spbcap_enable - enable SPIB for a stream
+ * @sbus - HD-audio soc core bus
+ * @index: stream index for which SPIB need to be enabled
+ */
+void snd_soc_hdac_stream_spbcap_enable(struct soc_hdac_bus *sbus,
+				 bool enable, int index)
+{
+	u32 mask = 0;
+	u32 register_mask = 0;
+	struct hdac_bus *bus = &sbus->bus;
+
+	if (!sbus->spbcap) {
+		dev_err(bus->dev, "Address of SPB capability is NULL");
+		return;
+	}
+
+	mask |= (1 << index);
+
+	register_mask = soc_hdac_bus_spbcap_readl(sbus, SPB_SPBFCCTL);
+
+	mask |= register_mask;
+
+	if (enable)
+		soc_hdac_bus_spbcap_updatel(sbus, SPB_SPBFCCTL, 0, mask);
+	else
+		soc_hdac_bus_spbcap_updatel(sbus, SPB_SPBFCCTL, mask, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_spbcap_enable);
+
+/**
+ * snd_soc_hdac_stop_all_stream - stop all stream if running
+ * @sbus - HD-audio soc core bus
+ */
+void snd_soc_hdac_stop_streams(struct soc_hdac_bus *sbus)
+{
+	struct hdac_bus *bus = hdac_bus(sbus);
+	struct hdac_stream *stream;
+
+	if (bus->chip_init) {
+		list_for_each_entry(stream, &bus->stream_list, list)
+			snd_hdac_stream_stop(stream);
+		snd_hdac_bus_stop_chip(bus);
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stop_streams);
-- 
1.7.9.5
