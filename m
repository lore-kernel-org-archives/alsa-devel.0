From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm1250-ev1: Flag all supported rates in
	the DAI
Date: Thu,  5 Jul 2012 14:31:29 +0100
Message-ID: <1341495089-28983-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2741424609
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 15:31:32 +0200 (CEST)
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

Not previously noticed due to normal usage being with CODEC<->CODEC links.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm1250-ev1.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm1250-ev1.c b/sound/soc/codecs/wm1250-ev1.c
index e0b51e9..951d7b4 100644
--- a/sound/soc/codecs/wm1250-ev1.c
+++ b/sound/soc/codecs/wm1250-ev1.c
@@ -121,20 +121,23 @@ static const struct snd_soc_dai_ops wm1250_ev1_ops = {
 	.hw_params = wm1250_ev1_hw_params,
 };
 
+#define WM1250_EV1_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |\
+			  SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_64000)
+
 static struct snd_soc_dai_driver wm1250_ev1_dai = {
 	.name = "wm1250-ev1",
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = WM1250_EV1_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.capture = {
 		.stream_name = "Capture",
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000,
+		.rates = WM1250_EV1_RATES,
 		.formats = SNDRV_PCM_FMTBIT_S16_LE,
 	},
 	.ops = &wm1250_ev1_ops,
-- 
1.7.10
