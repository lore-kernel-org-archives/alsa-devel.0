From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/4] Revert "ASoC: twl4030: Use core to set the
	msbits constraint"
Date: Thu, 19 Jan 2012 19:24:14 +0100
Message-ID: <1326997456-16296-3-git-send-email-peter.ujfalusi@ti.com>
References: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 5830E103C64
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 19:24:43 +0100 (CET)
Received: by mail-yx0-f173.google.com with SMTP id l8so167632yen.32
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 10:24:39 -0800 (PST)
In-Reply-To: <1326997456-16296-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The core implementation applies the msbits constraint to samples
where it should not.
Do not ask core to do this, the original code does the right thing.

This reverts commit f3da57f0fc092d338fe83cf89e3fe25ca2283bbf.
---
 sound/soc/codecs/twl4030.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index a193f5f..18e7101 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1689,6 +1689,7 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
+	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
 	if (twl4030->master_substream) {
 		twl4030->slave_substream = substream;
 		/* The DAI has one configuration for playback and capture, so
@@ -2174,15 +2175,13 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES | SNDRV_PCM_RATE_96000,
-		.formats = TWL4030_FORMATS,
-		.sig_bits = 24,},
+		.formats = TWL4030_FORMATS,},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
-		.formats = TWL4030_FORMATS,
-		.sig_bits = 24,},
+		.formats = TWL4030_FORMATS,},
 	.ops = &twl4030_dai_hifi_ops,
 },
 {
-- 
1.7.8.3
