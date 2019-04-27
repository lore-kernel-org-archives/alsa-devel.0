From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Intel: Add hda-bus support and
	initialization" to the asoc tree
Date: Sat, 27 Apr 2019 18:52:44 +0100 (BST)
Message-ID: <20190427175244.14F34441D3C@finisterre.ee.mobilebroadband>
References: <20190412160904.30418-11-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160904.30418-11-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Keyon Jie <yang.jie@linux.intel.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, tiwai@suse.de, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Intel: Add hda-bus support and initialization

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 78ad1f07a49a56fa3714ee36573133a39e32593d Mon Sep 17 00:00:00 2001
From: Keyon Jie <yang.jie@linux.intel.com>
Date: Fri, 12 Apr 2019 11:08:53 -0500
Subject: [PATCH] ASoC: SOF: Intel: Add hda-bus support and initialization

Use hdac_io_ops and configure all required spin_locks/mutex to use
hdac_hda_ext library. Keep the code conditional so that the HDA link
and audio codec support can be removed.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/hda-bus.c | 108 ++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-bus.c

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
new file mode 100644
index 000000000000..62cc9921bb55
--- /dev/null
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Keyon Jie <yang.jie@linux.intel.com>
+
+#include <linux/io.h>
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
2.20.1
