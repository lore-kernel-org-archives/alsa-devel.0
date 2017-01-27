From: Sergej Sawazki <ce3a@gmx.de>
Subject: [PATCH] ASoC: wm8741: Remove unneeded startup()
	callback
Date: Sat, 28 Jan 2017 00:35:45 +0100
Message-ID: <1485560145-12908-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by alsa0.perex.cz (Postfix) with ESMTP id B5062267B7C
 for <alsa-devel@alsa-project.org>; Sat, 28 Jan 2017 00:36:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, ckeepax@opensource.wolfsonmicro.com
Cc: Sergej Sawazki <ce3a@gmx.de>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Do not apply rate constraints in the startup() callback. The machine driver
can change the sysclk and hence the supported frame rates in its hw_params().
This callback is unneeded since commit e369bd006fd6 ("ASoC: wm8741: Allow
master clock switching").

Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
---
 sound/soc/codecs/wm8741.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index b8c1940..d6e540a 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -176,20 +176,6 @@ static const struct snd_pcm_hw_constraint_list constraints_36864 = {
 	.list	= rates_36864,
 };
 
-static int wm8741_startup(struct snd_pcm_substream *substream,
-			  struct snd_soc_dai *dai)
-{
-	struct snd_soc_codec *codec = dai->codec;
-	struct wm8741_priv *wm8741 = snd_soc_codec_get_drvdata(codec);
-
-	if (wm8741->sysclk)
-		snd_pcm_hw_constraint_list(substream->runtime, 0,
-				SNDRV_PCM_HW_PARAM_RATE,
-				wm8741->sysclk_constraints);
-
-	return 0;
-}
-
 static int wm8741_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
@@ -360,7 +346,6 @@ static int wm8741_set_dai_fmt(struct snd_soc_dai *codec_dai,
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dai_ops wm8741_dai_ops = {
-	.startup	= wm8741_startup,
 	.hw_params	= wm8741_hw_params,
 	.set_sysclk	= wm8741_set_dai_sysclk,
 	.set_fmt	= wm8741_set_dai_fmt,
-- 
2.7.4
