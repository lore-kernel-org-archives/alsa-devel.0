From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Don't change the FLLn_GAIN
	before entering FREERUN" to the asoc tree
Date: Wed, 31 Aug 2016 12:42:33 +0100
Message-ID: <E1bf3ub-00012e-Ty@finisterre>
References: <1472549440-4155-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D0DC26750B
 for <alsa-devel@alsa-project.org>; Wed, 31 Aug 2016 13:42:53 +0200 (CEST)
In-Reply-To: <1472549440-4155-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, nariman@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Don't change the FLLn_GAIN before entering FREERUN

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

>From c9991052aedaa74c69f8198852c65a99caf1adec Mon Sep 17 00:00:00 2001
From: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Date: Tue, 30 Aug 2016 10:30:40 +0100
Subject: [PATCH] ASoC: arizona: Don't change the FLLn_GAIN before entering
 FREERUN

When reclocking an active FLL, to ensure a clean transition, do
not change the gain setting until we have entered free run.

Signed-off-by: Nariman Poushin <nariman@opensource.wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index ecfdbfcae366..0fc3b4b61552 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2218,11 +2218,11 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 
 	if (already_enabled) {
 		/* Facilitate smooth refclk across the transition */
-		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
-					 ARIZONA_FLL1_GAIN_MASK, 0);
 		regmap_update_bits(fll->arizona->regmap, fll->base + 1,
 				   ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
 		udelay(32);
+		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
+					 ARIZONA_FLL1_GAIN_MASK, 0);
 	}
 
 	/*
-- 
2.9.3
