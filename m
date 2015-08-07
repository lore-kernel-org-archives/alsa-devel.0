From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: Add IEC control" to the asoc tree
Date: Fri, 07 Aug 2015 15:00:10 +0100
Message-ID: <E1ZNiBu-0005i8-Ks@finisterre>
References: <1434983473-25092-10-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 25F4226046A
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 16:00:32 +0200 (CEST)
In-Reply-To: <1434983473-25092-10-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: Add IEC control

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

>From 36cc093520b9a6348292c253d3ec03bb67a84da8 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Thu, 16 Jul 2015 11:36:07 +0200
Subject: [PATCH] ASoC: sti: Add IEC control

Add control to configure IEC60958 settings.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/uniperif_player.c | 77 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index d8df906..f6eefe1 100644
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
2.5.0
