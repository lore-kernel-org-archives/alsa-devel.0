From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v4 5/6] ASoC: sti: use iec channel status
	control helper
Date: Tue, 8 Mar 2016 13:54:00 +0100
Message-ID: <1457441641-7501-6-git-send-email-arnaud.pouliquen@st.com>
References: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D4CD26519F
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 13:54:31 +0100 (CET)
In-Reply-To: <1457441641-7501-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, arnaud.pouliquen@st.com, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Use helper function instead of internal function for iec control

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/Kconfig           |  1 +
 sound/soc/sti/sti_uniperif.c    | 22 ++++++++++--
 sound/soc/sti/uniperif.h        |  1 +
 sound/soc/sti/uniperif_player.c | 78 ++++++++++-------------------------------
 4 files changed, 41 insertions(+), 61 deletions(-)

diff --git a/sound/soc/sti/Kconfig b/sound/soc/sti/Kconfig
index 64a6900..8e616a4 100644
--- a/sound/soc/sti/Kconfig
+++ b/sound/soc/sti/Kconfig
@@ -6,6 +6,7 @@ menuconfig SND_SOC_STI
 	depends on SND_SOC
 	depends on ARCH_STI || COMPILE_TEST
 	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select SND_PCM_IEC958
 	help
 		Say Y if you want to enable ASoC-support for
 		any of the STI platforms (e.g. STIH416).
diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 267c44f..97e777c 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -9,6 +9,7 @@
 #include <linux/pinctrl/consumer.h>
 
 #include "uniperif.h"
+#include <sound/pcm_iec958.h>
 
 /*
  * DAI
@@ -84,10 +85,14 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct sti_uniperiph_dai *dai_data = &priv->dai_data;
-	struct uniperif *uni = priv->dai_data.uni;
+	struct uniperif *uni = dai_data->uni;
+	int ret, stream;
 
 	/* DMA settings*/
-	if (of_device_is_compatible(dai->dev->of_node, "st,sti-uni-player"))
+	stream  = of_device_is_compatible(dai->dev->of_node,
+					  "st,sti-uni-player") ?
+			SNDRV_PCM_STREAM_PLAYBACK : SNDRV_PCM_STREAM_CAPTURE;
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
 		snd_soc_dai_init_dma_data(dai, &dai_data->dma_data, NULL);
 	else
 		snd_soc_dai_init_dma_data(dai, NULL, &dai_data->dma_data);
@@ -95,6 +100,19 @@ static int sti_uniperiph_dai_probe(struct snd_soc_dai *dai)
 	dai_data->dma_data.addr = uni->fifo_phys_address;
 	dai_data->dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
+	if (uni->iec_param) {
+		const struct snd_kcontrol_new *ctrl;
+		/* create generic iec control*/
+		ctrl = snd_pcm_iec958_ctl_new(stream);
+		ret = snd_soc_add_dai_pcm_controls(dai, ctrl, 1,
+						   uni->iec_param);
+		if (ret < 0) {
+			dev_err(dai->dev, "%s: Failed to create iec control",
+				__func__);
+			return ret;
+		}
+	}
+
 	if (uni->num_ctrls)
 		return snd_soc_add_dai_pcm_controls(dai, uni->snd_ctrls,
 						    uni->num_ctrls, dai);
diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index f0fd5a9..ab06b4c 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1189,6 +1189,7 @@ struct uniperif {
 	/*alsa ctrl*/
 	struct snd_kcontrol_new *snd_ctrls;
 	int num_ctrls;
+	struct snd_pcm_iec958_params *iec_param;
 
 	/* dai properties */
 	unsigned int daifmt;
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 7aca6b9..ee69443 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -12,6 +12,7 @@
 
 #include <sound/asoundef.h>
 #include <sound/soc.h>
+#include <sound/pcm_iec958.h>
 
 #include "uniperif.h"
 
@@ -250,7 +251,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * sampling frequency. If no sample rate is already specified, then
 	 * set one.
 	 */
-	mutex_lock(&player->ctrl_lock);
 	if (runtime) {
 		switch (runtime->rate) {
 		case 22050:
@@ -327,7 +327,6 @@ static void uni_player_set_channel_status(struct uniperif *player,
 		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
 		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
 	}
-	mutex_unlock(&player->ctrl_lock);
 
 	/* Update the channel status */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -390,7 +389,9 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 	SET_UNIPERIF_CTRL_ZERO_STUFF_HW(player);
 
 	/* Update the channel status */
+	mutex_lock(&player->ctrl_lock);
 	uni_player_set_channel_status(player, runtime);
+	mutex_unlock(&player->ctrl_lock);
 
 	/* Clear the user validity user bits */
 	SET_UNIPERIF_USER_VALIDITY_VALIDITY_LR(player, 0);
@@ -541,60 +542,16 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 /*
  * ALSA uniperipheral iec958 controls
  */
-static int  uni_player_ctl_iec958_info(struct snd_kcontrol *kcontrol,
-				       struct snd_ctl_elem_info *uinfo)
-{
-	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
-	uinfo->count = 1;
-
-	return 0;
-}
 
-static int uni_player_ctl_iec958_get(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
+static int uni_player_ctl_iec958_set(void *pdata, u8 *status)
 {
-	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
-	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
-	struct uniperif *player = priv->dai_data.uni;
-	struct snd_aes_iec958 *iec958 = &player->stream_settings.iec958;
-
-	mutex_lock(&player->ctrl_lock);
-	ucontrol->value.iec958.status[0] = iec958->status[0];
-	ucontrol->value.iec958.status[1] = iec958->status[1];
-	ucontrol->value.iec958.status[2] = iec958->status[2];
-	ucontrol->value.iec958.status[3] = iec958->status[3];
-	mutex_unlock(&player->ctrl_lock);
-	return 0;
-}
-
-static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
-				     struct snd_ctl_elem_value *ucontrol)
-{
-	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
-	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
-	struct uniperif *player = priv->dai_data.uni;
-	struct snd_aes_iec958 *iec958 =  &player->stream_settings.iec958;
-
-	mutex_lock(&player->ctrl_lock);
-	iec958->status[0] = ucontrol->value.iec958.status[0];
-	iec958->status[1] = ucontrol->value.iec958.status[1];
-	iec958->status[2] = ucontrol->value.iec958.status[2];
-	iec958->status[3] = ucontrol->value.iec958.status[3];
-	mutex_unlock(&player->ctrl_lock);
+	struct uniperif *player = pdata;
 
 	uni_player_set_channel_status(player, NULL);
 
 	return 0;
 }
 
-static struct snd_kcontrol_new uni_player_iec958_ctl = {
-	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
-	.info = uni_player_ctl_iec958_info,
-	.get = uni_player_ctl_iec958_get,
-	.put = uni_player_ctl_iec958_put,
-};
-
 /*
  * uniperif rate adjustement control
  */
@@ -654,12 +611,7 @@ static struct snd_kcontrol_new uni_player_clk_adj_ctl = {
 	.put = snd_sti_clk_adjustment_put,
 };
 
-static struct snd_kcontrol_new *snd_sti_pcm_ctl[] = {
-	&uni_player_clk_adj_ctl,
-};
-
-static struct snd_kcontrol_new *snd_sti_iec_ctl[] = {
-	&uni_player_iec958_ctl,
+static struct snd_kcontrol_new *snd_sti_ctl[] = {
 	&uni_player_clk_adj_ctl,
 };
 
@@ -1106,13 +1058,21 @@ int uni_player_init(struct platform_device *pdev,
 					IEC958_AES4_CON_MAX_WORDLEN_24 |
 					IEC958_AES4_CON_WORDLEN_24_20;
 
-		player->num_ctrls = ARRAY_SIZE(snd_sti_iec_ctl);
-		player->snd_ctrls = snd_sti_iec_ctl[0];
-	} else {
-		player->num_ctrls = ARRAY_SIZE(snd_sti_pcm_ctl);
-		player->snd_ctrls = snd_sti_pcm_ctl[0];
+		player->iec_param = devm_kzalloc(player->dev,
+						 sizeof(*player->iec_param),
+						 GFP_KERNEL);
+		if (!player->iec_param)
+			return -ENOMEM;
+
+		player->iec_param->iec = &player->stream_settings.iec958;
+		player->iec_param->mutex = &player->ctrl_lock;
+		player->iec_param->pdata = player;
+		player->iec_param->ctrl_set = uni_player_ctl_iec958_set;
 	}
 
+	player->num_ctrls = ARRAY_SIZE(snd_sti_ctl);
+	player->snd_ctrls = snd_sti_ctl[0];
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uni_player_init);
-- 
1.9.1
