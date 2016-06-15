From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Remove misleading comment" to the asoc tree
Date: Wed, 15 Jun 2016 15:38:40 +0100
Message-ID: <E1bDBxo-0006z7-T5@finisterre>
References: <20160606231453.19377-7-clemens.gruber@pqgruber.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160606231453.19377-7-clemens.gruber@pqgruber.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Eric Nelson <eric@nelint.com>Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Remove misleading comment

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

>From 7e74436410a9a74f41f3be9cc45b504e83544f60 Mon Sep 17 00:00:00 2001
From: Clemens Gruber <clemens.gruber@pqgruber.com>
Date: Tue, 7 Jun 2016 01:14:53 +0200
Subject: [PATCH] ASoC: sgtl5000: Remove misleading comment

All new designs should use external VDDD according to official
documentation. See ER1 in errata sheet:
http://cache.nxp.com/files/analog/doc/errata/SGTL5000ER.pdf

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 08b40460663c..23766bc4f8e8 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1113,7 +1113,6 @@ static const u8 vol_quot_table[] = {
  * and should be set according to:
  * 1. vddd provided by external or not
  * 2. vdda and vddio voltage value. > 3.1v or not
- * 3. chip revision >=0x11 or not. If >=0x11, not use external vddd.
  */
 static int sgtl5000_set_power_regs(struct snd_soc_codec *codec)
 {
-- 
2.8.1
