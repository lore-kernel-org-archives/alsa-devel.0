From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	wm5102" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:47 +0000
Message-ID: <E1eLvoJ-0000cl-8D@debutante>
References: <87o9qvklbz.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB0526762C
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:50 +0100 (CET)
In-Reply-To: <87o9qvklbz.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on wm5102

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

>From 2d6e28c368aabbdc841c44a2213a5ee16cfd5ae2 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:05:01 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on wm5102

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5102.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 4f0481d3c7a7..fc066caa1918 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1935,8 +1935,11 @@ static int wm5102_codec_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm5102_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 	int ret;
 
+	snd_soc_codec_init_regmap(codec, arizona->regmap);
+
 	ret = wm_adsp2_codec_probe(&priv->core.adsp[0], codec);
 	if (ret)
 		return ret;
@@ -1989,17 +1992,9 @@ static unsigned int wm5102_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_5R,
 };
 
-static struct regmap *wm5102_get_regmap(struct device *dev)
-{
-	struct wm5102_priv *priv = dev_get_drvdata(dev);
-
-	return priv->core.arizona->regmap;
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_wm5102 = {
 	.probe = wm5102_codec_probe,
 	.remove = wm5102_codec_remove,
-	.get_regmap = wm5102_get_regmap,
 
 	.idle_bias_off = true,
 
-- 
2.15.0
