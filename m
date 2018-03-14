From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: make structure
	da7219_dai_clks_ops static" to the asoc tree
Date: Wed, 14 Mar 2018 16:39:49 +0000 (GMT)
Message-ID: <20180314163949.6FA6644007A@finisterre.ee.mobilebroadband>
References: <20180313081400.GA10404@lkp-ivb-ep02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E5ED4267467
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:39:52 +0100 (CET)
In-Reply-To: <20180313081400.GA10404@lkp-ivb-ep02>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: make structure da7219_dai_clks_ops static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 1d37ce929c71f430389db3042a8b23536cede1e5 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 14 Mar 2018 14:28:25 +0000
Subject: [PATCH] ASoC: da7219: make structure da7219_dai_clks_ops static

structure da7219_dai_clks_ops is local to the source and does not need
to be in global scope, so make it static.

Cleans up sparse warning:
sound/soc/codecs/da7219.c:1777:22: warning: symbol 'da7219_dai_clks_ops'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 08f55d7a11ba..980a6a8bf56d 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1774,7 +1774,7 @@ static int da7219_dai_clks_is_prepared(struct clk_hw *hw)
 	return !!(clk_reg & DA7219_DAI_CLK_EN_MASK);
 }
 
-const struct clk_ops da7219_dai_clks_ops = {
+static const struct clk_ops da7219_dai_clks_ops = {
 	.prepare = da7219_dai_clks_prepare,
 	.unprepare = da7219_dai_clks_unprepare,
 	.is_prepared = da7219_dai_clks_is_prepared,
-- 
2.16.2
