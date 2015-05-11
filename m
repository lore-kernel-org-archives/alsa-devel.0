From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 3/7] ASoC: hda - add asoc hda core bus,
	controller and stream helpers
Date: Mon, 11 May 2015 16:24:01 +0530
Message-ID: <1431341645-2457-4-git-send-email-vinod.koul@intel.com>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 028CF261AB0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 12:53:36 +0200 (CEST)
In-Reply-To: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
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

This patch adds the asoc hdac bus with it initialization and cleanup routines
then we add hdac controller helpers, the new capability parsing and
initialization routines, and link configuration routines
Lastly, we add the hdac stream helpers, the new controller initialization
routines, stream management helpers.

These helpers are added on top of hdac_xxx helpers and the structures
introduced here; soc_hda_bus embeds hdac-bus, soc_hdac_stream embeds
hdac_stream with additional code for additional HDA capabilities.

These will be sued by ASoC HDA controllers like SKL which exhibit these
capabilities

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc-hdaudio.h         | 360 +++++++++++++++++++++++++++++++
 sound/soc/hda/Makefile              |   3 +-
 sound/soc/hda/soc-hdac-bus.c        | 115 ++++++++++
 sound/soc/hda/soc-hdac-controller.c | 296 ++++++++++++++++++++++++++
 sound/soc/hda/soc-hdac-stream.c     | 409 ++++++++++++++++++++++++++++++++++++
 5 files changed, 1182 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/soc-hdaudio.h
 create mode 100644 sound/soc/hda/soc-hdac-bus.c
 create mode 100644 sound/soc/hda/soc-hdac-controller.c
 create mode 100644 sound/soc/hda/soc-hdac-stream.c

diff --git a/include/sound/soc-hdaudio.h b/include/sound/soc-hdaudio.h
new file mode 100644
index 000000000000..477cd09121a4
--- /dev/null
+++ b/include/sound/soc-hdaudio.h
@@ -0,0 +1,360 @@
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
+	bool ppcap:1;
+	bool spbcap:1;
+	bool mlcap:1;
+	bool gtscap:1;
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
+int snd_soc_hdac_bus_init(struct soc_hdac_bus *sbus, struct device *dev,
+		      const struct hdac_bus_ops *ops,
+		      const struct hdac_io_ops *io_ops);
+
+void snd_soc_hdac_bus_exit(struct soc_hdac_bus *sbus);
+int snd_soc_hdac_bus_device_init(struct soc_hdac_bus *sbus, int addr);
+void snd_soc_hdac_bus_device_exit(struct hdac_device *hdev);
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
+#define _soc_hdac_bus_ppcap_write(type, dev, reg, value)		\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->ppcap_addr + (reg)))
+#define _soc_hdac_bus_ppcap_read(type, dev, reg)			\
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
+#define _soc_hdac_bus_spbcap_write(type, dev, reg, value)	\
+	((dev)->bus.io_ops->reg_write ## type(value,		\
+	(dev)->spbcap_addr + (reg)))
+#define _soc_hdac_bus_spbcap_read(type, dev, reg)		\
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
+int snd_soc_hdac_bus_get_ml_capabilities(struct soc_hdac_bus *bus);
+int snd_soc_hdac_bus_map_codec_to_link(struct soc_hdac_bus *bus, int addr);
+struct soc_hdac_link *snd_soc_hdac_bus_get_link(struct soc_hdac_bus *bus,
+						const char *codec_name);
+
+/*
+ * macros for mlcap register read/write
+ */
+#define _soc_hdac_bus_mlcap_write(type, dev, reg, value)		\
+	((dev)->bus.io_ops->reg_write ## type(value, (dev)->mlcap_addr + (reg)))
+#define _soc_hdac_bus_mlcap_read(type, dev, reg)			\
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
+#define _soc_hdac_bus_gtscap_write(type, dev, reg, value)	\
+	((dev)->bus.io_ops->reg_write ## type(value,		\
+	(dev)->gtscap_addr + (reg)))
+#define _soc_hdac_bus_gtscap_read(type, dev, reg)		\
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
+
+	void __iomem *pphc_addr; /* processing pipe host stream reg pointer */
+	void __iomem *pplc_addr; /* processing pipe link stream reg pointer */
+
+	bool decoupled:1;
+	bool link_locked:1;
+	bool link_prepared;
+
+	struct snd_pcm_substream *link_substream;
+};
+
+#define hdac_stream(s)		(&(s)->hstream)
+#define stream_to_soc_hdac_stream(s) \
+	container_of(s, struct soc_hdac_stream, hstream)
+
+void snd_soc_hdac_stream_init(struct soc_hdac_bus *bus,
+				struct soc_hdac_stream *stream, int idx,
+				int direction, int tag);
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
+#define _soc_hdac_host_stream_write(type, dev, reg, value)	\
+	((dev)->hstream.bus->io_ops->reg_write ## type(value,	\
+	(dev)->pphc_addr + (reg)))
+#define _soc_hdac_host_stream_read(type, dev, reg)		\
+	((dev)->hstream.bus->io_ops->reg_read ## type(		\
+	(dev)->pphc_addr + (reg)))
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
+#define _soc_hdac_link_stream_write(type, dev, reg, value)	\
+	((dev)->hstream.bus->io_ops->reg_write ## type(value,	\
+	(dev)->pplc_addr + (reg)))
+#define _soc_hdac_link_stream_read(type, dev, reg)		\
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
index 9585ab180a55..b6d5b1840dc2 100644
--- a/sound/soc/hda/Makefile
+++ b/sound/soc/hda/Makefile
@@ -1,3 +1,4 @@
-snd-soc-hda-core-objs := soc-hda-codec.o
+snd-soc-hda-core-objs := soc-hdac-controller.o soc-hdac-stream.o \
+soc-hdac-bus.o soc-hda-codec.o
 
 obj-$(CONFIG_SND_SOC_HDA_CORE) += snd-soc-hda-core.o
diff --git a/sound/soc/hda/soc-hdac-bus.c b/sound/soc/hda/soc-hdac-bus.c
new file mode 100644
index 000000000000..f541668577c6
--- /dev/null
+++ b/sound/soc/hda/soc-hdac-bus.c
@@ -0,0 +1,115 @@
+/*
+ *  soc-hdac-bus.c - SoC HD-audio core bus functions.
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
+#include <sound/soc-hdaudio.h>
+
+/**
+ * snd_soc_hdac_bus_init - initialize a HD-audio soc bus
+ * @sbus: the pointer to soc bus object
+ * @dev: device pointer
+ * @ops: bus verb operators
+ * @io_ops: lowlevel I/O operators
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_soc_hdac_bus_init(struct soc_hdac_bus *sbus, struct device *dev,
+			const struct hdac_bus_ops *ops,
+			const struct hdac_io_ops *io_ops)
+{
+	int ret;
+
+	ret = snd_hdac_bus_init(&sbus->bus, dev, ops, io_ops);
+	if (ret < 0)
+		return ret;
+
+	INIT_LIST_HEAD(&sbus->hlink_list);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_init);
+
+/**
+ * snd_soc_hdac_bus_exit - clean up a HD-audio soc bus
+ * @sbus: the pointer to soc bus object
+ */
+void snd_soc_hdac_bus_exit(struct soc_hdac_bus *sbus)
+{
+	snd_hdac_bus_exit(&sbus->bus);
+	WARN_ON(!list_empty(&sbus->hlink_list));
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_exit);
+
+static void default_release(struct device *dev)
+{
+	snd_soc_hdac_bus_device_exit(container_of(dev, struct hdac_device, dev));
+}
+
+/**
+ * snd_soc_hdac_device_init - initialize the HD-audio soc codec base device
+ * @sbus: hdac asoc bus to attach to
+ * @addr: codec address
+ *
+ * Returns zero for success or a negative error code.
+ */
+int snd_soc_hdac_bus_device_init(struct soc_hdac_bus *sbus, int addr)
+{
+	struct hdac_device *hdev = NULL;
+	struct hdac_bus *bus = hdac_bus(sbus);
+	char name[15];
+	int ret;
+
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
+	if (!hdev)
+		return -ENOMEM;
+
+	snprintf(name, sizeof(name), "soc-hda-codec#%03x", addr);
+
+	ret  = snd_hdac_device_init(hdev, bus, name, addr);
+	if (ret < 0) {
+		dev_err(bus->dev, "device init failed for hdac device\n");
+		return ret;
+	}
+	hdev->type = HDA_DEV_ASOC;
+	hdev->dev.release = default_release;
+
+	ret = snd_hdac_device_register(hdev);
+	if (ret) {
+		dev_err(bus->dev, "failed to register hdac device\n");
+		snd_soc_hdac_bus_device_exit(hdev);
+		return ret;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_device_init);
+
+/**
+ * snd_soc_hdac_bus_device_exit - clean up a HD-audio soc codec base device
+ * @hdev: hdac device to clean up
+ */
+void snd_soc_hdac_bus_device_exit(struct hdac_device *hdev)
+{
+	snd_hdac_device_exit(hdev);
+	kfree(hdev);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_device_exit);
diff --git a/sound/soc/hda/soc-hdac-controller.c b/sound/soc/hda/soc-hdac-controller.c
new file mode 100644
index 000000000000..53454703cece
--- /dev/null
+++ b/sound/soc/hda/soc-hdac-controller.c
@@ -0,0 +1,296 @@
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
+#include <linux/slab.h>
+#include <sound/core.h>
+#include <sound/hda_register.h>
+#include <sound/soc-hdaudio.h>
+
+/**
+ * snd_soc_hdac_bus_parse_capabilities - parse capablity structure
+ * @sbus: the pointer to soc bus object
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_soc_hdac_bus_parse_capabilities(struct soc_hdac_bus *sbus)
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
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_parse_capabilities);
+
+/*
+ * processing pipe helpers - these helpers are useful for dealing with HDA
+ * new capability of processing pipelines
+ */
+
+/**
+ * snd_soc_hdac_bus_ppcap_enable - enable/disable processing pipe capability
+ * @sbus: HD-audio soc core bus
+ * @enable: flag to turn on/off the capability
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
+
+	if (enable)
+		soc_hdac_bus_ppcap_updatel(sbus, PP_PPCTL, 0, AZX_PPCTL_GPROCEN);
+	else
+		soc_hdac_bus_ppcap_updatel(sbus, PP_PPCTL, AZX_PPCTL_GPROCEN, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_ppcap_enable);
+
+/**
+ * snd_soc_hdac_bus_ppcap_int_enable - ppcap interrupt enable/disable
+ * @sbus: HD-audio soc core bus
+ * @enable: flag to enable/disable interrupt
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
+		soc_hdac_bus_ppcap_updatel(sbus, PP_PPCTL, 0, AZX_PPCTL_PIE);
+	else
+		soc_hdac_bus_ppcap_updatel(sbus, PP_PPCTL, AZX_PPCTL_PIE, 0);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_ppcap_int_enable);
+
+/*
+ * Multilink helpers - these helpers are useful for dealing with HDA
+ * new multilink capability
+ */
+
+/**
+ * snd_soc_hdac_bus_get_ml_capabilities - get multilink capability
+ * @sbus: HD-audio soc core bus
+ *
+ * This will parse all links and read the mlink capabilities and add them
+ * in hlink_list of asoc hdac bus
+ * Note: this will be freed on bus exit by driver
+ */
+int snd_soc_hdac_bus_get_ml_capabilities(struct soc_hdac_bus *sbus)
+{
+	int idx;
+	u32 link_count;
+	struct soc_hdac_link *hlink;
+	struct hdac_bus *bus = &sbus->bus;
+
+	link_count = soc_hdac_bus_mlcap_readl(sbus, ML_MLCD) + 1;
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
+		hlink->lcaps  = soc_hdac_link_readl(hlink, ML_LCAP);
+		hlink->lsdiid = soc_hdac_link_readw(hlink, ML_LSDIID);
+
+		list_add_tail(&hlink->list, &sbus->hlink_list);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_get_ml_capabilities);
+
+/**
+ * snd_soc_hdac_bus_map_codec_to_link - maps codec to link
+ * @sbus: HD-audio soc core bus
+ * @addr: codec address
+ */
+int snd_soc_hdac_bus_map_codec_to_link(struct soc_hdac_bus *sbus, int addr)
+{
+	struct soc_hdac_link *hlink;
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
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_map_codec_to_link);
+
+/**
+ * snd_soc_hdac_bus_get_link_index - get link based on codec name
+ * @sbus: HD-audio soc core bus
+ * @codec_name: codec name
+ */
+struct soc_hdac_link *snd_soc_hdac_bus_get_link(struct soc_hdac_bus *sbus,
+						 const char *codec_name)
+{
+	int i;
+	struct soc_hdac_link *hlink = NULL;
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
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_get_link);
+
+int check_hdac_link_power_active(struct soc_hdac_link *link, bool enable)
+{
+	int timeout;
+	u32 val;
+	int mask = (1 << AZX_MLCTL_CPA);
+
+	udelay(3);
+	timeout = 50;
+
+	do {
+		val = soc_hdac_link_readl(link, ML_LCTL);
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
+ * snd_soc_hdac_bus_link_power_up -power up hda link
+ * @link: HD-audio soc link
+ */
+int snd_soc_hdac_bus_link_power_up(struct soc_hdac_link *link)
+{
+	soc_hdac_link_updatel(link, ML_LCTL, 0, AZX_MLCTL_SPA);
+
+	return check_hdac_link_power_active(link, true);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_link_power_up);
+
+/**
+ * snd_soc_hdac_bus_link_power_down -power down hda link
+ * @link: HD-audio soc link
+ */
+int snd_soc_hdac_bus_link_power_down(struct soc_hdac_link *link)
+{
+	soc_hdac_link_updatel(link, ML_LCTL, AZX_MLCTL_SPA, 0);
+
+	return check_hdac_link_power_active(link, false);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_bus_link_power_down);
+
+MODULE_DESCRIPTION("HDA SoC core");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/hda/soc-hdac-stream.c b/sound/soc/hda/soc-hdac-stream.c
new file mode 100644
index 000000000000..81d9eed4ece2
--- /dev/null
+++ b/sound/soc/hda/soc-hdac-stream.c
@@ -0,0 +1,409 @@
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
+ * @sbus: HD-audio soc core bus
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
+					AZX_PPHC_BASE +
+					AZX_PPHC_INTERVAL *
+					idx;
+
+		stream->pplc_addr = sbus->ppcap_addr +
+					AZX_PPLC_BASE +
+					AZX_PPLC_MULTI *
+					sbus->num_streams +
+					AZX_PPLC_INTERVAL *
+					idx;
+	}
+	stream->decoupled = false;
+	snd_hdac_stream_init(bus, &stream->hstream, idx, direction, tag);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_init);
+
+/**
+ * snd_soc_hdac_stream_decouple - decouple the hdac stream
+ * @sbus: HD-audio soc core bus
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
+		soc_hdac_bus_ppcap_updatel(sbus, PP_PPCTL, 0,
+						AZX_PPCTL_PROCEN(hstream->index));
+	else
+		soc_hdac_bus_ppcap_updatel(sbus, PP_PPCTL,
+					AZX_PPCTL_PROCEN(hstream->index), 0);
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
+	soc_hdac_link_stream_updatel(stream, PPLCCTL,
+				0, AZX_PPLCCTL_RUN);
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_link_stream_start);
+
+/**
+ * snd_soc_hdac_link_stream_clear - stop a stream DMA
+ * @stream: HD-audio soc core stream to stop
+ */
+void snd_soc_hdac_link_stream_clear(struct soc_hdac_stream *stream)
+{
+	soc_hdac_link_stream_updatel(stream, PPLCCTL,
+					AZX_PPLCCTL_RUN, 0);
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
+	soc_hdac_link_stream_updatel(stream, PPLCCTL, 0, AZX_PPLCCTL_STRST);
+	udelay(3);
+	timeout = 50;
+	do {
+		val = soc_hdac_link_stream_readl(stream, PPLCCTL) &
+			AZX_PPLCCTL_STRST;
+		if (val)
+			break;
+		udelay(3);
+	} while (--timeout);
+	val &= ~AZX_PPLCCTL_STRST;
+	soc_hdac_link_stream_writel(stream, PPLCCTL, val);
+	udelay(3);
+
+	timeout = 50;
+	/* waiting for hardware to report that the stream is out of reset */
+	do {
+		val = soc_hdac_link_stream_readl(stream, PPLCCTL) &
+			AZX_PPLCCTL_STRST;
+		if (!val)
+			break;
+		udelay(3);
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
+	val = (val & ~AZX_PPLCCTL_STRM_MASK) |
+		(hstream->stream_tag << AZX_PPLCCTL_STRM_SHIFT);
+	soc_hdac_link_stream_writel(stream, PPLCCTL, val);
+
+	/* program the stream format */
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
+	if (!sbus->ppcap) {
+		dev_err(hbus->dev, "stream type not supported\n");
+		return NULL;
+	}
+
+	list_for_each_entry(stream, &hbus->stream_list, list) {
+		struct soc_hdac_stream *hstream = container_of(stream,
+						struct soc_hdac_stream,
+						hstream);
+		if (stream->direction != substream->stream)
+			continue;
+
+		/* check if decoupled stream and not in use is available */
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
+	int key;
+
+	if (!sbus->ppcap) {
+		dev_err(hbus->dev, "stream type not supported\n");
+		return NULL;
+	}
+
+	/* make a non-zero unique key for the substream */
+	key = (substream->pcm->device << 16) | (substream->number << 2) |
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
+ * @sbus: HD-audio soc core bus
+ * @substream: PCM substream to assign
+ * @type: type of stream (coupled, host or link stream)
+ *
+ * This assigns the stream based on the type (coupled/host/link), for the
+ * given PCM substream, assigns it and returns the stream object
+ *
+ * coupled: Looks for an unused stream
+ * host: Looks for an unused decoupled host stream
+ * link: Looks for an unused decoupled link stream
+ *
+ * If no stream is free, returns NULL. The function tries to keep using
+ * the same stream object when it's used beforehand.  when a stream is
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
+	switch (type) {
+	case HDAC_STREAM_TYPE_COUPLED:
+		stream = snd_hdac_stream_assign(hbus, substream);
+		if (stream)
+			hstream = container_of(stream,
+					struct soc_hdac_stream, hstream);
+		return hstream;
+
+	case HDAC_STREAM_TYPE_HOST:
+		return soc_hdac_host_stream_assign(sbus, substream);
+
+	case HDAC_STREAM_TYPE_LINK:
+		return soc_hdac_link_stream_assign(sbus, substream);
+
+	default:
+		return NULL;
+	}
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
+	switch (type) {
+	case HDAC_STREAM_TYPE_COUPLED:
+		snd_hdac_stream_release(&stream->hstream);
+		break;
+
+	case HDAC_STREAM_TYPE_HOST:
+		if (stream->decoupled && !stream->link_locked) {
+			snd_soc_hdac_stream_decouple(sbus, stream, false);
+			snd_hdac_stream_release(&stream->hstream);
+		}
+		break;
+	case HDAC_STREAM_TYPE_LINK:
+		if (stream->decoupled)
+			snd_soc_hdac_stream_decouple(sbus, stream, false);
+		spin_lock_irq(&bus->reg_lock);
+		stream->link_locked = 0;
+		stream->link_substream = NULL;
+		spin_unlock_irq(&bus->reg_lock);
+		break;
+	default:
+		dev_dbg(bus->dev, "Invalid type\n");
+	}
+
+}
+EXPORT_SYMBOL_GPL(snd_soc_hdac_stream_release);
+
+/**
+ * snd_soc_hdac_stream_spbcap_enable - enable SPIB for a stream
+ * @sbus: HD-audio soc core bus
+ * @enable: flag to enable/disable SPIB
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
+ * @sbus: HD-audio soc core bus
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
1.9.1
