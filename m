From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH v3 3/4] ASoC: sti: use iec channel status
	control helper
Date: Tue, 1 Mar 2016 09:19:16 +0100
Message-ID: <1456820357-2545-4-git-send-email-arnaud.pouliquen@st.com>
References: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id C2DDE265191
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 09:19:37 +0100 (CET)
In-Reply-To: <1456820357-2545-1-git-send-email-arnaud.pouliquen@st.com>
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
 sound/soc/sti/uniperif_player.c | 79 ++++++++++++++++-------------------------
 2 files changed, 32 insertions(+), 48 deletions(-)

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
diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 7aca6b9..8b8697b 100644
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
@@ -541,60 +542,18 @@ static int uni_player_prepare_pcm(struct uniperif *player,
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
+	struct snd_soc_dai *dai = pdata;
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
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
@@ -659,7 +618,6 @@ static struct snd_kcontrol_new *snd_sti_pcm_ctl[] = {
 };
 
 static struct snd_kcontrol_new *snd_sti_iec_ctl[] = {
-	&uni_player_iec958_ctl,
 	&uni_player_clk_adj_ctl,
 };
 
@@ -1030,6 +988,30 @@ static int uni_player_parse_dt(struct platform_device *pdev,
 	return 0;
 }
 
+static int uni_player_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			      struct snd_soc_dai *dai)
+{
+	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
+	struct uniperif *player = priv->dai_data.uni;
+	struct snd_pcm_iec958_params *params;
+
+	if (!UNIPERIF_PLAYER_TYPE_IS_IEC958(player))
+		return 0;
+
+	params = devm_kzalloc(dai->dev, sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+
+	params->iec = &player->stream_settings.iec958;
+	params->pdata = player;
+	params->mutex = &player->ctrl_lock;
+	params->pdata = dai;
+	params->ctrl_set = uni_player_ctl_iec958_set;
+
+	return snd_pcm_create_iec958_ctl(rtd->pcm, params,
+					 SNDRV_PCM_STREAM_PLAYBACK);
+}
+
 static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.startup = uni_player_startup,
 		.shutdown = uni_player_shutdown,
@@ -1037,7 +1019,8 @@ static const struct snd_soc_dai_ops uni_player_dai_ops = {
 		.trigger = uni_player_trigger,
 		.hw_params = sti_uniperiph_dai_hw_params,
 		.set_fmt = sti_uniperiph_dai_set_fmt,
-		.set_sysclk = uni_player_set_sysclk
+		.set_sysclk = uni_player_set_sysclk,
+		.pcm_new = uni_player_pcm_new,
 };
 
 int uni_player_init(struct platform_device *pdev,
-- 
1.9.1
