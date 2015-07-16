From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rename BUSIF_DALIGN to
	SSI_BUSIF_DALIGN" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:40 +0100
Message-ID: <E1ZFqRQ-0002pK-LI@finisterre>
References: <874ml5x5l5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CA720266843
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:45 +0200 (CEST)
In-Reply-To: <874ml5x5l5.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rename BUSIF_DALIGN to SSI_BUSIF_DALIGN

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

>From cdde84d10d3cb4d35051bc5fdb268f6faf33d1c8 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:09:27 +0000
Subject: [PATCH] ASoC: rsnd: rename BUSIF_DALIGN to SSI_BUSIF_DALIGN

based on datasheet

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  | 2 +-
 sound/soc/sh/rcar/rsnd.h | 2 +-
 sound/soc/sh/rcar/src.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 48f704b..9dc1968 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -216,7 +216,7 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 		/* FIXME: it needs SSI_MODE2/3 in the future */
 		RSND_GEN_M_REG(SSI_BUSIF_MODE,	0x0,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF_ADINR,	0x4,	0x80),
-		RSND_GEN_M_REG(BUSIF_DALIGN,	0x8,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF_DALIGN,0x8,	0x80),
 		RSND_GEN_M_REG(SSI_CTRL,	0x10,	0x80),
 		RSND_GEN_M_REG(INT_ENABLE,	0x18,	0x80),
 	};
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index f729646..f49b0cb 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -136,7 +136,7 @@ enum rsnd_reg {
 #define RSND_REG_AUDIO_CLK_SEL2		RSND_REG_SHARE19
 #define RSND_REG_CMD_CTRL		RSND_REG_SHARE20
 #define RSND_REG_CMDOUT_TIMSEL		RSND_REG_SHARE21
-#define RSND_REG_BUSIF_DALIGN		RSND_REG_SHARE22
+#define RSND_REG_SSI_BUSIF_DALIGN	RSND_REG_SHARE22
 #define RSND_REG_DVC_VRCTR		RSND_REG_SHARE23
 #define RSND_REG_DVC_VRPDR		RSND_REG_SHARE24
 #define RSND_REG_DVC_VRDBR		RSND_REG_SHARE25
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 37927ca..3f6f4df 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -189,7 +189,7 @@ int rsnd_src_ssiu_start(struct rsnd_mod *ssi_mod,
 			val |= 0x76543210 & ~mask;
 			break;
 		}
-		rsnd_mod_write(ssi_mod, BUSIF_DALIGN, val);
+		rsnd_mod_write(ssi_mod, SSI_BUSIF_DALIGN, val);
 
 	}
 
-- 
2.1.4
