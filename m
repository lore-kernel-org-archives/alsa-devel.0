From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: WM8804 does not support sample rates
	below 32kHz
Date: Wed,  8 Jun 2011 18:20:09 +0100
Message-ID: <1307553609-7133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3C312453F
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 19:21:15 +0200 (CEST)
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

Reported-by: Kieran O'Leary <Kieran.O'Leary@wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8804.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8804.c b/sound/soc/codecs/wm8804.c
index 6785688..9a5e67c 100644
--- a/sound/soc/codecs/wm8804.c
+++ b/sound/soc/codecs/wm8804.c
@@ -680,20 +680,25 @@ static struct snd_soc_dai_ops wm8804_dai_ops = {
 #define WM8804_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE)
 
+#define WM8804_RATES (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+		      SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_64000 | \
+		      SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
+		      SNDRV_PCM_RATE_176400 | SNDRV_PCM_RATE_192000)
+
 static struct snd_soc_dai_driver wm8804_dai = {
 	.name = "wm8804-spdif",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = WM8804_RATES,
 		.formats = WM8804_FORMATS,
 	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = WM8804_RATES,
 		.formats = WM8804_FORMATS,
 	},
 	.ops = &wm8804_dai_ops,
-- 
1.7.5.3
