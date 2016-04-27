From: Peter Rosin <peda@axentia.se>
Subject: [PATCH] ASoC: atmel_ssc_dai: note buggy I2S support
	when the codec masters LRCLK
Date: Wed, 27 Apr 2016 11:06:33 +0200
Message-ID: <1461747993-11516-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0143.outbound.protection.outlook.com [157.55.234.143])
 by alsa0.perex.cz (Postfix) with ESMTP id 81725265A72
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 11:06:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

The only difference in register settings between I2S and DSP mode A,
for the SND_SOC_DAIFMT_CBM_CFM case, is the start condition (which is
SSC_START_FALLING_RF for I2S and SSC_START_RISING_RF for DSP mode A).

As this is not the only difference between the two formats, it is an
indicator that something is seriously wrong. And it is the I2S support
that is broken.

While the start condition is correct for the left channel word in the I2S
case, it is not correct that the right channel word follows immediately
after the left channel word. The start of the right channel word should
be triggered by a rising edge on LRCLK in the I2S case, something which
simply does not happen.

The correct thing to do would be to simply remove the alleged support
for I2S/CBM_CFM, but that is likely to cause regressions. So, just make
a note about the buggy I2S support in the source.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 sound/soc/atmel/atmel_ssc_dai.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 4ab1e2013238..3108c6e20ad5 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -558,7 +558,15 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 		break;
 
 	case SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM:
-		/* I2S format, CODEC supplies BCLK and LRC clocks. */
+		/*
+		 * I2S format, CODEC supplies BCLK and LRC clocks.
+		 * NOTE! This is not really I2S, as the SSC does not allow
+		 * for any extra empty BCLK cycles after the left channel
+		 * word. I.e. the SSC is only looking at the falling edge
+		 * of LRCLK and ignores the rising edge.
+		 * In reality, this is DSP mode A with inverted LRCLK.
+		 * Use DSP mode A instead, if your codec supports it.
+		 */
 		rcmr =	  SSC_BF(RCMR_PERIOD, 0)
 			| SSC_BF(RCMR_STTDLY, START_DELAY)
 			| SSC_BF(RCMR_START, SSC_START_FALLING_RF)
-- 
2.1.4
