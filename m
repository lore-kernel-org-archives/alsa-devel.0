From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: rsnd_get_dalign() needs to care
	SSIU, not SSI" to the asoc tree
Date: Mon, 05 Dec 2016 12:09:33 +0000
Message-ID: <E1cDs5N-0003nS-Lj@finisterre>
References: <87vav3uk3q.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B1CE266C72
 for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2016 13:09:41 +0100 (CET)
In-Reply-To: <87vav3uk3q.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: rsnd_get_dalign() needs to care SSIU, not SSI

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

>From 3ce2959d162a8f2d69a83582df619a20ff3f6645 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 2 Dec 2016 02:44:23 +0000
Subject: [PATCH] ASoC: rsnd: rsnd_get_dalign() needs to care SSIU, not SSI

SSIU was controlled by SSI before, but
commit c7f69ab53("ASoC: rsnd: use mod base common method on SSIU")
separated it into ssiu.c

But, it didn't care about rsnd_get_dalign() for judging SSI_BUSIF_DALIGN
register value which changes the stream data order.
This function will be called from cmd/src/ssiu now, but current code
still cares ssi, not ssiu.
This patch fix it up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 6 +++---
 sound/soc/sh/rcar/rsnd.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 912dc62ff9c7..825635aaf30e 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -306,7 +306,7 @@ u32 rsnd_get_adinr_bit(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
  */
 u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 {
-	struct rsnd_mod *ssi = rsnd_io_to_mod_ssi(io);
+	struct rsnd_mod *ssiu = rsnd_io_to_mod_ssiu(io);
 	struct rsnd_mod *target;
 	struct snd_pcm_runtime *runtime = rsnd_io_to_runtime(io);
 	u32 val = 0x76543210;
@@ -315,11 +315,11 @@ u32 rsnd_get_dalign(struct rsnd_mod *mod, struct rsnd_dai_stream *io)
 	if (rsnd_io_is_play(io)) {
 		struct rsnd_mod *src = rsnd_io_to_mod_src(io);
 
-		target = src ? src : ssi;
+		target = src ? src : ssiu;
 	} else {
 		struct rsnd_mod *cmd = rsnd_io_to_mod_cmd(io);
 
-		target = cmd ? cmd : ssi;
+		target = cmd ? cmd : ssiu;
 	}
 
 	mask <<= runtime->channels * 4;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index d9e550211c09..71158c8bc254 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -428,6 +428,7 @@ struct rsnd_dai_stream {
 };
 #define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
 #define rsnd_io_to_mod_ssi(io)	rsnd_io_to_mod((io), RSND_MOD_SSI)
+#define rsnd_io_to_mod_ssiu(io)	rsnd_io_to_mod((io), RSND_MOD_SSIU)
 #define rsnd_io_to_mod_ssip(io)	rsnd_io_to_mod((io), RSND_MOD_SSIP)
 #define rsnd_io_to_mod_src(io)	rsnd_io_to_mod((io), RSND_MOD_SRC)
 #define rsnd_io_to_mod_ctu(io)	rsnd_io_to_mod((io), RSND_MOD_CTU)
-- 
2.10.2
