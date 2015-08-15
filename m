From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs42l52: Use case range at appropriate
	place" to the asoc tree
Date: Fri, 14 Aug 2015 19:14:20 -0700
Message-ID: <E1ZQQzE-0004OK-A2@finisterre>
References: <1439348917.3594.3.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 14EA5266626
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:14:30 +0200 (CEST)
In-Reply-To: <1439348917.3594.3.camel@ingics.com>
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

   ASoC: cs42l52: Use case range at appropriate place

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

>From 4caae9546d2cf7dbc7a12d451f847d7b58912bda Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 12 Aug 2015 11:08:37 +0800
Subject: [PATCH] ASoC: cs42l52: Use case range at appropriate place

The readable registers are in continuous range: 0x01 ~ 0x34.
Use case range syntax makes the code shorter with better readability when
we have a large number of continuous switch cases.
No functional change with this patch.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs42l52.c | 53 +---------------------------------------------
 1 file changed, 1 insertion(+), 52 deletions(-)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 4de52c9..02d9f3d 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -110,58 +110,7 @@ static const struct reg_default cs42l52_reg_defaults[] = {
 static bool cs42l52_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS42L52_CHIP:
-	case CS42L52_PWRCTL1:
-	case CS42L52_PWRCTL2:
-	case CS42L52_PWRCTL3:
-	case CS42L52_CLK_CTL:
-	case CS42L52_IFACE_CTL1:
-	case CS42L52_IFACE_CTL2:
-	case CS42L52_ADC_PGA_A:
-	case CS42L52_ADC_PGA_B:
-	case CS42L52_ANALOG_HPF_CTL:
-	case CS42L52_ADC_HPF_FREQ:
-	case CS42L52_ADC_MISC_CTL:
-	case CS42L52_PB_CTL1:
-	case CS42L52_MISC_CTL:
-	case CS42L52_PB_CTL2:
-	case CS42L52_MICA_CTL:
-	case CS42L52_MICB_CTL:
-	case CS42L52_PGAA_CTL:
-	case CS42L52_PGAB_CTL:
-	case CS42L52_PASSTHRUA_VOL:
-	case CS42L52_PASSTHRUB_VOL:
-	case CS42L52_ADCA_VOL:
-	case CS42L52_ADCB_VOL:
-	case CS42L52_ADCA_MIXER_VOL:
-	case CS42L52_ADCB_MIXER_VOL:
-	case CS42L52_PCMA_MIXER_VOL:
-	case CS42L52_PCMB_MIXER_VOL:
-	case CS42L52_BEEP_FREQ:
-	case CS42L52_BEEP_VOL:
-	case CS42L52_BEEP_TONE_CTL:
-	case CS42L52_TONE_CTL:
-	case CS42L52_MASTERA_VOL:
-	case CS42L52_MASTERB_VOL:
-	case CS42L52_HPA_VOL:
-	case CS42L52_HPB_VOL:
-	case CS42L52_SPKA_VOL:
-	case CS42L52_SPKB_VOL:
-	case CS42L52_ADC_PCM_MIXER:
-	case CS42L52_LIMITER_CTL1:
-	case CS42L52_LIMITER_CTL2:
-	case CS42L52_LIMITER_AT_RATE:
-	case CS42L52_ALC_CTL:
-	case CS42L52_ALC_RATE:
-	case CS42L52_ALC_THRESHOLD:
-	case CS42L52_NOISE_GATE_CTL:
-	case CS42L52_CLK_STATUS:
-	case CS42L52_BATT_COMPEN:
-	case CS42L52_BATT_LEVEL:
-	case CS42L52_SPK_STATUS:
-	case CS42L52_TEM_CTL:
-	case CS42L52_THE_FOLDBACK:
-	case CS42L52_CHARGE_PUMP:
+	case CS42L52_CHIP ... CS42L52_CHARGE_PUMP:
 		return true;
 	default:
 		return false;
-- 
2.5.0
