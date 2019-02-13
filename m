From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 03/14] ASoC: SOF: Add driver debug support.
Date: Wed, 13 Feb 2019 16:07:23 -0600
Message-ID: <20190213220734.10471-4-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add debugFS files that can be used to expose DSP memories and
and peripherals to userspace to assist with firmware debugging.

Since we cannot rely on debugFS, errors are logged but don't stop
execution.

When a resource cannot be read in D3, it is optionally cached on
suspend. Copying memories from IO will increase the suspend latency,
this should only used in engineering builds w/ debug options. This
part will have to be enhanced when support for D0ix states is
provided, currently only D0 and D3 are supported.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/debug.c | 219 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 sound/soc/sof/debug.c

diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
new file mode 100644
index 000000000000..83871f3ac2a1
--- /dev/null
+++ b/sound/soc/sof/debug.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//
+// Generic debug routines used to export DSP MMIO and memories to userspace
+// for firmware debugging.
+//
+
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include "sof-priv.h"
+#include "ops.h"
+
+static ssize_t sof_dfsentry_read(struct file *file, char __user *buffer,
+				 size_t count, loff_t *ppos)
+{
+	struct snd_sof_dfsentry *dfse = file->private_data;
+	struct snd_sof_dev *sdev = dfse->sdev;
+	struct dentry *dfsentry = dfse->dfsentry;
+	int size;
+	u32 *buf;
+	loff_t pos = *ppos;
+	size_t size_ret;
+
+	size = dfse->size;
+
+	/* validate position & count */
+	if (pos < 0)
+		return -EINVAL;
+	if (pos >= size || !count)
+		return 0;
+	/* find the minimum. min() is not used since it adds sparse warnings */
+	if (count > size - pos)
+		count = size - pos;
+
+	/* intermediate buffer size must be u32 multiple */
+	size = round_up(count, 4);
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (dfse->type == SOF_DFSENTRY_TYPE_IOMEM) {
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
+		/*
+		 * If the DSP is active: copy from IO.
+		 * If the DSP is suspended:
+		 *	- Copy from IO if the memory is always accessible.
+		 *	- Otherwise, copy from cached buffer.
+		 */
+		if (pm_runtime_active(sdev->dev) ||
+		    dfse->access_type == SOF_DEBUGFS_ACCESS_ALWAYS) {
+			memcpy_fromio(buf, dfse->io_mem + pos, size);
+		} else {
+			dev_info(sdev->dev,
+				 "Copying cached debugfs data\n");
+			memcpy(buf, dfse->cache_buf + pos, size);
+		}
+#else
+		/* if the DSP is in D3 */
+		if (!pm_runtime_active(sdev->dev) &&
+		    dfse->access_type == SOF_DEBUGFS_ACCESS_D0_ONLY) {
+			dev_err(sdev->dev,
+				"error: debugfs entry %s cannot be read in DSP D3\n",
+				dfsentry->d_name.name);
+			return -EINVAL;
+		}
+
+		memcpy_fromio(buf, dfse->io_mem + pos, size);
+#endif
+	} else {
+		memcpy(buf, dfse->buf + pos, size);
+	}
+
+	/* copy to userspace */
+	size_ret = copy_to_user(buffer, buf, count);
+	kfree(buf);
+
+	/* update count & position if copy succeeded */
+	if (size_ret == count)
+		return -EFAULT;
+	count -= size_ret;
+	*ppos = pos + count;
+
+	return count;
+}
+
+static const struct file_operations sof_dfs_fops = {
+	.open = simple_open,
+	.read = sof_dfsentry_read,
+	.llseek = default_llseek,
+};
+
+/* create FS entry for debug files that can expose DSP memories, registers */
+int snd_sof_debugfs_io_item(struct snd_sof_dev *sdev,
+			    void __iomem *base, size_t size,
+			    const char *name,
+			    enum sof_debugfs_access_type access_type)
+{
+	struct snd_sof_dfsentry *dfse;
+
+	if (!sdev)
+		return -EINVAL;
+
+	dfse = devm_kzalloc(sdev->dev, sizeof(*dfse), GFP_KERNEL);
+	if (!dfse)
+		return -ENOMEM;
+
+	dfse->type = SOF_DFSENTRY_TYPE_IOMEM;
+	dfse->io_mem = base;
+	dfse->size = size;
+	dfse->sdev = sdev;
+	dfse->access_type = access_type;
+
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE)
+	/*
+	 * allocate cache buffer that will be used to save the mem window
+	 * contents prior to suspend
+	 */
+	if (access_type == SOF_DEBUGFS_ACCESS_D0_ONLY) {
+		dfse->cache_buf = devm_kzalloc(sdev->dev, size, GFP_KERNEL);
+		if (!dfse->cache_buf)
+			return -ENOMEM;
+	}
+#endif
+
+	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
+					     dfse, &sof_dfs_fops);
+	if (!dfse->dfsentry) {
+		/* can't rely on debugfs, only log error and keep going */
+		dev_err(sdev->dev, "error: cannot create debugfs entry %s\n",
+			name);
+	} else {
+		/* add to dfsentry list */
+		list_add(&dfse->list, &sdev->dfsentry_list);
+
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sof_debugfs_io_item);
+
+/* create FS entry for debug files to expose kernel memory */
+int snd_sof_debugfs_buf_item(struct snd_sof_dev *sdev,
+			     void *base, size_t size,
+			     const char *name)
+{
+	struct snd_sof_dfsentry *dfse;
+
+	if (!sdev)
+		return -EINVAL;
+
+	dfse = devm_kzalloc(sdev->dev, sizeof(*dfse), GFP_KERNEL);
+	if (!dfse)
+		return -ENOMEM;
+
+	dfse->type = SOF_DFSENTRY_TYPE_BUF;
+	dfse->buf = base;
+	dfse->size = size;
+	dfse->sdev = sdev;
+
+	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
+					     dfse, &sof_dfs_fops);
+	if (!dfse->dfsentry) {
+		/* can't rely on debugfs, only log error and keep going */
+		dev_err(sdev->dev, "error: cannot create debugfs entry %s\n",
+			name);
+	} else {
+		/* add to dfsentry list */
+		list_add(&dfse->list, &sdev->dfsentry_list);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sof_debugfs_buf_item);
+
+int snd_sof_dbg_init(struct snd_sof_dev *sdev)
+{
+	const struct snd_sof_dsp_ops *ops = sof_ops(sdev);
+	const struct snd_sof_debugfs_map *map;
+	int i;
+	int err;
+
+	/* use "sof" as top level debugFS dir */
+	sdev->debugfs_root = debugfs_create_dir("sof", NULL);
+	if (IS_ERR_OR_NULL(sdev->debugfs_root)) {
+		dev_err(sdev->dev, "error: failed to create debugfs directory\n");
+		return 0;
+	}
+
+	/* init dfsentry list */
+	INIT_LIST_HEAD(&sdev->dfsentry_list);
+
+	/* create debugFS files for platform specific MMIO/DSP memories */
+	for (i = 0; i < ops->debug_map_count; i++) {
+		map = &ops->debug_map[i];
+
+		err = snd_sof_debugfs_io_item(sdev, sdev->bar[map->bar] +
+					      map->offset, map->size,
+					      map->name, map->access_type);
+		/* errors are only due to memory allocation, not debugfs */
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_sof_dbg_init);
+
+void snd_sof_free_debug(struct snd_sof_dev *sdev)
+{
+	debugfs_remove_recursive(sdev->debugfs_root);
+}
+EXPORT_SYMBOL_GPL(snd_sof_free_debug);
-- 
2.17.1
