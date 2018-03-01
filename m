From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Improve error logging" to the
	asoc tree
Date: Thu, 01 Mar 2018 18:06:40 +0000
Message-ID: <E1erSbI-0005n3-Kk@debutante>
References: <20180301141953.GD30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9983C26798F
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:06:41 +0100 (CET)
In-Reply-To: <20180301141953.GD30722@lenoch>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max9867: Improve error logging

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

>From 8b9c716aada77e72e2fe82320aba5a95b75ca400 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 1 Mar 2018 15:19:53 +0100
Subject: [PATCH] ASoC: max9867: Improve error logging

Tell user what are clock rate limits and reindent log messages.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 2f60924fe919..ac30213deac4 100644
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
@@ -486,8 +488,7 @@ static int max9867_i2c_probe(struct i2c_client *i2c,
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
