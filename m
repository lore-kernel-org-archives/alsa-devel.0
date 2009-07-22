From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: tlv320aic3x: Enable PLL when not bypassed
Date: Wed, 22 Jul 2009 07:45:04 -0400
Message-ID: <1248263104-12142-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 79F6A1038CE
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 14:36:20 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

PLL was not being enabled when it was not bypassed. This patch
enables the PLL when it is used. Additionally, it disables the PLL
when it is bypassed.

Without this patch, the audio on TI DM646x EVM and DM355 EVM
does not work properly. The bit clocks and the frame sync signals
from the codec are not correct and hence the playback/record are faster
than usual for most sample rates. The reason for this was that the PLL
was not enabled when it was not bypassed.

Tested on DM6467 EVM, playback tested on DM355 EVM.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to master branch of ALSA GIT tree at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=summary

 sound/soc/codecs/tlv320aic3x.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index ab099f4..cb0d1bf 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -767,6 +767,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	int codec_clk = 0, bypass_pll = 0, fsref, last_clk = 0;
 	u8 data, r, p, pll_q, pll_p = 1, pll_r = 1, pll_j = 1;
 	u16 pll_d = 1;
+	u8 reg;
 
 	/* select data word length */
 	data =
@@ -801,8 +802,16 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 		pll_q &= 0xf;
 		aic3x_write(codec, AIC3X_PLL_PROGA_REG, pll_q << PLLQ_SHIFT);
 		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_CLKDIV);
-	} else
+		/* disable PLL if it is bypassed */
+		reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg & ~PLL_ENABLE);
+
+	} else {
 		aic3x_write(codec, AIC3X_GPIOB_REG, CODEC_CLKIN_PLLDIV);
+		/* enable PLL when it is used */
+		reg = aic3x_read_reg_cache(codec, AIC3X_PLL_PROGA_REG);
+		aic3x_write(codec, AIC3X_PLL_PROGA_REG, reg | PLL_ENABLE);
+	}
 
 	/* Route Left DAC to left channel input and
 	 * right DAC to right channel input */
-- 
1.5.6
