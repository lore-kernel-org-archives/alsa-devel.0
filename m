From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 14/14] ASoC: SOF: Add utils
Date: Wed, 13 Feb 2019 16:07:34 -0600
Message-ID: <20190213220734.10471-15-pierre-louis.bossart@linux.intel.com>
References: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220734.10471-1-pierre-louis.bossart@linux.intel.com>
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

Helpers to set-up back-ends, create platform devices and common
IO/block read/write operations

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/utils.c | 109 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 sound/soc/sof/utils.c

diff --git a/sound/soc/sof/utils.c b/sound/soc/sof/utils.c
new file mode 100644
index 000000000000..9ade9aa30ab5
--- /dev/null
+++ b/sound/soc/sof/utils.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Keyon Jie <yang.jie@linux.intel.com>
+//
+
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/platform_device.h>
+#include <sound/soc.h>
+#include <sound/sof.h>
+#include "sof-priv.h"
+
+/*
+ * Register IO
+ */
+
+void sof_io_write(struct snd_sof_dev *sdev, void __iomem *addr, u32 value)
+{
+	writel(value, addr);
+}
+EXPORT_SYMBOL(sof_io_write);
+
+u32 sof_io_read(struct snd_sof_dev *sdev, void __iomem *addr)
+{
+	return readl(addr);
+}
+EXPORT_SYMBOL(sof_io_read);
+
+void sof_io_write64(struct snd_sof_dev *sdev, void __iomem *addr, u64 value)
+{
+	writeq(value, addr);
+}
+EXPORT_SYMBOL(sof_io_write64);
+
+u64 sof_io_read64(struct snd_sof_dev *sdev, void __iomem *addr)
+{
+	return readq(addr);
+}
+EXPORT_SYMBOL(sof_io_read64);
+
+/*
+ * IPC Mailbox IO
+ */
+
+void sof_mailbox_write(struct snd_sof_dev *sdev, u32 offset,
+		       void *message, size_t bytes)
+{
+	void __iomem *dest = sdev->bar[sdev->mailbox_bar] + offset;
+
+	memcpy_toio(dest, message, bytes);
+}
+EXPORT_SYMBOL(sof_mailbox_write);
+
+void sof_mailbox_read(struct snd_sof_dev *sdev, u32 offset,
+		      void *message, size_t bytes)
+{
+	void __iomem *src = sdev->bar[sdev->mailbox_bar] + offset;
+
+	memcpy_fromio(message, src, bytes);
+}
+EXPORT_SYMBOL(sof_mailbox_read);
+
+/*
+ * Memory copy.
+ */
+
+void sof_block_write(struct snd_sof_dev *sdev, u32 bar, u32 offset, void *src,
+		     size_t size)
+{
+	void __iomem *dest = sdev->bar[bar] + offset;
+	const u8 *src_byte = src;
+	u32 affected_mask;
+	u32 tmp;
+	int m, n;
+
+	m = size / 4;
+	n = size % 4;
+
+	/* __iowrite32_copy use 32bit size values so divide by 4 */
+	__iowrite32_copy(dest, src, m);
+
+	if (n) {
+		affected_mask = (1 << (8 * n)) - 1;
+
+		/* first read the 32bit data of dest, then change affected
+		 * bytes, and write back to dest. For unaffected bytes, it
+		 * should not be changed
+		 */
+		tmp = ioread32(dest + m * 4);
+		tmp &= ~affected_mask;
+
+		tmp |= *(u32 *)(src_byte + m * 4) & affected_mask;
+		iowrite32(tmp, dest + m * 4);
+	}
+}
+EXPORT_SYMBOL(sof_block_write);
+
+void sof_block_read(struct snd_sof_dev *sdev, u32 bar, u32 offset, void *dest,
+		    size_t size)
+{
+	void __iomem *src = sdev->bar[bar] + offset;
+
+	memcpy_fromio(dest, src, size);
+}
+EXPORT_SYMBOL(sof_block_read);
-- 
2.17.1
