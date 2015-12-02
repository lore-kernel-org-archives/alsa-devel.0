From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 2/3] ASoC: sti: use pcm iec958 channel status
	helper
Date: Wed, 2 Dec 2015 15:22:05 +0100
Message-ID: <1449066126-19431-3-git-send-email-moise.gergaud@st.com>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 0B83D261A8E
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 15:22:26 +0100 (CET)
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

Use pcm iec958 channel status helper to update sampling freq parameter.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/Kconfig           |  1 +
 sound/soc/sti/uniperif_player.c | 58 ++++++++---------------------------------
 2 files changed, 12 insertions(+), 47 deletions(-)

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
index 7aca6b9..b55e412 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -12,6 +12,7 @@
 
 #include <sound/asoundef.h>
 #include <sound/soc.h>
+#include <sound/pcm_iec958.h>
 
 #include "uniperif.h"
 
@@ -244,6 +245,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 {
 	int n;
 	unsigned int status;
+	unsigned char *aes = player->stream_settings.iec958.status;
 
 	/*
 	 * Some AVRs and TVs require the channel status to contain a correct
@@ -251,51 +253,9 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	 * set one.
 	 */
 	mutex_lock(&player->ctrl_lock);
-	if (runtime) {
-		switch (runtime->rate) {
-		case 22050:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_22050;
-			break;
-		case 44100:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_44100;
-			break;
-		case 88200:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_88200;
-			break;
-		case 176400:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_176400;
-			break;
-		case 24000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_24000;
-			break;
-		case 48000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_48000;
-			break;
-		case 96000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_96000;
-			break;
-		case 192000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_192000;
-			break;
-		case 32000:
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_32000;
-			break;
-		default:
-			/* Mark as sampling frequency not indicated */
-			player->stream_settings.iec958.status[3] =
-						IEC958_AES3_CON_FS_NOTID;
-			break;
-		}
-	}
+
+	/* update channel status sampling freq */
+	snd_pcm_update_iec958_consumer(runtime, aes, 4);
 
 	/* Audio mode:
 	 * Use audio mode status to select PCM or encoded mode
@@ -318,7 +278,7 @@ static void uni_player_set_channel_status(struct uniperif *player,
 	/* Program the new channel status */
 	for (n = 0; n < 6; ++n) {
 		status  =
-		player->stream_settings.iec958.status[0 + (n * 4)] & 0xf;
+		player->stream_settings.iec958.status[0 + (n * 4)] & 0xff;
 		status |=
 		player->stream_settings.iec958.status[1 + (n * 4)] << 8;
 		status |=
@@ -563,6 +523,7 @@ static int uni_player_ctl_iec958_get(struct snd_kcontrol *kcontrol,
 	ucontrol->value.iec958.status[1] = iec958->status[1];
 	ucontrol->value.iec958.status[2] = iec958->status[2];
 	ucontrol->value.iec958.status[3] = iec958->status[3];
+	ucontrol->value.iec958.status[4] = iec958->status[4];
 	mutex_unlock(&player->ctrl_lock);
 	return 0;
 }
@@ -574,15 +535,18 @@ static int uni_player_ctl_iec958_put(struct snd_kcontrol *kcontrol,
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
