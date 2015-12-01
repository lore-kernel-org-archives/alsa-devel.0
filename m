From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sunxi: Remove useless comments and
	variable" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:46 +0000
Message-ID: <E1a3tti-0006Vp-Ez@debutante>
References: <1448968007-10128-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AE56A264FFB
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:52 +0100 (CET)
In-Reply-To: <1448968007-10128-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sunxi: Remove useless comments and variable

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

>From 0837d8780c766bffe1fc5a5da54fb2620923a6d0 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 1 Dec 2015 12:06:46 +0100
Subject: [PATCH] ASoC: sunxi: Remove useless comments and variable

The comment is misleading on how we should support external power amps, and
the variable is not used and generates a warning.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 30c9e9260491..516c7c2b479a 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -109,11 +109,6 @@ struct sun4i_codec {
 
 static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO high here on some boards
-	 */
-
 	/* Flush TX FIFO */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH),
@@ -127,11 +122,6 @@ static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
 
 static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO low here on some boards
-	 */
-
 	/* Disable DAC DRQ */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 			   BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
@@ -140,11 +130,6 @@ static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 
 static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO high here on some boards
-	 */
-
 	/* Enable ADC DRQ */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
@@ -153,11 +138,6 @@ static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 
 static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
 {
-	/*
-	 * FIXME: according to the BSP, we might need to drive a PA
-	 *        GPIO low here on some boards
-	 */
-
 	/* Disable ADC DRQ */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
 			   BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
@@ -358,8 +338,6 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 					 struct snd_pcm_hw_params *params,
 					 unsigned int hwrate)
 {
-	u32 val;
-
 	/* Set ADC sample rate */
 	regmap_update_bits(scodec->regmap, SUN4I_CODEC_ADC_FIFOC,
 			   7 << SUN4I_CODEC_ADC_FIFOC_ADC_FS,
-- 
2.6.2
