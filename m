From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH v2] ASoC: max9867: Drop probe function
Date: Thu, 1 Mar 2018 22:57:01 +0100
Message-ID: <20180301215701.GB4302@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 10A7B267C57
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:57:05 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992615AbeCAV5EpzHqk (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 22:57:04 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Driver probe function has no use and can be deleted.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Changes:
 - v2: Rebased against Mark's current tree
 
 Mark,

 is this what you asked for? It does not make much sense to me
 as you have to redo the work I wanted to save you...

 sound/soc/codecs/max9867.c | 10 ----------
 sound/soc/codecs/max9867.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2f60924fe919..6b128dd6c5dd 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -404,17 +404,7 @@ static int max9867_resume(struct device *dev)
 }
 #endif
 
-static int max9867_probe(struct snd_soc_codec *codec)
-{
-	struct max9867_priv *max9867 = snd_soc_codec_get_drvdata(codec);
-
-	dev_dbg(codec->dev, "max98090_probe\n");
-	max9867->codec = codec;
-	return 0;
-}
-
 static const struct snd_soc_codec_driver max9867_codec = {
-	.probe = max9867_probe,
 	.component_driver = {
 		.controls		= max9867_snd_controls,
 		.num_controls		= ARRAY_SIZE(max9867_snd_controls),
diff --git a/sound/soc/codecs/max9867.h b/sound/soc/codecs/max9867.h
index 65590b4ad62a..55cd9976ff47 100644
--- a/sound/soc/codecs/max9867.h
+++ b/sound/soc/codecs/max9867.h
@@ -75,7 +75,6 @@
 /* codec private data */
 struct max9867_priv {
 	struct regmap *regmap;
-	struct snd_soc_codec *codec;
 	unsigned int sysclk;
 	unsigned int pclk;
 	unsigned int master;
-- 
2.16.2
