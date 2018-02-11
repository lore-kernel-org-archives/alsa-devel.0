From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/4] ASoC: fsl-asoc-card: Use
	'snd_pcm_format_t' type when appropriate
Date: Sun, 11 Feb 2018 19:53:18 -0200
Message-ID: <1518386001-4322-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 6341D266C0E
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 22:53:51 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id s198so239676qke.5
 for <alsa-devel@alsa-project.org>; Sun, 11 Feb 2018 13:53:50 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

A better suited type for 'sample_format' and 'asrc_format' is
'snd_pcm_format_t'.

Change the type so that the following build warnings with W=1 are gone:

sound/soc/fsl/fsl-asoc-card.c:153:29: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl-asoc-card.c:153:29:    expected unsigned int [unsigned] [usertype] sample_format
sound/soc/fsl/fsl-asoc-card.c:153:29:    got restricted snd_pcm_format_t
sound/soc/fsl/fsl-asoc-card.c:258:44: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl-asoc-card.c:525:29: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl-asoc-card.c:525:29:    expected unsigned int [unsigned] [usertype] sample_format
sound/soc/fsl/fsl-asoc-card.c:525:29:    got restricted snd_pcm_format_t [usertype] <noident>
sound/soc/fsl/fsl-asoc-card.c:680:43: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl-asoc-card.c:680:43:    expected unsigned int [unsigned] [usertype] asrc_format
sound/soc/fsl/fsl-asoc-card.c:680:43:    got restricted snd_pcm_format_t [usertype] <noident>
sound/soc/fsl/fsl-asoc-card.c:682:43: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl-asoc-card.c:682:43:    expected unsigned int [unsigned] [usertype] asrc_format
sound/soc/fsl/fsl-asoc-card.c:682:43:    got restricted snd_pcm_format_t [usertype] <noident>

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 989be51..4a6750a 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -91,9 +91,9 @@ struct fsl_asoc_card_priv {
 	struct cpu_priv cpu_priv;
 	struct snd_soc_card card;
 	u32 sample_rate;
-	u32 sample_format;
+	snd_pcm_format_t sample_format;
 	u32 asrc_rate;
-	u32 asrc_format;
+	snd_pcm_format_t asrc_format;
 	u32 dai_fmt;
 	char name[32];
 };
@@ -199,7 +199,7 @@ static int be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 
 	mask = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 	snd_mask_none(mask);
-	snd_mask_set(mask, priv->asrc_format);
+	snd_mask_set(mask, (__force int)priv->asrc_format);
 
 	return 0;
 }
-- 
2.7.4
