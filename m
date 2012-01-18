From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v4 5/5] ASoC: twl4030: Use core to set the
	msbits constraint
Date: Wed, 18 Jan 2012 12:18:26 +0100
Message-ID: <1326885506-6140-6-git-send-email-peter.ujfalusi@ti.com>
References: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 97EEA103B41
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 12:18:53 +0100 (CET)
Received: by ghrr16 with SMTP id r16so1519291ghr.17
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 03:18:52 -0800 (PST)
In-Reply-To: <1326885506-6140-1-git-send-email-peter.ujfalusi@ti.com>
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

Core can set the msbits constraint in behalf of the dai.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/codecs/twl4030.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 18e7101..a193f5f 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1689,7 +1689,6 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
-	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
 	if (twl4030->master_substream) {
 		twl4030->slave_substream = substream;
 		/* The DAI has one configuration for playback and capture, so
@@ -2175,13 +2174,15 @@ static struct snd_soc_dai_driver twl4030_dai[] = {
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES | SNDRV_PCM_RATE_96000,
-		.formats = TWL4030_FORMATS,},
+		.formats = TWL4030_FORMATS,
+		.sig_bits = 24,},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 4,
 		.rates = TWL4030_RATES,
-		.formats = TWL4030_FORMATS,},
+		.formats = TWL4030_FORMATS,
+		.sig_bits = 24,},
 	.ops = &twl4030_dai_hifi_ops,
 },
 {
-- 
1.7.8.3
