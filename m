From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: ad193x: Fix frame polarity for DSP_A format" to the asoc tree
Date: Mon, 18 Feb 2019 18:49:35 +0000 (GMT)
Message-ID: <20190218184935.72BB11128008@debutante.sirena.org.uk>
References: <20190218160954.13929-4-codrin.ciubotariu@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218160954.13929-4-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, lars@metafoo.de, lgirdwood@gmail.combroonie@kernel.org, alsa-devel@alsa-project.org, Codrin.Ciubotariu@microchip.com, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: ad193x: Fix frame polarity for DSP_A format

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

>From 90f6e68031397fb6212bef5619193cd15707fa0f Mon Sep 17 00:00:00 2001
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Date: Mon, 18 Feb 2019 16:10:32 +0000
Subject: [PATCH] ASoC: codecs: ad193x: Fix frame polarity for DSP_A format

By default, the codec starts to interpret the left (first) channel on
the falling edge (low polarity) of LRCLK. However, for DSP_A, the left
channel needs to start on the rising edge of LRCLK. This patch fixes
this channel swap by toggling the bit which selects the LRCLK polarity.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ad193x.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/ad193x.c b/sound/soc/codecs/ad193x.c
index c16c9969d1a0..315ec9775118 100644
--- a/sound/soc/codecs/ad193x.c
+++ b/sound/soc/codecs/ad193x.c
@@ -228,6 +228,12 @@ static int ad193x_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
+	/* For DSP_*, LRCLK's polarity must be inverted */
+	if (fmt & SND_SOC_DAIFMT_DSP_A) {
+		change_bit(ffs(AD193X_DAC_LEFT_HIGH) - 1,
+			   (unsigned long *)&dac_fmt);
+	}
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & frm master */
 		adc_fmt |= AD193X_ADC_LCR_MASTER;
-- 
2.20.1
