From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/3] ASoC: uda1380: Cleanup manual bias level
	transitions
Date: Sun, 23 Nov 2014 15:04:14 +0100
Message-ID: <1416751454-16916-3-git-send-email-lars@metafoo.de>
References: <1416751454-16916-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-218.synserver.de (smtp-out-218.synserver.de
 [212.40.185.218])
 by alsa0.perex.cz (Postfix) with ESMTP id D09E626167A
 for <alsa-devel@alsa-project.org>; Sun, 23 Nov 2014 15:04:17 +0100 (CET)
In-Reply-To: <1416751454-16916-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Set the CODEC driver's suspend_bias_off flag rather than manually going to
SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
the code a bit shorter and cleaner.

Since the ASoC core now takes care of setting the bias level to
SND_SOC_BIAS_OFF when removing the CODEC there is no need to do it manually
anymore either.

The manual transition to SND_SOC_BIAS_STANDBY at the end of CODEC probe()
can also be removed as the core will automatically do this after the CODEC
has been probed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/uda1380.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index e62e707..dc7778b 100644
--- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -693,18 +693,6 @@ static struct snd_soc_dai_driver uda1380_dai[] = {
 },
 };
 
-static int uda1380_suspend(struct snd_soc_codec *codec)
-{
-	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	return 0;
-}
-
-static int uda1380_resume(struct snd_soc_codec *codec)
-{
-	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
-	return 0;
-}
-
 static int uda1380_probe(struct snd_soc_codec *codec)
 {
 	struct uda1380_platform_data *pdata =codec->dev->platform_data;
@@ -739,8 +727,6 @@ static int uda1380_probe(struct snd_soc_codec *codec)
 
 	INIT_WORK(&uda1380->work, uda1380_flush_work);
 
-	/* power on device */
-	uda1380_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 	/* set clock input */
 	switch (pdata->dac_clk) {
 	case UDA1380_DAC_CLK_SYSCLK:
@@ -766,8 +752,6 @@ static int uda1380_remove(struct snd_soc_codec *codec)
 {
 	struct uda1380_platform_data *pdata =codec->dev->platform_data;
 
-	uda1380_set_bias_level(codec, SND_SOC_BIAS_OFF);
-
 	gpio_free(pdata->gpio_reset);
 	gpio_free(pdata->gpio_power);
 
@@ -777,11 +761,11 @@ static int uda1380_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_uda1380 = {
 	.probe =	uda1380_probe,
 	.remove =	uda1380_remove,
-	.suspend =	uda1380_suspend,
-	.resume =	uda1380_resume,
 	.read =		uda1380_read_reg_cache,
 	.write =	uda1380_write,
 	.set_bias_level = uda1380_set_bias_level,
+	.suspend_bias_off = true,
+
 	.reg_cache_size = ARRAY_SIZE(uda1380_reg),
 	.reg_word_size = sizeof(u16),
 	.reg_cache_default = uda1380_reg,
-- 
1.8.0
