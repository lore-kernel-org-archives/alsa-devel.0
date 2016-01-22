From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: don't update status if
	rsnd_mod_call() doesn't match" to the asoc tree
Date: Fri, 22 Jan 2016 18:26:48 +0000
Message-ID: <E1aMgQ4-0004A5-KJ@debutante>
References: <87lh7j4s2e.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A83E526145A
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 19:26:53 +0100 (CET)
In-Reply-To: <87lh7j4s2e.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: don't update status if rsnd_mod_call() doesn't match

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

>From 6c001f3ab4ce20f01a1b3064b2bd1a9352c5d6b1 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Jan 2016 01:56:18 +0000
Subject: [PATCH] ASoC: rsnd: don't update status if rsnd_mod_call() doesn't
 match

If system uses CTU/MUX, and if probe error happened, it will try to
call rsnd_dai_call(remove, ...). Then, MUX/DVC/SSIU/SSI might be called
without calling rsnd_dai_call(probe, ...). Then, each mod status might
be un-matched. It doesn't call un-matched remove function by this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 691e22381280..3eb7e9a7b5dc 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -330,8 +330,11 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	u8 add  = ((val + __rsnd_mod_add_##func) & 0xF);		\
 	int ret = 0;							\
 	int call = (val == __rsnd_mod_call_##func) && (mod)->ops->func;	\
-	*status = (*status & ~mask) +					\
-		(add << __rsnd_mod_shift_##func);			\
+	if (add == 0xF)							\
+		call = 0;						\
+	else								\
+		*status = (*status & ~mask) +				\
+			(add << __rsnd_mod_shift_##func);		\
 	dev_dbg(dev, "%s[%d]\t0x%08x %s\n",				\
 		rsnd_mod_name(mod), rsnd_mod_id(mod),			\
 		*status, call ? #func : "");				\
-- 
2.7.0.rc3
