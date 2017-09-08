From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Override bit clock rate based
	on slot number
Date: Thu,  7 Sep 2017 22:23:43 -0700
Message-ID: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id D19B9267400
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 07:24:56 +0200 (CEST)
Received: by mail-pf0-f194.google.com with SMTP id g65so707730pfe.1
 for <alsa-devel@alsa-project.org>; Thu, 07 Sep 2017 22:24:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, timur@tabi.org, arnaud.mouiche@invoxia.com, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, caleb@crome.org, mpa@pengutronix.de, max.krummenacher@toradex.com, lukma@denx.de, fabio.estevam@nxp.com, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The set_sysclk() now is used to override the output bit clock rate.
But this is not a common way to implement a set_dai_sysclk(). And
this creates a problem when a general machine driver (simple-card
for example) tries to do set_dai_sysclk() by passing an input clock
rate for the baud clock instead of setting the bit clock rate as
fsl_ssi driver expected.

So this patch solves this problem by firstly removing set_sysclk()
since the hw_params() can calculate the bit clock rate. Secondly,
in order not to break those TDM use cases which previously might
have been using set_sysclk() to override the bit clock rate, this
patch changes the driver to override it based on the slot number.

The patch also removes an obsolete comment of the dir parameter.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 64598d1..3657c88 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -197,12 +197,12 @@ struct fsl_ssi_soc_data {
  * @use_dma: DMA is used or FIQ with stream filter
  * @use_dual_fifo: DMA with support for both FIFOs used
  * @fifo_deph: Depth of the SSI FIFOs
+ * @slots: number of slots
  * @rxtx_reg_val: Specific register settings for receive/transmit configuration
  *
  * @clk: SSI clock
  * @baudclk: SSI baud clock for master mode
  * @baudclk_streams: Active streams that are using baudclk
- * @bitclk_freq: bitclock frequency set by .set_dai_sysclk
  *
  * @dma_params_tx: DMA transmit parameters
  * @dma_params_rx: DMA receive parameters
@@ -233,12 +233,12 @@ struct fsl_ssi_private {
 	bool use_dual_fifo;
 	bool has_ipg_clk_name;
 	unsigned int fifo_depth;
+	unsigned int slots;
 	struct fsl_ssi_rxtx_reg_val rxtx_reg_val;
 
 	struct clk *clk;
 	struct clk *baudclk;
 	unsigned int baudclk_streams;
-	unsigned int bitclk_freq;
 
 	/* regcache for volatile regs */
 	u32 regcache_sfcsr;
@@ -700,8 +700,7 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
  * Note: This function can be only called when using SSI as DAI master
  *
  * Quick instruction for parameters:
- * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
- * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
+ * freq: Output BCLK frequency = samplerate * 32 (fixed) * slots (or channels)
  */
 static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 		struct snd_soc_dai *cpu_dai,
@@ -716,9 +715,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	unsigned int freq;
 	bool baudclk_is_used;
 
-	/* Prefer the explicitly set bitclock frequency */
-	if (ssi_private->bitclk_freq)
-		freq = ssi_private->bitclk_freq;
+	/* Generate bit clock based on the slot or channel number */
+	if (ssi_private->slots)
+		freq = ssi_private->slots * 32 * params_rate(hw_params);
 	else
 		freq = params_channels(hw_params) * 32 * params_rate(hw_params);
 
@@ -805,16 +804,6 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
-		int clk_id, unsigned int freq, int dir)
-{
-	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
-
-	ssi_private->bitclk_freq = freq;
-
-	return 0;
-}
-
 /**
  * fsl_ssi_hw_params - program the sample size
  *
@@ -1121,6 +1110,8 @@ static int fsl_ssi_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 
 	regmap_update_bits(regs, CCSR_SSI_SCR, CCSR_SSI_SCR_SSIEN, val);
 
+	ssi_private->slots = slots;
+
 	return 0;
 }
 
@@ -1191,7 +1182,6 @@ static const struct snd_soc_dai_ops fsl_ssi_dai_ops = {
 	.hw_params	= fsl_ssi_hw_params,
 	.hw_free	= fsl_ssi_hw_free,
 	.set_fmt	= fsl_ssi_set_dai_fmt,
-	.set_sysclk	= fsl_ssi_set_dai_sysclk,
 	.set_tdm_slot	= fsl_ssi_set_dai_tdm_slot,
 	.trigger	= fsl_ssi_trigger,
 };
-- 
2.7.4
