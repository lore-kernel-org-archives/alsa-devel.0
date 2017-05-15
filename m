From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH] ASoC: atmel-classd: sync regcache when resuming
Date: Mon, 15 May 2017 10:36:17 +0200
Message-ID: <20170515083617.16742-1-quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, alexandre.belloni@free-electrons.com, thomas.petazzoni@free-electrons.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The PM functions used in this driver are the ones defined in
sounc/soc/soc-core.c.

When suspending (using snd_soc_suspend), the regcache is marked dirty
but is never synced on resume.

Sync regcache on resume of Atmel ClassD device.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
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
