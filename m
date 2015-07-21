From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sti: error handling bug in
	sti_uniperiph_cpu_dai_of()" to the asoc tree
Date: Tue, 21 Jul 2015 11:49:12 +0100
Message-ID: <E1ZHV6m-0002qn-SB@debutante>
References: <20150721085736.GB22070@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85B2226154B
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 12:49:20 +0200 (CEST)
In-Reply-To: <20150721085736.GB22070@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sti: error handling bug in sti_uniperiph_cpu_dai_of()

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

>From a4642e99694a912b32952317e8f4c253ed6be4a9 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 21 Jul 2015 11:57:36 +0300
Subject: [PATCH] ASoC: sti: error handling bug in sti_uniperiph_cpu_dai_of()

There is a stray '!' which means the condition is never true.

Fixes: f3bd847eb0a7 ('ASoC: sti: Add uniperipheral dai driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sti/sti_uniperif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 51f745c56c7f..dffabf3ba9fb 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -175,7 +175,7 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 				     UNIPERIF_FIFO_DATA_OFFSET(uni);
 
 	uni->irq = platform_get_irq(priv->pdev, 0);
-	if (!uni->irq < 0) {
+	if (uni->irq < 0) {
 		dev_err(dev, "Failed to get IRQ resource");
 		return -ENXIO;
 	}
-- 
2.1.4
