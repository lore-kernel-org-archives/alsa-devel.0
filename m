From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: fix bug in FLL parameter" to the asoc tree
Date: Wed, 14 Sep 2016 18:15:56 +0100
Message-ID: <E1bkDmu-0001lB-OG@debutante>
References: <1473738963-17406-1-git-send-email-KCHSU0@nuvoton.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1473738963-17406-1-git-send-email-KCHSU0@nuvoton.com>
Sender: stable-owner@vger.kernel.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgbroonie@kernel.org, alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: fix bug in FLL parameter

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

>From a8961cae29c38e225120c40c3340dbde2f552e60 Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Tue, 13 Sep 2016 11:56:03 +0800
Subject: [PATCH] ASoC: nau8825: fix bug in FLL parameter

In the FLL parameter calculation, the FVCO should choose the maximum one.
The patch is to fix the bug about the wrong FVCO chosen.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/codecs/nau8825.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 5c9707ac4bbf..cc32699f8e29 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1912,7 +1912,7 @@ static int nau8825_calc_fll_param(unsigned int fll_in, unsigned int fs,
 	/* Calculate the FLL 10-bit integer input and the FLL 16-bit fractional
 	 * input based on FDCO, FREF and FLL ratio.
 	 */
-	fvco = div_u64(fvco << 16, fref * fll_param->ratio);
+	fvco = div_u64(fvco_max << 16, fref * fll_param->ratio);
 	fll_param->fll_int = (fvco >> 16) & 0x3FF;
 	fll_param->fll_frac = fvco & 0xFFFF;
 	return 0;
-- 
2.8.1
