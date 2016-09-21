From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_asrc: use flat regmap cache" to the
	asoc tree
Date: Wed, 21 Sep 2016 13:56:08 +0100
Message-ID: <E1bmh4K-0001a3-2p@debutante>
References: <20160919193029.8119-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1AB1261560
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 14:56:14 +0200 (CEST)
In-Reply-To: <20160919193029.8119-1-marex@denx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marex@denx.de>
Cc: alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_asrc: use flat regmap cache

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

>From b413886886b9a8f845f7d1a5adafa0ca573d3828 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marex@denx.de>
Date: Mon, 19 Sep 2016 21:30:25 +0200
Subject: [PATCH] ASoC: fsl_asrc: use flat regmap cache

Same as commit ce492b3b8f99cf9d2f807ec22d8805c996a09503
Subject: drm/fsl-dcu: use flat regmap cache

Using flat regmap cache instead of RB-tree to avoid the following
lockdep warning on driver load:
WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:2871 lockdep_trace_alloc+0x104/0x128
DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))

The RB-tree regmap cache needs to allocate new space on first
writes. However, allocations in an atomic context (e.g. when a
spinlock is held) are not allowed. The function regmap_write
calls map->lock, which acquires a spinlock in the fast_io case.
Since the driver uses MMIO, the regmap bus of type regmap_mmio
is being used which has fast_io set to true.

Signed-off-by: Marek Vasut <marex@denx.de>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_asrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index b7157ce23479..1d82f68305c3 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -726,7 +726,7 @@ static const struct regmap_config fsl_asrc_regmap_config = {
 	.readable_reg = fsl_asrc_readable_reg,
 	.volatile_reg = fsl_asrc_volatile_reg,
 	.writeable_reg = fsl_asrc_writeable_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_FLAT,
 };
 
 /**
-- 
2.8.1
