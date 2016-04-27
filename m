From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel_ssc_dai: read DSP mode A data on rising edges of bclk" to the asoc tree
Date: Wed, 27 Apr 2016 17:35:03 +0100
Message-ID: <E1avSQZ-0004Q5-Ck@debutante>
References: <1461740809-10101-1-git-send-email-peda@axentia.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461740809-10101-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel_ssc_dai: read DSP mode A data on rising edges of bclk

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 80833ff0eea693d8e0c3305a869159a64141fdad Mon Sep 17 00:00:00 2001
From: Peter Rosin <peda@axentia.se>
Date: Wed, 27 Apr 2016 09:06:49 +0200
Subject: [PATCH] ASoC: atmel_ssc_dai: read DSP mode A data on rising edges of
 bclk

Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 276897033639..1267e1af0fae 100644
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
2.8.0.rc3
