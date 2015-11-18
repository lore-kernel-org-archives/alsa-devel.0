From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: cleanup RSND_REG_xxx" to the asoc
	tree
Date: Wed, 18 Nov 2015 18:09:42 +0000
Message-ID: <E1Zz7As-0000KI-Pg@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 486B6265B90
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 19:09:47 +0100 (CET)
In-Reply-To: 
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

   ASoC: rsnd: cleanup RSND_REG_xxx

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

>From d444080ef824bf45ead732f2c68cfeb5885bc53a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Nov 2015 05:10:18 +0000
Subject: [PATCH] ASoC: rsnd: cleanup RSND_REG_xxx

SRC Gen1 support was removed. Current rsnd driver is sharing Gen1/Gen2
register index to reduce memory, but there is no effect anymore.
Let's remove share definition and merge RSND_REG_xxx

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 93 ++++++++++++++++--------------------------------
 1 file changed, 30 insertions(+), 63 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index da671869f12a..a3e42a4f4b19 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -34,9 +34,14 @@
  * see gen1/gen2 for detail
  */
 enum rsnd_reg {
-	/* SRU/SCU/SSIU */
+	/* SCU (SRC/SSIU/MIX/CTU/DVC) */
 	RSND_REG_SSI_MODE0,
 	RSND_REG_SSI_MODE1,
+	RSND_REG_SSI_CTRL,		/* Gen2 only */
+	RSND_REG_SSI_BUSIF_MODE,	/* Gen2 only */
+	RSND_REG_SSI_BUSIF_ADINR,	/* Gen2 only */
+	RSND_REG_SSI_BUSIF_DALIGN,	/* Gen2 only */
+	RSND_REG_SSI_INT_ENABLE,	/* Gen2 only */
 	RSND_REG_SRC_BUSIF_MODE,
 	RSND_REG_SRC_ROUTE_MODE0,
 	RSND_REG_SRC_SWRSR,
@@ -45,9 +50,28 @@ enum rsnd_reg {
 	RSND_REG_SRC_IFSCR,
 	RSND_REG_SRC_IFSVR,
 	RSND_REG_SRC_SRCCR,
+	RSND_REG_SRC_CTRL,		/* Gen2 only */
+	RSND_REG_SRC_BSDSR,		/* Gen2 only */
+	RSND_REG_SRC_BSISR,		/* Gen2 only */
+	RSND_REG_SRC_INT_ENABLE0,	/* Gen2 only */
+	RSND_REG_SRC_BUSIF_DALIGN,	/* Gen2 only */
+	RSND_REG_SRCIN_TIMSEL0,		/* Gen2 only */
+	RSND_REG_SRCIN_TIMSEL1,		/* Gen2 only */
+	RSND_REG_SRCIN_TIMSEL2,		/* Gen2 only */
+	RSND_REG_SRCIN_TIMSEL3,		/* Gen2 only */
+	RSND_REG_SRCIN_TIMSEL4,		/* Gen2 only */
+	RSND_REG_SRCOUT_TIMSEL0,	/* Gen2 only */
+	RSND_REG_SRCOUT_TIMSEL1,	/* Gen2 only */
+	RSND_REG_SRCOUT_TIMSEL2,	/* Gen2 only */
+	RSND_REG_SRCOUT_TIMSEL3,	/* Gen2 only */
+	RSND_REG_SRCOUT_TIMSEL4,	/* Gen2 only */
 	RSND_REG_SCU_SYS_STATUS0,
+	RSND_REG_SCU_SYS_STATUS1,	/* Gen2 only */
 	RSND_REG_SCU_SYS_INT_EN0,
+	RSND_REG_SCU_SYS_INT_EN1,	/* Gen2 only */
+	RSND_REG_CMD_CTRL,		/* Gen2 only */
 	RSND_REG_CMD_ROUTE_SLCT,
+	RSND_REG_CMDOUT_TIMSEL,		/* Gen2 only */
 	RSND_REG_CTU_CTUIR,
 	RSND_REG_CTU_ADINR,
 	RSND_REG_MIX_SWRSR,
@@ -68,13 +92,18 @@ enum rsnd_reg {
 	RSND_REG_DVC_VOL0R,
 	RSND_REG_DVC_VOL1R,
 	RSND_REG_DVC_DVUER,
+	RSND_REG_DVC_VRCTR,		/* Gen2 only */
+	RSND_REG_DVC_VRPDR,		/* Gen2 only */
+	RSND_REG_DVC_VRDBR,		/* Gen2 only */
 
 	/* ADG */
 	RSND_REG_BRRA,
 	RSND_REG_BRRB,
 	RSND_REG_SSICKR,
+	RSND_REG_DIV_EN,		/* Gen2 only */
 	RSND_REG_AUDIO_CLK_SEL0,
 	RSND_REG_AUDIO_CLK_SEL1,
+	RSND_REG_AUDIO_CLK_SEL2,	/* Gen2 only */
 
 	/* SSI */
 	RSND_REG_SSICR,
@@ -83,71 +112,9 @@ enum rsnd_reg {
 	RSND_REG_SSIRDR,
 	RSND_REG_SSIWSR,
 
-	/* SHARE see below */
-	RSND_REG_SHARE01,
-	RSND_REG_SHARE02,
-	RSND_REG_SHARE03,
-	RSND_REG_SHARE04,
-	RSND_REG_SHARE05,
-	RSND_REG_SHARE06,
-	RSND_REG_SHARE07,
-	RSND_REG_SHARE08,
-	RSND_REG_SHARE09,
-	RSND_REG_SHARE10,
-	RSND_REG_SHARE11,
-	RSND_REG_SHARE12,
-	RSND_REG_SHARE13,
-	RSND_REG_SHARE14,
-	RSND_REG_SHARE15,
-	RSND_REG_SHARE16,
-	RSND_REG_SHARE17,
-	RSND_REG_SHARE18,
-	RSND_REG_SHARE19,
-	RSND_REG_SHARE20,
-	RSND_REG_SHARE21,
-	RSND_REG_SHARE22,
-	RSND_REG_SHARE23,
-	RSND_REG_SHARE24,
-	RSND_REG_SHARE25,
-	RSND_REG_SHARE26,
-	RSND_REG_SHARE27,
-	RSND_REG_SHARE28,
-	RSND_REG_SHARE29,
-
 	RSND_REG_MAX,
 };
 
-/* Gen2 only */
-#define RSND_REG_SRC_CTRL		RSND_REG_SHARE01
-#define RSND_REG_SSI_CTRL		RSND_REG_SHARE02
-#define RSND_REG_SSI_BUSIF_MODE		RSND_REG_SHARE03
-#define RSND_REG_SSI_BUSIF_ADINR	RSND_REG_SHARE04
-#define RSND_REG_SSI_INT_ENABLE		RSND_REG_SHARE05
-#define RSND_REG_SRC_BSDSR		RSND_REG_SHARE06
-#define RSND_REG_SRC_BSISR		RSND_REG_SHARE07
-#define RSND_REG_DIV_EN			RSND_REG_SHARE08
-#define RSND_REG_SRCIN_TIMSEL0		RSND_REG_SHARE09
-#define RSND_REG_SRCIN_TIMSEL1		RSND_REG_SHARE10
-#define RSND_REG_SRCIN_TIMSEL2		RSND_REG_SHARE11
-#define RSND_REG_SRCIN_TIMSEL3		RSND_REG_SHARE12
-#define RSND_REG_SRCIN_TIMSEL4		RSND_REG_SHARE13
-#define RSND_REG_SRCOUT_TIMSEL0		RSND_REG_SHARE14
-#define RSND_REG_SRCOUT_TIMSEL1		RSND_REG_SHARE15
-#define RSND_REG_SRCOUT_TIMSEL2		RSND_REG_SHARE16
-#define RSND_REG_SRCOUT_TIMSEL3		RSND_REG_SHARE17
-#define RSND_REG_SRCOUT_TIMSEL4		RSND_REG_SHARE18
-#define RSND_REG_AUDIO_CLK_SEL2		RSND_REG_SHARE19
-#define RSND_REG_CMD_CTRL		RSND_REG_SHARE20
-#define RSND_REG_CMDOUT_TIMSEL		RSND_REG_SHARE21
-#define RSND_REG_SSI_BUSIF_DALIGN	RSND_REG_SHARE22
-#define RSND_REG_DVC_VRCTR		RSND_REG_SHARE23
-#define RSND_REG_DVC_VRPDR		RSND_REG_SHARE24
-#define RSND_REG_DVC_VRDBR		RSND_REG_SHARE25
-#define RSND_REG_SCU_SYS_STATUS1	RSND_REG_SHARE26
-#define RSND_REG_SCU_SYS_INT_EN1	RSND_REG_SHARE27
-#define RSND_REG_SRC_INT_ENABLE0	RSND_REG_SHARE28
-#define RSND_REG_SRC_BUSIF_DALIGN	RSND_REG_SHARE29
-
 struct rsnd_of_data;
 struct rsnd_priv;
 struct rsnd_mod;
-- 
2.6.2
