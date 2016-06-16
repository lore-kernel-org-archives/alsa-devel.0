From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] ASoC: ak4613: Implement suspend callback
Date: Thu, 16 Jun 2016 14:34:31 +0200
Message-ID: <1466080472-9817-3-git-send-email-geert+renesas@glider.be>
References: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1466080472-9817-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, patches@opensource.wolfsonmicro.com, linux-renesas-soc@vger.kernel.org, alsa-devel@alsa-project.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: alsa-devel@alsa-project.org

Add the suspend callback to accompany the existing resume operation.
With the suspend/resume callbacks the regmap (regcache) state handling
can follow the recommended sequence.

Based on commit a2ebd58627e9aa48 ("ASoC: ak4642: Implement suspend
callback") by Peter Ujfalusi <peter.ujfalusi@ti.com>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 sound/soc/codecs/ak4613.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 5013d2ba0c10a968..97798d250f08689e 100644
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
1.9.1
