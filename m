From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup struct rsnd_gen::res array
	size" to the asoc tree
Date: Fri, 23 Oct 2015 08:10:09 +0900
Message-ID: <E1ZpOzp-00007d-Hx@finisterre>
References: <871tcntxav.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07EA8266B76
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:10:19 +0200 (CEST)
In-Reply-To: <871tcntxav.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: fixup struct rsnd_gen::res array size

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

>From 9993c16d460e2965da4357575060373a5577167a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:13:27 +0000
Subject: [PATCH] ASoC: rsnd: fixup struct rsnd_gen::res array size

struct rsnd_gen :: res array size should be RSND_BASE_MAX,
not RSND_REG_MAX. This patch fixup it, and indicates whether
each data array size is based on what

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 0c69f83..76da762 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -22,13 +22,15 @@
 #include "rsnd.h"
 
 struct rsnd_gen {
-	void __iomem *base[RSND_BASE_MAX];
-
 	struct rsnd_gen_ops *ops;
 
+	/* RSND_BASE_MAX base */
+	void __iomem *base[RSND_BASE_MAX];
+	phys_addr_t res[RSND_BASE_MAX];
 	struct regmap *regmap[RSND_BASE_MAX];
+
+	/* RSND_REG_MAX base */
 	struct regmap_field *regs[RSND_REG_MAX];
-	phys_addr_t res[RSND_REG_MAX];
 };
 
 #define rsnd_priv_to_gen(p)	((struct rsnd_gen *)(p)->gen)
@@ -182,6 +184,7 @@ static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
+	/* RSND_BASE_MAX base */
 	gen->base[reg_id] = base;
 	gen->regmap[reg_id] = regmap;
 	gen->res[reg_id] = res->start;
@@ -198,6 +201,7 @@ static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
 		if (IS_ERR(regs))
 			return PTR_ERR(regs);
 
+		/* RSND_REG_MAX base */
 		gen->regs[conf[i].idx] = regs;
 	}
 
-- 
2.6.1
