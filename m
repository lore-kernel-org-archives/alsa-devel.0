From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/2] ASoC: rt5670: Staticise non-exported
	symbols
Date: Fri,  1 Aug 2014 17:31:23 +0100
Message-ID: <1406910684-29708-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B37872655D1
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 19:23:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/rt5670.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index 879d42e..31f664f 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -2407,7 +2407,7 @@ static int rt5670_resume(struct snd_soc_codec *codec)
 #define RT5670_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5670_aif_dai_ops = {
+static struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.hw_params = rt5670_hw_params,
 	.set_fmt = rt5670_set_dai_fmt,
 	.set_sysclk = rt5670_set_dai_sysclk,
@@ -2415,7 +2415,7 @@ struct snd_soc_dai_ops rt5670_aif_dai_ops = {
 	.set_pll = rt5670_set_dai_pll,
 };
 
-struct snd_soc_dai_driver rt5670_dai[] = {
+static struct snd_soc_dai_driver rt5670_dai[] = {
 	{
 		.name = "rt5670-aif1",
 		.id = RT5670_AIF1,
@@ -2675,7 +2675,7 @@ static int rt5670_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-struct i2c_driver rt5670_i2c_driver = {
+static struct i2c_driver rt5670_i2c_driver = {
 	.driver = {
 		.name = "rt5670",
 		.owner = THIS_MODULE,
-- 
2.0.0
