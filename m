From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Fix 24bit support
Date: Tue, 14 Dec 2010 13:45:29 +0200
Message-ID: <1292327129-19417-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da01.nokia.com (smtp.nokia.com [147.243.128.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 64AD410381C
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 12:45:29 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

twl4030 series of codecs supports S32_LE with msbits=24.
Replace the S24_LE with S32_LE format, and add constraint
for 24msbit in case of 32 S32_LE format.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index c173cf0..e4d464b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1724,6 +1724,7 @@ static int twl4030_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_codec *codec = rtd->codec;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 
+	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
 	if (twl4030->master_substream) {
 		twl4030->slave_substream = substream;
 		/* The DAI has one configuration for playback and capture, so
@@ -1848,7 +1849,7 @@ static int twl4030_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S16_LE:
 		format |= TWL4030_DATA_WIDTH_16S_16W;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
+	case SNDRV_PCM_FORMAT_S32_LE:
 		format |= TWL4030_DATA_WIDTH_32S_24W;
 		break;
 	default:
@@ -2181,7 +2182,7 @@ static int twl4030_voice_set_tristate(struct snd_soc_dai *dai, int tristate)
 }
 
 #define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
-#define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
+#define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops twl4030_dai_hifi_ops = {
 	.startup	= twl4030_startup,
-- 
1.7.3.3
