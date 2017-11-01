From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: remove NULL check from
	rsnd_mod_name()/rsnd_mod_id()" to the asoc tree
Date: Wed, 01 Nov 2017 10:06:59 +0000
Message-ID: <E1e9pvH-0004Dt-Tc@debutante>
References: <87zi86xyp9.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 48785266AE1
 for <alsa-devel@alsa-project.org>; Wed,  1 Nov 2017 11:07:05 +0100 (CET)
In-Reply-To: <87zi86xyp9.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: remove NULL check from rsnd_mod_name()/rsnd_mod_id()

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

>From 9b6ea25066b05c4b8bc4ea69037741bd67649cd1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 1 Nov 2017 07:17:34 +0000
Subject: [PATCH] ASoC: rsnd: remove NULL check from
 rsnd_mod_name()/rsnd_mod_id()

Current rsnd driver has rsnd_mod_id() which returns mod ID,
and it returns -1 if mod was NULL.
In the same time, this driver has rsnd_mod_name() which returns mod
name, and it returns "unknown" if mod or mod->ops was NULL.

Basically these "mod" never be NULL, but the reason why rsnd driver
has such behavior is that DMA path finder is assuming memory as
"mod == NULL".
Thus, current DMA path debug code prints like below.
Here "unknown[-1]" means it was memory.

	...
	rcar_sound ec500000.sound:   unknown[-1] from
	rcar_sound ec500000.sound:   src[0] to
	rcar_sound ec500000.sound:   ctu[2]
	rcar_sound ec500000.sound:   mix[0]
	rcar_sound ec500000.sound:   dvc[0]
	rcar_sound ec500000.sound:   ssi[0]
	rcar_sound ec500000.sound: audmac[0] unknown[-1] -> src[0]
	...

1st issue is that it is confusable for user.
2nd issue is rsnd driver has something like below code.

	mask |= 1 << rsnd_mod_id(mod);

Because of this kind of code, some statically code checker will
reports "Shifting by a negative value is undefined behaviour".

But this "mod" never be NULL, thus negative shift never happen.
To avoid these issues, this patch adds new dummy "mem" to
indicate memory, and use it to indicate debug information,
and, remove unneeded "NULL mod" behavior from rsnd_mod_id() and
rsnd_mod_name().

The debug information will be like below by this patch
	...
	rcar_sound ec500000.sound:   mem[0] from
	rcar_sound ec500000.sound:   src[0] to
	rcar_sound ec500000.sound:   ctu[2]
	rcar_sound ec500000.sound:   mix[0]
	rcar_sound ec500000.sound:   dvc[0]
	rcar_sound ec500000.sound:   ssi[0]
	rcar_sound ec500000.sound: audmac[0] mem[0] -> src[0]
	...

Reported-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c |  8 --------
 sound/soc/sh/rcar/dma.c  | 24 ++++++++++++++++++------
 sound/soc/sh/rcar/rsnd.h |  6 +++---
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b36832ef7342..c70eb2097816 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -121,14 +121,6 @@ void rsnd_mod_make_sure(struct rsnd_mod *mod, enum rsnd_mod_type type)
 	}
 }
 
-char *rsnd_mod_name(struct rsnd_mod *mod)
-{
-	if (!mod || !mod->ops)
-		return "unknown";
-
-	return mod->ops->name;
-}
-
 struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
 				  struct rsnd_mod *mod)
 {
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 17220c946ff0..5bc9ec16813c 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -60,6 +60,14 @@ struct rsnd_dma_ctrl {
 #define rsnd_dma_to_dmaen(dma)	(&(dma)->dma.en)
 #define rsnd_dma_to_dmapp(dma)	(&(dma)->dma.pp)
 
+/* for DEBUG */
+static struct rsnd_mod_ops mem_ops = {
+	.name = "mem",
+};
+
+static struct rsnd_mod mem = {
+};
+
 /*
  *		Audio DMAC
  */
@@ -747,9 +755,10 @@ static void rsnd_dma_of_path(struct rsnd_mod *this,
 		rsnd_mod_name(this), rsnd_mod_id(this));
 	for (i = 0; i <= idx; i++) {
 		dev_dbg(dev, "  %s[%d]%s\n",
-		       rsnd_mod_name(mod[i]), rsnd_mod_id(mod[i]),
-		       (mod[i] == *mod_from) ? " from" :
-		       (mod[i] == *mod_to)   ? " to" : "");
+			rsnd_mod_name(mod[i] ? mod[i] : &mem),
+			rsnd_mod_id  (mod[i] ? mod[i] : &mem),
+			(mod[i] == *mod_from) ? " from" :
+			(mod[i] == *mod_to)   ? " to" : "");
 	}
 }
 
@@ -814,8 +823,10 @@ static int rsnd_dma_alloc(struct rsnd_dai_stream *io, struct rsnd_mod *mod,
 
 	dev_dbg(dev, "%s[%d] %s[%d] -> %s[%d]\n",
 		rsnd_mod_name(*dma_mod), rsnd_mod_id(*dma_mod),
-		rsnd_mod_name(mod_from), rsnd_mod_id(mod_from),
-		rsnd_mod_name(mod_to),   rsnd_mod_id(mod_to));
+		rsnd_mod_name(mod_from ? mod_from : &mem),
+		rsnd_mod_id  (mod_from ? mod_from : &mem),
+		rsnd_mod_name(mod_to   ? mod_to   : &mem),
+		rsnd_mod_id  (mod_to   ? mod_to   : &mem));
 
 	ret = attach(io, dma, mod_from, mod_to);
 	if (ret < 0)
@@ -872,5 +883,6 @@ int rsnd_dma_probe(struct rsnd_priv *priv)
 
 	priv->dma = dmac;
 
-	return 0;
+	/* dummy mem mod for debug */
+	return rsnd_mod_init(NULL, &mem, &mem_ops, NULL, NULL, 0, 0);
 }
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index 2a224fa639cb..57cd2bc773c2 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -355,8 +355,9 @@ struct rsnd_mod {
 #define __rsnd_mod_call_nolock_start	0
 #define __rsnd_mod_call_nolock_stop	1
 
-#define rsnd_mod_to_priv(mod) ((mod)->priv)
-#define rsnd_mod_id(mod) ((mod) ? (mod)->id : -1)
+#define rsnd_mod_to_priv(mod)	((mod)->priv)
+#define rsnd_mod_name(mod)	((mod)->ops->name)
+#define rsnd_mod_id(mod)	((mod)->id)
 #define rsnd_mod_power_on(mod)	clk_enable((mod)->clk)
 #define rsnd_mod_power_off(mod)	clk_disable((mod)->clk)
 #define rsnd_mod_get(ip)	(&(ip)->mod)
@@ -371,7 +372,6 @@ int rsnd_mod_init(struct rsnd_priv *priv,
 		  enum rsnd_mod_type type,
 		  int id);
 void rsnd_mod_quit(struct rsnd_mod *mod);
-char *rsnd_mod_name(struct rsnd_mod *mod);
 struct dma_chan *rsnd_mod_dma_req(struct rsnd_dai_stream *io,
 				  struct rsnd_mod *mod);
 void rsnd_mod_interrupt(struct rsnd_mod *mod,
-- 
2.15.0.rc2
