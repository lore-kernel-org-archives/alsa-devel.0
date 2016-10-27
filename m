From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove "Gen2 only" comment" to
	the asoc tree
Date: Thu, 27 Oct 2016 17:47:42 +0100
Message-ID: <E1bznqA-0007jg-Ja@debutante>
References: <87vawfwxp3.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 063052669A9
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:50 +0200 (CEST)
In-Reply-To: <87vawfwxp3.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove "Gen2 only" comment

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

>From f0b20e7120849ea68b2d7f0ec36ea45643265b09 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Oct 2016 04:27:22 +0000
Subject: [PATCH] ASoC: rsnd: remove "Gen2 only" comment

Gen1 support had been removed. "Gen2 only" comment is
no longer needed.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 62 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 422b5344b687..ff8c03601810 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -44,16 +44,16 @@
  */
 enum rsnd_reg {
 	/* SCU (SRC/SSIU/MIX/CTU/DVC) */
-	RSND_REG_SSI_MODE,		/* Gen2 only */
+	RSND_REG_SSI_MODE,
 	RSND_REG_SSI_MODE0,
 	RSND_REG_SSI_MODE1,
 	RSND_REG_SSI_MODE2,
 	RSND_REG_SSI_CONTROL,
-	RSND_REG_SSI_CTRL,		/* Gen2 only */
-	RSND_REG_SSI_BUSIF_MODE,	/* Gen2 only */
-	RSND_REG_SSI_BUSIF_ADINR,	/* Gen2 only */
-	RSND_REG_SSI_BUSIF_DALIGN,	/* Gen2 only */
-	RSND_REG_SSI_INT_ENABLE,	/* Gen2 only */
+	RSND_REG_SSI_CTRL,
+	RSND_REG_SSI_BUSIF_MODE,
+	RSND_REG_SSI_BUSIF_ADINR,
+	RSND_REG_SSI_BUSIF_DALIGN,
+	RSND_REG_SSI_INT_ENABLE,
 	RSND_REG_SRC_I_BUSIF_MODE,
 	RSND_REG_SRC_O_BUSIF_MODE,
 	RSND_REG_SRC_ROUTE_MODE0,
@@ -63,29 +63,29 @@ enum rsnd_reg {
 	RSND_REG_SRC_IFSCR,
 	RSND_REG_SRC_IFSVR,
 	RSND_REG_SRC_SRCCR,
-	RSND_REG_SRC_CTRL,		/* Gen2 only */
-	RSND_REG_SRC_BSDSR,		/* Gen2 only */
-	RSND_REG_SRC_BSISR,		/* Gen2 only */
-	RSND_REG_SRC_INT_ENABLE0,	/* Gen2 only */
-	RSND_REG_SRC_BUSIF_DALIGN,	/* Gen2 only */
-	RSND_REG_SRCIN_TIMSEL0,		/* Gen2 only */
-	RSND_REG_SRCIN_TIMSEL1,		/* Gen2 only */
-	RSND_REG_SRCIN_TIMSEL2,		/* Gen2 only */
-	RSND_REG_SRCIN_TIMSEL3,		/* Gen2 only */
-	RSND_REG_SRCIN_TIMSEL4,		/* Gen2 only */
-	RSND_REG_SRCOUT_TIMSEL0,	/* Gen2 only */
-	RSND_REG_SRCOUT_TIMSEL1,	/* Gen2 only */
-	RSND_REG_SRCOUT_TIMSEL2,	/* Gen2 only */
-	RSND_REG_SRCOUT_TIMSEL3,	/* Gen2 only */
-	RSND_REG_SRCOUT_TIMSEL4,	/* Gen2 only */
+	RSND_REG_SRC_CTRL,
+	RSND_REG_SRC_BSDSR,
+	RSND_REG_SRC_BSISR,
+	RSND_REG_SRC_INT_ENABLE0,
+	RSND_REG_SRC_BUSIF_DALIGN,
+	RSND_REG_SRCIN_TIMSEL0,
+	RSND_REG_SRCIN_TIMSEL1,
+	RSND_REG_SRCIN_TIMSEL2,
+	RSND_REG_SRCIN_TIMSEL3,
+	RSND_REG_SRCIN_TIMSEL4,
+	RSND_REG_SRCOUT_TIMSEL0,
+	RSND_REG_SRCOUT_TIMSEL1,
+	RSND_REG_SRCOUT_TIMSEL2,
+	RSND_REG_SRCOUT_TIMSEL3,
+	RSND_REG_SRCOUT_TIMSEL4,
 	RSND_REG_SCU_SYS_STATUS0,
-	RSND_REG_SCU_SYS_STATUS1,	/* Gen2 only */
+	RSND_REG_SCU_SYS_STATUS1,
 	RSND_REG_SCU_SYS_INT_EN0,
-	RSND_REG_SCU_SYS_INT_EN1,	/* Gen2 only */
-	RSND_REG_CMD_CTRL,		/* Gen2 only */
-	RSND_REG_CMD_BUSIF_DALIGN,	/* Gen2 only */
+	RSND_REG_SCU_SYS_INT_EN1,
+	RSND_REG_CMD_CTRL,
+	RSND_REG_CMD_BUSIF_DALIGN,
 	RSND_REG_CMD_ROUTE_SLCT,
-	RSND_REG_CMDOUT_TIMSEL,		/* Gen2 only */
+	RSND_REG_CMDOUT_TIMSEL,
 	RSND_REG_CTU_SWRSR,
 	RSND_REG_CTU_CTUIR,
 	RSND_REG_CTU_ADINR,
@@ -147,18 +147,18 @@ enum rsnd_reg {
 	RSND_REG_DVC_VOL6R,
 	RSND_REG_DVC_VOL7R,
 	RSND_REG_DVC_DVUER,
-	RSND_REG_DVC_VRCTR,		/* Gen2 only */
-	RSND_REG_DVC_VRPDR,		/* Gen2 only */
-	RSND_REG_DVC_VRDBR,		/* Gen2 only */
+	RSND_REG_DVC_VRCTR,
+	RSND_REG_DVC_VRPDR,
+	RSND_REG_DVC_VRDBR,
 
 	/* ADG */
 	RSND_REG_BRRA,
 	RSND_REG_BRRB,
 	RSND_REG_SSICKR,
-	RSND_REG_DIV_EN,		/* Gen2 only */
+	RSND_REG_DIV_EN,
 	RSND_REG_AUDIO_CLK_SEL0,
 	RSND_REG_AUDIO_CLK_SEL1,
-	RSND_REG_AUDIO_CLK_SEL2,	/* Gen2 only */
+	RSND_REG_AUDIO_CLK_SEL2,
 
 	/* SSI */
 	RSND_REG_SSICR,
-- 
2.8.1
