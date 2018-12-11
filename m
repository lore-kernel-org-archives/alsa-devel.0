From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 08/14] ASoC: SOF: Add DSP HW abstraction
	operations
Date: Tue, 11 Dec 2018 15:23:12 -0600
Message-ID: <20181211212318.28644-9-pierre-louis.bossart@linux.intel.com>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add operation pointers that can be called by core to control a wide
variety of DSP targets. The DSP HW drivers will fill in these
operations.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ops.c | 200 +++++++++++++++++++++++
 sound/soc/sof/ops.h | 379 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 579 insertions(+)
 create mode 100644 sound/soc/sof/ops.c
 create mode 100644 sound/soc/sof/ops.h

diff --git a/sound/soc/sof/ops.c b/sound/soc/sof/ops.c
new file mode 100644
index 000000000000..41143fd97772
--- /dev/null
+++ b/sound/soc/sof/ops.c
@@ -0,0 +1,200 @@
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
+	bool change;
+	unsigned int old, new;
+	u32 ret = ~0; /* explicit init to remove uninitialized use warnings */
+
+	pci_read_config_dword(sdev->pci, offset, &ret);
+	dev_dbg(sdev->dev, "Debug PCIR: %8.8x at  %8.8x\n",
+		pci_read_config_dword(sdev->pci, offset, &ret), offset);
+
+	old = ret;
+	new = (old & (~mask)) | (value & mask);
+
+	change = (old != new);
+	if (change) {
+		pci_write_config_dword(sdev->pci, offset, new);
+		dev_dbg(sdev->dev, "Debug PCIW: %8.8x at  %8.8x\n", value,
+			offset);
+	}
+
+	return change;
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
+	bool change;
+	unsigned int old, new;
+	u32 ret;
+
+	ret = snd_sof_dsp_read(sdev, bar, offset);
+
+	old = ret;
+	new = (old & (~mask)) | (value & mask);
+
+	change = (old != new);
+	if (change)
+		snd_sof_dsp_write(sdev, bar, offset, new);
+
+	return change;
+}
+EXPORT_SYMBOL(snd_sof_dsp_update_bits_unlocked);
+
+int snd_sof_dsp_update_bits64_unlocked(struct snd_sof_dev *sdev, u32 bar,
+				       u32 offset, u64 mask, u64 value)
+{
+	bool change;
+	u64 old, new;
+
+	old = snd_sof_dsp_read64(sdev, bar, offset);
+
+	new = (old & (~mask)) | (value & mask);
+
+	change = (old != new);
+	if (change)
+		snd_sof_dsp_write64(sdev, bar, offset, new);
+
+	return change;
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
+			      u32 mask, u32 target, u32 timeout)
+{
+	int time, ret;
+
+	/*
+	 * we will poll for couple of ms using mdelay, if not successful
+	 * then go to longer sleep using usleep_range
+	 */
+
+	/* check if set state successful */
+	for (time = 5; time > 0; time--) {
+		if ((snd_sof_dsp_read(sdev, bar, offset) & mask) == target)
+			break;
+		msleep(20);
+	}
+
+	if (!time) {
+		/* sleeping in 10ms steps so adjust timeout value */
+		timeout /= 10;
+
+		for (time = timeout; time > 0; time--) {
+			if ((snd_sof_dsp_read(sdev, bar, offset) & mask) ==
+				target)
+				break;
+
+			usleep_range(5000, 10000);
+		}
+	}
+
+	ret = time ? 0 : -ETIME;
+
+	return ret;
+}
+EXPORT_SYMBOL(snd_sof_dsp_register_poll);
+
+void snd_sof_dsp_panic(struct snd_sof_dev *sdev, u32 offset)
+{
+	dev_err(sdev->dev, "error : DSP panic!\n");
+
+	/* check if DSP is not ready and did not set the dsp_oops_offset.
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
index 000000000000..405e39155645
--- /dev/null
+++ b/sound/soc/sof/ops.h
@@ -0,0 +1,379 @@
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
+/* init */
+static inline int snd_sof_probe(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->probe)
+		return sdev->ops->probe(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_remove(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->remove)
+		return sdev->ops->remove(sdev);
+
+	return 0;
+}
+
+/* control */
+static inline int snd_sof_dsp_run(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->run)
+		return sdev->ops->run(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_stall(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->stall)
+		return sdev->ops->stall(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_reset(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->reset)
+		return sdev->ops->reset(sdev);
+
+	return 0;
+}
+
+/* dsp core power up/power down */
+static inline int snd_sof_dsp_core_power_up(struct snd_sof_dev *sdev,
+					    unsigned int core_mask)
+{
+	if (sdev->ops->core_power_up)
+		return sdev->ops->core_power_up(sdev, core_mask);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_core_power_down(struct snd_sof_dev *sdev,
+					      unsigned int core_mask)
+{
+	if (sdev->ops->core_power_down)
+		return sdev->ops->core_power_down(sdev, core_mask);
+
+	return 0;
+}
+
+/* pre/post fw load */
+static inline int snd_sof_dsp_pre_fw_run(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->pre_fw_run)
+		return sdev->ops->pre_fw_run(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_post_fw_run(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->post_fw_run)
+		return sdev->ops->post_fw_run(sdev);
+
+	return 0;
+}
+
+/* power management */
+static inline int snd_sof_dsp_resume(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->resume)
+		return sdev->ops->resume(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_suspend(struct snd_sof_dev *sdev, int state)
+{
+	if (sdev->ops->suspend)
+		return sdev->ops->suspend(sdev, state);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_runtime_resume(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->runtime_resume)
+		return sdev->ops->runtime_resume(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_runtime_suspend(struct snd_sof_dev *sdev,
+					      int state)
+{
+	if (sdev->ops->runtime_suspend)
+		return sdev->ops->runtime_suspend(sdev, state);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_set_clk(struct snd_sof_dev *sdev, u32 freq)
+{
+	if (sdev->ops->set_clk)
+		return sdev->ops->set_clk(sdev, freq);
+
+	return 0;
+}
+
+/* debug */
+static inline void snd_sof_dsp_dbg_dump(struct snd_sof_dev *sdev, u32 flags)
+{
+	if (sdev->ops->dbg_dump)
+		return sdev->ops->dbg_dump(sdev, flags);
+}
+
+/* register IO */
+static inline void snd_sof_dsp_write(struct snd_sof_dev *sdev, u32 bar,
+				     u32 offset, u32 value)
+{
+	if (sdev->ops->write)
+		sdev->ops->write(sdev, sdev->bar[bar] + offset, value);
+}
+
+static inline void snd_sof_dsp_write64(struct snd_sof_dev *sdev, u32 bar,
+				       u32 offset, u64 value)
+{
+	if (sdev->ops->write64)
+		sdev->ops->write64(sdev,
+			sdev->bar[bar] + offset, value);
+}
+
+static inline u32 snd_sof_dsp_read(struct snd_sof_dev *sdev, u32 bar,
+				   u32 offset)
+{
+	if (sdev->ops->read)
+		return sdev->ops->read(sdev, sdev->bar[bar] + offset);
+
+	return 0;
+}
+
+static inline u64 snd_sof_dsp_read64(struct snd_sof_dev *sdev, u32 bar,
+				     u32 offset)
+{
+	if (sdev->ops->read64)
+		return sdev->ops->read64(sdev, sdev->bar[bar] + offset);
+
+	return 0;
+}
+
+/* block IO */
+static inline void snd_sof_dsp_block_read(struct snd_sof_dev *sdev,
+					  u32 offset, void *dest, size_t bytes)
+{
+	if (sdev->ops->block_read)
+		sdev->ops->block_read(sdev, offset, dest, bytes);
+}
+
+static inline void snd_sof_dsp_block_write(struct snd_sof_dev *sdev,
+					   u32 offset, void *src, size_t bytes)
+{
+	if (sdev->ops->block_write)
+		sdev->ops->block_write(sdev, offset, src, bytes);
+}
+
+/* mailbox */
+static inline void snd_sof_dsp_mailbox_read(struct snd_sof_dev *sdev,
+					    u32 offset, void *message,
+					    size_t bytes)
+{
+	if (sdev->ops->mailbox_read)
+		sdev->ops->mailbox_read(sdev, offset, message, bytes);
+}
+
+static inline void snd_sof_dsp_mailbox_write(struct snd_sof_dev *sdev,
+					     u32 offset, void *message,
+					     size_t bytes)
+{
+	if (sdev->ops->mailbox_write)
+		sdev->ops->mailbox_write(sdev, offset, message, bytes);
+}
+
+/* ipc */
+static inline int snd_sof_dsp_send_msg(struct snd_sof_dev *sdev,
+				       struct snd_sof_ipc_msg *msg)
+{
+	if (sdev->ops->send_msg)
+		return sdev->ops->send_msg(sdev, msg);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_get_reply(struct snd_sof_dev *sdev,
+					struct snd_sof_ipc_msg *msg)
+{
+	if (sdev->ops->get_reply)
+		return sdev->ops->get_reply(sdev, msg);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_is_ready(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->is_ready)
+		return sdev->ops->is_ready(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_cmd_done(struct snd_sof_dev *sdev,
+				       int dir)
+{
+	if (sdev->ops->cmd_done)
+		return sdev->ops->cmd_done(sdev, dir);
+
+	return 0;
+}
+
+/* host DMA trace */
+static inline int snd_sof_dma_trace_init(struct snd_sof_dev *sdev,
+					 u32 *stream_tag)
+{
+	if (sdev->ops->trace_init)
+		return sdev->ops->trace_init(sdev, stream_tag);
+
+	return 0;
+}
+
+static inline int snd_sof_dma_trace_release(struct snd_sof_dev *sdev)
+{
+	if (sdev->ops->trace_release)
+		return sdev->ops->trace_release(sdev);
+
+	return 0;
+}
+
+static inline int snd_sof_dma_trace_trigger(struct snd_sof_dev *sdev, int cmd)
+{
+	if (sdev->ops->trace_trigger)
+		return sdev->ops->trace_trigger(sdev, cmd);
+
+	return 0;
+}
+
+/* host PCM ops */
+static inline int
+snd_sof_pcm_platform_open(struct snd_sof_dev *sdev,
+			  struct snd_pcm_substream *substream)
+{
+	if (sdev->ops && sdev->ops->pcm_open)
+		return sdev->ops->pcm_open(sdev, substream);
+
+	return 0;
+}
+
+/* disconnect pcm substream to a host stream */
+static inline int
+snd_sof_pcm_platform_close(struct snd_sof_dev *sdev,
+			   struct snd_pcm_substream *substream)
+{
+	if (sdev->ops && sdev->ops->pcm_close)
+		return sdev->ops->pcm_close(sdev, substream);
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
+	if (sdev->ops && sdev->ops->pcm_hw_params)
+		return sdev->ops->pcm_hw_params(sdev, substream,
+						params, ipc_params);
+
+	return 0;
+}
+
+/* host stream trigger */
+static inline int
+snd_sof_pcm_platform_trigger(struct snd_sof_dev *sdev,
+			     struct snd_pcm_substream *substream, int cmd)
+{
+	if (sdev->ops && sdev->ops->pcm_trigger)
+		return sdev->ops->pcm_trigger(sdev, substream, cmd);
+
+	return 0;
+}
+
+/* host stream pointer */
+static inline snd_pcm_uframes_t
+snd_sof_pcm_platform_pointer(struct snd_sof_dev *sdev,
+			     struct snd_pcm_substream *substream)
+{
+	if (sdev->ops && sdev->ops->pcm_pointer)
+		return sdev->ops->pcm_pointer(sdev, substream);
+
+	return 0;
+}
+
+static inline struct snd_sof_dsp_ops
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
+			      u32 mask, u32 target, u32 timeout);
+
+void snd_sof_dsp_panic(struct snd_sof_dev *sdev, u32 offset);
+#endif
-- 
2.17.1
