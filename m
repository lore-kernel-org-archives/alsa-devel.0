From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH v2 3/7] ASoC: sti: define tdm type & default
	tdm hw config
Date: Thu, 7 Apr 2016 11:25:32 +0200
Message-ID: <1460021136-27822-4-git-send-email-moise.gergaud@st.com>
References: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id E679A264F34
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 11:25:56 +0200 (CEST)
In-Reply-To: <1460021136-27822-1-git-send-email-moise.gergaud@st.com>
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif.h b/sound/soc/sti/uniperif.h
index 75116ab..750eb5a 100644
--- a/sound/soc/sti/uniperif.h
+++ b/sound/soc/sti/uniperif.h
@@ -1228,6 +1228,9 @@
 #define UNIPERIF_TYPE_IS_IEC958(p) \
 	(UNIPERIF_TYPE_IS_HDMI(p) || \
 		UNIPERIF_TYPE_IS_SPDIF(p))
+#define UNIPERIF_TYPE_IS_TDM(p) \
+	((p)->info->type == SND_ST_UNIPERIF_TYPE_TDM)
+
 /*
  * Uniperipheral IP revisions
  */
@@ -1249,7 +1252,8 @@ enum uniperif_type {
 	SND_ST_UNIPERIF_TYPE_NONE,
 	SND_ST_UNIPERIF_TYPE_HDMI,
 	SND_ST_UNIPERIF_TYPE_PCM,
-	SND_ST_UNIPERIF_TYPE_SPDIF
+	SND_ST_UNIPERIF_TYPE_SPDIF,
+	SND_ST_UNIPERIF_TYPE_TDM
 };
 
 enum uniperif_state {
@@ -1330,6 +1334,28 @@ struct sti_uniperiph_data {
 	struct sti_uniperiph_dai dai_data;
 };
 
+static const struct snd_pcm_hardware uni_tdm_hw = {
+	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_MMAP |
+		SNDRV_PCM_INFO_MMAP_VALID,
+
+	.formats = SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S16_LE,
+
+	.rates = SNDRV_PCM_RATE_CONTINUOUS,
+	.rate_min = 8000,
+	.rate_max = 48000,
+
+	.channels_min = 1,
+	.channels_max = 32,
+
+	.periods_min = 2,
+	.periods_max = 10,
+
+	.period_bytes_min = 128,
+	.period_bytes_max = 64 * PAGE_SIZE,
+	.buffer_bytes_max = 256 * PAGE_SIZE
+};
+
 /* uniperiph player*/
 int uni_player_init(struct platform_device *pdev,
 		    struct uniperif *uni_player);
-- 
1.9.1
