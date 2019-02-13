From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 08/20] ASoC: SOF: Intel: Add Intel specific
	HDA firmware loader
Date: Wed, 13 Feb 2019 16:08:35 -0600
Message-ID: <20190213220847.10567-9-pierre-louis.bossart@linux.intel.com>
References: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190213220847.10567-1-pierre-louis.bossart@linux.intel.com>
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

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Add support for loading DSP firmware on Intel HDA based platforms.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-loader.c | 359 +++++++++++++++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100644 sound/soc/sof/intel/hda-loader.c

diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
new file mode 100644
index 000000000000..6a5e07df4116
--- /dev/null
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2018 Intel Corporation. All rights reserved.
+//
+// Authors: Liam Girdwood <liam.r.girdwood@linux.intel.com>
+//	    Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
+//	    Rander Wang <rander.wang@intel.com>
+//          Keyon Jie <yang.jie@linux.intel.com>
+//
+
+/*
+ * Hardware interface for HDA DSP code loader
+ */
+
+#include <linux/firmware.h>
+#include <sound/hdaudio_ext.h>
+#include <sound/sof.h>
+#include "../ops.h"
+#include "hda.h"
+
+#define HDA_FW_BOOT_ATTEMPTS	3
+
+static int cl_stream_prepare(struct snd_sof_dev *sdev, unsigned int format,
+			     unsigned int size, struct snd_dma_buffer *dmab,
+			     int direction)
+{
+	struct hdac_ext_stream *dsp_stream = NULL;
+	struct hdac_stream *hstream;
+	struct pci_dev *pci = to_pci_dev(sdev->dev);
+	int ret;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
+		dsp_stream = hda_dsp_stream_get(sdev, direction);
+	} else {
+		dev_err(sdev->dev, "error: code loading DMA is playback only\n");
+		return -EINVAL;
+	}
+
+	if (!dsp_stream) {
+		dev_err(sdev->dev, "error: no stream available\n");
+		return -ENODEV;
+	}
+	hstream = &dsp_stream->hstream;
+
+	/* allocate DMA buffer */
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG, &pci->dev, size, dmab);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: memory alloc failed: %x\n", ret);
+		goto error;
+	}
+
+	hstream->period_bytes = 0;/* initialize period_bytes */
+	hstream->format_val = format;
+	hstream->bufsize = size;
+
+	ret = hda_dsp_stream_hw_params(sdev, dsp_stream, dmab, NULL);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: hdac prepare failed: %x\n", ret);
+		goto error;
+	}
+
+	hda_dsp_stream_spib_config(sdev, dsp_stream, HDA_DSP_SPIB_ENABLE, size);
+
+	return hstream->stream_tag;
+
+error:
+	hda_dsp_stream_put(sdev, direction, hstream->stream_tag);
+	snd_dma_free_pages(dmab);
+	return ret;
+}
+
+/*
+ * first boot sequence has some extra steps. core 0 waits for power
+ * status on core 1, so power up core 1 also momentarily, keep it in
+ * reset/stall and then turn it off
+ */
+static int cl_dsp_init(struct snd_sof_dev *sdev, const void *fwdata,
+		       u32 fwsize, int stream_tag)
+{
+	struct sof_intel_hda_dev *hda = sdev->pdata->hw_pdata;
+	const struct sof_intel_dsp_desc *chip = hda->desc;
+	int ret;
+
+	/* step 1: power up corex */
+	ret = hda_dsp_core_power_up(sdev, chip->cores_mask);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: dsp core 0/1 power up failed\n");
+		goto err;
+	}
+
+	/* step 2: purge FW request */
+	snd_sof_dsp_write(sdev, HDA_DSP_BAR, chip->ipc_req,
+			  chip->ipc_req_mask | (HDA_DSP_IPC_PURGE_FW |
+			  ((stream_tag - 1) << 9)));
+
+	/* step 3: unset core 0 reset state & unstall/run core 0 */
+	ret = hda_dsp_core_run(sdev, HDA_DSP_CORE_MASK(0));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: dsp core start failed %d\n", ret);
+		ret = -EIO;
+		goto err;
+	}
+
+	/* step 4: wait for IPC DONE bit from ROM */
+	ret = snd_sof_dsp_register_poll(sdev, HDA_DSP_BAR,
+					chip->ipc_ack,
+					chip->ipc_ack_mask, chip->ipc_ack_mask,
+					HDA_DSP_INIT_TIMEOUT,
+					HDA_DSP_REG_POLL_INTERVAL_US);
+
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: waiting for HIPCIE done\n");
+		goto err;
+	}
+
+	/* step 5: power down corex */
+	ret = hda_dsp_core_power_down(sdev,
+				  chip->cores_mask & ~(HDA_DSP_CORE_MASK(0)));
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: dsp core x power down failed\n");
+		goto err;
+	}
+
+	/* step 6: enable IPC interrupts */
+	hda_dsp_ipc_int_enable(sdev);
+
+	/* step 7: wait for ROM init */
+	ret = snd_sof_dsp_register_poll(sdev, HDA_DSP_BAR,
+					HDA_DSP_SRAM_REG_ROM_STATUS,
+					HDA_DSP_ROM_STS_MASK, HDA_DSP_ROM_INIT,
+					HDA_ROM_INIT_TIMEOUT,
+					HDA_DSP_REG_POLL_INTERVAL_US);
+	if (!ret)
+		return 0;
+
+err:
+	hda_dsp_dump(sdev, SOF_DBG_REGS | SOF_DBG_PCI | SOF_DBG_MBOX);
+	hda_dsp_core_reset_power_down(sdev, chip->cores_mask);
+
+	return ret;
+}
+
+static int cl_trigger(struct snd_sof_dev *sdev,
+		      struct hdac_ext_stream *stream, int cmd)
+{
+	struct hdac_stream *hstream = &stream->hstream;
+	int sd_offset = SOF_STREAM_SD_OFFSET(hstream);
+
+	/* code loader is special case that reuses stream ops */
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		wait_event_timeout(sdev->waitq, !sdev->code_loading,
+				   HDA_DSP_CL_TRIGGER_TIMEOUT);
+
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR, SOF_HDA_INTCTL,
+					1 << hstream->index,
+					1 << hstream->index);
+
+		snd_sof_dsp_update_bits(sdev, HDA_DSP_HDA_BAR,
+					sd_offset,
+					SOF_HDA_SD_CTL_DMA_START |
+					SOF_HDA_CL_DMA_SD_INT_MASK,
+					SOF_HDA_SD_CTL_DMA_START |
+					SOF_HDA_CL_DMA_SD_INT_MASK);
+
+		hstream->running = true;
+		return 0;
+	default:
+		return hda_dsp_stream_trigger(sdev, stream, cmd);
+	}
+}
+
+static struct hdac_ext_stream *get_stream_with_tag(struct snd_sof_dev *sdev,
+						   int tag)
+{
+	struct hdac_bus *bus = sof_to_bus(sdev);
+	struct hdac_stream *s;
+
+	/* get stream with tag */
+	list_for_each_entry(s, &bus->stream_list, list) {
+		if (s->direction == SNDRV_PCM_STREAM_PLAYBACK &&
+		    s->stream_tag == tag) {
+			return stream_to_hdac_ext_stream(s);
+		}
+	}
+
+	return NULL;
+}
+
+static int cl_cleanup(struct snd_sof_dev *sdev, struct snd_dma_buffer *dmab,
+		      struct hdac_ext_stream *stream)
+{
+	struct hdac_stream *hstream = &stream->hstream;
+	int sd_offset = SOF_STREAM_SD_OFFSET(hstream);
+	int ret;
+
+	ret = hda_dsp_stream_spib_config(sdev, stream, HDA_DSP_SPIB_DISABLE, 0);
+
+	hda_dsp_stream_put(sdev, SNDRV_PCM_STREAM_PLAYBACK,
+			   hstream->stream_tag);
+	hstream->running = 0;
+	hstream->substream = NULL;
+
+	/* reset BDL address */
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+			  sd_offset + SOF_HDA_ADSP_REG_CL_SD_BDLPL, 0);
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR,
+			  sd_offset + SOF_HDA_ADSP_REG_CL_SD_BDLPU, 0);
+
+	snd_sof_dsp_write(sdev, HDA_DSP_HDA_BAR, sd_offset, 0);
+	snd_dma_free_pages(dmab);
+	dmab->area = NULL;
+	hstream->bufsize = 0;
+	hstream->format_val = 0;
+
+	return ret;
+}
+
+static int cl_copy_fw(struct snd_sof_dev *sdev, struct hdac_ext_stream *stream)
+{
+	int ret, status;
+
+	ret = cl_trigger(sdev, stream, SNDRV_PCM_TRIGGER_START);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: DMA trigger start failed\n");
+		return ret;
+	}
+
+	status = snd_sof_dsp_register_poll(sdev, HDA_DSP_BAR,
+					   HDA_DSP_SRAM_REG_ROM_STATUS,
+					   HDA_DSP_ROM_STS_MASK,
+					   HDA_DSP_ROM_FW_ENTERED,
+					   HDA_DSP_BASEFW_TIMEOUT,
+					   HDA_DSP_REG_POLL_INTERVAL_US);
+
+	ret = cl_trigger(sdev, stream, SNDRV_PCM_TRIGGER_STOP);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: DMA trigger stop failed\n");
+		return ret;
+	}
+
+	return status;
+}
+
+int hda_dsp_cl_boot_firmware(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_pdata *plat_data = sdev->pdata;
+	struct hdac_ext_stream *stream;
+	struct firmware stripped_firmware;
+	int ret, ret1, tag, i;
+
+	stripped_firmware.data = plat_data->fw->data;
+	stripped_firmware.size = plat_data->fw->size;
+
+	/* init for booting wait */
+	init_waitqueue_head(&sdev->boot_wait);
+	sdev->boot_complete = false;
+
+	/* prepare DMA for code loader stream */
+	tag = cl_stream_prepare(sdev, 0x40, stripped_firmware.size,
+				&sdev->dmab, SNDRV_PCM_STREAM_PLAYBACK);
+
+	if (tag < 0) {
+		dev_err(sdev->dev, "error: dma prepare for fw loading err: %x\n",
+			tag);
+		return tag;
+	}
+
+	/* get stream with tag */
+	stream = get_stream_with_tag(sdev, tag);
+	if (!stream) {
+		dev_err(sdev->dev,
+			"error: could not get stream with stream tag %d\n",
+			tag);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	memcpy(sdev->dmab.area, stripped_firmware.data,
+	       stripped_firmware.size);
+
+	/* try ROM init a few times before giving up */
+	for (i = 0; i < HDA_FW_BOOT_ATTEMPTS; i++) {
+		ret = cl_dsp_init(sdev, stripped_firmware.data,
+				  stripped_firmware.size, tag);
+
+		/* don't retry anymore if successful */
+		if (!ret)
+			break;
+
+		dev_err(sdev->dev, "error: Error code=0x%x: FW status=0x%x\n",
+			snd_sof_dsp_read(sdev, HDA_DSP_BAR,
+					 HDA_DSP_SRAM_REG_ROM_ERROR),
+			snd_sof_dsp_read(sdev, HDA_DSP_BAR,
+					 HDA_DSP_SRAM_REG_ROM_STATUS));
+		dev_err(sdev->dev, "error: iteration %d of Core En/ROM load failed: %d\n",
+			i, ret);
+	}
+
+	if (i == HDA_FW_BOOT_ATTEMPTS) {
+		dev_err(sdev->dev, "error: dsp init failed after %d attempts with err: %d\n",
+			i, ret);
+		goto cleanup;
+	}
+
+	/*
+	 * at this point DSP ROM has been initialized and
+	 * should be ready for code loading and firmware boot
+	 */
+	ret = cl_copy_fw(sdev, stream);
+	if (!ret)
+		dev_dbg(sdev->dev, "Firmware download successful, booting...\n");
+	else
+		dev_err(sdev->dev, "error: load fw failed ret: %d\n", ret);
+
+cleanup:
+	/*
+	 * Perform codeloader stream cleanup.
+	 * This should be done even if firmware loading fails.
+	 */
+	ret1 = cl_cleanup(sdev, &sdev->dmab, stream);
+	if (ret1 < 0) {
+		dev_err(sdev->dev, "error: Code loader DSP cleanup failed\n");
+
+		/* set return value to indicate cleanup failure */
+		ret = ret1;
+	}
+
+	/* return if both copying fw and stream clean up are successful */
+	if (!ret)
+		return ret;
+
+	/* dump dsp registers and disable DSP upon error */
+err:
+	hda_dsp_dump(sdev, SOF_DBG_REGS | SOF_DBG_PCI | SOF_DBG_MBOX);
+
+	/* disable DSP */
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_PP_BAR,
+				SOF_HDA_REG_PP_PPCTL,
+				SOF_HDA_PPCTL_GPROCEN, 0);
+	return ret;
+}
+
+/* pre fw run operations */
+int hda_dsp_pre_fw_run(struct snd_sof_dev *sdev)
+{
+	/* disable clock gating and power gating */
+	return hda_dsp_ctrl_clock_power_gating(sdev, false);
+}
+
+/* post fw run operations */
+int hda_dsp_post_fw_run(struct snd_sof_dev *sdev)
+{
+	/* re-enable clock gating and power gating */
+	return hda_dsp_ctrl_clock_power_gating(sdev, true);
+}
-- 
2.17.1
