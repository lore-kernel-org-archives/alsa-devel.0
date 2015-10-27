From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: avoid pointless loop in
	rsnd_mod_interrupt()" to the asoc tree
Date: Tue, 27 Oct 2015 13:48:28 +0900
Message-ID: <E1ZqwBQ-0004p6-Rp@finisterre>
References: <87lhaq3u1s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 758492651FD
 for <alsa-devel@alsa-project.org>; Tue, 27 Oct 2015 05:48:38 +0100 (CET)
In-Reply-To: <87lhaq3u1s.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: rsnd: avoid pointless loop in rsnd_mod_interrupt()

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

>From f1b28110be591426ee9d0f36888fef4e37d707a9 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Oct 2015 08:41:53 +0000
Subject: [PATCH] ASoC: rsnd: avoid pointless loop in rsnd_mod_interrupt()

Current Renesas sound driver doesn't have 1:1 relationship between
stream <-> mod because it is supporting MIX. Because of this reason
rsnd_mod_interrupt() is searching correspond mod by for loop.
But this loop is not needed, because each mod has own type.
This patch avoid pointless loop by using mod->type.

This patch is good for SSI-parent support, because stream might have
2 SSI as SSI-parent/child. SSI interrupt handler will be called twice
if stream has SSI-parent without this patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 5f20d67..8af2d22 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -192,19 +192,16 @@ void rsnd_mod_interrupt(struct rsnd_mod *mod,
 	struct rsnd_priv *priv = rsnd_mod_to_priv(mod);
 	struct rsnd_dai_stream *io;
 	struct rsnd_dai *rdai;
-	int i, j;
-
-	for_each_rsnd_dai(rdai, priv, j) {
+	int i;
 
-		for (i = 0; i < RSND_MOD_MAX; i++) {
-			io = &rdai->playback;
-			if (mod == io->mod[i])
-				callback(mod, io);
+	for_each_rsnd_dai(rdai, priv, i) {
+		io = &rdai->playback;
+		if (mod == io->mod[mod->type])
+			callback(mod, io);
 
-			io = &rdai->capture;
-			if (mod == io->mod[i])
-				callback(mod, io);
-		}
+		io = &rdai->capture;
+		if (mod == io->mod[mod->type])
+			callback(mod, io);
 	}
 }
 
-- 
2.6.1
