From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Always keep SYSCLK link for DAIs
Date: Fri, 25 Jan 2013 19:21:29 +0800
Message-ID: <1359112889-28218-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5C4EE265139
 for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2013 18:56:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Don't disconnect SYSCLK when a DAI moves to the ASYNCCLK domain, we always
need SYSCLK for operation even if it's not the reference clock for the
domain.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 27b6efc..f76e982 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -978,13 +978,27 @@ static int arizona_dai_set_sysclk(struct snd_soc_dai *dai,
 	routes[0].sink = dai->driver->capture.stream_name;
 	routes[1].sink = dai->driver->playback.stream_name;
 
-	routes[0].source = arizona_dai_clk_str(dai_priv->clk);
-	routes[1].source = arizona_dai_clk_str(dai_priv->clk);
-	snd_soc_dapm_del_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
+	switch (clk_id) {
+	case ARIZONA_CLK_SYSCLK:
+		routes[0].source = arizona_dai_clk_str(dai_priv->clk);
+		routes[1].source = arizona_dai_clk_str(dai_priv->clk);
+		snd_soc_dapm_del_routes(&codec->dapm, routes,
+					ARRAY_SIZE(routes));
+		break;
+	default:
+		break;
+	}
 
-	routes[0].source = arizona_dai_clk_str(clk_id);
-	routes[1].source = arizona_dai_clk_str(clk_id);
-	snd_soc_dapm_add_routes(&codec->dapm, routes, ARRAY_SIZE(routes));
+	switch (clk_id) {
+	case ARIZONA_CLK_ASYNCCLK:
+		routes[0].source = arizona_dai_clk_str(clk_id);
+		routes[1].source = arizona_dai_clk_str(clk_id);
+		snd_soc_dapm_add_routes(&codec->dapm, routes,
+					ARRAY_SIZE(routes));
+		break;
+	default:
+		break;
+	}
 
 	dai_priv->clk = clk_id;
 
-- 
1.7.10.4
