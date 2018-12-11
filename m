From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 14/14] ASoC: SOF: Add utils
Date: Tue, 11 Dec 2018 15:23:18 -0600
Message-ID: <20181211212318.28644-15-pierre-louis.bossart@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
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
 sound/soc/sof/utils.c | 173 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)
 create mode 100644 sound/soc/sof/utils.c

diff --git a/sound/soc/sof/utils.c b/sound/soc/sof/utils.c
new file mode 100644
index 000000000000..bf66e14bc258
--- /dev/null
+++ b/sound/soc/sof/utils.c
@@ -0,0 +1,173 @@
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
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <sound/soc.h>
+#include <sound/sof.h>
+#include "sof-priv.h"
+
+int sof_bes_setup(struct device *dev, struct snd_sof_dsp_ops *ops,
+		  struct snd_soc_dai_link *links, int link_num,
+		  struct snd_soc_card *card)
+{
+	char name[32];
+	int i;
+
+	if (!ops || !links || !card)
+		return -EINVAL;
+
+	/* set up BE dai_links */
+	for (i = 0; i < link_num; i++) {
+		snprintf(name, 32, "NoCodec-%d", i);
+		links[i].name = devm_kstrdup(dev, name, GFP_KERNEL);
+		if (!links[i].name)
+			return -ENOMEM;
+
+		links[i].id = i;
+		links[i].no_pcm = 1;
+		links[i].cpu_dai_name = ops->drv[i].name;
+		links[i].platform_name = "sof-audio";
+		links[i].codec_dai_name = "snd-soc-dummy-dai";
+		links[i].codec_name = "snd-soc-dummy";
+		links[i].dpcm_playback = 1;
+		links[i].dpcm_capture = 1;
+	}
+
+	card->dai_link = links;
+	card->num_links = link_num;
+
+	return 0;
+}
+EXPORT_SYMBOL(sof_bes_setup);
+
+/* register sof platform device */
+int sof_create_platform_device(struct sof_platform_priv *priv)
+{
+	struct snd_sof_pdata *sof_pdata = priv->sof_pdata;
+	struct device *dev = sof_pdata->dev;
+
+	priv->pdev_pcm =
+		platform_device_register_data(dev, "sof-audio", -1,
+					      sof_pdata, sizeof(*sof_pdata));
+	if (IS_ERR(priv->pdev_pcm)) {
+		dev_err(dev, "error: cannot register device sof-audio. Error %d\n",
+			(int)PTR_ERR(priv->pdev_pcm));
+		return PTR_ERR(priv->pdev_pcm);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(sof_create_platform_device);
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
+#ifdef CONFIG_64BIT
+	writeq(value, addr);
+#else
+	memcpy_toio(addr, &value, sizeof(value));
+#endif
+}
+EXPORT_SYMBOL(sof_io_write64);
+
+u64 sof_io_read64(struct snd_sof_dev *sdev, void __iomem *addr)
+{
+#ifdef CONFIG_64BIT
+	return readq(addr);
+#else
+	u64 val;
+
+	memcpy_fromio(&val, addr, sizeof(val));
+	return val;
+#endif
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
+void sof_block_write(struct snd_sof_dev *sdev, u32 offset, void *src,
+		     size_t size)
+{
+	void __iomem *dest = sdev->bar[sdev->mmio_bar] + offset;
+	const u8 *src_byte = src;
+	u32 affected_mask;
+	u32 tmp = 0;
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
+		__ioread32_copy(&tmp, dest + m * 4, 1);
+		tmp &= ~affected_mask;
+
+		tmp |= *(u32 *)(src_byte + m * 4) & affected_mask;
+		__iowrite32_copy(dest + m * 4, &tmp, 1);
+	}
+}
+EXPORT_SYMBOL(sof_block_write);
+
+void sof_block_read(struct snd_sof_dev *sdev, u32 offset, void *dest,
+		    size_t size)
+{
+	void __iomem *src = sdev->bar[sdev->mmio_bar] + offset;
+
+	memcpy_fromio(dest, src, size);
+}
+EXPORT_SYMBOL(sof_block_read);
-- 
2.17.1
