From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 4/6] ASoC: TWL4030: Add 4 channel TDM support
Date: Mon,  6 Apr 2009 15:19:30 +0300
Message-ID: <1239020372-8457-5-git-send-email-peter.ujfalusi@nokia.com>
References: <1239020372-8457-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-3-git-send-email-peter.ujfalusi@nokia.com>
	<1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BB7A24359
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 14:19:44 +0200 (CEST)
In-Reply-To: <1239020372-8457-4-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com, jarkko.nikula@nokia.com
List-Id: alsa-devel@alsa-project.org

Support for 4 channel TDM (SND_SOC_DAIFMT_DSP_A) for twl4030
codec.
The channel allocations are:
Playback:
TDM         i2s   TWL RX
Channel 1   Left  SDRL2
Channel 3   Right SDRR2
Channel 2   --    SDRL1
Channel 4   --    SDRR1

Capture:
TDM         i2s   TWL TX
Channel 1   Left  TXL1
Channel 3   Right TXR1
Channel 2   --    TXL2
Channel 4   --    TXR2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 8b44a88..927b876 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -1416,6 +1416,9 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	case SND_SOC_DAIFMT_I2S:
 		format |= TWL4030_AIF_FORMAT_CODEC;
 		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		format |= TWL4030_AIF_FORMAT_TDM;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1451,13 +1454,13 @@ struct snd_soc_dai twl4030_dai = {
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 4,
 		.rates = TWL4030_RATES | SNDRV_PCM_RATE_96000,
 		.formats = TWL4030_FORMATS,},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
-		.channels_max = 2,
+		.channels_max = 4,
 		.rates = TWL4030_RATES,
 		.formats = TWL4030_FORMATS,},
 	.ops = &twl4030_dai_ops,
-- 
1.6.2.2
