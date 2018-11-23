From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/5] ASoC: max9867: Fix whitespace
Date: Fri, 23 Nov 2018 15:27:00 +0100
Message-ID: <20181123142700.GB7347@lenoch>
References: <20181123142507.GA7347@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C382678DF
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2018 15:28:05 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23992934AbeKWO1EcZ7rb (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Fri, 23 Nov 2018 15:27:04 +0100
Content-Disposition: inline
In-Reply-To: <20181123142507.GA7347@lenoch>
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
Cc: Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Minor changes to match coding style.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/max9867.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 4ea3287162ad..1cda54b59854 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -283,13 +283,13 @@ static int max9867_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	/* Set the prescaler based on the master clock frequency*/
 	if (freq >= 10000000 && freq <= 20000000) {
 		value |= MAX9867_PSCLK_10_20;
-		max9867->pclk =  freq;
+		max9867->pclk = freq;
 	} else if (freq >= 20000000 && freq <= 40000000) {
 		value |= MAX9867_PSCLK_20_40;
-		max9867->pclk =  freq/2;
+		max9867->pclk = freq / 2;
 	} else if (freq >= 40000000 && freq <= 60000000) {
 		value |= MAX9867_PSCLK_40_60;
-		max9867->pclk =  freq/4;
+		max9867->pclk = freq / 4;
 	} else {
 		dev_err(component->dev,
 			"Invalid clock frequency %uHz (required 10-60MHz)\n",
@@ -478,8 +478,7 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 	struct max9867_priv *max9867;
 	int ret = 0, reg;
 
-	max9867 = devm_kzalloc(&i2c->dev,
-			sizeof(*max9867), GFP_KERNEL);
+	max9867 = devm_kzalloc(&i2c->dev, sizeof(*max9867), GFP_KERNEL);
 	if (!max9867)
 		return -ENOMEM;
 
@@ -490,8 +489,7 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Failed to allocate regmap: %d\n", ret);
 		return ret;
 	}
-	ret = regmap_read(max9867->regmap,
-			MAX9867_REVISION, &reg);
+	ret = regmap_read(max9867->regmap, MAX9867_REVISION, &reg);
 	if (ret < 0) {
 		dev_err(&i2c->dev, "Failed to read: %d\n", ret);
 		return ret;
-- 
2.19.1
