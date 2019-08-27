From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es8316: fix inverted L/R of headphone mixer volume" to the asoc tree
Date: Tue, 27 Aug 2019 20:57:44 +0100 (BST)
Message-ID: <20190827195744.8D301D02CEC@fitzroy.sirena.org.uk>
References: <20190826153900.25969-2-katsuhiro@katsuster.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190826153900.25969-2-katsuhiro@katsuster.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc: alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>, David Yang <yangxiaohua@everest-semi.com>, Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es8316: fix inverted L/R of headphone mixer volume

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

>From f6e77921969003eaf5dbae9c0b5feeb20c6caf50 Mon Sep 17 00:00:00 2001
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Date: Tue, 27 Aug 2019 00:39:00 +0900
Subject: [PATCH] ASoC: es8316: fix inverted L/R of headphone mixer volume

This patch fixes inverted Left-Right channel of headphone mixer
volume by wrong shift_left, shift_right values.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Reviewed-by: Daniel Drake <drake@endlessm.com>
Link: https://lore.kernel.org/r/20190826153900.25969-2-katsuhiro@katsuster.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 96d04896193f..ed2959dbe1fb 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -92,7 +92,7 @@ static const struct snd_kcontrol_new es8316_snd_controls[] = {
 	SOC_DOUBLE_TLV("Headphone Playback Volume", ES8316_CPHP_ICAL_VOL,
 		       4, 0, 3, 1, hpout_vol_tlv),
 	SOC_DOUBLE_TLV("Headphone Mixer Volume", ES8316_HPMIX_VOL,
-		       0, 4, 11, 0, hpmixer_gain_tlv),
+		       4, 0, 11, 0, hpmixer_gain_tlv),
 
 	SOC_ENUM("Playback Polarity", dacpol),
 	SOC_DOUBLE_R_TLV("DAC Playback Volume", ES8316_DAC_VOLL,
-- 
2.20.1
