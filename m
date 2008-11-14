From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Fix supported sample rates of
	TWL4030 audio codec
Date: Fri, 14 Nov 2008 14:58:43 +0000
Message-ID: <1226674726-11678-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081114145705.GA11635@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B3261037F3
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 15:58:47 +0100 (CET)
In-Reply-To: <20081114145705.GA11635@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Jarkko Nikula <jarkko.nikula@nokia.com>

TWL4030 currently supports rates between 8 kHz and 48 kHz and sets the codec
mode register accordingly in twl4030_hw_params. Expose this info so that
ASoC can match other rates than 44.1 kHz or 48 kHz as well.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Acked-by: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 90f3b4d..c1893d2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -504,7 +504,7 @@ static int twl4030_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-#define TWL4030_RATES	 (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+#define TWL4030_RATES	 (SNDRV_PCM_RATE_8000_48000)
 #define TWL4030_FORMATS	 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FORMAT_S24_LE)
 
 struct snd_soc_dai twl4030_dai = {
-- 
1.5.6.5
