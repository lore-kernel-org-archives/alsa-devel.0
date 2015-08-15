From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l56: Use case range at appropriate
	place" to the asoc tree
Date: Fri, 14 Aug 2015 19:14:03 -0700
Message-ID: <E1ZQQyx-0004NS-7z@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A217266559
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:14:12 +0200 (CEST)
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
To: Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l56: Use case range at appropriate place

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

>From 7f325bfc933d140337e55507821d6bb021321059 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 12 Aug 2015 11:09:39 +0800
Subject: [PATCH] ASoC: cs42l56: Use case range at appropriate place

The readable registers are in continuous range: 0x01 ~ 0x2e.
Use case range syntax makes the code shorter with better readability when
we have a large number of continuous switch cases.
No functional change with this patch.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l56.c | 47 +---------------------------------------------
 1 file changed, 1 insertion(+), 46 deletions(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 1e11ba4..98a68c6 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -115,52 +115,7 @@ static const struct reg_default cs42l56_reg_defaults[] = {
 static bool cs42l56_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS42L56_CHIP_ID_1:
-	case CS42L56_CHIP_ID_2:
-	case CS42L56_PWRCTL_1:
-	case CS42L56_PWRCTL_2:
-	case CS42L56_CLKCTL_1:
-	case CS42L56_CLKCTL_2:
-	case CS42L56_SERIAL_FMT:
-	case CS42L56_CLASSH_CTL:
-	case CS42L56_MISC_CTL:
-	case CS42L56_INT_STATUS:
-	case CS42L56_PLAYBACK_CTL:
-	case CS42L56_DSP_MUTE_CTL:
-	case CS42L56_ADCA_MIX_VOLUME:
-	case CS42L56_ADCB_MIX_VOLUME:
-	case CS42L56_PCMA_MIX_VOLUME:
-	case CS42L56_PCMB_MIX_VOLUME:
-	case CS42L56_ANAINPUT_ADV_VOLUME:
-	case CS42L56_DIGINPUT_ADV_VOLUME:
-	case CS42L56_MASTER_A_VOLUME:
-	case CS42L56_MASTER_B_VOLUME:
-	case CS42L56_BEEP_FREQ_ONTIME:
-	case CS42L56_BEEP_FREQ_OFFTIME:
-	case CS42L56_BEEP_TONE_CFG:
-	case CS42L56_TONE_CTL:
-	case CS42L56_CHAN_MIX_SWAP:
-	case CS42L56_AIN_REFCFG_ADC_MUX:
-	case CS42L56_HPF_CTL:
-	case CS42L56_MISC_ADC_CTL:
-	case CS42L56_GAIN_BIAS_CTL:
-	case CS42L56_PGAA_MUX_VOLUME:
-	case CS42L56_PGAB_MUX_VOLUME:
-	case CS42L56_ADCA_ATTENUATOR:
-	case CS42L56_ADCB_ATTENUATOR:
-	case CS42L56_ALC_EN_ATTACK_RATE:
-	case CS42L56_ALC_RELEASE_RATE:
-	case CS42L56_ALC_THRESHOLD:
-	case CS42L56_NOISE_GATE_CTL:
-	case CS42L56_ALC_LIM_SFT_ZC:
-	case CS42L56_AMUTE_HPLO_MUX:
-	case CS42L56_HPA_VOLUME:
-	case CS42L56_HPB_VOLUME:
-	case CS42L56_LOA_VOLUME:
-	case CS42L56_LOB_VOLUME:
-	case CS42L56_LIM_THRESHOLD_CTL:
-	case CS42L56_LIM_CTL_RELEASE_RATE:
-	case CS42L56_LIM_ATTACK_RATE:
+	case CS42L56_CHIP_ID_1 ... CS42L56_LIM_ATTACK_RATE:
 		return true;
 	default:
 		return false;
-- 
2.5.0
