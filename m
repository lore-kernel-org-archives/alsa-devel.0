From: "Olaya, Margarita" <magi.olaya@ti.com>
Subject: [PATCH v2  05/16] ASoC: twl6040: Support all DAIs
Date: Fri, 10 Dec 2010 21:05:37 -0600
Message-ID: <1889FA7136B567478A67D4B0F85B0CCEA4E225D4@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 5FA4510395D
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 04:05:40 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch adds support for all the TWL6040 DAIs.
- twl6040-ul
- twl6040-dl1
- twl6040-dl2
- twl6040-vib

Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl6040.c |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 27d6d53..b713d13 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1067,23 +1067,51 @@ static struct snd_soc_dai_ops twl6040_dai_ops = {
 	.set_sysclk	= twl6040_set_dai_sysclk,
 };
 
-static struct snd_soc_dai_driver twl6040_dai = {
-	.name = "twl6040-hifi",
+static struct snd_soc_dai_driver twl6040_dai[] = {
+{
+	.name = "twl6040-ul",
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = TWL6040_RATES,
+		.formats = TWL6040_FORMATS,
+	},
+	.ops = &twl6040_dai_ops,
+},
+{
+	.name = "twl6040-dl1",
 	.playback = {
-		.stream_name = "Playback",
+		.stream_name = "Headset Playback",
 		.channels_min = 1,
-		.channels_max = 4,
+		.channels_max = 2,
 		.rates = TWL6040_RATES,
 		.formats = TWL6040_FORMATS,
 	},
-	.capture = {
-		.stream_name = "Capture",
+	.ops = &twl6040_dai_ops,
+},
+{
+	.name = "twl6040-dl2",
+	.playback = {
+		.stream_name = "Handsfree Playback",
 		.channels_min = 1,
 		.channels_max = 2,
 		.rates = TWL6040_RATES,
 		.formats = TWL6040_FORMATS,
 	},
 	.ops = &twl6040_dai_ops,
+},
+{
+	.name = "twl6040-vib",
+	.playback = {
+		.stream_name = "Vibra Playback",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = TWL6040_FORMATS,
+	},
+	.ops = &twl6040_dai_ops,
+},
 };
 
 #ifdef CONFIG_PM
@@ -1235,7 +1263,8 @@ static struct snd_soc_codec_driver soc_codec_dev_twl6040 = {
 static int __devinit twl6040_codec_probe(struct platform_device *pdev)
 {
 	return snd_soc_register_codec(&pdev->dev,
-			&soc_codec_dev_twl6040, &twl6040_dai, 1);
+			&soc_codec_dev_twl6040, twl6040_dai,
+						ARRAY_SIZE(twl6040_dai));
 }
 
 static int __devexit twl6040_codec_remove(struct platform_device *pdev)
-- 
1.7.0.4
