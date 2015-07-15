From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] ASoC: da732x: Merge da732x_dai1_ops and
	da732x_dai2_ops
Date: Wed, 15 Jul 2015 09:51:33 +0800
Message-ID: <1436925093.19790.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 10DCE26571B
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 03:51:41 +0200 (CEST)
Received: by pachj5 with SMTP id hj5so14741347pac.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2015 18:51:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <support.opensource@diasemi.com>, Michal Hajduk <michal.hajduk@diasemi.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

da732x_dai1_ops is identical to da732x_dai2_ops, so merge them to
da732x_dai_ops. The da732x_dai_ops is not modified after initialization,
so make it const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/da732x.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
index b1cb465..29251b0 100644
--- a/sound/soc/codecs/da732x.c
+++ b/sound/soc/codecs/da732x.c
@@ -1196,13 +1196,7 @@ static int da732x_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
 #define	DA732X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
-static struct snd_soc_dai_ops da732x_dai1_ops = {
-	.hw_params	= da732x_hw_params,
-	.set_fmt	= da732x_set_dai_fmt,
-	.set_sysclk	= da732x_set_dai_sysclk,
-};
-
-static struct snd_soc_dai_ops da732x_dai2_ops = {
+static const struct snd_soc_dai_ops da732x_dai_ops = {
 	.hw_params	= da732x_hw_params,
 	.set_fmt	= da732x_set_dai_fmt,
 	.set_sysclk	= da732x_set_dai_sysclk,
@@ -1227,7 +1221,7 @@ static struct snd_soc_dai_driver da732x_dai[] = {
 			.rates = DA732X_RATES,
 			.formats = DA732X_FORMATS,
 		},
-		.ops = &da732x_dai1_ops,
+		.ops = &da732x_dai_ops,
 	},
 	{
 		.name	= "DA732X_AIFB",
@@ -1247,7 +1241,7 @@ static struct snd_soc_dai_driver da732x_dai[] = {
 			.rates = DA732X_RATES,
 			.formats = DA732X_FORMATS,
 		},
-		.ops = &da732x_dai2_ops,
+		.ops = &da732x_dai_ops,
 	},
 };
 
-- 
2.1.0
