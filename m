From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: use snd_soc_component_init_regmap() on
	atmel-classd" to the asoc tree
Date: Mon, 04 Dec 2017 18:49:22 +0000
Message-ID: <E1eLvnu-0000TP-Vx@debutante>
References: <87efrrkl7q.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A21CD2675E7
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 19:49:27 +0100 (CET)
In-Reply-To: <87efrrkl7q.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: use snd_soc_component_init_regmap() on atmel-classd

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

>From 4b952275d2e7c6b32671a121ea5303a467bf2a0f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Nov 2017 06:06:44 +0000
Subject: [PATCH] ASoC: use snd_soc_component_init_regmap() on atmel-classd

To setup regmap, ALSA SoC has snd_soc_component_init_regmap() and
.get_regmap. But these are duplicated feature.
This driver is using .get_regmap and set regmap by using
dev_get_regmap(), but it is automatically done by
snd_soc_component_add_unlocked(). let's remove .get_regmap.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-classd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 8445edd06737..ebabed69f0e6 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -308,15 +308,9 @@ static int atmel_classd_codec_resume(struct snd_soc_codec *codec)
 	return regcache_sync(dd->regmap);
 }
 
-static struct regmap *atmel_classd_codec_get_remap(struct device *dev)
-{
-	return dev_get_regmap(dev, NULL);
-}
-
 static struct snd_soc_codec_driver soc_codec_dev_classd = {
 	.probe		= atmel_classd_codec_probe,
 	.resume		= atmel_classd_codec_resume,
-	.get_regmap	= atmel_classd_codec_get_remap,
 	.component_driver = {
 		.controls		= atmel_classd_snd_controls,
 		.num_controls		= ARRAY_SIZE(atmel_classd_snd_controls),
-- 
2.15.0
