From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: psc-i2s: constify dev_pm_ops
	structure" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:27 +0100
Message-ID: <E1dX8XT-00057c-KI@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E33F26747A
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:40 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: au1x: psc-i2s: constify dev_pm_ops structure

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

>From 90982dcdda4f0163bc5e53f49301e155c2cd8547 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sun, 16 Jul 2017 21:12:49 -0500
Subject: [PATCH] ASoC: au1x: psc-i2s: constify dev_pm_ops structure

This dev_pm_ops structure is only stored in the pm field of a
device_driver structure. This field is declared const, so
dev_pm_ops structures that have this property can be declared
as const also.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/psc-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/au1x/psc-i2s.c b/sound/soc/au1x/psc-i2s.c
index 0bf9d62b91a0..e6eec081eaae 100644
--- a/sound/soc/au1x/psc-i2s.c
+++ b/sound/soc/au1x/psc-i2s.c
@@ -392,7 +392,7 @@ static int au1xpsc_i2s_drvresume(struct device *dev)
 	return 0;
 }
 
-static struct dev_pm_ops au1xpsci2s_pmops = {
+static const struct dev_pm_ops au1xpsci2s_pmops = {
 	.suspend	= au1xpsc_i2s_drvsuspend,
 	.resume		= au1xpsc_i2s_drvresume,
 };
-- 
2.13.2
