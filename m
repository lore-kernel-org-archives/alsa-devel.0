From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_mod_make_sure() is not under DEBUG" to the asoc tree
Date: Wed, 19 Apr 2017 17:33:19 +0100
Message-ID: <E1d0sXf-0001QG-5c@debutante>
References: <8760i1kzb8.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <8760i1kzb8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rsnd_mod_make_sure() is not under DEBUG

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

>From 9ca5e57d78446c8bd42adff3dcae693703f91d9c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 19 Apr 2017 00:41:24 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_mod_make_sure() is not under DEBUG

rsnd_mod_make_sure() will be used any situation,
thus, under DEBUG is not realistic.
This patch move it to non DEBUG area

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 2 --
 sound/soc/sh/rcar/rsnd.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f8eb9d3d1949..1744015408c3 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -110,7 +110,6 @@ MODULE_DEVICE_TABLE(of, rsnd_of_match);
 /*
  *	rsnd_mod functions
  */
-#ifdef DEBUG
 void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type)
 {
 	if (mod->type != type) {
@@ -121,7 +120,6 @@ void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type)
 			 rsnd_mod_name(mod), rsnd_mod_id(mod));
 	}
 }
-#endif
 
 char *rsnd_mod_name(struct rsnd_mod *mod)
 {
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 3dc9e06f5943..dbf4163427e8 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -727,8 +727,8 @@ void rsnd_cmd_remove(struct rsnd_priv *priv);
 int rsnd_cmd_attach(struct rsnd_dai_stream *io, int id);
 struct rsnd_mod *rsnd_cmd_mod_get(struct rsnd_priv *priv, int id);
 
-#ifdef DEBUG
 void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type);
+#ifdef DEBUG
 #define rsnd_mod_confirm_ssi(mssi)	rsnd_mod_make_sure(mssi, RSND_MOD_SSI)
 #define rsnd_mod_confirm_src(msrc)	rsnd_mod_make_sure(msrc, RSND_MOD_SRC)
 #define rsnd_mod_confirm_dvc(mdvc)	rsnd_mod_make_sure(mdvc, RSND_MOD_DVC)
-- 
2.11.0
