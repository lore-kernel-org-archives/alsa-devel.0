From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [topic/asoc][PATCH] ASoC: Fix supported sample rates
	of TWL4030 audio codec
Date: Wed, 12 Nov 2008 17:05:41 +0200
Message-ID: <1226502341-21815-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id C59BC24482
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:06:29 +0100 (CET)
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
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

TWL4030 currently supports rates between 8 kHz and 48 kHz and sets the codec
mode register accordingly in twl4030_hw_params. Expose this info so that
ASoC can match other rates than 44.1 kHz or 48 kHz as well.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: Steve Sakoman <steve@sakoman.com>
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
