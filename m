From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ak4613: Implement suspend callback" to the asoc tree
Date: Fri, 17 Jun 2016 12:43:21 +0100
Message-ID: <E1bDsBF-000258-9s@debutante>
References: <1466080472-9817-3-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466080472-9817-3-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ak4613: Implement suspend callback

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

>From f9ae17ba97e0fd134f7c0108c70e708313a07063 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jun 2016 14:34:31 +0200
Subject: [PATCH] ASoC: ak4613: Implement suspend callback

Add the suspend callback to accompany the existing resume operation.
With the suspend/resume callbacks the regmap (regcache) state handling
can follow the recommended sequence.

Based on commit a2ebd58627e9aa48 ("ASoC: ak4642: Implement suspend
callback") by Peter Ujfalusi <peter.ujfalusi@ti.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ak4613.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 5013d2ba0c10..97798d250f08 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -437,15 +437,25 @@ static struct snd_soc_dai_driver ak4613_dai = {
 	.symmetric_rates = 1,
 };
 
-static int ak4613_resume(struct snd_soc_codec *codec)
+static int ak4613_suspend(struct snd_soc_codec *codec)
 {
 	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
 
+	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
+	return 0;
+}
+
+static int ak4613_resume(struct snd_soc_codec *codec)
+{
+	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+
+	regcache_cache_only(regmap, false);
 	return regcache_sync(regmap);
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ak4613 = {
+	.suspend		= ak4613_suspend,
 	.resume			= ak4613_resume,
 	.set_bias_level		= ak4613_set_bias_level,
 	.controls		= ak4613_snd_controls,
-- 
2.8.1
