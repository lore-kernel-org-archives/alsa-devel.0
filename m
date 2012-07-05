From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: arizona: Change DAPM routes for AIF
	clocks when we change them
Date: Thu,  5 Jul 2012 17:28:00 +0100
Message-ID: <1341505680-10802-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1341505680-10802-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 160E324457
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 18:30:05 +0200 (CEST)
In-Reply-To: <1341505680-10802-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index d0bcca9..901b53e 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -588,12 +588,25 @@ static int arizona_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static const char *arizona_dai_clk_str(int clk_id)
+{
+	switch (clk_id) {
+	case ARIZONA_CLK_SYSCLK:
+		return "SYSCLK";
+	case ARIZONA_CLK_ASYNCCLK:
+		return "ASYNCCLK";
+	default:
+		return "Unknown clock";
+	}
+}
+
 static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 				  int clk_id, unsigned int freq, int dir)
 {
 	struct snd_soc_codec *codec = dai->codec;
 	struct arizona_priv *priv = snd_soc_codec_get_drvdata(codec);
 	struct arizona_dai_priv *dai_priv = &priv->dai[dai->id - 1];
+	struct snd_soc_dapm_route routes[2];
 
 	switch (clk_id) {
 	case ARIZONA_CLK_SYSCLK:
@@ -603,15 +616,28 @@ static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	if (clk_id != dai_priv->clk && dai->active) {
+	if (clk_id == dai_priv->clk)
+		return 0;
+
+	if (dai->active) {
 		dev_err(codec->dev, "Can't change clock on active DAI %d\n",
 			dai->id);
 		return -EBUSY;
 	}
 
-	dai_priv->clk = clk_id;
+	memset(&routes, 0, sizeof(routes));
+	routes[0].sink = dai->driver->capture.stream_name;
+	routes[1].sink = dai->driver->playback.stream_name;
 
-	return 0;
+	routes[0].source = arizona_dai_clk_str(dai_priv->clk);
+	routes[1].source = arizona_dai_clk_str(dai_priv->clk);
+	snd_soc_dapm_del_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
+
+	routes[0].source = arizona_dai_clk_str(clk_id);
+	routes[1].source = arizona_dai_clk_str(clk_id);
+	snd_soc_dapm_add_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
+
+	return snd_soc_dapm_sync(&codec->dapm);
 }
 
 const struct snd_soc_dai_ops arizona_dai_ops = {
-- 
1.7.10
