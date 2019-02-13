From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 08/14] ASoC: SOF: Add DSP HW abstraction
	operations
Date: Wed, 13 Feb 2019 16:07:28 -0600
Message-ID: <20190213220734.10471-9-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add operation pointers that can be called by core to control a wide
variety of DSP targets. The DSP HW drivers will fill in these
operations.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.c | 204 ++++++++++++++++++++++
 sound/soc/sof/ops.h | 414 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 618 insertions(+)
 create mode 100644 sound/soc/sof/ops.c
 create mode 100644 sound/soc/sof/ops.h

diff --git a/sound/soc/sof/ops.c b/sound/soc/sof/ops.c
new file mode 100644
index 000000000000..3dcdeb75fdd1
--- /dev/null
+++ b/sound/soc/sof/ops.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//
+
+#include <linux/pci.h>
+#include "ops.h"
+
+int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
+				     u32 mask, u32 value)
+{
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	unsigned int old, new;
+	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */
+
+	pci_read_config_dword(pci, offset, &ret);
+	old = ret;
+	dev_dbg(sdev->dev, "Debug PCIR: %8.8x at  %8.8x\n", old & mask, offset);
+
+	new = (old & (~mask)) | (value & mask);
+
+	if (old == new)
+		return false;
+
+	pci_write_config_dword(pci, offset, new);
+	dev_dbg(sdev->dev, "Debug PCIW: %8.8x at  %8.8x\n", value,
+		offset);
+
+	return true;
+}
+EXPORT_SYMBOL(snd_sof_pci_update_bits_unlocked);
+
+int snd_sof_pci_update_bits(struct snd_sof_dev *sdev, u32 offset,
+			    u32 mask, u32 value)
+{
+	unsigned long flags;
+	bool change;
+
+	spin_lock_irqsave(&sdev->hw_lock, flags);
+	change = snd_sof_pci_update_bits_unlocked(sdev, offset, mask, value);
+	spin_unlock_irqrestore(&sdev->hw_lock, flags);
+	return change;
+}
+EXPORT_SYMBOL(snd_sof_pci_update_bits);
+
+int snd_sof_dsp_update_bits_unlocked(struct snd_sof_dev *sdev, u32 bar,
+				     u32 offset, u32 mask, u32 value)
+{
+	unsigned int old, new;
+	u32 ret;
+
+	ret = snd_sof_dsp_read(sdev, bar, offset);
+
+	old = ret;
+	new = (old & (~mask)) | (value & mask);
+
+	if (old == new)
+		return false;
+
+	snd_sof_dsp_write(sdev, bar, offset, new);
+
+	return true;
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits_unlocked);
+
+int snd_sof_dsp_update_bits64_unlocked(struct snd_sof_dev *sdev, u32 bar,
+				       u32 offset, u64 mask, u64 value)
+{
+	u64 old, new;
+
+	old = snd_sof_dsp_read64(sdev, bar, offset);
+
+	new = (old & (~mask)) | (value & mask);
+
+	if (old == new)
+		return false;
+
+	snd_sof_dsp_write64(sdev, bar, offset, new);
+
+	return true;
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits64_unlocked);
+
+/* This is for registers bits with attribute RWC */
+void snd_sof_dsp_update_bits_forced_unlocked(struct snd_sof_dev *sdev, u32 bar,
+					     u32 offset, u32 mask, u32 value)
+{
+	unsigned int old, new;
+	u32 ret;
+
+	ret = snd_sof_dsp_read(sdev, bar, offset);
+
+	old = ret;
+	new = (old & (~mask)) | (value & mask);
+
+	snd_sof_dsp_write(sdev, bar, offset, new);
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits_forced_unlocked);
+
+int snd_sof_dsp_update_bits(struct snd_sof_dev *sdev, u32 bar, u32 offset,
+			    u32 mask, u32 value)
+{
+	unsigned long flags;
+	bool change;
+
+	spin_lock_irqsave(&sdev->hw_lock, flags);
+	change = snd_sof_dsp_update_bits_unlocked(sdev, bar, offset, mask,
+						  value);
+	spin_unlock_irqrestore(&sdev->hw_lock, flags);
+	return change;
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits);
+
+int snd_sof_dsp_update_bits64(struct snd_sof_dev *sdev, u32 bar, u32 offset,
+			      u64 mask, u64 value)
+{
+	unsigned long flags;
+	bool change;
+
+	spin_lock_irqsave(&sdev->hw_lock, flags);
+	change = snd_sof_dsp_update_bits64_unlocked(sdev, bar, offset, mask,
+						    value);
+	spin_unlock_irqrestore(&sdev->hw_lock, flags);
+	return change;
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits64);
+
+/* This is for registers bits with attribute RWC */
+void snd_sof_dsp_update_bits_forced(struct snd_sof_dev *sdev, u32 bar,
+				    u32 offset, u32 mask, u32 value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sdev->hw_lock, flags);
+	snd_sof_dsp_update_bits_forced_unlocked(sdev, bar, offset, mask, value);
+	spin_unlock_irqrestore(&sdev->hw_lock, flags);
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits_forced);
+
+int snd_sof_dsp_register_poll(struct snd_sof_dev *sdev, u32 bar, u32 offset,
+			      u32 mask, u32 target, u32 timeout_ms,
+			      u32 interval_us)
+{
+	u32 reg;
+	unsigned long tout_jiff;
+	int k = 0, s = interval_us;
+
+	/*
+	 * Split the loop into 2 sleep stages with varying resolution.
+	 * To do it more accurately, the range of wakeups are:
+	 * In case of interval_us = 500,
+	 * Phase 1(first 5ms): min sleep 0.5ms; max sleep 1ms.
+	 * Phase 2(beyond 5ms): min sleep 5ms; max sleep 10ms.
+	 */
+
+	tout_jiff = jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		reg = snd_sof_dsp_read(sdev, bar, offset);
+		if ((reg & mask) == target)
+			break;
+
+		/* Phase 2 after 5ms(500us * 10) */
+		if (++k > 10)
+			s = interval_us * 10;
+
+		usleep_range(s, 2 * s);
+	} while (time_before(jiffies, tout_jiff));
+
+	if ((reg & mask) == target) {
+		dev_dbg(sdev->dev, "FW Poll Status: reg=%#x successful\n", reg);
+
+		return 0;
+	}
+
+	dev_dbg(sdev->dev, "FW Poll Status: reg=%#x timedout\n", reg);
+	return -ETIME;
+}
+EXPORT_SYMBOL(snd_sof_dsp_register_poll);
+
+void snd_sof_dsp_panic(struct snd_sof_dev *sdev, u32 offset)
+{
+	dev_err(sdev->dev, "error : DSP panic!\n");
+
+	/*
+	 * check if DSP is not ready and did not set the dsp_oops_offset.
+	 * if the dsp_oops_offset is not set, set it from the panic message.
+	 * Also add a check to memory window setting with panic message.
+	 */
+	if (!sdev->dsp_oops_offset)
+		sdev->dsp_oops_offset = offset;
+	else
+		dev_dbg(sdev->dev, "panic: dsp_oops_offset %zu offset %d\n",
+			sdev->dsp_oops_offset, offset);
+
+	snd_sof_dsp_dbg_dump(sdev, SOF_DBG_REGS | SOF_DBG_MBOX);
+	snd_sof_trace_notify_for_error(sdev);
+	snd_sof_dsp_cmd_done(sdev, SOF_IPC_HOST_REPLY);
+}
+EXPORT_SYMBOL(snd_sof_dsp_panic);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
new file mode 100644
index 000000000000..c6374f0210e9
--- /dev/null
+++ b/sound/soc/sof/ops.h
@@ -0,0 +1,414 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2018 Intel Corporation. All rights reserved.
+ *
+ * Author: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+ */
+
+#ifndef __SOUND_SOC_SOF_IO_H
+#define __SOUND_SOC_SOF_IO_H
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <sound/pcm.h>
+#include "sof-priv.h"
+
+#define sof_ops(sdev) \
+	((sdev)->pdata->desc->ops)
+
+/* init */
+static inline int snd_sof_probe(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->probe)
+		return sof_ops(sdev)->probe(sdev);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+static inline int snd_sof_remove(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->remove)
+		return sof_ops(sdev)->remove(sdev);
+
+	return 0;
+}
+
+/* control */
+static inline int snd_sof_dsp_run(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->run)
+		return sof_ops(sdev)->run(sdev);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+static inline int snd_sof_dsp_stall(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->stall)
+		return sof_ops(sdev)->stall(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_reset(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->reset)
+		return sof_ops(sdev)->reset(sdev);
+
+	return 0;
+}
+
+/* dsp core power up/power down */
+static inline int snd_sof_dsp_core_power_up(struct snd_sof_dev *sdev,
+					    unsigned int core_mask)
+{
+	if (sof_ops(sdev)->core_power_up)
+		return sof_ops(sdev)->core_power_up(sdev, core_mask);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_core_power_down(struct snd_sof_dev *sdev,
+					      unsigned int core_mask)
+{
+	if (sof_ops(sdev)->core_power_down)
+		return sof_ops(sdev)->core_power_down(sdev, core_mask);
+
+	return 0;
+}
+
+/* pre/post fw load */
+static inline int snd_sof_dsp_pre_fw_run(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->pre_fw_run)
+		return sof_ops(sdev)->pre_fw_run(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_post_fw_run(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->post_fw_run)
+		return sof_ops(sdev)->post_fw_run(sdev);
+
+	return 0;
+}
+
+/* power management */
+static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->resume)
+		return sof_ops(sdev)->resume(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_suspend(struct snd_sof_dev *sdev, int state)
+{
+	if (sof_ops(sdev)->suspend)
+		return sof_ops(sdev)->suspend(sdev, state);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_runtime_resume(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->runtime_resume)
+		return sof_ops(sdev)->runtime_resume(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_runtime_suspend(struct snd_sof_dev *sdev,
+					      int state)
+{
+	if (sof_ops(sdev)->runtime_suspend)
+		return sof_ops(sdev)->runtime_suspend(sdev, state);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_set_clk(struct snd_sof_dev *sdev, u32 freq)
+{
+	if (sof_ops(sdev)->set_clk)
+		return sof_ops(sdev)->set_clk(sdev, freq);
+
+	return 0;
+}
+
+/* debug */
+static inline void snd_sof_dsp_dbg_dump(struct snd_sof_dev *sdev, u32 flags)
+{
+	if (sof_ops(sdev)->dbg_dump)
+		return sof_ops(sdev)->dbg_dump(sdev, flags);
+}
+
+/* register IO */
+static inline void snd_sof_dsp_write(struct snd_sof_dev *sdev, u32 bar,
+				     u32 offset, u32 value)
+{
+	if (sof_ops(sdev)->write) {
+		sof_ops(sdev)->write(sdev, sdev->bar[bar] + offset, value);
+		return;
+	}
+
+	dev_err_ratelimited(sdev->dev, "error: %s not defined\n", __func__);
+}
+
+static inline void snd_sof_dsp_write64(struct snd_sof_dev *sdev, u32 bar,
+				       u32 offset, u64 value)
+{
+	if (sof_ops(sdev)->write64) {
+		sof_ops(sdev)->write64(sdev, sdev->bar[bar] + offset, value);
+		return;
+	}
+
+	dev_err_ratelimited(sdev->dev, "error: %s not defined\n", __func__);
+}
+
+static inline u32 snd_sof_dsp_read(struct snd_sof_dev *sdev, u32 bar,
+				   u32 offset)
+{
+	if (sof_ops(sdev)->read)
+		return sof_ops(sdev)->read(sdev, sdev->bar[bar] + offset);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+static inline u64 snd_sof_dsp_read64(struct snd_sof_dev *sdev, u32 bar,
+				     u32 offset)
+{
+	if (sof_ops(sdev)->read64)
+		return sof_ops(sdev)->read64(sdev, sdev->bar[bar] + offset);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+/* block IO */
+static inline void snd_sof_dsp_block_read(struct snd_sof_dev *sdev, u32 bar,
+					  u32 offset, void *dest, size_t bytes)
+{
+	if (sof_ops(sdev)->block_read) {
+		sof_ops(sdev)->block_read(sdev, bar, offset, dest, bytes);
+		return;
+	}
+
+	dev_err_ratelimited(sdev->dev, "error: %s not defined\n", __func__);
+}
+
+static inline void snd_sof_dsp_block_write(struct snd_sof_dev *sdev, u32 bar,
+					   u32 offset, void *src, size_t bytes)
+{
+	if (sof_ops(sdev)->block_write) {
+		sof_ops(sdev)->block_write(sdev, bar, offset, src, bytes);
+		return;
+	}
+
+	dev_err_ratelimited(sdev->dev, "error: %s not defined\n", __func__);
+}
+
+/* mailbox */
+static inline void snd_sof_dsp_mailbox_read(struct snd_sof_dev *sdev,
+					    u32 offset, void *message,
+					    size_t bytes)
+{
+	if (sof_ops(sdev)->mailbox_read) {
+		sof_ops(sdev)->mailbox_read(sdev, offset, message, bytes);
+		return;
+	}
+
+	dev_err_ratelimited(sdev->dev, "error: %s not defined\n", __func__);
+}
+
+static inline void snd_sof_dsp_mailbox_write(struct snd_sof_dev *sdev,
+					     u32 offset, void *message,
+					     size_t bytes)
+{
+	if (sof_ops(sdev)->mailbox_write) {
+		sof_ops(sdev)->mailbox_write(sdev, offset, message, bytes);
+		return;
+	}
+
+	dev_err_ratelimited(sdev->dev, "error: %s not defined\n", __func__);
+}
+
+/* ipc */
+static inline int snd_sof_dsp_send_msg(struct snd_sof_dev *sdev,
+				       struct snd_sof_ipc_msg *msg)
+{
+	if (sof_ops(sdev)->send_msg)
+		return sof_ops(sdev)->send_msg(sdev, msg);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+static inline int snd_sof_dsp_get_reply(struct snd_sof_dev *sdev,
+					struct snd_sof_ipc_msg *msg)
+{
+	if (sof_ops(sdev)->get_reply)
+		return sof_ops(sdev)->get_reply(sdev, msg);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+static inline int snd_sof_dsp_is_ipc_ready(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->is_ipc_ready)
+		return sof_ops(sdev)->is_ipc_ready(sdev);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+static inline int snd_sof_dsp_cmd_done(struct snd_sof_dev *sdev,
+				       int dir)
+{
+	if (sof_ops(sdev)->cmd_done)
+		return sof_ops(sdev)->cmd_done(sdev, dir);
+
+	dev_err(sdev->dev, "error: %s not defined\n", __func__);
+	return -ENOTSUPP;
+}
+
+/* host DMA trace */
+static inline int snd_sof_dma_trace_init(struct snd_sof_dev *sdev,
+					 u32 *stream_tag)
+{
+	if (sof_ops(sdev)->trace_init)
+		return sof_ops(sdev)->trace_init(sdev, stream_tag);
+
+	return 0;
+}
+
+static inline int snd_sof_dma_trace_release(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev)->trace_release)
+		return sof_ops(sdev)->trace_release(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dma_trace_trigger(struct snd_sof_dev *sdev, int cmd)
+{
+	if (sof_ops(sdev)->trace_trigger)
+		return sof_ops(sdev)->trace_trigger(sdev, cmd);
+
+	return 0;
+}
+
+/* host PCM ops */
+static inline int
+snd_sof_pcm_platform_open(struct snd_sof_dev *sdev,
+			  struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_open)
+		return sof_ops(sdev)->pcm_open(sdev, substream);
+
+	return 0;
+}
+
+/* disconnect pcm substream to a host stream */
+static inline int
+snd_sof_pcm_platform_close(struct snd_sof_dev *sdev,
+			   struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_close)
+		return sof_ops(sdev)->pcm_close(sdev, substream);
+
+	return 0;
+}
+
+/* host stream hw params */
+static inline int
+snd_sof_pcm_platform_hw_params(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct sof_ipc_stream_params *ipc_params)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_hw_params)
+		return sof_ops(sdev)->pcm_hw_params(sdev, substream,
+						    params, ipc_params);
+
+	return 0;
+}
+
+/* host stream trigger */
+static inline int
+snd_sof_pcm_platform_trigger(struct snd_sof_dev *sdev,
+			     struct snd_pcm_substream *substream, int cmd)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_trigger)
+		return sof_ops(sdev)->pcm_trigger(sdev, substream, cmd);
+
+	return 0;
+}
+
+/* host stream pointer */
+static inline snd_pcm_uframes_t
+snd_sof_pcm_platform_pointer(struct snd_sof_dev *sdev,
+			     struct snd_pcm_substream *substream)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->pcm_pointer)
+		return sof_ops(sdev)->pcm_pointer(sdev, substream);
+
+	return 0;
+}
+
+static inline const struct snd_sof_dsp_ops
+*sof_get_ops(const struct sof_dev_desc *d,
+	     const struct sof_ops_table mach_ops[], int asize)
+{
+	int i;
+
+	for (i = 0; i < asize; i++) {
+		if (d == mach_ops[i].desc)
+			return mach_ops[i].ops;
+	}
+
+	/* not found */
+	return NULL;
+}
+
+int snd_sof_dsp_update_bits_unlocked(struct snd_sof_dev *sdev, u32 bar,
+				     u32 offset, u32 mask, u32 value);
+
+int snd_sof_dsp_update_bits64_unlocked(struct snd_sof_dev *sdev, u32 bar,
+				       u32 offset, u64 mask, u64 value);
+
+/* This is for registers bits with attribute RWC */
+void snd_sof_dsp_update_bits_forced_unlocked(struct snd_sof_dev *sdev, u32 bar,
+					     u32 offset, u32 mask, u32 value);
+
+int snd_sof_dsp_update_bits(struct snd_sof_dev *sdev, u32 bar, u32 offset,
+			    u32 mask, u32 value);
+
+int snd_sof_dsp_update_bits64(struct snd_sof_dev *sdev, u32 bar,
+			      u32 offset, u64 mask, u64 value);
+
+/* This is for registers bits with attribute RWC */
+void snd_sof_dsp_update_bits_forced(struct snd_sof_dev *sdev, u32 bar,
+				    u32 offset, u32 mask, u32 value);
+
+int snd_sof_pci_update_bits_unlocked(struct snd_sof_dev *sdev, u32 offset,
+				     u32 mask, u32 value);
+
+int snd_sof_pci_update_bits(struct snd_sof_dev *sdev, u32 offset,
+			    u32 mask, u32 value);
+
+int snd_sof_dsp_register_poll(struct snd_sof_dev *sdev, u32 bar, u32 offset,
+			      u32 mask, u32 target, u32 timeout_ms,
+			      u32 interval_us);
+
+void snd_sof_dsp_panic(struct snd_sof_dev *sdev, u32 offset);
+#endif
-- 
2.17.1
