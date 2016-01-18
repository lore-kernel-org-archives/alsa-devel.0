From: Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH 3/3] ASoC: pcm179x: Support continuous rates
Date: Mon, 18 Jan 2016 16:57:37 +0100
Message-ID: <1453132657-18678-4-git-send-email-jacob@teenage.engineering>
References: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453132657-18678-1-git-send-email-jacob@teenage.engineering>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, Johan Hovold <johan@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Jacob Siverskog <jacob@teenage.engineering>
List-Id: alsa-devel@alsa-project.org

According to the PCM179x data sheets sampling frequencies between 10
kHz and 200 kHz are supported. Specify support in the driver.

Tested with PCM1791A.

References:
http://www.ti.com/lit/ds/symlink/pcm1791a.pdf
http://www.ti.com/lit/ds/symlink/pcm1792a.pdf
http://www.ti.com/lit/ds/symlink/pcm1795.pdf
http://www.ti.com/lit/ds/symlink/pcm1796.pdf

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Jacob Siverskog <jacob@teenage.engineering>
---
 sound/soc/codecs/pcm179x.c | 4 +++-
 sound/soc/codecs/pcm179x.h | 4 ----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/pcm179x.c b/sound/soc/codecs/pcm179x.c
index 08bc6e0..5a70384 100644
--- a/sound/soc/codecs/pcm179x.c
+++ b/sound/soc/codecs/pcm179x.c
@@ -181,7 +181,9 @@ static struct snd_soc_dai_driver pcm179x_dai = {
 		.stream_name = "Playback",
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = PCM1792A_RATES,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.rate_min = 10000,
+		.rate_max = 200000,
 		.formats = PCM1792A_FORMATS, },
 	.ops = &pcm179x_dai_ops,
 };
diff --git a/sound/soc/codecs/pcm179x.h b/sound/soc/codecs/pcm179x.h
index d1536e0..7829157 100644
--- a/sound/soc/codecs/pcm179x.h
+++ b/sound/soc/codecs/pcm179x.h
@@ -24,10 +24,6 @@ struct pcm179x_private {
 	unsigned int rate;
 };
 
-#define PCM1792A_RATES (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_8000_48000 | \
-			SNDRV_PCM_RATE_88200 | SNDRV_PCM_RATE_96000 | \
-			SNDRV_PCM_RATE_192000)
-
 #define PCM1792A_FORMATS (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE | \
 			  SNDRV_PCM_FMTBIT_S16_LE)
 
-- 
2.7.0
