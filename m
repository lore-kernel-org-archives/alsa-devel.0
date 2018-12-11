From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 10/21] ASoC: SOF: Intel: Add hda-bus support
	and initialization
Date: Tue, 11 Dec 2018 15:30:18 -0600
Message-ID: <20181211213029.28801-11-pierre-louis.bossart@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

Use hdac_io_ops and configure all required spin_locks/mutex to use
hdac_hda_ext library. Keep the code conditional so that the HDA link
and audio codec support can be removed.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-bus.c | 107 ++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-bus.c

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
new file mode 100644
index 000000000000..cadf559f5a82
--- /dev/null
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Keyon Jie <yang.jie@linux.intel.com>
+
+#include <sound/hdaudio.h>
+#include "../sof-priv.h"
+#include "hda.h"
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+
+static const struct hdac_bus_ops bus_ops = {
+	.command = snd_hdac_bus_send_cmd,
+	.get_response = snd_hdac_bus_get_response,
+};
+
+#endif
+
+static void sof_hda_writel(u32 value, u32 __iomem *addr)
+{
+	writel(value, addr);
+}
+
+static u32 sof_hda_readl(u32 __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void sof_hda_writew(u16 value, u16 __iomem *addr)
+{
+	writew(value, addr);
+}
+
+static u16 sof_hda_readw(u16 __iomem *addr)
+{
+	return readw(addr);
+}
+
+static void sof_hda_writeb(u8 value, u8 __iomem *addr)
+{
+	writeb(value, addr);
+}
+
+static u8 sof_hda_readb(u8 __iomem *addr)
+{
+	return readb(addr);
+}
+
+static int sof_hda_dma_alloc_pages(struct hdac_bus *bus, int type,
+				   size_t size, struct snd_dma_buffer *buf)
+{
+	return snd_dma_alloc_pages(type, bus->dev, size, buf);
+}
+
+static void sof_hda_dma_free_pages(struct hdac_bus *bus,
+				   struct snd_dma_buffer *buf)
+{
+	snd_dma_free_pages(buf);
+}
+
+static const struct hdac_io_ops io_ops = {
+	.reg_writel = sof_hda_writel,
+	.reg_readl = sof_hda_readl,
+	.reg_writew = sof_hda_writew,
+	.reg_readw = sof_hda_readw,
+	.reg_writeb = sof_hda_writeb,
+	.reg_readb = sof_hda_readb,
+	.dma_alloc_pages = sof_hda_dma_alloc_pages,
+	.dma_free_pages = sof_hda_dma_free_pages,
+};
+
+/*
+ * This can be used for both with/without hda link support.
+ */
+void sof_hda_bus_init(struct hdac_bus *bus, struct device *dev,
+		      const struct hdac_ext_bus_ops *ext_ops)
+{
+	static int idx;
+
+	memset(bus, 0, sizeof(*bus));
+	bus->dev = dev;
+
+	bus->io_ops = &io_ops;
+	INIT_LIST_HEAD(&bus->stream_list);
+
+	bus->irq = -1;
+	bus->ext_ops = ext_ops;
+	bus->idx = idx++;
+
+	spin_lock_init(&bus->reg_lock);
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	INIT_LIST_HEAD(&bus->codec_list);
+	INIT_LIST_HEAD(&bus->hlink_list);
+
+	mutex_init(&bus->cmd_mutex);
+	mutex_init(&bus->lock);
+	bus->ops = &bus_ops;
+	INIT_WORK(&bus->unsol_work, snd_hdac_bus_process_unsol_events);
+	bus->cmd_dma_state = true;
+#endif
+
+}
-- 
2.17.1
