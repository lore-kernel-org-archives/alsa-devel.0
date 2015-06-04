From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v6 3/3] ALSA: hdac_ext: add extended stream
	capabilities
Date: Thu,  4 Jun 2015 15:23:22 +0530
Message-ID: <1433411602-5444-4-git-send-email-vinod.koul@intel.com>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AB079265E0D
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 11:52:13 +0200 (CEST)
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

Now we have the bus and controller code added to find and initialize the
extended capabilities. Now we need to use them in stream code to decouple
stream, manage links etc

So this patch adds the stream handling code for extended capabilities
introduced in preceding patches

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio_ext.h     | 118 ++++++++++++
 sound/hda/ext/Makefile          |   2 +-
 sound/hda/ext/hdac_ext_stream.c | 414 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 533 insertions(+), 1 deletion(-)
 create mode 100644 sound/hda/ext/hdac_ext_stream.c

diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index b17d7f91f6ac..05982dc7e3cc 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -212,6 +212,124 @@ enum hdac_ext_stream_type {
 	HDAC_EXT_STREAM_TYPE_LINK
 };
 
+/**
+ * hdac_ext_stream: HDAC extended stream for extended HDA caps
+ *
+ * @hstream: hdac_stream
+ * @pphc_addr: processing pipe host stream pointer
+ * @pplc_addr: processing pipe link stream pointer
+ * @decoupled: stream host and link is decoupled
+ * @link_locked: link is locked
+ * @link_prepared: link is prepared
+ * link_substream: link substream
+ */
+struct hdac_ext_stream {
+	struct hdac_stream hstream;
+
+	void __iomem *pphc_addr;
+	void __iomem *pplc_addr;
+
+	bool decoupled:1;
+	bool link_locked:1;
+	bool link_prepared;
+
+	struct snd_pcm_substream *link_substream;
+};
+
+#define hdac_stream(s)		(&(s)->hstream)
+#define stream_to_hdac_ext_stream(s) \
+	container_of(s, struct hdac_ext_stream, hstream)
+
+void snd_hdac_ext_stream_init(struct hdac_ext_bus *bus,
+				struct hdac_ext_stream *stream, int idx,
+				int direction, int tag);
+struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_ext_bus *bus,
+					   struct snd_pcm_substream *substream,
+					   int type);
+void snd_hdac_ext_stream_release(struct hdac_ext_stream *azx_dev, int type);
+void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *bus,
+				struct hdac_ext_stream *azx_dev, bool decouple);
+void snd_hdac_ext_stop_streams(struct hdac_ext_bus *sbus);
+
+/*
+ * macros for host stream register read/write
+ */
+#define _snd_hdac_ext_host_stream_write(type, dev, reg, value)	\
+	((dev)->hstream.bus->io_ops->reg_write ## type(value,	\
+	(dev)->pphc_addr + (reg)))
+#define _snd_hdac_ext_host_stream_read(type, dev, reg)		\
+	((dev)->hstream.bus->io_ops->reg_read ## type(		\
+	(dev)->pphc_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_host_stream_writel(dev, reg, value) \
+	_snd_hdac_ext_host_stream_write(l, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_host_stream_writew(dev, reg, value) \
+	_snd_hdac_ext_host_stream_write(w, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_host_stream_writeb(dev, reg, value) \
+	_snd_hdac_ext_host_stream_write(b, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_host_stream_readl(dev, reg) \
+	_snd_hdac_ext_host_stream_read(l, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_host_stream_readw(dev, reg) \
+	_snd_hdac_ext_host_stream_read(w, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_host_stream_readb(dev, reg) \
+	_snd_hdac_ext_host_stream_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_host_stream_updatel(dev, reg, mask, val) \
+	snd_hdac_ext_host_stream_writel(dev, reg, \
+			       (snd_hdac_ext_host_stream_readl(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_host_stream_updatew(dev, reg, mask, val) \
+	snd_hdac_ext_host_stream_writew(dev, reg, \
+			       (snd_hdac_ext_host_stream_readw(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_host_stream_updateb(dev, reg, mask, val) \
+	snd_hdac_ext_host_stream_writeb(dev, reg, \
+			       (snd_hdac_ext_host_stream_readb(dev, reg) & \
+				~(mask)) | (val))
+
+void snd_hdac_ext_link_stream_start(struct hdac_ext_stream *hstream);
+void snd_hdac_ext_link_stream_clear(struct hdac_ext_stream *hstream);
+void snd_hdac_ext_link_stream_reset(struct hdac_ext_stream *hstream);
+int snd_hdac_ext_link_stream_setup(struct hdac_ext_stream *stream, int fmt);
+
+/*
+ * macros for link stream register read/write
+ */
+#define _snd_hdac_ext_link_stream_write(type, dev, reg, value)	\
+	((dev)->hstream.bus->io_ops->reg_write ## type(value,	\
+	(dev)->pplc_addr + (reg)))
+#define _snd_hdac_ext_link_stream_read(type, dev, reg)		\
+	((dev)->hstream.bus->io_ops->reg_read ## type((dev)->pplc_addr + (reg)))
+
+/* read/write a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_link_stream_writel(dev, reg, value) \
+	_snd_hdac_ext_link_stream_write(l, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_link_stream_writew(dev, reg, value) \
+	_snd_hdac_ext_link_stream_write(w, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_link_stream_writeb(dev, reg, value) \
+	_snd_hdac_ext_link_stream_write(b, dev, AZX_REG_ ## reg, value)
+#define snd_hdac_ext_link_stream_readl(dev, reg) \
+	_snd_hdac_ext_link_stream_read(l, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_link_stream_readw(dev, reg) \
+	_snd_hdac_ext_link_stream_read(w, dev, AZX_REG_ ## reg)
+#define snd_hdac_ext_link_stream_readb(dev, reg) \
+	_snd_hdac_ext_link_stream_read(b, dev, AZX_REG_ ## reg)
+
+/* update a register, pass without AZX_REG_ prefix */
+#define snd_hdac_ext_link_stream_updatel(dev, reg, mask, val) \
+	snd_hdac_ext_link_stream_writel(dev, reg, \
+			       (snd_hdac_ext_link_stream_readl(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_link_stream_updatew(dev, reg, mask, val) \
+	snd_hdac_ext_link_stream_writew(dev, reg, \
+			       (snd_hdac_ext_link_stream_readw(dev, reg) & \
+				~(mask)) | (val))
+#define snd_hdac_ext_link_stream_updateb(dev, reg, mask, val) \
+	snd_hdac_ext_link_stream_writeb(dev, reg, \
+			       (snd_hdac_ext_link_stream_readb(dev, reg) & \
+				~(mask)) | (val))
 struct hdac_ext_link {
 	struct hdac_bus *bus;
 	int index;
diff --git a/sound/hda/ext/Makefile b/sound/hda/ext/Makefile
index 934b7bf5d87f..9b6f641c7777 100644
--- a/sound/hda/ext/Makefile
+++ b/sound/hda/ext/Makefile
@@ -1,3 +1,3 @@
-snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o
+snd-hda-ext-core-objs := hdac_ext_bus.o hdac_ext_controller.o hdac_ext_stream.o
 
 obj-$(CONFIG_SND_HDA_EXT_CORE) += snd-hda-ext-core.o
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
new file mode 100644
index 000000000000..f95dce6b9d0a
--- /dev/null
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -0,0 +1,414 @@
+/*
+ *  hdac-ext-stream.c - HD-audio extended stream operations.
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
+#include <sound/hdaudio_ext.h>
+
+/**
+ * snd_hdac_ext_stream_init - initialize each stream (aka device)
+ * @sbus: HD-audio ext core bus
+ * @stream: HD-audio ext core stream object to initialize
+ * @idx: stream index number
+ * @direction: stream direction (SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE)
+ * @tag: the tag id to assign
+ *
+ * initialize teh stream, if ppcap is enabled then init those and then
+ * invoke hdac stream initialization routine
+ */
+void snd_hdac_ext_stream_init(struct hdac_ext_bus *sbus,
+				struct hdac_ext_stream *stream,
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
+
+	stream->decoupled = false;
+	snd_hdac_stream_init(bus, &stream->hstream, idx, direction, tag);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_init);
+
+/**
+ * snd_hdac_ext_stream_decouple - decouple the hdac stream
+ * @sbus: HD-audio ext core bus
+ * @stream: HD-audio ext core stream object to initialize
+ * @decouple: flag to decouple
+ */
+void snd_hdac_ext_stream_decouple(struct hdac_ext_bus *sbus,
+				struct hdac_ext_stream *stream, bool decouple)
+{
+	struct hdac_stream *hstream = &stream->hstream;
+	struct hdac_bus *bus = &sbus->bus;
+
+	spin_lock_irq(&bus->reg_lock);
+	if (decouple)
+		snd_hdac_ext_bus_ppcap_updatel(sbus, PP_PPCTL, 0,
+						AZX_PPCTL_PROCEN(hstream->index));
+	else
+		snd_hdac_ext_bus_ppcap_updatel(sbus, PP_PPCTL,
+					AZX_PPCTL_PROCEN(hstream->index), 0);
+	stream->decoupled = decouple;
+	spin_unlock_irq(&bus->reg_lock);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_decouple);
+
+/**
+ * snd_hdac_ext_linkstream_start - start a stream
+ * @stream: HD-audio ext core stream to start
+ */
+void snd_hdac_ext_link_stream_start(struct hdac_ext_stream *stream)
+{
+	snd_hdac_ext_link_stream_updatel(stream, PPLCCTL,
+				0, AZX_PPLCCTL_RUN);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_link_stream_start);
+
+/**
+ * snd_hdac_ext_link_stream_clear - stop a stream DMA
+ * @stream: HD-audio ext core stream to stop
+ */
+void snd_hdac_ext_link_stream_clear(struct hdac_ext_stream *stream)
+{
+	snd_hdac_ext_link_stream_updatel(stream, PPLCCTL,
+					AZX_PPLCCTL_RUN, 0);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_link_stream_clear);
+
+/**
+ * snd_hdac_ext_link_stream_reset - reset a stream
+ * @stream: HD-audio ext core stream to reset
+ */
+void snd_hdac_ext_link_stream_reset(struct hdac_ext_stream *stream)
+{
+	unsigned char val;
+	int timeout;
+
+	snd_hdac_ext_link_stream_clear(stream);
+
+	snd_hdac_ext_link_stream_updatel(stream, PPLCCTL, 0, AZX_PPLCCTL_STRST);
+	udelay(3);
+	timeout = 50;
+	do {
+		val = snd_hdac_ext_link_stream_readl(stream, PPLCCTL) &
+			AZX_PPLCCTL_STRST;
+		if (val)
+			break;
+		udelay(3);
+	} while (--timeout);
+	val &= ~AZX_PPLCCTL_STRST;
+	snd_hdac_ext_link_stream_writel(stream, PPLCCTL, val);
+	udelay(3);
+
+	timeout = 50;
+	/* waiting for hardware to report that the stream is out of reset */
+	do {
+		val = snd_hdac_ext_link_stream_readl(stream, PPLCCTL) &
+			AZX_PPLCCTL_STRST;
+		if (!val)
+			break;
+		udelay(3);
+	} while (--timeout);
+
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_link_stream_reset);
+
+/**
+ * snd_hdac_ext_link_stream_setup -  set up the SD for streaming
+ * @stream: HD-audio ext core stream to set up
+ * @fmt: stream format
+ */
+int snd_hdac_ext_link_stream_setup(struct hdac_ext_stream *stream, int fmt)
+{
+	struct hdac_stream *hstream = &stream->hstream;
+	unsigned int val;
+
+	/* make sure the run bit is zero for SD */
+	snd_hdac_ext_link_stream_clear(stream);
+	/* program the stream_tag */
+	val = snd_hdac_ext_link_stream_readl(stream, PPLCCTL);
+	val = (val & ~AZX_PPLCCTL_STRM_MASK) |
+		(hstream->stream_tag << AZX_PPLCCTL_STRM_SHIFT);
+	snd_hdac_ext_link_stream_writel(stream, PPLCCTL, val);
+
+	/* program the stream format */
+	snd_hdac_ext_link_stream_writew(stream, PPLCFMT, fmt);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_link_stream_setup);
+
+/**
+ * snd_hdac_ext_link_set_stream_id - maps stream id to link output
+ * @link: HD-audio ext link to set up
+ * @stream: stream id
+ */
+void snd_hdac_ext_link_set_stream_id(struct hdac_ext_link *link,
+				 int stream)
+{
+	snd_hdac_ext_link_updatew(link, ML_LOSIDV, (1 << stream), 0);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_link_set_stream_id);
+
+/**
+ * snd_hdac_ext_link_clear_stream_id - maps stream id to link output
+ * @link: HD-audio ext link to set up
+ * @stream: stream id
+ */
+void snd_hdac_ext_link_clear_stream_id(struct hdac_ext_link *link,
+				 int stream)
+{
+	snd_hdac_ext_link_updatew(link, ML_LOSIDV, 0, (1 << stream));
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_link_clear_stream_id);
+
+static struct hdac_ext_stream *
+hdac_ext_link_stream_assign(struct hdac_ext_bus *sbus,
+				struct snd_pcm_substream *substream)
+{
+	struct hdac_ext_stream *res = NULL;
+	struct hdac_stream *stream = NULL;
+	struct hdac_bus *hbus = &sbus->bus;
+
+	if (!sbus->ppcap) {
+		dev_err(hbus->dev, "stream type not supported\n");
+		return NULL;
+	}
+
+	list_for_each_entry(stream, &hbus->stream_list, list) {
+		struct hdac_ext_stream *hstream = container_of(stream,
+						struct hdac_ext_stream,
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
+			snd_hdac_ext_stream_decouple(sbus, hstream, true);
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
+static struct hdac_ext_stream *
+hdac_ext_host_stream_assign(struct hdac_ext_bus *sbus,
+				struct snd_pcm_substream *substream)
+{
+	struct hdac_ext_stream *res = NULL;
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
+		struct hdac_ext_stream *hstream = container_of(stream,
+						struct hdac_ext_stream,
+						hstream);
+		if (stream->direction != substream->stream)
+			continue;
+
+		if (stream->opened) {
+			if (!hstream->decoupled)
+				snd_hdac_ext_stream_decouple(sbus, hstream, true);
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
+
+	return res;
+}
+
+/**
+ * snd_hdac_ext_stream_assign - assign a stream for the PCM
+ * @sbus: HD-audio ext core bus
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
+struct hdac_ext_stream *snd_hdac_ext_stream_assign(struct hdac_ext_bus *sbus,
+					   struct snd_pcm_substream *substream,
+					   int type)
+{
+	struct hdac_ext_stream *hstream = NULL;
+	struct hdac_stream *stream = NULL;
+	struct hdac_bus *hbus = &sbus->bus;
+
+	switch (type) {
+	case HDAC_EXT_STREAM_TYPE_COUPLED:
+		stream = snd_hdac_stream_assign(hbus, substream);
+		if (stream)
+			hstream = container_of(stream,
+					struct hdac_ext_stream, hstream);
+		return hstream;
+
+	case HDAC_EXT_STREAM_TYPE_HOST:
+		return hdac_ext_host_stream_assign(sbus, substream);
+
+	case HDAC_EXT_STREAM_TYPE_LINK:
+		return hdac_ext_link_stream_assign(sbus, substream);
+
+	default:
+		return NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_assign);
+
+/**
+ * snd_hdac_ext_stream_release - release the assigned stream
+ * @stream: HD-audio ext core stream to release
+ * @type: type of stream (coupled, host or link stream)
+ *
+ * Release the stream that has been assigned by snd_hdac_ext_stream_assign().
+ */
+void snd_hdac_ext_stream_release(struct hdac_ext_stream *stream, int type)
+{
+	struct hdac_bus *bus = stream->hstream.bus;
+	struct hdac_ext_bus *sbus = bus_to_hdac_ext_bus(bus);
+
+	switch (type) {
+	case HDAC_EXT_STREAM_TYPE_COUPLED:
+		snd_hdac_stream_release(&stream->hstream);
+		break;
+
+	case HDAC_EXT_STREAM_TYPE_HOST:
+		if (stream->decoupled) {
+			snd_hdac_ext_stream_decouple(sbus, stream, false);
+			snd_hdac_stream_release(&stream->hstream);
+		}
+		break;
+
+	case HDAC_EXT_STREAM_TYPE_LINK:
+		if (stream->decoupled)
+			snd_hdac_ext_stream_decouple(sbus, stream, false);
+		spin_lock_irq(&bus->reg_lock);
+		stream->link_locked = 0;
+		stream->link_substream = NULL;
+		spin_unlock_irq(&bus->reg_lock);
+		break;
+
+	default:
+		dev_dbg(bus->dev, "Invalid type %d\n", type);
+	}
+
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_release);
+
+/**
+ * snd_hdac_ext_stream_spbcap_enable - enable SPIB for a stream
+ * @sbus: HD-audio ext core bus
+ * @enable: flag to enable/disable SPIB
+ * @index: stream index for which SPIB need to be enabled
+ */
+void snd_hdac_ext_stream_spbcap_enable(struct hdac_ext_bus *sbus,
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
+	register_mask = snd_hdac_ext_bus_spbcap_readl(sbus, SPB_SPBFCCTL);
+
+	mask |= register_mask;
+
+	if (enable)
+		snd_hdac_ext_bus_spbcap_updatel(sbus, SPB_SPBFCCTL, 0, mask);
+	else
+		snd_hdac_ext_bus_spbcap_updatel(sbus, SPB_SPBFCCTL, mask, 0);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_spbcap_enable);
+
+/**
+ * snd_hdac_ext_stop_streams - stop all stream if running
+ * @sbus: HD-audio ext core bus
+ */
+void snd_hdac_ext_stop_streams(struct hdac_ext_bus *sbus)
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
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stop_streams);
-- 
1.9.1
