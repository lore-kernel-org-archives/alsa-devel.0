From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup rsnd_dai_call() behavior
	for unimplemented method" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:57 +0900
Message-ID: <E1ZpOzd-00005v-E8@finisterre>
References: <87wpufsiox.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47E80266B57
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:10:11 +0200 (CEST)
In-Reply-To: <87wpufsiox.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup rsnd_dai_call() behavior for unimplemented method

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

>From 32a96d558d02581c32b09401b8aa5eecb3965d3e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:14:21 +0000
Subject: [PATCH] ASoC: rsnd: fixup rsnd_dai_call() behavior for unimplemented
 method

Current rsnd_dai_call didn't count callback-count if callback
wasn't implemented. Thus, it counts can be unbalance.
ex) .start : implemented
    .stop  : not implemented
This patch solve this issue

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index c0182ac..5c67144 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -300,7 +300,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 /*
  *	rsnd_dai functions
  */
-#define __rsnd_mod_call(mod, io, func, param...)		\
+#define rsnd_mod_call(mod, io, func, param...)			\
 ({								\
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);		\
 	struct device *dev = rsnd_priv_to_dev(priv);		\
@@ -308,7 +308,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	u8 val  = (mod->status >> __rsnd_mod_shift_##func) & 0xF;	\
 	u8 add  = ((val + __rsnd_mod_add_##func) & 0xF);		\
 	int ret = 0;							\
-	int call = (val == __rsnd_mod_call_##func);			\
+	int call = (val == __rsnd_mod_call_##func) && (mod)->ops->func;	\
 	mod->status = (mod->status & ~mask) +				\
 		(add << __rsnd_mod_shift_##func);			\
 	dev_dbg(dev, "%s[%d]\t0x%08x %s\n",				\
@@ -319,11 +319,6 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	ret;								\
 })
 
-#define rsnd_mod_call(mod, io, func, param...)	\
-	(!(mod) ? -ENODEV :			\
-	 !((mod)->ops->func) ? 0 :		\
-	 __rsnd_mod_call(mod, io, func, param))
-
 #define rsnd_dai_call(fn, io, param...)				\
 ({								\
 	struct rsnd_mod *mod;					\
-- 
2.6.1
