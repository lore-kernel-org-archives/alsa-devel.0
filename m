From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	wm5110" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:50 +0000
Message-ID: <E1eLvoM-0000db-GK@debutante>
References: <87pobbklce.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DD53B267686
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:53 +0100 (CET)
In-Reply-To: <87pobbklce.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on wm5110

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

>From 893d7cbea2fa259573e4ba36075e74f489f6dd28 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:04:45 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on wm5110

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 6ed1e1f9ce51..fb0cf9c61f48 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -2280,9 +2280,11 @@ static int wm5110_codec_probe(struct snd_soc_codec *codec)
 	struct snd_soc_dapm_context *dapm = snd_soc_codec_get_dapm(codec);
 	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
 	struct wm5110_priv *priv = snd_soc_codec_get_drvdata(codec);
+	struct arizona *arizona = priv->core.arizona;
 	int i, ret;
 
-	priv->core.arizona->dapm = dapm;
+	arizona->dapm = dapm;
+	snd_soc_codec_init_regmap(codec, arizona->regmap);
 
 	ret = arizona_init_spk(codec);
 	if (ret < 0)
@@ -2344,17 +2346,9 @@ static unsigned int wm5110_digital_vu[] = {
 	ARIZONA_DAC_DIGITAL_VOLUME_6R,
 };
 
-static struct regmap *wm5110_get_regmap(struct device *dev)
-{
-	struct wm5110_priv *priv = dev_get_drvdata(dev);
-
-	return priv->core.arizona->regmap;
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_wm5110 = {
 	.probe = wm5110_codec_probe,
 	.remove = wm5110_codec_remove,
-	.get_regmap = wm5110_get_regmap,
 
 	.idle_bias_off = true,
 
-- 
2.15.0
