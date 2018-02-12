From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl-asoc-card: Use 'snd_pcm_format_t'
	type when appropriate" to the asoc tree
Date: Mon, 12 Feb 2018 12:53:11 +0000
Message-ID: <E1elDbb-0006d1-OJ@debutante>
References: <1518386001-4322-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6B72681B8
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:53:14 +0100 (CET)
In-Reply-To: <1518386001-4322-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl-asoc-card: Use 'snd_pcm_format_t' type when appropriate

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From fc734c244ab5bad427baa57e2e729d2a623b2fa1 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 11 Feb 2018 19:53:18 -0200
Subject: [PATCH] ASoC: fsl-asoc-card: Use 'snd_pcm_format_t' type when
 appropriate

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 989be518c4ed..4a6750aa3637 100644
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
2.16.1
