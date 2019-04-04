From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH] ASoC: max98357a: add missing supported rates
Date: Thu,  4 Apr 2019 13:50:15 +0200
Message-ID: <20190404115015.32208-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

According the publicly available datasheet (and some test) the max98357a
also supports 32, 44.1 and 88.2 kHz sample rate.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Datasheet is available here:
 https://datasheets.maximintegrated.com/en/ds/MAX98357A-MAX98357B.pdf

 sound/soc/codecs/max98357a.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index d469576b5a7b..d037a3e4d323 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -97,7 +97,10 @@ static struct snd_soc_dai_driver max98357a_dai_driver = {
 					SNDRV_PCM_FMTBIT_S32,
 		.rates		= SNDRV_PCM_RATE_8000 |
 					SNDRV_PCM_RATE_16000 |
+					SNDRV_PCM_RATE_32000 |
+					SNDRV_PCM_RATE_44100 |
 					SNDRV_PCM_RATE_48000 |
+					SNDRV_PCM_RATE_88200 |
 					SNDRV_PCM_RATE_96000,
 		.rate_min	= 8000,
 		.rate_max	= 96000,
-- 
2.20.1
