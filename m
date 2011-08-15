From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Disable pulls on WM8994 AIF2 when
	starting it
Date: Mon, 15 Aug 2011 11:02:03 +0900
Message-ID: <1313373723-974-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67BF1243C7
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 04:02:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Pull control is availalbe for WM8994 AIF2, generally disabled as part of
the GPIO configuration in order to save power after system startup. As on
newer devices in the series there is no GPIO functionality on these pins
this will happen less naturally so have the driver disable the pulls as the
AIF is probed.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index b63c4c8..f328369 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2498,6 +2498,21 @@ static int wm8994_set_tristate(struct snd_soc_dai *codec_dai, int tristate)
 	return snd_soc_update_bits(codec, reg, mask, val);
 }
 
+static int wm8994_aif2_probe(struct snd_soc_dai *dai)
+{
+	struct snd_soc_codec *codec = dai->codec;
+
+	/* Disable the pulls on the AIF if we're using it to save power. */
+	snd_soc_update_bits(codec, WM8994_GPIO_3,
+			    WM8994_GPN_PU | WM8994_GPN_PD, 0);
+	snd_soc_update_bits(codec, WM8994_GPIO_4,
+			    WM8994_GPN_PU | WM8994_GPN_PD, 0);
+	snd_soc_update_bits(codec, WM8994_GPIO_5,
+			    WM8994_GPN_PU | WM8994_GPN_PD, 0);
+
+	return 0;
+}
+
 #define WM8994_RATES SNDRV_PCM_RATE_8000_96000
 
 #define WM8994_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
@@ -2565,6 +2580,7 @@ static struct snd_soc_dai_driver wm8994_dai[] = {
 			.rates = WM8994_RATES,
 			.formats = WM8994_FORMATS,
 		},
+		.probe = wm8994_aif2_probe,
 		.ops = &wm8994_aif2_dai_ops,
 	},
 	{
-- 
1.7.5.4
