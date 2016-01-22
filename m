From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: ctu: settings matches to
	datasheet" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:40 +0000
Message-ID: <E1aMgPw-00045l-AU@debutante>
References: <878u3j4rwx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACFA3260544
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:47 +0100 (CET)
In-Reply-To: <878u3j4rwx.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: ctu: settings matches to datasheet

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

>From dc037afdbc4f285dc2f8107a0b8eaf89892e28ac Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:59:33 +0000
Subject: [PATCH] ASoC: rsnd: ctu: settings matches to datasheet

Current CTU settings was rough. This patch makes it match to datasheet.
But do nothing at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/ctu.c  | 61 ++++++++++++++++++++++++++++++++++++++----------
 sound/soc/sh/rcar/gen.c  | 34 +++++++++++++++++++++++++++
 sound/soc/sh/rcar/rsnd.h | 34 +++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rcar/ctu.c b/sound/soc/sh/rcar/ctu.c
index 7b482f36cb63..a10d0f7b73fa 100644
--- a/sound/soc/sh/rcar/ctu.c
+++ b/sound/soc/sh/rcar/ctu.c
@@ -37,13 +37,6 @@ static void rsnd_ctu_halt(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, CTU_SWRSR, 0);
 }
 
-#define rsnd_ctu_initialize_lock(mod)	__rsnd_ctu_initialize_lock(mod, 1)
-#define rsnd_ctu_initialize_unlock(mod)	__rsnd_ctu_initialize_lock(mod, 0)
-static void __rsnd_ctu_initialize_lock(struct rsnd_mod *mod, u32 enable)
-{
-	rsnd_mod_write(mod, CTU_CTUIR, enable);
-}
-
 static int rsnd_ctu_probe_(struct rsnd_mod *mod,
 			   struct rsnd_dai_stream *io,
 			   struct rsnd_priv *priv)
@@ -51,6 +44,54 @@ static int rsnd_ctu_probe_(struct rsnd_mod *mod,
 	return rsnd_cmd_attach(io, rsnd_mod_id(mod) / 4);
 }
 
+static void rsnd_ctu_value_init(struct rsnd_dai_stream *io,
+			       struct rsnd_mod *mod)
+{
+	rsnd_mod_write(mod, CTU_CTUIR, 1);
+
+	rsnd_mod_write(mod, CTU_ADINR, rsnd_get_adinr_chan(mod, io));
+
+	rsnd_mod_write(mod, CTU_CPMDR, 0);
+	rsnd_mod_write(mod, CTU_SCMDR, 0);
+	rsnd_mod_write(mod, CTU_SV00R, 0);
+	rsnd_mod_write(mod, CTU_SV01R, 0);
+	rsnd_mod_write(mod, CTU_SV02R, 0);
+	rsnd_mod_write(mod, CTU_SV03R, 0);
+	rsnd_mod_write(mod, CTU_SV04R, 0);
+	rsnd_mod_write(mod, CTU_SV05R, 0);
+	rsnd_mod_write(mod, CTU_SV06R, 0);
+	rsnd_mod_write(mod, CTU_SV07R, 0);
+
+	rsnd_mod_write(mod, CTU_SV10R, 0);
+	rsnd_mod_write(mod, CTU_SV11R, 0);
+	rsnd_mod_write(mod, CTU_SV12R, 0);
+	rsnd_mod_write(mod, CTU_SV13R, 0);
+	rsnd_mod_write(mod, CTU_SV14R, 0);
+	rsnd_mod_write(mod, CTU_SV15R, 0);
+	rsnd_mod_write(mod, CTU_SV16R, 0);
+	rsnd_mod_write(mod, CTU_SV17R, 0);
+
+	rsnd_mod_write(mod, CTU_SV20R, 0);
+	rsnd_mod_write(mod, CTU_SV21R, 0);
+	rsnd_mod_write(mod, CTU_SV22R, 0);
+	rsnd_mod_write(mod, CTU_SV23R, 0);
+	rsnd_mod_write(mod, CTU_SV24R, 0);
+	rsnd_mod_write(mod, CTU_SV25R, 0);
+	rsnd_mod_write(mod, CTU_SV26R, 0);
+	rsnd_mod_write(mod, CTU_SV27R, 0);
+
+	rsnd_mod_write(mod, CTU_SV30R, 0);
+	rsnd_mod_write(mod, CTU_SV31R, 0);
+	rsnd_mod_write(mod, CTU_SV32R, 0);
+	rsnd_mod_write(mod, CTU_SV33R, 0);
+	rsnd_mod_write(mod, CTU_SV34R, 0);
+	rsnd_mod_write(mod, CTU_SV35R, 0);
+	rsnd_mod_write(mod, CTU_SV36R, 0);
+	rsnd_mod_write(mod, CTU_SV37R, 0);
+
+	rsnd_mod_write(mod, CTU_CTUIR, 0);
+}
+
 static int rsnd_ctu_init(struct rsnd_mod *mod,
 			 struct rsnd_dai_stream *io,
 			 struct rsnd_priv *priv)
@@ -59,11 +100,7 @@ static int rsnd_ctu_init(struct rsnd_mod *mod,
 
 	rsnd_ctu_activation(mod);
 
-	rsnd_ctu_initialize_lock(mod);
-
-	rsnd_mod_write(mod, CTU_ADINR, rsnd_get_adinr_chan(mod, io));
-
-	rsnd_ctu_initialize_unlock(mod);
+	rsnd_ctu_value_init(io, mod);
 
 	return 0;
 }
diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 2f01e5eb462c..b6e487e06019 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -263,6 +263,40 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(CTU_SWRSR,	0x500,	0x100),
 		RSND_GEN_M_REG(CTU_CTUIR,	0x504,	0x100),
 		RSND_GEN_M_REG(CTU_ADINR,	0x508,	0x100),
+		RSND_GEN_M_REG(CTU_CPMDR,	0x510,	0x100),
+		RSND_GEN_M_REG(CTU_SCMDR,	0x514,	0x100),
+		RSND_GEN_M_REG(CTU_SV00R,	0x518,	0x100),
+		RSND_GEN_M_REG(CTU_SV01R,	0x51c,	0x100),
+		RSND_GEN_M_REG(CTU_SV02R,	0x520,	0x100),
+		RSND_GEN_M_REG(CTU_SV03R,	0x524,	0x100),
+		RSND_GEN_M_REG(CTU_SV04R,	0x528,	0x100),
+		RSND_GEN_M_REG(CTU_SV05R,	0x52c,	0x100),
+		RSND_GEN_M_REG(CTU_SV06R,	0x530,	0x100),
+		RSND_GEN_M_REG(CTU_SV07R,	0x534,	0x100),
+		RSND_GEN_M_REG(CTU_SV10R,	0x538,	0x100),
+		RSND_GEN_M_REG(CTU_SV11R,	0x53c,	0x100),
+		RSND_GEN_M_REG(CTU_SV12R,	0x540,	0x100),
+		RSND_GEN_M_REG(CTU_SV13R,	0x544,	0x100),
+		RSND_GEN_M_REG(CTU_SV14R,	0x548,	0x100),
+		RSND_GEN_M_REG(CTU_SV15R,	0x54c,	0x100),
+		RSND_GEN_M_REG(CTU_SV16R,	0x550,	0x100),
+		RSND_GEN_M_REG(CTU_SV17R,	0x554,	0x100),
+		RSND_GEN_M_REG(CTU_SV20R,	0x558,	0x100),
+		RSND_GEN_M_REG(CTU_SV21R,	0x55c,	0x100),
+		RSND_GEN_M_REG(CTU_SV22R,	0x560,	0x100),
+		RSND_GEN_M_REG(CTU_SV23R,	0x564,	0x100),
+		RSND_GEN_M_REG(CTU_SV24R,	0x568,	0x100),
+		RSND_GEN_M_REG(CTU_SV25R,	0x56c,	0x100),
+		RSND_GEN_M_REG(CTU_SV26R,	0x570,	0x100),
+		RSND_GEN_M_REG(CTU_SV27R,	0x574,	0x100),
+		RSND_GEN_M_REG(CTU_SV30R,	0x578,	0x100),
+		RSND_GEN_M_REG(CTU_SV31R,	0x57c,	0x100),
+		RSND_GEN_M_REG(CTU_SV32R,	0x580,	0x100),
+		RSND_GEN_M_REG(CTU_SV33R,	0x584,	0x100),
+		RSND_GEN_M_REG(CTU_SV34R,	0x588,	0x100),
+		RSND_GEN_M_REG(CTU_SV35R,	0x58c,	0x100),
+		RSND_GEN_M_REG(CTU_SV36R,	0x590,	0x100),
+		RSND_GEN_M_REG(CTU_SV37R,	0x594,	0x100),
 		RSND_GEN_M_REG(MIX_SWRSR,	0xd00,	0x40),
 		RSND_GEN_M_REG(MIX_MIXIR,	0xd04,	0x40),
 		RSND_GEN_M_REG(MIX_ADINR,	0xd08,	0x40),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 12227f6b6221..4974db6679c3 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -89,6 +89,40 @@ enum rsnd_reg {
 	RSND_REG_CTU_SWRSR,
 	RSND_REG_CTU_CTUIR,
 	RSND_REG_CTU_ADINR,
+	RSND_REG_CTU_CPMDR,
+	RSND_REG_CTU_SCMDR,
+	RSND_REG_CTU_SV00R,
+	RSND_REG_CTU_SV01R,
+	RSND_REG_CTU_SV02R,
+	RSND_REG_CTU_SV03R,
+	RSND_REG_CTU_SV04R,
+	RSND_REG_CTU_SV05R,
+	RSND_REG_CTU_SV06R,
+	RSND_REG_CTU_SV07R,
+	RSND_REG_CTU_SV10R,
+	RSND_REG_CTU_SV11R,
+	RSND_REG_CTU_SV12R,
+	RSND_REG_CTU_SV13R,
+	RSND_REG_CTU_SV14R,
+	RSND_REG_CTU_SV15R,
+	RSND_REG_CTU_SV16R,
+	RSND_REG_CTU_SV17R,
+	RSND_REG_CTU_SV20R,
+	RSND_REG_CTU_SV21R,
+	RSND_REG_CTU_SV22R,
+	RSND_REG_CTU_SV23R,
+	RSND_REG_CTU_SV24R,
+	RSND_REG_CTU_SV25R,
+	RSND_REG_CTU_SV26R,
+	RSND_REG_CTU_SV27R,
+	RSND_REG_CTU_SV30R,
+	RSND_REG_CTU_SV31R,
+	RSND_REG_CTU_SV32R,
+	RSND_REG_CTU_SV33R,
+	RSND_REG_CTU_SV34R,
+	RSND_REG_CTU_SV35R,
+	RSND_REG_CTU_SV36R,
+	RSND_REG_CTU_SV37R,
 	RSND_REG_MIX_SWRSR,
 	RSND_REG_MIX_MIXIR,
 	RSND_REG_MIX_ADINR,
-- 
2.7.0.rc3
