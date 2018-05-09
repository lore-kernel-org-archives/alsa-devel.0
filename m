From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove .get_regmap" to the asoc tree
Date: Wed,  9 May 2018 10:44:51 +0100 (BST)
Message-ID: <20180509094451.CE80544007A@finisterre.ee.mobilebroadband>
References: <87in91f7qy.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A2775267738
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:28:56 +0200 (CEST)
In-Reply-To: <87in91f7qy.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove .get_regmap

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

>From 2250e76d78e82b1da0f6f571f7211dfa78cbd469 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:19:16 +0000
Subject: [PATCH] ASoC: remove .get_regmap

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
Now, no one is using .get_regmap, let's remove it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 2 --
 sound/soc/soc-core.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 7233d3a206b2..309bb70bcb1e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -947,8 +947,6 @@ struct snd_soc_codec_driver {
 	int (*set_jack)(struct snd_soc_codec *codec,
 			struct snd_soc_jack *jack,  void *data);
 
-	/* codec IO */
-	struct regmap *(*get_regmap)(struct device *);
 	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
 	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 96081160fd24..e5af15aa1c28 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3392,9 +3392,6 @@ int snd_soc_register_codec(struct device *dev,
 	codec->component.debugfs_prefix = "codec";
 #endif
 
-	if (codec_drv->get_regmap)
-		codec->component.regmap = codec_drv->get_regmap(dev);
-
 	for (i = 0; i < num_dai; i++) {
 		convert_endianness_formats(&dai_drv[i].playback);
 		convert_endianness_formats(&dai_drv[i].capture);
-- 
2.17.0
