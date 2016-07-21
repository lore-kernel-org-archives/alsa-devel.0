From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs53l30: Fix bit shift issue of TDM mode" to the asoc tree
Date: Thu, 21 Jul 2016 12:08:20 +0100
Message-ID: <E1bQBq0-0001nQ-9S@debutante>
References: <1468967774-18621-2-git-send-email-nicoleotsuka@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1468967774-18621-2-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>broonie@kernel.org, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs53l30: Fix bit shift issue of TDM mode

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

>From 1708796fc1053eae3dcf648669f552967c210bd2 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 19 Jul 2016 15:36:14 -0700
Subject: [PATCH] ASoC: cs53l30: Fix bit shift issue of TDM mode

The TDM mode using PCM format now has two-bit right shift due to the
format configuration in the driver. According to Figure 4-13 in the
CS53L30 datasheet, using ASP_SCLK_INV = 0 and SHIFT_LEFT = 1 should
be the correct combination to create one-bit right shift for the DSP
type A format.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs53l30.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs53l30.c b/sound/soc/codecs/cs53l30.c
index fd5502e3aa34..2c0d9c430a8c 100644
--- a/sound/soc/codecs/cs53l30.c
+++ b/sound/soc/codecs/cs53l30.c
@@ -592,8 +592,12 @@ static int cs53l30_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		aspctl1 |= CS53L30_ASP_TDM_PDN;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		/* Clear TDM_PDN and SHIFT_LEFT, invert SCLK */
-		aspcfg |= CS53L30_ASP_SCLK_INV;
+		/*
+		 * Clear TDM_PDN to turn on TDM mode; Use ASP_SCLK_INV = 0
+		 * with SHIFT_LEFT = 1 combination as Figure 4-13 shows in
+		 * the CS53L30 datasheet
+		 */
+		aspctl1 |= CS53L30_SHIFT_LEFT;
 		break;
 	default:
 		return -EINVAL;
-- 
2.8.1
