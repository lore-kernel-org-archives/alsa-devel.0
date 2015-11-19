From: Moise Gergaud <moise.gergaud@st.com>
Subject: [PATCH 3/4] ASoC: sti: set player private data
Date: Thu, 19 Nov 2015 14:54:09 +0100
Message-ID: <1447941250-344-4-git-send-email-moise.gergaud@st.com>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 36BBD265FFA
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 14:54:31 +0100 (CET)
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

Set substream player private data.
substream player private data is used in uni_player_irq_handler to lock,
stop & unlock the stream when interrupt indicates underflow/overflow.
If not set, then segmentation fault occurs.

Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/sti/uniperif_player.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 1e19a7c..5c2bc53 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -669,6 +669,7 @@ static int uni_player_startup(struct snd_pcm_substream *substream,
 {
 	struct sti_uniperiph_data *priv = snd_soc_dai_get_drvdata(dai);
 	struct uniperif *player = priv->dai_data.uni;
+	player->substream = substream;
 
 	player->clk_adj = 0;
 
@@ -950,6 +951,8 @@ static void uni_player_shutdown(struct snd_pcm_substream *substream,
 	if (player->state != UNIPERIF_STATE_STOPPED)
 		/* Stop the player */
 		uni_player_stop(player);
+
+	player->substream = NULL;
 }
 
 static int uni_player_parse_dt_clk_glue(struct platform_device *pdev,
-- 
1.9.1
