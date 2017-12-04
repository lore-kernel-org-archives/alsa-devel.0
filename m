From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	wm8994" to the asoc tree
Date: Mon, 04 Dec 2017 18:50:00 +0000
Message-ID: <E1eLvoW-0000g8-MO@debutante>
References: <87tw0nkldt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2710026765C
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:50:04 +0100 (CET)
In-Reply-To: <87tw0nkldt.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: use snd_soc_component_init_regmap() on wm8994

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

>From 5a81eb5356c87ad60f65378464ba92a7d645ce1d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:04:02 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on wm8994

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Let's use snd_soc_component_init_regmap() and remove .get_regmap

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8994.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index f91b49e1ece3..21ffd6403173 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3993,6 +3993,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 	unsigned int reg;
 	int ret, i;
 
+	snd_soc_codec_init_regmap(codec, control->regmap);
+
 	wm8994->hubs.codec = codec;
 
 	mutex_init(&wm8994->accdet_lock);
@@ -4434,19 +4436,11 @@ static int wm8994_codec_remove(struct snd_soc_codec *codec)
 	return 0;
 }
 
-static struct regmap *wm8994_get_regmap(struct device *dev)
-{
-	struct wm8994 *control = dev_get_drvdata(dev->parent);
-
-	return control->regmap;
-}
-
 static const struct snd_soc_codec_driver soc_codec_dev_wm8994 = {
 	.probe =	wm8994_codec_probe,
 	.remove =	wm8994_codec_remove,
 	.suspend =	wm8994_codec_suspend,
 	.resume =	wm8994_codec_resume,
-	.get_regmap =   wm8994_get_regmap,
 	.set_bias_level = wm8994_set_bias_level,
 };
 
-- 
2.15.0
