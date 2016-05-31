From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: ak4642: Implement suspend callback
Date: Tue, 31 May 2016 13:14:30 +0300
Message-ID: <20160531101430.14396-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D6D72654CD
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 12:14:37 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Add the suspend callback to accompany the existing resume operation.
With the suspend/resume callbacks the regmap (regcache) state handling can
follow the recommended sequence.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/ak4642.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 4d8b9e49e8d6..ca9e82568b3c 100644
--- a/sound/soc/codecs/ak4642.c
+++ b/sound/soc/codecs/ak4642.c
@@ -523,15 +523,23 @@ static struct snd_soc_dai_driver ak4642_dai = {
 	.symmetric_rates = 1,
 };
 
-static int ak4642_resume(struct snd_soc_codec *codec)
+static int ak4642_suspend(struct snd_soc_codec *codec)
 {
 	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
 
+	regcache_cache_only(regmap, true);
 	regcache_mark_dirty(regmap);
-	regcache_sync(regmap);
 	return 0;
 }
 
+static int ak4642_resume(struct snd_soc_codec *codec)
+{
+	struct regmap *regmap = dev_get_regmap(codec->dev, NULL);
+
+	regcache_cache_only(regmap, false);
+	regcache_sync(regmap);
+	return 0;
+}
 static int ak4642_probe(struct snd_soc_codec *codec)
 {
 	struct ak4642_priv *priv = snd_soc_codec_get_drvdata(codec);
-- 
2.8.3
