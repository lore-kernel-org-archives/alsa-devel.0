From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use codec hw_write on twl6040" to
	the asoc tree
Date: Mon, 27 Nov 2017 18:52:08 +0000
Message-ID: <E1eJOVk-0006sc-P3@debutante>
References: <87bmmvm108.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 87FBE26758B
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 19:52:12 +0100 (CET)
In-Reply-To: <87bmmvm108.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: don't use codec hw_write on twl6040

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 3bd333677d6091d989068b0f7ff7aba975e62dc5 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 9 Nov 2017 01:04:37 +0000
Subject: [PATCH] ASoC: don't use codec hw_write on twl6040

twl6040 driver is using codec hw_write/control_data,
but it is redundant code. This patch cleanup these

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 1773ff84ee3b..a8e6941a1868 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -106,10 +106,12 @@ static const struct snd_pcm_hw_constraint_list sysclk_constraints[] = {
 	{ .count = ARRAY_SIZE(hp_rates), .list = hp_rates, },
 };
 
+#define to_twl6040(codec)	dev_get_drvdata((codec)->dev->parent)
+
 static unsigned int twl6040_read(struct snd_soc_codec *codec, unsigned int reg)
 {
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
-	struct twl6040 *twl6040 = codec->control_data;
+	struct twl6040 *twl6040 = to_twl6040(codec);
 	u8 value;
 
 	if (reg >= TWL6040_CACHEREGNUM)
@@ -171,7 +173,7 @@ static inline void twl6040_update_dl12_cache(struct snd_soc_codec *codec,
 static int twl6040_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value)
 {
-	struct twl6040 *twl6040 = codec->control_data;
+	struct twl6040 *twl6040 = to_twl6040(codec);
 
 	if (reg >= TWL6040_CACHEREGNUM)
 		return -EIO;
@@ -572,7 +574,7 @@ EXPORT_SYMBOL_GPL(twl6040_get_trim_value);
 
 int twl6040_get_hs_step_size(struct snd_soc_codec *codec)
 {
-	struct twl6040 *twl6040 = codec->control_data;
+	struct twl6040 *twl6040 = to_twl6040(codec);
 
 	if (twl6040_get_revid(twl6040) < TWL6040_REV_ES1_3)
 		/* For ES under ES_1.3 HS step is 2 mV */
@@ -830,7 +832,7 @@ static const struct snd_soc_dapm_route intercon[] = {
 static int twl6040_set_bias_level(struct snd_soc_codec *codec,
 				enum snd_soc_bias_level level)
 {
-	struct twl6040 *twl6040 = codec->control_data;
+	struct twl6040 *twl6040 = to_twl6040(codec);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
@@ -922,7 +924,7 @@ static int twl6040_prepare(struct snd_pcm_substream *substream,
 			struct snd_soc_dai *dai)
 {
 	struct snd_soc_codec *codec = dai->codec;
-	struct twl6040 *twl6040 = codec->control_data;
+	struct twl6040 *twl6040 = to_twl6040(codec);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int ret;
 
@@ -964,7 +966,7 @@ static int twl6040_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 static void twl6040_mute_path(struct snd_soc_codec *codec, enum twl6040_dai_id id,
 			     int mute)
 {
-	struct twl6040 *twl6040 = codec->control_data;
+	struct twl6040 *twl6040 = to_twl6040(codec);
 	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
 	int hslctl, hsrctl, earctl;
 	int hflctl, hfrctl;
@@ -1108,7 +1110,6 @@ static struct snd_soc_dai_driver twl6040_dai[] = {
 static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv;
-	struct twl6040 *twl6040 = dev_get_drvdata(codec->dev->parent);
 	struct platform_device *pdev = to_platform_device(codec->dev);
 	int ret = 0;
 
@@ -1119,7 +1120,6 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 	snd_soc_codec_set_drvdata(codec, priv);
 
 	priv->codec = codec;
-	codec->control_data = twl6040;
 
 	priv->plug_irq = platform_get_irq(pdev, 0);
 	if (priv->plug_irq < 0) {
-- 
2.15.0
