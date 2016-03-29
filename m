From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8962: Disable clock if
	wm8962_runtime_resume() fails" to the asoc tree
Date: Tue, 29 Mar 2016 10:08:13 -0700
Message-ID: <E1akx7l-0001Hv-8O@finisterre>
References: <1459164679-17961-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 948092668C5
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 19:08:23 +0200 (CEST)
In-Reply-To: <1459164679-17961-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8962: Disable clock if wm8962_runtime_resume() fails

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

>From 65147846796bd443972d9055b3b4c1339e15d53a Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Mon, 28 Mar 2016 08:31:18 -0300
Subject: [PATCH] ASoC: wm8962: Disable clock if wm8962_runtime_resume() fails

When regulator_bulk_enable() fails inside wm8962_runtime_resume(),
we should disable the previously enabled clock.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8962.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 88223608a33f..f3f71ba0ed12 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3800,7 +3800,7 @@ static int wm8962_runtime_resume(struct device *dev)
 	if (ret != 0) {
 		dev_err(dev,
 			"Failed to enable supplies: %d\n", ret);
-		return ret;
+		goto disable_clock;
 	}
 
 	regcache_cache_only(wm8962->regmap, false);
@@ -3838,6 +3838,10 @@ static int wm8962_runtime_resume(struct device *dev)
 	msleep(5);
 
 	return 0;
+
+disable_clock:
+	clk_disable_unprepare(wm8962->pdata.mclk);
+	return ret;
 }
 
 static int wm8962_runtime_suspend(struct device *dev)
-- 
2.8.0.rc3
