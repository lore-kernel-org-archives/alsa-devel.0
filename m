From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: make the volume TLV to match
	the units 0.01dB" to the asoc tree
Date: Mon, 12 Sep 2016 20:07:00 +0100
Message-ID: <E1bjWZI-0002Zb-62@debutante>
References: <1473217669-29972-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 368A7266948
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 21:07:09 +0200 (CEST)
In-Reply-To: <1473217669-29972-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, shumingf@realtek.com, broonie@kernel.org, woojoo.lee@samsung.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: make the volume TLV to match the units 0.01dB

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

>From a1338a7d4cd401bb71f4562d6896aa2b74eeb1fb Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 7 Sep 2016 11:07:49 +0800
Subject: [PATCH] ASoC: rt5514: make the volume TLV to match the units 0.01dB

The volume have a step of 0.375dB, but TLV uses the units 0.01dB. It should
be changed to a step of 0.75dB to match the units of TLV.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 6 +++---
 sound/soc/codecs/rt5514.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 7162f05101d9..bad41ae40c6d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -278,7 +278,7 @@ static const DECLARE_TLV_DB_RANGE(bst_tlv,
 	8, 8, TLV_DB_SCALE_ITEM(1700, 0, 0)
 );
 
-static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(adc_vol_tlv, -1725, 75, 0);
 
 static int rt5514_dsp_voice_wake_up_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
@@ -352,10 +352,10 @@ static const struct snd_kcontrol_new rt5514_snd_controls[] = {
 	SOC_DOUBLE_TLV("MIC Boost Volume", RT5514_ANA_CTRL_MICBST,
 		RT5514_SEL_BSTL_SFT, RT5514_SEL_BSTR_SFT, 8, 0, bst_tlv),
 	SOC_DOUBLE_R_TLV("ADC1 Capture Volume", RT5514_DOWNFILTER0_CTRL1,
-		RT5514_DOWNFILTER0_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
+		RT5514_DOWNFILTER0_CTRL2, RT5514_AD_GAIN_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_DOUBLE_R_TLV("ADC2 Capture Volume", RT5514_DOWNFILTER1_CTRL1,
-		RT5514_DOWNFILTER1_CTRL2, RT5514_AD_GAIN_SFT, 127, 0,
+		RT5514_DOWNFILTER1_CTRL2, RT5514_AD_GAIN_SFT, 63, 0,
 		adc_vol_tlv),
 	SOC_SINGLE_EXT("DSP Voice Wake Up", SND_SOC_NOPM, 0, 1, 0,
 		rt5514_dsp_voice_wake_up_get, rt5514_dsp_voice_wake_up_put),
diff --git a/sound/soc/codecs/rt5514.h b/sound/soc/codecs/rt5514.h
index 68883c68e999..229de0e2c88c 100644
--- a/sound/soc/codecs/rt5514.h
+++ b/sound/soc/codecs/rt5514.h
@@ -196,8 +196,8 @@
 #define RT5514_AD_AD_MIX_BIT			10
 #define RT5514_AD_AD_MUTE			(0x1 << 7)
 #define RT5514_AD_AD_MUTE_BIT			7
-#define RT5514_AD_GAIN_MASK			(0x7f << 0)
-#define RT5514_AD_GAIN_SFT			0
+#define RT5514_AD_GAIN_MASK			(0x3f << 1)
+#define RT5514_AD_GAIN_SFT			1
 
 /*  RT5514_ANA_CTRL_MICBST (0x2220) */
 #define RT5514_SEL_BSTL_MASK			(0xf << 4)
-- 
2.8.1
