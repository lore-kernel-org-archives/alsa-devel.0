From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8824: leave Class D gain at chip
	default" to the asoc tree
Date: Sun, 30 Apr 2017 21:58:04 +0900
Message-ID: <E1d4oQO-0003zp-FF@finisterre>
References: <1493263370-23040-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B99A2664EB
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 14:58:12 +0200 (CEST)
In-Reply-To: <1493263370-23040-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, WTLI@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8824: leave Class D gain at chip default

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

>From c869ce5aaf8f470c8cf32638e7cd498f57118fa5 Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Thu, 27 Apr 2017 11:22:50 +0800
Subject: [PATCH] ASoC: nau8824: leave Class D gain at chip default

Remove initial configuration of Class D gain for 1R and 2L.
Leave them at the chip default.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8824.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index cd358be027dd..cca974d26136 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1626,12 +1626,6 @@ static void nau8824_init_regs(struct nau8824 *nau8824)
 	regmap_update_bits(regmap, NAU8824_REG_DAC_FILTER_CTRL_1,
 		NAU8824_DAC_CICCLP_OFF | NAU8824_DAC_OVERSAMPLE_MASK,
 		NAU8824_DAC_CICCLP_OFF | NAU8824_DAC_OVERSAMPLE_64);
-	/* Class D gain 9db for 1R and 2L */
-	regmap_update_bits(regmap, NAU8824_REG_CLASSD_GAIN_1,
-		NAU8824_CLASSD_GAIN_1R_MASK,
-		(0xa << NAU8824_CLASSD_GAIN_1R_SFT));
-	regmap_update_bits(regmap, NAU8824_REG_CLASSD_GAIN_2,
-		NAU8824_CLASSD_GAIN_2L_MASK, 0xa);
 	/* DAC clock delay 2ns, VREF */
 	regmap_update_bits(regmap, NAU8824_REG_RDAC,
 		NAU8824_RDAC_CLK_DELAY_MASK | NAU8824_RDAC_VREF_MASK,
-- 
2.11.0
