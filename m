From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 2/4] ASoC: sti: tdm: uni tdm mode
Date: Thu, 31 Mar 2016 18:00:56 +0200
Message-ID: <1459440058-12234-3-git-send-email-moise.gergaud@st.com>
References: <1459440058-12234-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id EAA732651B7
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 18:01:20 +0200 (CEST)
In-Reply-To: <1459440058-12234-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

Implement tdm mode for uni player & reader:
- Remove "player" in uni type enum => common type enum for player & reader
- When TDM_ENABLE is set to 1, the i2s format should be automatically
configured. Unfortunately this is not the case (HW bug). Then, we shall
force DATA_SIZE setting.
- Compute the transfer size for tdm mode: transfer size = user frame size
- Manage tdm slots configuration given in DT.
- Don't use mclk-fs when unip in tdm mode; use tdm slot config to compute
frame size and to set mclk rate.
- Refine the hw param (channels & format) according to tdm slot config.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/sti_uniperif.c    | 144 ++++++++++++++++++++++++-
 sound/soc/sti/uniperif.h        | 197 +++++++++++++++++++++++++++++++++-
 sound/soc/sti/uniperif_player.c | 140 +++++++++++++++++-------
 sound/soc/sti/uniperif_reader.c | 229 +++++++++++++++++++++++++++++-----------
 4 files changed, 606 insertions(+), 104 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 39bcefe..488ef4e 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -11,6 +11,142 @@
 #include "uniperif.h"
 
 /*
+ * User frame size shall be 2, 4, 6 or 8 32-bits words length
+ * (i.e. 8, 16, 24 or 32 bytes)
+ * This constraint comes from allowed values for
+ * UNIPERIF_I2S_FMT_NUM_CH register
+ */
+#define UNIPERIF_MAX_FRAME_SZ 0x20
+#define UNIPERIF_ALLOWED_FRAME_SZ (0x08 | 0x10 | 0x18 | UNIPERIF_MAX_FRAME_SZ)
+
+int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots,
+			       int slot_width)
+{
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *uni = priv->dai_data.uni;
+	int i, frame_size, avail_slots;
+
+	if (!UNIPERIF_TYPE_IS_TDM(uni)) {
+		dev_err(uni->dev, "cpu dai not in tdm mode\n");
+		return -EINVAL;
+	}
+
+	/* store info in unip context */
+	uni->tdm_slot.slots = slots;
+	uni->tdm_slot.slot_width = slot_width;
+	/* unip is unidirectionnal */
+	uni->tdm_slot.mask = (tx_mask != 0) ? tx_mask : rx_mask;
+
+	/* number of available timeslots */
+	for (i = 0, avail_slots = 0; i < uni->tdm_slot.slots; i++) {
+		if ((uni->tdm_slot.mask >> i) & 0x01)
+			avail_slots++;
+	}
+	uni->tdm_slot.avail_slots = avail_slots;
+
+	/* frame size in bytes */
+	frame_size = uni->tdm_slot.avail_slots * uni->tdm_slot.slot_width / 8;
+
+	/* check frame size is allowed */
+	if ((frame_size > UNIPERIF_MAX_FRAME_SZ) ||
+	    (frame_size & ~(int)UNIPERIF_ALLOWED_FRAME_SZ)) {
+		dev_err(uni->dev, "frame size not allowed: %d bytes\n",
+			frame_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int sti_uniperiph_fix_tdm_chan(struct snd_pcm_hw_params *params,
+			       struct snd_pcm_hw_rule *rule)
+{
+	struct uniperif *uni = rule->private;
+	struct snd_interval t;
+
+	t.min = uni->tdm_slot.avail_slots;
+	t.max = uni->tdm_slot.avail_slots;
+	t.openmin = 0;
+	t.openmax = 0;
+	t.integer = 0;
+
+	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
+}
+
+int sti_uniperiph_fix_tdm_format(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule)
+{
+	struct uniperif *uni = rule->private;
+	struct snd_mask *maskp = hw_param_mask(params, rule->var);
+	u64 format;
+
+	switch (uni->tdm_slot.slot_width) {
+	case 16:
+		format = SNDRV_PCM_FMTBIT_S16_LE;
+		break;
+	case 32:
+		format = SNDRV_PCM_FMTBIT_S32_LE;
+		break;
+	default:
+		dev_err(uni->dev, "format not supported: %d bits\n",
+			uni->tdm_slot.slot_width);
+		return -EINVAL;
+	}
+
+	maskp->bits[0] &= (u_int32_t)format;
+	maskp->bits[1] &= (u_int32_t)(format >> 32);
+	/* clear remaining indexes */
+	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX - 64) / 8);
+
+	if (!maskp->bits[0] && !maskp->bits[1])
+		return -EINVAL;
+
+	return 0;
+}
+
+int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
+				   unsigned int *word_pos)
+{
+	int slot_width = uni->tdm_slot.slot_width / 8;
+	int slots_num = uni->tdm_slot.slots;
+	unsigned int slots_mask = uni->tdm_slot.mask;
+	int i, j, k;
+	unsigned int word16_pos[4];
+
+	/* word16_pos:
+	 * word16_pos[0] = WORDX_LSB
+	 * word16_pos[1] = WORDX_MSB,
+	 * word16_pos[2] = WORDX+1_LSB
+	 * word16_pos[3] = WORDX+1_MSB
+	 */
+
+	/* set unip word position */
+	for (i = 0, j = 0, k = 0; (i < slots_num) && (k < WORD_MAX); i++) {
+		if ((slots_mask >> i) & 0x01) {
+			word16_pos[j] = i * slot_width;
+
+			if (slot_width == 4) {
+				word16_pos[j + 1] = word16_pos[j] + 2;
+				j++;
+			}
+			j++;
+
+			if (j > 3) {
+				word_pos[k] = word16_pos[1] |
+					      (word16_pos[0] << 8) |
+					      (word16_pos[3] << 16) |
+					      (word16_pos[2] << 24);
+				j = 0;
+				k++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/*
  * sti_uniperiph_dai_create_ctrl
  * This function is used to create Ctrl associated to DAI but also pcm device.
  * Request is done by front end to associate ctrl with pcm device id
@@ -45,10 +181,16 @@ int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *uni = priv->dai_data.uni;
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	int transfer_size;
 
-	transfer_size = params_channels(params) * UNIPERIF_FIFO_FRAMES;
+	if (uni->info->type == SND_ST_UNIPERIF_TYPE_TDM)
+		/* transfer size = user frame size (in 32-bits FIFO cell) */
+		transfer_size = snd_soc_params_to_frame_size(params) / 32;
+	else
+		transfer_size = params_channels(params) * UNIPERIF_FIFO_FRAMES;
 
 	dma_data = snd_soc_dai_get_dma_data(dai, substream);
 	dma_data->maxburst = transfer_size;
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 1f82faa..d0e2446 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1101,12 +1101,136 @@
 		UNIPERIF_DBG_STANDBY_LEFT_SP_MASK(ip), value)
 
 /*
+ * UNIPERIF_TDM_ENABLE
+ */
+#define UNIPERIF_TDM_ENABLE_OFFSET(ip) 0x0118
+#define GET_UNIPERIF_TDM_ENABLE(ip) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_ENABLE_OFFSET(ip))
+#define SET_UNIPERIF_TDM_ENABLE(ip, value) \
+	writel_relaxed(value, ip->base + UNIPERIF_TDM_ENABLE_OFFSET(ip))
+
+/* TDM_ENABLE */
+#define UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip) 0x0
+#define UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip) 0x1
+#define GET_UNIPERIF_TDM_ENABLE_EN_TDM(ip) \
+		GET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip))
+#define SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip), 1)
+#define SET_UNIPERIF_TDM_ENABLE_TDM_DISABLE(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_ENABLE_OFFSET(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_SHIFT(ip), \
+		UNIPERIF_TDM_ENABLE_EN_TDM_MASK(ip), 0)
+
+/*
+ * UNIPERIF_TDM_FS_REF_FREQ
+ */
+#define UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip) 0x011c
+#define GET_UNIPERIF_TDM_FS_REF_FREQ(ip) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ(ip, value) \
+	writel_relaxed(value, ip->base + \
+			UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip))
+
+/* REF_FREQ */
+#define UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip) 0x0
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip) 0
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip) 1
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip) 2
+#define VALUE_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip) 3
+#define UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip) 0x3
+#define GET_UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ(ip) \
+		GET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_8KHZ(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_16KHZ(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_32KHZ(ip))
+#define SET_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_FREQ_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_FREQ_REF_FREQ_MASK(ip), \
+		VALUE_UNIPERIF_TDM_FS_REF_FREQ_48KHZ(ip))
+
+/*
+ * UNIPERIF_TDM_FS_REF_DIV
+ */
+#define UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip) 0x0120
+#define GET_UNIPERIF_TDM_FS_REF_DIV(ip) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip))
+#define SET_UNIPERIF_TDM_FS_REF_DIV(ip, value) \
+		writel_relaxed(value, ip->base + \
+			UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip))
+
+/* NUM_TIMESLOT */
+#define UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip) 0x0
+#define UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip) 0xff
+#define GET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(ip) \
+		GET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip))
+#define SET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(ip, value) \
+		SET_UNIPERIF_REG(ip, \
+		UNIPERIF_TDM_FS_REF_DIV_OFFSET(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_SHIFT(ip), \
+		UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT_MASK(ip), value)
+
+/*
+ * UNIPERIF_TDM_WORD_POS_X_Y
+ * 32 bits of UNIPERIF_TDM_WORD_POS_X_Y register shall be set in 1 shot
+ */
+#define UNIPERIF_TDM_WORD_POS_1_2_OFFSET(ip) 0x013c
+#define UNIPERIF_TDM_WORD_POS_3_4_OFFSET(ip) 0x0140
+#define UNIPERIF_TDM_WORD_POS_5_6_OFFSET(ip) 0x0144
+#define UNIPERIF_TDM_WORD_POS_7_8_OFFSET(ip) 0x0148
+#define GET_UNIPERIF_TDM_WORD_POS(ip, words) \
+	readl_relaxed(ip->base + UNIPERIF_TDM_WORD_POS_##words##_OFFSET(ip))
+#define SET_UNIPERIF_TDM_WORD_POS(ip, words, value) \
+		writel_relaxed(value, ip->base + \
+		UNIPERIF_TDM_WORD_POS_##words##_OFFSET(ip))
+/*
  * uniperipheral IP capabilities
  */
 
 #define UNIPERIF_FIFO_SIZE		70 /* FIFO is 70 cells deep */
 #define UNIPERIF_FIFO_FRAMES		4  /* FDMA trigger limit in frames */
 
+#define UNIPERIF_TYPE_IS_HDMI(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_HDMI)
+#define UNIPERIF_TYPE_IS_PCM(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_PCM)
+#define UNIPERIF_TYPE_IS_SPDIF(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_SPDIF)
+#define UNIPERIF_TYPE_IS_IEC958(p) \
+	(UNIPERIF_TYPE_IS_HDMI(p) || \
+		UNIPERIF_TYPE_IS_SPDIF(p))
+#define UNIPERIF_TYPE_IS_TDM(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_TDM)
+
 /*
  * Uniperipheral IP revisions
  */
@@ -1125,10 +1249,11 @@ enum uniperif_version {
 };
 
 enum uniperif_type {
-	SND_ST_UNIPERIF_PLAYER_TYPE_NONE,
-	SND_ST_UNIPERIF_PLAYER_TYPE_HDMI,
-	SND_ST_UNIPERIF_PLAYER_TYPE_PCM,
-	SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF
+	SND_ST_UNIPERIF_TYPE_NONE,
+	SND_ST_UNIPERIF_TYPE_HDMI,
+	SND_ST_UNIPERIF_TYPE_PCM,
+	SND_ST_UNIPERIF_TYPE_SPDIF,
+	SND_ST_UNIPERIF_TYPE_TDM
 };
 
 enum uniperif_state {
@@ -1145,9 +1270,17 @@ enum uniperif_iec958_encoding_mode {
 	UNIPERIF_IEC958_ENCODING_MODE_ENCODED
 };
 
+enum uniperif_word_pos {
+	WORD_1_2,
+	WORD_3_4,
+	WORD_5_6,
+	WORD_7_8,
+	WORD_MAX
+};
+
 struct uniperif_info {
 	int id; /* instance value of the uniperipheral IP */
-	enum uniperif_type player_type;
+	enum uniperif_type type;
 	int underflow_enabled;		/* Underflow recovery mode */
 };
 
@@ -1156,6 +1289,13 @@ struct uniperif_iec958_settings {
 	struct snd_aes_iec958 iec958;
 };
 
+struct dai_tdm_slot {
+	unsigned int mask;
+	int slots;
+	int slot_width;
+	unsigned int avail_slots;
+};
+
 struct uniperif {
 	/* System information */
 	struct uniperif_info *info;
@@ -1192,6 +1332,7 @@ struct uniperif {
 
 	/* dai properties */
 	unsigned int daifmt;
+	struct dai_tdm_slot tdm_slot;
 
 	/* DAI callbacks */
 	const struct snd_soc_dai_ops *dai_ops;
@@ -1209,6 +1350,28 @@ struct sti_uniperiph_data {
 	struct sti_uniperiph_dai dai_data;
 };
 
+static const struct snd_pcm_hardware uni_tdm_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID,
+
+	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE,
+
+	.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min = 8000,
+	.rate_max = 48000,
+
+	.channels_min = 1,
+	.channels_max = 32,
+
+	.periods_min = 2,
+	.periods_max = 10,
+
+	.period_bytes_min = 128,
+	.period_bytes_max = 64 * PAGE_SIZE,
+	.buffer_bytes_max = 256 * PAGE_SIZE
+};
+
 /* uniperiph player*/
 int uni_player_init(struct platform_device *pdev,
 		    struct uniperif *uni_player);
@@ -1226,4 +1389,28 @@ int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai);
 
+static inline int sti_uniperiph_get_user_frame_size(
+	struct snd_pcm_runtime *runtime)
+{
+	return (runtime->channels * snd_pcm_format_width(runtime->format) / 8);
+}
+
+static inline int sti_uniperiph_get_unip_tdm_frame_size(struct uniperif *uni)
+{
+	return (uni->tdm_slot.slots * uni->tdm_slot.slot_width / 8);
+}
+
+int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+			       unsigned int rx_mask, int slots,
+			       int slot_width);
+
+int sti_uniperiph_get_tdm_word_pos(struct uniperif *uni,
+				   unsigned int *word_pos);
+
+int sti_uniperiph_fix_tdm_chan(struct snd_pcm_hw_params *params,
+			       struct snd_pcm_hw_rule *rule);
+
+int sti_uniperiph_fix_tdm_format(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule *rule);
+
 #endif
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 7aca6b9..ff2d735 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -26,15 +26,6 @@
 /*
  * Driver specific types.
  */
-#define UNIPERIF_PLAYER_TYPE_IS_HDMI(p) \
-	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_HDMI)
-#define UNIPERIF_PLAYER_TYPE_IS_PCM(p) \
-	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_PCM)
-#define UNIPERIF_PLAYER_TYPE_IS_SPDIF(p) \
-	((p)->info->player_type == SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF)
-#define UNIPERIF_PLAYER_TYPE_IS_IEC958(p) \
-	(UNIPERIF_PLAYER_TYPE_IS_HDMI(p) || \
-		UNIPERIF_PLAYER_TYPE_IS_SPDIF(p))
 
 #define UNIPERIF_PLAYER_CLK_ADJ_MIN  -999999
 #define UNIPERIF_PLAYER_CLK_ADJ_MAX  1000000
@@ -444,18 +435,11 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 
 	/* Force slot width to 32 in I2S mode (HW constraint) */
 	if ((player->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) ==
-		SND_SOC_DAIFMT_I2S) {
+		SND_SOC_DAIFMT_I2S)
 		slot_width = 32;
-	} else {
-		switch (runtime->format) {
-		case SNDRV_PCM_FORMAT_S16_LE:
-			slot_width = 16;
-			break;
-		default:
-			slot_width = 32;
-			break;
-		}
-	}
+	else
+		slot_width = snd_pcm_format_width(runtime->format);
+
 	output_frame_size = slot_width * runtime->channels;
 
 	clk_div = player->mclk / runtime->rate;
@@ -530,7 +514,6 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
 
 	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
-	SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
 
 	/* No iec958 formatting as outputting to DAC  */
 	SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(player);
@@ -538,6 +521,55 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 	return 0;
 }
 
+static int uni_player_prepare_tdm(struct uniperif *player,
+				  struct snd_pcm_runtime *runtime)
+{
+	int tdm_frame_size; /* unip tdm frame size in bytes */
+	int user_frame_size; /* user tdm frame size in bytes */
+	/* default unip TDM_WORD_POS_X_Y */
+	unsigned int word_pos[4] = {
+		0x04060002, 0x0C0E080A, 0x14161012, 0x1C1E181A};
+	int freq, ret;
+
+	tdm_frame_size =
+		sti_uniperiph_get_unip_tdm_frame_size(player);
+	user_frame_size =
+		sti_uniperiph_get_user_frame_size(runtime);
+
+	/* fix 16/0 format */
+	SET_UNIPERIF_CONFIG_MEM_FMT_16_0(player);
+	SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(player);
+
+	/* number of words inserted on the TDM line */
+	SET_UNIPERIF_I2S_FMT_NUM_CH(player, user_frame_size / 4 / 2);
+
+	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
+	SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(player);
+
+	/* Enable the tdm functionality */
+	SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(player);
+
+	/* number of 8 bits timeslots avail in unip tdm frame */
+	SET_UNIPERIF_TDM_FS_REF_DIV_NUM_TIMESLOT(player, tdm_frame_size);
+
+	/* set the timeslot allocation for words in FIFO */
+	sti_uniperiph_get_tdm_word_pos(player, word_pos);
+	SET_UNIPERIF_TDM_WORD_POS(player, 1_2, word_pos[WORD_1_2]);
+	SET_UNIPERIF_TDM_WORD_POS(player, 3_4, word_pos[WORD_3_4]);
+	SET_UNIPERIF_TDM_WORD_POS(player, 5_6, word_pos[WORD_5_6]);
+	SET_UNIPERIF_TDM_WORD_POS(player, 7_8, word_pos[WORD_7_8]);
+
+	/* set unip clk rate (not done vai set_sysclk ops) */
+	freq = runtime->rate * tdm_frame_size * 8;
+	mutex_lock(&player->ctrl_lock);
+	ret = uni_player_clk_set_rate(player, freq);
+	if (!ret)
+		player->mclk = freq;
+	mutex_unlock(&player->ctrl_lock);
+
+	return 0;
+}
+
 /*
  * ALSA uniperipheral iec958 controls
  */
@@ -668,11 +700,29 @@ static int uni_player_startup(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	int ret;
+
 	player->substream = substream;
 
 	player->clk_adj = 0;
 
-	return 0;
+	if (!UNIPERIF_TYPE_IS_TDM(player))
+		return 0;
+
+	/* refine hw constraint in tdm mode */
+	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  sti_uniperiph_fix_tdm_chan,
+				  player, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  -1);
+	if (ret < 0)
+		return ret;
+
+	return snd_pcm_hw_rule_add(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_FORMAT,
+				   sti_uniperiph_fix_tdm_format,
+				   player, SNDRV_PCM_HW_PARAM_FORMAT,
+				   -1);
 }
 
 static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
@@ -682,7 +732,7 @@ static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct uniperif *player = priv->dai_data.uni;
 	int ret;
 
-	if (dir == SND_SOC_CLOCK_IN)
+	if (UNIPERIF_TYPE_IS_TDM(player) || (dir == SND_SOC_CLOCK_IN))
 		return 0;
 
 	if (clk_id != 0)
@@ -714,7 +764,13 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	}
 
 	/* Calculate transfer size (in fifo cells and bytes) for frame count */
-	transfer_size = runtime->channels * UNIPERIF_FIFO_FRAMES;
+	if (player->info->type == SND_ST_UNIPERIF_TYPE_TDM) {
+		/* transfer size = user frame size (in 32 bits FIFO cell) */
+		transfer_size =
+			sti_uniperiph_get_user_frame_size(runtime) / 4;
+	} else {
+		transfer_size = runtime->channels * UNIPERIF_FIFO_FRAMES;
+	}
 
 	/* Calculate number of empty cells available before asserting DREQ */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0) {
@@ -738,16 +794,19 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(player, trigger_limit);
 
 	/* Uniperipheral setup depends on player type */
-	switch (player->info->player_type) {
-	case SND_ST_UNIPERIF_PLAYER_TYPE_HDMI:
+	switch (player->info->type) {
+	case SND_ST_UNIPERIF_TYPE_HDMI:
 		ret = uni_player_prepare_iec958(player, runtime);
 		break;
-	case SND_ST_UNIPERIF_PLAYER_TYPE_PCM:
+	case SND_ST_UNIPERIF_TYPE_PCM:
 		ret = uni_player_prepare_pcm(player, runtime);
 		break;
-	case SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF:
+	case SND_ST_UNIPERIF_TYPE_SPDIF:
 		ret = uni_player_prepare_iec958(player, runtime);
 		break;
+	case SND_ST_UNIPERIF_TYPE_TDM:
+		ret = uni_player_prepare_tdm(player, runtime);
+		break;
 	default:
 		dev_err(player->dev, "invalid player type");
 		return -EINVAL;
@@ -852,8 +911,8 @@ static int uni_player_start(struct uniperif *player)
 	 * will not take affect and hang the player.
 	 */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
-		if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player))
-				SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
+		if (UNIPERIF_TYPE_IS_IEC958(player))
+			SET_UNIPERIF_CTRL_SPDIF_FMT_ON(player);
 
 	/* Force channel status update (no update if clk disable) */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -1012,13 +1071,15 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	}
 
 	if (strcasecmp(mode, "hdmi") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_HDMI;
+		info->type = SND_ST_UNIPERIF_TYPE_HDMI;
 	else if (strcasecmp(mode, "pcm") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_PCM;
+		info->type = SND_ST_UNIPERIF_TYPE_PCM;
 	else if (strcasecmp(mode, "spdif") == 0)
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_SPDIF;
+		info->type = SND_ST_UNIPERIF_TYPE_SPDIF;
+	else if (strcasecmp(mode, "tdm") == 0)
+		info->type = SND_ST_UNIPERIF_TYPE_TDM;
 	else
-		info->player_type = SND_ST_UNIPERIF_PLAYER_TYPE_NONE;
+		info->type = SND_ST_UNIPERIF_TYPE_NONE;
 
 	/* Save the info structure */
 	player->info = info;
@@ -1037,7 +1098,8 @@ static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.trigger = uni_player_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,
-		.set_sysclk = uni_player_set_sysclk
+		.set_sysclk = uni_player_set_sysclk,
+		.set_tdm_slot = sti_uniperiph_set_tdm_slot
 };
 
 int uni_player_init(struct platform_device *pdev,
@@ -1047,7 +1109,6 @@ int uni_player_init(struct platform_device *pdev,
 
 	player->dev = &pdev->dev;
 	player->state = UNIPERIF_STATE_STOPPED;
-	player->hw = &uni_player_pcm_hw;
 	player->dai_ops = &uni_player_dai_ops;
 
 	ret = uni_player_parse_dt(pdev, player);
@@ -1057,6 +1118,11 @@ int uni_player_init(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (UNIPERIF_TYPE_IS_TDM(player))
+		player->hw = &uni_tdm_hw;
+	else
+		player->hw = &uni_player_pcm_hw;
+
 	/* Get uniperif resource */
 	player->clk = of_clk_get(pdev->dev.of_node, 0);
 	if (IS_ERR(player->clk))
@@ -1087,7 +1153,7 @@ int uni_player_init(struct platform_device *pdev,
 	SET_UNIPERIF_CTRL_SPDIF_LAT_OFF(player);
 	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
 
-	if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player)) {
+	if (UNIPERIF_TYPE_IS_IEC958(player)) {
 		/* Set default iec958 status bits  */
 
 		/* Consumer, PCM, copyright, 2ch, mode 0 */
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 8a0eb20..eb74a32 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -73,55 +73,10 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
 	return ret;
 }
 
-static int uni_reader_prepare(struct snd_pcm_substream *substream,
-			      struct snd_soc_dai *dai)
+static int uni_reader_prepare_pcm(struct snd_pcm_runtime *runtime,
+				  struct uniperif *reader)
 {
-	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
-	struct uniperif *reader = priv->dai_data.uni;
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	int transfer_size, trigger_limit;
 	int slot_width;
-	int count = 10;
-
-	/* The reader should be stopped */
-	if (reader->state != UNIPERIF_STATE_STOPPED) {
-		dev_err(reader->dev, "%s: invalid reader state %d", __func__,
-			reader->state);
-		return -EINVAL;
-	}
-
-	/* Calculate transfer size (in fifo cells and bytes) for frame count */
-	transfer_size = runtime->channels * UNIPERIF_FIFO_FRAMES;
-
-	/* Calculate number of empty cells available before asserting DREQ */
-	if (reader->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
-		trigger_limit = UNIPERIF_FIFO_SIZE - transfer_size;
-	else
-		/*
-		 * Since SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0
-		 * FDMA_TRIGGER_LIMIT also controls when the state switches
-		 * from OFF or STANDBY to AUDIO DATA.
-		 */
-		trigger_limit = transfer_size;
-
-	/* Trigger limit must be an even number */
-	if ((!trigger_limit % 2) ||
-	    (trigger_limit != 1 && transfer_size % 2) ||
-	    (trigger_limit > UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(reader))) {
-		dev_err(reader->dev, "invalid trigger limit %d", trigger_limit);
-		return -EINVAL;
-	}
-
-	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(reader, trigger_limit);
-
-	switch (reader->daifmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_IB_IF:
-	case SND_SOC_DAIFMT_NB_IF:
-		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(reader);
-		break;
-	default:
-		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(reader);
-	}
 
 	/* Force slot width to 32 in I2S mode */
 	if ((reader->daifmt & SND_SOC_DAIFMT_FORMAT_MASK)
@@ -173,6 +128,109 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Number of channels must be even */
+	if ((runtime->channels % 2) || (runtime->channels < 2) ||
+	    (runtime->channels > 10)) {
+		dev_err(reader->dev, "%s: invalid nb of channels", __func__);
+		return -EINVAL;
+	}
+
+	SET_UNIPERIF_I2S_FMT_NUM_CH(reader, runtime->channels / 2);
+	SET_UNIPERIF_I2S_FMT_ORDER_MSB(reader);
+
+	return 0;
+}
+
+static int uni_reader_prepare_tdm(struct snd_pcm_runtime *runtime,
+				  struct uniperif *reader)
+{
+	int frame_size; /* user tdm frame size in bytes */
+	/* default unip TDM_WORD_POS_X_Y */
+	unsigned int word_pos[4] = {
+		0x04060002, 0x0C0E080A, 0x14161012, 0x1C1E181A};
+
+	frame_size = sti_uniperiph_get_user_frame_size(runtime);
+
+	/* fix 16/0 format */
+	SET_UNIPERIF_CONFIG_MEM_FMT_16_0(reader);
+	SET_UNIPERIF_I2S_FMT_DATA_SIZE_32(reader);
+
+	/* number of words inserted on the TDM line */
+	SET_UNIPERIF_I2S_FMT_NUM_CH(reader, frame_size / 4 / 2);
+
+	SET_UNIPERIF_I2S_FMT_ORDER_MSB(reader);
+	SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
+	SET_UNIPERIF_TDM_ENABLE_TDM_ENABLE(reader);
+
+	/*
+	 * set the timeslots allocation for words in FIFO
+	 *
+	 * HW bug: (LSB word < MSB word) => this config is not possible
+	 *         So if we want (LSB word < MSB) word, then it shall be
+	 *         handled by user
+	 */
+	sti_uniperiph_get_tdm_word_pos(reader, word_pos);
+	SET_UNIPERIF_TDM_WORD_POS(reader, 1_2, word_pos[WORD_1_2]);
+	SET_UNIPERIF_TDM_WORD_POS(reader, 3_4, word_pos[WORD_3_4]);
+	SET_UNIPERIF_TDM_WORD_POS(reader, 5_6, word_pos[WORD_5_6]);
+	SET_UNIPERIF_TDM_WORD_POS(reader, 7_8, word_pos[WORD_7_8]);
+
+	return 0;
+}
+
+static int uni_reader_prepare(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *reader = priv->dai_data.uni;
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int transfer_size, trigger_limit, ret;
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
+	if (reader->info->type == SND_ST_UNIPERIF_TYPE_TDM) {
+		/* transfer size = unip frame size (in 32 bits FIFO cell) */
+		transfer_size =
+			sti_uniperiph_get_user_frame_size(runtime) / 4;
+	} else {
+		transfer_size = runtime->channels * UNIPERIF_FIFO_FRAMES;
+	}
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
+	if (UNIPERIF_TYPE_IS_TDM(reader))
+		ret = uni_reader_prepare_tdm(runtime, reader);
+	else
+		ret = uni_reader_prepare_pcm(runtime, reader);
+	if (ret)
+		return ret;
+
 	switch (reader->daifmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		SET_UNIPERIF_I2S_FMT_ALIGN_LEFT(reader);
@@ -191,21 +249,26 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-	SET_UNIPERIF_I2S_FMT_ORDER_MSB(reader);
-
-	/* Data clocking (changing) on the rising edge */
-	SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(reader);
-
-	/* Number of channels must be even */
-
-	if ((runtime->channels % 2) || (runtime->channels < 2) ||
-	    (runtime->channels > 10)) {
-		dev_err(reader->dev, "%s: invalid nb of channels", __func__);
-		return -EINVAL;
+	/* Data clocking (changing) on the rising/falling edge */
+	switch (reader->daifmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(reader);
+		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(reader);
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(reader);
+		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_RISING(reader);
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(reader);
+		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(reader);
+		break;
+	case SND_SOC_DAIFMT_IB_IF:
+		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(reader);
+		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(reader);
+		break;
 	}
 
-	SET_UNIPERIF_I2S_FMT_NUM_CH(reader, runtime->channels / 2);
-
 	/* Clear any pending interrupts */
 	SET_UNIPERIF_ITS_BCLR(reader, GET_UNIPERIF_ITS(reader));
 
@@ -293,6 +356,32 @@ static int  uni_reader_trigger(struct snd_pcm_substream *substream,
 	}
 }
 
+static int uni_reader_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *reader = priv->dai_data.uni;
+	int ret;
+
+	if (!UNIPERIF_TYPE_IS_TDM(reader))
+		return 0;
+
+	/* refine hw constraint in tdm mode */
+	ret = snd_pcm_hw_rule_add(substream->runtime, 0,
+				  SNDRV_PCM_HW_PARAM_CHANNELS,
+				  sti_uniperiph_fix_tdm_chan,
+				  reader, SNDRV_PCM_HW_PARAM_CHANNELS,
+				  -1);
+	if (ret < 0)
+		return ret;
+
+	return snd_pcm_hw_rule_add(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_FORMAT,
+				   sti_uniperiph_fix_tdm_format,
+				   reader, SNDRV_PCM_HW_PARAM_FORMAT,
+				   -1);
+}
+
 static void uni_reader_shutdown(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
@@ -310,6 +399,7 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 {
 	struct uniperif_info *info;
 	struct device_node *node = pdev->dev.of_node;
+	const char *mode;
 
 	/* Allocate memory for the info structure */
 	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
@@ -322,6 +412,17 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
+	/* Read the device mode property */
+	if (of_property_read_string(node, "st,mode", &mode)) {
+		dev_err(&pdev->dev, "uniperipheral mode not defined");
+		return -EINVAL;
+	}
+
+	if (strcasecmp(mode, "tdm") == 0)
+		info->type = SND_ST_UNIPERIF_TYPE_TDM;
+	else
+		info->type = SND_ST_UNIPERIF_TYPE_PCM;
+
 	/* Save the info structure */
 	reader->info = info;
 
@@ -329,11 +430,13 @@ static int uni_reader_parse_dt(struct platform_device *pdev,
 }
 
 static const struct snd_soc_dai_ops uni_reader_dai_ops = {
+		.startup = uni_reader_startup,
 		.shutdown = uni_reader_shutdown,
 		.prepare = uni_reader_prepare,
 		.trigger = uni_reader_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,
+		.set_tdm_slot = sti_uniperiph_set_tdm_slot
 };
 
 int uni_reader_init(struct platform_device *pdev,
@@ -343,7 +446,6 @@ int uni_reader_init(struct platform_device *pdev,
 
 	reader->dev = &pdev->dev;
 	reader->state = UNIPERIF_STATE_STOPPED;
-	reader->hw = &uni_reader_pcm_hw;
 	reader->dai_ops = &uni_reader_dai_ops;
 
 	ret = uni_reader_parse_dt(pdev, reader);
@@ -352,6 +454,11 @@ int uni_reader_init(struct platform_device *pdev,
 		return ret;
 	}
 
+	if (UNIPERIF_TYPE_IS_TDM(reader))
+		reader->hw = &uni_tdm_hw;
+	else
+		reader->hw = &uni_reader_pcm_hw;
+
 	ret = devm_request_irq(&pdev->dev, reader->irq,
 			       uni_reader_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), reader);
-- 
1.9.1
