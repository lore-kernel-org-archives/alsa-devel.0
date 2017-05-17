From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel-classd: sync regcache when resuming" to the asoc tree
Date: Wed, 17 May 2017 10:51:12 +0100
Message-ID: <E1dAvbs-0006dB-Po@debutante>
References: <20170515083617.16742-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170515083617.16742-1-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>nicolas.ferre@microchip.com, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.orgalexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel-classd: sync regcache when resuming

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

>From 61abce1312bf97eac62eef704260ce9a8f9b85f6 Mon Sep 17 00:00:00 2001
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Date: Mon, 15 May 2017 10:36:17 +0200
Subject: [PATCH] ASoC: atmel-classd: sync regcache when resuming

The PM functions used in this driver are the ones defined in
sounc/soc/soc-core.c.

When suspending (using snd_soc_suspend), the regcache is marked dirty
but is never synced on resume.

Sync regcache on resume of Atmel ClassD device.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-classd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 7ae46c2647d4..b7ef8c59b49a 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -301,6 +301,14 @@ static int atmel_classd_codec_probe(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static int atmel_classd_codec_resume(struct snd_soc_codec *codec)
+{
+	struct snd_soc_card *card = snd_soc_codec_get_drvdata(codec);
+	struct atmel_classd *dd = snd_soc_card_get_drvdata(card);
+
+	return regcache_sync(dd->regmap);
+}
+
 static struct regmap *atmel_classd_codec_get_remap(struct device *dev)
 {
 	return dev_get_regmap(dev, NULL);
@@ -308,6 +316,7 @@ static struct regmap *atmel_classd_codec_get_remap(struct device *dev)
 
 static struct snd_soc_codec_driver soc_codec_dev_classd = {
 	.probe		= atmel_classd_codec_probe,
+	.resume		= atmel_classd_codec_resume,
 	.get_regmap	= atmel_classd_codec_get_remap,
 	.component_driver = {
 		.controls		= atmel_classd_snd_controls,
-- 
2.11.0
