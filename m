From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98927: Updated volatile register list" to the asoc tree
Date: Thu, 31 Aug 2017 12:54:57 +0100
Message-ID: <E1dnO3l-0000nI-Nt@debutante>
References: <1497910046-3369-3-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497910046-3369-3-git-send-email-ryans.lee@maximintegrated.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, ryan.lee.maxim@gmail.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98927: Updated volatile register list

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

>From 9c1743ebe0da614517a1b94f171924d5fd758df4 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee@maximintegrated.com>
Date: Mon, 28 Aug 2017 16:30:55 -0700
Subject: [PATCH] ASoC: max98927: Updated volatile register list

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98927.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index b5ee29499e16..768e84dbcdf6 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -495,6 +495,13 @@ static bool max98927_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case MAX98927_R0001_INT_RAW1 ... MAX98927_R0009_INT_FLAG3:
+	case MAX98927_R004C_MEAS_ADC_CH0_READ:
+	case MAX98927_R004D_MEAS_ADC_CH1_READ:
+	case MAX98927_R004E_MEAS_ADC_CH2_READ:
+	case MAX98927_R0051_BROWNOUT_STATUS:
+	case MAX98927_R0087_ENV_TRACK_BOOST_VOUT_READ:
+	case MAX98927_R01FF_REV_ID:
+	case MAX98927_R0100_SOFT_RESET:
 		return true;
 	default:
 		return false;
-- 
2.14.1
