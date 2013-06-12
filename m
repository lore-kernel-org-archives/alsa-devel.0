From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 1/2] ASoC: rt5640: fix sparse warnings
Date: Wed, 12 Jun 2013 15:34:23 -0600
Message-ID: <1371072864-13205-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D354261705
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 23:34:32 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

This fixes:
975:9: sparse: Using plain integer as NULL pointer
1917:24: sparse: symbol 'rt5640_aif_dai_ops' was not declared. Should it be static?
1924:27: sparse: symbol 'rt5640_dai' was not declared. Should it be static?
2079:19: sparse: symbol 'rt5640_i2c_driver' was not declared. Should it be static?

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/codecs/rt5640.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 8761552..ce585e3 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -974,7 +974,7 @@ static const struct snd_soc_dapm_widget rt5640_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("LDO2", RT5640_PWR_ANLG1,
 			RT5640_PWR_LDO2_BIT, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("MICBIAS1", RT5640_PWR_ANLG2,
-			RT5640_PWR_MB1_BIT, 0, 0, 0),
+			RT5640_PWR_MB1_BIT, 0, NULL, 0),
 	/* Input Lines */
 	SND_SOC_DAPM_INPUT("DMIC1"),
 	SND_SOC_DAPM_INPUT("DMIC2"),
@@ -1915,14 +1915,14 @@ static int rt5640_resume(struct snd_soc_codec *codec)
 #define RT5640_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5640_aif_dai_ops = {
+static const struct snd_soc_dai_ops rt5640_aif_dai_ops = {
 	.hw_params = rt5640_hw_params,
 	.set_fmt = rt5640_set_dai_fmt,
 	.set_sysclk = rt5640_set_dai_sysclk,
 	.set_pll = rt5640_set_dai_pll,
 };
 
-struct snd_soc_dai_driver rt5640_dai[] = {
+static struct snd_soc_dai_driver rt5640_dai[] = {
 	{
 		.name = "rt5640-aif1",
 		.id = RT5640_AIF1,
@@ -2112,7 +2112,7 @@ static int rt5640_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-struct i2c_driver rt5640_i2c_driver = {
+static struct i2c_driver rt5640_i2c_driver = {
 	.driver = {
 		.name = "rt5640",
 		.owner = THIS_MODULE,
-- 
1.8.1.5
