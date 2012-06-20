From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH 1/1] davinci:mcasp: Fix audio pll (pll-p) configure bug
Date: Wed, 20 Jun 2012 19:18:07 +0530
Message-ID: <1340200087-13744-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org
Cc: sudhakar.raj@ti.com, nsekhar@ti.com, gururaja.hebbar@ti.com
List-Id: alsa-devel@alsa-project.org

In sound/soc/codecs/tlv320aic3x.c

	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
		      data | (pll_p << PLLP_SHIFT));

In the above code pll-p value is OR'ed with previous value without
clearing the mask.

Currently it seems pll-p value doesn't change across Sampling frequency
(it stays at 1).

However on some platforms (like AM335x EVM-SK), pll-p may have different
values across different sampling frequencies. In such case, above code
configures the pll with a wrong value.
Because of this bug, when a audio stream is played with pll value
different from previous stream, audio is heard as stretched.

Fix the same by clearing the mask and then writing the value.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
 sound/soc/codecs/tlv320aic3x.c |    2 +-
 sound/soc/codecs/tlv320aic3x.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index d0dbac1..8c1977b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -963,7 +963,7 @@ static int aic3x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 found:
-	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
+	data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG) & ~PLLP_MASK;
 	snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
 		      data | (pll_p << PLLP_SHIFT));
 	snd_soc_write(codec, AIC3X_OVRF_STATUS_AND_PLLR_REG,
diff --git a/sound/soc/codecs/tlv320aic3x.h b/sound/soc/codecs/tlv320aic3x.h
index 06a1978..16d9999 100644
--- a/sound/soc/codecs/tlv320aic3x.h
+++ b/sound/soc/codecs/tlv320aic3x.h
@@ -166,6 +166,7 @@
 
 /* PLL registers bitfields */
 #define PLLP_SHIFT		0
+#define PLLP_MASK		7
 #define PLLQ_SHIFT		3
 #define PLLR_SHIFT		0
 #define PLLJ_SHIFT		2
-- 
1.7.1
