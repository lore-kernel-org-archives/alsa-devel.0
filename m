From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add 32uS delay after putting
	FLL into freerun" to the asoc tree
Date: Tue, 01 Dec 2015 22:59:47 +0000
Message-ID: <E1a3ttj-0006Y7-Gd@debutante>
References: <1448905048-13862-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BE9426619D
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:55 +0100 (CET)
In-Reply-To: <1448905048-13862-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add 32uS delay after putting FLL into freerun

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

>From 800f297e8ef91901b93c280425863684dff2d9c6 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 30 Nov 2015 17:37:28 +0000
Subject: [PATCH] ASoC: arizona: Add 32uS delay after putting FLL into freerun

When switching between two clock sources using the FLL freerun to smooth
the transition we should wait 32uS after putting the FLL into freerun
before we proceed. In practice we appear to be getting enough delay from
the surrounding code, but better to make it explicit.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index e76ecc7cc775..a23f7d15324a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2212,9 +2212,9 @@ static int arizona_enable_fll(struct arizona_fll *fll)
 		/* Facilitate smooth refclk across the transition */
 		regmap_update_bits_async(fll->arizona->regmap, fll->base + 0x9,
 					 ARIZONA_FLL1_GAIN_MASK, 0);
-		regmap_update_bits_async(fll->arizona->regmap, fll->base + 1,
-					 ARIZONA_FLL1_FREERUN,
-					 ARIZONA_FLL1_FREERUN);
+		regmap_update_bits(fll->arizona->regmap, fll->base + 1,
+				   ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
+		udelay(32);
 	}
 
 	/*
-- 
2.6.2
