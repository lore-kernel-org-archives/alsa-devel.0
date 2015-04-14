From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 4/7] Asoc: sti: add CPU DAI driver for capture
Date: Tue, 14 Apr 2015 15:35:28 +0200
Message-ID: <1429018531-29025-5-git-send-email-arnaud.pouliquen@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 308C8265050
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 15:37:24 +0200 (CEST)
In-Reply-To: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Add code to manage Uniperipheral reader IP instances.
These DAIs are dedicated to capture and support I2S and IEC mode.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif.h        |   4 +
 sound/soc/sti/uniperif_reader.c | 493 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 497 insertions(+)
 create mode 100644 sound/soc/sti/uniperif_reader.c

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 02ac9a8..194f884 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1229,4 +1229,8 @@ int uni_player_init(struct platform_device *pdev, struct device_node *node,
 		    struct uniperif **uni_player, int idx);
 int uni_player_remove(struct platform_device *pdev);
 
+/* uniperiph reader */
+int uni_reader_init(struct platform_device *pdev, struct device_node *node,
+		    struct uniperif **uni_reader, int idx);
+int uni_reader_remove(struct platform_device *pdev);
 #endif
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
new file mode 100644
index 0000000..3cc67d8
--- /dev/null
+++ b/sound/soc/sti/uniperif_reader.c
@@ -0,0 +1,493 @@
+/*
+ * Copyright (C) STMicroelectronics SA 2015
+ * Authors: Arnaud Pouliquen <arnaud.pouliquen@st.com>
+ *          for STMicroelectronics.
+ * License terms:  GNU General Public License (GPL), version 2
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#include <sound/soc.h>
+
+#include "uniperif.h"
+
+const struct snd_pcm_hardware uni_reader_pcm_hw = {
+	.info = (SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		 SNDRV_PCM_INFO_PAUSE),
+
+	.formats = (SNDRV_PCM_FMTBIT_S32_LE |
+		    SNDRV_PCM_FMTBIT_S16_LE),
+
+	.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min = UNIPERIF_MIN_RATE,
+	.rate_max = UNIPERIF_MAX_RATE,
+
+	.channels_min = UNIPERIF_MIN_CHANNELS,
+	.channels_max = UNIPERIF_MAX_CHANNELS,
+
+	.periods_min = UNIPERIF_PERIODS_MIN,
+	.periods_max = UNIPERIF_PERIODS_MAX,
+
+	.period_bytes_min = UNIPERIF_PERIODS_BYTES_MIN,
+	.period_bytes_max = UNIPERIF_PERIODS_BYTES_MAX,
+	.buffer_bytes_max = UNIPERIF_BUFFER_BYTES_MAX
+};
+
+static inline int get_property_hdl(struct device *dev, struct device_node *np,
+				   const char *prop, int idx)
+{
+	int sz = 0;
+	const __be32 *phandle;
+
+	phandle = of_get_property(np, prop, &sz);
+
+	if (!phandle) {
+		dev_err(dev, "%s: ERROR: DT-property '%s' missing or invalid!",
+			__func__, prop);
+		return -EINVAL;
+	}
+
+	if (idx >= sz) {
+		dev_err(dev, "%s: ERROR: Array-index (%u) >= array-size (%u)!",
+			__func__, idx, sz);
+		return -EINVAL;
+	}
+
+	return be32_to_cpup(phandle + idx);
+}
+
+/*
+ * Uniperipheral reader implementation
+ */
+
+static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
+{
+	irqreturn_t ret = IRQ_NONE;
+	struct uniperif *reader = dev_id;
+	unsigned int status;
+
+	/* Get interrupt status & clear them immediately */
+	preempt_disable();
+	status = GET_UNIPERIF_ITS(reader);
+	SET_UNIPERIF_ITS_BCLR(reader, status);
+	preempt_enable();
+
+	if (reader->state == UNIPERIF_STATE_STOPPED) {
+		/* unexpected IRQ: do nothing */
+		dev_warn(reader->dev, "unexpected IRQ: status flag: %#x",
+			 status);
+		return IRQ_HANDLED;
+	};
+
+	/* Overflow? */
+	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(reader))) {
+		dev_err(reader->dev, "FIFO error detected");
+
+		snd_pcm_stream_lock(reader->substream);
+		snd_pcm_stop(reader->substream, SNDRV_PCM_STATE_XRUN);
+		snd_pcm_stream_unlock(reader->substream);
+
+		return IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static int uni_reader_prepare_pcm(struct uniperif *reader,
+				  struct snd_pcm_runtime *runtime)
+{
+	int slot_width;
+
+	if (!runtime) {
+		dev_err(reader->dev, "%s: invalid pointer(s)", __func__);
+		return -EINVAL;
+	}
+
+	/* force slot width to 32 in I2S mode */
+	if ((reader->daifmt & SND_SOC_DAIFMT_FORMAT_MASK)
+		== SND_SOC_DAIFMT_I2S) {
+		slot_width = 32;
+	} else {
+		switch (runtime->format) {
+		case SNDRV_PCM_FORMAT_S16_LE:
+			slot_width = 16;
+			break;
+		default:
+			slot_width = 32;
+			break;
+		}
+	}
+
+	/* Number of bits per subframe (i.e one channel sample) on input. */
+	switch (slot_width) {
+	case 32:
+		SET_UNIPERIF_I2S_FMT_NBIT_32(reader);
+		SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(reader);
+		break;
+	case 16:
+		SET_UNIPERIF_I2S_FMT_NBIT_16(reader);
+		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(reader);
+		break;
+	default:
+		dev_err(reader->dev, "subframe format not supported");
+		return -EINVAL;
+	}
+
+	/* Configure data memory format */
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		/* One data word contains two samples */
+		SET_UNIPERIF_CONFIG_MEM_FMT_16_16(reader);
+		break;
+
+	case SNDRV_PCM_FORMAT_S32_LE:
+		/*
+		 * Actually "16 bits/0 bits" means "32/28/24/20/18/16 bits
+		 * on the MSB then zeros (if less than 32 bytes)"...
+		 */
+		SET_UNIPERIF_CONFIG_MEM_FMT_16_0(reader);
+		break;
+
+	default:
+		dev_err(reader->dev, "format not supported");
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_CONFIG_MSTR_CLKEDGE_RISING(reader);
+	SET_UNIPERIF_CTRL_READER_OUT_SEL_IN_MEM(reader);
+
+	/*
+	 * Serial audio interface format - for detailed explanation
+	 * see ie.:
+	 * http: www.cirrus.com/en/pubs/appNote/AN282REV1.pdf
+	 */
+
+	SET_UNIPERIF_I2S_FMT_ORDER_MSB(reader);
+
+	/* Data clocking (changing) on the rising edge */
+	SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(reader);
+
+	/* Number of channels... */
+
+	if ((runtime->channels % 2) || (runtime->channels < 2) ||
+	    (runtime->channels > 10)) {
+		dev_err(reader->dev, "%s: invalid nb of channels", __func__);
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_I2S_FMT_NUM_CH(reader, runtime->channels / 2);
+
+	return 0;
+}
+
+static int uni_reader_prepare(struct uniperif *reader,
+			      struct snd_pcm_runtime *runtime)
+{
+	int transfer_size, trigger_limit;
+	int ret;
+	int count = 10;
+
+	/* The reader should be stopped */
+	if (reader->state != UNIPERIF_STATE_STOPPED) {
+		dev_err(reader->dev, "%s: invalid reader state %d", __func__,
+			reader->state);
+		return -EINVAL;
+	}
+
+	/* Calculate transfer size (in fifo cells and bytes) for frame count */
+	transfer_size = runtime->channels * UNIPERIF_FIFO_FRAMES;
+
+	/* Calculate number of empty cells available before asserting DREQ */
+	if (reader->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		trigger_limit = UNIPERIF_FIFO_SIZE - transfer_size;
+	else
+		/*
+		 * Since SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
+		 * FDMA_TRIGGER_LIMIT also controls when the state switches
+		 * from OFF or STANDBY to AUDIO DATA.
+		 */
+		trigger_limit = transfer_size;
+
+	/* Trigger limit must be an even number */
+	if ((!trigger_limit % 2) ||
+	    (trigger_limit != 1 && transfer_size % 2) ||
+	    (trigger_limit > UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(reader))) {
+		dev_err(reader->dev, "invalid trigger limit %d", trigger_limit);
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(reader, trigger_limit);
+
+	ret = uni_reader_prepare_pcm(reader, runtime);
+
+	switch (reader->daifmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+	case SND_SOC_DAIFMT_NB_IF:
+		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(reader);
+		break;
+	default:
+		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(reader);
+	}
+
+	switch (reader->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
+		SET_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(reader);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
+		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(reader);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		SET_UNIPERIF_I2S_FMT_ALIGN_RIGHT(reader);
+		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(reader);
+		break;
+	default:
+		dev_err(reader->dev, "format not supported");
+		return -EINVAL;
+	}
+
+	/* Clear any pending interrupts */
+	SET_UNIPERIF_ITS_BCLR(reader, GET_UNIPERIF_ITS(reader));
+
+	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(reader, 0);
+
+	/* Set the interrupt mask */
+	SET_UNIPERIF_ITM_BSET_DMA_ERROR(reader);
+	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(reader);
+	SET_UNIPERIF_ITM_BSET_MEM_BLK_READ(reader);
+
+	/* Enable underflow recovery interrupts */
+	if (reader->info->underflow_enabled) {
+		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(reader);
+		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(reader);
+	}
+
+	/* Reset uniperipheral reader */
+	SET_UNIPERIF_SOFT_RST_SOFT_RST(reader);
+
+	while (GET_UNIPERIF_SOFT_RST_SOFT_RST(reader)) {
+		udelay(5);
+		count--;
+	}
+	if (!count) {
+		dev_err(reader->dev, "Failed to reset uniperif");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int uni_reader_start(struct uniperif *reader)
+{
+	/* The reader should be stopped ot in standby */
+	if ((reader->state != UNIPERIF_STATE_STOPPED) &&
+	    (reader->state != UNIPERIF_STATE_STANDBY)) {
+		dev_err(reader->dev, "%s: invalid reader state", __func__);
+		return -EINVAL;
+	}
+
+	/* Check if we are moving from standby state to started */
+	if (reader->state == UNIPERIF_STATE_STANDBY) {
+		/* Set the reader to audio/pcm data mode */
+		SET_UNIPERIF_CTRL_OPERATION_AUDIO_DATA(reader);
+
+		/* Update state to started and return */
+		reader->state = UNIPERIF_STATE_STARTED;
+		return 0;
+	}
+
+	/* Enable reader interrupts (and clear possible stalled ones) */
+	enable_irq(reader->irq);
+	SET_UNIPERIF_ITS_BCLR_FIFO_ERROR(reader);
+	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(reader);
+
+	/* Launch the reader */
+	SET_UNIPERIF_CTRL_OPERATION_PCM_DATA(reader);
+
+	/* Update state to started */
+	reader->state = UNIPERIF_STATE_STARTED;
+	return 0;
+}
+
+static int uni_reader_stop(struct uniperif *reader)
+{
+	/* The reader should not be in stopped state */
+	if (reader->state == UNIPERIF_STATE_STOPPED) {
+		dev_err(reader->dev, "%s: invalid reader state", __func__);
+		return -EINVAL;
+	}
+
+	/* Turn the reader off */
+	SET_UNIPERIF_CTRL_OPERATION_OFF(reader);
+
+	/* Disable interrupts */
+	SET_UNIPERIF_ITM_BCLR(reader, GET_UNIPERIF_ITM(reader));
+	disable_irq_nosync(reader->irq);
+
+	/* Update state to stopped and return */
+	reader->state = UNIPERIF_STATE_STOPPED;
+
+	return 0;
+}
+
+static int uni_reader_suspend(struct uniperif *reader)
+{
+	/* pinctrl: switch pinstate to sleep */
+	return pinctrl_pm_select_sleep_state(reader->dev);
+}
+
+static int uni_reader_resume(struct uniperif *reader)
+{
+	/* ensure that disable by default */
+	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(reader);
+	SET_UNIPERIF_CTRL_ROUNDING_OFF(reader);
+	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(reader);
+	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(reader);
+
+	/* pinctrl: switch pinstate to default */
+	return pinctrl_pm_select_default_state(reader->dev);
+}
+
+static int  uni_reader_trigger(struct uniperif *reader, int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		return  uni_reader_start(reader);
+	case SNDRV_PCM_TRIGGER_STOP:
+		return  uni_reader_stop(reader);
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		return uni_reader_suspend(reader);
+	case SNDRV_PCM_TRIGGER_RESUME:
+		return uni_reader_resume(reader);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void uni_reader_close(struct uniperif *reader)
+{
+	if (reader->state != UNIPERIF_STATE_STOPPED) {
+		/* Stop the reader */
+		uni_reader_stop(reader);
+	}
+}
+
+/*
+ * Platform driver routines
+ */
+
+static int uni_reader_parse_dt(struct platform_device *pdev,
+			       struct device_node *pnode,
+			       struct uniperif *reader)
+{
+	struct uniperif_info *info;
+
+	/* Allocate memory for the info structure */
+	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	if (!pnode) {
+		dev_err(&pdev->dev, "%s: invalid pnode", __func__);
+		return -EINVAL;
+	}
+	of_property_read_u32(pnode, "version", &info->ver);
+
+	/* Save the info structure */
+	reader->info = info;
+
+	return 0;
+}
+
+const struct uniperif_ops uni_reader_ops = {
+	.close = uni_reader_close,
+	.prepare = uni_reader_prepare,
+	.trigger = uni_reader_trigger
+};
+
+int uni_reader_init(struct platform_device *pdev, struct device_node *node,
+		    struct uniperif **uni_reader, int idx)
+{
+	struct uniperif *reader;
+	int ret = 0;
+
+	reader = devm_kzalloc(&pdev->dev, sizeof(*reader), GFP_KERNEL);
+	if (!reader)
+		return -ENOMEM;
+
+	reader->dev = &pdev->dev;
+	reader->state = UNIPERIF_STATE_STOPPED;
+	reader->hw = &uni_reader_pcm_hw;
+	reader->ops = &uni_reader_ops;
+	ret = uni_reader_parse_dt(pdev, node, reader);
+
+	if (ret < 0) {
+		dev_err(reader->dev, "Failed to parse DeviceTree");
+		return ret;
+	}
+
+	/* Get resources */
+
+	reader->mem_region = platform_get_resource(pdev, IORESOURCE_MEM, idx);
+
+	if (!reader->mem_region) {
+		dev_err(&pdev->dev, "Failed to get memory resource");
+		return -ENODEV;
+	}
+
+	reader->base = devm_ioremap_resource(&pdev->dev,
+						reader->mem_region);
+
+	if (!reader->base) {
+		dev_err(&pdev->dev, "Failed to ioremap memory region");
+		return -ENXIO;
+	}
+
+	reader->fifo_phys_address = reader->mem_region->start +
+				     UNIPERIF_FIFO_DATA_OFFSET(reader);
+
+	reader->irq = platform_get_irq(pdev, idx);
+
+	if (reader->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ resource");
+		return -ENXIO;
+	}
+
+	ret = devm_request_irq(&pdev->dev, reader->irq,
+			       uni_reader_irq_handler, IRQF_SHARED,
+			       dev_name(&pdev->dev), reader);
+
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ");
+		return -EBUSY;
+	}
+
+	/*
+	 * request_irq() enables the interrupt immediately; as it is
+	 * lethal in concurrent audio environment, we want to have
+	 * it disabled for most of the time...
+	 */
+	disable_irq(reader->irq);
+
+	*uni_reader = reader;
+
+	/* ensure that disable by default */
+	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(reader);
+	SET_UNIPERIF_CTRL_ROUNDING_OFF(reader);
+	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(reader);
+	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(reader);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uni_reader_init);
+
+int uni_reader_remove(struct platform_device *pdev)
+{
+	/* nothing to do */
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uni_reader_remove);
-- 
1.9.1
