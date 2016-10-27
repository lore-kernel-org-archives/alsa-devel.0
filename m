From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_reg cleanup for SSIU" to the
	asoc tree
Date: Thu, 27 Oct 2016 17:47:39 +0100
Message-ID: <E1bznq7-0007iu-GO@debutante>
References: <87twbzwxnv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D9C422669A9
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:45 +0200 (CEST)
In-Reply-To: <87twbzwxnv.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rsnd_reg cleanup for SSIU

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

>From bb7927c793e1036bc15f67a8fd10e803f56c6760 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Oct 2016 04:28:06 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_reg cleanup for SSIU

R-Car Gen1 didn't have SSIU IP, and it was part of SRU.
In Gen2, SSIU was created and it has original register.
Let's cleanup rsnd_reg for SSIU, because this driver
doesn't support Gen1 SRU any more.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/rsnd.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index ff8c03601810..678a9914c96f 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -43,17 +43,7 @@
  * see gen1/gen2 for detail
  */
 enum rsnd_reg {
-	/* SCU (SRC/SSIU/MIX/CTU/DVC) */
-	RSND_REG_SSI_MODE,
-	RSND_REG_SSI_MODE0,
-	RSND_REG_SSI_MODE1,
-	RSND_REG_SSI_MODE2,
-	RSND_REG_SSI_CONTROL,
-	RSND_REG_SSI_CTRL,
-	RSND_REG_SSI_BUSIF_MODE,
-	RSND_REG_SSI_BUSIF_ADINR,
-	RSND_REG_SSI_BUSIF_DALIGN,
-	RSND_REG_SSI_INT_ENABLE,
+	/* SCU (MIX/CTU/DVC) */
 	RSND_REG_SRC_I_BUSIF_MODE,
 	RSND_REG_SRC_O_BUSIF_MODE,
 	RSND_REG_SRC_ROUTE_MODE0,
@@ -160,6 +150,18 @@ enum rsnd_reg {
 	RSND_REG_AUDIO_CLK_SEL1,
 	RSND_REG_AUDIO_CLK_SEL2,
 
+	/* SSIU */
+	RSND_REG_SSI_MODE,
+	RSND_REG_SSI_MODE0,
+	RSND_REG_SSI_MODE1,
+	RSND_REG_SSI_MODE2,
+	RSND_REG_SSI_CONTROL,
+	RSND_REG_SSI_CTRL,
+	RSND_REG_SSI_BUSIF_MODE,
+	RSND_REG_SSI_BUSIF_ADINR,
+	RSND_REG_SSI_BUSIF_DALIGN,
+	RSND_REG_SSI_INT_ENABLE,
+
 	/* SSI */
 	RSND_REG_SSICR,
 	RSND_REG_SSISR,
-- 
2.8.1
