From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: fixed 32bit audio capture
	support for H3/H2+" to the asoc tree
Date: Thu, 09 Nov 2017 17:43:08 +0000
Message-ID: <E1eCqr6-0006f0-Au@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BBF2F267826
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 18:43:09 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: fixed 32bit audio capture support for H3/H2+

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8a0f95ce48304364979066600eba7cc5c939ba83 Mon Sep 17 00:00:00 2001
From: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Date: Tue, 31 Oct 2017 12:58:18 +0100
Subject: [PATCH] ASoC: sun4i-codec: fixed 32bit audio capture support for
 H3/H2+

32bit and 24bit audio capture formats for H3/H2+ are broken because the
RX_SAMPLE_BITS and the RX_FIFO_MODE bits of AC_ADC_FIFOC register of the audio
codec are not set to operate in 24bit mode but in 16bit mode only.
The following patch sets the H3 audio codec registers and the DMA bus width
properly when a 24/32bit capture is requested.

Signed-off-by: Andrea Bondavalli <andrea.bondavalli74@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index baa9007464ed..5da4efe7a550 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -346,11 +346,6 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 				   0x3 << 8,
 				   0x1 << 8);
 
-	/* Fill most significant bits with valid data MSB */
-	regmap_field_update_bits(scodec->reg_adc_fifoc,
-				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
-				 BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
-
 	return 0;
 }
 
@@ -490,6 +485,30 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
 					 0);
 
+	/* Set the number of sample bits to either 16 or 24 bits */
+	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
+
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+				   0);
+
+		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	} else {
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
+				   0);
+
+		/* Fill most significant bits with valid data MSB */
+		regmap_field_update_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
+
+		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+	}
+
 	return 0;
 }
 
-- 
2.15.0
