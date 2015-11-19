From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 4/4] ASoC: sti: reset iec60958 settings on close
Date: Thu, 19 Nov 2015 14:54:10 +0100
Message-ID: <1447941250-344-5-git-send-email-moise.gergaud@st.com>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A0AB266190
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 14:54:34 +0100 (CET)
In-Reply-To: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
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

Reset IEC 60958 settings for next PCM session.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 5c2bc53..b73e348 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -64,6 +64,23 @@ static const struct snd_pcm_hardware uni_player_pcm_hw = {
 	.buffer_bytes_max = 256 * PAGE_SIZE
 };
 
+static inline void reset_iec958_settings(struct uniperif *player)
+{
+	struct snd_aes_iec958 *iec958 = &player->stream_settings.iec958;
+
+	memset(iec958->status, 0, sizeof(iec958->status));
+
+	/* Broadcast reception category */
+	iec958->status[1] = IEC958_AES1_CON_GENERAL;
+	/* Do not take into account source or channel number */
+	iec958->status[2] = IEC958_AES2_CON_SOURCE_UNSPEC;
+	/* Sampling frequency not indicated */
+	iec958->status[3] = IEC958_AES3_CON_FS_NOTID;
+	/* Max sample word 24-bit, sample word length not indicated */
+	iec958->status[4] = IEC958_AES4_CON_MAX_WORDLEN_24 |
+			    IEC958_AES4_CON_WORDLEN_24_20;
+}
+
 static inline int reset_player(struct uniperif *player)
 {
 	int count = 10;
@@ -947,6 +964,11 @@ static void uni_player_shutdown(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	/*
+	 * Set default iec958 status bits done in close to allow to set
+	 * iec settings before next open pcm session
+	 */
+	reset_iec958_settings(player);
 
 	if (player->state != UNIPERIF_STATE_STOPPED)
 		/* Stop the player */
@@ -1089,23 +1111,8 @@ int uni_player_init(struct platform_device *pdev,
 	SET_UNIPERIF_CONFIG_IDLE_MOD_DISABLE(player);
 
 	if (UNIPERIF_PLAYER_TYPE_IS_IEC958(player)) {
-		/* Set default iec958 status bits  */
-
-		/* Consumer, PCM, copyright, 2ch, mode 0 */
-		player->stream_settings.iec958.status[0] = 0x00;
-		/* Broadcast reception category */
-		player->stream_settings.iec958.status[1] =
-					IEC958_AES1_CON_GENERAL;
-		/* Do not take into account source or channel number */
-		player->stream_settings.iec958.status[2] =
-					IEC958_AES2_CON_SOURCE_UNSPEC;
-		/* Sampling frequency not indicated */
-		player->stream_settings.iec958.status[3] =
-					IEC958_AES3_CON_FS_NOTID;
-		/* Max sample word 24-bit, sample word length not indicated */
-		player->stream_settings.iec958.status[4] =
-					IEC958_AES4_CON_MAX_WORDLEN_24 |
-					IEC958_AES4_CON_WORDLEN_24_20;
+		/* Set default iec958 status bits */
+		reset_iec958_settings(player);
 
 		player->num_ctrls = ARRAY_SIZE(snd_sti_iec_ctl);
 		player->snd_ctrls = snd_sti_iec_ctl[0];
-- 
1.9.1
