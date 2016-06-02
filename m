From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Rename the volume controls for preamplifier" to the asoc tree
Date: Thu, 02 Jun 2016 11:18:24 +0100
Message-ID: <E1b8Pho-0001aw-Bc@finisterre>
References: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464735999-10384-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>broonie@kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.comPaul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Rename the volume controls for preamplifier

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

>From b97c4446817a88a3e5c85d6eed3e65693588c088 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 31 May 2016 16:06:38 -0700
Subject: [PATCH] ASoC: cs53l30: Rename the volume controls for preamplifier

Volume controls should end with 'Volume', so this patch renames them for
ADC preamplifier.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index 714e5799284f..9aff449e57af 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -331,10 +331,10 @@ static const struct snd_kcontrol_new cs53l30_snd_controls[] = {
 	SOC_SINGLE_TLV("ADC2 NG Boost Volume", CS53L30_ADC2_NG_CTL,
 		       CS53L30_ADCx_NG_BOOST_SHIFT, 1, 0, adc_ng_boost_tlv),
 
-	SOC_DOUBLE_R_TLV("ADC1 Pre Amp Gain", CS53L30_ADC1A_AFE_CTL,
+	SOC_DOUBLE_R_TLV("ADC1 Preamplifier Volume", CS53L30_ADC1A_AFE_CTL,
 			 CS53L30_ADC1B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
 			 2, 0, pga_preamp_tlv),
-	SOC_DOUBLE_R_TLV("ADC2 Pre Amp Gain", CS53L30_ADC2A_AFE_CTL,
+	SOC_DOUBLE_R_TLV("ADC2 Preamplifier Volume", CS53L30_ADC2A_AFE_CTL,
 			 CS53L30_ADC2B_AFE_CTL, CS53L30_ADCxy_PREAMP_SHIFT,
 			 2, 0, pga_preamp_tlv),
 
-- 
2.8.1
