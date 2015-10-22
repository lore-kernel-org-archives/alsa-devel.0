From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup print debug message after
	read" to the asoc tree
Date: Fri, 23 Oct 2015 08:10:13 +0900
Message-ID: <E1ZpOzt-000086-Lx@finisterre>
References: <8737x3txbg.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E2B71266B3C
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:10:25 +0200 (CEST)
In-Reply-To: <8737x3txbg.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup print debug message after read

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

>From c9b9638f617871aa83c197eed8f068294c843b69 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:13:06 +0000
Subject: [PATCH] ASoC: rsnd: fixup print debug message after read

debug meesage for rsnd_mod_read() should be prints after read

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index f04d17b..0c69f83 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -79,11 +79,11 @@ u32 rsnd_read(struct rsnd_priv *priv,
 	if (!rsnd_is_accessible_reg(priv, gen, reg))
 		return 0;
 
+	regmap_fields_read(gen->regs[reg], rsnd_mod_id(mod), &val);
+
 	dev_dbg(dev, "r %s[%d] - %4d : %08x\n",
 		rsnd_mod_name(mod), rsnd_mod_id(mod), reg, val);
 
-	regmap_fields_read(gen->regs[reg], rsnd_mod_id(mod), &val);
-
 	return val;
 }
 
-- 
2.6.1
