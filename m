From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ctu: add rsnd_mix_activation()"
	to the asoc tree
Date: Fri, 22 Jan 2016 18:26:42 +0000
Message-ID: <E1aMgPy-00046h-5G@debutante>
References: <87bn8f4ry2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF9732605B0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:47 +0100 (CET)
In-Reply-To: <87bn8f4ry2.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: ctu: add rsnd_mix_activation()

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

>From bd9a603fe78fa838a9c884b1e67749120a45508c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:58:53 +0000
Subject: [PATCH] ASoC: rsnd: ctu: add rsnd_mix_activation()

Based on datasheet

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c  | 9 +++++++++
 sound/soc/sh/rcar/gen.c  | 1 +
 sound/soc/sh/rcar/rsnd.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 109930a20401..0dc451803eb6 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -24,6 +24,13 @@ struct rsnd_ctu {
 	     i++)
 
 #define rsnd_ctu_get(priv, id) ((struct rsnd_ctu *)(priv->ctu) + id)
+
+static void rsnd_ctu_activation(struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, CTU_SWRSR, 0);
+	rsnd_mod_write(mod, CTU_SWRSR, 1);
+}
+
 #define rsnd_ctu_initialize_lock(mod)	__rsnd_ctu_initialize_lock(mod, 1)
 #define rsnd_ctu_initialize_unlock(mod)	__rsnd_ctu_initialize_lock(mod, 0)
 static void __rsnd_ctu_initialize_lock(struct rsnd_mod *mod, u32 enable)
@@ -44,6 +51,8 @@ static int rsnd_ctu_init(struct rsnd_mod *mod,
 {
 	rsnd_mod_power_on(mod);
 
+	rsnd_ctu_activation(mod);
+
 	rsnd_ctu_initialize_lock(mod);
 
 	rsnd_mod_write(mod, CTU_ADINR, rsnd_get_adinr_chan(mod, io));
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index c7aee9e59e86..2f01e5eb462c 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -260,6 +260,7 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SRC_SRCCR,	0x224,	0x40),
 		RSND_GEN_M_REG(SRC_BSDSR,	0x22c,	0x40),
 		RSND_GEN_M_REG(SRC_BSISR,	0x238,	0x40),
+		RSND_GEN_M_REG(CTU_SWRSR,	0x500,	0x100),
 		RSND_GEN_M_REG(CTU_CTUIR,	0x504,	0x100),
 		RSND_GEN_M_REG(CTU_ADINR,	0x508,	0x100),
 		RSND_GEN_M_REG(MIX_SWRSR,	0xd00,	0x40),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 90c732e265a2..12227f6b6221 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -86,6 +86,7 @@ enum rsnd_reg {
 	RSND_REG_CMD_BUSIF_DALIGN,	/* Gen2 only */
 	RSND_REG_CMD_ROUTE_SLCT,
 	RSND_REG_CMDOUT_TIMSEL,		/* Gen2 only */
+	RSND_REG_CTU_SWRSR,
 	RSND_REG_CTU_CTUIR,
 	RSND_REG_CTU_ADINR,
 	RSND_REG_MIX_SWRSR,
-- 
2.7.0.rc3
