From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: sti: suppress inappropriate DT fields" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:30 +0100
Message-ID: <E1bkDmU-0001cQ-C2@debutante>
References: <1473753504-20179-2-git-send-email-arnaud.pouliquen@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473753504-20179-2-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: suppress inappropriate DT fields

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

>From 5a4326d1c21bc9aa958d5e621e06cd1b13e50711 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Date: Tue, 13 Sep 2016 09:58:23 +0200
Subject: [PATCH] ASoC: sti: suppress inappropriate DT fields

Update to suppress some DT nodes that can be handled in driver
using compatible string.
"dai-name", "st,version"and "st,mode" are suppressed
"st,tdm-mode" is added to handle TDM mode.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 sound/soc/sti/sti_uniperif.c    | 130 +++++++++++++++++++++++++++++++++-------
 sound/soc/sti/uniperif.h        |  28 ++++-----
 sound/soc/sti/uniperif_player.c |  79 +++++-------------------
 sound/soc/sti/uniperif_reader.c |  46 +-------------
 4 files changed, 140 insertions(+), 143 deletions(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 488ef4ed8fba..549fac349fa0 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -19,6 +19,84 @@
 #define UNIPERIF_MAX_FRAME_SZ 0x20
 #define UNIPERIF_ALLOWED_FRAME_SZ (0x08 | 0x10 | 0x18 | UNIPERIF_MAX_FRAME_SZ)
 
+struct sti_uniperiph_dev_data {
+	unsigned int id; /* Nb available player instances */
+	unsigned int version; /* player IP version */
+	unsigned int stream;
+	const char *dai_names;
+	enum uniperif_type type;
+};
+
+static const struct sti_uniperiph_dev_data sti_uniplayer_hdmi = {
+	.id = 0,
+	.version = SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
+	.stream = SNDRV_PCM_STREAM_PLAYBACK,
+	.dai_names = "Uni Player #0 (HDMI)",
+	.type = SND_ST_UNIPERIF_TYPE_HDMI
+};
+
+static const struct sti_uniperiph_dev_data sti_uniplayer_pcm_out = {
+	.id = 1,
+	.version = SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
+	.stream = SNDRV_PCM_STREAM_PLAYBACK,
+	.dai_names = "Uni Player #1 (PCM OUT)",
+	.type = SND_ST_UNIPERIF_TYPE_PCM | SND_ST_UNIPERIF_TYPE_TDM,
+};
+
+static const struct sti_uniperiph_dev_data sti_uniplayer_dac = {
+	.id = 2,
+	.version = SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
+	.stream = SNDRV_PCM_STREAM_PLAYBACK,
+	.dai_names = "Uni Player #2 (DAC)",
+	.type = SND_ST_UNIPERIF_TYPE_PCM,
+};
+
+static const struct sti_uniperiph_dev_data sti_uniplayer_spdif = {
+	.id = 3,
+	.version = SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0,
+	.stream = SNDRV_PCM_STREAM_PLAYBACK,
+	.dai_names = "Uni Player #3 (SPDIF)",
+	.type = SND_ST_UNIPERIF_TYPE_SPDIF
+};
+
+static const struct sti_uniperiph_dev_data sti_unireader_pcm_in = {
+	.id = 0,
+	.version = SND_ST_UNIPERIF_VERSION_UNI_RDR_1_0,
+	.stream = SNDRV_PCM_STREAM_CAPTURE,
+	.dai_names = "Uni Reader #0 (PCM IN)",
+	.type = SND_ST_UNIPERIF_TYPE_PCM | SND_ST_UNIPERIF_TYPE_TDM,
+};
+
+static const struct sti_uniperiph_dev_data sti_unireader_hdmi_in = {
+	.id = 1,
+	.version = SND_ST_UNIPERIF_VERSION_UNI_RDR_1_0,
+	.stream = SNDRV_PCM_STREAM_CAPTURE,
+	.dai_names = "Uni Reader #1 (HDMI IN)",
+	.type = SND_ST_UNIPERIF_TYPE_PCM,
+};
+
+static const struct of_device_id snd_soc_sti_match[] = {
+	{ .compatible = "st,stih407-uni-player-hdmi",
+	  .data = &sti_uniplayer_hdmi
+	},
+	{ .compatible = "st,stih407-uni-player-pcm-out",
+	  .data = &sti_uniplayer_pcm_out
+	},
+	{ .compatible = "st,stih407-uni-player-dac",
+	  .data = &sti_uniplayer_dac
+	},
+	{ .compatible = "st,stih407-uni-player-spdif",
+	  .data = &sti_uniplayer_spdif
+	},
+	{ .compatible = "st,stih407-uni-reader-pcm_in",
+	  .data = &sti_unireader_pcm_in
+	},
+	{ .compatible = "st,stih407-uni-reader-hdmi",
+	  .data = &sti_unireader_hdmi_in
+	},
+	{},
+};
+
 int sti_uniperiph_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 			       unsigned int rx_mask, int slots,
 			       int slot_width)
@@ -167,8 +245,8 @@ static int sti_uniperiph_dai_create_ctrl(struct snd_soc_dai *dai)
 		 * Uniperipheral instance ID
 		 */
 		ctrl = &uni->snd_ctrls[i];
-		ctrl->index = uni->info->id;
-		ctrl->device = uni->info->id;
+		ctrl->index = uni->id;
+		ctrl->device = uni->id;
 	}
 
 	return snd_soc_add_dai_controls(dai, uni->snd_ctrls, uni->num_ctrls);
@@ -186,7 +264,7 @@ int sti_uniperiph_dai_hw_params(struct snd_pcm_substream *substream,
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	int transfer_size;
 
-	if (uni->info->type == SND_ST_UNIPERIF_TYPE_TDM)
+	if (uni->type == SND_ST_UNIPERIF_TYPE_TDM)
 		/* transfer size = user frame size (in 32-bits FIFO cell) */
 		transfer_size = snd_soc_params_to_frame_size(params) / 32;
 	else
@@ -235,7 +313,7 @@ static int sti_uniperiph_dai_resume(struct snd_soc_dai *dai)
 	struct uniperif *uni = priv->dai_data.uni;
 	int ret;
 
-	if (of_device_is_compatible(dai->dev->of_node, "st,sti-uni-player")) {
+	if (priv->dai_data.stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		ret = uni_player_resume(uni);
 		if (ret)
 			return ret;
@@ -256,7 +334,7 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 	struct sti_uniperiph_dai *dai_data = &priv->dai_data;
 
 	/* DMA settings*/
-	if (of_device_is_compatible(dai->dev->of_node, "st,sti-uni-player"))
+	if (priv->dai_data.stream == SNDRV_PCM_STREAM_PLAYBACK)
 		snd_soc_dai_init_dma_data(dai, &dai_data->dma_data, NULL);
 	else
 		snd_soc_dai_init_dma_data(dai, NULL, &dai_data->dma_data);
@@ -280,25 +358,32 @@ static const struct snd_soc_component_driver sti_uniperiph_dai_component = {
 static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 				    struct sti_uniperiph_data *priv)
 {
-	const char *str;
-	int ret;
 	struct device *dev = &priv->pdev->dev;
 	struct sti_uniperiph_dai *dai_data = &priv->dai_data;
 	struct snd_soc_dai_driver *dai = priv->dai;
 	struct snd_soc_pcm_stream *stream;
 	struct uniperif *uni;
+	const struct of_device_id *of_id;
+	const struct sti_uniperiph_dev_data *dev_data;
+	const char *mode;
+
+	/* Populate data structure depending on compatibility */
+	of_id = of_match_node(snd_soc_sti_match, node);
+	if (!of_id->data) {
+		dev_err(dev, "data associated to device is missing");
+		return -EINVAL;
+	}
+	dev_data = (struct sti_uniperiph_dev_data *)of_id->data;
 
 	uni = devm_kzalloc(dev, sizeof(*uni), GFP_KERNEL);
 	if (!uni)
 		return -ENOMEM;
 
+	uni->id = dev_data->id;
+	uni->ver = dev_data->version;
+
 	*dai = sti_uniperiph_dai_template;
-	ret = of_property_read_string(node, "dai-name", &str);
-	if (ret < 0) {
-		dev_err(dev, "%s: dai name missing.\n", __func__);
-		return -EINVAL;
-	}
-	dai->name = str;
+	dai->name = dev_data->dai_names;
 
 	/* Get resources */
 	uni->mem_region = platform_get_resource(priv->pdev, IORESOURCE_MEM, 0);
@@ -322,9 +407,20 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 		return -ENXIO;
 	}
 
+	uni->type = dev_data->type;
+
+	/* check if player should be configured for tdm */
+	if (dev_data->type & SND_ST_UNIPERIF_TYPE_TDM) {
+		if (!of_property_read_string(node, "st,tdm-mode", &mode))
+			uni->type = SND_ST_UNIPERIF_TYPE_TDM;
+		else
+			uni->type = SND_ST_UNIPERIF_TYPE_PCM;
+	}
+
 	dai_data->uni = uni;
+	dai_data->stream = dev_data->stream;
 
-	if (of_device_is_compatible(node, "st,sti-uni-player")) {
+	if (priv->dai_data.stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		uni_player_init(priv->pdev, uni);
 		stream = &dai->playback;
 	} else {
@@ -376,12 +472,6 @@ static int sti_uniperiph_probe(struct platform_device *pdev)
 					       &dmaengine_pcm_config, 0);
 }
 
-static const struct of_device_id snd_soc_sti_match[] = {
-	{ .compatible = "st,sti-uni-player", },
-	{ .compatible = "st,sti-uni-reader", },
-	{},
-};
-
 static struct platform_driver sti_uniperiph_driver = {
 	.driver = {
 		.name = "sti-uniperiph-dai",
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index eb9933c62ad6..1993c655fb79 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1220,16 +1220,16 @@
 #define UNIPERIF_FIFO_FRAMES		4  /* FDMA trigger limit in frames */
 
 #define UNIPERIF_TYPE_IS_HDMI(p) \
-	((p)->info->type == SND_ST_UNIPERIF_TYPE_HDMI)
+	((p)->type == SND_ST_UNIPERIF_TYPE_HDMI)
 #define UNIPERIF_TYPE_IS_PCM(p) \
-	((p)->info->type == SND_ST_UNIPERIF_TYPE_PCM)
+	((p)->type == SND_ST_UNIPERIF_TYPE_PCM)
 #define UNIPERIF_TYPE_IS_SPDIF(p) \
-	((p)->info->type == SND_ST_UNIPERIF_TYPE_SPDIF)
+	((p)->type == SND_ST_UNIPERIF_TYPE_SPDIF)
 #define UNIPERIF_TYPE_IS_IEC958(p) \
 	(UNIPERIF_TYPE_IS_HDMI(p) || \
 		UNIPERIF_TYPE_IS_SPDIF(p))
 #define UNIPERIF_TYPE_IS_TDM(p) \
-	((p)->info->type == SND_ST_UNIPERIF_TYPE_TDM)
+	((p)->type == SND_ST_UNIPERIF_TYPE_TDM)
 
 /*
  * Uniperipheral IP revisions
@@ -1249,11 +1249,11 @@ enum uniperif_version {
 };
 
 enum uniperif_type {
-	SND_ST_UNIPERIF_TYPE_NONE,
-	SND_ST_UNIPERIF_TYPE_HDMI,
-	SND_ST_UNIPERIF_TYPE_PCM,
-	SND_ST_UNIPERIF_TYPE_SPDIF,
-	SND_ST_UNIPERIF_TYPE_TDM
+	SND_ST_UNIPERIF_TYPE_NONE	= 0x00,
+	SND_ST_UNIPERIF_TYPE_HDMI	= 0x01,
+	SND_ST_UNIPERIF_TYPE_PCM	= 0x02,
+	SND_ST_UNIPERIF_TYPE_SPDIF	= 0x04,
+	SND_ST_UNIPERIF_TYPE_TDM	= 0x08
 };
 
 enum uniperif_state {
@@ -1278,12 +1278,6 @@ enum uniperif_word_pos {
 	WORD_MAX
 };
 
-struct uniperif_info {
-	int id; /* instance value of the uniperipheral IP */
-	enum uniperif_type type;
-	int underflow_enabled;		/* Underflow recovery mode */
-};
-
 struct uniperif_iec958_settings {
 	enum uniperif_iec958_encoding_mode encoding_mode;
 	struct snd_aes_iec958 iec958;
@@ -1298,8 +1292,10 @@ struct dai_tdm_slot {
 
 struct uniperif {
 	/* System information */
-	struct uniperif_info *info;
+	enum uniperif_type type;
+	int underflow_enabled; /* Underflow recovery mode */
 	struct device *dev;
+	int id; /* instance value of the uniperipheral IP */
 	int ver; /* IP version, used by register access macros */
 	struct regmap_field *clk_sel;
 	struct regmap_field *valid_sel;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 1ac2db205a0d..645e4152e6a1 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -100,7 +100,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 		dev_err(player->dev, "FIFO underflow error detected");
 
 		/* Interrupt is just for information when underflow recovery */
-		if (player->info->underflow_enabled) {
+		if (player->underflow_enabled) {
 			/* Update state to underflow */
 			player->state = UNIPERIF_STATE_UNDERFLOW;
 
@@ -134,7 +134,7 @@ static irqreturn_t uni_player_irq_handler(int irq, void *dev_id)
 
 	/* Check for underflow recovery done */
 	if (unlikely(status & UNIPERIF_ITM_UNDERFLOW_REC_DONE_MASK(player))) {
-		if (!player->info->underflow_enabled) {
+		if (!player->underflow_enabled) {
 			dev_err(player->dev, "unexpected Underflow recovering");
 			return -EPERM;
 		}
@@ -764,7 +764,7 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	}
 
 	/* Calculate transfer size (in fifo cells and bytes) for frame count */
-	if (player->info->type == SND_ST_UNIPERIF_TYPE_TDM) {
+	if (player->type == SND_ST_UNIPERIF_TYPE_TDM) {
 		/* transfer size = user frame size (in 32 bits FIFO cell) */
 		transfer_size =
 			sti_uniperiph_get_user_frame_size(runtime) / 4;
@@ -794,7 +794,7 @@ static int uni_player_prepare(struct snd_pcm_substream *substream,
 	SET_UNIPERIF_CONFIG_DMA_TRIG_LIMIT(player, trigger_limit);
 
 	/* Uniperipheral setup depends on player type */
-	switch (player->info->type) {
+	switch (player->type) {
 	case SND_ST_UNIPERIF_TYPE_HDMI:
 		ret = uni_player_prepare_iec958(player, runtime);
 		break;
@@ -884,7 +884,7 @@ static int uni_player_start(struct uniperif *player)
 	SET_UNIPERIF_ITM_BSET_FIFO_ERROR(player);
 
 	/* Enable underflow recovery interrupts */
-	if (player->info->underflow_enabled) {
+	if (player->underflow_enabled) {
 		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(player);
 		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(player);
 	}
@@ -1021,8 +1021,8 @@ static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
 	struct reg_field regfield[2] = {
 		/* PCM_CLK_SEL */
 		REG_FIELD(SYS_CFG_AUDIO_GLUE,
-			  8 + player->info->id,
-			  8 + player->info->id),
+			  8 + player->id,
+			  8 + player->id),
 		/* PCMP_VALID_SEL */
 		REG_FIELD(SYS_CFG_AUDIO_GLUE, 0, 1)
 	};
@@ -1040,60 +1040,6 @@ static int uni_player_parse_dt_audio_glue(struct platform_device *pdev,
 	return 0;
 }
 
-static int uni_player_parse_dt(struct platform_device *pdev,
-			       struct uniperif *player)
-{
-	struct uniperif_info *info;
-	struct device *dev = &pdev->dev;
-	struct device_node *pnode = pdev->dev.of_node;
-	const char *mode;
-
-	/* Allocate memory for the info structure */
-	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	if (of_property_read_u32(pnode, "st,version", &player->ver) ||
-	    player->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
-		dev_err(dev, "Unknown uniperipheral version ");
-		return -EINVAL;
-	}
-	/* Underflow recovery is only supported on later ip revisions */
-	if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
-		info->underflow_enabled = 1;
-
-	if (of_property_read_u32(pnode, "st,uniperiph-id", &info->id)) {
-		dev_err(dev, "uniperipheral id not defined");
-		return -EINVAL;
-	}
-
-	/* Read the device mode property */
-	if (of_property_read_string(pnode, "st,mode", &mode)) {
-		dev_err(dev, "uniperipheral mode not defined");
-		return -EINVAL;
-	}
-
-	if (strcasecmp(mode, "hdmi") == 0)
-		info->type = SND_ST_UNIPERIF_TYPE_HDMI;
-	else if (strcasecmp(mode, "pcm") == 0)
-		info->type = SND_ST_UNIPERIF_TYPE_PCM;
-	else if (strcasecmp(mode, "spdif") == 0)
-		info->type = SND_ST_UNIPERIF_TYPE_SPDIF;
-	else if (strcasecmp(mode, "tdm") == 0)
-		info->type = SND_ST_UNIPERIF_TYPE_TDM;
-	else
-		info->type = SND_ST_UNIPERIF_TYPE_NONE;
-
-	/* Save the info structure */
-	player->info = info;
-
-	/* Get PCM_CLK_SEL & PCMP_VALID_SEL from audio-glue-ctrl SoC reg */
-	if (uni_player_parse_dt_audio_glue(pdev, player))
-		return -EINVAL;
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.startup = uni_player_startup,
 		.shutdown = uni_player_shutdown,
@@ -1114,13 +1060,18 @@ int uni_player_init(struct platform_device *pdev,
 	player->state = UNIPERIF_STATE_STOPPED;
 	player->dai_ops = &uni_player_dai_ops;
 
-	ret = uni_player_parse_dt(pdev, player);
+	/* Get PCM_CLK_SEL & PCMP_VALID_SEL from audio-glue-ctrl SoC reg */
+	ret = uni_player_parse_dt_audio_glue(pdev, player);
 
 	if (ret < 0) {
 		dev_err(player->dev, "Failed to parse DeviceTree");
 		return ret;
 	}
 
+	/* Underflow recovery is only supported on later ip revisions */
+	if (player->ver >= SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
+		player->underflow_enabled = 1;
+
 	if (UNIPERIF_TYPE_IS_TDM(player))
 		player->hw = &uni_tdm_hw;
 	else
@@ -1144,8 +1095,8 @@ int uni_player_init(struct platform_device *pdev,
 
 	/* connect to I2S/TDM TX bus */
 	if (player->valid_sel &&
-	    (player->info->id == UNIPERIF_PLAYER_I2S_OUT)) {
-		ret = regmap_field_write(player->valid_sel, player->info->id);
+	    (player->id == UNIPERIF_PLAYER_I2S_OUT)) {
+		ret = regmap_field_write(player->valid_sel, player->id);
 		if (ret) {
 			dev_err(player->dev,
 				"%s: unable to connect to tdm bus", __func__);
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index eb74a328c928..0e1c3ee56675 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -13,6 +13,7 @@
 
 #include "uniperif.h"
 
+#define UNIPERIF_READER_I2S_IN 0 /* reader id connected to I2S/TDM TX bus */
 /*
  * Note: snd_pcm_hardware is linked to DMA controller but is declared here to
  * integrate unireader capability in term of rate and supported channels
@@ -195,7 +196,7 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 	}
 
 	/* Calculate transfer size (in fifo cells and bytes) for frame count */
-	if (reader->info->type == SND_ST_UNIPERIF_TYPE_TDM) {
+	if (reader->type == SND_ST_UNIPERIF_TYPE_TDM) {
 		/* transfer size = unip frame size (in 32 bits FIFO cell) */
 		transfer_size =
 			sti_uniperiph_get_user_frame_size(runtime) / 4;
@@ -280,7 +281,7 @@ static int uni_reader_prepare(struct snd_pcm_substream *substream,
 	SET_UNIPERIF_ITM_BSET_MEM_BLK_READ(reader);
 
 	/* Enable underflow recovery interrupts */
-	if (reader->info->underflow_enabled) {
+	if (reader->underflow_enabled) {
 		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_DONE(reader);
 		SET_UNIPERIF_ITM_BSET_UNDERFLOW_REC_FAILED(reader);
 	}
@@ -394,41 +395,6 @@ static void uni_reader_shutdown(struct snd_pcm_substream *substream,
 	}
 }
 
-static int uni_reader_parse_dt(struct platform_device *pdev,
-			       struct uniperif *reader)
-{
-	struct uniperif_info *info;
-	struct device_node *node = pdev->dev.of_node;
-	const char *mode;
-
-	/* Allocate memory for the info structure */
-	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	if (of_property_read_u32(node, "st,version", &reader->ver) ||
-	    reader->ver == SND_ST_UNIPERIF_VERSION_UNKNOWN) {
-		dev_err(&pdev->dev, "Unknown uniperipheral version ");
-		return -EINVAL;
-	}
-
-	/* Read the device mode property */
-	if (of_property_read_string(node, "st,mode", &mode)) {
-		dev_err(&pdev->dev, "uniperipheral mode not defined");
-		return -EINVAL;
-	}
-
-	if (strcasecmp(mode, "tdm") == 0)
-		info->type = SND_ST_UNIPERIF_TYPE_TDM;
-	else
-		info->type = SND_ST_UNIPERIF_TYPE_PCM;
-
-	/* Save the info structure */
-	reader->info = info;
-
-	return 0;
-}
-
 static const struct snd_soc_dai_ops uni_reader_dai_ops = {
 		.startup = uni_reader_startup,
 		.shutdown = uni_reader_shutdown,
@@ -448,12 +414,6 @@ int uni_reader_init(struct platform_device *pdev,
 	reader->state = UNIPERIF_STATE_STOPPED;
 	reader->dai_ops = &uni_reader_dai_ops;
 
-	ret = uni_reader_parse_dt(pdev, reader);
-	if (ret < 0) {
-		dev_err(reader->dev, "Failed to parse DeviceTree");
-		return ret;
-	}
-
 	if (UNIPERIF_TYPE_IS_TDM(reader))
 		reader->hw = &uni_tdm_hw;
 	else
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
