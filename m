From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rename INT_ENABLE to
	SSI_INT_ENABLE" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:39 +0100
Message-ID: <E1ZFqRP-0002or-19@finisterre>
References: <87380px5kl.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01CB0266844
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:44 +0200 (CEST)
In-Reply-To: <87380px5kl.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Keita Kobayashi <keita.kobayashi.ym@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rename INT_ENABLE to SSI_INT_ENABLE

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

>From efa991dc9143815179fd55a88e846cc39792608c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:09:47 +0000
Subject: [PATCH] ASoC: rsnd: rename INT_ENABLE to SSI_INT_ENABLE

based on datasheet

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  | 2 +-
 sound/soc/sh/rcar/rsnd.h | 2 +-
 sound/soc/sh/rcar/src.c  | 9 ++++-----
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 9dc1968..5d3592df 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -218,7 +218,7 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 		RSND_GEN_M_REG(SSI_BUSIF_ADINR,	0x4,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF_DALIGN,0x8,	0x80),
 		RSND_GEN_M_REG(SSI_CTRL,	0x10,	0x80),
-		RSND_GEN_M_REG(INT_ENABLE,	0x18,	0x80),
+		RSND_GEN_M_REG(SSI_INT_ENABLE,	0x18,	0x80),
 	};
 	struct rsnd_regmap_field_conf conf_scu[] = {
 		RSND_GEN_M_REG(SRC_BUSIF_MODE,	0x0,	0x20),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index f49b0cb..9ecd151 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -119,7 +119,7 @@ enum rsnd_reg {
 #define RSND_REG_SSI_CTRL		RSND_REG_SHARE02
 #define RSND_REG_SSI_BUSIF_MODE		RSND_REG_SHARE03
 #define RSND_REG_SSI_BUSIF_ADINR	RSND_REG_SHARE04
-#define RSND_REG_INT_ENABLE		RSND_REG_SHARE05
+#define RSND_REG_SSI_INT_ENABLE		RSND_REG_SHARE05
 #define RSND_REG_SRC_BSDSR		RSND_REG_SHARE06
 #define RSND_REG_SRC_BSISR		RSND_REG_SHARE07
 #define RSND_REG_DIV_EN			RSND_REG_SHARE08
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 3f6f4df..9e11f73 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -215,10 +215,9 @@ int rsnd_src_ssi_irq_enable(struct rsnd_mod *ssi_mod)
 		return 0;
 
 	/* enable SSI interrupt if Gen2 */
-	if (rsnd_ssi_is_dma_mode(ssi_mod))
-		rsnd_mod_write(ssi_mod, INT_ENABLE, 0x0e000000);
-	else
-		rsnd_mod_write(ssi_mod, INT_ENABLE, 0x0f000000);
+	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE,
+		       rsnd_ssi_is_dma_mode(ssi_mod) ?
+		       0x0e000000 : 0x0f000000);
 
 	return 0;
 }
@@ -231,7 +230,7 @@ int rsnd_src_ssi_irq_disable(struct rsnd_mod *ssi_mod)
 		return 0;
 
 	/* disable SSI interrupt if Gen2 */
-	rsnd_mod_write(ssi_mod, INT_ENABLE, 0x00000000);
+	rsnd_mod_write(ssi_mod, SSI_INT_ENABLE, 0x00000000);
 
 	return 0;
 }
-- 
2.1.4
