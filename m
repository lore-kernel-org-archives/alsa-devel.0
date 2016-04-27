From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel_ssc_dai: read DSP mode A data on rising edges of bclk
Date: Wed, 27 Apr 2016 09:06:49 +0200
Message-ID: <1461740809-10101-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 6dca95aa8a82..4ab1e2013238 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -652,7 +652,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		rcmr =	  SSC_BF(RCMR_PERIOD, ssc_p->rcmr_period)
 			| SSC_BF(RCMR_STTDLY, 1)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
 			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
 			| SSC_BF(RCMR_CKS, SSC_CKS_DIV);
 
@@ -692,7 +692,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_RISING_RF)
-			| SSC_BF(RCMR_CKI, SSC_CKI_FALLING)
+			| SSC_BF(RCMR_CKI, SSC_CKI_RISING)
 			| SSC_BF(RCMR_CKO, SSC_CKO_NONE)
 			| SSC_BF(RCMR_CKS, ssc->clk_from_rk_pin ?
 					   SSC_CKS_PIN : SSC_CKS_CLOCK);
-- 
2.1.4
