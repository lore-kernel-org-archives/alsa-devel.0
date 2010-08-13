From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: Implement BCLK rate selection for
	WM8580
Date: Fri, 13 Aug 2010 20:35:05 +0100
Message-ID: <1281728107-25386-5-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20100813193305.GB3778@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 09BE21038C8
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 21:35:13 +0200 (CEST)
In-Reply-To: <20100813193305.GB3778@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

Drive a minimal supported number of clocks required for the current
bit format in master mode. In slave mode this setting has no effect.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8580.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm8580.c b/sound/soc/codecs/wm8580.c
index 3d7ff55..6262124 100644
--- a/sound/soc/codecs/wm8580.c
+++ b/sound/soc/codecs/wm8580.c
@@ -486,14 +486,18 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 	/* bit size */
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
+		paifa |= 0x8;
 		break;
 	case SNDRV_PCM_FORMAT_S20_3LE:
+		paifa |= 0x10;
 		paifb |= WM8580_AIF_LENGTH_20;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
+		paifa |= 0x10;
 		paifb |= WM8580_AIF_LENGTH_24;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
+		paifa |= 0x10;
 		paifb |= WM8580_AIF_LENGTH_24;
 		break;
 	default:
@@ -515,7 +519,8 @@ static int wm8580_paif_hw_params(struct snd_pcm_substream *substream,
 		wm8580_sysclk_ratios[i], wm8580->sysclk[dai->driver->id]);
 
 	snd_soc_update_bits(codec, WM8580_PAIF1 + dai->driver->id,
-			    WM8580_AIF_RATE_MASK, paifa);
+			    WM8580_AIF_RATE_MASK | WM8580_AIF_BCLKSEL_MASK,
+			    paifa);
 	snd_soc_update_bits(codec, WM8580_PAIF3 + dai->driver->id,
 			    WM8580_AIF_LENGTH_MASK, paifb);
 	return 0;
-- 
1.7.1
