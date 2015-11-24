From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 2/2] ASoC: sti: correction for HBRA support
Date: Tue, 24 Nov 2015 14:16:36 +0100
Message-ID: <1448370996-30224-3-git-send-email-moise.gergaud@st.com>
References: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6901C265DB7
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2015 14:16:54 +0100 (CET)
In-Reply-To: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de
Cc: Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Detect HBRA based on rate and channels used in the pcm session
In case of HBRA:
  - CH_STS repeat is disabled
  - channel status sampling freq is not set if already set (because it can
    be a multiple of the runtime rate)

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 72 +++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 7aca6b9..d6b7cea 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -244,55 +244,70 @@ static void uni_player_set_channel_status(struct uniperif *player,
 {
 	int n;
 	unsigned int status;
+	unsigned char *aes3 = &player->stream_settings.iec958.status[3];
+	const unsigned int cs_rate[] = {
+		44100, 0, 48000, 32000, 22050, 24000,
+		88200, 768000, 176400, 192000
+	};
 
 	/*
 	 * Some AVRs and TVs require the channel status to contain a correct
-	 * sampling frequency. If no sample rate is already specified, then
-	 * set one.
+	 * sampling freq.
+	 * In case of HBRA is not detected:
+	 *   set the channel status sampling freq
+	 * In case of HBRA is detected:
+	 *   channel status sampling freq is already set; it can be a multiple
+	 *   of runtime rate
+	 *
+	 * HBRA is detected when:
+	 *   runtime channels is 8 and runtime->rate < channel status rate
 	 */
+
 	mutex_lock(&player->ctrl_lock);
-	if (runtime) {
+
+	if ((runtime->channels == 8) &&
+	    (runtime->rate < cs_rate[*aes3 & IEC958_AES3_CON_FS])) {
+		/*
+		 * Consecutive frames repetition of Z preamble needs to be
+		 * disabled in case of HBRA
+		 */
+		SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_DISABLE(player);
+	} else {
+		SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(player);
+
+		*aes3 &= ~IEC958_AES3_CON_FS;
+
 		switch (runtime->rate) {
 		case 22050:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_22050;
+			*aes3 |= IEC958_AES3_CON_FS_22050;
 			break;
 		case 44100:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_44100;
+			*aes3 |= IEC958_AES3_CON_FS_44100;
 			break;
 		case 88200:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_88200;
+			*aes3 |= IEC958_AES3_CON_FS_88200;
 			break;
 		case 176400:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_176400;
+			*aes3 |= IEC958_AES3_CON_FS_176400;
 			break;
 		case 24000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_24000;
+			*aes3 |= IEC958_AES3_CON_FS_24000;
 			break;
 		case 48000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_48000;
+			*aes3 |= IEC958_AES3_CON_FS_48000;
 			break;
 		case 96000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_96000;
+			*aes3 |= IEC958_AES3_CON_FS_96000;
 			break;
 		case 192000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_192000;
+			*aes3 |= IEC958_AES3_CON_FS_192000;
 			break;
 		case 32000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_32000;
+			*aes3 |= IEC958_AES3_CON_FS_32000;
 			break;
 		default:
 			/* Mark as sampling frequency not indicated */
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_NOTID;
+			*aes3 |= IEC958_AES3_CON_FS_NOTID;
 			break;
 		}
 	}
@@ -318,7 +333,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	/* Program the new channel status */
 	for (n = 0; n < 6; ++n) {
 		status  =
-		player->stream_settings.iec958.status[0 + (n * 4)] & 0xf;
+		player->stream_settings.iec958.status[0 + (n * 4)] & 0xff;
 		status |=
 		player->stream_settings.iec958.status[1 + (n * 4)] << 8;
 		status |=
@@ -398,9 +413,6 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 	/* Disable one-bit audio mode */
 	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
 
-	/* Enable consecutive frames repetition of Z preamble (not for HBRA) */
-	SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(player);
-
 	/* Change to SUF0_SUBF1 and left/right channels swap! */
 	SET_UNIPERIF_CONFIG_SUBFRAME_SEL_SUBF1_SUBF0(player);
 
@@ -563,6 +575,7 @@ static int uni_player_ctl_iec958_get(struct snd_kcontrol *kcontrol,
 	ucontrol->value.iec958.status[1] = iec958->status[1];
 	ucontrol->value.iec958.status[2] = iec958->status[2];
 	ucontrol->value.iec958.status[3] = iec958->status[3];
+	ucontrol->value.iec958.status[4] = iec958->status[4];
 	mutex_unlock(&player->ctrl_lock);
 	return 0;
 }
@@ -574,15 +587,18 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
 	struct snd_aes_iec958 *iec958 =  &player->stream_settings.iec958;
+	struct snd_pcm_substream *substream = player->substream;
 
 	mutex_lock(&player->ctrl_lock);
 	iec958->status[0] = ucontrol->value.iec958.status[0];
 	iec958->status[1] = ucontrol->value.iec958.status[1];
 	iec958->status[2] = ucontrol->value.iec958.status[2];
 	iec958->status[3] = ucontrol->value.iec958.status[3];
+	iec958->status[4] = ucontrol->value.iec958.status[4];
 	mutex_unlock(&player->ctrl_lock);
 
-	uni_player_set_channel_status(player, NULL);
+	if (substream && substream->runtime)
+		uni_player_set_channel_status(player, substream->runtime);
 
 	return 0;
 }
-- 
1.9.1
