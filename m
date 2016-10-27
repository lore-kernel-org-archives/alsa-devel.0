From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: clear SSI_SYS_STATUSx every time"
	to the asoc tree
Date: Thu, 27 Oct 2016 17:47:33 +0100
Message-ID: <E1bznq1-0007hI-9b@debutante>
References: <87r373wxlp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B267D2669A9
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 18:47:39 +0200 (CEST)
In-Reply-To: <87r373wxlp.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: clear SSI_SYS_STATUSx every time

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

>From 814efe3ed72d1cad926e21b8d0869a1ea74bb9dd Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Oct 2016 04:29:21 +0000
Subject: [PATCH] ASoC: rsnd: clear SSI_SYS_STATUSx every time

Renesas sound SSIU has SSI_SYS_STATUS register whick will
be changed if over/under run was occurred.
Current rsnd driver is handling over/under run error on SSI/SRC,
but doesn't on SSIU.
HW guys can't guarantee correct behavior if it already had error bit
on status register when it start.
Thus, it should be cleared every start timing. This patch do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/gen.c  |  8 ++++++++
 sound/soc/sh/rcar/rsnd.h |  8 ++++++++
 sound/soc/sh/rcar/ssiu.c | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 7d2fdf8dd188..d653cf488f73 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -211,6 +211,14 @@ static int rsnd_gen2_probe(struct rsnd_priv *priv)
 		RSND_GEN_S_REG(SSI_MODE1,	0x804),
 		RSND_GEN_S_REG(SSI_MODE2,	0x808),
 		RSND_GEN_S_REG(SSI_CONTROL,	0x810),
+		RSND_GEN_S_REG(SSI_SYS_STATUS0,	0x840),
+		RSND_GEN_S_REG(SSI_SYS_STATUS1,	0x844),
+		RSND_GEN_S_REG(SSI_SYS_STATUS2,	0x848),
+		RSND_GEN_S_REG(SSI_SYS_STATUS3,	0x84c),
+		RSND_GEN_S_REG(SSI_SYS_STATUS4,	0x880),
+		RSND_GEN_S_REG(SSI_SYS_STATUS5,	0x884),
+		RSND_GEN_S_REG(SSI_SYS_STATUS6,	0x888),
+		RSND_GEN_S_REG(SSI_SYS_STATUS7,	0x88c),
 
 		/* FIXME: it needs SSI_MODE2/3 in the future */
 		RSND_GEN_M_REG(SSI_BUSIF_MODE,	0x0,	0x80),
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 678a9914c96f..d6bb53009123 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -161,6 +161,14 @@ enum rsnd_reg {
 	RSND_REG_SSI_BUSIF_ADINR,
 	RSND_REG_SSI_BUSIF_DALIGN,
 	RSND_REG_SSI_INT_ENABLE,
+	RSND_REG_SSI_SYS_STATUS0,
+	RSND_REG_SSI_SYS_STATUS1,
+	RSND_REG_SSI_SYS_STATUS2,
+	RSND_REG_SSI_SYS_STATUS3,
+	RSND_REG_SSI_SYS_STATUS4,
+	RSND_REG_SSI_SYS_STATUS5,
+	RSND_REG_SSI_SYS_STATUS6,
+	RSND_REG_SSI_SYS_STATUS7,
 
 	/* SSI */
 	RSND_REG_SSICR,
diff --git a/sound/soc/sh/rcar/ssiu.c b/sound/soc/sh/rcar/ssiu.c
index 6f9b388ec5a8..4e817c8a18c0 100644
--- a/sound/soc/sh/rcar/ssiu.c
+++ b/sound/soc/sh/rcar/ssiu.c
@@ -33,6 +33,26 @@ static int rsnd_ssiu_init(struct rsnd_mod *mod,
 	u32 mask1, val1;
 	u32 mask2, val2;
 
+	/* clear status */
+	switch (id) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+	case 4:
+		rsnd_mod_write(mod, SSI_SYS_STATUS0, 0xf << (id * 4));
+		rsnd_mod_write(mod, SSI_SYS_STATUS2, 0xf << (id * 4));
+		rsnd_mod_write(mod, SSI_SYS_STATUS4, 0xf << (id * 4));
+		rsnd_mod_write(mod, SSI_SYS_STATUS6, 0xf << (id * 4));
+		break;
+	case 9:
+		rsnd_mod_write(mod, SSI_SYS_STATUS1, 0xf << 4);
+		rsnd_mod_write(mod, SSI_SYS_STATUS3, 0xf << 4);
+		rsnd_mod_write(mod, SSI_SYS_STATUS5, 0xf << 4);
+		rsnd_mod_write(mod, SSI_SYS_STATUS7, 0xf << 4);
+		break;
+	}
+
 	/*
 	 * SSI_MODE0
 	 */
-- 
2.8.1
