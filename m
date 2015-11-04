From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: DVC settings matches to
	datasheet" to the asoc tree
Date: Wed, 04 Nov 2015 14:53:10 +0000
Message-ID: <E1ZtzR0-0002zh-7F@finisterre>
References: <87egg6w44g.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CA4A2657FE
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:53:22 +0100 (CET)
In-Reply-To: <87egg6w44g.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: DVC settings matches to datasheet

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

>From ee461716b5fff232e880be0f40270de9cf7245bf Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 4 Nov 2015 08:44:12 +0000
Subject: [PATCH] ASoC: rsnd: DVC settings matches to datasheet

Current DVC settings order was rough.
This patch makes it match to datasheet.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/dvc.c | 119 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 42 deletions(-)

diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 651c057..0dc8a2a 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -70,65 +70,105 @@ static void rsnd_dvc_soft_reset(struct rsnd_mod *mod)
 	rsnd_mod_write(mod, DVC_SWRSR, 1);
 }
 
-#define rsnd_dvc_initialize_lock(mod)	__rsnd_dvc_initialize_lock(mod, 1)
-#define rsnd_dvc_initialize_unlock(mod)	__rsnd_dvc_initialize_lock(mod, 0)
-static void __rsnd_dvc_initialize_lock(struct rsnd_mod *mod, u32 enable)
-{
-	rsnd_mod_write(mod, DVC_DVUIR, enable);
-}
+#define rsnd_dvc_get_vrpdr(dvc) (dvc->rup.val << 8 | dvc->rdown.val)
+#define rsnd_dvc_get_vrdbr(dvc) (0x3ff - (dvc->volume.val[0] >> 13))
 
-static void rsnd_dvc_volume_update(struct rsnd_dai_stream *io,
-				   struct rsnd_mod *mod)
+static void rsnd_dvc_volume_parameter(struct rsnd_dai_stream *io,
+					      struct rsnd_mod *mod)
 {
 	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
 	u32 val[RSND_DVC_CHANNELS];
-	u32 dvucr = 0;
-	u32 mute = 0;
 	int i;
 
-	for (i = 0; i < dvc->mute.cfg.size; i++)
-		mute |= (!!dvc->mute.cfg.val[i]) << i;
+	/* Enable Ramp */
+	if (dvc->ren.val)
+		for (i = 0; i < RSND_DVC_CHANNELS; i++)
+			val[i] = dvc->volume.cfg.max;
+	else
+		for (i = 0; i < RSND_DVC_CHANNELS; i++)
+			val[i] = dvc->volume.val[i];
 
-	/* Disable DVC Register access */
-	rsnd_mod_write(mod, DVC_DVUER, 0);
+	/* Enable Digital Volume */
+	rsnd_mod_write(mod, DVC_VOL0R, val[0]);
+	rsnd_mod_write(mod, DVC_VOL1R, val[1]);
+}
+
+static void rsnd_dvc_volume_init(struct rsnd_dai_stream *io,
+				 struct rsnd_mod *mod)
+{
+	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
+	u32 dvucr = 0;
+	u32 vrctr = 0;
+	u32 vrpdr = 0;
+	u32 vrdbr = 0;
+
+	/* Enable Digital Volume, Zero Cross Mute Mode */
+	dvucr |= 0x101;
 
 	/* Enable Ramp */
 	if (dvc->ren.val) {
 		dvucr |= 0x10;
 
-		/* Digital Volume Max */
-		for (i = 0; i < RSND_DVC_CHANNELS; i++)
-			val[i] = dvc->volume.cfg.max;
-
-		rsnd_mod_write(mod, DVC_VRCTR, 0xff);
-		rsnd_mod_write(mod, DVC_VRPDR, dvc->rup.val << 8 |
-					       dvc->rdown.val);
 		/*
 		 * FIXME !!
 		 * use scale-downed Digital Volume
 		 * as Volume Ramp
 		 * 7F FFFF -> 3FF
 		 */
-		rsnd_mod_write(mod, DVC_VRDBR,
-			       0x3ff - (dvc->volume.val[0] >> 13));
-
-	} else {
-		for (i = 0; i < RSND_DVC_CHANNELS; i++)
-			val[i] = dvc->volume.val[i];
+		vrctr = 0xff;
+		vrpdr = rsnd_dvc_get_vrpdr(dvc);
+		vrdbr = rsnd_dvc_get_vrdbr(dvc);
 	}
 
-	/* Enable Digital Volume */
-	dvucr |= 0x100;
-	rsnd_mod_write(mod, DVC_VOL0R, val[0]);
-	rsnd_mod_write(mod, DVC_VOL1R, val[1]);
+	/* Initialize operation */
+	rsnd_mod_write(mod, DVC_DVUIR, 1);
+
+	/* General Information */
+	rsnd_mod_write(mod, DVC_ADINR, rsnd_get_adinr_bit(mod, io));
+	rsnd_mod_write(mod, DVC_DVUCR, dvucr);
+
+	/* Volume Ramp Parameter */
+	rsnd_mod_write(mod, DVC_VRCTR, vrctr);
+	rsnd_mod_write(mod, DVC_VRPDR, vrpdr);
+	rsnd_mod_write(mod, DVC_VRDBR, vrdbr);
+
+	/* Digital Volume Function Parameter */
+	rsnd_dvc_volume_parameter(io, mod);
+
+	/* cancel operation */
+	rsnd_mod_write(mod, DVC_DVUIR, 0);
+}
+
+static void rsnd_dvc_volume_update(struct rsnd_dai_stream *io,
+				   struct rsnd_mod *mod)
+{
+	struct rsnd_dvc *dvc = rsnd_mod_to_dvc(mod);
+	u32 zcmcr = 0;
+	u32 vrpdr = 0;
+	u32 vrdbr = 0;
+	int i;
+
+	for (i = 0; i < dvc->mute.cfg.size; i++)
+		zcmcr |= (!!dvc->mute.cfg.val[i]) << i;
 
-	/*  Enable Mute */
-	if (mute) {
-		dvucr |= 0x1;
-		rsnd_mod_write(mod, DVC_ZCMCR, mute);
+	if (dvc->ren.val) {
+		vrpdr = rsnd_dvc_get_vrpdr(dvc);
+		vrdbr = rsnd_dvc_get_vrdbr(dvc);
 	}
 
-	rsnd_mod_write(mod, DVC_DVUCR, dvucr);
+	/* Disable DVC Register access */
+	rsnd_mod_write(mod, DVC_DVUER, 0);
+
+	/* Zero Cross Mute Function */
+	rsnd_mod_write(mod, DVC_ZCMCR, zcmcr);
+
+	/* Volume Ramp Function */
+	rsnd_mod_write(mod, DVC_VRPDR, vrpdr);
+	rsnd_mod_write(mod, DVC_VRDBR, vrdbr);
+	/* add DVC_VRWTR here */
+
+	/* Digital Volume Function Parameter */
+	rsnd_dvc_volume_parameter(io, mod);
 
 	/* Enable DVC Register access */
 	rsnd_mod_write(mod, DVC_DVUER, 1);
@@ -164,15 +204,10 @@ static int rsnd_dvc_init(struct rsnd_mod *mod,
 
 	rsnd_dvc_soft_reset(mod);
 
-	rsnd_dvc_initialize_lock(mod);
+	rsnd_dvc_volume_init(io, mod);
 
-	rsnd_mod_write(mod, DVC_ADINR, rsnd_get_adinr_bit(mod, io));
-
-	/* ch0/ch1 Volume */
 	rsnd_dvc_volume_update(io, mod);
 
-	rsnd_dvc_initialize_unlock(mod);
-
 	return 0;
 }
 
-- 
2.6.1
