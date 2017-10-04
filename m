From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: makes volume ramp rate list generic" to the asoc tree
Date: Wed, 04 Oct 2017 12:28:09 +0100
Message-ID: <E1dzhqT-0004Hm-6G@debutante>
References: <877ewigrcv.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <877ewigrcv.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: makes volume ramp rate list generic

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

>From f3c26ac61c09862f0037fe484a98da0364f02ec3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 1 Oct 2017 23:49:03 +0000
Subject: [PATCH] ASoC: rsnd: makes volume ramp rate list generic

DVC is supporting Volume Ramp Rate, and MIX has Volume Ramp
but not yet supported. To support MIX Volume Ramp, we want to
share Rate List since DVC/MIX are using almost same list.
This patch move DVC specific Volume Ramp Rate List to core.c.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 27 +++++++++++++++++++++++++++
 sound/soc/sh/rcar/dvc.c  | 33 ++++-----------------------------
 sound/soc/sh/rcar/rsnd.h |  7 +++++--
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 107133297e8d..2d94b3d4519c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1242,6 +1242,33 @@ struct rsnd_kctrl_cfg *rsnd_kctrl_init_s(struct rsnd_kctrl_cfg_s *cfg)
 	return &cfg->cfg;
 }
 
+const char * const volume_ramp_rate[] = {
+	"128 dB/1 step",	 /* 00000 */
+	"64 dB/1 step",		 /* 00001 */
+	"32 dB/1 step",		 /* 00010 */
+	"16 dB/1 step",		 /* 00011 */
+	"8 dB/1 step",		 /* 00100 */
+	"4 dB/1 step",		 /* 00101 */
+	"2 dB/1 step",		 /* 00110 */
+	"1 dB/1 step",		 /* 00111 */
+	"0.5 dB/1 step",	 /* 01000 */
+	"0.25 dB/1 step",	 /* 01001 */
+	"0.125 dB/1 step",	 /* 01010 */
+	"0.125 dB/2 steps",	 /* 01011 */
+	"0.125 dB/4 steps",	 /* 01100 */
+	"0.125 dB/8 steps",	 /* 01101 */
+	"0.125 dB/16 steps",	 /* 01110 */
+	"0.125 dB/32 steps",	 /* 01111 */
+	"0.125 dB/64 steps",	 /* 10000 */
+	"0.125 dB/128 steps",	 /* 10001 */
+	"0.125 dB/256 steps",	 /* 10010 */
+	"0.125 dB/512 steps",	 /* 10011 */
+	"0.125 dB/1024 steps",	 /* 10100 */
+	"0.125 dB/2048 steps",	 /* 10101 */
+	"0.125 dB/4096 steps",	 /* 10110 */
+	"0.125 dB/8192 steps",	 /* 10111 = VOLUME_RAMP_MAX_DVC */
+};
+
 int rsnd_kctrl_new(struct rsnd_mod *mod,
 		   struct rsnd_dai_stream *io,
 		   struct snd_soc_pcm_runtime *rtd,
diff --git a/sound/soc/sh/rcar/dvc.c b/sound/soc/sh/rcar/dvc.c
index bb22850e8fe6..4ef318ac73d5 100644
--- a/sound/soc/sh/rcar/dvc.c
+++ b/sound/soc/sh/rcar/dvc.c
@@ -61,33 +61,6 @@ struct rsnd_dvc {
 	     ((pos) = (struct rsnd_dvc *)(priv)->dvc + i);	\
 	     i++)
 
-static const char * const dvc_ramp_rate[] = {
-	"128 dB/1 step",	 /* 00000 */
-	"64 dB/1 step",		 /* 00001 */
-	"32 dB/1 step",		 /* 00010 */
-	"16 dB/1 step",		 /* 00011 */
-	"8 dB/1 step",		 /* 00100 */
-	"4 dB/1 step",		 /* 00101 */
-	"2 dB/1 step",		 /* 00110 */
-	"1 dB/1 step",		 /* 00111 */
-	"0.5 dB/1 step",	 /* 01000 */
-	"0.25 dB/1 step",	 /* 01001 */
-	"0.125 dB/1 step",	 /* 01010 */
-	"0.125 dB/2 steps",	 /* 01011 */
-	"0.125 dB/4 steps",	 /* 01100 */
-	"0.125 dB/8 steps",	 /* 01101 */
-	"0.125 dB/16 steps",	 /* 01110 */
-	"0.125 dB/32 steps",	 /* 01111 */
-	"0.125 dB/64 steps",	 /* 10000 */
-	"0.125 dB/128 steps",	 /* 10001 */
-	"0.125 dB/256 steps",	 /* 10010 */
-	"0.125 dB/512 steps",	 /* 10011 */
-	"0.125 dB/1024 steps",	 /* 10100 */
-	"0.125 dB/2048 steps",	 /* 10101 */
-	"0.125 dB/4096 steps",	 /* 10110 */
-	"0.125 dB/8192 steps",	 /* 10111 */
-};
-
 static void rsnd_dvc_activation(struct rsnd_mod *mod)
 {
 	rsnd_mod_write(mod, DVC_SWRSR, 0);
@@ -298,7 +271,8 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->rup,
-			dvc_ramp_rate);
+			volume_ramp_rate,
+			VOLUME_RAMP_MAX_DVC);
 	if (ret < 0)
 		return ret;
 
@@ -308,7 +282,8 @@ static int rsnd_dvc_pcm_new(struct rsnd_mod *mod,
 			rsnd_kctrl_accept_anytime,
 			rsnd_dvc_volume_update,
 			&dvc->rdown,
-			dvc_ramp_rate);
+			volume_ramp_rate,
+			VOLUME_RAMP_MAX_DVC);
 
 	if (ret < 0)
 		return ret;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index beffbec42404..9d66a15000fa 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -656,9 +656,12 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 	rsnd_kctrl_new(mod, io, rtd, name, accept, update, rsnd_kctrl_init_s(cfg), \
 		       NULL, 1, max)
 
-#define rsnd_kctrl_new_e(mod, io, rtd, name, accept, update, cfg, texts)	\
+#define rsnd_kctrl_new_e(mod, io, rtd, name, accept, update, cfg, texts, size) \
 	rsnd_kctrl_new(mod, io, rtd, name, accept, update, rsnd_kctrl_init_s(cfg), \
-		       texts, 1, ARRAY_SIZE(texts))
+		       texts, 1, size)
+
+extern const char * const volume_ramp_rate[];
+#define VOLUME_RAMP_MAX_DVC	(0x17 + 1)
 
 /*
  *	R-Car SSI
-- 
2.14.1
