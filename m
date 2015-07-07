From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: Move the code checking *regmap
	argument earlier" to the asoc tree
Date: Tue, 07 Jul 2015 14:57:54 +0100
Message-ID: <E1ZCTNi-0005XY-7f@finisterre>
References: <1435239703.22170.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA7326572A
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2015 15:58:08 +0200 (CEST)
In-Reply-To: <1435239703.22170.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: Move the code checking *regmap argument earlier

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From d375d0abcd625cd09cd90a252ad22a1085452e3c Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 25 Jun 2015 21:41:43 +0800
Subject: [PATCH] ASoC: cs42xx8: Move the code checking *regmap argument
 earlier

Slightly improve the readability by moving the code checking *regmap
argument earlier. Also move the assignment of of_id close to the place
testing it.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index e1d4686..ab39514 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -435,16 +435,24 @@ EXPORT_SYMBOL_GPL(cs42xx8_of_match);
 
 int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 {
-	const struct of_device_id *of_id = of_match_device(cs42xx8_of_match, dev);
+	const struct of_device_id *of_id;
 	struct cs42xx8_priv *cs42xx8;
 	int ret, val, i;
 
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		dev_err(dev, "failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
 	cs42xx8 = devm_kzalloc(dev, sizeof(*cs42xx8), GFP_KERNEL);
 	if (cs42xx8 == NULL)
 		return -ENOMEM;
 
+	cs42xx8->regmap = regmap;
 	dev_set_drvdata(dev, cs42xx8);
 
+	of_id = of_match_device(cs42xx8_of_match, dev);
 	if (of_id)
 		cs42xx8->drvdata = of_id->data;
 
@@ -482,13 +490,6 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	/* Make sure hardware reset done */
 	msleep(5);
 
-	cs42xx8->regmap = regmap;
-	if (IS_ERR(cs42xx8->regmap)) {
-		ret = PTR_ERR(cs42xx8->regmap);
-		dev_err(dev, "failed to allocate regmap: %d\n", ret);
-		goto err_enable;
-	}
-
 	/*
 	 * We haven't marked the chip revision as volatile due to
 	 * sharing a register with the right input volume; explicitly
-- 
2.1.4
