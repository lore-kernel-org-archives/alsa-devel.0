From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [RFC] ASoC: Fix non-networked I2S mode for PXA SSP
Date: Fri, 13 Mar 2009 14:37:54 +0000
Message-ID: <1236955075-14253-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090313143720.GC8989@sirena.org.uk>
	<1236955075-14253-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 24A57103801
	for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2009 16:06:52 +0100 (CET)
In-Reply-To: <1236955075-14253-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>, pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Two issues are fixed here:

 - I2S transmits the left frame with the clock low but I don't seem to
   get LRCLK out without SFRMDLY being set so invert SFRMP and set a
   delay.
 - I2S has a clock cycle prior to the first data byte in each channel
   so we need to delay the data by one cycle.

Only tested on Zylonite in master mode.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa-ssp.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 4dd0d7c..b0bf409 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -1,4 +1,3 @@
-#define DEBUG
 /*
  * pxa-ssp.c  --  ALSA Soc Audio Layer
  *
@@ -561,14 +560,15 @@ static int pxa_ssp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		sscr0 |= SSCR0_PSP;
 		sscr1 |= SSCR1_RWOT | SSCR1_TRAIL;
 
+		/* See hw_params() */
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 		case SND_SOC_DAIFMT_NB_NF:
+			sspsp |= SSPSP_SFRMP;
 			break;
 		case SND_SOC_DAIFMT_NB_IF:
-			sspsp |= SSPSP_SFRMP;
 			break;
 		case SND_SOC_DAIFMT_IB_IF:
-			sspsp |= SSPSP_SFRMP | SSPSP_SCMODE(3);
+			sspsp |= SSPSP_SCMODE(3);
 			break;
 		default:
 			return -EINVAL;
@@ -691,8 +691,17 @@ static int pxa_ssp_hw_params(struct snd_pcm_substream *substream,
 #else
 			return -EINVAL;
 #endif
-		} else
-			sspsp |= SSPSP_SFRMWDTH(width);
+		} else {
+			/* The frame width is the width the LRCLK is
+			 * asserted for; the delay is expressed in
+			 * half cycle units.  We need the extra cycle
+			 * because the data starts clocking out one BCLK
+			 * after LRCLK changes polarity.
+			 */
+			sspsp |= SSPSP_SFRMWDTH(width + 1);
+			sspsp |= SSPSP_SFRMDLY((width + 1) * 2);
+			sspsp |= SSPSP_DMYSTRT(1);
+		}
 
 		ssp_write_reg(ssp, SSPSP, sspsp);
 		break;
-- 
1.5.6.3
