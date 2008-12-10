From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 8/8] ASoC: Stop WM8903 SYSCLK when suspending
Date: Wed, 10 Dec 2008 20:01:15 +0000
Message-ID: <1228939275-7768-8-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081210195858.GA4062@rakim.wolfsonmicro.main>
	<1228939275-7768-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228939275-7768-7-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89566243BC
	for <alsa-devel@alsa-project.org>; Wed, 10 Dec 2008 21:01:17 +0100 (CET)
In-Reply-To: <1228939275-7768-7-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This will save some additional power.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index c80968f..bde7454 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -997,6 +997,9 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_STANDBY:
 		if (codec->bias_level == SND_SOC_BIAS_OFF) {
+			wm8903_write(codec, WM8903_CLOCK_RATES_2,
+				     WM8903_CLK_SYS_ENA);
+
 			wm8903_run_sequence(codec, 0);
 			wm8903_sync_reg_cache(codec, codec->reg_cache);
 
@@ -1027,6 +1030,9 @@ static int wm8903_set_bias_level(struct snd_soc_codec *codec,
 
 	case SND_SOC_BIAS_OFF:
 		wm8903_run_sequence(codec, 32);
+		reg = wm8903_read(codec, WM8903_CLOCK_RATES_2);
+		reg &= ~WM8903_CLK_SYS_ENA;
+		wm8903_write(codec, WM8903_CLOCK_RATES_2, reg);
 		break;
 	}
 
@@ -1619,9 +1625,6 @@ static int wm8903_i2c_probe(struct i2c_client *i2c,
 
 	wm8903_reset(codec);
 
-	/* SYSCLK is required for pretty much anything */
-	wm8903_write(codec, WM8903_CLOCK_RATES_2, WM8903_CLK_SYS_ENA);
-
 	/* power on device */
 	wm8903_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.5.6.5
