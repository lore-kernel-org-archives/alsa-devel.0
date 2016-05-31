From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2] ASoC: ak4642: Implement suspend callback
Date: Tue, 31 May 2016 13:34:59 +0300
Message-ID: <20160531103459.18569-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id EA4BA2654E6
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 12:35:07 +0200 (CEST)
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
Hi,

Changes since v1:
- take into use the suspend callback (set the suspend in soc_codec_dev_ak4642)

Regards,
Peter

 sound/soc/codecs/ak4642.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ak4642.c b/sound/soc/codecs/ak4642.c
index 4d8b9e49e8d6..cc941d66ec3d 100644
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
@@ -544,6 +552,7 @@ static int ak4642_probe(struct snd_soc_codec *codec)
 
 static struct snd_soc_codec_driver soc_codec_dev_ak4642 = {
 	.probe			= ak4642_probe,
+	.suspend		= ak4642_suspend,
 	.resume			= ak4642_resume,
 	.set_bias_level		= ak4642_set_bias_level,
 	.controls		= ak4642_snd_controls,
-- 
2.8.3
