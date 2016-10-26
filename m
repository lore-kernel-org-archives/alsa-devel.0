From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: fix errors management" to the asoc
	tree
Date: Wed, 26 Oct 2016 11:46:13 +0100
Message-ID: <E1bzLin-0005PN-6D@debutante>
References: <1477320177-30130-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 87158266875
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 12:46:20 +0200 (CEST)
In-Reply-To: <1477320177-30130-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: fix errors management

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

>From 748abba8f3a93cee13a56350386e59457ffa600d Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Mon, 24 Oct 2016 16:42:51 +0200
Subject: [PATCH] ASoC: sti: fix errors management

Add missing error messages.
Propagate error of uni_reader_init and uni_reader_init.
Add return at end of dev_err strings.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/sti_uniperif.c    | 20 ++++++++------
 sound/soc/sti/uniperif_player.c | 58 +++++++++++++++++++++++------------------
 sound/soc/sti/uniperif_reader.c | 25 +++++++++---------
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 549fac349fa0..ee91ae5f812a 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -293,7 +293,7 @@ static int sti_uniperiph_dai_suspend(struct snd_soc_dai *dai)
 
 	/* The uniperipheral should be in stopped state */
 	if (uni->state != UNIPERIF_STATE_STOPPED) {
-		dev_err(uni->dev, "%s: invalid uni state( %d)",
+		dev_err(uni->dev, "%s: invalid uni state( %d)\n",
 			__func__, (int)uni->state);
 		return -EBUSY;
 	}
@@ -301,7 +301,7 @@ static int sti_uniperiph_dai_suspend(struct snd_soc_dai *dai)
 	/* Pinctrl: switch pinstate to sleep */
 	ret = pinctrl_pm_select_sleep_state(uni->dev);
 	if (ret)
-		dev_err(uni->dev, "%s: failed to select pinctrl state",
+		dev_err(uni->dev, "%s: failed to select pinctrl state\n",
 			__func__);
 
 	return ret;
@@ -322,7 +322,7 @@ static int sti_uniperiph_dai_resume(struct snd_soc_dai *dai)
 	/* pinctrl: switch pinstate to default */
 	ret = pinctrl_pm_select_default_state(uni->dev);
 	if (ret)
-		dev_err(uni->dev, "%s: failed to select pinctrl state",
+		dev_err(uni->dev, "%s: failed to select pinctrl state\n",
 			__func__);
 
 	return ret;
@@ -366,11 +366,12 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 	const struct of_device_id *of_id;
 	const struct sti_uniperiph_dev_data *dev_data;
 	const char *mode;
+	int ret;
 
 	/* Populate data structure depending on compatibility */
 	of_id = of_match_node(snd_soc_sti_match, node);
 	if (!of_id->data) {
-		dev_err(dev, "data associated to device is missing");
+		dev_err(dev, "data associated to device is missing\n");
 		return -EINVAL;
 	}
 	dev_data = (struct sti_uniperiph_dev_data *)of_id->data;
@@ -389,7 +390,7 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 	uni->mem_region = platform_get_resource(priv->pdev, IORESOURCE_MEM, 0);
 
 	if (!uni->mem_region) {
-		dev_err(dev, "Failed to get memory resource");
+		dev_err(dev, "Failed to get memory resource\n");
 		return -ENODEV;
 	}
 
@@ -403,7 +404,7 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 
 	uni->irq = platform_get_irq(priv->pdev, 0);
 	if (uni->irq < 0) {
-		dev_err(dev, "Failed to get IRQ resource");
+		dev_err(dev, "Failed to get IRQ resource\n");
 		return -ENXIO;
 	}
 
@@ -421,12 +422,15 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 	dai_data->stream = dev_data->stream;
 
 	if (priv->dai_data.stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		uni_player_init(priv->pdev, uni);
+		ret = uni_player_init(priv->pdev, uni);
 		stream = &dai->playback;
 	} else {
-		uni_reader_init(priv->pdev, uni);
+		ret = uni_reader_init(priv->pdev, uni);
 		stream = &dai->capture;
 	}
+	if (ret < 0)
+		return ret;
+
 	dai->ops = uni->dai_ops;
 
 	stream->stream_name = dai->name;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 1bc8ebc2528e..c9b4670b772b 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -67,7 +67,7 @@ static inline int reset_player(struct uniperif *player)
 	}
 
 	if (!count) {
-		dev_err(player->dev, "Failed to reset uniperif");
+		dev_err(player->dev, "Failed to reset uniperif\n");
 		return -EIO;
 	}
 
@@ -97,7 +97,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 
 	/* Check for fifo error (underrun) */
 	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(player))) {
-		dev_err(player->dev, "FIFO underflow error detected");
+		dev_err(player->dev, "FIFO underflow error detected\n");
 
 		/* Interrupt is just for information when underflow recovery */
 		if (player->underflow_enabled) {
@@ -119,7 +119,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 
 	/* Check for dma error (overrun) */
 	if (unlikely(status & UNIPERIF_ITS_DMA_ERROR_MASK(player))) {
-		dev_err(player->dev, "DMA error detected");
+		dev_err(player->dev, "DMA error detected\n");
 
 		/* Disable interrupt so doesn't continually fire */
 		SET_UNIPERIF_ITM_BCLR_DMA_ERROR(player);
@@ -135,11 +135,14 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 	/* Check for underflow recovery done */
 	if (unlikely(status & UNIPERIF_ITM_UNDERFLOW_REC_DONE_MASK(player))) {
 		if (!player->underflow_enabled) {
-			dev_err(player->dev, "unexpected Underflow recovering");
+			dev_err(player->dev,
+				"unexpected Underflow recovering\n");
 			return -EPERM;
 		}
 		/* Read the underflow recovery duration */
 		tmp = GET_UNIPERIF_STATUS_1_UNDERFLOW_DURATION(player);
+		dev_dbg(player->dev, "Underflow recovered (%d LR clocks max)\n",
+			tmp);
 
 		/* Clear the underflow recovery duration */
 		SET_UNIPERIF_BIT_CONTROL_CLR_UNDERFLOW_DURATION(player);
@@ -153,7 +156,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 	/* Check if underflow recovery failed */
 	if (unlikely(status &
 		     UNIPERIF_ITM_UNDERFLOW_REC_FAILED_MASK(player))) {
-		dev_err(player->dev, "Underflow recovery failed");
+		dev_err(player->dev, "Underflow recovery failed\n");
 
 		/* Stop the player */
 		snd_pcm_stream_lock(player->substream);
@@ -336,7 +339,7 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 
 	/* Oversampling must be multiple of 128 as iec958 frame is 32-bits */
 	if ((clk_div % 128) || (clk_div <= 0)) {
-		dev_err(player->dev, "%s: invalid clk_div %d",
+		dev_err(player->dev, "%s: invalid clk_div %d\n",
 			__func__, clk_div);
 		return -EINVAL;
 	}
@@ -359,7 +362,7 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 		SET_UNIPERIF_I2S_FMT_DATA_SIZE_24(player);
 		break;
 	default:
-		dev_err(player->dev, "format not supported");
+		dev_err(player->dev, "format not supported\n");
 		return -EINVAL;
 	}
 
@@ -448,12 +451,12 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 	 * for 16 bits must be a multiple of 64
 	 */
 	if ((slot_width == 32) && (clk_div % 128)) {
-		dev_err(player->dev, "%s: invalid clk_div", __func__);
+		dev_err(player->dev, "%s: invalid clk_div\n", __func__);
 		return -EINVAL;
 	}
 
 	if ((slot_width == 16) && (clk_div % 64)) {
-		dev_err(player->dev, "%s: invalid clk_div", __func__);
+		dev_err(player->dev, "%s: invalid clk_div\n", __func__);
 		return -EINVAL;
 	}
 
@@ -471,7 +474,7 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(player);
 		break;
 	default:
-		dev_err(player->dev, "subframe format not supported");
+		dev_err(player->dev, "subframe format not supported\n");
 		return -EINVAL;
 	}
 
@@ -491,7 +494,7 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 		break;
 
 	default:
-		dev_err(player->dev, "format not supported");
+		dev_err(player->dev, "format not supported\n");
 		return -EINVAL;
 	}
 
@@ -504,7 +507,7 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 	/* Number of channelsmust be even*/
 	if ((runtime->channels % 2) || (runtime->channels < 2) ||
 	    (runtime->channels > 10)) {
-		dev_err(player->dev, "%s: invalid nb of channels", __func__);
+		dev_err(player->dev, "%s: invalid nb of channels\n", __func__);
 		return -EINVAL;
 	}
 
@@ -758,7 +761,7 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 
 	/* The player should be stopped */
 	if (player->state != UNIPERIF_STATE_STOPPED) {
-		dev_err(player->dev, "%s: invalid player state %d", __func__,
+		dev_err(player->dev, "%s: invalid player state %d\n", __func__,
 			player->state);
 		return -EINVAL;
 	}
@@ -787,7 +790,8 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	/* Trigger limit must be an even number */
 	if ((!trigger_limit % 2) || (trigger_limit != 1 && transfer_size % 2) ||
 	    (trigger_limit > UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(player))) {
-		dev_err(player->dev, "invalid trigger limit %d", trigger_limit);
+		dev_err(player->dev, "invalid trigger limit %d\n",
+			trigger_limit);
 		return -EINVAL;
 	}
 
@@ -808,7 +812,7 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 		ret = uni_player_prepare_tdm(player, runtime);
 		break;
 	default:
-		dev_err(player->dev, "invalid player type");
+		dev_err(player->dev, "invalid player type\n");
 		return -EINVAL;
 	}
 
@@ -848,7 +852,7 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(player);
 		break;
 	default:
-		dev_err(player->dev, "format not supported");
+		dev_err(player->dev, "format not supported\n");
 		return -EINVAL;
 	}
 
@@ -866,13 +870,13 @@ static int uni_player_start(struct uniperif *player)
 
 	/* The player should be stopped */
 	if (player->state != UNIPERIF_STATE_STOPPED) {
-		dev_err(player->dev, "%s: invalid player state", __func__);
+		dev_err(player->dev, "%s: invalid player state\n", __func__);
 		return -EINVAL;
 	}
 
 	ret = clk_prepare_enable(player->clk);
 	if (ret) {
-		dev_err(player->dev, "%s: Failed to enable clock", __func__);
+		dev_err(player->dev, "%s: Failed to enable clock\n", __func__);
 		return ret;
 	}
 
@@ -934,7 +938,7 @@ static int uni_player_stop(struct uniperif *player)
 
 	/* The player should not be in stopped state */
 	if (player->state == UNIPERIF_STATE_STOPPED) {
-		dev_err(player->dev, "%s: invalid player state", __func__);
+		dev_err(player->dev, "%s: invalid player state\n", __func__);
 		return -EINVAL;
 	}
 
@@ -969,7 +973,7 @@ int uni_player_resume(struct uniperif *player)
 		ret = regmap_field_write(player->clk_sel, 1);
 		if (ret) {
 			dev_err(player->dev,
-				"%s: Failed to select freq synth clock",
+				"%s: Failed to select freq synth clock\n",
 				__func__);
 			return ret;
 		}
@@ -1066,7 +1070,7 @@ int uni_player_init(struct platform_device *pdev,
 	ret = uni_player_parse_dt_audio_glue(pdev, player);
 
 	if (ret < 0) {
-		dev_err(player->dev, "Failed to parse DeviceTree");
+		dev_err(player->dev, "Failed to parse DeviceTree\n");
 		return ret;
 	}
 
@@ -1081,15 +1085,17 @@ int uni_player_init(struct platform_device *pdev,
 
 	/* Get uniperif resource */
 	player->clk = of_clk_get(pdev->dev.of_node, 0);
-	if (IS_ERR(player->clk))
+	if (IS_ERR(player->clk)) {
+		dev_err(player->dev, "Failed to get clock\n");
 		ret = PTR_ERR(player->clk);
+	}
 
 	/* Select the frequency synthesizer clock */
 	if (player->clk_sel) {
 		ret = regmap_field_write(player->clk_sel, 1);
 		if (ret) {
 			dev_err(player->dev,
-				"%s: Failed to select freq synth clock",
+				"%s: Failed to select freq synth clock\n",
 				__func__);
 			return ret;
 		}
@@ -1101,7 +1107,7 @@ int uni_player_init(struct platform_device *pdev,
 		ret = regmap_field_write(player->valid_sel, player->id);
 		if (ret) {
 			dev_err(player->dev,
-				"%s: unable to connect to tdm bus", __func__);
+				"%s: unable to connect to tdm bus\n", __func__);
 			return ret;
 		}
 	}
@@ -1109,8 +1115,10 @@ int uni_player_init(struct platform_device *pdev,
 	ret = devm_request_irq(&pdev->dev, player->irq,
 			       uni_player_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), player);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(player->dev, "unable to request IRQ %d\n", player->irq);
 		return ret;
+	}
 
 	mutex_init(&player->ctrl_lock);
 
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 0e1c3ee56675..09314f8be841 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -52,7 +52,7 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
 
 	if (reader->state == UNIPERIF_STATE_STOPPED) {
 		/* Unexpected IRQ: do nothing */
-		dev_warn(reader->dev, "unexpected IRQ ");
+		dev_warn(reader->dev, "unexpected IRQ\n");
 		return IRQ_HANDLED;
 	}
 
@@ -62,7 +62,7 @@ static irqreturn_t uni_reader_irq_handler(int irq, void *dev_id)
 
 	/* Check for fifo overflow error */
 	if (unlikely(status & UNIPERIF_ITS_FIFO_ERROR_MASK(reader))) {
-		dev_err(reader->dev, "FIFO error detected");
+		dev_err(reader->dev, "FIFO error detected\n");
 
 		snd_pcm_stream_lock(reader->substream);
 		snd_pcm_stop(reader->substream, SNDRV_PCM_STATE_XRUN);
@@ -105,7 +105,7 @@ static int uni_reader_prepare_pcm(struct snd_pcm_runtime *runtime,
 		SET_UNIPERIF_I2S_FMT_DATA_SIZE_16(reader);
 		break;
 	default:
-		dev_err(reader->dev, "subframe format not supported");
+		dev_err(reader->dev, "subframe format not supported\n");
 		return -EINVAL;
 	}
 
@@ -125,14 +125,14 @@ static int uni_reader_prepare_pcm(struct snd_pcm_runtime *runtime,
 		break;
 
 	default:
-		dev_err(reader->dev, "format not supported");
+		dev_err(reader->dev, "format not supported\n");
 		return -EINVAL;
 	}
 
 	/* Number of channels must be even */
 	if ((runtime->channels % 2) || (runtime->channels < 2) ||
 	    (runtime->channels > 10)) {
-		dev_err(reader->dev, "%s: invalid nb of channels", __func__);
+		dev_err(reader->dev, "%s: invalid nb of channels\n", __func__);
 		return -EINVAL;
 	}
 
@@ -190,7 +190,7 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 
 	/* The reader should be stopped */
 	if (reader->state != UNIPERIF_STATE_STOPPED) {
-		dev_err(reader->dev, "%s: invalid reader state %d", __func__,
+		dev_err(reader->dev, "%s: invalid reader state %d\n", __func__,
 			reader->state);
 		return -EINVAL;
 	}
@@ -219,7 +219,8 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 	if ((!trigger_limit % 2) ||
 	    (trigger_limit != 1 && transfer_size % 2) ||
 	    (trigger_limit > UNIPERIF_CONFIG_DMA_TRIG_LIMIT_MASK(reader))) {
-		dev_err(reader->dev, "invalid trigger limit %d", trigger_limit);
+		dev_err(reader->dev, "invalid trigger limit %d\n",
+			trigger_limit);
 		return -EINVAL;
 	}
 
@@ -246,7 +247,7 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 		SET_UNIPERIF_I2S_FMT_PADDING_SONY_MODE(reader);
 		break;
 	default:
-		dev_err(reader->dev, "format not supported");
+		dev_err(reader->dev, "format not supported\n");
 		return -EINVAL;
 	}
 
@@ -294,7 +295,7 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 		count--;
 	}
 	if (!count) {
-		dev_err(reader->dev, "Failed to reset uniperif");
+		dev_err(reader->dev, "Failed to reset uniperif\n");
 		return -EIO;
 	}
 
@@ -305,7 +306,7 @@ static int uni_reader_start(struct uniperif *reader)
 {
 	/* The reader should be stopped */
 	if (reader->state != UNIPERIF_STATE_STOPPED) {
-		dev_err(reader->dev, "%s: invalid reader state", __func__);
+		dev_err(reader->dev, "%s: invalid reader state\n", __func__);
 		return -EINVAL;
 	}
 
@@ -325,7 +326,7 @@ static int uni_reader_stop(struct uniperif *reader)
 {
 	/* The reader should not be in stopped state */
 	if (reader->state == UNIPERIF_STATE_STOPPED) {
-		dev_err(reader->dev, "%s: invalid reader state", __func__);
+		dev_err(reader->dev, "%s: invalid reader state\n", __func__);
 		return -EINVAL;
 	}
 
@@ -423,7 +424,7 @@ int uni_reader_init(struct platform_device *pdev,
 			       uni_reader_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), reader);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to request IRQ");
+		dev_err(&pdev->dev, "Failed to request IRQ\n");
 		return -EBUSY;
 	}
 
-- 
2.8.1
