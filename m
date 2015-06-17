From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ALSA: HDA: provide default bus io ops
	extended hdac
Date: Wed, 17 Jun 2015 11:20:18 +0530
Message-ID: <1434520218-14556-3-git-send-email-vinod.koul@intel.com>
References: <1434520218-14556-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 26872265AA0
 for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2015 07:48:50 +0200 (CEST)
In-Reply-To: <1434520218-14556-1-git-send-email-vinod.koul@intel.com>
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

A typical io ops use simple io accessors which can be common for most
drivers, so provide a default ops which will be used if driver doesn't
provide one

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/ext/hdac_ext_bus.c | 59 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index f1100354c591..0aa5d9eb6c3f 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -24,12 +24,65 @@
 MODULE_DESCRIPTION("HDA extended core");
 MODULE_LICENSE("GPL v2");
 
+static void hdac_ext_writel(u32 value, u32 __iomem *addr)
+{
+	writel(value, addr);
+}
+
+static u32 hdac_ext_readl(u32 __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void hdac_ext_writew(u16 value, u16 __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static u16 hdac_ext_readw(u16 __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void hdac_ext_writeb(u8 value, u8 __iomem *addr)
+{
+	writeb(value, addr);
+}
+
+static u8 hdac_ext_readb(u8 __iomem *addr)
+{
+	return readb(addr);
+}
+
+static int hdac_ext_dma_alloc_pages(struct hdac_bus *bus, int type,
+			   size_t size, struct snd_dma_buffer *buf)
+{
+	return snd_dma_alloc_pages(type, bus->dev, size, buf);
+}
+
+static void hdac_ext_dma_free_pages(struct hdac_bus *bus, struct snd_dma_buffer *buf)
+{
+	snd_dma_free_pages(buf);
+}
+
+static const struct hdac_io_ops hdac_ext_default_io = {
+	.reg_writel = hdac_ext_writel,
+	.reg_readl = hdac_ext_readl,
+	.reg_writew = hdac_ext_writew,
+	.reg_readw = hdac_ext_readw,
+	.reg_writeb = hdac_ext_writeb,
+	.reg_readb = hdac_ext_readb,
+	.dma_alloc_pages = hdac_ext_dma_alloc_pages,
+	.dma_free_pages = hdac_ext_dma_free_pages,
+};
+
 /**
  * snd_hdac_ext_bus_init - initialize a HD-audio extended bus
  * @ebus: the pointer to extended bus object
  * @dev: device pointer
  * @ops: bus verb operators
- * @io_ops: lowlevel I/O operators
+ * @io_ops: lowlevel I/O operators, can be NULL. If NULL core will use
+ * default ops
  *
  * Returns 0 if successful, or a negative error code.
  */
@@ -40,6 +93,10 @@ int snd_hdac_ext_bus_init(struct hdac_ext_bus *ebus, struct device *dev,
 	int ret;
 	static int idx;
 
+	/* check if io ops are provided, if not load the defaults */
+	if (io_ops == NULL)
+		io_ops = &hdac_ext_default_io;
+
 	ret = snd_hdac_bus_init(&ebus->bus, dev, ops, io_ops);
 	if (ret < 0)
 		return ret;
-- 
1.9.1
