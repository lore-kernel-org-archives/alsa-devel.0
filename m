From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8962: Support mono playback and record
Date: Wed,  8 Feb 2012 19:02:49 +0000
Message-ID: <1328727769-3277-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 30901103E7D
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 20:02:51 +0100 (CET)
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

Make sure we generate enough BCLKs for I2S style modes by always having
a minimum of two channels worth of clocks for the BCLK.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 0f6bd06..85f71a7 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2536,6 +2536,9 @@ static int wm8962_hw_params(struct snd_pcm_substream *substream,
 	int adctl3 = 0;
 
 	wm8962->bclk = snd_soc_params_to_bclk(params);
+	if (params_channels(params) == 1)
+		wm8962->bclk *= 2;
+
 	wm8962->lrclk = params_rate(params);
 
 	for (i = 0; i < ARRAY_SIZE(sr_vals); i++) {
@@ -2913,14 +2916,14 @@ static struct snd_soc_dai_driver wm8962_dai = {
 	.name = "wm8962",
 	.playback = {
 		.stream_name = "Playback",
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8962_RATES,
 		.formats = WM8962_FORMATS,
 	},
 	.capture = {
 		.stream_name = "Capture",
-		.channels_min = 2,
+		.channels_min = 1,
 		.channels_max = 2,
 		.rates = WM8962_RATES,
 		.formats = WM8962_FORMATS,
-- 
1.7.9.rc1
