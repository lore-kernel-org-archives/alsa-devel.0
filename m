From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 3/3] ASoC: sti: correction for HBRA (High Bit
	Rate Audio) support
Date: Wed, 2 Dec 2015 15:22:06 +0100
Message-ID: <1449066126-19431-4-git-send-email-moise.gergaud@st.com>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 806CD261B0A
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 15:22:29 +0100 (CET)
In-Reply-To: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: arnaud.pouliquen@st.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.de, rmk+kernel@arm.linux.org.uk
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
 sound/soc/sti/uniperif_player.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index b55e412..cf99dee 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -246,16 +246,39 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	int n;
 	unsigned int status;
 	unsigned char *aes = player->stream_settings.iec958.status;
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
 
-	/* update channel status sampling freq */
-	snd_pcm_update_iec958_consumer(runtime, aes, 4);
+	if ((runtime->channels == 8) &&
+	    (runtime->rate < cs_rate[aes[3] & IEC958_AES3_CON_FS])) {
+		/*
+		 * Consecutive frames repetition of Z preamble needs to be
+		 * disabled in case of HBRA
+		 */
+		SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_DISABLE(player);
+	} else {
+		SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(player);
+
+		/* update channel status sampling freq */
+		snd_pcm_update_iec958_consumer(runtime, aes, 4);
+	}
 
 	/* Audio mode:
 	 * Use audio mode status to select PCM or encoded mode
@@ -358,9 +381,6 @@ static int uni_player_prepare_iec958(struct uniperif *player,
 	/* Disable one-bit audio mode */
 	SET_UNIPERIF_CONFIG_ONE_BIT_AUD_DISABLE(player);
 
-	/* Enable consecutive frames repetition of Z preamble (not for HBRA) */
-	SET_UNIPERIF_CONFIG_REPEAT_CHL_STS_ENABLE(player);
-
 	/* Change to SUF0_SUBF1 and left/right channels swap! */
 	SET_UNIPERIF_CONFIG_SUBFRAME_SEL_SUBF1_SUBF0(player);
 
-- 
1.9.1
