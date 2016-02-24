From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Make logging of FLL
	calculations clearer" to the asoc tree
Date: Wed, 24 Feb 2016 13:15:25 +0900
Message-ID: <E1aYQrF-0000rF-Jl@finisterre>
References: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B70AB266738
 for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2016 05:15:31 +0100 (CET)
In-Reply-To: <1456236992-32028-1-git-send-email-rf@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Make logging of FLL calculations clearer

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

>From 2595b7fe1aa3a1dfc47e549b39f7c35c5ce8a56d Mon Sep 17 00:00:00 2001
From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Date: Tue, 23 Feb 2016 14:16:32 +0000
Subject: [PATCH] ASoC: arizona: Make logging of FLL calculations clearer

The debug logging of FLL calculations was confusing. Values were
printed in hex without indicating this by a leading 0x, and
despite these normally being required in decimal. Also where the
register value isn't the actual value (it s a power-of-two or
0 means 1, 1 means 2, ...)  it was unclear whether the actual or
register value was shown.

This patch changes the log print so that all mathematical values
are shown in decimal, all register values are shown in hex with a
0x prefix, and where the register value isn't the actual integer
value the decimal integer value is shown in () after the hex
register value.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index a32cfb85f1ca..dd926f4da409 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2108,11 +2108,12 @@ static int arizona_calc_fll(struct arizona_fll *fll,
 		return -EINVAL;
 	}
 
-	arizona_fll_dbg(fll, "N=%x THETA=%x LAMBDA=%x\n",
+	arizona_fll_dbg(fll, "N=%d THETA=%d LAMBDA=%d\n",
 			cfg->n, cfg->theta, cfg->lambda);
-	arizona_fll_dbg(fll, "FRATIO=%x(%d) OUTDIV=%x REFCLK_DIV=%x\n",
-			cfg->fratio, cfg->fratio, cfg->outdiv, cfg->refdiv);
-	arizona_fll_dbg(fll, "GAIN=%d\n", cfg->gain);
+	arizona_fll_dbg(fll, "FRATIO=0x%x(%d) OUTDIV=%d REFCLK_DIV=0x%x(%d)\n",
+			cfg->fratio, ratio, cfg->outdiv,
+			cfg->refdiv, 1 << cfg->refdiv);
+	arizona_fll_dbg(fll, "GAIN=0x%x(%d)\n", cfg->gain, 1 << cfg->gain);
 
 	return 0;
 
-- 
2.7.0
