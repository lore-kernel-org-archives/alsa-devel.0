From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v3 03/13] ALSA: hdac: Add support for hda DMA
	Resume capability
Date: Mon, 14 Dec 2015 09:57:19 +0530
Message-ID: <1450067249-7151-4-git-send-email-vinod.koul@intel.com>
References: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 622EC260542
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 05:24:29 +0100 (CET)
In-Reply-To: <1450067249-7151-1-git-send-email-vinod.koul@intel.com>
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

Skylake sports new capability of DMA resume, DRSM where we can
resume the DMA. This capability is defined by presence of
AZX_DRSM_CAP_ID.

If this capability is present, we use this capability.
So we add:

snd_hdac_ext_stream_drsm_enable() - DMA resume caps
snd_hdac_ext_stream_set_dpibr() - set the DMA position
snd_hdac_ext_stream_set_lpib() - set the lpib

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hda_register.h        |  9 +++++
 include/sound/hdaudio_ext.h         | 14 ++++++++
 sound/hda/ext/hdac_ext_controller.c |  6 ++++
 sound/hda/ext/hdac_ext_stream.c     | 71 +++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/include/sound/hda_register.h b/include/sound/hda_register.h
index 2ae8812d7b1a..28ac1f9a18ac 100644
--- a/include/sound/hda_register.h
+++ b/include/sound/hda_register.h
@@ -230,6 +230,15 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define AZX_MLCTL_SPA			(1<<16)
 #define AZX_MLCTL_CPA			23
 
+
+/* registers for DMA Resume Capability Structure */
+#define AZX_DRSM_CAP_ID			0x5
+#define AZX_REG_DRSM_CTL		0x4
+/* Base used to calculate the iterating register offset */
+#define AZX_DRSM_BASE			0x08
+/* Interval used to calculate the iterating register offset */
+#define AZX_DRSM_INTERVAL		0x08
+
 /*
  * helpers to read the stream position
  */
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index 425af0674557..f3454950ee0b 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -12,6 +12,7 @@
  * @spbcap: SPIB capabilities pointer
  * @mlcap: MultiLink capabilities pointer
  * @gtscap: gts capabilities pointer
+ * @drsmcap: dma resume capabilities pointer
  * @hlink_list: link list of HDA links
  */
 struct hdac_ext_bus {
@@ -23,6 +24,7 @@ struct hdac_ext_bus {
 	void __iomem *spbcap;
 	void __iomem *mlcap;
 	void __iomem *gtscap;
+	void __iomem *drsmcap;
 
 	struct list_head hlink_list;
 };
@@ -72,6 +74,9 @@ enum hdac_ext_stream_type {
  * @pplc_addr: processing pipe link stream pointer
  * @spib_addr: software position in buffers stream pointer
  * @fifo_addr: software position Max fifos stream pointer
+ * @dpibr_addr: DMA position in buffer resume pointer
+ * @dpib: DMA position in buffer
+ * @lpib: Linear position in buffer
  * @decoupled: stream host and link is decoupled
  * @link_locked: link is locked
  * @link_prepared: link is prepared
@@ -86,6 +91,10 @@ struct hdac_ext_stream {
 	void __iomem *spib_addr;
 	void __iomem *fifo_addr;
 
+	void __iomem *dpibr_addr;
+
+	u32 dpib;
+	u32 lpib;
 	bool decoupled:1;
 	bool link_locked:1;
 	bool link_prepared;
@@ -116,6 +125,11 @@ int snd_hdac_ext_stream_set_spib(struct hdac_ext_bus *ebus,
 				 struct hdac_ext_stream *stream, u32 value);
 int snd_hdac_ext_stream_get_spbmaxfifo(struct hdac_ext_bus *ebus,
 				 struct hdac_ext_stream *stream);
+void snd_hdac_ext_stream_drsm_enable(struct hdac_ext_bus *ebus,
+				bool enable, int index);
+int snd_hdac_ext_stream_set_dpibr(struct hdac_ext_bus *ebus,
+				struct hdac_ext_stream *stream, u32 value);
+int snd_hdac_ext_stream_set_lpib(struct hdac_ext_stream *stream, u32 value);
 
 void snd_hdac_ext_link_stream_start(struct hdac_ext_stream *hstream);
 void snd_hdac_ext_link_stream_clear(struct hdac_ext_stream *hstream);
diff --git a/sound/hda/ext/hdac_ext_controller.c b/sound/hda/ext/hdac_ext_controller.c
index 63215b17247c..556267e75591 100644
--- a/sound/hda/ext/hdac_ext_controller.c
+++ b/sound/hda/ext/hdac_ext_controller.c
@@ -77,6 +77,12 @@ int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *ebus)
 			ebus->spbcap = bus->remap_addr + offset;
 			break;
 
+		case AZX_DRSM_CAP_ID:
+			/* DMA resume  capability found, handler function */
+			dev_dbg(bus->dev, "Found DRSM capability\n");
+			ebus->drsmcap = bus->remap_addr + offset;
+			break;
+
 		default:
 			dev_dbg(bus->dev, "Unknown capability %d\n", cur_cap);
 			break;
diff --git a/sound/hda/ext/hdac_ext_stream.c b/sound/hda/ext/hdac_ext_stream.c
index cb89ec7c8147..8f30e8836818 100644
--- a/sound/hda/ext/hdac_ext_stream.c
+++ b/sound/hda/ext/hdac_ext_stream.c
@@ -59,6 +59,10 @@ void snd_hdac_ext_stream_init(struct hdac_ext_bus *ebus,
 					AZX_SPB_MAXFIFO;
 	}
 
+	if (ebus->drsmcap)
+		stream->dpibr_addr = ebus->drsmcap + AZX_DRSM_BASE +
+					AZX_DRSM_INTERVAL * idx;
+
 	stream->decoupled = false;
 	snd_hdac_stream_init(bus, &stream->hstream, idx, direction, tag);
 }
@@ -497,3 +501,70 @@ void snd_hdac_ext_stop_streams(struct hdac_ext_bus *ebus)
 	}
 }
 EXPORT_SYMBOL_GPL(snd_hdac_ext_stop_streams);
+
+/**
+ * snd_hdac_ext_stream_drsm_enable - enable DMA resume for a stream
+ * @ebus: HD-audio ext core bus
+ * @enable: flag to enable/disable DRSM
+ * @index: stream index for which DRSM need to be enabled
+ */
+void snd_hdac_ext_stream_drsm_enable(struct hdac_ext_bus *ebus,
+				bool enable, int index)
+{
+	u32 mask = 0;
+	u32 register_mask = 0;
+	struct hdac_bus *bus = &ebus->bus;
+
+	if (!ebus->drsmcap) {
+		dev_err(bus->dev, "Address of DRSM capability is NULL");
+		return;
+	}
+
+	mask |= (1 << index);
+
+	register_mask = readl(ebus->drsmcap + AZX_REG_SPB_SPBFCCTL);
+
+	mask |= register_mask;
+
+	if (enable)
+		snd_hdac_updatel(ebus->drsmcap, AZX_REG_DRSM_CTL, 0, mask);
+	else
+		snd_hdac_updatel(ebus->drsmcap, AZX_REG_DRSM_CTL, mask, 0);
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_drsm_enable);
+
+/**
+ * snd_hdac_ext_stream_set_dpibr - sets the dpibr value of a stream
+ * @ebus: HD-audio ext core bus
+ * @stream: hdac_ext_stream
+ * @value: dpib value to set
+ */
+int snd_hdac_ext_stream_set_dpibr(struct hdac_ext_bus *ebus,
+				 struct hdac_ext_stream *stream, u32 value)
+{
+	struct hdac_bus *bus = &ebus->bus;
+
+	if (!ebus->drsmcap) {
+		dev_err(bus->dev, "Address of DRSM capability is NULL");
+		return -EINVAL;
+	}
+
+	writel(value, stream->dpibr_addr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_set_dpibr);
+
+/**
+ * snd_hdac_ext_stream_set_lpib - sets the lpib value of a stream
+ * @ebus: HD-audio ext core bus
+ * @stream: hdac_ext_stream
+ * @value: lpib value to set
+ */
+int snd_hdac_ext_stream_set_lpib(struct hdac_ext_stream *stream, u32 value)
+{
+	snd_hdac_stream_writel(&stream->hstream, SD_LPIB, value);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_ext_stream_set_lpib);
-- 
1.9.1
