From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 1/5] ASoC: es7134: remove 64kHz rate from the
	supported rates
Date: Fri, 29 Jun 2018 17:09:20 +0200
Message-ID: <20180629150924.18197-2-jbrunet@baylibre.com>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 40F95267601
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 17:09:32 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so9188262wro.1
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 08:09:32 -0700 (PDT)
In-Reply-To: <20180629150924.18197-1-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

64Khz is actually not supported by the es7134 according to the datasheet

Fixes: 9000b59d7a12 ("ASoC: es7134: add es7134 DAC driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/codecs/es7134.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es7134.c b/sound/soc/codecs/es7134.c
index 58515bb1a303..2fbb49f5b278 100644
--- a/sound/soc/codecs/es7134.c
+++ b/sound/soc/codecs/es7134.c
@@ -48,7 +48,11 @@ static struct snd_soc_dai_driver es7134_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_192000,
+		.rates = (SNDRV_PCM_RATE_8000_48000 |
+			  SNDRV_PCM_RATE_88200      |
+			  SNDRV_PCM_RATE_96000      |
+			  SNDRV_PCM_RATE_176400     |
+			  SNDRV_PCM_RATE_192000),
 		.formats = (SNDRV_PCM_FMTBIT_S16_LE  |
 			    SNDRV_PCM_FMTBIT_S18_3LE |
 			    SNDRV_PCM_FMTBIT_S20_3LE |
-- 
2.14.4
