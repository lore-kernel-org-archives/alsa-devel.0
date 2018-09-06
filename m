From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: gen: use tab instead of
	white-space" to the asoc tree
Date: Thu,  6 Sep 2018 11:44:45 +0100 (BST)
Message-ID: <20180906104445.5411D1122A1F@debutante.sirena.org.uk>
References: <871sa7b9me.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E87CA26779A
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:44:45 +0200 (CEST)
In-Reply-To: <871sa7b9me.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: gen: use tab instead of white-space

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 501683d0cd54714de78501efe945bbe4356b922b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Sep 2018 03:21:16 +0000
Subject: [PATCH] ASoC: rsnd: gen: use tab instead of white-space

commit 8c9d75033340 ("ASoC: rsnd: ssiu: Support BUSIF
other than BUSIF0") added new SSIU registers.
But it is using white-space for it.
This patch fixup it to use tab.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 3032869a7f26..1f7881cc16b2 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -222,30 +222,30 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_M_REG(SSI_BUSIF0_MODE,		0x0,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF0_ADINR,	0x4,	0x80),
 		RSND_GEN_M_REG(SSI_BUSIF0_DALIGN,	0x8,	0x80),
-		RSND_GEN_M_REG(SSI_BUSIF1_MODE,         0x20,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF1_ADINR,        0x24,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF1_DALIGN,       0x28,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF2_MODE,         0x40,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF2_ADINR,        0x44,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF2_DALIGN,       0x48,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF3_MODE,         0x60,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF3_ADINR,        0x64,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF3_DALIGN,       0x68,   0x80),
-		RSND_GEN_M_REG(SSI_BUSIF4_MODE,         0x500,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF4_ADINR,        0x504,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF4_DALIGN,       0x508,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF5_MODE,         0x520,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF5_ADINR,        0x524,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF5_DALIGN,       0x528,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF6_MODE,         0x540,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF6_ADINR,        0x544,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF6_DALIGN,       0x548,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF7_MODE,         0x560,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF7_ADINR,        0x564,  0x80),
-		RSND_GEN_M_REG(SSI_BUSIF7_DALIGN,       0x568,  0x80),
-		RSND_GEN_M_REG(SSI_MODE,	0xc,	0x80),
-		RSND_GEN_M_REG(SSI_CTRL,	0x10,	0x80),
-		RSND_GEN_M_REG(SSI_INT_ENABLE,	0x18,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF1_MODE,		0x20,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF1_ADINR,	0x24,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF1_DALIGN,	0x28,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF2_MODE,		0x40,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF2_ADINR,	0x44,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF2_DALIGN,	0x48,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF3_MODE,		0x60,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF3_ADINR,	0x64,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF3_DALIGN,	0x68,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF4_MODE,		0x500,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF4_ADINR,	0x504,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF4_DALIGN,	0x508,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF5_MODE,		0x520,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF5_ADINR,	0x524,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF5_DALIGN,	0x528,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF6_MODE,		0x540,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF6_ADINR,	0x544,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF6_DALIGN,	0x548,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF7_MODE,		0x560,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF7_ADINR,	0x564,	0x80),
+		RSND_GEN_M_REG(SSI_BUSIF7_DALIGN,	0x568,	0x80),
+		RSND_GEN_M_REG(SSI_MODE,		0xc,	0x80),
+		RSND_GEN_M_REG(SSI_CTRL,		0x10,	0x80),
+		RSND_GEN_M_REG(SSI_INT_ENABLE,		0x18,	0x80),
 	};
 
 	static const struct rsnd_regmap_field_conf conf_scu[] = {
-- 
2.19.0.rc1
