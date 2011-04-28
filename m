From: Michael Williamson <michael.williamson@criticallink.com>
Subject: [PATCH] audio: tlv320aic26: fix PLL register configuration
Date: Thu, 28 Apr 2011 17:32:57 -0400
Message-ID: <1304026377-21829-1-git-send-email-michael.williamson@criticallink.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, tiwai@suse.de, Michael Williamson <michael.williamson@criticallink.com>
List-Id: alsa-devel@alsa-project.org

The current PLL configuration code for the tlc320aic26 codec appears to assume a
hardcoded system clock of 12 MHz.  Use the clock value provided by the DAI_OPS
API for the calculation.

Tested using a MityDSP-L138 platform providing a 24.576 MHz clock.

Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
---
Against 2f666bcf757cb72549f360ef6da02f03620a48b6 of Linus' tree.

I'm not sure if I have this on all the right lists / CC's.  get_maintainer.pl
generated a *pile* of addresses...

 sound/soc/codecs/tlv320aic26.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index e2a7608..51e060b 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -163,8 +163,10 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 
 	/* Configure PLL */
 	pval = 1;
-	jval = (fsref == 44100) ? 7 : 8;
-	dval = (fsref == 44100) ? 5264 : 1920;
+	jval = fsref / (aic26->mclk / 2048);
+	dval = fsref - jval * (aic26->mclk / 2048);
+	dval = 10000 * dval / (aic26->mclk / 2048);
+	dev_dbg(&aic26->spi->dev, "Setting PLLM to %d.%04d\n", jval, dval);
 	qval = 0;
 	reg = 0x8000 | qval << 11 | pval << 8 | jval << 2;
 	aic26_reg_write(codec, AIC26_REG_PLL_PROG1, reg);
-- 
1.7.0.4
