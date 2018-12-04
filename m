From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98373: Added max98373_reset for
	stable amp reset" to the asoc tree
Date: Tue,  4 Dec 2018 17:26:59 +0000 (GMT)
Message-ID: <20181204172659.3BB5911251E3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D16CC267B4E
 for <alsa-devel@alsa-project.org>; Tue,  4 Dec 2018 18:27:00 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <RyanS.Lee@maximintegrated.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Ryan Lee <ryans.lee@maximintegrated.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98373: Added max98373_reset for stable amp reset

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

>From 20f2ab247d3b787af91c1aa5eb27c5061744c154 Mon Sep 17 00:00:00 2001
From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Date: Fri, 30 Nov 2018 03:21:09 +0000
Subject: [PATCH] ASoC: max98373: Added max98373_reset for stable amp reset

This patch added max98373_reset function to avoid amp software reset failure and code duplication.
Reset verification step has been added for stable amp reset and it repeats verification maximum 3 times when it is failed.
Chip revision ID is available when the amp is in the idle state which means software reset is completed well.
Additional 10ms delay was added for every retrial and maximum 30ms delay can be applied.

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98373.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index a09d01318f79..9c8616a7b61c 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -724,14 +724,39 @@ static struct snd_soc_dai_driver max98373_dai[] = {
 	}
 };
 
+static void max98373_reset(struct max98373_priv *max98373, struct device *dev)
+{
+	int ret, reg, count;
+
+	/* Software Reset */
+	ret = regmap_update_bits(max98373->regmap,
+		MAX98373_R2000_SW_RESET,
+		MAX98373_SOFT_RESET,
+		MAX98373_SOFT_RESET);
+	if (ret)
+		dev_err(dev, "Reset command failed. (ret:%d)\n", ret);
+
+	count = 0;
+	while (count < 3) {
+		usleep_range(10000, 11000);
+		/* Software Reset Verification */
+		ret = regmap_read(max98373->regmap,
+			MAX98373_R21FF_REV_ID, &reg);
+		if (!ret) {
+			dev_info(dev, "Reset completed (retry:%d)\n", count);
+			return;
+		}
+		count++;
+	}
+	dev_err(dev, "Reset failed. (ret:%d)\n", ret);
+}
+
 static int max98373_probe(struct snd_soc_component *component)
 {
 	struct max98373_priv *max98373 = snd_soc_component_get_drvdata(component);
 
 	/* Software Reset */
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, component->dev);
 
 	/* IV default slot configuration */
 	regmap_write(max98373->regmap,
@@ -818,9 +843,7 @@ static int max98373_resume(struct device *dev)
 {
 	struct max98373_priv *max98373 = dev_get_drvdata(dev);
 
-	regmap_write(max98373->regmap,
-		MAX98373_R2000_SW_RESET, MAX98373_SOFT_RESET);
-	usleep_range(10000, 11000);
+	max98373_reset(max98373, dev);
 	regcache_cache_only(max98373->regmap, false);
 	regcache_sync(max98373->regmap);
 	return 0;
-- 
2.19.0.rc2
