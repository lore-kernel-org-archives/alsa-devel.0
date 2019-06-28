From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Reset used registers at probe" to the asoc tree
Date: Fri, 28 Jun 2019 17:56:28 +0100 (BST)
Message-ID: <20190628165628.5898244004A@finisterre.sirena.org.uk>
References: <20190627120208.4661-2-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190627120208.4661-2-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Reset used registers at probe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 8af6b2291e054773e2e58b2e5dbc06e981d14296 Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Thu, 27 Jun 2019 15:02:08 +0300
Subject: [PATCH] ASoC: codecs: ad193x: Reset used registers at probe

Since the ad193x codecs have no software reset, we have to reinitialize the
registers after a hardware reset to assure no previous values are kept.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index f3bab8fe3579..9615e786d049 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -427,12 +427,22 @@ static void ad193x_reg_default_init(struct ad193x_priv *ad193x)
 		{  0, 0x99 },	/* PLL_CLK_CTRL0: pll input: mclki/xi 12.288Mhz */
 		{  1, 0x04 },	/* PLL_CLK_CTRL1: no on-chip Vref */
 		{  2, 0x40 },	/* DAC_CTRL0: TDM mode */
+		{  3, 0x00 },	/* DAC_CTRL1: reset */
 		{  4, 0x1A },	/* DAC_CTRL2: 48kHz de-emphasis, unmute dac */
 		{  5, 0x00 },	/* DAC_CHNL_MUTE: unmute DAC channels */
+		{  6, 0x00 },	/* DAC_L1_VOL: no attenuation */
+		{  7, 0x00 },	/* DAC_R1_VOL: no attenuation */
+		{  8, 0x00 },	/* DAC_L2_VOL: no attenuation */
+		{  9, 0x00 },	/* DAC_R2_VOL: no attenuation */
+		{ 10, 0x00 },	/* DAC_L3_VOL: no attenuation */
+		{ 11, 0x00 },	/* DAC_R3_VOL: no attenuation */
+		{ 12, 0x00 },	/* DAC_L4_VOL: no attenuation */
+		{ 13, 0x00 },	/* DAC_R4_VOL: no attenuation */
 	};
 	const struct ad193x_reg_default reg_adc_init[] = {
 		{ 14, 0x03 },	/* ADC_CTRL0: high-pass filter enable */
 		{ 15, 0x43 },	/* ADC_CTRL1: sata delay=1, adc aux mode */
+		{ 16, 0x00 },	/* ADC_CTRL2: reset */
 	};
 	int i;
 
-- 
2.20.1
