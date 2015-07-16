From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: tidyup ADINR function name" to
	the asoc tree
Date: Thu, 16 Jul 2015 22:29:59 +0100
Message-ID: <E1ZFqj9-0004jj-0r@finisterre>
References: <87k2u1vqsx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C08412666DE
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:30:04 +0200 (CEST)
In-Reply-To: <87k2u1vqsx.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: tidyup ADINR function name

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

>From 3023b384d0c9da49028131b91fe64b24b5b84e6d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:14:05 +0000
Subject: [PATCH] ASoC: rsnd: tidyup ADINR function name

Renesas sound IP (= SSIU/SRC/CTU/MIX/DVC) have ADINR
(= Audio Information Register), but some of them (= SSIU/SRC/DVC)
are for audio data bits, some of them (= CTU/MIX) are for audio data
channels.
Current rsnd driver is supporting SSIU/SRC/DVC, and these ADINR were
for bits. This patch rename rsnd_get_adinr() to rsnd_get_adinr_bit(),
and we will have rsnd_get_adinr_chan() for CTU/MIX.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 sound/soc/sh/rcar/dvc.c  | 2 +-
 sound/soc/sh/rcar/rsnd.h | 2 +-
 sound/soc/sh/rcar/src.c  | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index cb82067..0ca6d02 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -203,9 +203,9 @@ int rsnd_io_is_working(struct rsnd_dai_stream *io)
 }
 
 /*
- *	settting function
+ *	ADINR function
  */
-u32 rsnd_get_adinr(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
+u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index 343d446..d06e4ee 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -161,7 +161,7 @@ static int rsnd_dvc_init(struct rsnd_mod *mod,
 
 	rsnd_path_parse(priv, io);
 
-	rsnd_mod_write(mod, DVC_ADINR, rsnd_get_adinr(mod, io));
+	rsnd_mod_write(mod, DVC_ADINR, rsnd_get_adinr_bit(mod, io));
 
 	/* ch0/ch1 Volume */
 	rsnd_dvc_volume_update(io, mod);
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 6a87757..224a4a9 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -169,7 +169,7 @@ void rsnd_force_write(struct rsnd_priv *priv, struct rsnd_mod *mod,
 		enum rsnd_reg reg, u32 data);
 void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod, enum rsnd_reg reg,
 		    u32 mask, u32 data);
-u32 rsnd_get_adinr(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
+u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io);
 void rsnd_path_parse(struct rsnd_priv *priv,
 		     struct rsnd_dai_stream *io);
 
diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index b3d965e..c45da61 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -189,7 +189,7 @@ int rsnd_src_ssiu_start(struct rsnd_mod *ssi_mod,
 		u32 mask = ~0;
 
 		rsnd_mod_write(ssi_mod, SSI_BUSIF_ADINR,
-			       rsnd_get_adinr(ssi_mod, io));
+			       rsnd_get_adinr_bit(ssi_mod, io));
 		rsnd_mod_write(ssi_mod, SSI_BUSIF_MODE,  1);
 		rsnd_mod_write(ssi_mod, SSI_CTRL, 0x1);
 
@@ -309,7 +309,7 @@ static int rsnd_src_set_convert_rate(struct rsnd_mod *mod,
 		fsrate = 0x0400000 / convert_rate * runtime->rate;
 
 	/* Set channel number and output bit length */
-	rsnd_mod_write(mod, SRC_ADINR, rsnd_get_adinr(mod, io));
+	rsnd_mod_write(mod, SRC_ADINR, rsnd_get_adinr_bit(mod, io));
 
 	/* Enable the initial value of IFS */
 	if (fsrate) {
-- 
2.1.4
