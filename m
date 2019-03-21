From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Properly Set Processing
	Blocks" to the asoc tree
Date: Thu, 21 Mar 2019 15:06:39 +0000 (GMT)
Message-ID: <20190321150639.5E41211288EC@debutante.sirena.org.uk>
References: <20190321023854.16947-2-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9E6EF896B7
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:06:40 +0100 (CET)
In-Reply-To: <20190321023854.16947-2-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: team@nwdigitalradio.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Properly Set Processing Blocks

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

>From c95e3a4b96293403a427b5185e60fad28af51fdd Mon Sep 17 00:00:00 2001
From: Annaliese McDermond <nh6z@nh6z.net>
Date: Wed, 20 Mar 2019 19:38:44 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Properly Set Processing Blocks

Different processing blocks are required for different sampling
rates and power parameters.  Set the processing blocks based
on this information.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 56 ++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 1aa8f5aa4225..71a93fbc5971 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -59,6 +59,8 @@ struct aic32x4_rate_divs {
 	u8 nadc;
 	u8 madc;
 	u8 blck_N;
+	u8 r_block;
+	u8 p_block;
 };
 
 struct aic32x4_priv {
@@ -307,34 +309,34 @@ static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 
 static const struct aic32x4_rate_divs aic32x4_divs[] = {
 	/* 8k rate */
-	{12000000, 8000, 1, 7, 6800, 768, 5, 3, 128, 5, 18, 24},
-	{24000000, 8000, 2, 7, 6800, 768, 15, 1, 64, 45, 4, 24},
-	{25000000, 8000, 2, 7, 3728, 768, 15, 1, 64, 45, 4, 24},
+	{12000000, 8000, 1, 7, 6800, 768, 5, 3, 128, 5, 18, 24, 1, 1},
+	{24000000, 8000, 2, 7, 6800, 768, 15, 1, 64, 45, 4, 24, 1, 1},
+	{25000000, 8000, 2, 7, 3728, 768, 15, 1, 64, 45, 4, 24, 1, 1},
 	/* 11.025k rate */
-	{12000000, 11025, 1, 7, 5264, 512, 8, 2, 128, 8, 8, 16},
-	{24000000, 11025, 2, 7, 5264, 512, 16, 1, 64, 32, 4, 16},
+	{12000000, 11025, 1, 7, 5264, 512, 8, 2, 128, 8, 8, 16, 1, 1},
+	{24000000, 11025, 2, 7, 5264, 512, 16, 1, 64, 32, 4, 16, 1, 1},
 	/* 16k rate */
-	{12000000, 16000, 1, 7, 6800, 384, 5, 3, 128, 5, 9, 12},
-	{24000000, 16000, 2, 7, 6800, 384, 15, 1, 64, 18, 5, 12},
-	{25000000, 16000, 2, 7, 3728, 384, 15, 1, 64, 18, 5, 12},
+	{12000000, 16000, 1, 7, 6800, 384, 5, 3, 128, 5, 9, 12, 1, 1},
+	{24000000, 16000, 2, 7, 6800, 384, 15, 1, 64, 18, 5, 12, 1, 1},
+	{25000000, 16000, 2, 7, 3728, 384, 15, 1, 64, 18, 5, 12, 1, 1},
 	/* 22.05k rate */
-	{12000000, 22050, 1, 7, 5264, 256, 4, 4, 128, 4, 8, 8},
-	{24000000, 22050, 2, 7, 5264, 256, 16, 1, 64, 16, 4, 8},
-	{25000000, 22050, 2, 7, 2253, 256, 16, 1, 64, 16, 4, 8},
+	{12000000, 22050, 1, 7, 5264, 256, 4, 4, 128, 4, 8, 8, 1, 1},
+	{24000000, 22050, 2, 7, 5264, 256, 16, 1, 64, 16, 4, 8, 1, 1},
+	{25000000, 22050, 2, 7, 2253, 256, 16, 1, 64, 16, 4, 8, 1, 1},
 	/* 32k rate */
-	{12000000, 32000, 1, 7, 1680, 192, 2, 7, 64, 2, 21, 6},
-	{24000000, 32000, 2, 7, 1680, 192, 7, 2, 64, 7, 6, 6},
+	{12000000, 32000, 1, 7, 1680, 192, 2, 7, 64, 2, 21, 6, 1, 1},
+	{24000000, 32000, 2, 7, 1680, 192, 7, 2, 64, 7, 6, 6, 1, 1},
 	/* 44.1k rate */
-	{12000000, 44100, 1, 7, 5264, 128, 2, 8, 128, 2, 8, 4},
-	{24000000, 44100, 2, 7, 5264, 128, 8, 2, 64, 8, 4, 4},
-	{25000000, 44100, 2, 7, 2253, 128, 8, 2, 64, 8, 4, 4},
+	{12000000, 44100, 1, 7, 5264, 128, 2, 8, 128, 2, 8, 4, 1, 1},
+	{24000000, 44100, 2, 7, 5264, 128, 8, 2, 64, 8, 4, 4, 1, 1},
+	{25000000, 44100, 2, 7, 2253, 128, 8, 2, 64, 8, 4, 4, 1, 1},
 	/* 48k rate */
-	{12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4},
-	{24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4},
-	{25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4},
+	{12000000, 48000, 1, 8, 1920, 128, 2, 8, 128, 2, 8, 4, 1, 1},
+	{24000000, 48000, 2, 8, 1920, 128, 8, 2, 64, 8, 4, 4, 1, 1},
+	{25000000, 48000, 2, 7, 8643, 128, 8, 2, 64, 8, 4, 4, 1, 1},
 
 	/* 96k rate */
-	{25000000, 96000, 2, 7, 8643, 64, 4, 4, 64, 4, 4, 1},
+	{25000000, 96000, 2, 7, 8643, 64, 4, 4, 64, 4, 4, 1, 1, 9},
 };
 
 static const struct snd_kcontrol_new hpl_output_mixer_controls[] = {
@@ -696,6 +698,18 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
+static int aic32x4_set_processing_blocks(struct snd_soc_component *component,
+						u8 r_block, u8 p_block)
+{
+	if (r_block > 18 || p_block > 25)
+		return -EINVAL;
+
+	snd_soc_component_write(component, AIC32X4_ADCSPB, r_block);
+	snd_soc_component_write(component, AIC32X4_DACSPB, p_block);
+
+	return 0;
+}
+
 static int aic32x4_setup_clocks(struct snd_soc_component *component,
 				unsigned int sample_rate,
 				unsigned int parent_rate)
@@ -708,6 +722,8 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 		return i;
 	}
 
+	aic32x4_set_processing_blocks(component, aic32x4_divs[i].r_block, aic32x4_divs[i].p_block);
+
 	/* MCLK as PLL_CLKIN */
 	snd_soc_component_update_bits(component, AIC32X4_CLKMUX, AIC32X4_PLL_CLKIN_MASK,
 			    AIC32X4_PLL_CLKIN_MCLK << AIC32X4_PLL_CLKIN_SHIFT);
-- 
2.20.1
