From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max9867: Drop probe function" to the
	asoc tree
Date: Fri, 02 Mar 2018 13:17:52 +0000
Message-ID: <E1erkZM-0006EF-Fr@debutante>
References: <20180301142027.GE30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 12919267377
 for <alsa-devel@alsa-project.org>; Fri,  2 Mar 2018 14:17:54 +0100 (CET)
In-Reply-To: <20180301142027.GE30722@lenoch>
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

   ASoC: max9867: Drop probe function

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

>From b3e9c3f0d98135d8b9991c2a34e42627c20664a4 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Fri, 2 Mar 2018 14:11:00 +0100
Subject: [PATCH] ASoC: max9867: Drop probe function

Driver probe function has no use and can be deleted.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max9867.c | 10 ----------
 sound/soc/codecs/max9867.h |  1 -
 2 files changed, 11 deletions(-)

diff --git a/sound/soc/codecs/max9867.c b/sound/soc/codecs/max9867.c
index 349d9cc116ee..4ea3287162ad 100644
--- a/sound/soc/codecs/max9867.c
+++ b/sound/soc/codecs/max9867.c
@@ -413,17 +413,7 @@ static int max9867_resume(struct device *dev)
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
