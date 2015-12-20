From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register volatile
Date: Sun, 20 Dec 2015 21:30:25 +0100
Message-ID: <56770FE1.4060202@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id A8A2226073D
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 21:30:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

SACNT register should be marked volatile since
its WR and RD bits are cleared by SSI after
completing the relevant operation.
This unbreaks AC'97 register access.

Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 sound/soc/fsl/fsl_ssi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e3abad5f980a..cc22354d7758 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -146,6 +146,7 @@ static bool fsl_ssi_volatile_reg(struct device *dev, unsigned int reg)
 	case CCSR_SSI_SRX1:
 	case CCSR_SSI_SISR:
 	case CCSR_SSI_SFCSR:
+	case CCSR_SSI_SACNT:
 	case CCSR_SSI_SACADD:
 	case CCSR_SSI_SACDAT:
 	case CCSR_SSI_SATAG:
@@ -239,8 +240,9 @@ struct fsl_ssi_private {
 	unsigned int baudclk_streams;
 	unsigned int bitclk_freq;
 
-	/*regcache for SFCSR*/
+	/* regcache for volatile regs */
 	u32 regcache_sfcsr;
+	u32 regcache_sacnt;
 
 	/* DMA params */
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
@@ -1587,6 +1589,8 @@ static int fsl_ssi_suspend(struct device *dev)
 
 	regmap_read(regs, CCSR_SSI_SFCSR,
 			&ssi_private->regcache_sfcsr);
+	regmap_read(regs, CCSR_SSI_SACNT,
+			&ssi_private->regcache_sacnt);
 
 	regcache_cache_only(regs, true);
 	regcache_mark_dirty(regs);
@@ -1605,6 +1609,8 @@ static int fsl_ssi_resume(struct device *dev)
 			CCSR_SSI_SFCSR_RFWM1_MASK | CCSR_SSI_SFCSR_TFWM1_MASK |
 			CCSR_SSI_SFCSR_RFWM0_MASK | CCSR_SSI_SFCSR_TFWM0_MASK,
 			ssi_private->regcache_sfcsr);
+	regmap_write(regs, CCSR_SSI_SACNT,
+			ssi_private->regcache_sacnt);
 
 	return regcache_sync(regs);
 }
