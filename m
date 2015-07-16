From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 6/6] ASoC: sti: Add IEC control
Date: Thu, 16 Jul 2015 11:36:07 +0200
Message-ID: <1437039367-30842-7-git-send-email-arnaud.pouliquen@st.com>
References: <1437039367-30842-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 37EDE2661E4
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 11:36:23 +0200 (CEST)
In-Reply-To: <1437039367-30842-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

Add control to configure IEC60958 settings.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 77 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d990d2c..506045c 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -250,6 +250,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * sampling frequency. If no sample rate is already specified, then
 	 * set one.
 	 */
+	mutex_lock(&player->ctrl_lock);
 	if (runtime && (player->stream_settings.iec958.status[3]
 					== IEC958_AES3_CON_FS_NOTID)) {
 		switch (runtime->rate) {
@@ -327,6 +328,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 		player->stream_settings.iec958.status[3 + (n * 4)] << 24;
 		SET_UNIPERIF_CHANNEL_STA_REGN(player, n, status);
 	}
+	mutex_unlock(&player->ctrl_lock);
 
 	/* Update the channel status */
 	if (player->ver < SND_ST_UNIPERIF_VERSION_UNI_PLR_TOP_1_0)
@@ -538,6 +540,63 @@ static int uni_player_prepare_pcm(struct uniperif *player,
 }
 
 /*
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
+	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *player = priv->dai_data.uni;
+	struct snd_aes_iec958 *iec958 = &player->stream_settings.iec958;
+
+	mutex_lock(&player->ctrl_lock);
+	ucontrol->value.iec958.status[0] = iec958->status[0];
+	ucontrol->value.iec958.status[1] = iec958->status[1];
+	ucontrol->value.iec958.status[2] = iec958->status[2];
+	ucontrol->value.iec958.status[3] = iec958->status[3];
+	mutex_unlock(&player->ctrl_lock);
+	return 0;
+}
+
+static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *dai = snd_kcontrol_chip(kcontrol);
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *player = priv->dai_data.uni;
+	struct snd_aes_iec958 *iec958 =  &player->stream_settings.iec958;
+
+	mutex_lock(&player->ctrl_lock);
+	iec958->status[0] = ucontrol->value.iec958.status[0];
+	iec958->status[1] = ucontrol->value.iec958.status[1];
+	iec958->status[2] = ucontrol->value.iec958.status[2];
+	iec958->status[3] = ucontrol->value.iec958.status[3];
+	mutex_unlock(&player->ctrl_lock);
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
  * uniperif rate adjustement control
  */
 static int snd_sti_clk_adjustment_info(struct snd_kcontrol *kcontrol,
@@ -559,7 +618,9 @@ static int snd_sti_clk_adjustment_get(struct snd_kcontrol *kcontrol,
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
 
+	mutex_lock(&player->ctrl_lock);
 	ucontrol->value.integer.value[0] = player->clk_adj;
+	mutex_unlock(&player->ctrl_lock);
 
 	return 0;
 }
@@ -594,7 +655,12 @@ static struct snd_kcontrol_new uni_player_clk_adj_ctl = {
 	.put = snd_sti_clk_adjustment_put,
 };
 
-static struct snd_kcontrol_new *snd_sti_ctl[] = {
+static struct snd_kcontrol_new *snd_sti_pcm_ctl[] = {
+	&uni_player_clk_adj_ctl,
+};
+
+static struct snd_kcontrol_new *snd_sti_iec_ctl[] = {
+	&uni_player_iec958_ctl,
 	&uni_player_clk_adj_ctl,
 };
 
@@ -1031,10 +1097,13 @@ int uni_player_init(struct platform_device *pdev,
 		player->stream_settings.iec958.status[4] =
 					IEC958_AES4_CON_MAX_WORDLEN_24 |
 					IEC958_AES4_CON_WORDLEN_24_20;
-	}
 
-	player->num_ctrls = ARRAY_SIZE(snd_sti_ctl);
-	player->snd_ctrls = snd_sti_ctl[0];
+		player->num_ctrls = ARRAY_SIZE(snd_sti_iec_ctl);
+		player->snd_ctrls = snd_sti_iec_ctl[0];
+	} else {
+		player->num_ctrls = ARRAY_SIZE(snd_sti_pcm_ctl);
+		player->snd_ctrls = snd_sti_pcm_ctl[0];
+	}
 
 	return 0;
 }
-- 
1.9.1
