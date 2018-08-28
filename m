From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5682: Change DAC/ADC volume scale" to
	the asoc tree
Date: Tue, 28 Aug 2018 21:45:03 +0100 (BST)
Message-ID: <20180828204503.D09DF44007A@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0326D26781A
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 22:45:49 +0200 (CEST)
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
To: Shuming Fan <shumingf@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, stable@vger.kernel.org, koonc@google.com, albertchen@realtek.com, broonie@kernel.org, alexlee@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5682: Change DAC/ADC volume scale

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

>From 7509487785d7a2bf3606cf26710f0ca29e9ca94d Mon Sep 17 00:00:00 2001
From: Shuming Fan <shumingf@realtek.com>
Date: Fri, 24 Aug 2018 10:52:19 +0800
Subject: [PATCH] ASoC: rt5682: Change DAC/ADC volume scale

The step of DAC/ADC volume scale changes from 0.375dB to 0.75dB

Signed-off-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/rt5682.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
index 640d400ca013..afe7d5b19313 100644
--- a/sound/soc/codecs/rt5682.c
+++ b/sound/soc/codecs/rt5682.c
@@ -750,8 +750,8 @@ static bool rt5682_readable_register(struct device *dev, unsigned int reg)
 }
 
 static const DECLARE_TLV_DB_SCALE(hp_vol_tlv, -2250, 150, 0);
-static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -65625, 375, 0);
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(dac_vol_tlv, -6525, 75, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(adc_bst_tlv, 0, 1200, 0);
 
 /* {0, +20, +24, +30, +35, +40, +44, +50, +52} dB */
@@ -1114,7 +1114,7 @@ static const struct snd_kcontrol_new rt5682_snd_controls[] = {
 
 	/* DAC Digital Volume */
 	SOC_DOUBLE_TLV("DAC1 Playback Volume", RT5682_DAC1_DIG_VOL,
-		RT5682_L_VOL_SFT, RT5682_R_VOL_SFT, 175, 0, dac_vol_tlv),
+		RT5682_L_VOL_SFT + 1, RT5682_R_VOL_SFT + 1, 86, 0, dac_vol_tlv),
 
 	/* IN Boost Volume */
 	SOC_SINGLE_TLV("CBJ Boost Volume", RT5682_CBJ_BST_CTRL,
@@ -1124,7 +1124,7 @@ static const struct snd_kcontrol_new rt5682_snd_controls[] = {
 	SOC_DOUBLE("STO1 ADC Capture Switch", RT5682_STO1_ADC_DIG_VOL,
 		RT5682_L_MUTE_SFT, RT5682_R_MUTE_SFT, 1, 1),
 	SOC_DOUBLE_TLV("STO1 ADC Capture Volume", RT5682_STO1_ADC_DIG_VOL,
-		RT5682_L_VOL_SFT, RT5682_R_VOL_SFT, 127, 0, adc_vol_tlv),
+		RT5682_L_VOL_SFT + 1, RT5682_R_VOL_SFT + 1, 63, 0, adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
 	SOC_DOUBLE_TLV("STO1 ADC Boost Gain Volume", RT5682_STO1_ADC_BOOST,
-- 
2.18.0
