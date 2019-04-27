From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: SOF: Add utils" to the asoc tree
Date: Sat, 27 Apr 2019 18:52:56 +0100 (BST)
Message-ID: <20190427175256.518F0441D3B@finisterre.ee.mobilebroadband>
References: <20190412160519.30207-15-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190412160519.30207-15-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Dragos Tarcatu <dragos_tarcatu@mentor.com>, Daniel Baluta <daniel.baluta@gmail.com>, sound-open-firmware@alsa-project.org, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Mark Brown <broonie@kernel.org>, andriy.shevchenko@linux.intel.com, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: SOF: Add utils

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

>From 3bafac46065eb7ea6f3e3fcbdb8b70b66f6c71b4 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Apr 2019 11:05:19 -0500
Subject: [PATCH] ASoC: SOF: Add utils

Helpers to set-up back-ends, create platform devices and common
IO/block read/write operations

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/utils.c | 112 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 sound/soc/sof/utils.c

diff --git a/sound/soc/sof/utils.c b/sound/soc/sof/utils.c
new file mode 100644
index 000000000000..2ac4c3da0320
--- /dev/null
+++ b/sound/soc/sof/utils.c
@@ -0,0 +1,112 @@
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
+ *
+ * The sof_io_xyz() wrappers are typically referenced in snd_sof_dsp_ops
+ * structures and cannot be inlined.
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
2.20.1
