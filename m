From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH 1/6] ASoC: Extend range of supported sample
 rates for CS4271 CODEC.
Date: Mon, 07 Mar 2011 20:29:36 +0300
Message-ID: <1299518976.2255.65.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward5.mail.yandex.net (forward5.mail.yandex.net
	[77.88.46.21]) by alsa0.perex.cz (Postfix) with ESMTP id 52670244DE
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 18:29:43 +0100 (CET)
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Extend range of supported sample rates for CS4271 CODEC.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
Acked-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/codecs/cs4271.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index 1791796..e5cc4da 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -33,6 +33,7 @@
 #define CS4271_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
 			    SNDRV_PCM_FMTBIT_S24_LE | \
 			    SNDRV_PCM_FMTBIT_S32_LE)
+#define CS4271_PCM_RATES SNDRV_PCM_RATE_8000_192000
 
 /*
  * CS4271 registers
@@ -392,14 +393,14 @@ static struct snd_soc_dai_driver cs4271_dai = {
 		.stream_name	= "Playback",
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_96000,
+		.rates		= CS4271_PCM_RATES,
 		.formats	= CS4271_PCM_FORMATS,
 	},
 	.capture = {
 		.stream_name	= "Capture",
 		.channels_min	= 2,
 		.channels_max	= 2,
-		.rates		= SNDRV_PCM_RATE_8000_96000,
+		.rates		= CS4271_PCM_RATES,
 		.formats	= CS4271_PCM_FORMATS,
 	},
 	.ops = &cs4271_dai_ops,
