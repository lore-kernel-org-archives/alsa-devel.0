From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 3/7] Asoc: sti: add CPU DAI driver for playback
Date: Tue, 14 Apr 2015 15:35:27 +0200
Message-ID: <1429018531-29025-4-git-send-email-arnaud.pouliquen@st.com>
References: <1429018531-29025-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 615D72614A6
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 15:37:27 +0200 (CEST)
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

Add code to manage Uniperipheral player IP instances.
These DAIs are dedicated to playback and support I2S and IEC mode.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif.h        |  133 ++++
 sound/soc/sti/uniperif_player.c | 1367 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 1500 insertions(+)
 create mode 100644 sound/soc/sti/uniperif_player.c

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 043853e..02ac9a8 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1097,3 +1097,136 @@
 		UNIPERIF_DBG_STANDBY_LEFT_SP_OFFSET(ip), \
 		UNIPERIF_DBG_STANDBY_LEFT_SP_SHIFT(ip), \
 		UNIPERIF_DBG_STANDBY_LEFT_SP_MASK(ip), value)
+
+/*
+ * uniperipheral IP capabilities
+ */
+
+#define UNIPERIF_FIFO_SIZE		70 /* FIFO is 70 cells deep */
+#define UNIPERIF_FIFO_FRAMES		4  /* FDMA trigger limit in frames */
+
+#define UNIPERIF_MIN_RATE 8000
+#define UNIPERIF_MAX_RATE 192000
+
+#define UNIPERIF_MIN_CHANNELS 2
+#define UNIPERIF_MAX_CHANNELS 8
+
+#define UNIPERIF_PERIODS_BYTES_MIN	128
+#define UNIPERIF_PERIODS_BYTES_MAX	(64 * PAGE_SIZE)
+#define UNIPERIF_PERIODS_MIN		2
+#define UNIPERIF_PERIODS_MAX		48
+#define UNIPERIF_BUFFER_BYTES_MAX	(2048 * PAGE_SIZE)
+
+/*
+ * Uniperipheral IP revisions
+ */
+enum uniperif_version {
+	SND_ST_UNIPERIF_VERSION_UNKNOWN,
+	/* SASG1 (Orly), Newman */
+	SND_ST_UNIPERIF_VERSION_C6AUD0_UNI_1_0,
+	/* SASC1, SASG2 (Orly2) */
+	SND_ST_UNIPERIF_VERSION_UNI_PLR_1_0,
+	/* SASC1, SASG2 (Orly2), TELSS, Cannes */
+	SND_ST_UNIPERIF_VERSION_UNI_RDR_1_0,
+	/* TELSS (SASC1) */
+	SND_ST_UNIPERIF_VERSION_TDM_PLR_1_0,
+	/* Cannes/Monaco */
+	SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
+};
+
+enum uniperif_type {
+	SND_ST_UNIPERIF_PLAYER_TYPE_NONE,
+	SND_ST_UNIPERIF_PLAYER_TYPE_HDMI,
+	SND_ST_UNIPERIF_PLAYER_TYPE_PCM,
+	SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF
+};
+
+enum uniperif_state {
+	UNIPERIF_STATE_STOPPED,
+	UNIPERIF_STATE_STARTED,
+	UNIPERIF_STATE_STANDBY,
+	UNIPERIF_STATE_UNDERFLOW,
+	UNIPERIF_STATE_OVERFLOW = UNIPERIF_STATE_UNDERFLOW,
+	UNIPERIF_STATE_XRUN
+};
+
+enum uniperif_iec958_encoding_mode {
+	UNIPERIF_IEC958_ENCODING_MODE_PCM,
+	UNIPERIF_IEC958_ENCODING_MODE_ENCODED
+};
+
+struct uniperif_info {
+	int ver;
+	int uni_num; /* instance value of the uniperipheral IP */
+	enum uniperif_type player_type;
+	int underflow_enabled;		/* Underflow recovery mode */
+	int standby_enabled;
+	unsigned int suspend_delay;
+};
+
+struct uniperif_iec958_settings {
+	enum uniperif_iec958_encoding_mode encoding_mode;
+	struct snd_aes_iec958 iec958;
+};
+
+struct uniperif;
+
+struct uniperif_ops {
+	int (*open)(struct uniperif *player);
+	void (*close)(struct uniperif *player);
+	int (*prepare)(struct uniperif *player,
+		       struct snd_pcm_runtime *runtime);
+	int (*trigger)(struct uniperif *player, int cmd);
+};
+
+struct uniperif {
+	/* System information */
+	struct uniperif_info *info;
+	struct device *dev;
+	int ver; /* IP version, used by register access macros */
+	struct regmap_field *clk_sel;
+
+	/* capabilities */
+	const struct snd_pcm_hardware *hw;
+
+	/* Resources */
+	struct resource *mem_region;
+	void *base;
+	unsigned long fifo_phys_address;
+	int irq;
+
+	/* Clocks */
+	struct clk *clk;
+	int clk_div;
+	int clk_adj;
+	int rate;
+
+	/* Runtime data */
+	enum uniperif_state state;
+
+	struct snd_pcm_substream *substream;
+
+	/* Specific to IEC958 player */
+	struct uniperif_iec958_settings stream_settings;
+	spinlock_t lock;  /* lock on resource updated by alsa controls */
+
+	/*alsa ctrl*/
+	struct snd_kcontrol_new *snd_ctrls;
+	int num_ctrls;
+
+	/* dai properties */
+	unsigned int daifmt;
+
+	/* DAI callbacks */
+	const struct uniperif_ops *ops;
+
+	/* work struct */
+	struct delayed_work delayed_work;
+};
+
+/* uniperiph player*/
+int uni_player_init(struct platform_device *pdev, struct device_node *node,
+		    struct uniperif **uni_player, int idx);
+int uni_player_remove(struct platform_device *pdev);
+
+#endif
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
new file mode 100644
index 0000000..702bcd5
--- /dev/null
+++ b/sound/soc/sti/uniperif_player.c
@@ -0,0 +1,1367 @@
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
+#include <linux/mfd/syscon.h>
+
+#include <sound/asoundef.h>
+#include <sound/soc.h>
+
+#include "uniperif.h"
+
+/*
+ * Some hardware-related definitions
+ */
+
+#define DEFAULT_OVERSAMPLING 128 /* make all ip's running at same rate*/
+
+#define MIN_IEC958_SAMPLE_RATE	32000
+
+/* sys config registers definitions */
+#define SYS_CFG_AUDIO_GLUE 0xA4
+#define SYS_CFG_AUDI0_GLUE_PCM_CLKX 8
+
+/*
+ * Driver specific types.
+ */
+
+#define UNIPERIF_PLAYER_TYPE_IS_HDMI(p) \
+	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_HDMI)
+#define UNIPERIF_PLAYER_TYPE_IS_PCM(p) \
+	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_PCM)
+#define UNIPERIF_PLAYER_TYPE_IS_SPDIF(p) \
+	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF)
+#define UNIPERIF_PLAYER_TYPE_IS_IEC958(p) \
+	(UNIPERIF_PLAYER_TYPE_IS_HDMI(p) || \
+		UNIPERIF_PLAYER_TYPE_IS_SPDIF(p))
+
+#define DUMP_REGISTER(r) \
+		snd_iprintf(buffer, "AUD_UNIPERIF_%-23s (offset 0x%04x) = " \
+				"0x%08x\n", __stringify(r), \
+				UNIPERIF_##r##_OFFSET(player), \
+				GET_UNIPERIF_##r(player))
+
+#define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
+#define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
+#define UNIPERIF_PLAYER_CLK_ADJ_STEP 1
+
+#define MIN_AUTOSUPEND_DELAY_MS 100
+
+static int uni_player_suspend(struct uniperif *player);
+
+static struct workqueue_struct *uni_player_wq;
+
+const struct snd_pcm_hardware uni_player_pcm_hw = {
+	.info		= (
+	SNDRV_PCM_INFO_INTERLEAVED |
+	SNDRV_PCM_INFO_BLOCK_TRANSFER |
+	SNDRV_PCM_INFO_PAUSE),
+	.formats	= (SNDRV_PCM_FMTBIT_S32_LE |
+	SNDRV_PCM_FMTBIT_S16_LE),
+
+	.rates		= SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min	= UNIPERIF_MIN_RATE,
+	.rate_max	= UNIPERIF_MAX_RATE,
+
+	.channels_min	= UNIPERIF_MIN_CHANNELS,
+	.channels_max	= UNIPERIF_MAX_CHANNELS,
+
+	.periods_min	= UNIPERIF_PERIODS_MIN,
+	.periods_max	= UNIPERIF_PERIODS_MAX,
+
+	.period_bytes_min = UNIPERIF_PERIODS_BYTES_MIN,
+	.period_bytes_max = UNIPERIF_PERIODS_BYTES_MAX,
+	.buffer_bytes_max = UNIPERIF_BUFFER_BYTES_MAX
+};
+
+static inline int reset_player(struct uniperif *player)
+{
+	int count = 10;
+
+	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		while (GET_UNIPERIF_SOFT_RST_SOFT_RST(player) && count) {
+			udelay(5);
+			count--;
+		}
+
+	if (!count) {
+		dev_err(player->dev, "Failed to reset uniperif");
+		return -EIO;
+	}
+
+	return 0;
+}
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
+ * Uniperipheral player implementation
+ */
+
+static void uni_player_work(struct work_struct *work)
+{
+	struct uniperif *player =
+		container_of(work, struct uniperif, delayed_work.work);
+
+	spin_lock(&player->lock);
+	if (uni_player_suspend(player))
+		dev_err(player->dev, "%s: failed to suspend player", __func__);
+	spin_unlock(&player->lock);
+}
+
+static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
+{
+	irqreturn_t ret = IRQ_NONE;
+	struct uniperif *player = dev_id;
+	unsigned int status;
+	unsigned int tmp;
+
+	/* Get interrupt status & clear them immediately */
+	preempt_disable();
+	status = GET_UNIPERIF_ITS(player);
+	SET_UNIPERIF_ITS_BCLR(player, status);
+	preempt_enable();
+
+	if ((player->state == UNIPERIF_STATE_STANDBY) ||
+	    (player->state == UNIPERIF_STATE_STOPPED)) {
+		/* unexpected IRQ: do nothing */
+		dev_warn(player->dev, "unexpected IRQ: status flag: %#x",
+			 status);
+		return IRQ_HANDLED;
+	};
+
+	snd_pcm_stream_lock(player->substream);
+	/* Check for fifo error (under run) */
+	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(player))) {
+		dev_err(player->dev, "FIFO underflow error detected");
+
+		/* Interrupt is just for information when underflow recovery */
+		if (player->info->underflow_enabled) {
+			/* Update state to underflow */
+			player->state = UNIPERIF_STATE_UNDERFLOW;
+
+		} else {
+			/* Disable interrupt so doesn't continually fire */
+			SET_UNIPERIF_ITM_BCLR_FIFO_ERROR(player);
+
+			/* Stop the player */
+			snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
+		}
+
+		ret = IRQ_HANDLED;
+	}
+
+	/* Check for dma error (over run) */
+	if (unlikely(status & UNIPERIF_ITS_DMA_ERROR_MASK(player))) {
+		dev_err(player->dev, "DMA error detected");
+
+		/* Disable interrupt so doesn't continually fire */
+		SET_UNIPERIF_ITM_BCLR_DMA_ERROR(player);
+
+		/* Stop the player */
+		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
+
+		ret = IRQ_HANDLED;
+	}
+
+	/* Check for underflow recovery done */
+	if (unlikely(status &
+			UNIPERIF_ITM_UNDERFLOW_REC_DONE_MASK(player))) {
+		if (!player->info->underflow_enabled) {
+			dev_err(player->dev, "unexpected Underflow recovering");
+			snd_pcm_stream_unlock(player->substream);
+			return -EPERM;
+		}
+		/* Read the underflow recovery duration */
+		tmp = GET_UNIPERIF_STATUS_1_UNDERFLOW_DURATION(player);
+
+		/* Clear the underflow recovery duration */
+		SET_UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION(player);
+
+		/* Update state to started */
+		player->state = UNIPERIF_STATE_STARTED;
+
+		ret = IRQ_HANDLED;
+	}
+
+	if (unlikely(status &
+		UNIPERIF_ITS_MEM_BLK_READ_MASK(player))) {
+		ret = IRQ_HANDLED;
+	}
+
+	/* Checkf or underflow recovery failed */
+	if (unlikely(status &
+		     UNIPERIF_ITM_UNDERFLOW_REC_FAILED_MASK(player))) {
+		dev_err(player->dev, "Underflow recovery failed");
+
+		/* Stop the player */
+		snd_pcm_stop(player->substream, SNDRV_PCM_STATE_XRUN);
+
+		ret = IRQ_HANDLED;
+	}
+
+	/* error  on unhandled interrupt */
+	if (ret != IRQ_HANDLED)
+		dev_err(player->dev, "IRQ status : %#x", status);
+
+	snd_pcm_stream_unlock(player->substream);
+	return ret;
+}
+
+int uni_player_clk_set_rate(struct uniperif *player, unsigned long rate)
+{
+	int rate_adjusted, rate_achieved, delta;
+	int adjustment = player->clk_adj;
+
+	/*
+	 *             a
+	 * F = f + --------- * f = f + d
+	 *          1000000
+	 *
+	 *         a
+	 * d = --------- * f
+	 *      1000000
+	 *
+	 * where:
+	 *   f - nominal rate
+	 *   a - adjustment in ppm (parts per milion)
+	 *   F - rate to be set in synthesizer
+	 *   d - delta (difference) between f and F
+	 */
+	if (adjustment < 0) {
+		/* div64_64 operates on unsigned values... */
+		delta = -1;
+		adjustment = -adjustment;
+	} else {
+		delta = 1;
+	}
+	/* 500000 ppm is 0.5, which is used to round up values */
+	delta *= (int)div64_u64((uint64_t)rate *
+				(uint64_t)adjustment + 500000, 1000000);
+	rate_adjusted = rate + delta;
+
+	/* adjusted rate should never be == 0 */
+	if (!rate_adjusted)
+		return -EINVAL;
+
+	if (clk_set_rate(player->clk, rate_adjusted) < 0) {
+		dev_err(player->dev, "Failed to clk set rate %d !\n",
+			rate_adjusted);
+		return -EINVAL;
+	}
+
+	rate_achieved = clk_get_rate(player->clk);
+	if (!rate_achieved)
+		return -EINVAL;
+
+	/*
+	 * using ALSA's adjustment control, we can modify the rate to be up
+	 * to twice as much as requested, but no more
+	 */
+	delta = rate_achieved - rate;
+	if (delta < 0) {
+		/* div64_64 operates on unsigned values... */
+		delta = -delta;
+		adjustment = -1;
+	} else {
+		adjustment = 1;
+	}
+	/* frequency/2 is added to round up result */
+	adjustment *= (int)div64_u64((uint64_t)delta * 1000000 + rate / 2,
+				     rate);
+	player->clk_adj = adjustment;
+	return 0;
+}
+
+static void uni_player_set_channel_status(struct uniperif *player,
+					  struct snd_pcm_runtime *runtime)
+{
+	int n;
+	unsigned int status;
+
+	/*
+	 * Some AVRs and TVs require the channel status to contain a correct
+	 * sampling frequency. If no sample rate is already specified, then
+	 * set one.
+	 */
+	spin_lock(&player->lock);
+	if (runtime && (player->stream_settings.iec958.status[3]
+					== IEC958_AES3_CON_FS_NOTID)) {
+		switch (runtime->rate) {
+		case 22050:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_22050;
+			break;
+		case 44100:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_44100;
+			break;
+		case 88200:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_88200;
+			break;
+		case 176400:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_176400;
+			break;
+		case 24000:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_24000;
+			break;
+		case 48000:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_48000;
+			break;
+		case 96000:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_96000;
+			break;
+		case 192000:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_192000;
+			break;
+		case 32000:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_32000;
+			break;
+		case 768000:
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_768000;
+			break;
+		default:
+			/* Mark as sampling frequency not indicated */
+			player->stream_settings.iec958.status[3] =
+						IEC958_AES3_CON_FS_NOTID;
+			break;
+		}
+	}
+
+	/* audio mode
+	 * use audio mode status to select PCM or encoded mode
+	 */
+	if (player->stream_settings.iec958.status[0] & IEC958_AES0_NONAUDIO)
+		player->stream_settings.encoding_mode =
+			UNIPERIF_IEC958_ENCODING_MODE_ENCODED;
+	else
+		player->stream_settings.encoding_mode =
+			UNIPERIF_IEC958_ENCODING_MODE_PCM;
+
+	if (player->stream_settings.encoding_mode ==
+		UNIPERIF_IEC958_ENCODING_MODE_PCM)
+		/* Clear user validity bits */
+		SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
+	else
+		/* Set user validity bits */
+		SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 1);
+
+	/* Program the new channel status */
+	for (n = 0; n < 6; ++n) {
+		status  =
+		player->stream_settings.iec958.status[0 + (n * 4)] & 0xf;
+		status |=
+		player->stream_settings.iec958.status[1 + (n * 4)] << 8;
+		status |=
+		player->stream_settings.iec958.status[2 + (n * 4)] << 16;
+		status |=
+		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
+		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
+	}
+	spin_unlock(&player->lock);
+
+	/* Update the channel status */
+	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		SET_UNIPERIF_CONFIG_CHL_STS_UPDATE(player);
+	else
+		SET_UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE(player);
+}
+
+static int uni_player_prepare_iec958(struct uniperif *player,
+				     struct snd_pcm_runtime *runtime)
+{
+	if (!runtime) {
+		dev_err(player->dev, "%s: invalid pointer(s)", __func__);
+		return -EINVAL;
+	}
+
+	/* Oversampling must be multiple of 128 as iec958 frame is 32-bits */
+	if ((player->clk_div % 128) ||
+	    (player->clk_div <= 0)) {
+		dev_err(player->dev, "%s: invalid clk_div %d",
+			__func__, player->clk_div);
+		return -EINVAL;
+	}
+
+	/* No sample rates below 32kHz are supported for iec958 */
+	if (runtime->rate < MIN_IEC958_SAMPLE_RATE) {
+		dev_err(player->dev, "Invalid rate (%d)", runtime->rate);
+		return -EINVAL;
+	}
+
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		/* 16/16 memory format */
+		SET_UNIPERIF_CONFIG_MEM_FMT_16_16(player);
+		/* 16-bits per sub-frame */
+		SET_UNIPERIF_I2S_FMT_NBIT_32(player);
+		/* Set 16-bit sample precision */
+		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(player);
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		/* 16/0 memory format */
+		SET_UNIPERIF_CONFIG_MEM_FMT_16_0(player);
+		/* 32-bits per sub-frame */
+		SET_UNIPERIF_I2S_FMT_NBIT_32(player);
+		/* Set 24-bit sample precision */
+		SET_UNIPERIF_I2S_FMT_DATA_SIZE_24(player);
+		break;
+	default:
+		dev_err(player->dev, "format not supported");
+		return -EINVAL;
+	}
+
+	/* Set parity to be calculated by the hardware */
+	SET_UNIPERIF_CONFIG_PARITY_CNTR_BY_HW(player);
+
+	/* Set channel status bits to be inserted by the hardware */
+	SET_UNIPERIF_CONFIG_CHANNEL_STA_CNTR_BY_HW(player);
+
+	/* Set user data bits to be inserted by the hardware */
+	SET_UNIPERIF_CONFIG_USER_DAT_CNTR_BY_HW(player);
+
+	/* Set validity bits to be inserted by the hardware */
+	SET_UNIPERIF_CONFIG_VALIDITY_DAT_CNTR_BY_HW(player);
+
+	/* Set full software control to disabled */
+	SET_UNIPERIF_CONFIG_SPDIF_SW_CTRL_DISABLE(player);
+
+	SET_UNIPERIF_CTRL_ZERO_STUFF_HW(player);
+
+	/* Update the channel status */
+	uni_player_set_channel_status(player, runtime);
+
+	/* Clear the user validity user bits */
+	SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
+
+	/* Disable one-bit audio mode */
+	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
+
+	/* Enable consecutive frames repetition of Z preamble (not for HBRA) */
+	SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(player);
+
+	/* Change to SUF0_SUBF1 and left/right channels swap! */
+	SET_UNIPERIF_CONFIG_SUBFRAME_SEL_SUBF1_SUBF0(player);
+
+	/* Set lr clock polarity and i2s mode using platform configuration */
+	/* Set data output on rising edge */
+	SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(player);
+
+	/* Set data aligned to left with respect to left-right clock polarity */
+	SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
+
+	/* Set data output as MSB first */
+	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
+
+	/* Set the number of channels (maximum supported by spdif is 2) */
+	if (UNIPERIF_PLAYER_TYPE_IS_SPDIF(player) &&
+	    (runtime->channels != 2)) {
+		dev_err(player->dev, "invalid nb of channels");
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_I2S_FMT_NUM_CH(player, runtime->channels / 2);
+
+	/* Set rounding to off */
+	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
+
+	/* Set clock divisor */
+	SET_UNIPERIF_CTRL_DIVIDER(player,
+				  player->clk_div / 128);
+
+	/* Set the spdif latency to not wait before starting player */
+	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
+
+	/*
+	 * Ensure iec958 formatting is off. It will be enabled in function
+	 * uni_player_start() at the same time as the operation
+	 * mode is set to work around a silicon issue.
+	 */
+	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(player);
+	else
+		SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
+
+	return 0;
+}
+
+static int uni_player_prepare_pcm(struct uniperif *player,
+				  struct snd_pcm_runtime *runtime)
+{
+	int output_frame_size, slot_width;
+
+	if (!runtime) {
+		dev_err(player->dev, "%s: invalid pointer(s)", __func__);
+		return -EINVAL;
+	}
+
+	/* force slot width to 32 in I2S mode (HW constraint) */
+	if ((player->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
+		SND_SOC_DAIFMT_I2S) {
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
+	output_frame_size = slot_width * runtime->channels;
+
+	if (player->clk_div <= 0) {
+		dev_err(player->dev, "%s: invalid clk_div", __func__);
+		return -EINVAL;
+	}
+
+	/* For 32 bits subframe clk_div must be a multiple of 128,
+	 * for 16 bits - of 64 */
+	if ((slot_width == 32) && (player->clk_div % 128)) {
+		dev_err(player->dev, "%s: invalid clk_div", __func__);
+		return -EINVAL;
+	}
+
+	if ((slot_width == 16) && (player->clk_div % 64)) {
+		dev_err(player->dev, "%s: invalid clk_div", __func__);
+		return -EINVAL;
+	}
+
+	/* Number of bits per subframe (which is one channel sample)
+	 * on output - Transfer 16 or 32 bits from FIFO
+	 */
+	switch (slot_width) {
+	case 32:
+		SET_UNIPERIF_I2S_FMT_NBIT_32(player);
+		SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(player);
+		break;
+	case 16:
+		SET_UNIPERIF_I2S_FMT_NBIT_16(player);
+		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(player);
+		break;
+	default:
+		dev_err(player->dev, "subframe format not supported");
+		return -EINVAL;
+	}
+
+	/* Configure data memory format */
+	switch (runtime->format) {
+	case SNDRV_PCM_FORMAT_S16_LE:
+		/* One data word contains two samples */
+		SET_UNIPERIF_CONFIG_MEM_FMT_16_16(player);
+		break;
+
+	case SNDRV_PCM_FORMAT_S32_LE:
+		/* Actually "16 bits/0 bits" means "32/28/24/20/18/16 bits
+		 * on the left than zeros (if less than 32 bytes)"... ;-) */
+		SET_UNIPERIF_CONFIG_MEM_FMT_16_0(player);
+		break;
+
+	default:
+		dev_err(player->dev, "format not supported");
+		return -EINVAL;
+	}
+
+	/* Set rounding to off */
+	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
+
+	/* Set clock divisor */
+	SET_UNIPERIF_CTRL_DIVIDER(player,
+				  player->clk_div / (2 * output_frame_size));
+
+	/* Number of channels... */
+
+	if ((runtime->channels % 2) || (runtime->channels < 2) ||
+	    (runtime->channels > 10)) {
+		dev_err(player->dev, "%s: invalid nb of channels", __func__);
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_I2S_FMT_NUM_CH(player, runtime->channels / 2);
+
+	/* Set 1-bit audio format to disabled */
+	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
+
+	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
+	SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
+
+	/* No iec958 formatting as outputting to DAC  */
+	SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(player);
+
+	return 0;
+}
+
+/*
+ * ALSA uniperipheral iec958 controls
+ */
+static int  uni_player_ctl_iec958_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+
+	return 0;
+}
+
+static int uni_player_ctl_iec958_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct uniperif *player = snd_kcontrol_chip(kcontrol);
+	struct snd_aes_iec958 *iec958 = &player->stream_settings.iec958;
+
+	spin_lock(&player->lock);
+	ucontrol->value.iec958.status[0] = iec958->status[0];
+	ucontrol->value.iec958.status[1] = iec958->status[1];
+	ucontrol->value.iec958.status[2] = iec958->status[2];
+	ucontrol->value.iec958.status[3] = iec958->status[3];
+	spin_unlock(&player->lock);
+	return 0;
+}
+
+static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct uniperif *player = snd_kcontrol_chip(kcontrol);
+	struct snd_aes_iec958 *iec958 =  &player->stream_settings.iec958;
+
+	spin_lock(&player->lock);
+	iec958->status[0] = ucontrol->value.iec958.status[0];
+	iec958->status[1] = ucontrol->value.iec958.status[1];
+	iec958->status[2] = ucontrol->value.iec958.status[2];
+	iec958->status[3] = ucontrol->value.iec958.status[3];
+	spin_unlock(&player->lock);
+
+	uni_player_set_channel_status(player, NULL);
+
+	return 0;
+}
+
+static struct snd_kcontrol_new uni_player_iec958_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+	.info = uni_player_ctl_iec958_info,
+	.get = uni_player_ctl_iec958_get,
+	.put = uni_player_ctl_iec958_put,
+};
+
+/*
+ * uniperif rate adjustement control
+ */
+static int snd_sti_clk_adjustment_info(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 1;
+	uinfo->value.integer.min = UNIPERIF_PLAYER_CLK_ADJ_MIN;
+	uinfo->value.integer.max = UNIPERIF_PLAYER_CLK_ADJ_MAX;
+	uinfo->value.integer.step = UNIPERIF_PLAYER_CLK_ADJ_STEP;
+
+	return 0;
+}
+
+static int snd_sti_clk_adjustment_get(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct uniperif *player = snd_kcontrol_chip(kcontrol);
+
+	spin_lock(&player->lock);
+	ucontrol->value.integer.value[0] = player->clk_adj;
+	spin_unlock(&player->lock);
+
+	return 0;
+}
+
+static int snd_sti_clk_adjustment_put(struct snd_kcontrol *kcontrol,
+				      struct snd_ctl_elem_value *ucontrol)
+{
+	struct uniperif *player = snd_kcontrol_chip(kcontrol);
+	int ret = 0;
+
+	if ((ucontrol->value.integer.value[0] < UNIPERIF_PLAYER_CLK_ADJ_MIN) ||
+	    (ucontrol->value.integer.value[0] > UNIPERIF_PLAYER_CLK_ADJ_MAX))
+		return -EINVAL;
+
+	spin_lock(&player->lock);
+	player->clk_adj = ucontrol->value.integer.value[0];
+
+	if (player->rate)
+		ret = uni_player_clk_set_rate(player,
+					      player->rate * player->clk_div);
+	spin_unlock(&player->lock);
+
+	return ret;
+}
+
+static struct snd_kcontrol_new uni_player_clk_adj_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name = "PCM Playback Oversampling Freq. Adjustment",
+	.info = snd_sti_clk_adjustment_info,
+	.get = snd_sti_clk_adjustment_get,
+	.put = snd_sti_clk_adjustment_put,
+};
+
+static struct snd_kcontrol_new *snd_sti_pcm_ctl[] = {
+	&uni_player_clk_adj_ctl,
+};
+
+static struct snd_kcontrol_new *snd_sti_iec_ctl[] = {
+	&uni_player_iec958_ctl,
+	&uni_player_clk_adj_ctl,
+};
+
+static int uni_player_open(struct uniperif *player)
+{
+	/* cancel pending delayed work (suspend) */
+	if (!cancel_delayed_work(&player->delayed_work))
+		flush_workqueue(uni_player_wq);
+
+	spin_lock(&player->lock);
+	player->rate = 0;
+	player->clk_adj = 0;
+	spin_unlock(&player->lock);
+
+	return 0;
+}
+
+static int uni_player_prepare(struct uniperif *player,
+			      struct snd_pcm_runtime *runtime)
+{
+	int transfer_size, trigger_limit;
+	int ret;
+
+	/* The player should be stopped or in standby */
+	if ((player->state != UNIPERIF_STATE_STOPPED) &&
+	    (player->state != UNIPERIF_STATE_STANDBY)) {
+		dev_err(player->dev, "%s: invalid player state %d", __func__,
+			player->state);
+		return -EINVAL;
+	}
+
+	/* Calculate transfer size (in fifo cells and bytes) for frame count */
+	transfer_size = runtime->channels * UNIPERIF_FIFO_FRAMES;
+
+	/* Calculate number of empty cells available before asserting DREQ */
+	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		trigger_limit = UNIPERIF_FIFO_SIZE - transfer_size;
+	else
+		/* Since SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
+		 * FDMA_TRIGGER_LIMIT also controls when the state switches
+		 * from OFF or STANDBY to AUDIO DATA.*/
+		trigger_limit = transfer_size;
+
+	/* Trigger limit must be an even number */
+	if ((!trigger_limit % 2) || (trigger_limit != 1 && transfer_size % 2) ||
+	    (trigger_limit > UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(player))) {
+		dev_err(player->dev, "invalid trigger limit %d", trigger_limit);
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(player, trigger_limit);
+
+	/* Uniperipheral setup is depend on player type */
+	switch (player->info->player_type) {
+	case SND_ST_UNIPERIF_PLAYER_TYPE_HDMI:
+		ret = uni_player_prepare_iec958(player, runtime);
+		break;
+	case SND_ST_UNIPERIF_PLAYER_TYPE_PCM:
+		ret = uni_player_prepare_pcm(player, runtime);
+		break;
+	case SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF:
+		ret = uni_player_prepare_iec958(player, runtime);
+		break;
+	default:
+		dev_err(player->dev, "invalid player type");
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	switch (player->daifmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+	case SND_SOC_DAIFMT_NB_IF:
+		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
+		break;
+	default:
+		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(player);
+	}
+
+	switch (player->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
+		SET_UNIPERIF_I2S_FMT_PADDING_I2S_MODE(player);
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
+		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(player);
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		SET_UNIPERIF_I2S_FMT_ALIGN_RIGHT(player);
+		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(player);
+		break;
+	default:
+		dev_err(player->dev, "format not supported");
+		return -EINVAL;
+	}
+
+	/* Set the interrupt mask */
+	SET_UNIPERIF_ITM_BSET_DMA_ERROR(player);
+	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(player);
+
+	/* Enable underflow recovery interrupts */
+	if (player->info->underflow_enabled) {
+		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(player);
+		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(player);
+	}
+
+	/* Set clock rate */
+	spin_lock(&player->lock);
+	ret = uni_player_clk_set_rate(player,
+				      runtime->rate * player->clk_div);
+	if (ret) {
+		dev_err(player->dev, "Failed to set clock rate");
+		spin_unlock(&player->lock);
+		return ret;
+	}
+
+	player->rate = runtime->rate;
+	spin_unlock(&player->lock);
+
+	if (player->state == UNIPERIF_STATE_STANDBY) {
+		/* We are moving from standby to started
+		 *Synchronise transition out of standby
+		 */
+		if ((UNIPERIF_PLAYER_TYPE_IS_IEC958(player)) &&
+		    (player->stream_settings.encoding_mode ==
+				UNIPERIF_IEC958_ENCODING_MODE_ENCODED))
+			SET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_ON(player);
+		else
+			SET_UNIPERIF_CTRL_EXIT_STBY_ON_EOBLOCK_OFF(
+					player);
+		return 0;
+	}
+
+	SET_UNIPERIF_I2S_FMT_NO_OF_SAMPLES_TO_READ(player, 0);
+
+	/* Reset uniperipheral player */
+	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
+
+	return reset_player(player);
+}
+
+static int uni_player_start(struct uniperif *player)
+{
+	int ret;
+
+	/* The player should be stopped ot in standby */
+	if ((player->state != UNIPERIF_STATE_STOPPED) &&
+	    (player->state != UNIPERIF_STATE_STANDBY)) {
+		dev_err(player->dev, "%s: invalid player state", __func__);
+		return -EINVAL;
+	}
+
+	/* pinctrl: switch pinstate to default */
+	ret = pinctrl_pm_select_default_state(player->dev);
+	if (ret) {
+		dev_err(player->dev,
+			"%s: failed to select default pinctrl state",
+			__func__);
+		return ret;
+	}
+
+	/* Check if we are moving from standby state to started */
+	if (player->state == UNIPERIF_STATE_STANDBY) {
+		/* Set the player to audio/pcm data mode */
+		SET_UNIPERIF_CTRL_OPERATION_AUDIO_DATA(player);
+
+		/* Clear any pending interrupts */
+		SET_UNIPERIF_ITS_BCLR(player, GET_UNIPERIF_ITS(player));
+
+		/* Enable player interrupts */
+		enable_irq(player->irq);
+
+		/* Update state to started and return */
+		player->state = UNIPERIF_STATE_STARTED;
+		return 0;
+	}
+
+	ret = clk_prepare_enable(player->clk);
+	if (ret) {
+		dev_err(player->dev, "%s: Failed to enable clock", __func__);
+		return ret;
+	}
+
+	/* Clear any pending interrupts */
+	SET_UNIPERIF_ITS_BCLR(player, GET_UNIPERIF_ITS(player));
+
+	/* Enable player interrupts */
+	enable_irq(player->irq);
+
+	/* Reset uniperipheral player */
+	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
+
+	ret = reset_player(player);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Does not use IEC61937 features of the uniperipheral hardware.
+	 * Instead it performs IEC61937 in software and inserts it directly
+	 * into the audio data stream. As such, when encoded mode is selected,
+	 * linear pcm mode is still used, but with the differences of the
+	 * channel status bits set for encoded mode and the validity bits set.
+	 */
+
+	SET_UNIPERIF_CTRL_OPERATION_PCM_DATA(player);
+
+	/*
+	 * If iec958 formatting is required for hdmi or spdif, then it must be
+	 * enabled after the operation mode is set. If set prior to this, it
+	 * will not take affect and hang the player.
+	 */
+
+	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player))
+				SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
+
+	/* Force channel status update (no update if clk disable) */
+	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		SET_UNIPERIF_CONFIG_CHL_STS_UPDATE(player);
+	else
+		SET_UNIPERIF_BIT_CONTROL_CHL_STS_UPDATE(player);
+
+	/* Update state to started */
+	player->state = UNIPERIF_STATE_STARTED;
+
+	return 0;
+}
+
+static int uni_player_stop(struct uniperif *player)
+{
+	int ret;
+
+	/* The player should not be in stopped state */
+	if (player->state == UNIPERIF_STATE_STOPPED) {
+		dev_err(player->dev, "%s: invalid player state", __func__);
+		return -EINVAL;
+	}
+
+	/* Turn the player off */
+	SET_UNIPERIF_CTRL_OPERATION_OFF(player);
+
+	/* Soft reset the player */
+	SET_UNIPERIF_SOFT_RST_SOFT_RST(player);
+
+	ret = reset_player(player);
+	if (ret < 0)
+		return ret;
+
+	if (player->state != UNIPERIF_STATE_STANDBY) {
+		/* Disable interrupts */
+		SET_UNIPERIF_ITM_BCLR(player, GET_UNIPERIF_ITM(player));
+		disable_irq_nosync(player->irq);
+	}
+
+	/* Disable clock */
+	clk_disable_unprepare(player->clk);
+
+	/* Update state to stopped and return */
+	player->state = UNIPERIF_STATE_STOPPED;
+
+	/* pinctrl: switch pinstate to sleep */
+	ret = pinctrl_pm_select_sleep_state(player->dev);
+	if (ret) {
+		dev_err(player->dev,
+			"%s: failed to select sleep pinctrl state",
+			__func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int uni_player_standby(struct uniperif *player)
+{
+	/* Check if we should enable standby mode */
+	if ((player->state == UNIPERIF_STATE_STARTED) &&
+	    (player->info->standby_enabled == 1)) {
+		/* Disable interrupts */
+		SET_UNIPERIF_ITM_BCLR(player, GET_UNIPERIF_ITM(player));
+		disable_irq_nosync(player->irq);
+
+		/* Set standby mode */
+		SET_UNIPERIF_CTRL_OPERATION_STANDBY(player);
+
+		/* Update state to standby and return */
+		player->state = UNIPERIF_STATE_STANDBY;
+		return 0;
+	}
+
+	return uni_player_stop(player);
+}
+
+static int uni_player_suspend(struct uniperif *player)
+{
+	/* The player should be in stopped or standby state */
+	if ((player->state != UNIPERIF_STATE_STOPPED) &&
+	    (player->state != UNIPERIF_STATE_STANDBY)) {
+		dev_err(player->dev, "%s: invalid player state( %d)",
+			__func__, (int)player->state);
+		return -EBUSY;
+	}
+	if (player->state == UNIPERIF_STATE_STANDBY)
+		return uni_player_stop(player);
+
+	return 0;
+}
+
+static int uni_player_resume(struct uniperif *player)
+{
+	int ret;
+
+	/* select the frequency synthesizer clock */
+	if (player->clk_sel) {
+		ret = regmap_field_write(player->clk_sel, 1);
+		if (ret) {
+			dev_err(player->dev,
+				"%s: Failed to select freq synth clock",
+				__func__);
+			return ret;
+		}
+	}
+
+	/* cancel pending delayed work (suspend) */
+	if (!cancel_delayed_work(&player->delayed_work))
+		flush_workqueue(uni_player_wq);
+
+	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
+	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
+	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
+	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
+
+	return 0;
+}
+
+static int  uni_player_trigger(struct uniperif *player, int cmd)
+{
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		return uni_player_start(player);
+	case SNDRV_PCM_TRIGGER_STOP:
+		return uni_player_standby(player);
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		return uni_player_suspend(player);
+	case SNDRV_PCM_TRIGGER_RESUME:
+		return uni_player_resume(player);
+	default:
+		return -EINVAL;
+	}
+}
+
+static void uni_player_close(struct uniperif *player)
+{
+	if (player->state == UNIPERIF_STATE_STANDBY) {
+		/* Keep uni player in standby and trigger delayed suspend */
+		if (player->info->suspend_delay)
+			queue_delayed_work(uni_player_wq,
+				&player->delayed_work,
+				msecs_to_jiffies(player->info->suspend_delay));
+		return;
+	}
+
+	if (player->state != UNIPERIF_STATE_STOPPED) {
+		/* Stop the player */
+		uni_player_stop(player);
+	}
+}
+
+/*
+ * Platform driver routines
+ */
+
+static int uni_player_parse_dt_clk_glue(struct platform_device *pdev,
+					struct uniperif *player)
+{
+	int bit_offset;
+	struct device_node *node = pdev->dev.of_node;
+	struct regmap *regmap;
+
+	bit_offset = SYS_CFG_AUDI0_GLUE_PCM_CLKX + player->info->uni_num;
+
+	regmap = syscon_regmap_lookup_by_phandle(node, "st,syscfg");
+
+	if (regmap) {
+		struct reg_field regfield =
+			REG_FIELD(SYS_CFG_AUDIO_GLUE, bit_offset, bit_offset);
+
+		player->clk_sel = regmap_field_alloc(regmap, regfield);
+	} else {
+		dev_err(&pdev->dev, "sti-audio-clk-glue syscf not found\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int uni_player_parse_dt(struct platform_device *pdev,
+			       struct device_node *pnode,
+			       struct uniperif *player)
+{
+	struct uniperif_info *info;
+	struct device *dev = &pdev->dev;
+	const char *mode;
+
+	/* Allocate memory for the info structure */
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	if (!pnode) {
+		dev_err(dev, "%s: invalid pnode", __func__);
+		return -EINVAL;
+	}
+
+	of_property_read_u32(pnode, "version", &info->ver);
+
+	of_property_read_u32(pnode, "uniperiph-id", &info->uni_num);
+
+	/* Read the device mode property */
+	of_property_read_string(pnode, "mode", &mode);
+
+	if (strcasecmp(mode, "hdmi") == 0)
+		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_HDMI;
+	else if (strcasecmp(mode, "pcm") == 0)
+		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_PCM;
+	else if (strcasecmp(mode, "spdif") == 0)
+		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF;
+	else
+		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_NONE;
+
+	/* Read the device features properties */
+	of_property_read_u32(pnode, "underflow", &info->underflow_enabled);
+	of_property_read_u32(pnode, "standby", &info->standby_enabled);
+
+	/* Save the info structure */
+	player->info = info;
+
+	/* get the PCM_CLK_SEL bit from audio-glue-ctrl SoC register */
+	if (uni_player_parse_dt_clk_glue(pdev, player))
+		return -EINVAL;
+
+	of_property_read_u32(pnode, "auto-suspend-delay",
+			     &info->suspend_delay);
+	if (info->suspend_delay)
+		if (info->suspend_delay < MIN_AUTOSUPEND_DELAY_MS) {
+			info->suspend_delay = MIN_AUTOSUPEND_DELAY_MS;
+			dev_info(dev,
+				 "%s: auto-suspend-delay set to min: %d ms",
+				 __func__, info->suspend_delay);
+		}
+
+	return 0;
+}
+
+const struct uniperif_ops uni_player_ops = {
+	.open = uni_player_open,
+	.close = uni_player_close,
+	.prepare = uni_player_prepare,
+	.trigger = uni_player_trigger
+};
+
+int uni_player_init(struct platform_device *pdev, struct device_node *node,
+		    struct uniperif **uni_player, int idx)
+{
+	struct uniperif *player;
+	int ret = 0;
+
+	player = devm_kzalloc(&pdev->dev, sizeof(*player), GFP_KERNEL);
+
+	if (!player)
+		return -ENOMEM;
+
+	player->dev = &pdev->dev;
+	player->state = UNIPERIF_STATE_STOPPED;
+	player->hw = &uni_player_pcm_hw;
+	player->ops = &uni_player_ops;
+
+	ret = uni_player_parse_dt(pdev, node, player);
+
+	if (ret < 0) {
+		dev_err(player->dev, "Failed to parse DeviceTree");
+		return ret;
+	}
+
+	/* get uniperif resource */
+	player->clk = of_clk_get(pdev->dev.of_node, idx);
+
+	if (IS_ERR(player->clk)) {
+		ret = (int)PTR_ERR(player->clk);
+		dev_err(player->dev, "%s: ERROR: clk_get failed (%d)!\n",
+			__func__, ret);
+		return -EINVAL;
+	}
+
+	/* select the frequency synthesizer clock */
+	if (player->clk_sel) {
+		ret = regmap_field_write(player->clk_sel, 1);
+		if (ret) {
+			dev_err(player->dev,
+				"%s: Failed to select freq synth clock",
+				__func__);
+			return ret;
+		}
+	}
+
+	if (player->info->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
+		dev_err(player->dev, "Unknown uniperipheral version ");
+		return -EINVAL;
+	}
+	player->ver = player->info->ver;
+
+	/* Check for underflow recovery being enabled */
+	if (player->info->underflow_enabled)
+		/* Underflow recovery is only supported on later ip revisions */
+		if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0) {
+			dev_err(player->dev,
+				"underflow recovery not supported");
+			player->info->underflow_enabled = 0;
+		}
+
+	/* Get resources */
+
+	player->mem_region = platform_get_resource(pdev, IORESOURCE_MEM, idx);
+
+	if (!player->mem_region) {
+		dev_err(&pdev->dev, "Failed to get memory resource");
+		return -ENODEV;
+	}
+
+	player->base = devm_ioremap_resource(&pdev->dev,
+							player->mem_region);
+
+	if (!player->base) {
+		dev_err(&pdev->dev, "Failed to ioremap memory region");
+		return -ENXIO;
+	}
+
+	player->fifo_phys_address = player->mem_region->start +
+					UNIPERIF_FIFO_DATA_OFFSET(player);
+
+	player->irq = platform_get_irq(pdev, idx);
+
+	if (player->irq < 0) {
+		dev_err(&pdev->dev, "Failed to get IRQ resource");
+		return -ENXIO;
+	}
+
+	ret = devm_request_irq(&pdev->dev, player->irq,
+			       uni_player_irq_handler, IRQF_SHARED,
+			       dev_name(&pdev->dev), player);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to request IRQ");
+		return -EBUSY;
+	}
+
+	/* request_irq() enables the interrupt immediately; as it is
+	 * lethal in concurrent audio environment, we want to have
+	 * it disabled for most of the time...
+	 */
+	disable_irq(player->irq);
+
+	player->clk_div = DEFAULT_OVERSAMPLING;
+
+	*uni_player = player;
+
+	spin_lock_init(&player->lock);
+
+	/* ensure that disabled by default */
+	SET_UNIPERIF_CONFIG_BACK_STALL_REQ_DISABLE(player);
+	SET_UNIPERIF_CTRL_ROUNDING_OFF(player);
+	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
+	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
+
+	if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player)) {
+		/* Set default iec958 status bits  */
+
+		/* Consumer, PCM, copyright, 2ch, mode 0 */
+		player->stream_settings.iec958.status[0] = 0x00;
+		/* Broadcast reception category */
+		player->stream_settings.iec958.status[1] =
+					IEC958_AES1_CON_GENERAL;
+		/* Do not take into account source or channel number */
+		player->stream_settings.iec958.status[2] =
+					IEC958_AES2_CON_SOURCE_UNSPEC;
+		/* Sampling frequency not indicated */
+		player->stream_settings.iec958.status[3] =
+					IEC958_AES3_CON_FS_NOTID;
+		/* Max sample word 24-bit, sample word length not indicated */
+		player->stream_settings.iec958.status[4] =
+					IEC958_AES4_CON_MAX_WORDLEN_24 |
+					IEC958_AES4_CON_WORDLEN_24_20;
+
+		player->num_ctrls = ARRAY_SIZE(snd_sti_iec_ctl);
+		player->snd_ctrls = snd_sti_iec_ctl[0];
+	} else {
+		player->num_ctrls = ARRAY_SIZE(snd_sti_pcm_ctl);
+		player->snd_ctrls = snd_sti_pcm_ctl[0];
+	}
+
+	uni_player_wq = create_workqueue("uni_player_workqueue");
+	if (!uni_player_wq)
+		return -ENOMEM;
+
+	INIT_DELAYED_WORK(&player->delayed_work, uni_player_work);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uni_player_init);
+
+int uni_player_remove(struct platform_device *pdev)
+{
+	struct uniperif *player = platform_get_drvdata(pdev);
+
+	if (player->clk)
+		clk_put(player->clk);
+
+	if (uni_player_wq)
+		destroy_workqueue(uni_player_wq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(uni_player_remove);
-- 
1.9.1
