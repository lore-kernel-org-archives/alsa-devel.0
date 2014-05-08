From: Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/4] ASoC: rt5645: Staticise non-exported
	symbols
Date: Thu, 8 May 2014 14:47:35 +0800
Message-ID: <1399531657-31793-2-git-send-email-oder_chiou@realtek.com>
References: <1399531657-31793-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 36D0D2654CB
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 08:47:50 +0200 (CEST)
In-Reply-To: <1399531657-31793-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, bardliao@realtek.com, alsa-devel@alsa-project.org, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch is for staticising non-exported symbols

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rt5645.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 37ec468..9d8c7c8 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2248,7 +2248,7 @@ static int rt5645_resume(struct snd_soc_codec *codec)
 #define RT5645_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5645_aif_dai_ops = {
+static struct snd_soc_dai_ops rt5645_aif_dai_ops = {
 	.hw_params = rt5645_hw_params,
 	.set_fmt = rt5645_set_dai_fmt,
 	.set_sysclk = rt5645_set_dai_sysclk,
@@ -2256,7 +2256,7 @@ struct snd_soc_dai_ops rt5645_aif_dai_ops = {
 	.set_pll = rt5645_set_dai_pll,
 };
 
-struct snd_soc_dai_driver rt5645_dai[] = {
+static struct snd_soc_dai_driver rt5645_dai[] = {
 	{
 		.name = "rt5645-aif1",
 		.id = RT5645_AIF1,
@@ -2459,7 +2459,7 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-struct i2c_driver rt5645_i2c_driver = {
+static struct i2c_driver rt5645_i2c_driver = {
 	.driver = {
 		.name = "rt5645",
 		.owner = THIS_MODULE,
-- 
1.8.1.1.439.g50a6b54
