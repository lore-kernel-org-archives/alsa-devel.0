From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: unip player tdm mode" to the asoc
	tree
Date: Tue, 12 Apr 2016 07:31:01 +0100
Message-ID: <E1aprqn-0008FN-Q4@debutante>
References: <1460021136-27822-7-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CEA1E26581A
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 08:31:06 +0200 (CEST)
In-Reply-To: <1460021136-27822-7-git-send-email-moise.gergaud@st.com>
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

   ASoC: sti: unip player tdm mode

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

>From 8d8b1e2eddaef25ca0a18500dd9425638f1cfd02 Mon Sep 17 00:00:00 2001
From: Moise Gergaud <moise.gergaud@st.com>
Date: Thu, 7 Apr 2016 11:25:35 +0200
Subject: [PATCH] ASoC: sti: unip player tdm mode

here are the changes to enable player tdm mode:
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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/sti_uniperif.c    |   8 ++-
 sound/soc/sti/uniperif.h        |  11 ++++
 sound/soc/sti/uniperif_player.c | 109 +++++++++++++++++++++++++++++++++-------
 3 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index d49badec9e62..488ef4ed8fba 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -181,10 +181,16 @@ int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
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
index 17d5d1030741..d0e24468478c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1389,6 +1389,17 @@ int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
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
 int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots,
 			       int slot_width);
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index ab4310a1615e..ff2d73597ce3 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -435,18 +435,11 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 
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
@@ -521,7 +514,6 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
 
 	SET_UNIPERIF_I2S_FMT_ORDER_MSB(player);
-	SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
 
 	/* No iec958 formatting as outputting to DAC  */
 	SET_UNIPERIF_CTRL_SPDIF_FMT_OFF(player);
@@ -529,6 +521,55 @@ static int uni_player_prepare_pcm(struct uniperif *player,
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
@@ -659,11 +700,29 @@ static int uni_player_startup(struct snd_pcm_substream *substream,
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
@@ -673,7 +732,7 @@ static int uni_player_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	struct uniperif *player = priv->dai_data.uni;
 	int ret;
 
-	if (dir == SND_SOC_CLOCK_IN)
+	if (UNIPERIF_TYPE_IS_TDM(player) || (dir == SND_SOC_CLOCK_IN))
 		return 0;
 
 	if (clk_id != 0)
@@ -705,7 +764,13 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
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
@@ -739,6 +804,9 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	case SND_ST_UNIPERIF_TYPE_SPDIF:
 		ret = uni_player_prepare_iec958(player, runtime);
 		break;
+	case SND_ST_UNIPERIF_TYPE_TDM:
+		ret = uni_player_prepare_tdm(player, runtime);
+		break;
 	default:
 		dev_err(player->dev, "invalid player type");
 		return -EINVAL;
@@ -1008,6 +1076,8 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 		info->type = SND_ST_UNIPERIF_TYPE_PCM;
 	else if (strcasecmp(mode, "spdif") == 0)
 		info->type = SND_ST_UNIPERIF_TYPE_SPDIF;
+	else if (strcasecmp(mode, "tdm") == 0)
+		info->type = SND_ST_UNIPERIF_TYPE_TDM;
 	else
 		info->type = SND_ST_UNIPERIF_TYPE_NONE;
 
@@ -1028,7 +1098,8 @@ static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.trigger = uni_player_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,
-		.set_sysclk = uni_player_set_sysclk
+		.set_sysclk = uni_player_set_sysclk,
+		.set_tdm_slot = sti_uniperiph_set_tdm_slot
 };
 
 int uni_player_init(struct platform_device *pdev,
@@ -1038,7 +1109,6 @@ int uni_player_init(struct platform_device *pdev,
 
 	player->dev = &pdev->dev;
 	player->state = UNIPERIF_STATE_STOPPED;
-	player->hw = &uni_player_pcm_hw;
 	player->dai_ops = &uni_player_dai_ops;
 
 	ret = uni_player_parse_dt(pdev, player);
@@ -1048,6 +1118,11 @@ int uni_player_init(struct platform_device *pdev,
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
-- 
2.8.0.rc3
