From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: fixup each module counter on
	__rsnd_mod_call()" to the asoc tree
Date: Thu, 16 Jul 2015 22:11:37 +0100
Message-ID: <E1ZFqRN-0002oO-MC@finisterre>
References: <871tg9x5k2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2148626686F
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 23:11:43 +0200 (CEST)
In-Reply-To: <871tg9x5k2.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: fixup each module counter on __rsnd_mod_call()

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

>From a48e3f9747fd62b385221a892cd4726b82dacd11 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 15 Jul 2015 07:10:04 +0000
Subject: [PATCH] ASoC: rsnd: fixup each module counter on __rsnd_mod_call()

'5451ea443b ("ASoC: rsnd: count each mod (SSI/SRC/DVC)")' counts each
module's callback status, but counts 1st callback only.
This patch fixup it. Otherwise, multi-called function will be trouble

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index f1e5920..d44bfb7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -242,9 +242,9 @@ u32 rsnd_get_adinr(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	if (val == __rsnd_mod_call_##func) {				\
 		called = 1;						\
 		ret = (mod)->ops->func(mod, io, param);			\
-		mod->status = (mod->status & ~mask) +			\
-			(add << __rsnd_mod_shift_##func);		\
 	}								\
+	mod->status = (mod->status & ~mask) +				\
+		(add << __rsnd_mod_shift_##func);			\
 	dev_dbg(dev, "%s[%d] 0x%08x %s\n",				\
 		rsnd_mod_name(mod), rsnd_mod_id(mod), mod->status,	\
 		called ? #func : "");					\
-- 
2.1.4
