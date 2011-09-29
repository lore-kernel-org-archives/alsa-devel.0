From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Staticise non-exported symbols in
	rt5631
Date: Thu, 29 Sep 2011 17:32:46 +0100
Message-ID: <1317313968-18966-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BCF4624657
	for <alsa-devel@Alsa-project.org>;
	Thu, 29 Sep 2011 18:32:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@Alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/rt5631.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5631.c b/sound/soc/codecs/rt5631.c
index 889a7dd..7e1f894 100644
--- a/sound/soc/codecs/rt5631.c
+++ b/sound/soc/codecs/rt5631.c
@@ -1308,7 +1308,7 @@ static const struct pll_div codec_slave_pll_div[] = {
 	{3072000,  12288000,  0x0a90},
 };
 
-struct coeff_clk_div coeff_div[] = {
+static struct coeff_clk_div coeff_div[] = {
 	/* sysclk is 256fs */
 	{2048000,  8000 * 32,  8000, 0x1000},
 	{2048000,  8000 * 64,  8000, 0x0000},
@@ -1680,7 +1680,7 @@ static int rt5631_resume(struct snd_soc_codec *codec)
 			SNDRV_PCM_FMTBIT_S24_LE | \
 			SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5631_ops = {
+static struct snd_soc_dai_ops rt5631_ops = {
 	.hw_params = rt5631_hifi_pcm_params,
 	.set_fmt = rt5631_hifi_codec_set_dai_fmt,
 	.set_sysclk = rt5631_hifi_codec_set_dai_sysclk,
@@ -1762,7 +1762,7 @@ static __devexit int rt5631_i2c_remove(struct i2c_client *client)
 	return 0;
 }
 
-struct i2c_driver rt5631_i2c_driver = {
+static struct i2c_driver rt5631_i2c_driver = {
 	.driver = {
 		.name = "rt5631",
 		.owner = THIS_MODULE,
-- 
1.7.6.3
