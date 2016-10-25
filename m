From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42xx8: Mark chip ID as volatile and
	remove cache bypass" to the asoc tree
Date: Tue, 25 Oct 2016 20:23:37 +0100
Message-ID: <E1bz7Jx-0004ly-1G@debutante>
References: <1477410151-17515-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4CAF2606F8
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 21:23:43 +0200 (CEST)
In-Reply-To: <1477410151-17515-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: brian.austin@cirrus.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42xx8: Mark chip ID as volatile and remove cache bypass

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

>From 03d2ec460f126d8f4409d137b5865bc4eca253c0 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 25 Oct 2016 16:42:29 +0100
Subject: [PATCH] ASoC: cs42xx8: Mark chip ID as volatile and remove cache
 bypass

Rather than manually enabling cache bypass when reading the ID registers
simply remove the default which will cause the first read to go to the
hardware. The old code worked this is simply the more standard way to
implement this. There is a comment included in the code that claims the
chip ID register also contains the right input volume, however this is
clearly not the case from the rest of the driver. Further investigation
reveals exactly the same comment in the wm8962 driver, where this is the
case, so this is almost certainly a copy and paste error from when the
driver was created.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42xx8.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index b4d87379d2bc..c1785bd4ff19 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -321,7 +321,6 @@ static struct snd_soc_dai_driver cs42xx8_dai = {
 };
 
 static const struct reg_default cs42xx8_reg[] = {
-	{ 0x01, 0x01 },   /* Chip I.D. and Revision Register */
 	{ 0x02, 0x00 },   /* Power Control */
 	{ 0x03, 0xF0 },   /* Functional Mode */
 	{ 0x04, 0x46 },   /* Interface Formats */
@@ -498,13 +497,6 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	/* Make sure hardware reset done */
 	msleep(5);
 
-	/*
-	 * We haven't marked the chip revision as volatile due to
-	 * sharing a register with the right input volume; explicitly
-	 * bypass the cache to read it.
-	 */
-	regcache_cache_bypass(cs42xx8->regmap, true);
-
 	/* Validate the chip ID */
 	ret = regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
 	if (ret < 0) {
@@ -523,8 +515,6 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
 	dev_info(dev, "found device, revision %X\n",
 			val & CS42XX8_CHIPID_REV_ID_MASK);
 
-	regcache_cache_bypass(cs42xx8->regmap, false);
-
 	cs42xx8_dai.name = cs42xx8->drvdata->name;
 
 	/* Each adc supports stereo input */
-- 
2.8.1
