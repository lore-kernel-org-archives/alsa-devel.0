From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 3/6] ASoC: max9867: Drop probe function
Date: Thu, 1 Mar 2018 15:20:27 +0100
Message-ID: <20180301142027.GE30722@lenoch>
References: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id CC484267922
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:20:29 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993945AbeCAOU3hucuy (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:20:29 +0100
Content-Disposition: inline
In-Reply-To: <20180301141843.GB30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Driver probe function has no use and can be deleted.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 10 ----------
 sound/soc/codecs/max9867.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 99b8035d2fda..3620b38291f0 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -406,17 +406,7 @@ static int max9867_resume(struct device *dev)
 }
 #endif
 
-static int max9867_probe(struct snd_soc_component *component)
-{
-	struct max9867_priv *max9867 = snd_soc_component_get_drvdata(component);
-
-	dev_dbg(component->dev, "max98090_probe\n");
-	max9867->component = component;
-	return 0;
-}
-
 static const struct snd_soc_component_driver max9867_component = {
-	.probe			= max9867_probe,
 	.controls		= max9867_snd_controls,
 	.num_controls		= ARRAY_SIZE(max9867_snd_controls),
 	.dapm_routes		= max9867_audio_map,
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index c0aea3d1f2ba..55cd9976ff47 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -75,7 +75,6 @@
 /* codec private data */
 struct max9867_priv {
 	struct regmap *regmap;
-	struct snd_soc_component *component;
 	unsigned int sysclk;
 	unsigned int pclk;
 	unsigned int master;
-- 
2.16.2
