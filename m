From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Fix whitespace" to the asoc
	tree
Date: Mon, 26 Nov 2018 17:20:36 +0000 (GMT)
Message-ID: <20181126172036.87D5C112519F@debutante.sirena.org.uk>
References: <20181123142700.GB7347@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C70CE26770D
 for <alsa-devel@alsa-project.org>; Mon, 26 Nov 2018 18:20:38 +0100 (CET)
In-Reply-To: <20181123142700.GB7347@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Fix whitespace

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 933662f28981cf8520a814e47acaea53061ec894 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Fri, 23 Nov 2018 15:27:00 +0100
Subject: [PATCH] ASoC: max9867: Fix whitespace

Minor changes to match coding style.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.19.0.rc2
