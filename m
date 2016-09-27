From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ASoC: tlv320aic31xx: do not declare support for mono DAI
Date: Tue, 27 Sep 2016 11:30:15 +0300
Message-ID: <1474965015-29243-1-git-send-email-nikita.yoush@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bastien Nocera <hadess@hadess.net>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Nikita Yushchenko <nikita.yoush@cogentembedded.com>
List-Id: alsa-devel@alsa-project.org

This hardware supports only 2-channel DAI, even mono ADC digital output
has two channels with the same data.

Having min_channels=1 results in broken playback of mono files in setups
where CPU DAI supports mono.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 725173b12725..be1a64bfd320 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -1213,7 +1213,7 @@ static struct snd_soc_dai_driver dac31xx_dai_driver[] = {
 		.name = "tlv32dac31xx-hifi",
 		.playback = {
 			.stream_name	 = "Playback",
-			.channels_min	 = 1,
+			.channels_min	 = 2,
 			.channels_max	 = 2,
 			.rates		 = AIC31XX_RATES,
 			.formats	 = AIC31XX_FORMATS,
@@ -1228,14 +1228,14 @@ static struct snd_soc_dai_driver aic31xx_dai_driver[] = {
 		.name = "tlv320aic31xx-hifi",
 		.playback = {
 			.stream_name	 = "Playback",
-			.channels_min	 = 1,
+			.channels_min	 = 2,
 			.channels_max	 = 2,
 			.rates		 = AIC31XX_RATES,
 			.formats	 = AIC31XX_FORMATS,
 		},
 		.capture = {
 			.stream_name	 = "Capture",
-			.channels_min	 = 1,
+			.channels_min	 = 2,
 			.channels_max	 = 2,
 			.rates		 = AIC31XX_RATES,
 			.formats	 = AIC31XX_FORMATS,
-- 
2.1.4
