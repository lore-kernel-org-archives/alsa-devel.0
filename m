From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 1/5] ALSA: hda - move bus_parse_capabilities
	to core
Date: Thu,  4 Aug 2016 15:46:00 +0530
Message-ID: <1470305764-20802-2-git-send-email-vinod.koul@intel.com>
References: <1470305764-20802-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E4E9268267
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 12:08:50 +0200 (CEST)
In-Reply-To: <1470305764-20802-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

HDA capability introduced recently are move to hdac core so that it can
be used by legacy driver as well. Also move the capability pointers up
to hdac_bus object.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/hdaudio.h     | 13 ++++++++
 sound/hda/hdac_controller.c | 75 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 93e63c56f48f..56004ec8d441 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -245,6 +245,12 @@ struct hdac_rb {
 
 /*
  * HD-audio bus base driver
+ *
+ * @ppcap: pp capabilities pointer
+ * @spbcap: SPIB capabilities pointer
+ * @mlcap: MultiLink capabilities pointer
+ * @gtscap: gts capabilities pointer
+ * @drsmcap: dma resume capabilities pointer
  */
 struct hdac_bus {
 	struct device *dev;
@@ -256,6 +262,12 @@ struct hdac_bus {
 	void __iomem *remap_addr;
 	int irq;
 
+	void __iomem *ppcap;
+	void __iomem *spbcap;
+	void __iomem *mlcap;
+	void __iomem *gtscap;
+	void __iomem *drsmcap;
+
 	/* codec linked list */
 	struct list_head codec_list;
 	unsigned int num_codecs;
@@ -335,6 +347,7 @@ static inline void snd_hdac_codec_link_down(struct hdac_device *codec)
 int snd_hdac_bus_send_cmd(struct hdac_bus *bus, unsigned int val);
 int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 			      unsigned int *res);
+int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus);
 int snd_hdac_link_power(struct hdac_device *codec, bool enable);
 
 bool snd_hdac_bus_init_chip(struct hdac_bus *bus, bool full_reset);
diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 9fee464e5d49..043065867656 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -255,6 +255,81 @@ int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_get_response);
 
+#define HDAC_MAX_CAPS 10
+/**
+ * snd_hdac_bus_parse_capabilities - parse capability structure
+ * @bus: the pointer to bus object
+ *
+ * Returns 0 if successful, or a negative error code.
+ */
+int snd_hdac_bus_parse_capabilities(struct hdac_bus *bus)
+{
+	unsigned int cur_cap;
+	unsigned int offset;
+	unsigned int counter = 0;
+
+	offset = snd_hdac_chip_readl(bus, LLCH);
+
+	/* Lets walk the linked capabilities list */
+	do {
+		cur_cap = _snd_hdac_chip_read(l, bus, offset);
+
+		dev_dbg(bus->dev, "Capability version: 0x%x\n",
+			(cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF);
+
+		dev_dbg(bus->dev, "HDA capability ID: 0x%x\n",
+			(cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF);
+
+		switch ((cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF) {
+		case AZX_ML_CAP_ID:
+			dev_dbg(bus->dev, "Found ML capability\n");
+			bus->mlcap = bus->remap_addr + offset;
+			break;
+
+		case AZX_GTS_CAP_ID:
+			dev_dbg(bus->dev, "Found GTS capability offset=%x\n", offset);
+			bus->gtscap = bus->remap_addr + offset;
+			break;
+
+		case AZX_PP_CAP_ID:
+			/* PP capability found, the Audio DSP is present */
+			dev_dbg(bus->dev, "Found PP capability offset=%x\n", offset);
+			bus->ppcap = bus->remap_addr + offset;
+			break;
+
+		case AZX_SPB_CAP_ID:
+			/* SPIB capability found, handler function */
+			dev_dbg(bus->dev, "Found SPB capability\n");
+			bus->spbcap = bus->remap_addr + offset;
+			break;
+
+		case AZX_DRSM_CAP_ID:
+			/* DMA resume  capability found, handler function */
+			dev_dbg(bus->dev, "Found DRSM capability\n");
+			bus->drsmcap = bus->remap_addr + offset;
+			break;
+
+		default:
+			dev_dbg(bus->dev, "Unknown capability %d\n", cur_cap);
+			break;
+		}
+
+		counter++;
+
+		if (counter > HDAC_MAX_CAPS) {
+			dev_err(bus->dev, "We exceeded HDAC capabilities!!!\n");
+			break;
+		}
+
+		/* read the offset of next capability */
+		offset = cur_cap & AZX_CAP_HDR_NXT_PTR_MASK;
+
+	} while (offset);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_hdac_bus_parse_capabilities);
+
 /*
  * Lowlevel interface
  */
-- 
1.9.1
