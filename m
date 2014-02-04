From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: cs42l73: Don't mix SNDRV_PCM_RATE_KNOT
	with specific rates
Date: Tue,  4 Feb 2014 20:55:31 +0100
Message-ID: <1391543731-9085-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-174.synserver.de
 [212.40.185.174])
 by alsa0.perex.cz (Postfix) with ESMTP id E4AC2261A8B
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 20:55:33 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SNDRV_PCM_RATE_KNOT means that the device can support rates that can not be
expressed using the rate bits. The driver will provide a list of those rates
specified through constraints. Any rate bits that are set in the rates mask will
be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT wont have any
effect, but might be confusing to the casual reader, so remove them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs42l73.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 549d5d6..7cae046 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1255,9 +1255,6 @@ static int cs42l73_pcm_startup(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/* SNDRV_PCM_RATE_KNOT -> 12000, 24000 Hz, limit with constraint list */
-#define CS42L73_RATES (SNDRV_PCM_RATE_8000_48000 | SNDRV_PCM_RATE_KNOT)
-
 
 #define CS42L73_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
 	SNDRV_PCM_FMTBIT_S24_LE)
@@ -1278,14 +1275,14 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
 			.stream_name = "XSP Playback",
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = CS42L73_RATES,
+			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS42L73_FORMATS,
 		},
 		.capture = {
 			.stream_name = "XSP Capture",
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = CS42L73_RATES,
+			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS42L73_FORMATS,
 		},
 		.ops = &cs42l73_ops,
@@ -1298,14 +1295,14 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
 			.stream_name = "ASP Playback",
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = CS42L73_RATES,
+			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS42L73_FORMATS,
 		},
 		.capture = {
 			.stream_name = "ASP Capture",
 			.channels_min = 2,
 			.channels_max = 2,
-			.rates = CS42L73_RATES,
+			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS42L73_FORMATS,
 		},
 		.ops = &cs42l73_ops,
@@ -1318,14 +1315,14 @@ static struct snd_soc_dai_driver cs42l73_dai[] = {
 			.stream_name = "VSP Playback",
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = CS42L73_RATES,
+			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS42L73_FORMATS,
 		},
 		.capture = {
 			.stream_name = "VSP Capture",
 			.channels_min = 1,
 			.channels_max = 2,
-			.rates = CS42L73_RATES,
+			.rates = SNDRV_PCM_RATE_KNOT,
 			.formats = CS42L73_FORMATS,
 		},
 		.ops = &cs42l73_ops,
-- 
1.8.0
