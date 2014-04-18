From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: rt5651: Staticise non-exported symbols
Date: Fri, 18 Apr 2014 20:02:49 +0100
Message-ID: <1397847769-28911-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 727142617AA
 for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2014 21:03:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Make the dai_ops const too since we can.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/rt5651.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index a1577369c49c..f785b81238ae 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1736,14 +1736,14 @@ static int rt5651_resume(struct snd_soc_codec *codec)
 #define RT5651_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5651_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5651_aif_dai_ops = {
 	.hw_params = rt5651_hw_params,
 	.set_fmt = rt5651_set_dai_fmt,
 	.set_sysclk = rt5651_set_dai_sysclk,
 	.set_pll = rt5651_set_dai_pll,
 };
 
-struct snd_soc_dai_driver rt5651_dai[] = {
+static struct snd_soc_dai_driver rt5651_dai[] = {
 	{
 		.name = "rt5651-aif1",
 		.id = RT5651_AIF1,
@@ -1882,7 +1882,7 @@ static int rt5651_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-struct i2c_driver rt5651_i2c_driver = {
+static struct i2c_driver rt5651_i2c_driver = {
 	.driver = {
 		.name = "rt5651",
 		.owner = THIS_MODULE,
-- 
1.9.2
