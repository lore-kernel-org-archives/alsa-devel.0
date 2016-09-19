From: Marek Vasut <marex@denx.de>
Subject: [PATCH 2/5] ASoC: fsl_esai: use flat regmap cache
Date: Mon, 19 Sep 2016 21:30:26 +0200
Message-ID: <20160919193029.8119-2-marex@denx.de>
References: <20160919193029.8119-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DB9226655F
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2016 21:30:42 +0200 (CEST)
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
To: alsa-devel@alsa-project.org
Cc: Marek Vasut <marex@denx.de>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

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
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index e927955..38bfd46 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -781,7 +781,7 @@ static const struct regmap_config fsl_esai_regmap_config = {
 	.readable_reg = fsl_esai_readable_reg,
 	.volatile_reg = fsl_esai_volatile_reg,
 	.writeable_reg = fsl_esai_writeable_reg,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_FLAT,
 };
 
 static int fsl_esai_probe(struct platform_device *pdev)
-- 
2.9.3
