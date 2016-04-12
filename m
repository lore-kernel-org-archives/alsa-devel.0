From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: unip reader tdm mode" to the asoc
	tree
Date: Tue, 12 Apr 2016 07:30:58 +0100
Message-ID: <E1aprqk-0008Ef-S4@debutante>
References: <1460021136-27822-8-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BE9E9265818
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 08:31:05 +0200 (CEST)
In-Reply-To: <1460021136-27822-8-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: unip reader tdm mode

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 82d4eb91ab1912cb9e8751b9aa0875af2ae36db2 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 7 Apr 2016 11:25:36 +0200
Subject: [PATCH] ASoC: sti: unip reader tdm mode

Here are the changes to enable reader tdm mode:
- When TDM_ENABLE is set to 1, the i2s format should be automatically
configured. Unfortunately this is not the case (HW bug). Then, we shall
force DATA_SIZE setting.
- Compute the transfer size for tdm mode: transfer size = user frame size
- Manage tdm slots configuration given in DT.
- Refine the hw param (channels & format) according to tdm slot config.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_reader.c | 229 +++++++++++++++++++++++++++++-----------
 1 file changed, 168 insertions(+), 61 deletions(-)

diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 8a0eb2050169..eb74a328c928 100644
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
2.8.0.rc3
