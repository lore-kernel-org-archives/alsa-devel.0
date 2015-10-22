From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup rsnd_mod_call() behavior
	for debug" to the asoc tree
Date: Fri, 23 Oct 2015 08:09:59 +0900
Message-ID: <E1ZpOzf-00006Y-PV@finisterre>
References: <87y4evsipe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC04266B66
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:10:17 +0200 (CEST)
In-Reply-To: <87y4evsipe.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup rsnd_mod_call() behavior for debug

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

>From 1355720a3b3eba5604431d89d5cf69ce4ad51311 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Oct 2015 03:14:02 +0000
Subject: [PATCH] ASoC: rsnd: fixup rsnd_mod_call() behavior for debug

Indicating each module method as debug message before executing is
readable/understandable.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6ef9a88..c0182ac 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -308,16 +308,14 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	u8 val  = (mod->status >> __rsnd_mod_shift_##func) & 0xF;	\
 	u8 add  = ((val + __rsnd_mod_add_##func) & 0xF);		\
 	int ret = 0;							\
-	int called = 0;							\
-	if (val == __rsnd_mod_call_##func) {				\
-		called = 1;						\
-		ret = (mod)->ops->func(mod, io, param);			\
-	}								\
+	int call = (val == __rsnd_mod_call_##func);			\
 	mod->status = (mod->status & ~mask) +				\
 		(add << __rsnd_mod_shift_##func);			\
-	dev_dbg(dev, "%s[%d] 0x%08x %s\n",				\
-		rsnd_mod_name(mod), rsnd_mod_id(mod), mod->status,	\
-		called ? #func : "");					\
+	dev_dbg(dev, "%s[%d]\t0x%08x %s\n",				\
+		rsnd_mod_name(mod), rsnd_mod_id(mod),			\
+		mod->status, call ? #func : "");			\
+	if (call)							\
+		ret = (mod)->ops->func(mod, io, param);			\
 	ret;								\
 })
 
-- 
2.6.1
