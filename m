From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: rename some alsa control names"
	to the asoc tree
Date: Wed, 23 Dec 2015 00:08:55 +0000
Message-ID: <E1aBWz9-0007JN-2X@debutante>
References: <1450663793-3351-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0735B265D83
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:01 +0100 (CET)
In-Reply-To: <1450663793-3351-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: rename some alsa control names

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

>From e2133b64820df302a8e3d00c7531018470cd63a9 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 21 Dec 2015 10:09:53 +0800
Subject: [PATCH] ASoC: rt5616: rename some alsa control names

Rename some alsa control name as what they should be.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index 7bb56dddff8e..1c10d8ed39d2 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -323,9 +323,9 @@ static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 			RT5616_L_VOL_SFT, RT5616_R_VOL_SFT,
 			175, 0, dac_vol_tlv),
 	/* IN1/IN2 Control */
-	SOC_SINGLE_TLV("IN1 Boost", RT5616_IN1_IN2,
+	SOC_SINGLE_TLV("IN1 Boost Volume", RT5616_IN1_IN2,
 		RT5616_BST_SFT1, 8, 0, bst_tlv),
-	SOC_SINGLE_TLV("IN2 Boost", RT5616_IN1_IN2,
+	SOC_SINGLE_TLV("IN2 Boost Volume", RT5616_IN1_IN2,
 		RT5616_BST_SFT2, 8, 0, bst_tlv),
 	/* INL/INR Volume Control */
 	SOC_DOUBLE_TLV("IN Capture Volume", RT5616_INL1_INR1_VOL,
@@ -339,7 +339,7 @@ static const struct snd_kcontrol_new rt5616_snd_controls[] = {
 			127, 0, adc_vol_tlv),
 
 	/* ADC Boost Volume Control */
-	SOC_DOUBLE_TLV("ADC Boost Gain", RT5616_ADC_BST_VOL,
+	SOC_DOUBLE_TLV("ADC Boost Volume", RT5616_ADC_BST_VOL,
 			RT5616_ADC_L_BST_SFT, RT5616_ADC_R_BST_SFT,
 			3, 0, adc_bst_tlv),
 };
-- 
2.6.2
