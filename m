From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: hda - move bus_parse_capabilities to
	core" to the asoc tree
Date: Tue, 09 Aug 2016 13:44:21 +0100
Message-ID: <E1bX6OL-0003fs-L9@debutante>
References: <1470305764-20802-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19DA9267D34
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 14:44:28 +0200 (CEST)
In-Reply-To: <1470305764-20802-2-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: hda - move bus_parse_capabilities to core

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 6720b38420a01d40dbeb8ee575eb601d612de691 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 4 Aug 2016 15:46:00 +0530
Subject: [PATCH] ALSA: hda - move bus_parse_capabilities to core

HDA capability introduced recently are move to hdac core so that it can
be used by legacy driver as well. Also move the capability pointers up
to hdac_bus object.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
2.8.1
