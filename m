From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: si476x: Remove custom register I/O
	implementation
Date: Thu, 26 Sep 2013 19:34:21 +0100
Message-ID: <1380220461-16359-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A2A5C261A97
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 20:34:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

The current si476x I/O implementation wraps the regmap for the core with
functions that make the register map cache only when the device is powered
down. This implementation appears to be incomplete since there is no code
to synchronise the cache so writes done while the core is powered down
will be ignored, the device will only be configured if it is powered.

A better and more idiomatic approach would be to have the MFD manage the
cache, making the device cache only when it powers things down. This also
allows ASoC to use the standard regmap helpers for the device which helps
remove the ASoC custom ones so do convert to do that.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/si476x.c | 46 +---------------------------------------------
 1 file changed, 1 insertion(+), 45 deletions(-)

diff --git a/sound/soc/codecs/si476x.c b/sound/soc/codecs/si476x.c
index 38f3b10..ec29d26 100644
--- a/sound/soc/codecs/si476x.c
+++ b/sound/soc/codecs/si476x.c
@@ -60,48 +60,6 @@ enum si476x_pcm_format {
 	SI476X_PCM_FORMAT_S24_LE	= 6,
 };
 
-static unsigned int si476x_codec_read(struct snd_soc_codec *codec,
-				      unsigned int reg)
-{
-	int err;
-	unsigned int val;
-	struct si476x_core *core = codec->control_data;
-
-	si476x_core_lock(core);
-	if (!si476x_core_is_powered_up(core))
-		regcache_cache_only(core->regmap, true);
-
-	err = regmap_read(core->regmap, reg, &val);
-
-	if (!si476x_core_is_powered_up(core))
-		regcache_cache_only(core->regmap, false);
-	si476x_core_unlock(core);
-
-	if (err < 0)
-		return err;
-
-	return val;
-}
-
-static int si476x_codec_write(struct snd_soc_codec *codec,
-			      unsigned int reg, unsigned int val)
-{
-	int err;
-	struct si476x_core *core = codec->control_data;
-
-	si476x_core_lock(core);
-	if (!si476x_core_is_powered_up(core))
-		regcache_cache_only(core->regmap, true);
-
-	err = regmap_write(core->regmap, reg, val);
-
-	if (!si476x_core_is_powered_up(core))
-		regcache_cache_only(core->regmap, false);
-	si476x_core_unlock(core);
-
-	return err;
-}
-
 static const struct snd_soc_dapm_widget si476x_dapm_widgets[] = {
 SND_SOC_DAPM_OUTPUT("LOUT"),
 SND_SOC_DAPM_OUTPUT("ROUT"),
@@ -239,7 +197,7 @@ static int si476x_codec_hw_params(struct snd_pcm_substream *substream,
 
 static int si476x_codec_probe(struct snd_soc_codec *codec)
 {
-	codec->control_data = i2c_mfd_cell_to_core(codec->dev);
+	codec->control_data = dev_get_regmap(codec->dev.parent);
 	return 0;
 }
 
@@ -268,8 +226,6 @@ static struct snd_soc_dai_driver si476x_dai = {
 
 static struct snd_soc_codec_driver soc_codec_dev_si476x = {
 	.probe  = si476x_codec_probe,
-	.read   = si476x_codec_read,
-	.write  = si476x_codec_write,
 	.dapm_widgets = si476x_dapm_widgets,
 	.num_dapm_widgets = ARRAY_SIZE(si476x_dapm_widgets),
 	.dapm_routes = si476x_dapm_routes,
-- 
1.8.4.rc3
