From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/6] ASoC: max9867: Improve error logging
Date: Thu, 1 Mar 2018 15:19:53 +0100
Message-ID: <20180301141953.GD30722@lenoch>
References: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 56C24267932
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:19:56 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993890AbeCAOTzwsAFy (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:19:55 +0100
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

Tell user what are clock rate limits and reindent log messages.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index a4e8fafb7e6d..99b8035d2fda 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -291,7 +291,9 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 		value |= MAX9867_PSCLK_40_60;
 		max9867->pclk =  freq/4;
 	} else {
-		pr_err("bad clock frequency %d", freq);
+		dev_err(component->dev,
+			"Invalid clock frequency %uHz (required 10-60MHz)\n",
+			freq);
 		return -EINVAL;
 	}
 	value = value << MAX9867_PSCLK_SHIFT;
@@ -488,8 +490,7 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 	max9867->regmap = devm_regmap_init_i2c(i2c, &max9867_regmap);
 	if (IS_ERR(max9867->regmap)) {
 		ret = PTR_ERR(max9867->regmap);
-		dev_err(&i2c->dev,
-				"Failed to allocate regmap: %d\n", ret);
+		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
 		return ret;
 	}
 	ret = regmap_read(max9867->regmap,
-- 
2.16.2
