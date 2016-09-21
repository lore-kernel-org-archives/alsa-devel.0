From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: fix sparse warnings" to the asoc tree
Date: Wed, 21 Sep 2016 13:56:14 +0100
Message-ID: <E1bmh4Q-0001cJ-4M@debutante>
References: <1474076049-9416-1-git-send-email-weiyj.lk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474076049-9416-1-git-send-email-weiyj.lk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: fix sparse warnings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 66d7c2629aa4f2c861b7cca9ff15b6bc38e9c9a8 Mon Sep 17 00:00:00 2001
From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Sat, 17 Sep 2016 01:34:09 +0000
Subject: [PATCH] ASoC: rt5663: fix sparse warnings

Fixes the following sparse warnings:

sound/soc/codecs/rt5663.c:1367:14: warning: duplicate const
sound/soc/codecs/rt5663.c:1577:5: warning:
 symbol 'rt5663_button_detect' was not declared. Should it be static?
sound/soc/codecs/rt5663.c:2857:24: warning:
 symbol 'rt5663_aif_dai_ops' was not declared. Should it be static?
sound/soc/codecs/rt5663.c:2866:27: warning:
 symbol 'rt5663_dai' was not declared. Should it be static?
sound/soc/codecs/rt5663.c:3193:6: warning:
 symbol 'rt5663_i2c_shutdown' was not declared. Should it be static?
sound/soc/codecs/rt5663.c:3200:19: warning:
 symbol 'rt5663_i2c_driver' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 8078abcaf728..90a6ad5821f6 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1364,7 +1364,7 @@ static const char * const rt5663_if1_adc_data_select[] = {
 	"L/R", "R/L", "L/L", "R/R"
 };
 
-static const SOC_ENUM_SINGLE_DECL(rt5663_if1_adc_enum, RT5663_TDM_2,
+static SOC_ENUM_SINGLE_DECL(rt5663_if1_adc_enum, RT5663_TDM_2,
 	RT5663_DATA_SWAP_ADCDAT1_SHIFT, rt5663_if1_adc_data_select);
 
 static void rt5663_enable_push_button_irq(struct snd_soc_codec *codec,
@@ -1574,7 +1574,7 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 	return rt5663->jack_type;
 }
 
-int rt5663_button_detect(struct snd_soc_codec *codec)
+static int rt5663_button_detect(struct snd_soc_codec *codec)
 {
 	int btn_type, val;
 
@@ -2857,7 +2857,7 @@ static int rt5663_resume(struct snd_soc_codec *codec)
 #define RT5663_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5663_aif_dai_ops = {
+static struct snd_soc_dai_ops rt5663_aif_dai_ops = {
 	.hw_params = rt5663_hw_params,
 	.set_fmt = rt5663_set_dai_fmt,
 	.set_sysclk = rt5663_set_dai_sysclk,
@@ -2866,7 +2866,7 @@ struct snd_soc_dai_ops rt5663_aif_dai_ops = {
 	.set_bclk_ratio = rt5663_set_bclk_ratio,
 };
 
-struct snd_soc_dai_driver rt5663_dai[] = {
+static struct snd_soc_dai_driver rt5663_dai[] = {
 	{
 		.name = "rt5663-aif",
 		.id = RT5663_AIF,
@@ -3193,14 +3193,14 @@ static int rt5663_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-void rt5663_i2c_shutdown(struct i2c_client *client)
+static void rt5663_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5663_priv *rt5663 = i2c_get_clientdata(client);
 
 	regmap_write(rt5663->regmap, RT5663_RESET, 0);
 }
 
-struct i2c_driver rt5663_i2c_driver = {
+static struct i2c_driver rt5663_i2c_driver = {
 	.driver = {
 		.name = "rt5663",
 		.owner = THIS_MODULE,
-- 
2.8.1
