From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_dai_stream has each mod's
	status insted of rsnd_mod" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:36 +0900
Message-ID: <E1ZqwBY-0004q5-Rq@finisterre>
References: <87oafm3u2s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 839E3265340
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:48:45 +0100 (CET)
In-Reply-To: <87oafm3u2s.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: rsnd_dai_stream has each mod's status insted of rsnd_mod

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

>From eff1d0d499dbe127c2aac2626d0fd7aab806944b Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:41:17 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_dai_stream has each mod's status insted of
 rsnd_mod

Renesas sound needs many devices
(SSI/SSIU/SRC/CTU/MIX/DVC/CMD/AudioDMAC/AudioDMACpp).
SSI/SRC/CTU/MIX/DVC are implemented as module.
SSI parent, SSIU are implemented as part of SSI
CMD is implemented as part of CTU/MIX/DVC
AudioDMAC/AudioDMACpp are implemented as part of SSI/SRC
It is nice sense that these all devices are implemented as mod.

Current rsnd is controling each mod's status on mod. But it was not
good design for SSI, because stream might has SSI-parent.
In such case, it can't play/capture in same time, because SSI-parent
is used as normal SSI in other stream, but it shares same status.
To avoid this issue each mod's status is controlled by rsnd_dai_stream
instead of rsnd_mod.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 12 +++++++-----
 sound/soc/sh/rcar/rsnd.h |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index b6fc0d8..5f20d67 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -300,20 +300,22 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 /*
  *	rsnd_dai functions
  */
-#define rsnd_mod_call(mod, io, func, param...)			\
+#define rsnd_mod_call(idx, io, func, param...)			\
 ({								\
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);		\
+	struct rsnd_mod *mod = (io)->mod[idx];			\
 	struct device *dev = rsnd_priv_to_dev(priv);		\
+	u32 *status = (io)->mod_status + idx;			\
 	u32 mask = 0xF << __rsnd_mod_shift_##func;			\
-	u8 val  = (mod->status >> __rsnd_mod_shift_##func) & 0xF;	\
+	u8 val  = (*status >> __rsnd_mod_shift_##func) & 0xF;		\
 	u8 add  = ((val + __rsnd_mod_add_##func) & 0xF);		\
 	int ret = 0;							\
 	int call = (val == __rsnd_mod_call_##func) && (mod)->ops->func;	\
-	mod->status = (mod->status & ~mask) +				\
+	*status = (*status & ~mask) +					\
 		(add << __rsnd_mod_shift_##func);			\
 	dev_dbg(dev, "%s[%d]\t0x%08x %s\n",				\
 		rsnd_mod_name(mod), rsnd_mod_id(mod),			\
-		mod->status, call ? #func : "");			\
+		*status, call ? #func : "");				\
 	if (call)							\
 		ret = (mod)->ops->func(mod, io, param);			\
 	ret;								\
@@ -327,7 +329,7 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 		mod = (io)->mod[i];				\
 		if (!mod)					\
 			continue;				\
-		ret |= rsnd_mod_call(mod, io, fn, param);	\
+		ret |= rsnd_mod_call(i, io, fn, param);		\
 	}							\
 	ret;							\
 })
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index d6365dc..774cb24 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -259,7 +259,6 @@ struct rsnd_mod {
 	struct rsnd_mod_ops *ops;
 	struct rsnd_priv *priv;
 	struct clk *clk;
-	u32 status;
 };
 /*
  * status
@@ -335,6 +334,7 @@ struct rsnd_dai_stream {
 	struct rsnd_mod *mod[RSND_MOD_MAX];
 	struct rsnd_dai_path_info *info; /* rcar_snd.h */
 	struct rsnd_dai *rdai;
+	u32 mod_status[RSND_MOD_MAX];
 	int byte_pos;
 	int period_pos;
 	int byte_per_period;
-- 
2.6.1
